Return-Path: <linux-kernel+bounces-116018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA908895E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99147B34C73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99A17D24B;
	Mon, 25 Mar 2024 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4NlJMJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E08175545;
	Sun, 24 Mar 2024 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323358; cv=none; b=iF+Udv4hwPtL7W78TbEpmZSUwb7gCaTNYCnrPqBZz4UrBz6ObNBhMnVqsVo38ABgTMz+Yj6qNNf1P/PR1vrI/fXYsiRq6JCMDrLVNfCUp5MgkzH8wzcfDT4PSOBORLSUitlAP9OqbFOjZiSG2gk9C87oH2PbFogOi94jfeZF960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323358; c=relaxed/simple;
	bh=jSETjfA6+4rjPk0c2xR67WmUBQc3t5xsnw2SytfzANc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgM7gJg6JlZIL2/1Kn8Jn1qLc62bAg567z8Lff26S/8fdNiacRVZzn+TBLCfauWECMMabxoL6qjR/bqUsdBOLXOYJpKypjJZzeAGaEnPi+wfyOzMzEkcbGlmp1kb0pUxBQyReNc6f4ejOVrabNeL59+I3NxW9ZMjFPS54Lwbcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4NlJMJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB46C43399;
	Sun, 24 Mar 2024 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323358;
	bh=jSETjfA6+4rjPk0c2xR67WmUBQc3t5xsnw2SytfzANc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4NlJMJqBdxmQyww7uM0jQERMoyrAqgiwGVVUaFj4VijVWKRLeDXYkuCCCXMP/QO7
	 I8zTZWP9YXAZCdTtSLfgazp+PN/DXpJVn+s2niUK7ubgaLGMeY/y7yB2WreM+S17Dn
	 76Ai6OjJEmEbA7qm1qSeRdrdwD6RrdJ1r3Nsu2kNRv05A2z7TEttUIgsezcXtQHJTO
	 bSbsRCaUyKNH2cLQPWb+R/DgSemup5Uq6jJzlr7A+ulG6BKnUINgedAb1LC9GsezLa
	 D71BJtj64+255tfX+Al3bjYqLL3ap3b4jfr2YlgCRb5bD8vuMZNHvnkj4PTmdN7A2g
	 sgK8G4NWn/7hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 058/317] wifi: wilc1000: fix multi-vif management when deleting a vif
Date: Sun, 24 Mar 2024 19:30:38 -0400
Message-ID: <20240324233458.1352854-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 1688144d78475..0f48204e6e0e4 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1562,7 +1562,6 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	cfg80211_unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
-	wilc_set_operation_mode(vif, 0, 0, 0);
 	mutex_lock(&wl->vif_mutex);
 	list_del_rcu(&vif->list);
 	wl->vif_num--;
-- 
2.43.0


