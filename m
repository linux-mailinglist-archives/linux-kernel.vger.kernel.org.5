Return-Path: <linux-kernel+bounces-96606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65252875EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A311C22134
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C851C5D;
	Fri,  8 Mar 2024 07:53:02 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E74F61D;
	Fri,  8 Mar 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884382; cv=none; b=DCQY2Zwn/BBqx4UcxjD/ZAPT32AqbQHCsBZ7E80o9ww8YKeaVN5ChfXF3onj7XUtGCaYLi1q4pQHIt4eLYPDRHgGtHlV7pYJUmJZ1AzECVAbyih2UzRNnK16cJR+rOxwjhLRQlmcZ0mSw38uy24VQRyco9Ri2pz81vS1KgwvC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884382; c=relaxed/simple;
	bh=plk1XpvlB+tBdxjoQXMNOo0U73Y5H1GaU8aJioRRm7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TybWqL5FmNKJ8wgg70j75SbNuOrmoxAn7Wyunbtr8i6sJg3FAz9I91EpAZ0/pFKw5r5qe/z7HIkbd3vaE7BG8bohfeak1RO6F0rpqx0KX/Si2Ml0ZvJ8j3ar4cGjWpUXURnTZCE1pBPhM4MGiS9F4i3ml6KLzuHIOkCUkPDYRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4287qeK631940758, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4287qeK631940758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 15:52:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 15:52:40 +0800
Received: from fc38.realtek.com.tw (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 15:52:39 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang
	<hayeswang@realtek.com>
Subject: [PATCH net] r8152: fix unknown device for choose_configuration
Date: Fri, 8 Mar 2024 15:52:06 +0800
Message-ID: <20240308075206.33553-436-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

For the unknown device, rtl8152_cfgselector_choose_configuration()
should return a negative value. Then, usb_choose_configuration() would
set a configuration for CDC ECM or NCM mode. Otherwise, there is no
usb interface driver for the device.

Fixes: aa4f2b3e418e ("r8152: Choose our USB config with choose_configuration() rather than probe()")
Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0d0672d2a654..51fe00c2b896 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10078,7 +10078,7 @@ static int rtl8152_cfgselector_choose_configuration(struct usb_device *udev)
 	 * driver supports it.
 	 */
 	if (__rtl_get_hw_ver(udev) == RTL_VER_UNKNOWN)
-		return 0;
+		return -ENODEV;
 
 	/* The vendor mode is not always config #1, so to find it out. */
 	c = udev->config;
-- 
2.43.0


