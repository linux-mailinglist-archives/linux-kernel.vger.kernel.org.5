Return-Path: <linux-kernel+bounces-102145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13BD87AECC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2F12842CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D6745D5;
	Wed, 13 Mar 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up+/lUsU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7547442F;
	Wed, 13 Mar 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349361; cv=none; b=Av3sL9/73TizwbuaXs3M1aja8NnPk3CnsIxRHC9sV0kmlPrcIInlzjmvvKXZxAH94yz+pR42yq3i86RLWK9pwZNcDORwmU/6LS1YOj1EB7ybwrVtx8nJMJQ4C+svOrZYF1GAFjKqbZ+ZohCni3Nq/ahZ/z8aS05f7ht0WLBDyKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349361; c=relaxed/simple;
	bh=czvRIDeSrj7wwrFEdr0oP/W3xIJ/FE8CNCPsTfV2OgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixieBzKwD6CbZdJfF85an5J2A+B+NGSGB5ZnOM3wNCwdrpiNKos4wr88UybxP1DUyp8Qmyr+lIqH9fUh4lZCoacQ6LFs9jh/ZOaqLBoQXDql8D2HUXlhcGLx4C3YG5aeDBF0s/1ca5CHaIQ6qx6edzrnDMAV2vi/BdSPMMPY6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up+/lUsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D66C433C7;
	Wed, 13 Mar 2024 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349360;
	bh=czvRIDeSrj7wwrFEdr0oP/W3xIJ/FE8CNCPsTfV2OgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=up+/lUsU9NEj81VVekISqzp/++ExEJJ0ZgFTMqsiUvTxqseaWgSwnJMdn3nY2XHAe
	 1M/Ay4TBJ6e0Vo+19nqIc2+U0DEN+Woj+RQaTcXrDFv6jy81sINHD0uXe+3OIoyC6z
	 yb8igoUGlrOrsDBOiAmL4zdAyvmH/vUY9XCs3kjF4YgbQsyXBEjM7DZvOTqUMOCGgS
	 d9zCnO/Hi5WDkYA2DJCgKbaAv1jG8YEpfwK+bIY7PD9K/UnVrQYkhFNb6j9BFfupwa
	 gltkQGKPrp8gkjUulkL5KZ0HS+nwmtgbT3njP2vZYXMHc5zPPuk1qACQr2K5bTZqfk
	 zYTwSPkbrkojw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 24/51] netrom: Fix data-races around sysctl_net_busy_read
Date: Wed, 13 Mar 2024 13:01:45 -0400
Message-ID: <20240313170212.616443-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index e25bb0fe6d13c..abb69c149644a 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -932,7 +932,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		 * G8PZT's Xrouter which is sending packets with command type 7
 		 * as an extension of the protocol.
 		 */
-		if (sysctl_netrom_reset_circuit &&
+		if (READ_ONCE(sysctl_netrom_reset_circuit) &&
 		    (frametype != NR_RESET || flags != 0))
 			nr_transmit_reset(skb, 1);
 
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 2bef3779f8935..8cbb57678a9ea 100644
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
 
@@ -263,7 +263,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
-- 
2.43.0


