Return-Path: <linux-kernel+bounces-101776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F423C87AB79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00AB28ED5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F216215F;
	Wed, 13 Mar 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc/Gyr1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5F62140;
	Wed, 13 Mar 2024 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347604; cv=none; b=ZopC52ivXnkd+2pzVqpfy5t29vxI3JPHLtx6+AK6YUtaDoZGMaEb8S8ASrTHQMZwYJm5XyQ7G8I/x3Ro8LtzYoIQfw4QWoGeCrx6gWSdmjlyDw9c6S8LC4zhfoXQC6iiSr3QcHbjOySHVR4TDQOav7OHCmVyQ8kXrdKy3DDAkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347604; c=relaxed/simple;
	bh=UY2a1ds5pIif1hu36k0hBJ9Lt+EN8fYHOb1ZFw9/1aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pI9PAKg3qXgheAugfqvcR2lpcwDvKHPxRW/G7dH/0eDyX+KwWXGei4F3EEOgWgJqokboHbOp4DDThwmHlhs3SAddo3arxqOLACi/VgArp8vjGWoZZiXkLqpbIrP08r8inqVCm+p5haCpMW3WSIodnMpgRZSwehfxAOj/bxD2Vfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc/Gyr1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B2C433B1;
	Wed, 13 Mar 2024 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347604;
	bh=UY2a1ds5pIif1hu36k0hBJ9Lt+EN8fYHOb1ZFw9/1aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qc/Gyr1G2vtskdFROmUq6JmYxKHz3HzApB5orQJCfDbatrC+Z72hb9EgOW1+4G1Oq
	 TiT1DoFgsXNrJRuiNDn7CsZiz7gVf+pHg0TOrpbSDbzp8J2AjKkH0yXvQ1/wrymAz0
	 Q5PuBoCcit9TGtoTuBbCdsnB0KQEKma8J/nqyDuOtjGvpJQFrpPqeWozULbCc1wXip
	 6M0vr1Yxrlw5m3Dtp4+taQ0fW3dYG/XX/h7IFs6t8gB9uR+DPs8vZ2HM1JiKHo2AvC
	 HTTEiBv/RATmN2bkvXSn7b90MyKBHdyVV3Q8tqyNEqNdZHsmEvgkV4UXM3+92hXpJ9
	 oZdKfFgCtMF3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	=?UTF-8?q?Tobias=20B=C3=B6hm?= <tobias@aibor.de>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 37/61] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
Date: Wed, 13 Mar 2024 12:32:12 -0400
Message-ID: <20240313163236.613880-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index 8a0bb80fe48a3..ef82ffc90cbe9 100644
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


