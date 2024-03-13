Return-Path: <linux-kernel+bounces-101887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8469F87AC72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55BC1C20433
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A07A137;
	Wed, 13 Mar 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfGcCY/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2F612E6;
	Wed, 13 Mar 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348023; cv=none; b=SgeatWxqDRNQZyy+0mCh1U2EYmA41AMHR0O71reRFpc82bZSt7mEkAIaHFDc2Xd77dYJxv7qnCJhO4YMvjdbXbBPV7G/isvst38MvQoYweoRmvPwlgxk2jaGNlx6oDcBcDtnV9hqRH1TRK8XN/+VO0CH6E8nNRAQyIueMyyM790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348023; c=relaxed/simple;
	bh=1ayRbnay81uQwaBNVQbQadvJau2LtCm8yMXjEqr/Yic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=en0S4KCOFgpRdlL2cqTkmGZB1tsDs1XMgHBQQAKkNzX43yoXHJMGAweu2Z30nIJXlwpoLof5LmSYS3ht9ds8P50jSZ3lB9DWuxzMSOKklypxK9446ofCW/rxCyM3xWBC7YdZUdhofe/MTLzYnSt173yXzaDublYo30jVUZElLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfGcCY/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4518C43399;
	Wed, 13 Mar 2024 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348022;
	bh=1ayRbnay81uQwaBNVQbQadvJau2LtCm8yMXjEqr/Yic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfGcCY/49glMJ7C8fk+8kv05Y1JmW4eZtnd4o5GMHF6scpmWHWcQ0+17ZlgArlAZo
	 qa4ceX0AL81sxDgFPquFr7e0uYO9zOZkUzxPoMw3YhPFLTdVABCAYNhos3qYvq+9mW
	 vw8p6eC0TaU3l9YFyJLaWecSC9P9g2uOS72QMycLYj7aE1weEUiQY6Aj2+m3YBvUm7
	 jWe8UJw22A0mG436Sq5YyAkcEbeyQymTAF5ajKfB/oaL5a25sjqqpPF0gXiweyFi4A
	 ZZkro1YxsoiYNEhTMCjkX57i9tkt8X6G0xU54iHoLiX5qH0FqLiOu41+MM1eIRv4rp
	 TrGLKfpsD+Fjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 19/71] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 12:39:05 -0400
Message-ID: <20240313163957.615276-20-sashal@kernel.org>
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

[ Upstream commit 958d6145a6d9ba9e075c921aead8753fb91c9101 ]

We need to protect the reader reading sysctl_netrom_default_path_quality
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index baea3cbd76ca5..6f709fdffc11f 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -153,7 +153,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->digipeat = NULL;
 		nr_neigh->ax25     = NULL;
 		nr_neigh->dev      = dev;
-		nr_neigh->quality  = sysctl_netrom_default_path_quality;
+		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
 		nr_neigh->locked   = 0;
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
-- 
2.43.0


