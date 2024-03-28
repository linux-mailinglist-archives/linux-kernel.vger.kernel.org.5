Return-Path: <linux-kernel+bounces-113040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C28880FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 860801C213E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28F13DB8A;
	Sun, 24 Mar 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpRUscqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5F13F430;
	Sun, 24 Mar 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319850; cv=none; b=j4ZQHL34Qs88lRcUQ4B3+bipZ/tsgWO2ZATOXscDPkrVf562BE3vVYP2qpbEZC7wiwTFTADt2HVNtS44U6yvqsGP1SLCaXQu0WN1Uu8FhE/IvELpM95o9tDd3KceIY4ajULmiQ6qlsy4FKxsh2Av/MUPv4ahL06BsIaXE++Ys9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319850; c=relaxed/simple;
	bh=X8VLIvZrwN5fBir6rvd0OfOk45Gpo7bw7ybhXi54sp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZwM5sq7nDeoirgb5x1mc2V3OAnvI9s4gmAAfk17V9TC0+rPvXxmTXoKhdt8LtqczMBPvOGkMpfFeshLma3syOUu7hMvVUZDGQpAw3XEMk/Pc1zN9aMW1NJhi6ye3e2hLP45skYAi006PAN3r5wWCpV0VPJg1gJJeexCCxoIEJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpRUscqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8A1C43390;
	Sun, 24 Mar 2024 22:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319850;
	bh=X8VLIvZrwN5fBir6rvd0OfOk45Gpo7bw7ybhXi54sp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpRUscqM9yPHyXV2IS4yN3/sFlDaJDuAfech7Ua9z1aQlBZ9pi7WTdW+UFbJtpf+N
	 tIMfPQYKxbwxmWo2UNS/Dng17hNOn46oOjSwzPzoR+ZauhQZVRDYt8cxYa2+nUyw4X
	 3Ezc9ngDVOX3mfSBSKHYpfOiFFhtBSgsgpt43neZQA8HIM5aN5tDHgY6sGzUUl8Chw
	 Bpk6l6hi0LpWLXkSM7PnQp2++nn9M7Brt55m4nRaaelFB29IYCpb0hmCKZZ0IoUVjY
	 w3x/iPbgS0rEtB/n9jNLC2crc/TE+Dp5VBbPEmrJiEAJfK8QImkuWT/lHWIMPLgX+W
	 MMb1ZANEKa/Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	Ulrich Mohr <u.mohr@semex-engcon.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 153/715] wifi: wfx: fix memory leak when starting AP
Date: Sun, 24 Mar 2024 18:25:32 -0400
Message-ID: <20240324223455.1342824-154-sashal@kernel.org>
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

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

[ Upstream commit b8cfb7c819dd39965136a66fe3a7fde688d976fc ]

