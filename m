Return-Path: <linux-kernel+bounces-115087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A46C888D04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6A21F297B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AB81C3A26;
	Mon, 25 Mar 2024 01:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzZz+EZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8D2261B2;
	Sun, 24 Mar 2024 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324073; cv=none; b=sNOU11gJlv3MU5DNVbFiDzNfrhBmAuT6KBdp5qVo3QjO3w6wRYpvT9CIZ1V1TU3cK7D/IiJjieTUwWJaMsGejscwEfMQarTijiRetgDTuTmEtHOcWqHkqJhcSPFrDLWa+kdQzwn+hK4EL5G7iBVM29roROtMVvEe67nBBAodo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324073; c=relaxed/simple;
	bh=3qxOdARrpY2hq8g/cSdqLb0ed/bDJFFK2NQnVfzf07Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfP9QrwtQJeEj2R2yEkIYwaVOY6KvFTIhKLXeg+Giw+QA8gvh7LFLfWJlH3z3iXpBHZg+Erbs8u6yChrKAjNTgJcUps2i0AIO/YS/yFsPfKXe+TjdPzFWCIcOKAXfYFyzgDf3tTWIkey22t7eg5v33LpBjFkuvSxOh0AmgnQlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzZz+EZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05241C433B1;
	Sun, 24 Mar 2024 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324071;
	bh=3qxOdARrpY2hq8g/cSdqLb0ed/bDJFFK2NQnVfzf07Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzZz+EZWFkkxIKc7f6Xw/2dX7v4M2/j/MC0JruoUVAd9vConte3uybBJWAC4C09PU
	 Dw6lafi0NOZKSOIe2/2H2iRx2gmVsn/ybOPIPTxFki/gGeiuslsiHwJfZ9gRj4qA9z
	 C4Ql0NaULUn4zG4EOAcuJ/190vA/00NxJsqfIxfBIIEHzi/cICjIkqDNyz8lBPMv6k
	 VjUrepgGzv99B2r12yOFHNGiSufARvJ5fDud7fLE3dmAQeqzX3R1rjtDPEiGa9itqH
	 g6+NQlzB1qnXr2P0PKqY481rqokDyr6wwjXd6wueF7RN4a1zrUgRLk9eacHW3UED+P
	 QtSRlp/McCdBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/183] bpf: Fix hashtab overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:44:45 -0400
Message-ID: <20240324234638.1355609-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index f1dec90f3a522..34c4f709b1ede 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -327,7 +327,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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
@@ -337,10 +343,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
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


