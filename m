Return-Path: <linux-kernel+bounces-114983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C28892CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74AB1C2E0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0882E25FD;
	Mon, 25 Mar 2024 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP3n70xu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC917B4ED;
	Sun, 24 Mar 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323719; cv=none; b=XAgadunBiFsjPfeRIHcXkuvAOZ3xrqSVs9IXI7yWDuNvZjqpY/ZwW+nrZo8WHD3WpHoT75J0oB0HIo13CCa4mFpWZrYr5cVSNHe2/QHG6hVI4ovmgDMmi9xv9+BB9U7D3Ycf/T1LT9lSkjtb9sx76hmgd7R63nidxo5vsT8pS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323719; c=relaxed/simple;
	bh=Oi1Bgb62KQWDj6D/oPXCu6ZhtmpUecLv39W8cqWEMBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecRrV5amexSc3hW1H/rhb/o+ZHMh4331hqpR9X/Q0BhJ8vWv+GixcQEsUSorSbguvtCIbWpGVYYqzPNa/hCn+r+aQYxROTE53pxgu75dSYLpzOFV5MHlkU1eXa3GSCO6sEv4YzskS20rh3lvboXUwAFGbIa8WVHAF981mjPHX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP3n70xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5CAC43390;
	Sun, 24 Mar 2024 23:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323717;
	bh=Oi1Bgb62KQWDj6D/oPXCu6ZhtmpUecLv39W8cqWEMBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JP3n70xua6HOXEpWdCcKqDOhoi+DD0D4eR177VMbjo7VFIeuThgYlRk6EfOe1TLpn
	 PCTcz+lzkRqv6BpjJfYS/+MkQ3EuvPERtgrzzrWAQMCQokKfOr9lNAyTTLdraraZda
	 2aejzRh43Y5EkpO11oRjjOF19VjBlYUKxLQix9iLqkSPk6QogqLTMzM9Od9fTmTSdh
	 aZ02ArNuy4l6INij8FvR6dv6E0u2No9LWncLiBuwfVbBH3RNWppIQSkaCQSHJq19RG
	 GYJVrLoC3EJv2w/5cGngAvQb4GqgezmkT2ee0FcOWaaXeOSUQ+BX6OUJtEAMnyvole
	 L66O2l6Rut4PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 091/238] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:37:59 -0400
Message-ID: <20240324234027.1354210-92-sashal@kernel.org>
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
index ec84973142725..72bc5f5752543 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -443,7 +443,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -453,10 +459,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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