Kmemleak reported this error:

    unreferenced object 0xd73d1180 (size 184):
      comm "wpa_supplicant", pid 1559, jiffies 13006305 (age 964.245s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 1e 00 01 00 00 00 00 00  ................
      backtrace:
        [<5ca11420>] kmem_cache_alloc+0x20c/0x5ac
        [<127bdd74>] __alloc_skb+0x144/0x170
        [<fb8a5e38>] __netdev_alloc_skb+0x50/0x180
        [<0f9fa1d5>] __ieee80211_beacon_get+0x290/0x4d4 [mac80211]
        [<7accd02d>] ieee80211_beacon_get_tim+0x54/0x18c [mac80211]
        [<41e25cc3>] wfx_start_ap+0xc8/0x234 [wfx]
        [<93a70356>] ieee80211_start_ap+0x404/0x6b4 [mac80211]
        [<a4a661cd>] nl80211_start_ap+0x76c/0x9e0 [cfg80211]
        [<47bd8b68>] genl_rcv_msg+0x198/0x378
        [<453ef796>] netlink_rcv_skb+0xd0/0x130
        [<6b7c977a>] genl_rcv+0x34/0x44
        [<66b2d04d>] netlink_unicast+0x1b4/0x258
        [<f965b9b6>] netlink_sendmsg+0x1e8/0x428
        [<aadb8231>] ____sys_sendmsg+0x1e0/0x274
        [<d2b5212d>] ___sys_sendmsg+0x80/0xb4
        [<69954f45>] __sys_sendmsg+0x64/0xa8
    unreferenced object 0xce087000 (size 1024):
      comm "wpa_supplicant", pid 1559, jiffies 13006305 (age 964.246s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        10 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
      backtrace:
        [<9a993714>] __kmalloc_track_caller+0x230/0x600
        [<f83ea192>] kmalloc_reserve.constprop.0+0x30/0x74
        [<a2c61343>] __alloc_skb+0xa0/0x170
        [<fb8a5e38>] __netdev_alloc_skb+0x50/0x180
        [<0f9fa1d5>] __ieee80211_beacon_get+0x290/0x4d4 [mac80211]
        [<7accd02d>] ieee80211_beacon_get_tim+0x54/0x18c [mac80211]
        [<41e25cc3>] wfx_start_ap+0xc8/0x234 [wfx]
        [<93a70356>] ieee80211_start_ap+0x404/0x6b4 [mac80211]
        [<a4a661cd>] nl80211_start_ap+0x76c/0x9e0 [cfg80211]
        [<47bd8b68>] genl_rcv_msg+0x198/0x378
        [<453ef796>] netlink_rcv_skb+0xd0/0x130
        [<6b7c977a>] genl_rcv+0x34/0x44
        [<66b2d04d>] netlink_unicast+0x1b4/0x258
        [<f965b9b6>] netlink_sendmsg+0x1e8/0x428
        [<aadb8231>] ____sys_sendmsg+0x1e0/0x274
        [<d2b5212d>] ___sys_sendmsg+0x80/0xb4

However, since the kernel is build optimized, it seems the stack is not
accurate. It appears the issue is related to wfx_set_mfp_ap(). The issue
is obvious in this function: memory allocated by ieee80211_beacon_get()
is never released. Fixing this leak makes kmemleak happy.

Reported-by: Ulrich Mohr <u.mohr@semex-engcon.com>
Co-developed-by: Ulrich Mohr <u.mohr@semex-engcon.com>
Signed-off-by: Ulrich Mohr <u.mohr@semex-engcon.com>
Fixes: 268bceec1684 ("staging: wfx: fix BA when device is AP and MFP is enabled")
Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240202164213.1606145-1-jerome.pouiller@silabs.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/silabs/wfx/sta.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 537caf9d914a7..bb4446b88c12b 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -344,6 +344,7 @@ static int wfx_set_mfp_ap(struct wfx_vif *wvif)
 	const int pairwise_cipher_suite_count_offset = 8 / sizeof(u16);
 	const int pairwise_cipher_suite_size = 4 / sizeof(u16);
 	const int akm_suite_size = 4 / sizeof(u16);
+	int ret = -EINVAL;
 	const u16 *ptr;
 
 	if (unlikely(!skb))
@@ -352,22 +353,26 @@ static int wfx_set_mfp_ap(struct wfx_vif *wvif)
 	ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
 				      skb->len - ieoffset);
 	if (unlikely(!ptr))
-		return -EINVAL;
+		goto free_skb;
 
 	ptr += pairwise_cipher_suite_count_offset;
 	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-		return -EINVAL;
+		goto free_skb;
 
 	ptr += 1 + pairwise_cipher_suite_size * *ptr;
 	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-		return -EINVAL;
+		goto free_skb;
 
 	ptr += 1 + akm_suite_size * *ptr;
 	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-		return -EINVAL;
+		goto free_skb;
 
 	wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
-	return 0;
+	ret = 0;
+
+free_skb:
+	dev_kfree_skb(skb);
+	return ret;
 }
 
 int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.43.0


