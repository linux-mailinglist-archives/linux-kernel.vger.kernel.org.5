Return-Path: <linux-kernel+bounces-115402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED7889B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530871F39681
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E438201274;
	Mon, 25 Mar 2024 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZbyLry1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49F1D696B;
	Sun, 24 Mar 2024 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320580; cv=none; b=iWFHYoo8p+P6xV7nezmiV3hmkfB7Lv2xJeRR2b0iDfG8lhpC44YV96oe+o0Arl6liq8KCFl/RC3llrnqXn5bxbDSy6OwFroSh8Gq2rgOieWksA/ZO4huVTSNQfsFhWAS+CaXPn2HdjFQCu38gzTkBiY0uz6gRBMe+ZTOU49T8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320580; c=relaxed/simple;
	bh=CFbF8Gb1ow+NdPZA7IBEO0pn0ejXW8fD02MyU28E5tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMxL7M27SoCluBOdDHpnT8JKVYPtvpXJgV1MUnSuCZlth6YU6b50rzEu0lJjW2PEUMidKAycY6I/gb9lDtBq5nnjQX8Ey4nkToMlpIdYCYusqZgs2ZVWMLY4XPbskKEaAM/oE8+AwYkNK20/HO2iBYunk7LxmCyH8kHXOtH2274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZbyLry1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A9C43390;
	Sun, 24 Mar 2024 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320579;
	bh=CFbF8Gb1ow+NdPZA7IBEO0pn0ejXW8fD02MyU28E5tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZbyLry1nqJ1KmVqC8vxnh8T2SvJ7AnGDErwyJvYhy6uhh8LKFhfl4qtSNa0Igfwi
	 0ZOOD3kaA/Clu4bIgE5n2DeqxsYTlZ7c9tq8KKC+3kv6UYCu+jQiP+10QSX2AieZPx
	 tjS5QSZc0zp9tNMIJPsA4MzsmKpZ3+TXoe+GCTHIYGYKUtpZoNgyQjS3FWd2sNpqZY
	 2K9l500fbaN3rjh/wK0eXy3wG4yEvGYwB24sEp2n3/EhYsn3yKfa7mXA9127VNOVCb
	 Z6DueUfkiPTB5FJ4UUoBfLU8lg2iXXZS1pb1mja/nbA2dD+hSejEMXocapHUPOGl87
	 K/fx8zPo1kk8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 140/713] wifi: wilc1000: fix multi-vif management when deleting a vif
Date: Sun, 24 Mar 2024 18:37:46 -0400
Message-ID: <20240324224720.1345309-141-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index fec18be90697c..e9a047a8c7dce 100644
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


