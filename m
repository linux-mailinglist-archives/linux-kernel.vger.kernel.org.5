Return-Path: <linux-kernel+bounces-102038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0D87ADCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8A11F27BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF703151CCD;
	Wed, 13 Mar 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9HaoHOs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAA151779;
	Wed, 13 Mar 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348419; cv=none; b=ZMOUVUrkz2A7U5RRJ/xP/RHiAN93JoxSmAcxZm5diwQPtRB/kByVyrluEA7EcFg8emm0KXyFlypHxlXmzKtw8aeOj/zqZ9C1bkhwMr6dn+bk/zkdb62KYmAWjkRJCrKeEaYqbwZvMS+7xZYyVWO0Dt0SJGWM4epQwbM+veE/S1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348419; c=relaxed/simple;
	bh=zlG8DVa0z/JC9OL++FL1QnHN99NG2yDrykYETr5qrCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QISXZb1GDSrj4i3e5mEQO43nn+Bh6kCJ4LLwqdxKSELkGjxz91Fwx/4+UPqB4yCgaBhYZQobWJUfMhQ6QOUC0LsHQlNTmjVKEYRQabY1bifqfV9YIQ7uMmkMUdgDUS9okGAhHz4cPXlKB1CBjK142VpfJmIgUAgUWtIzq/AoEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9HaoHOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17595C433A6;
	Wed, 13 Mar 2024 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348418;
	bh=zlG8DVa0z/JC9OL++FL1QnHN99NG2yDrykYETr5qrCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9HaoHOs8WDHW/WklbsLptRQToHCVxXhc3VE/bIfVrLlvORzeMpS591Y0Z5hZlQRy
	 9k2G8SMo/vk1sP2wUNs9QcFNRy+6qNW8huB/+CLxNrCXvRBXUSppn+bTUp8rsjVDht
	 OsUXT758P1ANRpTf2oL9a1gKlFZmIVg5GFh8eBJHuS0WHs7+ddxMmgXJaa0gTnREak
	 57Bnfh+QZuGObwXfN2l25A0Ds6W3jyZy8af9pIN1R9vReF7MLfAkk+CdsJcbcF8Z78
	 s/5HOOpQg+FWYaxI8/rBb6TFYDlOK2iFTP3ALVqOOqoFX35AVjFVgyDdR+GSnUysFB
	 VzkhoOzlbNq3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias@aibor.de>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 14/73] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
Date: Wed, 13 Mar 2024 12:45:41 -0400
Message-ID: <20240313164640.616049-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index c61a23b564aa5..2dcc04b2f330e 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -229,7 +229,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
-- 
2.43.0


