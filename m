Return-Path: <linux-kernel+bounces-115088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C94888D08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2081F2974B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF51C4AF4;
	Mon, 25 Mar 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sve8yJ3Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA71428E3;
	Sun, 24 Mar 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324074; cv=none; b=A1CdolaeXMdSALaAA2FkZmesPMNH+kAEf3oqTCbm50SSixNk0Gt4EOm6fD+mNt5tEaW96o1uQ6dbapswU1oYGtWKk7gvFyaUCBi5VSzREzMd//x1xrWrG0uxZtp/MkPlkF2SQM5knZVSpNzpTntPaVQr7ijTT7F0whFDoUoQs0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324074; c=relaxed/simple;
	bh=haepUSdHZ5S5zXDOWWKLJiizzLp2HB7y+ELmu0P1SgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ke+vLq3tnBSPrVCIGuF+e4IIpvNWT9NZ/o5MO2/14usjZZCIVclsX3FVAhvazJcyoLndpqF8MAzfN7blco55FqX+1euuoWhw6XpfRrJCJtETe2wo3+Mj0pAgiZnzk0+SIpSmCg0fPr0FzISNNR2zs9SVQZ9l3MGtKMT4RMAPMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sve8yJ3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A44BC43390;
	Sun, 24 Mar 2024 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324073;
	bh=haepUSdHZ5S5zXDOWWKLJiizzLp2HB7y+ELmu0P1SgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sve8yJ3Z79Mn3McbtbM0qkHxNtVkg3jx4W/q7CaRRFRyCflVpSNIN1/U/Jbve8tCd
	 flF8FDZeh6iQvrFhEpAJADCzH1iSOCUrzlIQHKiqaenEjzC7gdeR1VqLhg+aQ6+F+3
	 dA6nUzoNaExITEsziCTlm1Iq81oWd0IT0116ByFngJeuq8rbKlNnzXDI/xOeuLos1D
	 ZyvPVaUGI62RzvDke6mkoLhzUwHRypIXQUsUc/8M3o9sbHvQmTd7E6x4eXXvHG86pm
	 ZzfBXbD3F9DM0/dHtPGwnLHsrpyyguT0W8ZQ8dqiwyk/sEHieK6SAlq2PImvxWyg+D
	 px7KYF15KNPrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/183] bpf: Fix stackmap overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:44:46 -0400
Message-ID: <20240324234638.1355609-74-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 811071c227f11..bd8516d967453 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -111,11 +111,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
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
 	err = bpf_map_charge_init(&mem, cost + attr->max_entries *
 			   (sizeof(struct stack_map_bucket) + (u64)value_size));
-- 
2.43.0


