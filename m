Return-Path: <linux-kernel+bounces-113784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6414888E85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50181C28F48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483DA12EBCF;
	Sun, 24 Mar 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCQ2dgoC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3531F1E3862;
	Sun, 24 Mar 2024 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320799; cv=none; b=OtrFc8yulQ5SCzzjmu2l3wPWs68uJGHYLQOwLCt+WyEL2haNcfzAyRFr8lgKRvMv4GmCFLGtEo0y+gb/kzh5KU3Avlyqcgjbe/RayZfzZxeD5fOYtsCkPrsOBtkUG7T9p4eC4tIXbOTlFSS8PpJkiKBCBOVazW116EV0kLDXXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320799; c=relaxed/simple;
	bh=2hRt1La1a0cLNCTGH/9iSTwtq5WzHFv8P3BW3OtCK1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4zFOTtZrkl3o2vx8NsJylZ1vD1NH2OXMOi/waWfHbyixMj+7hRSAb8YDdmPrTHMrW4bT4VESFJGrDNl8fCFu4VtYJMlCHwzS1OIDXh5wHzZoqesxMR0mQ4j+oxTzA/R1XQj+g9agwUrt+/eChqwBvRd20Qe7okiICRe+aA9088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCQ2dgoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C04EC433C7;
	Sun, 24 Mar 2024 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320798;
	bh=2hRt1La1a0cLNCTGH/9iSTwtq5WzHFv8P3BW3OtCK1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCQ2dgoCsnqES/pozubc09caKoEkLT6T4kuXEjx6aE9ZvpmqkojTQ/WFOvXULxgMg
	 kWbdIssXGFOvS7Xm460a0ODbGF1OCE6WIiBynnsnsXlu3vhz+UdwT1IHqjrwqQ4EFM
	 0zwqGSZ5QwCzVfKrMY/DKTPqZamaMEYoFrIEDAkQIWsTu0ZVbNV33XibKHi/OX8xp7
	 WJpOF//XTl3iLIII+cnBW77DFoI+d5Ltep4ExmOsru6DVyGqklORxSkUEKdC92ObPB
	 xP+y27HwSzJ73pSTmbZhTyccYn5TmcqefXKp52KIv5ou6dLVKRhvQ9jkfNmRxD1JSt
	 cGryO+ed7PODw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 362/713] bpf: Fix stackmap overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:41:28 -0400
Message-ID: <20240324224720.1345309-363-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


