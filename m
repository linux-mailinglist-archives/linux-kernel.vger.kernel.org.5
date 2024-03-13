Return-Path: <linux-kernel+bounces-101962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647587AD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C8E2802BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6B13F438;
	Wed, 13 Mar 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHRAPNgf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128213EFE4;
	Wed, 13 Mar 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348171; cv=none; b=oSPjOMjW/2RWASxbgR1COQg36uUx85sH9kBgPJM/xnUjj+x5wHu3PxC7934GIajM5GrmGqPMWpA6xWF0q2x3n0W1qSpVFOup+tJbZhy6kkLSNuyPV18EfFGn0pbeshan2epdAJhbvMwWqzx0xTcb/6qmfuumzN9KnqCy1JbbF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348171; c=relaxed/simple;
	bh=JupO535FDJs874LcX2bRQiX9YuUvDP4z5KRR1MTFWag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPBbWa6rRttuwOLxm+1eV8VQZfKMH6tbkViB2ZGPKdEFHoPMlmR8GNN59gFUbLsV/jSvEsYRGXc21ariKC9t3V87f3+mwh44VM2NZ8Q/isLKnMfHPf1XotpzdyO3F6pX71IXFaLifeIN7aE91nu2wZGHDdXSsle9o4zG+TuTnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHRAPNgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D735C43394;
	Wed, 13 Mar 2024 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348171;
	bh=JupO535FDJs874LcX2bRQiX9YuUvDP4z5KRR1MTFWag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHRAPNgfAXAsch/Zh7PDup8SA1XgwNbmGPP0efN2VKV0kQOzxVnEKhXPJ2oNUt8Lx
	 hBhVE8OsWLLs/OV6/9p8eRTyAgSYcXy929Z4Wh2IJOVpKY1Ym/HF4By/yPdZQp/2qx
	 B5DNTrvMFXjF/va1TR6O0rnILicAZabe1ioQrpT7DR7wiPtXcVSONmEZOzrktB/R8u
	 xbPlK4AtnpRxvbgNSrpwsJT6IxDz2kEeT10CelGDmk7XpGORcn4iY4nZaNsdv4R8C9
	 Yjx0+1zFVk4oXY7bcv9289ZgkNuhtXSDQAB16Htj4QF80+3ubAzkUSHWZAY4JO38zm
	 Ug+M2De00r31g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 22/76] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 12:41:29 -0400
Message-ID: <20240313164223.615640-23-sashal@kernel.org>
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

[ Upstream commit 43547d8699439a67b78d6bb39015113f7aa360fd ]

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
index 5a5cca18ae0c6..76d66eb0de255 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -459,7 +459,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
 	nr->window = sysctl_netrom_transport_requested_window_size;
-- 
2.43.0


