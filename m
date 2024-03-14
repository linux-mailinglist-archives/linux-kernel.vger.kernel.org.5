Return-Path: <linux-kernel+bounces-102897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDF187B823
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0581C20A41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE18BF6;
	Thu, 14 Mar 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNaDKHll"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345E5664;
	Thu, 14 Mar 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399471; cv=none; b=c4R4Xackmn4bO6sMws/zQUVg4AtY24wWF4jKqG4kI1tC6rB/iFjZgOrk8ZToqQjPPADjDwrqmtx1nl0J7huo7zxHcNysMarW+axasfsJIAbGJm+4tce8ea5c8yX+bpERVi940GcZvvqre6Igkpnw2rKLOxzEShmjh+J1RKeWloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399471; c=relaxed/simple;
	bh=9EK0hK9Yh8f/gaoc5EL6LuxNpHEYEbWGrAthaoXzOb0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=JHGSkyVHByP1GKkYId9rjs66K75MwgI9/OjTYRzlJqxnMvuQ0jPR9sl/OX/s9dAs6gOYP/eah+gb4BcqpsoHclagR/wQruCiJZLBnPuKxnpVr5BXRQB4fPSb/1Vy9an5act0qF+1LxobheaVSdTZeR/kkRMXQ3SkxJYsdlQKMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNaDKHll; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c35c4d8878so132317b6e.1;
        Wed, 13 Mar 2024 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710399469; x=1711004269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3XCzn158oeVoQis+pbpqZUpajHhpzGWGyFPRII2fyI=;
        b=XNaDKHlldv/sJhyVOKxlgm2HPaTqBD1ikEB35o23UYzE9EltaI1lhpgw4fpLNX2j6e
         MAbOQckiYJDY1e5FLitpchu3QVsfLTX8sEaE9p4PxGNK2X5/1BpAWUZopqrebOB8dVAt
         jwyTi7zxzcm1qFtZ9bx1xmdgKqtCBbmauM9NwvoLqxeayyxShIKS6eWt6za0NH/0vpba
         nSkz83e4/Dik4DpxQRCHuRlyDGZYv6OiDSRGv+HaAMMfu78rp6ui9oEYp4YUEbWiBJhR
         MD254mAFCO4vRjY+nMMJcjkX6tLYZ0iB+2QDR8cLCoVJiTwpfKQNt/NfhDow6jotUUma
         xQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399469; x=1711004269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3XCzn158oeVoQis+pbpqZUpajHhpzGWGyFPRII2fyI=;
        b=ZAs5Of1QwoxphjxNYEHd8jVa4WPo2XCua3pe8EcRScyzDv/XXKrS4oxROQz7rtKN4E
         yuuTynTWY6YthxVvaY4sPhmeUa/z/qOKDfzcxq4czoUWMuqWgTAsC+SBfrj1jDQ/6vwj
         6C5Za3IHhwv0kf8Bu7bWsUI2P6Uho+wVtohie2AqkU5xPmuS5Vs9lv+Tul0kK3lN8rRp
         6spaSyLHQ+OFB96XfgP5+/SIMfy47ATNnXsgZZPs4DcyIS+rpUroiemEU+vxTzCbXe9H
         lyj7UOTPZVtGajmT4s5QTHH31fVDmsRHUP14BVBEVx7V21owmZD2kpiFzGKamPJmwCRH
         rSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWfbnT6zpTGGTHHIrHDc311IlMuKZppoIfzDmy14CVW7Z3naimNPARv4O1Zhs7p1b7WuiJW9pVwHyoLUo2gYEAjMvDQzFA7WCsa41F9hpmpfKq2FRk1eZBBCOT6A6AFSquyBf/swzNdb12NgM=
X-Gm-Message-State: AOJu0YwLsejiJGStV/KPCSMK6joJB0oWEkSqrwF3tauweOa+iGLQfiyy
	B6kfhYl9rBksuCiMsVhWs301oqyy6DmEG2P7jqKl7SBvvD/WTZzt
X-Google-Smtp-Source: AGHT+IEGDBPn5h1CV4s3eWeXANQ5Zk+Wc9Bse4rPgbtE2gjJ8e8WQd/zlGsODb+VhYWDWnMuXDgUpg==
X-Received: by 2002:a05:6808:399b:b0:3c2:36dd:a368 with SMTP id gq27-20020a056808399b00b003c236dda368mr980223oib.10.1710399468981;
        Wed, 13 Mar 2024 23:57:48 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e359-9e59-9ebb-2f4b-4781-fe3b.emome-ip6.hinet.net. [2001:b400:e359:9e59:9ebb:2f4b:4781:fe3b])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b006e6857da474sm733847pfr.178.2024.03.13.23.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:57:48 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drivers: watchdog: ast2600 support bootstatus
Date: Thu, 14 Mar 2024 14:57:44 +0800
Message-Id: <20240314065744.1182701-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 bootstatus in ast2600

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Change log:

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---
 drivers/watchdog/aspeed_wdt.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..8adadd394be6 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -81,6 +81,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
+#define   WDT_EVENT_COUNTER_MASK       (0xFFF << 8)
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -459,8 +460,17 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		if (status & WDT_EVENT_COUNTER_MASK) {
+			/*
+			 * Reset cause by WatchDog
+			 */
+			wdt->wdd.bootstatus |= WDIOF_EXTERN1;
+		}
+	} else {
+		if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
 		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
 		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-- 
2.25.1


