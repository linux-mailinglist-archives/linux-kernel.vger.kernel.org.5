Return-Path: <linux-kernel+bounces-102210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DB87AF73
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364E91F278D8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE661A00FA;
	Wed, 13 Mar 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M06D9tGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00701A00D8;
	Wed, 13 Mar 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349503; cv=none; b=Umzqa9BWftXrktNIm+4gMHkLAyrI00CIlBZQHqwDAXrxLF/7+arwMYIg9JzHunGraSh2ssOxPEnhaD8sSgM7euuYq1ODTL1mWu3AvrTi0o+jwuef8zzK6QEkuKVTw16ze0gwv86LCUB4/6moAxUFYMiMR8fEkOVI8YBS7Eca30M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349503; c=relaxed/simple;
	bh=N9eFFLNvBeCJR5OOr+1sJq7SrsL/bh8fC3C8N+Sjc4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBMsdUtvMDkFS9JDR3TDVxwqDd6ij130RCCtJAaj4hSQIrPWIjsJqxL3P5s/ZDVt/ydRM/35v3NtEMjuUzW7QtDJ3bGldyVog4NtfccAMsZ4r//euiUWVCEpViEZgpsGr3q2NM/KC5sPom7bJiMKR4uT5fgRkqkds4p5ewzqBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M06D9tGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783BBC43390;
	Wed, 13 Mar 2024 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349503;
	bh=N9eFFLNvBeCJR5OOr+1sJq7SrsL/bh8fC3C8N+Sjc4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M06D9tGRzwYrHiiKpwtqKbvOODdTeLLSxLVM4LJFL/2/xWPEaxsOXSTTCoy/+X1dm
	 1Poupz92A4L361Cu11g61Su3XMDXXIXahD7ztTDULT7ELiwgogWRC153FSw0bvR1JJ
	 yyxUiql+q1bmsIkSTPk6F0fpy6JFA3WG0rtcHT6dcbVDfeEdIdzDOP8EipVYaRcE/d
	 VvWbMZo2LuVz4Kvg9DVgWFBk6mIDZd3Kmy6FC/jnK8du5LfrRgBoFhU2s7dQptPwt+
	 CvnkEbIp4bGOVPpn+Fza84Ex4s7tAi7hWymEb43kEWSWkSqHzpAjjbBS/ayA8aY/9/
	 jHjXnXQlz7srw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/41] netrom: Fix data-races around sysctl_net_busy_read
Date: Wed, 13 Mar 2024 13:04:17 -0400
Message-ID: <20240313170435.616724-24-sashal@kernel.org>
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
index 3277f9a7ed02b..9e48ce56f085c 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -957,7 +957,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		 * G8PZT's Xrouter which is sending packets with command type 7
 		 * as an extension of the protocol.
 		 */
-		if (sysctl_netrom_reset_circuit &&
+		if (READ_ONCE(sysctl_netrom_reset_circuit) &&
 		    (frametype != NR_RESET || flags != 0))
 			nr_transmit_reset(skb, 1);
 
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index fbfdae452ff9a..01ccd00d1c005 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -100,7 +100,7 @@ static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -131,7 +131,7 @@ static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -266,7 +266,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
-- 
2.43.0


