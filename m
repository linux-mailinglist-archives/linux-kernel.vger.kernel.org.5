Return-Path: <linux-kernel+bounces-101881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3F287AC65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB2D286461
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22A78B66;
	Wed, 13 Mar 2024 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyO3o7U/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5B78B4A;
	Wed, 13 Mar 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348016; cv=none; b=dxwZYfDngHmlNe+wRnKdRqIVkW2eI5lltkF15mAyFMl8Z1Jj29W9BOy9fD6inaQ3V/4hZEfsgDy5a+mtvQFwwLC1WLPjZUi6dPWxukf00pX4KVVVDwMb6vrUYkVCapw688YDZd2M2HP58QM9dC1Yk8eCbPv8H3KeUpKg8HSKxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348016; c=relaxed/simple;
	bh=ybuXajKoE/4oZjZoTSRqY5XuI6zt6tVcd4UpFloBw+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xz3TlbN+Fq+oIYw4ru21kF//lLpMalvVKR6gH34UDvZQfc4v3Xhl9+WkK4F2TshQBwC8fH/6QV63hEkctGoohe/sUHLRaVozTbyd0C/7rnkjBD9cPNxOr3fDKJllYA680KeyMPubTs5PDm9WIJ5Xg3PNJXbtr/k0FVXu5m/wXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyO3o7U/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE7DC433F1;
	Wed, 13 Mar 2024 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348016;
	bh=ybuXajKoE/4oZjZoTSRqY5XuI6zt6tVcd4UpFloBw+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyO3o7U/Ix4xj7DhiGuP7PbmgeBoLQ4f64VLL4awjp5cTnCD11+MYAtCVaujwgT9h
	 LEP5d+uMPC36IF2E72H/aw4mpKtv2uADPz3qsRHzka7Hf/HkzQky5FJDYMz55bUAgN
	 nJH8PUHPgPvI4I4+PpUb3YTI2a/oFJqShBSxcdUF/EIKT3WId1SUYJ1fk4W1fUcFQN
	 F2pMLLOr4L6FOVWEWi0vgwPjRdA4AYCvIRMCBmUPcHiaZ6GlpHkTSjkthARH0j+B3d
	 jlUjp3dfpK9CsOxNbhzlu5/jUXwjzboDY5qLDpWpArbQYHJM5Yaceponuw4SfQl/Vd
	 gweYu5yCfsHkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias@aibor.de>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 13/71] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
Date: Wed, 13 Mar 2024 12:38:59 -0400
Message-ID: <20240313163957.615276-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 2487007aa3b9fafbd2cb14068f49791ce1d7ede5 ]

When running an XDP program that is attached to a cpumap entry, we don't
initialise the xdp_rxq_info data structure being used in the xdp_buff
that backs the XDP program invocation. Tobias noticed that this leads to
random values being returned as the xdp_md->rx_queue_index value for XDP
programs running in a cpumap.

This means we're basically returning the contents of the uninitialised
memory, which is bad. Fix this by zero-initialising the rxq data
structure before running the XDP program.

Fixes: 9216477449f3 ("bpf: cpumap: Add the possibility to attach an eBPF program to cpumap")
Reported-by: Tobias Böhm <tobias@aibor.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/20240305213132.11955-1-toke@redhat.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/cpumap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 08a8e81027289..0508937048137 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -222,7 +222,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
-- 
2.43.0


