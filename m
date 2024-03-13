Return-Path: <linux-kernel+bounces-101841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7487AC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04CAB241A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED171738;
	Wed, 13 Mar 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp1aRoRC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859170CDD;
	Wed, 13 Mar 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347877; cv=none; b=l3rX2dhJMz21UkRszriPTxkWvyzRHC/Uab5ZItB12uuzP5gAsvyQ5Qqx8f7E3ceGHj+RuZ0MsAP8Rp5WYV7cU1ap5r20u8ML94Y6RMTCaPQby4jTHhJd8r9+mmXPHCpN1wtm7NSD5Q/5wOXr8u2gRomhX0mIMp2b7yMdAA1FdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347877; c=relaxed/simple;
	bh=1ayRbnay81uQwaBNVQbQadvJau2LtCm8yMXjEqr/Yic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IExQBytVvXER1C+MBfJ4mxYQTOz/LFbSCqfIEOmQFu3iOtl/Tw8VNBSyy559pAP+5a6KRCPkkNmWI9CsdXOH0kVE1054EJVN/AXAVZMv8GoXDuZ2NAGPGRoVK0uBXNaDvIIwLGa16x0S/oRciaaHYfDgyplNoeldaUYTjzOEO4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp1aRoRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412E0C433F1;
	Wed, 13 Mar 2024 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347877;
	bh=1ayRbnay81uQwaBNVQbQadvJau2LtCm8yMXjEqr/Yic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xp1aRoRC9um5issc8YWk9KsDKAsrgywLpC0nBdLXQwV1BwNAkxnORTZ16SIFAGQhu
	 D64SMhzDChkRkBB+/XbVlJVe/YAwUrRd7BxWsHBwsa+NqBIvplL8Vf1Vrp/efq84MC
	 hGjKCRxBve+lYf82kMX7koAwitHS3HpE7dZfkKkKSgqqa0B9ovLnCDbxTHtCWtUPvg
	 h63vEgsK2C7K9zSXIkpkI3Xvnf9wjoGC820lKdl9DTaUCMTunIKO9wIwK9A1ijTq5V
	 PBBtqHlf8vTT6q+QhIanvYfkVr1nHkgxSRLbBIXojJUCC8eMSgTtsKEZQ3P4ts8WWw
	 Wvww7VwRQVjRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 38/60] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 12:36:45 -0400
Message-ID: <20240313163707.615000-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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


