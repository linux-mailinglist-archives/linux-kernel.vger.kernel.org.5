Return-Path: <linux-kernel+bounces-115674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA5788946F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097651C2D81A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D6356697;
	Mon, 25 Mar 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KleW3R0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91B137C52;
	Sun, 24 Mar 2024 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321587; cv=none; b=RShA5qID13+yWyOi10KkldqQe5+DfkyFdeLosWuoY0k3O7Ur0VFcCqX66j0w6juKiOXxtwfqKx9myynPpYZ1bT3Mf4SvsJyCi2aXVFGIFPqhlLPmSiIEXn2r8pG2zElBDoty8V7sVhh6XjQbREhmBuwCkYC3DKe4UjSyI9tihT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321587; c=relaxed/simple;
	bh=Mc/P9/6Sk5XwLDubGvWl2JOLLtczsB37LimzgM0opGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8cNm1VoAz0Bo2yvcORx7rPxeEyWqlfbl0MKHmgvSfWs9kMpqyHSXNJMMGWNP9kUqk6OTqslyg+f2QOmCt0zgdUlqh387xns7RHOF8HY/VKE25yydSLfRYgothhDr6CwsQCTH4zbeSfdFeRLuIK9O8M22J+8IHDmBtzV283giLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KleW3R0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93408C433B2;
	Sun, 24 Mar 2024 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321586;
	bh=Mc/P9/6Sk5XwLDubGvWl2JOLLtczsB37LimzgM0opGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KleW3R0zyh7TZJlhxGfjVSlzoCQ3I5ZLY5qAeElJnsp4jUw4sNAEVzCz7GXWoLIIM
	 9Wk6W4MjFZMGlyaOEoQyM4QFcoG14VRTTk2HyG+X6zyUstGxXw9rJKjZp4I9YA2zsU
	 Pi76BNQXXk/tHItqXlNh4S4cP/mX9oP9ymqBzvg71pBZKIbuiGj7eLfQ9oj2lwRi2y
	 cYG5OcVY6S+96DQRnFDtcaU8TPQTHglZcPJz/9hRuQTu+5zAO/Om16yK/V6kphTCFf
	 jM2BVPDUGKBisX5epOs+Is3At9bufqm5liBg/MVuEzhxt/Gb01cWbKAJku/goqS3dE
	 s2dKAYulgMMOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 316/638] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 18:55:53 -0400
Message-ID: <20240324230116.1348576-317-sashal@kernel.org>
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

[ Upstream commit 281d464a34f540de166cee74b723e97ac2515ec3 ]

The devmap code allocates a number hash buckets equal to the next power
of two of the max_entries value provided when creating the map. When
rounding up to the next power of two, the 32-bit variable storing the
number of buckets can overflow, and the code checks for overflow by
checking if the truncated 32-bit value is equal to 0. However, on 32-bit
arches the rounding up itself can overflow mid-way through, because it
ends up doing a left-shift of 32 bits on an unsigned long value. If the
size of an unsigned long is four bytes, this is undefined behaviour, so
there is no guarantee that we'll end up with a nice and tidy 0-value at
the end.

Syzbot managed to turn this into a crash on arm32 by creating a
DEVMAP_HASH with max_entries > 0x80000000 and then trying to update it.
Fix this by moving the overflow check to before the rounding up
operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Message-ID: <20240307120340.99577-2-toke@redhat.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 4d42f6ed6c11a..69e78dc4bb18e 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that first
+		 */
+		if (dtab->map.max_entries > 1UL << 31)
 			return -EINVAL;
-	}
 
-	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-- 
2.43.0


