Return-Path: <linux-kernel+bounces-26159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F882DC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED758B21365
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0317738;
	Mon, 15 Jan 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eQp3fu30"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626018629;
	Mon, 15 Jan 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 95A43C6473;
	Mon, 15 Jan 2024 14:59:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 954FAFF812;
	Mon, 15 Jan 2024 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705330755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KljMchxpu6sUXwdpmR1vxK0+FWcbaI+DBRqAnIQUPW8=;
	b=eQp3fu301Pdbrj+5NEEwhB3xtfqdd9CrRZuNr4j+TnGsXarH/kVpLtdeYvHaixB6ExxMTG
	mN5jxpP6VHWMrGHwGj7dWEo8XkBAL36stLNgR+OTGWliEQh5zWQCnAUwF7ocfgo9DmCO+Y
	FVlIeszJvowU32RiBfsGCs+7M/eZvHgg+ZyyG9NxLS+iK76xCrhsaga0CSWs4g6FO5MEn0
	cTtk9zBZkHmZFpLXEX+BI60Z8jUzQe+5DdIKsHkjXBqpoPjPDDE/1P6liFl1dU1ogyfolq
	wlBhNylR8C6qQrHEh1Es/3qrMzz73MpaZaQAW5moO2Knxum4b7Gv0yG/f5G04Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 15 Jan 2024 15:56:34 +0100
Subject: [PATCH 5/5] wifi: wilc1000: fix multi-vif management when deleting
 a vif
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240115-wilc_1000_fixes-v1-5-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
In-Reply-To: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

From: Ajay Singh <ajay.kathat@microchip.com>

Adding then removing a second vif currently makes the first vif not working
anymore. This is visible for example when we have a first interface
connected to some access point:
- create a wpa_supplicant.conf with some AP credentials
- wpa_supplicant -Dnl80211 -c /etc/wpa_supplicant.conf -i wlan0
- dhclient wlan0
- iw phy phy0 interface add wlan1 type managed
- iw dev wlan1 del
wlan0 does not manage properly traffic anymore (eg: ping not working)

This is due to vif mode being incorrectly reconfigured with some default
values in del_virtual_intf, affecting by default first vif.

Prevent first vif from being affected on second vif removal by removing vif
mode change command in del_virtual_intf

Fixes: 9bc061e88054 ("staging: wilc1000: added support to dynamically add/remove interfaces")
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Co-developed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
This patch has been initiated by Ajay, and I reworked it a bit/split it.
I could have just fixed the parameters passed to wilc_set_operation_mode,
but I observed that even calling wilc_set_operation_mode seems faulty in
del_virtual_intf: for example the thread in charge of sending commands to
the chip is possibly not running (because interface is not up). Also, the
vif mode is only configured in change_virtual_intf and not in
add_virtual_intf, which tends to validate the removal from
del_virtual_intf.
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 2d0474e6404e..f03fd15c0c97 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1609,7 +1609,6 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	cfg80211_unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
-	wilc_set_operation_mode(vif, 0, 0, 0);
 	mutex_lock(&wl->vif_mutex);
 	list_del_rcu(&vif->list);
 	wl->vif_num--;

-- 
2.42.1


