Return-Path: <linux-kernel+bounces-115201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028C888DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919061C29CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4B1CB30F;
	Mon, 25 Mar 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKAm6kJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C83184314;
	Sun, 24 Mar 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324278; cv=none; b=fqPwWpv31r8ebvRju4UlMfxUOVvqA331U1RNbJZzB6o8XSFbXcVR9bI2/YOLrwUNZdQ0Oyp2J3yjbRF/8wns1HJDrri3a/sgbCRCCCyWAbbwlu5IxO3CXdpmHPcjnx1z8du5QAXNVP9i4I/lHplgnSozompa+sPliX5XEeFMVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324278; c=relaxed/simple;
	bh=QnZwcPZGcyCW/XtB6zKt3HftXxpmW+ty+R0k8p/gbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLpKuaiMgQTWfbC1nm02MgDMD8G1s5d0rNdNXuUTgOUnT4wDKUPdU3j/XyH30GsB/A1s/jzJ/VS2itL8Q8YHeDPkcFRr0IGWhVlPF5+FsUrEsMm86emEsyohUyHMpeXv2Y1dezH2NRl2qd2uT/JD5/GBBnfJcGMm2cBZg/45sEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKAm6kJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE6C433F1;
	Sun, 24 Mar 2024 23:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324277;
	bh=QnZwcPZGcyCW/XtB6zKt3HftXxpmW+ty+R0k8p/gbuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKAm6kJZG5o+Yrv12/rDm2rOu9NAK0xYYfrndCs53LrYPGEZMps7H9mddxVu+kIIg
	 AkD/yTiQo6WjQiGoqWecuyKa3flzXQgz1VKUN9os35IVDcTbDlUuxlkvqWXEV/eu6m
	 Tv8v/yws8cqvl11isxZHH6MUqK4sSCdxqLMY7WyPpltsemKnbb/F3HloIYx7diqcXT
	 8crc12GQIO9s9wiibgpk4lHgnyi9buf24MOv6QK/JKLY7m83ZjKNkgWShahGqvmC6u
	 Nt1fk2hJJP98KkJKz3CUiGafFmsUToV1zplkv8hOvrfgRyYh/1OWQP8PwaZeamTpJE
	 1e6ukPWYFUL1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/148] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:48:39 -0400
Message-ID: <20240324235012.1356413-56-sashal@kernel.org>
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
index 8e379b667a0f7..16081d8384bfc 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -330,7 +330,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -340,10 +346,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	else
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
-	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* check for u32 overflow */
+	if (htab->n_buckets > U32_MAX / sizeof(struct bucket))
 		goto free_htab;
 
 	cost = (u64) htab->n_buckets * sizeof(struct bucket) +
-- 
2.43.0


