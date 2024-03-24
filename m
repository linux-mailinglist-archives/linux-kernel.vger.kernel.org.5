Return-Path: <linux-kernel+bounces-116154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09758899BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C271C32BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1B3B266E;
	Mon, 25 Mar 2024 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdeQKA3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E9E17B4EC;
	Sun, 24 Mar 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323719; cv=none; b=nydaFNAewMx0jOfQujNoPsRBo3ULgTz55JiKMSIGelgAjsSO8FGdWP+zBJZza5RDe0dH+lgAFB5b8WcRE2C9NiVHzIQtk5rGAxdSayNQO8xQ/NsTZCPcyyx/HKVsASruCoTZiAy5hqaIVR4IbO04zym2EDtX6Y6s1NrtFLRHpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323719; c=relaxed/simple;
	bh=6iUDn5w6RDH9Plp/mSGm62Klq1xCk1zCrBh/vNrD6aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5rN0f4mR0WyLVx+TRbzBe0Ukx49nD/3ljk5pSY4JuKppiNBz6lIKUueY39S2fLIYycPxW498FJRzxsdCljfoUlj4l1E6bOEgHSQnBBmQI4iiHtfM0oMZgT2v+g9HmaMRaOus1PW0mVL6I1YdvdzmbvcbsF2EgLR014Rw6Kzgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdeQKA3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FC5C433F1;
	Sun, 24 Mar 2024 23:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323718;
	bh=6iUDn5w6RDH9Plp/mSGm62Klq1xCk1zCrBh/vNrD6aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdeQKA3SnS/v95QyFaScyv4lehmBss8v6JivBCaVj3ytMDsmF4Tm5wI3IyIcl6tPF
	 cpIsECQ6MGE83XEIcYG0qCq8DCV6dSintxXIqkpos8IzmkCyxaULNVJ8tEJfXtk1fC
	 k11hbNw8w5j6mC1TkwBmbz1Fgz9Ez0cCXvbyVls+6bkKHyQ8xFmdWfnXDWIQtVKE0L
	 IGtdHrmYOvKujgGuUbU6KPkRt7AjgTAAgLUvEDbF6n7yNSpoYpI6DF00k1w2MadSuo
	 U5nHLluzUy1xfjCeulyWK9eOq1cwevjXE7jat6FbvjCBunxqIcE544h5hklEaPBnv5
	 eYXATf3mxvvfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 092/238] bpf: Fix stackmap overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:38:00 -0400
Message-ID: <20240324234027.1354210-93-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index b8afea2ceeeb1..3ec76cb5f240d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -115,11 +115,14 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
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


