Return-Path: <linux-kernel+bounces-101967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D757F87AD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E31F23860
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12449143C74;
	Wed, 13 Mar 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLAoBrj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518313F431;
	Wed, 13 Mar 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348176; cv=none; b=sCsbxFm1ubHdOb3Wxbi+GCrUnIuVbxw/rtd/rqsq05rqGDHQJCf5QT31rid/zbBjfO0HkcKzmEiQfN6tGRxUfEgGwhoisl9aFeC36kONlFbRlFvWBakE9l1xF92iBZeZmNshNMFyKSCYy5MQrQBSsvIOrTraLVEmFh87Vpa0+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348176; c=relaxed/simple;
	bh=t9cB5tJirBxb/oPgBSz64yZsV3dGZtpPI1QZkEyTRRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIdbwAhRi1gNS3lyIhaWECubxqKrWowiofxTRPbP+RmQ0iAVOrHJFKQDoXkYmfgnOxfUOuV5N8XaBpngVV25kJTNGIV4IJSTY4NY/szghwOPQ5EiBYZ9XnOl+7d0JpY97YJ2GAhIormYV9J0yL86sGR4FUvnaizCs+AkXih1qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLAoBrj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C1EC433F1;
	Wed, 13 Mar 2024 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348176;
	bh=t9cB5tJirBxb/oPgBSz64yZsV3dGZtpPI1QZkEyTRRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLAoBrj5p4QOguTkykSVXFiJ7RCgawKCf1ElncdcmRVeMuCfS/uyGxJGcVN0gUG37
	 SkWvc1gKxSgD+JSfxCr6CmXmONVUv2vLiizesuQ+OwXxQjQi/IGmrXxWfOVVXksCV/
	 1ghYB23gmUUsvWsNRPova60Xpq6aBfNS6aPsvv1YUhrA6076K8ve2+APzQRFpL41X2
	 a9lfFXuvulLkqgyvBgtacgtv1JXId1cTDDsUaFn7FomKfSjdOB19LgTsL3Tg4G/RMg
	 KkZZHYYzY8HQ0qYk3BHHp0V+ZtgSnxzs0TS7BjMBhKgm1hVjLqsztE81QDBtyVHcpZ
	 k0JyA4mtMehMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 27/76] netrom: Fix data-races around sysctl_net_busy_read
Date: Wed, 13 Mar 2024 12:41:34 -0400
Message-ID: <20240313164223.615640-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit d380ce70058a4ccddc3e5f5c2063165dc07672c6 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 net/netrom/nr_in.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 376b6af431448..37d0bf6cab456 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -954,7 +954,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		 * G8PZT's Xrouter which is sending packets with command type 7
 		 * as an extension of the protocol.
 		 */
-		if (sysctl_netrom_reset_circuit &&
+		if (READ_ONCE(sysctl_netrom_reset_circuit) &&
 		    (frametype != NR_RESET || flags != 0))
 			nr_transmit_reset(skb, 1);
 
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 2f084b6f69d7e..97944db6b5ac6 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -97,7 +97,7 @@ static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -128,7 +128,7 @@ static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -262,7 +262,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
-- 
2.43.0


