Return-Path: <linux-kernel+bounces-113212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A437C88825A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF27B23B35
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9322A17F363;
	Sun, 24 Mar 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoO5OJZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795C17EB90;
	Sun, 24 Mar 2024 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320013; cv=none; b=gs9MFI9y3xxduPr2rtbMhFwYlZVRz6d5v1K07wjiKn2XAr8w1hXagosf9gA5FyH8iJ1N4icpFSQEPYIdkQxWlQo064736G3v+MbaXJxUUgvZY9BXeax7BJIPmSjqDTyKtGH6eEoWL8+N7GaXOqdwooFfKRp+REDqpfr3WcwNMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320013; c=relaxed/simple;
	bh=2hRt1La1a0cLNCTGH/9iSTwtq5WzHFv8P3BW3OtCK1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAto2Lvcz6PpWzPFT/Np8lQ3j7NKM0KVu6OTzVSxAAcKIbgAxkwEFs8iuvipaeMGuO5Wxgng3TDOAxnaDD7ya3nrs9JE7v83hq4ciyEgt56drdqwyspZCA3KvEzqVTGehUSgm6T3F0u4Xjkgdlt8I64aF5zIE6iHbHZnRn0Zfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoO5OJZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7EEC43390;
	Sun, 24 Mar 2024 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320013;
	bh=2hRt1La1a0cLNCTGH/9iSTwtq5WzHFv8P3BW3OtCK1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoO5OJZkyNNFRyj7qAvvCKYZUv+akDXKdAD9E56SSZBt9g7h1lHFzSsyxIRSg3upw
	 fIrkgsbNRylDn5qBgCZ4+ART+0UaIyVvwHt52SE+Mn4KHGBPdtpWeB+Cf9AU90hzpp
	 AzS5fzrZirbOf2gDjzILJLu+CtW5pRMFVN5cRqAbxRENPbo7NDVPxFH4pqPMX2KJMC
	 /NdTyTQcQj+rEpOCXJuog1fEjCCtIyKDRjQ6WOfRNOTvGaZXQDN5gRiZX2XutTUdl7
	 Mlh8omMXreEF60u4X/fcX1qDcqfGPVGEeeSrGOxHNeXQ34y5c8fEV+g/loEfhvb2LL
	 AxgwNkZck7xuw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 321/715] bpf: Fix stackmap overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:28:20 -0400
Message-ID: <20240324223455.1342824-322-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 7a4b21250bf79eef26543d35bd390448646c536b ]

The stackmap code relies on roundup_pow_of_two() to compute the number
of hash buckets, and contains an overflow check by checking if the
resulting value is 0. However, on 32-bit arches, the roundup code itself
can overflow by doing a 32-bit left-shift of an unsigned long value,
which is undefined behaviour, so it is not guaranteed to truncate
neatly. This was triggered by syzbot on the DEVMAP_HASH type, which
contains the same check, copied from the hashtab code.

The commit in the fixes tag actually attempted to fix this, but the fix
did not account for the UB, so the fix only works on CPUs where an
overflow does result in a neat truncation to zero, which is not
guaranteed. Checking the value before rounding does not have this
problem.

Fixes: 6183f4d3a0a2 ("bpf: Check for integer overflow when using roundup_pow_of_two()")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>
Message-ID: <20240307120340.99577-4-toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index dff7ba5397015..c99f8e5234ac4 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -91,11 +91,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	} else if (value_size / 8 > sysctl_perf_event_max_stack)
 		return ERR_PTR(-EINVAL);
 
-	/* hash table size must be power of 2 */
-	n_buckets = roundup_pow_of_two(attr->max_entries);
-	if (!n_buckets)
+	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
+	 * into UB on 32-bit arches, so check that first
+	 */
+	if (attr->max_entries > 1UL << 31)
 		return ERR_PTR(-E2BIG);
 
+	n_buckets = roundup_pow_of_two(attr->max_entries);
+
 	cost = n_buckets * sizeof(struct stack_map_bucket *) + sizeof(*smap);
 	smap = bpf_map_area_alloc(cost, bpf_map_attr_numa_node(attr));
 	if (!smap)
-- 
2.43.0


