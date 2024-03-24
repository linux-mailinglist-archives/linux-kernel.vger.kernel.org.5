Return-Path: <linux-kernel+bounces-115202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A5889352
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A4F1C2E57B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124A91CB331;
	Mon, 25 Mar 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Piv0c9kw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FD18431F;
	Sun, 24 Mar 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324279; cv=none; b=aLcjxNP7WLucV447njlS13hToSsX1W47aiGsYzsBfY+zFsfFxpDvkwAM8r15EdrO463x28PQvawAHdtVyO6HYQIoI+lyYgmicQZj+eJfqwB1ZJLGnY11LCgRiFjid27PAAciJ7q7M4gJTnvNCUweVVjzDIcWK4foyUVqeX8SF+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324279; c=relaxed/simple;
	bh=ZhE1dZQ4Yu9nivZcDGnzC9MzTKCMqaSKKsVcmNvEnMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyajHbx55i2JiCKQ3cKmkO1tHzbELuYaOBNkqnKumHfDscsJWtinZqCIH+Q163j9xg/L5GhyudgubE6dokHutIjZDO5vzg6VkD6xiJ7qB1HEl4xvcA7brAiJhDS2RD52CxkcXHryF3UwLuWvQrf7HO5/s40DTagWl1SRwTRu2Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Piv0c9kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC98C43390;
	Sun, 24 Mar 2024 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324278;
	bh=ZhE1dZQ4Yu9nivZcDGnzC9MzTKCMqaSKKsVcmNvEnMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Piv0c9kwkNPzHtDTdgaNEnL+HoeTLQIxTJqaElWtTIfOyi8Hvo8ZlJS6aE6Lreno+
	 ud+wWgOWo3IBeKEd5DucRhaLK6TWElRUgtQgw1NmI3w4IcCEFXuPNvOBALFUm4iE5j
	 WHSNdKF4IAOPzUfsqZiQkYlqgG23qkkB1Iik+LAnQzw1OacUy1+1kliU4EPUYVQaWO
	 4mJ7as8/zRP0oEJsNVdnBtaQWbpgvDofCjJ6KOB9gDnIM4wZL1gpE6CNKbsc4KCtxH
	 heTAmSy2PccMJWHyJYI9Ro7DaGV7UBpf09Eb2cnympbsHJSl84MFF1olQOfSmV3X6R
	 0tqvMYBb2IKlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/148] bpf: Fix stackmap overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:48:40 -0400
Message-ID: <20240324235012.1356413-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 92310b07cb98e..a41858db14416 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -113,11 +113,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
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
 	if (cost >= U32_MAX - PAGE_SIZE)
 		return ERR_PTR(-E2BIG);
-- 
2.43.0


