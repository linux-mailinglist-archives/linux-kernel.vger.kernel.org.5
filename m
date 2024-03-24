Return-Path: <linux-kernel+bounces-116134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7114889986
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6223A2C27E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E628ECDC;
	Mon, 25 Mar 2024 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GELkPQ2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481D2811BB;
	Sun, 24 Mar 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323675; cv=none; b=nGALOHAZC/QKp9g6SO5rYII3Z3QANrQuRAV5HgJjXv3wizJg1YjnbGQtfkv15zaik4WSUya4PInMfdMkHU921e3SBAciHxfqp/9grhegvj8iKAsEC6+MbP0fuR3/0D3+175JTbyOG+UjyoLdPkoc7e6B7i3hM8/SVrcmCoXjfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323675; c=relaxed/simple;
	bh=1XQ8MwnwM5Ha1tMesnidn2cTW17PhSN1EXbTQwFpS6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVeiQ4Pa+R6CYIL0lxHueP3LLaydZ2WmD2iw9s/RgIt1HOrUshMkmJ0GXfoNI4QlD7Dj3HooaMEaOubijjGQqObgt64pryrGMIB0ZEoin75lbc/IpwbYsbM+RKb5zy/r8hjCNoMQcGVoT3u9wRxZPzPYib4u7O6UXsGsf9+SOyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GELkPQ2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5DCC433F1;
	Sun, 24 Mar 2024 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323675;
	bh=1XQ8MwnwM5Ha1tMesnidn2cTW17PhSN1EXbTQwFpS6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GELkPQ2tKub0pPTQJ28cmyRqaIYK+BKWZ8zHVtg/gL1yg7rhR3R9XNOP5FqKSLHIN
	 p167/j4s6PSG7gftdnw2EQTRG+tzNUtB9boyDcDMXJStY51p/3jDCy8k7/JJ8zmxZX
	 aDT/k/2DggucLlP13Wz+JgZSPKA27/eHbJtWkfzLvYK7BQ3OpwB+8gUvhuxcrxkpht
	 +v3xXH9mkuoxhRo7HRDtfg/hPCQ+tBoedvyy0S13wDspv1Q3aMRUqvDbBeJYniMYdl
	 foB9+0H7+tLlZdRMLaqjKcMFAsJsKZsqXRisrrTSUes20i5NzdoT3DZdwX62ATk7kl
	 dWIaoVjEbGvyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 047/238] wifi: wilc1000: fix multi-vif management when deleting a vif
Date: Sun, 24 Mar 2024 19:37:15 -0400
Message-ID: <20240324234027.1354210-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ajay Singh <ajay.kathat@microchip.com>

[ Upstream commit 12cfc9c8d3faf887a202c89bc312202445fca7e8 ]

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
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240115-wilc_1000_fixes-v1-5-54d29463a738@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index dd26f20861807..5d4f9e9a81e05 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1562,7 +1562,6 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
-	wilc_set_operation_mode(vif, 0, 0, 0);
 	mutex_lock(&wl->vif_mutex);
 	list_del_rcu(&vif->list);
 	wl->vif_num--;
-- 
2.43.0


