Return-Path: <linux-kernel+bounces-101835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F079187AC01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915171F23289
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608556EB79;
	Wed, 13 Mar 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJqecqeB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E96EB5F;
	Wed, 13 Mar 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347870; cv=none; b=C0FeVzRMLrWdSq74BkkiQSxzmGb6GjGU8G1KcUoASucFWiU6mjgrcd1VylKr2AS2R3E/VIM55HGiUE6ws/v1MNA2XmTE2Efxw9JnDcurN6oDYppGICY/PDvfC/SsVLAB5voCEKMwGjEAvwPJFV1DUkgDOx37fWzjBkmy7rIOqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347870; c=relaxed/simple;
	bh=Yo/HHHhxiV3Tu6KdwGYQEOmUir47UXj3VDa8ETMZ9zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvNh3csO60lvmGo4Va3p9mD4HmaAkEJMnbVlZ05g3IV+tfJMj7T1BUk9TE8P+raYwWKTMrt6pCmX6cMlmALJ1MrJjuInZGt45JL+EBhcFdXA60p+JeCuPhiBU8jST+Lh6S4QYSWSPItbVpnw0N5dU6IC+WhLJ6qzQ2gk9owIKFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJqecqeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA410C43394;
	Wed, 13 Mar 2024 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347870;
	bh=Yo/HHHhxiV3Tu6KdwGYQEOmUir47UXj3VDa8ETMZ9zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJqecqeBhF7aCXArAtrHchakaQ9dalH7CP6u4hIDq12P9ZWnLNUfPVslMXSQLjim9
	 Z3vAmt2+rCI/hofqgFj9yoSDV1k3D/z61kcA3WAoZVCz1H5RNwr/J2O0udOc6fkOME
	 Aywe8yqGTh2vJuGVALZpR60dvPnt+6UzWU27nzkedZevVNuS3YgO+Bd6q7deYaL5NZ
	 WPzEZYZxq+QhBcrvgN5+h6U2J0jfVUHgT+J+7v4oJ9eXHndNUUttDIAF9ndE479Vhv
	 2LCOKtdjg5oxC/AiEFyNqgekiwMELeH6eK2XObaBlPQlAz1i7T+ohRV5wpwMBIy2YO
	 00YNBacJjigBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias@aibor.de>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 32/60] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
Date: Wed, 13 Mar 2024 12:36:39 -0400
Message-ID: <20240313163707.615000-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index e42a1bdb7f536..9140b8bff9c04 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -178,7 +178,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
-- 
2.43.0


