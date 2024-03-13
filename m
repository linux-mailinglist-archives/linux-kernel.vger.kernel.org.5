Return-Path: <linux-kernel+bounces-101849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73787AC20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05E51C20BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1F74424;
	Wed, 13 Mar 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9fiktLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F260260;
	Wed, 13 Mar 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347885; cv=none; b=VZRxlVEToHj7+VGRHY19Zw9b+TyC/32kGkd/TcHqFwU5LTv/q2S7FGafL3dFC2UH2JRTgGrVEekRdfAbBbDaNHSmSpb5RHfDThHAbx7NReCuYRjAtg8Et+do/MNlNFQ3WFoGgQ2MhXsZcbMC2ZSeGQgaGInRhYd8pIZf3ia8Gik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347885; c=relaxed/simple;
	bh=P4In7B4cZc1rYRw52ylqcv1yXGAo/dlmBJUARwjzuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRBERuEZYJoR4eNAqdH+9wJpnwJ7tbf1buLrkoR0h05bHH0cbmf/RhLCGVyCO/TpwUm11eEtXceltTvfPjMAF04a2uCLiJxUM7Mcr7wyDl0gLgEB5FMQu3rioxzVZOdl/nluXLkLQCheAL8B1uOy4IdzuuomeTuH+OrmWshSA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9fiktLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A036C43390;
	Wed, 13 Mar 2024 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347885;
	bh=P4In7B4cZc1rYRw52ylqcv1yXGAo/dlmBJUARwjzuyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9fiktLIVZW/eWfSgLb7ci72vrl3Jpyajpn8I3ZfuC18VJTeVYvOKHwAbojnEub/k
	 RoFn67wSazSZtcezX3Nhqmhw6yQTnQdizXmfjESB/8TuHPoutc/hfNWls8GdPRz7Tc
	 qbB4y/TmBtCCwWSsLNTg3LzmcP6EZVq5DFRDZx3fpbGgEkM6rIVlZh7KgxJyENk0us
	 tMOfRMoyf/pcdngtQYGJYpL08w3LmejoS7Petn9If+nqvtP07SlFsW8tSLaWYB7vRL
	 ZLTgQ/yJI4DKI4AYab1WGeqRvuve51Ac1WhVp4xCsfMl/vl6ijjkNcpoSkhMg7RO99
	 FweRc7N0bKYlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 46/60] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 12:36:53 -0400
Message-ID: <20240313163707.615000-47-sashal@kernel.org>
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

[ Upstream commit f99b494b40431f0ca416859f2345746199398e2b ]

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
index 851c3a625768d..8c69f07651258 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -461,7 +461,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t4     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
 	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
-- 
2.43.0


