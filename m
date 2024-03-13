Return-Path: <linux-kernel+bounces-101785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433387AB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E033AB22DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FD6351E;
	Wed, 13 Mar 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbt+ixMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C88634FB;
	Wed, 13 Mar 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347614; cv=none; b=PJTqFjr4heHVgN0h/Hx8cOQMrrYIQK1truIpy2iJUkgdKCa0cHXXNTqEtuJ2vrcaVPy0HFCUTqYkOU19Ln5w+Nvz44tI8xvLtakSf3Jo0Rsmj5hvOpZ7futWiPQUaeVhn28r+BrLExDjhy3I+ZQuhK/ZMu6U0rkpmTgdCDn5O+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347614; c=relaxed/simple;
	bh=kCnXHqQDsjm1X8vpJNNRhno41su6alHx5R2Ic5AFIDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1U9ZtQyrQ8xMtkeqrJxtS7tYr9RU/t3zejLEmsqgh887uwzhHfhm5POPEAmP8dU16M/O3bpiZYqSWbmkqW0fpGE9qfZB4E1TBgTxcll1jLO4CxUXFTN9thI30Bl5HDHfvkrujQFkDrJhzNBVcrN8EOIRUpQXeAMpYyQyC26pWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbt+ixMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C29C433F1;
	Wed, 13 Mar 2024 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347614;
	bh=kCnXHqQDsjm1X8vpJNNRhno41su6alHx5R2Ic5AFIDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dbt+ixMJLMyi5//uPFz3fTnnh5F/9v/odbyJpubPxOaMDVggryaRc3Y6IhW60rAhk
	 dw5hHS27kvo+bnvOGhiGdgqJ4de9KV84DdB005VgI8ohF0d4kMN2vROCT/BUSXxIVO
	 +oqwsWwygCEhnw8VXYAhGnInhgHFIkHlWvvD7v8vnFyfpg5f3+NTcUYrByRMjEb9vb
	 7axe+GvjgLDSZlDWcet2lRw2EUGgNmcv7FCpYPCwx1jl0jGqLZjF/YZCSpAxr7lly+
	 zqk1eo5WUUewNDh83FLTrQnk7yiKwrN4KvDa6vGT/WIgZiV1eDQCWvXvp8J8fQdifZ
	 HwtFkXsG6AzAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 46/61] netrom: Fix a data-race around sysctl_netrom_transport_timeout
Date: Wed, 13 Mar 2024 12:32:21 -0400
Message-ID: <20240313163236.613880-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 60a7a152abd494ed4f69098cf0f322e6bb140612 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 0eed00184adf4..4d0e0834d527b 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -453,7 +453,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
 		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
 	nr->n2     =
-- 
2.43.0


