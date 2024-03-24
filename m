Return-Path: <linux-kernel+bounces-114239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B859888F70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0EE28F9B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602F916ABE5;
	Sun, 24 Mar 2024 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMjx0sMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9613848E;
	Sun, 24 Mar 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321589; cv=none; b=e9vnNnLbZDgCsTI0X2bI6Uu+XVai3z9P1UQ1E7sYPyqKPU4N30IuEfgysgd+gFymf+Zlz8b9ECipAGpJM5n4eAH8S9imbcrTKO3jZdeQBpQtUZ8JrFuWqEuHCqnDHeQlxW2a5sh0lCZg3fiAcAWxv7QF2CeGM6ubUBVu9n8Ua8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321589; c=relaxed/simple;
	bh=cw8A2LG6a4oZo0tYO+defptfQoLZHRPmb0Ms7zyq914=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnZthdzk37WPAJZ4zDQnpnsQnC0audWRHAIImZJw7K5lhGUqEC1+v90957y/7owuNzXrIDxbheNtb/Iz9BUM1wj6JMNgeexepGHBoYAjRFfbLDm88BaEG5dV9KeI/bN6RN7YZ0vaO1HPRr344dbM1GnToVz2klGONxpns/yzUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMjx0sMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C7AC43399;
	Sun, 24 Mar 2024 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321588;
	bh=cw8A2LG6a4oZo0tYO+defptfQoLZHRPmb0Ms7zyq914=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMjx0sMHGfUgVF2hwuMIEvindKN3+ftBzoDpti+9f3nYWnC8GkYMJIl39MmYvho7K
	 1zjf5A7ykekY1itstk7vuSmBg0ycvNU7D61BfCgHXiWJ1chKOh54ZCoWp3O/ZHnA35
	 jWHW4qm3e55vAl0KgtKG/3iW1wJl4aqlOSOv/ildHCD0UfQLgmpuXtzYDhz4SDHBbW
	 L/0ps672fFlxEw5dzB76vj+ThYP1O09SLYtH5C10XuHgBATFwyFkzF5b6Uvc5DYdVg
	 pUvG36CVrNyOJNYyCJDOycCcVwXlNCYLX0R3hrJ3fsBXhWabISZ3KI80cqZ/u6G5zT
	 gZhsoxePiGfXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 318/638] bpf: Fix stackmap overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:55:55 -0400
Message-ID: <20240324230116.1348576-319-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 36775c4bc33fb..a330f38ae7335 100644
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


