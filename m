Return-Path: <linux-kernel+bounces-102891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9987B811
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAC51F23FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98C7483;
	Thu, 14 Mar 2024 06:51:43 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54286107
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399103; cv=none; b=knB4mgGawIBmHRP19wOyawPQskqhOMVKZY7+hcyalBT2q0BnMP1IixmDOQebzG2/x8jOR9easu8UHDdVfTEj5NnAaknveeB6qq/yI099RKI0/EWObhTokCsEvzXXL46SvAWYe2fEZKWWaVMz85M1mnGqOJC20OXoLsx/lY8s5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399103; c=relaxed/simple;
	bh=PWh8eKsHZ2D80yRxqV5lAUSTWJ9Q0bV2NWJayUlEwpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dMEbHDFfpN2FbJIVq5Zxm2RXTGK7hat+s04oSKwVEUP0H0C9G1Vis0KX8ydKWXsROEpy9mxrMwdAoRMCfNaOLwgYSxARFVPNEKZHOxH0nUT4SAMqnO/hTMXMGtuplsY3jiIj2CIdy9sJZsfwsYXhk4vrm/awuUhkHDIHEAE4Up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42E6pJHc91216374, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42E6pJHc91216374
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 14:51:21 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 14:51:20 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Mar
 2024 14:51:20 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC: Ricky Wu <ricky_wu@realtek.com>
Subject: [PATCH] misc: rtsx: Fix rts5264 driver status incorrect when card removed
Date: Thu, 14 Mar 2024 14:51:13 +0800
Message-ID: <20240314065113.5962-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

rts5264 driver not clean express link error and set EXTRA_CAPS_SD_EXPRESS
capability back when card removed

Fixes: 6a511c9b3a0d ("misc: rtsx: add to support new card reader rts5264")
Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 1a64364700eb..0ad2ff9065aa 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1002,7 +1002,7 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		} else {
 			pcr->card_removed |= SD_EXIST;
 			pcr->card_inserted &= ~SD_EXIST;
-			if (PCI_PID(pcr) == PID_5261) {
+			if ((PCI_PID(pcr) == PID_5261) || (PCI_PID(pcr) == PID_5264)) {
 				rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
 					RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
 				pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
-- 
2.25.1


