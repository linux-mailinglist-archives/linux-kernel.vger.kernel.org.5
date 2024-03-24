Return-Path: <linux-kernel+bounces-115933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613028898B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9341B1C31378
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8FF38CE74;
	Mon, 25 Mar 2024 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+Ri5xuz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFB12FB1B;
	Sun, 24 Mar 2024 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322133; cv=none; b=XO4zAwWUdluGR8kHnFRT2ZwfEx8luBGpHW+BdYMxZuLCtEzNd1UroTWtPxTO9J0bcx0sVCePjHrUw3rZR6QiIVlYhXG3g94wJZE2YgyfRj+23WarfRTsXmfYgGJVJFgRua1PXsEc/6bZ1hi2cmNjV13u6cwU6GYTqXrKc9i3/4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322133; c=relaxed/simple;
	bh=YpSzysfo4UAfs9cAarSrjNbmfpDubkCturvBoJbgJCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laSAdy5ivyc/kLsDxWeg9mLrxUH5qM3TF4TxeWjf6N9vPN4vpSztUnt1CF5dpA7wfE+vnkyDL4tT2GYH7UFXN0yEX6B5D6gY6wNyAaPjiGJp3deNWtlRdGVDwf+GADMqn+/MlMSfOedZCkm2oUp6xLw2ToxmuI863WymuEaKfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+Ri5xuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01822C433C7;
	Sun, 24 Mar 2024 23:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322132;
	bh=YpSzysfo4UAfs9cAarSrjNbmfpDubkCturvBoJbgJCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+Ri5xuzA+rYvpL4eXPqJfv83FpG5wG02diEqo+q1zdUBCrgn8W/nsMIqfzreoXSC
	 4x/sTFZwG/qUha34ja/ZB7WWrGOvBpR4f5DsWHr/kfAK4H1NKT30ZjSjDQOsCYX6DC
	 PME/h8XnL8vbJ9XYJDbghpxtkQLTdkdNffDiukedxbkEXHO0OdXll2ARpBADI7pBIb
	 fvs0JPgV8BVN85r4+RFoD1HfPGaJ/xw4faLNMKOt2VQ7wIZpUiUgUNkAewmtqOIXxs
	 BMA7gH825nKrFIluFRLRQs+CN4vzTOCj4ElSOlxa1riBPITvEHZlgb0opV8qBFQp43
	 yA7UNsnJX3mXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 209/451] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:08:05 -0400
Message-ID: <20240324231207.1351418-210-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 88c71de0a0a95..0c74cc9012d5c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -495,7 +495,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -505,10 +511,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
-	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* check for u32 overflow */
+	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
 	err = -ENOMEM;
-- 
2.43.0


