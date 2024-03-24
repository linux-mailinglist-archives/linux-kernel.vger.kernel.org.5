Return-Path: <linux-kernel+bounces-114088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8021888857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02AF284838
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275B237B9C;
	Sun, 24 Mar 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMQjmOpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F28201242;
	Sun, 24 Mar 2024 23:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321399; cv=none; b=WJYqOKhOIaqIERyt7FDa2x8Z6/rbtLZ94oGGR09mlIaesvmB+G/4UQsPGTLAFX5mi5oiYGuBzPvw6HlL33lURVXB1rN0EK+2wRM4egFM1h+DRw1ywDDuRq9PhRH1LV6Fvopz2tfBpWpwuzgPTzNWjDyF0uUqBUHBvaGEPyomo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321399; c=relaxed/simple;
	bh=LOdq1mNqCD1OLC2zN1bxNCWDll0+7fgycknYNHN/tG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgNqTzJ9e54tNSl0EDT0WGGJ6fjqcs5P4fP26E1LNSiRKgMKqNb/BiHxfRbEyXsxOHDdB7LfiMPpRjHekKKuZePDVj9XqHvVIwZGkXsrLWwdB65RMirw+w9KVVlHSDT9MCf25WyLQrNK7HXAkBellBx8G1k+c/XGYH3BlGaLPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMQjmOpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6F5C433F1;
	Sun, 24 Mar 2024 23:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321398;
	bh=LOdq1mNqCD1OLC2zN1bxNCWDll0+7fgycknYNHN/tG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMQjmOpzFcZl1pPI8ChfDGP0PWS3LaaZxlN4ao2AToeAG6HPHE/3i+SMUPPsF7Kd/
	 Y7ZMBLyn71uPGL7x3p2rRQ6HcO/eN2wt4rQdUq/g+Tg03c6PzABFmhtKDsmBYWXtaI
	 Q47huPmo6VezNB3f7QAGADLiTCzjQgLaVXZZIlSw3SWypzlDshDhiNnNleJccAiifv
	 FSF4ID3tyxN96rophRJWb5s85vPqIkz2NJUnWDzJWk6BtKXxIDf2+28bGjwIvx6OJy
	 PNBeqKLZyrII74XdSPUYbxwQT8qhzI+r6ZX2B3dDXdJO17FiNolTWgcxlWF6s8ZvLL
	 H24BVUrIVx3gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 122/638] wifi: wilc1000: fix multi-vif management when deleting a vif
Date: Sun, 24 Mar 2024 18:52:39 -0400
Message-ID: <20240324230116.1348576-123-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 2f75dc4b47975..6f3245a43aef1 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1615,7 +1615,6 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	cfg80211_unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
-	wilc_set_operation_mode(vif, 0, 0, 0);
 	mutex_lock(&wl->vif_mutex);
 	list_del_rcu(&vif->list);
 	wl->vif_num--;
-- 
2.43.0


