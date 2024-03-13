Return-Path: <linux-kernel+bounces-101951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AF87AD03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30E3B248B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FED1384A8;
	Wed, 13 Mar 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzQoALsT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFB13791A;
	Wed, 13 Mar 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348159; cv=none; b=N5cSpolQIPeG5q/BHBRGFa1pcc2Lp+4w2LmKT0Ti46FvhztbVed90X03kQ+TI9uLVbaBonE+sHjX2nbxfP/7KcT7xxmpV0/8IJNsjaONyj3f858eR7ItnrcrwFM6cY3rDu8qJg0cLE9k4gALqZWrMIpy5RhMD8Wm0TnB5T6PCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348159; c=relaxed/simple;
	bh=fSzkZ1cPR6tfVQ5HUKnOSH0wQjQfYth45/o1vkdhC+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmt82xqwpcHKpnJPxEcj+NTvsfrunkEobS/Nl+q7ql5Qkm9R4JJ3fsSEjzPtDsfyGfX6z1D8gTkcna9b0fJhl0Ssgb3vEg9qkzfia4M+5EHTDVcU5eeu6U169WlPcxIfl8Tar76vIkxtl/fgyfypigETwcvhPn8rvwvuSgNatbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzQoALsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F03C433F1;
	Wed, 13 Mar 2024 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348159;
	bh=fSzkZ1cPR6tfVQ5HUKnOSH0wQjQfYth45/o1vkdhC+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dzQoALsTuDfdzWB3sknNPHPbwRwlATWIPWjjqyI03UuUeugtu89y26iJsI9dkUfkH
	 ThM2I2VLXUKxyIkpMOmsCDa1BxN6E4zJ0IjmJrbyOwMXFA3HrkZO8bcVDrRTA25xV4
	 rhxNn1F/dpDKMj0HLqx9IaBt6r3SREXeTYK6GkE4J36vbFngHeZzmzPfgahf0OF5UU
	 bEnbj2be1RfjoBDbOjpVW/FS9E9gAHgqYPWwRdKaGmgFtNB55xzxvjTE/2JARkx1mK
	 yDqSMBa703RwBj9zt3gFyXaJx7In5NY5Axlh42x/N3V21dKjA6L9Fyom8g7LsIrhYU
	 pO03LO9aolDKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias@aibor.de>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/76] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
Date: Wed, 13 Mar 2024 12:41:18 -0400
Message-ID: <20240313164223.615640-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 8d1c4b3ee7604..f7de5b313cc5b 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -221,7 +221,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
-- 
2.43.0


