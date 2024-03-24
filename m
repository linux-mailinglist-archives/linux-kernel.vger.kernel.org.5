Return-Path: <linux-kernel+bounces-114815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFE7889176
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658891F2D53A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831E2BEC29;
	Mon, 25 Mar 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH2IMjLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60D130A68;
	Sun, 24 Mar 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323431; cv=none; b=nl9suqHzNCnnA/BxyLtxURhwUrXromF6JiljOLGjZf68DUOxZhkkamPCBO5RCZz8OXi/MXQzAjaiI1tecSwjgpdZfPfbJa6OOubLhLyYYfyXn61k/fwdU2FMmkPuwtT7IyCxGEfyvXBzbcIIU+Daiu0odT3jJUZg/0f22DCvL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323431; c=relaxed/simple;
	bh=D0joGjw/fnnGUxOcyDbl6L1fMbAAXFAAFW3iPfcU4CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwUKqXz7w/FCAKrl2MY2MNWWCIUeXxayYdkXZiPfwdKp5u2vvPOFAUZJNRL3HoEmkU5dKF0DzeiujZi4UYBWdShAyTJ98xoAwLpRJvGRoeprP4krWMa004be2mJB6mINBPdDlne1QB+hLyrpq5P/Jd4X0odc85XXz8GEZcY0Lms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH2IMjLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F30C433C7;
	Sun, 24 Mar 2024 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323431;
	bh=D0joGjw/fnnGUxOcyDbl6L1fMbAAXFAAFW3iPfcU4CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kH2IMjLwCpq2WyOA3lLAxK76aIZmhSeznwigyvFX8+jsMdreIcnnjiWPnpRZceDRZ
	 vNxUm8ofPYZ2fnLaMY2e62Y8lYn9YpvlqQuSirf3h5eqlSOR9A4hjEzQBJ8EJ3Rf8S
	 NysoZvMAUSgZ2HS0XSyA7wq+qqH4eMDvvsUxy5KN3ZMLW9OowZj69o69zCBwd9qjGG
	 q4HF83HyHOwNZhzueDSY5+n8Wp+1h/jv+bC5zLdcKdVmszuDWcgS6ghs8WpuZLmx8v
	 ptLjisWETsJEs9P6lcbKuoSI6y4BogfKEJkFwslp9f1nfhbKBNz5nRZuB/K7CwjTl9
	 TGSX4Sz+041KQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 134/317] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:31:54 -0400
Message-ID: <20240324233458.1352854-135-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 28b43642c0593..f53b4f04b935c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -504,7 +504,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -514,10 +520,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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


