Return-Path: <linux-kernel+bounces-113211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59035888259
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFD71F21D84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E8E5C8FE;
	Sun, 24 Mar 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKq+934i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B317EB75;
	Sun, 24 Mar 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320013; cv=none; b=ePWh+c4ggvHDW7h1/OYgHC8hA/rzqBQ1DwRQowyErwt6Mq5kq+7cLebbTeBFQoGiWcYrpqKRtvU85keHxsbogIVG7z4SUpvqjIw19BZ+FTFr5j6VJMU5RvA/GtIBTT551GWuX71liFMxz1VoGvgHmSr2FU8bwnIqAuOIk9wHkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320013; c=relaxed/simple;
	bh=VIbvBBzSO6jB4GlKBMOGSPLMt75A1XyStIcCo4tKvWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UweUgPQebyXGQoBHAWWEPpgfHP2WgbUJKQdLJv+3YORT9BLd0iVdPYf1El0o66ZxzURxmbGtV3ar8ru3ICM9iQk+QUjHIEqboqOETq0G6IjFzPbIsiJq5i506GYJgbtWM1oiC6/UUzqORaR7oCKYnFa7I2h54zoffD5KY+Z6juA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKq+934i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E656BC433C7;
	Sun, 24 Mar 2024 22:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320012;
	bh=VIbvBBzSO6jB4GlKBMOGSPLMt75A1XyStIcCo4tKvWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKq+934i3IiQ0A8J9tY9mOkG5pnV0jxgxj7gMetSaaLUm+x5Be7BalSbO5w1szUwy
	 GOSlr9vPC5OA6doJItwcjG0omRN5ZjehgQyOYOw2SRsXL8HONhs+HTckw09nW4uoZ4
	 Aq5hFL+yQjqbAxN/O5btp+BlS1GpML0haj8Pq7UugJoybbtqNS9OvpK1ctydQOcYPW
	 XcJGphuoaSsKIzyGshkxRFiGDUTCMA21Ibo5ET2DquJ9pXa3VVhOrCYho+uoLkXC+S
	 7MvnRU6W0UaQxrkb210WHMaKypNd0S9WPsfo7Ilwng6LJMvpdjDIFNJsnQCXSZQHIh
	 WRcBuRfRvcCQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 320/715] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:28:19 -0400
Message-ID: <20240324223455.1342824-321-sashal@kernel.org>
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
index 03a6a2500b6ab..3a088a5349bc0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -499,7 +499,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -509,10 +515,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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


