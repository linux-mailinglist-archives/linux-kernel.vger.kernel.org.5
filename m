Return-Path: <linux-kernel+bounces-102192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3164587AF48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622271C2565F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341019C41B;
	Wed, 13 Mar 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLaKs0uR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA819C3FD;
	Wed, 13 Mar 2024 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349486; cv=none; b=bkuROFDQT4xH6MVicuWR/SkK/fenzhn4ExhG6fJ2K5yYzRa56uh3U1m30rqQbAW+xxxUjUmKLoOa/V8fVaDruLbp2EX2zxAs9rqNBEauCaABHW8w2cWp6jBZU7wCxxLNSIxENJVVs6hum57gm+2tRC0XGvLnA3HZLf8rAmyvU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349486; c=relaxed/simple;
	bh=3kgDSuFyXAW8sJnXODkw0rGdaC6EWFrWZog2gTwQNlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udG8oKBdVoYV3blXdhaEe5iUqOpAKa6FVxhpeqDDiNXGC4ZsuVNAlg3rfFAjHW7YqDlFaFcNyGxHlwJ/J3kYEBNEyGJrRTKns2aw7UDrczze5S0+mfb57iy8z/pKkGqaForzUh4ScHPjIe0G3tMFLfJr23A7R/j3etBhzan6wwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLaKs0uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFDCC433F1;
	Wed, 13 Mar 2024 17:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349486;
	bh=3kgDSuFyXAW8sJnXODkw0rGdaC6EWFrWZog2gTwQNlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLaKs0uR6D4GIc87hEeLFfAsx4F/2ZeOeSucwIFFcOwZtb5r3E9frUCIm+evmamAx
	 85fLnKJeWa+X5v8J3UdWW7ExWCEuw+mJSx4CrCli3E/Cq0/jLEREnaEIhdhtZnU3J0
	 cKGWKna+4E1CahoZE/EpkcSVxMeYh/j1YZz0R95aqshc3PeVVRk1YP+3tcfCZ8IqbO
	 k7isj4XjMvWTXD9ji0NA6RLC79X1iJtvcwTKaLhCoe7UyAfQ5NhiEuZ0iE1VuWB/nr
	 Pepzi84Md0lxv4hjI2UW+tBVMxWqGCSzX/ozOpT4hZ1oHL93CJw7N9QAzyf9o9yZYT
	 7PMwSJxEChh+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>,
	Zhang Yu <zhangyu31@baidu.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/41] net: move definition of pcpu_lstats to header file
Date: Wed, 13 Mar 2024 13:04:01 -0400
Message-ID: <20240313170435.616724-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 52bb6677d530d37055092d86b4eab69dce6c166a ]

pcpu_lstats is defined in several files, so unify them as one
and move to header file

Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1ca1ba465e55 ("geneve: make sure to pull inner header in geneve_rx()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/loopback.c    |  6 ------
 drivers/net/nlmon.c       |  6 ------
 drivers/net/vsockmon.c    | 14 ++++----------
 include/linux/netdevice.h |  6 ++++++
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 7863918592db9..954935a38f186 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -59,12 +59,6 @@
 #include <net/net_namespace.h>
 #include <linux/u64_stats_sync.h>
 
-struct pcpu_lstats {
-	u64			packets;
-	u64			bytes;
-	struct u64_stats_sync	syncp;
-};
-
 /* The higher levels take care of making this non-reentrant (it's
  * called with bh's disabled).
  */
diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index 4b22955de1918..dd0db7534cb32 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -6,12 +6,6 @@
 #include <linux/if_arp.h>
 #include <net/rtnetlink.h>
 
-struct pcpu_lstats {
-	u64 packets;
-	u64 bytes;
-	struct u64_stats_sync syncp;
-};
-
 static netdev_tx_t nlmon_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	int len = skb->len;
diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index c28bdce14fd5e..7bad5c95551fd 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -11,12 +11,6 @@
 #define DEFAULT_MTU (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + \
 		     sizeof(struct af_vsockmon_hdr))
 
-struct pcpu_lstats {
-	u64 rx_packets;
-	u64 rx_bytes;
-	struct u64_stats_sync syncp;
-};
-
 static int vsockmon_dev_init(struct net_device *dev)
 {
 	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
@@ -56,8 +50,8 @@ static netdev_tx_t vsockmon_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct pcpu_lstats *stats = this_cpu_ptr(dev->lstats);
 
 	u64_stats_update_begin(&stats->syncp);
-	stats->rx_bytes += len;
-	stats->rx_packets++;
+	stats->bytes += len;
+	stats->packets++;
 	u64_stats_update_end(&stats->syncp);
 
 	dev_kfree_skb(skb);
@@ -80,8 +74,8 @@ vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 		do {
 			start = u64_stats_fetch_begin_irq(&vstats->syncp);
-			tbytes = vstats->rx_bytes;
-			tpackets = vstats->rx_packets;
+			tbytes = vstats->bytes;
+			tpackets = vstats->packets;
 		} while (u64_stats_fetch_retry_irq(&vstats->syncp, start));
 
 		packets += tpackets;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ac87fcc4d44b4..89155d171b567 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2383,6 +2383,12 @@ struct pcpu_sw_netstats {
 	struct u64_stats_sync   syncp;
 };
 
+struct pcpu_lstats {
+	u64 packets;
+	u64 bytes;
+	struct u64_stats_sync syncp;
+};
+
 #define __netdev_alloc_pcpu_stats(type, gfp)				\
 ({									\
 	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, gfp);\
-- 
2.43.0


