Return-Path: <linux-kernel+bounces-112954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF47888006
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F551C21199
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2523EA90;
	Sun, 24 Mar 2024 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko8bceW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52B85941;
	Sun, 24 Mar 2024 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319767; cv=none; b=duzHev0BCdxyo5fsyQXduUZAflOnjQlioId6TiImok1vE4SBc6onmU2n7Iql3KAg8zdWr18hlj2Pxaqhd7uEhkO3DZ0d2ou6AIBno0DpukzpMwlzRqDvrblv7KFxBh5eIktpNvXRInzt1KfZjm0C1lYHotLG16cVN3PkFJcME7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319767; c=relaxed/simple;
	bh=7eUBJ5IjDgPLqBRxbfms1rpD5UqfO/FsYLiLZqXzTXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMf8GECxi6OvoCURqADHpu93j+bIaLSmBcihO/ar8i0QW+SLLHxuGpLyBvCsI2ToUJJHHVPAlEWTr0TCex+2k3CtynN0dcjBE+P5Lom4N/Q6MIcNZCdRTBDubc01OTNjctRJr7P4U7sN2gh+po4pgTFMmB+lm1Dv4xuzbD6wNko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko8bceW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04201C433C7;
	Sun, 24 Mar 2024 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319766;
	bh=7eUBJ5IjDgPLqBRxbfms1rpD5UqfO/FsYLiLZqXzTXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ko8bceW1VfnSYSPYKVsmecJibTwIRek/Wud4kLEvczEgasIka0Xdk8nd6WvSZ6PIg
	 2ByoAXBL37bkpKsVwdBaNmN9pkBB2Ym9U5GNvVGTJTGOaAkNGAH89wIiyARje/Nc/z
	 66JPYiTRO4zOi2WENeUtTzWuXIZ3gPoBwI5revxy/Zw9lk55/V10NP1v/l5a8O6CI5
	 Y/BSnj+JO4CnJB+pKhP5nbFGPH+aQ8BDeunoQm10xD5K9YUj99X/aSdtcCjkjabFgN
	 XJZM9BSsKqJVgpLV+HzKbZkueS4co79O9zz82eMqievSXsfFu6ZauidSS/xS/SqrM9
	 P9RyUxqee4o+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 067/715] wifi: wilc1000: fix multi-vif management when deleting a vif
Date: Sun, 24 Mar 2024 18:24:06 -0400
Message-ID: <20240324223455.1342824-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 2d0474e6404e1..f03fd15c0c97a 100644
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
2.43.0


