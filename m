Return-Path: <linux-kernel+bounces-116128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C4D88997D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7B62C2798
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA323AD94A;
	Mon, 25 Mar 2024 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxc/sWAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A3179FC9;
	Sun, 24 Mar 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323663; cv=none; b=c/5g6CqAwdFtohL8RriNfLBBF8rbNZzL4A+4ljZuQGB6prspdGe404WxNIJPZR/aCHfnY3bFeqxap4hF4HtxQES8YOors4hLIJnLfMxRDddLZtca7whKEnhBgexNOw5eLfcCghUhpcYuaoTdt3Ib6OI/Ws4i2GnGtZwWyTfWbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323663; c=relaxed/simple;
	bh=NIoDcRpVejFLNVUkjop1RAxTn/B6sQZnq+VQSlo84Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY2Fx+nROLPxxF2B9GMAGwelCTtBb9kzERNCrfIqG2o8q8Q9mA/f/DQRZ4l62SuIZheFA+UVi3GNwycQEmG169jr4rrzEK2aCl21p6tyRavgIoPiSfgu5C4yN7NZaBISfwVaN1ipJf7qPA6S+Psfva90vgo8f95Ge9M2BBpFEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxc/sWAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8117C43399;
	Sun, 24 Mar 2024 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323663;
	bh=NIoDcRpVejFLNVUkjop1RAxTn/B6sQZnq+VQSlo84Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mxc/sWAVUnF8ICSFAzeu4KxUprDCmKZ2w5qfCpacLT8th3soy/nGfID063tqqia9k
	 BPFqEKEBL7kmCRC87qJOrhAQL3BDX5Q4c8qggHg4mfV/2KMHyQjL81xR1b02NDV5gV
	 fHWraPspch7AteuVW6EyMd3H5jHrNdLPr57c9dlagfoOn/k8L1ghSvpEvgZK+O6HhB
	 fGLhCCMRcoyCdzki/jJ2IEbY0EjZ6FU0Q74Qt/7i0FUbmRk1LElAw4dRD2UJi8PJyM
	 bhzpw16yg8gseEOsmop5+sdfoEzVfeKChMap3deVb/xKGGJAZzXD/Q9JU35nkoTMVX
	 8+yX3Rktw1kgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chun-Yi Lee <jlee@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 035/238] aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
Date: Sun, 24 Mar 2024 19:37:03 -0400
Message-ID: <20240324234027.1354210-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 313f0b946fe2b..c805909c8e775 100644
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


