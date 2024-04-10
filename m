Return-Path: <linux-kernel+bounces-138054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60789EB99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBE028564D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4513C91C;
	Wed, 10 Apr 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="qC9XblTZ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A0F13C905
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733297; cv=none; b=IR3O4any/25+svUu2VxU6gdUIyikaQvOfPNHERmHVEZZk9UC4DR3OZVHf95nCLkKY/Ie+EBlqbZdyWiJCpiyfLIZy6y++xqKHWo0qotltSi/SG3wocVb21hC3S88s/An2UN8Umb906ZFQn7FFLOprIiJV5c/xPivE1Xh/RbHxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733297; c=relaxed/simple;
	bh=6g9/jsociBqmZYAv6y4f1ADBORU8rHPX+WE2IfbFsv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dGXw+6AqnZuj82b0BwHip/CBTNogf/BQsJgaZKCX7iS2Fmd0B/NZb8CqR7Oa0hCsGDTC9FEw7LHF1UDQl45RkUxtYAqcb2ybuLiEThKUaX8p5tAvhaK+WH/1luCb7lsxKHs+xM1hnE0UH1FJDm/2bZzaJXH9Q9YOZ5RT88x7enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=qC9XblTZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so1472686a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1712733296; x=1713338096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIMOd1zj3gkMdcIscBRTSVUzcEAoxAPXNWZxjmNC33Y=;
        b=qC9XblTZeENri3UNK8MqeSnuf2/Q8et/KEGlZhRHUpfLSj5eElk7FTliNOc7DFZNDc
         pIiiyF7ebLoNkMZ8dNEHDQ0pcnogvSjgpMd0JevXuzhv43NflvFw4o+5rAxH1lCv9/RH
         vuLZnOKMk+ut4AmG8880n8ksGkOGjylJH6Oiy+mDft9+prY6IcIVp6fG39LMOJo2HMsl
         FgBkroDJ5FTLe2wTirUAIUUfkTdqt4nDKBPzKKPRvak2TRoC+sUlOVfNCMoQfiwD2wlC
         5y/PCnPv+0rnH3L4iBYDqf7VLL3pPLVA67yuUJ4ZxFs58c/cuGRzOxpxdE5as630pATi
         pDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712733296; x=1713338096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIMOd1zj3gkMdcIscBRTSVUzcEAoxAPXNWZxjmNC33Y=;
        b=vq6b7n69qZEYfcRcuDyZpgXiJPhDa6aj/qCuZjfFWhkdtHaBsbztMEOxUpRyjkVEGG
         n911J8pnSdzKq10XD0b1HpEjnrRSl2xQp3KVMX+2iyPxYV/RuZziGnuJ9RH5raqJvIk2
         dNKw5aiAmP7uw0oxLqng+thJ/4xa9IIje0j8PpOdrDd81mUsggHdkIAeyKGfviqoGxwT
         H6cj+JDkt8Kgwi82PNjDcjSG5C52MghwfnqCpQ8BdCfpod+budqFO+0UsPG25gx2Xx/S
         aBDjSj4d9InuFb8Rw/y8lqSbEzKiGJFCMcgQmmRV0aaiJy0Ub5NWMwDztk/VTAmGLTKF
         DxDg==
X-Forwarded-Encrypted: i=1; AJvYcCWoCDiVIBSAzvzLyWiEkno7CzWUQHrsuPOTYe5Xn6vwoHbcvnnEE2HEKvy9z/gFRO2UovXri7eb2mZ0OD+vCKVWMOpXrXv+9i/mpc30
X-Gm-Message-State: AOJu0Yz2jSN9yHrbRo7uEKDhRYzme5uc3uTZCVa4sKgkGDfvVoCbqydf
	SR/Lhu1ILkLa+bpgxxcyChD6wqwCm17ixq9NdYPC/BlPp8Ucr93VEZYwDnbCzi8=
X-Google-Smtp-Source: AGHT+IEVm6HJ8DLUI4GT5B2aoRikQtW20BaDdKOMt4/+udHIsI3m/VTV3o3lGXByhjg8ncO4JyMRtA==
X-Received: by 2002:a05:6a20:9698:b0:1a8:4254:5cdf with SMTP id hp24-20020a056a20969800b001a842545cdfmr1796798pzc.22.1712733295666;
        Wed, 10 Apr 2024 00:14:55 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903409100b001e264b50964sm10107975plc.205.2024.04.10.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:14:55 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	airlied@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 0/2] Support BOE nv110wum-l60 and IVO t109nw41 MIPI-DSI panel
Date: Wed, 10 Apr 2024 15:14:35 +0800
Message-Id: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BOE nv110wum-l60 and IVO t109nw41 both 11.0" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6 driver.
Add compatible for BOE nv110wum-l60 and IVO t109nw41
in dt-bindings.

Cong Yang (4):
  dt-bindings: display: panel: Add compatible for BOE nv110wum-l60
  drm/panel: boe-tv101wum-nl6: Support for BOE nv110wum-l60 MIPI-DSI
    panel
  dt-bindings: display: panel: Add compatible for IVO t109nw41
  drm/panel: boe-tv101wum-nl6: Support for IVO t109nw41 MIPI-DSI panel

 .../display/panel/boe,tv101wum-nl6.yaml       |   4 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 213 ++++++++++++++++++
 2 files changed, 217 insertions(+)

-- 
2.25.1


