Return-Path: <linux-kernel+bounces-114238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD861888953
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F31C27D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03516ABDB;
	Sun, 24 Mar 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa42jo1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C269138481;
	Sun, 24 Mar 2024 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321588; cv=none; b=gzlf89fbCFDrA0Gt8MP8wEPANn1t5wBrGvU+kDlzH6RSyPrJMW8nru4zjXiLVFPzIWLxq0ZsMhbZAJVtnbtJMKHxqJXEU0RwijIwrc1LJzN8R+VgZpVWYzwBBon25Clo1V1Bmx3y3PYTJbgD0gG3ImUvy3eAy3AJi5vZTliam4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321588; c=relaxed/simple;
	bh=BSB4jCWJU4ghse22gPst7g6+o8OVQyN+w/jFKOUHFEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYyetcPkcnN4Zfz3H94GW0JnBD5M3MB18871FZF3YIo7fVLS7iRtYdyz13YUTSMXxOS4m4vVPB5OAbWjEyE03ncp/RWlGjrpdANwxiRPF89lROyuqOhgRtXd/CqXFxVca8HQghPBiwxQqXwXWnKrnDhRPp7hck9JHgXuhG1eiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa42jo1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC5EC433C7;
	Sun, 24 Mar 2024 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321587;
	bh=BSB4jCWJU4ghse22gPst7g6+o8OVQyN+w/jFKOUHFEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qa42jo1/dEZdNZ0lvWQqgTdoSVUWrmpjn0LPXbuRgcOnKAPNqbfxM7jAMGD/a3EV+
	 pkHiodm8QPqN0+MMucQsxj7lDsssydj7Gfw7PE2iGpX/7Df9InXkqHl1nTdQ3Xi48x
	 eTTjGZHF2vF+5if2Zn+l1S16Zy79fuY31hpG9IZlvvj3AM2x1Vhm9lGDeKIVQZr1j2
	 K5aBs+wtS7SHfa3txR71WElQtJQQHLY5tZ2fnFFe1bZVyyr09HRDiQ5CCn6uT4EHft
	 Yxk1kajQha0WXe8ek4XvsEKtOcQZuiKrmU2bS8fJbbsyBnyM7l1L+yXE/7d99H3xEa
	 VgVxReSwdTjMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 317/638] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:55:54 -0400
Message-ID: <20240324230116.1348576-318-sashal@kernel.org>
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


