Return-Path: <linux-kernel+bounces-102055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6187AE06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0861C1C20C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF950155A26;
	Wed, 13 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT3XXRvk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DA15530B;
	Wed, 13 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348434; cv=none; b=NCuhb1QqvrOB+44HcGpZQ5E3S3iZdmnwagAt75LPHX474MkFw+InhMtQwDAaX7GpHVG6RogPGW05uoRKEkGYVYAaaIZVtjiV7AWbXBBhxyzQ2sfrGyrbtDrysmOFeh+ssCb4C0VGG3i9dkIZvJuzfuRa8pY3qCHY8urfocrQG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348434; c=relaxed/simple;
	bh=VOUAc+hS+8LXXjO/8xjaKP/C6ALJcpsGzO3/KKcZsro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHhLZQ+lbSjuzz6yLSILVVopCKS8/S/nd9Uv/XxADHD1TROQVnqhh1+Xcaa89SezOe93Remv8612AildYeZN/WkB2NwIXJH1aIN6coQgGJnYs5lh5tZzjdM6Np+W+lsoC4GYvwU5dEJyJ9g8oTf28Hq+V+mmd/4HHvCKva2P260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT3XXRvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51087C43390;
	Wed, 13 Mar 2024 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348434;
	bh=VOUAc+hS+8LXXjO/8xjaKP/C6ALJcpsGzO3/KKcZsro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hT3XXRvk91gKer0LC4WRjZO538Ah3PUDazs2Ul3oldCfv+f5BnQtScH9v30ESE6ds
	 z7oLwC8bEWcrwhbbWAFrOFYcJ6RAMqQcf5TrmR+uHhvTTaleN9Oc6KqJ4uy26F7HTC
	 NmWUzka1E4Z5t40K35t5/reR0ykVAQKOy1zlnLaayv/GpPv34km7qO4bn0SYSkMPIN
	 9sXgGa6vwMLFzbM4XKPOI9009m8QnebIWEnQpkzU9LbqGDHn9pU36kA4fGsuQFJ2wD
	 a5QXb5dJrgyIKuSkVRBLZaJgfMFUDMk/svWpAquZBtiTfJMjO+6suZ22AH4gXkf7Lb
	 KE9YLeRXJNCTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 29/73] netrom: Fix data-races around sysctl_net_busy_read
Date: Wed, 13 Mar 2024 12:45:56 -0400
Message-ID: <20240313164640.616049-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 69e58906c32b1..034f79d11ae11 100644
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


