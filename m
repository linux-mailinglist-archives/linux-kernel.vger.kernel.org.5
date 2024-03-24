Return-Path: <linux-kernel+bounces-115172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE788933C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DF11C2D420
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C330704E;
	Mon, 25 Mar 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGKO8QGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523913C905;
	Sun, 24 Mar 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324241; cv=none; b=mvn2t5iAcF/+lgUW7SkUVLbGqYGUxi/4KoWgq1BrwEaA5aMqWz1a9FFjQyc2QmlBfxL1TFUnNdxPHueAl8oajjskoza+1KLYo1xjdn8sRU3YBd1IGoRV8bO2CWGawmKfZlsaXvNVyVKxdv6Rv1rELN1p/Binli2XANVg9Pw5tFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324241; c=relaxed/simple;
	bh=TguXJKuy5CaVUAV88Cbuqnahj5AOGBnq+XeOpYY/+Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZcNlic9Ved6sN1b1VQ7LhwpNwseTeIwIvx7OaiS5Y3E/34/Os3BApeiWziXFxvftMn7+Nw8OzI2/33Gj19rwJGSZlbOG06ZkE//u/5yLjYklKdJpWW/+xLI1M0qCTWERoUL4e9+FhjOCzWqwIjsoXWGqH/253PTJdXeXWfz0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGKO8QGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20AAC433F1;
	Sun, 24 Mar 2024 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324241;
	bh=TguXJKuy5CaVUAV88Cbuqnahj5AOGBnq+XeOpYY/+Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGKO8QGwgVySskkac3zsU2JLAJH4QEgqEB0tYIFZ2xSi3ghUuwglV4EkGXsJsY8Zg
	 mcY2MHcYm8jAVJuHFvV3I54QDKzvdP/FwK5QtZrTFNUqX557gpYw/ZklJbio1/2wsB
	 F3aUujsL4Qshc733o0b09t/sLswYfLQM/vRaS0CjEXZR0bzYEft/0MBazeoBYZY0Vl
	 Ik42au7yTanPCTE+YVdVHgdNRMoAyc0w/Z0SMcy/YFRWpTPFOkXCbyk5XgOIy9qtSI
	 ieGygiXSZs7oKn+21rh1Mk2aCH9i6CMv2ML4cxScJJwmYlVBnfT+eLtkSUb+wKRDQw
	 a+QvS4E61fiwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chun-Yi Lee <jlee@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/148] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
Date: Sun, 24 Mar 2024 19:48:08 -0400
Message-ID: <20240324235012.1356413-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chun-Yi Lee <jlee@suse.com>

[ Upstream commit f98364e926626c678fb4b9004b75cacf92ff0662 ]

This patch is against CVE-2023-6270. The description of cve is:

  A flaw was found in the ATA over Ethernet (AoE) driver in the Linux
  kernel. The aoecmd_cfg_pkts() function improperly updates the refcnt on
  `struct net_device`, and a use-after-free can be triggered by racing
  between the free on the struct and the access through the `skbtxq`
  global queue. This could lead to a denial of service condition or
  potential code execution.

In aoecmd_cfg_pkts(), it always calls dev_put(ifp) when skb initial
code is finished. But the net_device ifp will still be used in
later tx()->dev_queue_xmit() in kthread. Which means that the
dev_put(ifp) should NOT be called in the success path of skb
initial code in aoecmd_cfg_pkts(). Otherwise tx() may run into
use-after-free because the net_device is freed.

This patch removed the dev_put(ifp) in the success path in
aoecmd_cfg_pkts(), and added dev_put() after skb xmit in tx().

Link: https://nvd.nist.gov/vuln/detail/CVE-2023-6270
Fixes: 7562f876cd93 ("[NET]: Rework dev_base via list_head (v3)")
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
Link: https://lore.kernel.org/r/20240305082048.25526-1-jlee@suse.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/aoe/aoecmd.c | 12 ++++++------
 drivers/block/aoe/aoenet.c |  1 +
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 136dc507d0206..c2b32c53da2bb 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -420,13 +420,16 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 	rcu_read_lock();
 	for_each_netdev_rcu(&init_net, ifp) {
 		dev_hold(ifp);
-		if (!is_aoe_netif(ifp))
-			goto cont;
+		if (!is_aoe_netif(ifp)) {
+			dev_put(ifp);
+			continue;
+		}
 
 		skb = new_skb(sizeof *h + sizeof *ch);
 		if (skb == NULL) {
 			printk(KERN_INFO "aoe: skb alloc failure\n");
-			goto cont;
+			dev_put(ifp);
+			continue;
 		}
 		skb_put(skb, sizeof *h + sizeof *ch);
 		skb->dev = ifp;
@@ -441,9 +444,6 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
 		h->major = cpu_to_be16(aoemajor);
 		h->minor = aoeminor;
 		h->cmd = AOECMD_CFG;
-
-cont:
-		dev_put(ifp);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/block/aoe/aoenet.c b/drivers/block/aoe/aoenet.c
index 63773a90581dd..1e66c7a188a12 100644
--- a/drivers/block/aoe/aoenet.c
+++ b/drivers/block/aoe/aoenet.c
@@ -64,6 +64,7 @@ tx(int id) __must_hold(&txlock)
 			pr_warn("aoe: packet could not be sent on %s.  %s\n",
 				ifp ? ifp->name : "netif",
 				"consider increasing tx_queue_len");
+		dev_put(ifp);
 		spin_lock_irq(&txlock);
 	}
 	return 0;
-- 
2.43.0


