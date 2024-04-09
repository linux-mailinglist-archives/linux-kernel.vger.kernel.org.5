Return-Path: <linux-kernel+bounces-137319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F298E89E05D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B2D28D86E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F713E3F6;
	Tue,  9 Apr 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPXAwffX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802B13D8A1;
	Tue,  9 Apr 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680175; cv=none; b=ZrEB/Z/z227/Et1s3qfbXnN2jVWwe2vcOFHQJ11o+JeDO/N3fPuz6XKfz1WZyy+6Zn8osuyfkzLe2+IJZyGqAD1YsNeuZW1RxKtFyrqLXPprHUzDpYkXjlKz3DfAD7o9n/PYOczNIKJ9mkrslpdv4rHqaLEN+PUi27OjBedK1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680175; c=relaxed/simple;
	bh=V16moFgeP8k3yDO5pLaW4kgY9d/ZFFZUxwYukslm3/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nIGKFOBumzErh8oCom2PfrJhGiDxScxZ3X25gAWNgjjqC3ppxZnUS+WWY/fyX9fXW6bJKT8tmAmAxKdeJa+p8SSnnarAMPX2R8X+DPq7Kb+JTw+N1ISvVEmjY3YYGzfxaRZ5SaI3q+jAcnzbC6TjFBSO69eb6zQVc7TRY85ftnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPXAwffX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e2a307902cso9723635ad.1;
        Tue, 09 Apr 2024 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680173; x=1713284973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9wlbec+lGT/5Ea9hUF4B3S8EFMrY3jQ3hx2ghy4d9E=;
        b=SPXAwffX8L8co1i8DhbsJgNfJkzIU5GWJa2k0wUW74N4uHt+ytzvJfTDAOGuqA/0Mm
         iw/4cbeT61Ppoc3ji/9TEZ2ICt/W2B3hpdZw6MtkkknpjlOdMf/FgGrdsRCQKqk6z9/U
         qnJXg5BK2U0y0Zx+4Ogl/8OzZkoS1wIdVAxOte9ZIFBPUCrfJCO5uV4Wxt0M98PAABOV
         TuEUuhQMj6EXYf0JeUPFSbkkK6g7kva6SFxpeO3eMD42qM0LYgtquS89bnds2bomOJcb
         fu5JFiFwc7thh4vxlmc5NQKC7N+h5rYMiyhnwN08npXneNxh1d406aiWTBxzMkTDX67A
         dgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680173; x=1713284973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9wlbec+lGT/5Ea9hUF4B3S8EFMrY3jQ3hx2ghy4d9E=;
        b=IM1C7GjDtSZYyzTQqBDCReaAOLjFQySCx0kru4vkkvrvA1ApxNvIEEkHhux1hEWJku
         VdZRhlpEPTTT3BmfA95EoDwGfaF54mntzQ8o8ENbznBfohITXojwBMjFhKjS/q0pDG/z
         JSiFjVD47OPrw1iOOZq2W1wyUcmgmmn91+4vtL0TsuhDRnDnweAwJwJrueZkcZHy09RX
         eFUfZqAG+cLqd2LIn/igf5DmgSMmPJSzkaCjkaAwZWINbWflzBXcePgQ3h7HUb5V3zzT
         NltHu1l2A4K5FGYX3qNvKLHvw7RHFwPbRrE9yUR9Bgw00bNchZIIJaDGoMhK8q5/2rdY
         tq9g==
X-Forwarded-Encrypted: i=1; AJvYcCVJvyqETjr1h0/t9opqdVCabDkdvVGmu4yBMmkynA68QAQGinsTZcoBA+CBRod3IN9aCgb03pqu3pS2689Jjc9yMlPa53rcmihg/s1qYcCX3y9k4T8wLw69Gfeo/7RqQMLWrIhLPV8H
X-Gm-Message-State: AOJu0YwsNHTFEbPXdRpw2nM+qWUYidIOZHLDU1fMWKU/Te4xQhohOjrZ
	fJX7uWMcuwlxZS/72+fG4hGCTUROKD2xYEvHPvWyBJK59GJJCxcP
X-Google-Smtp-Source: AGHT+IGSACGuseLx/VFy/h/mXPubm88NKF6qjXDAXtMvgDzU4SzeT3MvID0TwvjpGnqVsyqmqS+5bQ==
X-Received: by 2002:a17:902:f68f:b0:1e4:344e:768e with SMTP id l15-20020a170902f68f00b001e4344e768emr240435plg.5.1712680173248;
        Tue, 09 Apr 2024 09:29:33 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:e1b3:7a61:eeed:d791])
        by smtp.gmail.com with ESMTPSA id ix14-20020a170902f80e00b001e22860c32asm9066544plb.143.2024.04.09.09.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:29:32 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: gregkh@linuxfoundation.org
Cc: mka@chromium.org,
	frieder.schrempf@kontron.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] usb: misc: onboard_usb_hub: Disable the USB hub clock on failure
Date: Tue,  9 Apr 2024 13:29:10 -0300
Message-Id: <20240409162910.2061640-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

In case regulator_bulk_enable() fails, the previously enabled USB hub
clock should be disabled.

Fix it accordingly.

Fixes: 65e62b8a955a ("usb: misc: onboard_usb_hub: Add support for clock input")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes since v1:
- Rebased against 6.9-rc2.
- Collected tags.

 drivers/usb/misc/onboard_usb_hub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index c6101ed2d9d4..d8049275a023 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -78,7 +78,7 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
 	err = regulator_bulk_enable(hub->pdata->num_supplies, hub->supplies);
 	if (err) {
 		dev_err(hub->dev, "failed to enable supplies: %pe\n", ERR_PTR(err));
-		return err;
+		goto disable_clk;
 	}
 
 	fsleep(hub->pdata->reset_us);
@@ -87,6 +87,10 @@ static int onboard_hub_power_on(struct onboard_hub *hub)
 	hub->is_powered_on = true;
 
 	return 0;
+
+disable_clk:
+	clk_disable_unprepare(hub->clk);
+	return err;
 }
 
 static int onboard_hub_power_off(struct onboard_hub *hub)
-- 
2.34.1


