Return-Path: <linux-kernel+bounces-101898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868187AC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223B5286C39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B68004D;
	Wed, 13 Mar 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzPF939p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B77F7D9;
	Wed, 13 Mar 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348034; cv=none; b=iJDY5VDNM448xPE1Gwa6YpK/ddooSDfMDqBXsZm6NRfoCtD4awoq4URs71QlXG5Ec3Is21NVJ6b62W9nDTM40luKLY8ssglmGd31aluPwTEHOmr+zrqf/TPcbI6CFpDNIY3QZktnsuKegzsckk8j1EKtfHrPNAaHsC+JHGmg4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348034; c=relaxed/simple;
	bh=9vb0yDa0kY/pRTpRxppIpEhL6hSD5H6EThJS2c2n8u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRUdCKSy7U2/Eo3VbHDHauiwIW6LAKnfv9D4p1e5IPnFhxtUWLCCNHT5rTH7FiD1pWEGakzNQU1gA0ocu2AJcNptH653bXtZCkIDxPEhxWL28uRKwlIY5kAqgRCKz0ZYDG+jntdxbsCO+lHlFaU9VjPLLZD5shToianYjxm4PPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzPF939p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEA4C433C7;
	Wed, 13 Mar 2024 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348033;
	bh=9vb0yDa0kY/pRTpRxppIpEhL6hSD5H6EThJS2c2n8u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzPF939pkyQE8q+Swciw9UxtVgW13/trOmdw2mgtJwKLd9GsdXaO24SIgtqM8kCfd
	 tcazWyPZDXkc3QEz4NlOTbkYC6DAEt//IvwtzNDSCFNY+6OWHZNWESrtmBAi/4AVHM
	 fy2dPNbMBT/ZvNmsxbVRpiq3Y1ZpxuZC0leHKxLQU0RExSy02aQChY+WcZbL7v3Ahx
	 rKyk6BiJXnHlDC16rj2hqhdxlkAHx+T+dUEg0kEQllzblt/Tb2Crp24PUpUqZtPDfq
	 SyvMyMKbToW7GH65f1MMlI3v1bd8qpEnk6dcdKmoqxoTTGDdg/H8ROJ1AEua/fzbUb
	 vFv5IpuwDDq5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 30/71] netrom: Fix data-races around sysctl_net_busy_read
Date: Wed, 13 Mar 2024 12:39:16 -0400
Message-ID: <20240313163957.615276-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
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
index 5472e79cde830..f0879295de110 100644
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


