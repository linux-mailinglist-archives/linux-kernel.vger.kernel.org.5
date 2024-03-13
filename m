Return-Path: <linux-kernel+bounces-102043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBE87ADDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 531AFB21803
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B8152E00;
	Wed, 13 Mar 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJScZcd/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30984152DE1;
	Wed, 13 Mar 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348423; cv=none; b=oF6ACK14vYPdZUpAdjD7VS+luRywe3FCID1KBRB7su9WAVvwGjEdK22QagBdRO7c9OPF9rMIh6V6KywM0ac1QkwyadAY4q4fR/58MPS08npsLZyHmu87KB/C7o8rBhOSAKMmTwU1ssT1YCO+AOA4SyyExEBCBS/VgxfdXETfqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348423; c=relaxed/simple;
	bh=Ao3Ut6Zdwf0dKFuZsDdSVpBan8+koA7bL8+4BXg7rl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qb8F+Wok8rufBHVT5CQAZqErcqW1WHH4sq2dl/GuOhtX9TPVuilyIAUSDn5eZu5bAjPDUVFGZmA2V0nkXoaFlf/Hl2knCZtDp31Ic66fLxUwkGoY+Tfdo+F2b5jaxAWYc4SQqSc/vRJdZ0iD7Hfx2AQ0Psasr/zfOQLdaAHxBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJScZcd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50333C43394;
	Wed, 13 Mar 2024 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348423;
	bh=Ao3Ut6Zdwf0dKFuZsDdSVpBan8+koA7bL8+4BXg7rl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJScZcd/YNVN9W76kKW7vpa2ts4F9CiaUGa0u0fCLtq53LYxGo6iP5QUi4FKMI0il
	 xc9kfPhrmmwFzNYOAs69paBWHJbiNoNyZ0wZ3vb7JEHqIe3EkC0gMzytQKz56Zx1kY
	 V7xKJI/JITTNruka+Ad9CRq+4LpwVaNx3z5EDhvKQcDrDmdzv73aMi4yo+HvTc7J+A
	 2c2g5a5wgC6fX0Z3O5VoMPn7v3IoUXywN1uUoGsUNiu1PSTV2RupSN/lkho/pDed02
	 Ay87BbREv76+PYA6qalr9tx+WwS+nJkFxY3AfRTVc4VLfk39mdOS4/LG75R1zeTmcs
	 fLvKZ4NiCSmMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 18/73] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 12:45:45 -0400
Message-ID: <20240313164640.616049-19-sashal@kernel.org>
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
index 78da5eab252a0..94c4d4554b9c7 100644
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


