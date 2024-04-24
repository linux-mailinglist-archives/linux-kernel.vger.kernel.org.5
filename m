Return-Path: <linux-kernel+bounces-156572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E34468B04B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9214B2567F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFD158A29;
	Wed, 24 Apr 2024 08:46:17 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E62156C78;
	Wed, 24 Apr 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948376; cv=none; b=utzmTM9j8kTdXUzfqJWbluYc2Cl47ybMxTr6u4TEFmWOE/LxyOQndaTDSU2VXOo+y1/DbwKfvCm77pgqad8gEaG6EqOIvfYUdNSJaiKhKmO9frN7ik4r4VvXmmlj7Q/+TRtZdpuez7xUkEH0ne1Sag51VhWALGcOYTbR5ITQgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948376; c=relaxed/simple;
	bh=U9WEx/BCuYxzfID62sP6/0+vS8kW5OxyjS0bTYk41Zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MDeBm+6dx0PNOxgdbct24BpKCQ9F/JB7HkgbjLUTAk3QvYQF6b+uAyfgizg4MHxn3Vo5Rpxcc21Z1g8cjceQ+/Jpo3pFzfBoIhtBLs9tcZHn9bISKjMZfadIqd70hKW8uoN80hkWeZoqoKYK0OHMkcpMrCNS8QPADGp0NpQSbcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43O8jun572217172, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43O8jun572217172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 16:45:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 16:45:56 +0800
Received: from fc38.realtek.com.tw (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Apr
 2024 16:45:55 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang
	<hayeswang@realtek.com>
Subject: [PATCH net-next] r8152: replace dev_info with dev_dbg for loading firmware
Date: Wed, 24 Apr 2024 16:45:32 +0800
Message-ID: <20240424084532.159649-1-hayeswang@realtek.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Someone complains the message appears continuously. This occurs
because the device is woken from UPS mode, and the driver re-loads
the firmware.

When the device enters runtime suspend and cable is unplugged, the
device would enter UPS mode. If the runtime resume occurs, and the
device is woken from UPS mode, the driver has to re-load the firmware
and causes the message. If someone wakes the device continuously, the
message would be shown continuously, too. Use dev_dbg to avoid it.

Note that, the function could be called before register_netdev(), so I
don't use netif_info() or netif_dbg().

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 5d6aeb086fc7..51e9f5b2dccf 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5274,7 +5274,7 @@ static void rtl8152_apply_firmware(struct r8152 *tp, bool power_cut)
 
 	rtl_reset_ocp_base(tp);
 	strscpy(rtl_fw->version, fw_hdr->version, RTL_VER_SIZE);
-	dev_info(&tp->intf->dev, "load %s successfully\n", rtl_fw->version);
+	dev_dbg(&tp->intf->dev, "load %s successfully\n", rtl_fw->version);
 }
 
 static void rtl8152_release_firmware(struct r8152 *tp)
-- 
2.44.0


