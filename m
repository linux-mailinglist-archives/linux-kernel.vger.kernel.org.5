Return-Path: <linux-kernel+bounces-47766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D936A845289
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CDB1C233EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A715956D;
	Thu,  1 Feb 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfcFRjaY"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A95158D81
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775525; cv=none; b=E2JMqYxA1ZPkRDJkFtJeVAbQLcHthn3jYAMYM/O720uHw4Zq/AHh5Wf9YRRHvjb0LSHqwekEZM3QlVGBG94Gf02Z5fdhw9sBH3rFWZPdFw7hycv+WpTYqN7beqoLTRZBUe2tcNzHQY0+myIl4BP/W4sfu8brSCbr+d22bHRMVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775525; c=relaxed/simple;
	bh=DIaKZBB4u7WsGLM+tjdwDqov0MpFb1q5HjpRcygEqeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVVPmoBp8bpqnKzyjz/tcyksZCkqW21OsfJISWeUM/fTRzMs9JNvKaMdu2pEKzh4laHf+735y5N888VejDI3w5ImpboVNgppzA8AbCjSTiyhx8LzXZK5ry2q/cRz/M41TxEADQEa/7HLUdUFUtPsPi7ukPUZveGJaIyFIvUPg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfcFRjaY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so840017a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775521; x=1707380321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ifEstaCFW5dRBoYTuvt1sun4+9dM+F8qEM4C8Rq1z4=;
        b=KfcFRjaYdID3vL9G0/PT1ndAPhEMbh9cBgjT8v6yYffsteP8VXNP99VOy+zAkxtyfM
         TYVEQegZfPgl2YM+MFx1RsTjV/FNS2GNMhmmxWup+gaTFEPcy8H/3fPRUJeZHTpQ98xL
         VDIeRm6GJ9gvI1be1W6oKimRf5qJcjPgxO72UhLTVp3ASPHSbFE8ZsaMy0430iNyRpxU
         D3zdmyFHOQqomi+XETbvS0TFRndv582ZGg2rAe23FLZxBzK9M+NpvEdMN3LiBqtTZCSk
         hW7sGxo7NmZRY25MuhZg3GvEzWIZNvWa7geOctAw3Dw00roHy5XvkPrm7Y9cfHBL0SMy
         TdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775521; x=1707380321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ifEstaCFW5dRBoYTuvt1sun4+9dM+F8qEM4C8Rq1z4=;
        b=a2McPmiV8LnmR/s1INFaui/DsBB09RYkm0fgYyK4WwWZ/C7wj4tWK07Gonvv6XEeTA
         z72cbF9bnjyzVZIJl2lWk8mA0SnwsAxbr/2SL9v5AbNN2yv7TORgSUr7QCLtl96Lg7A/
         7K/nqRi3Bt1BoHpY/fjVgBm6lv0q0Fq7bgkhSAKtC74GZulajBeXHrjH+SxPhnNw3u49
         29MN+DWwWikhzoZWqZXVHDQ7oW8YRH68xMnRI6fjvdq3ofi6fFkFRxi32DPih+9tOG/C
         kQjXk5g7WAqZuB+L6VPPZIVag+DKTlAzmprzZnHekPTMKMK0JceWre/AH4c/rFerUUJx
         uU+g==
X-Gm-Message-State: AOJu0Yyhox4RpevB7eFg153sfFKhOGU6AWhGO0fbTbHASR9k7cd/KNpM
	MmV5p54WoQC3vceX9+XwXxc5xJEKDspOSjTUE0x3SlwnqkbPMfFM
X-Google-Smtp-Source: AGHT+IHMZ0jzWGFDtRQQgsn44+OiI+Av+ADi9gmhMPUppeualZSHIB60NRp8bcasFd+Qgk9dcPdbTg==
X-Received: by 2002:a17:906:3b0d:b0:a36:9f72:2460 with SMTP id g13-20020a1709063b0d00b00a369f722460mr1746911ejf.0.1706775521201;
        Thu, 01 Feb 2024 00:18:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVx0Nbo+uM+MZOJnTBy3ppnzAum+Do/fzLfRqjd6KsKPeT0iCnWgD+XZn5bd17BNAlxbXmwgkd5KEvNtqadLxGLxgebopsJnwoA7H0plCrnWPcdqdprxeK2w/am58jtstdAHVAo4ZxjYDlyc6FFma5tgJtSVxmRu7k/TVOk4Gx4FSdg5U=
Received: from localhost.localdomain (ip-77-25-34-59.web.vodafone.de. [77.25.34.59])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00a310f2b4b91sm6954069ejm.48.2024.02.01.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:18:40 -0800 (PST)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: rtl8192e: some coding style cleanups
Date: Thu,  1 Feb 2024 09:18:21 +0100
Message-ID: <20240201081824.6998-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains some simple coding style cleanups to clear some
checkpatch warnings. Compile-tested only.

Michael Straube (3):
  staging: rtl8192e: remove braces from single statement blocks
  staging: rtl8192e: remove return from void function rtl92e_set_channel
  staging: rtl8192e: initialize variables at declaration

 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 5 ++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 3 +--
 drivers/staging/rtl8192e/rtl819x_HTProc.c      | 4 ++--
 drivers/staging/rtl8192e/rtllib_rx.c           | 5 ++---
 5 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.43.0


