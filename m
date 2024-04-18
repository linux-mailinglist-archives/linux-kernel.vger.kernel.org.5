Return-Path: <linux-kernel+bounces-149699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA6F8A94BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DA31C20B67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2ED7D3F7;
	Thu, 18 Apr 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="L+hc+BeC"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC6757F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428171; cv=none; b=hJpScNxcK42FYnxRX3YYErsVuRT7/I5QUjOYrQlQYcsUeVSAvRTmRJcBdTmWyojELdSoyo92SjhGYfPa2kS/QoZv2xLjvNtKO+QbHDvGfZ5BNeApTfpnay3y0yRcG8NUsCXkE+snLQqJWOapQois5V7G4hoBXVXLjDwqKrIiEs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428171; c=relaxed/simple;
	bh=SZ0vM4DnANcrfPPIc2NZiWYQJhhmf6OoJtwIR4g7SQA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Co9T3JQvn4ZDJBZHEkSDNuNkZvDIJTnG+CYSzgDB3omCOaRU3BDiEANkcjTQpHHA0XbuccRj3clHXTWA2dHdbP5T1iDwHGzNzOmzvJj2XMx6YfoX8zMpu/NQEwYmmQUZgsg+1eQIqUD8YMAhg9AjC/Ee+uC4xj1bVVpfNfCk5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=L+hc+BeC; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ebb815f688so403092a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1713428169; x=1714032969; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jJd4b5GIeq3KKj5gKwLyS3L0URtHswHqGyOVSmgZgE=;
        b=L+hc+BeCeUShj1IpgsP7A+wrVO6lzJl/8582l5SqBPzFRwGSw3SGBn3jCP+3w3ItmV
         8rSzk53O2ncR4o6ShroW9TwudxOkQ8k6Z0yT2VnGroAJLxuLzwBTAvv3bJOeGLFd+Egz
         gkjWdN7g0ZAA+9jNgn5jZh4ILM0R/kbn7vpQUg36Z01sKV58zoJb0fxgV9aZ4HnTStth
         ohpfOSKo6Opc3QRt5pqMy9u56NCHP8YrH4g8YEASNmb6pDaBSLPV7jbZvQbCtWkWjZ4Q
         gvFAU+pCxjbuyUuuM73J+vpak3fQpWIvwyjaYxoZq90/T5C6fPFow60rURTXYfPtO2og
         g4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713428169; x=1714032969;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jJd4b5GIeq3KKj5gKwLyS3L0URtHswHqGyOVSmgZgE=;
        b=G76XbKWnGt4IjHzWb07yQFeDGFO2q1oO83yTJ/A3FlhUDS9mCTi17Bq6GVjjHqZbrS
         7LJNxCun8LDyh6gN9SDNbdAmhYtW8B/SE5lrNGh7he7dVgo+gHWBBjnEwdVbuC8ucSL4
         8czr2dgNJagKW2yZ7HSiiPe2unoe6yhTj83Hc7PWj7V1tvPa+4Vs6LhEPfFR7bNZ06kG
         JeMX2lPx7vUOpOUl4zr7fZWWczgP1wpKhbzc0vZkyJqaxu62eLvhaetGM2V5Kshi5voi
         fOgm1ToOxZe6WYxAMdfllQB4N8R0tafehxS9aheBvPl+qHnDCbMvrYJ1i4CaggHAaNFk
         cEXw==
X-Forwarded-Encrypted: i=1; AJvYcCWdkeKQHoPINIoD6bqdjtTFRSS5DiBdhhOsi24qxeP4TD8bSUgrQthLTyc1OI1JbEEBssa68sWNKXlQ9eeUq2gTFFQxD+3LcN4xOqE/
X-Gm-Message-State: AOJu0YwFXXQCBq92OkWiDpMau/s3Rve3u/CqEOC8rPFxPcpWXcfvmKrG
	+4f8JEo64VWgqpDBqkmEpMJqGwXIENFN2qTS6nri8cfuvFmnzH6t2JYlHaAvyEQ=
X-Google-Smtp-Source: AGHT+IFjDUrGwm9kDxD+zeSPOCUBeTz3i7kYis3qMb3lTFVeiheqy30dloEzF9ToaqSHJSuHws4RCw==
X-Received: by 2002:a05:6808:60a:b0:3c6:e0a:f3c8 with SMTP id y10-20020a056808060a00b003c60e0af3c8mr2096740oih.35.1713428168829;
        Thu, 18 Apr 2024 01:16:08 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id o18-20020a634e52000000b005f3d54c0a57sm881394pgl.49.2024.04.18.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:16:07 -0700 (PDT)
From: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
To: mripard@kernel.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] Add kd101ne3 bindings and driver.
Date: Thu, 18 Apr 2024 16:15:46 +0800
Message-Id: <20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add bindings and driver for kd101ne3.

lvzhaoxiong (2):
  dt-bindings: display: panel: Add KD101NE3-40TI support
  drm/panel: kd101ne3: add new panel driver

 .../panel/kingdisplay,kd101ne3-40ti.yaml      |  63 ++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-kingdisplay-kd101ne3.c    | 607 ++++++++++++++++++
 4 files changed, 680 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd101ne3-40ti.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c

-- 
2.17.1


