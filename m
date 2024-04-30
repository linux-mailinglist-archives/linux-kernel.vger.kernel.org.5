Return-Path: <linux-kernel+bounces-163378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB58B6A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B416E283B73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67C1798C;
	Tue, 30 Apr 2024 06:01:30 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A5C2ED
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456889; cv=none; b=tt9bOlozcWpsrlO8ClH1XHe/rjSCy+B3EPqX2VgvWYb7M/kGEB1MsuHtE4Uq1f5YSqs8J0lRyFzjQqh09c6FQLwgR/rjUTUJ9SnEDwPKD5bekXa7DX5Pm+1FyDIpw8XSHyA49EZ5pKo5xOPgf/PLnbdh/KpMo1J6fNiObcaTwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456889; c=relaxed/simple;
	bh=kCKgs+b5qA0FeT5YCBwRPQjobIX9fmkyylAE+1ayplY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d1zRi866QVDajlcQFRcqt7FAcbdgtMtLmnLpniDnH50/HNsKkeL0TO3R/BXckn5jucZ3ty+JIVyeLUnNAMVmyQQVOgtTa3vRcUxUvgVdVg5MOcVI8iuYgCPbvAAXSzj1x4vC590XNOj1Gkdmp+tH/rBQcvODU1fwzE4ll8gKeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43U61EWF0079633, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43U61EWF0079633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:01:16 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 14:01:14 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 14:01:14 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: do clear express reg every SD_INT
Date: Tue, 30 Apr 2024 14:01:08 +0800
Message-ID: <20240430060108.580685-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

orginal only do clear EXPRESS_LINK_FAIL reg when card removed,
this patch moved the flow to SD_INT statement, make sure the reg status is
correct when inserted/removed card every time.

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 0ad2ff9065aa..117b3c24f910 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1002,12 +1002,14 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		} else {
 			pcr->card_removed |= SD_EXIST;
 			pcr->card_inserted &= ~SD_EXIST;
-			if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
-				rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
-					RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
-				pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
-			}
 		}
+
+		if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
+			rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
+				RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
+			pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
+		}
+
 		pcr->dma_error_count = 0;
 	}
 
-- 
2.25.1


