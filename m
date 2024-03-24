Return-Path: <linux-kernel+bounces-116253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C078895CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2160A1F2FFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C43C582D;
	Mon, 25 Mar 2024 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Elwtz9Wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25C1802B5;
	Sun, 24 Mar 2024 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324024; cv=none; b=UWj6isaXIK21yvdrZ/fbHHimwmbESgwZ3fwDZQT9eqa+PTcpP2ksb5azyhgU5SwHRIlpKNuL0jWGHmS5bXogniYOtL3Njecsr4cTC3xuGKi/cGgixsjUz8zb/TZxtSz4IUZHDLSV7BOSqaoPBjedvYOfeRaXleZM8Vbx0D/wWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324024; c=relaxed/simple;
	bh=AdKOgoZ7YM6xhwA39T+067LYWPCUSATZWLKHjQVp4b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDi+V5ujOs8sqP8C2KvCpBzqK7On3JT8Gt+4BCXvYaJXwB6NFCMgHzsa0lWcZaeW1VCRbVF8/q2xE86L/D6QWm2fEzkEctTgJU9W5VAQ53pW89DRDwt353u5rknGON2A1ZlgKKnQxWE/3mt91EzOwUo4AXOvb7xgUffFzmrvU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Elwtz9Wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA14BC43390;
	Sun, 24 Mar 2024 23:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324024;
	bh=AdKOgoZ7YM6xhwA39T+067LYWPCUSATZWLKHjQVp4b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Elwtz9Wufg1fOo/VT5YlYkRb2gIqq7WinQ8MnMlM4Q781gi2iAW4j/Kzp+kXY1pyH
	 rpkhIUlL6uAVQyi+S594DFFvh04YcOg0/7k/eczTtevocWC+mmox9UTgd/b9ajh3HM
	 WUlGR1i0JSwN311iwYjhaaWhfeESKn68RcayVIw9ZPM+dCZhrBd06NkHVE00gQPeWS
	 svjTkn+UrsgtvrL4P5iHEoUm3pNIvWoFBvv7J7ERgqyJzUQn8F5lDs+XFznf0P1Hxe
	 YNiGMbs9rgJAv3iIkZSeNU2FJtknsl4sgKd7u8r5wcXMjEczGnWFkBzo9hd74W6sXq
	 Ah0IE4mKovILQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chun-Yi Lee <jlee@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 025/183] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
Date: Sun, 24 Mar 2024 19:43:58 -0400
Message-ID: <20240324234638.1355609-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 3cf9bc5d8d959..3d5117be57f9f 100644
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


