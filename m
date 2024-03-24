Return-Path: <linux-kernel+bounces-113783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36084888FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE51DB38726
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59312E1F1;
	Sun, 24 Mar 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yph6WyeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353271E385A;
	Sun, 24 Mar 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320798; cv=none; b=B0yBjHQzUh3S02sO76OPgvSl3Iu+Iim9LUNT3nJz/z+V4Ll77vf4YNCNDKF4/41LEJ4c6BBqcw0G/+/0E0q4E0vXwQ7Ll2GiZ6WJMMSYVwSC3RiVFhJbOIsrJcdRMTosKfwUgtjmnBkU6SA3xy+Oz37wTq3dV5jZnmfQirgsGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320798; c=relaxed/simple;
	bh=BSB4jCWJU4ghse22gPst7g6+o8OVQyN+w/jFKOUHFEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSnxGF1ZcGmcKXG73xTXYunKKDJDs3codBbdON3qjluS2Tu3SLZ5mWtoUQGrPyrhKsqFONPHt15ouY4d17LON17lUeYNgy+tNOuM7BESp+izBDlAvM+ob1SD2QLUaq5kS+h4Cs8EH86PbpSlb61xIW7spALAUliAuGZm0XLW6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yph6WyeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762F0C43394;
	Sun, 24 Mar 2024 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320797;
	bh=BSB4jCWJU4ghse22gPst7g6+o8OVQyN+w/jFKOUHFEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yph6WyeO1U78Nt4yO9fdyFZsHeXx3g4FGRZHldfP+yK8f/HtEiaeBUzAJ7cYAUtW6
	 aj+WBn1V1mcrslgtBR7z8al938gl3eiYf7y/U9UzN44jT2pc6YQBcTToWvwQHYD4dI
	 pYZbwuoUoH3W6QFmkYiWNlMFcK1bwFXpLFCQ0ZXgrnCMZK4nWiUKIAGuslV0McSO0V
	 pFIkrunCl8uWHUrmAo1nDvIP7w/pI3Xx1ot3oaGWO1uaOeBg10v+bj21T6s3G4l9gR
	 G4iTqANCbPGhYiZd7PCTNFkxljaXwCGVX0TbB2Ep8Fd9dW54enfMeXLEULuFdE/Z/P
	 Bpv/oFJgn/uBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 361/713] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:41:27 -0400
Message-ID: <20240324224720.1345309-362-sashal@kernel.org>
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

[ Upstream commit 6787d916c2cf9850c97a0a3f73e08c43e7d973b1 ]

The hashtab code relies on roundup_pow_of_two() to compute the number of
hash buckets, and contains an overflow check by checking if the
resulting value is 0. However, on 32-bit arches, the roundup code itself
can overflow by doing a 32-bit left-shift of an unsigned long value,
which is undefined behaviour, so it is not guaranteed to truncate
neatly. This was triggered by syzbot on the DEVMAP_HASH type, which
contains the same check, copied from the hashtab code. So apply the same
fix to hashtab, by moving the overflow check to before the roundup.

Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overflow and zero size checks")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Message-ID: <20240307120340.99577-3-toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5b9146fa825fd..85cd17ca38290 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -498,7 +498,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 							  num_possible_cpus());
 	}
 
-	/* hash table size must be power of 2 */
+	/* hash table size must be power of 2; roundup_pow_of_two() can overflow
+	 * into UB on 32-bit arches, so check that first
+	 */
+	err = -E2BIG;
+	if (htab->map.max_entries > 1UL << 31)
+		goto free_htab;
+
 	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
 	htab->elem_size = sizeof(struct htab_elem) +
@@ -508,10 +514,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
-	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* check for u32 overflow */
+	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
 	err = bpf_map_init_elem_count(&htab->map);
-- 
2.43.0


