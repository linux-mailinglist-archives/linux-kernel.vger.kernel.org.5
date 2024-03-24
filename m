Return-Path: <linux-kernel+bounces-114082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BEA88884C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D71F256C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AD314F9C3;
	Sun, 24 Mar 2024 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNU2LyuH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C131130E34;
	Sun, 24 Mar 2024 23:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321379; cv=none; b=sb4k6yXYj65vw1u5OohHKZm95NNLCjQtr0qpBmbbEhhmBh8F/LtP2Cqmop2MGN70WFsswHKhwR9iL3qZ+9SpjtRa3xHe6hSHvtATOS0f7O2fsHbiL7HStpG2LVLEvwNSwBYRgAmGq/LgQ/GmDBz6ctCopR1UpCCmyCrVgvV2IU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321379; c=relaxed/simple;
	bh=MQ8BlB4JG1jjZwfj5Rva8ULNhjxYa7cmFF0KVqjjOCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dumeJvzpA8SYsiJrSVNi4Jou/JmqMnfDlsom062vM9hJQxir5+GmBO+xtM9RsEBFpiOGXJmhIOvWNmXP7F30KiRxMaITc17xG1iL2C9kKklPw3nuwFl3Ltry96tn7dPHPhifDIzkDDkvUjtoBTcPvKyTuFyXMk4l/1DkdP44hPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNU2LyuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59200C43399;
	Sun, 24 Mar 2024 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321378;
	bh=MQ8BlB4JG1jjZwfj5Rva8ULNhjxYa7cmFF0KVqjjOCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hNU2LyuH4090KT/uXGtuxtjAqdB7OPqX8L4vkQFwgAsCHJIZd2U5d6YVvLGQ0AfjZ
	 jEa5Vf9ujPzsNdFcr5jjwE83HH4LQBkAlbyfrJ0vRMFjVlJNvatyBzqk3ZJ8CRhTqz
	 T1h79F5Da030LM10cluEXGTDX4OuA2naYLp6r7SuludILACxWBwft2l0b2HAhRr+hs
	 uA9gs1vT0DYgTXRA5G+YtKvApP9cIo8v4rr9pDEpemLV1aETYv5DzertRHtfkzCWVq
	 liGkdj/eyigVR5/PlNpdD4Q1Msz94NoSbfa+f/58IVEXDqtPY9PlVWmC8kdTz625GT
	 j3XWNwmt7oMUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chun-Yi Lee <jlee@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 102/638] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
Date: Sun, 24 Mar 2024 18:52:19 -0400
Message-ID: <20240324230116.1348576-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index d7317425be510..cc9077b588d7e 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -419,13 +419,16 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
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
@@ -440,9 +443,6 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff_head *qu
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


