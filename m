Return-Path: <linux-kernel+bounces-115932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C068898B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065561C2699C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232338CE60;
	Mon, 25 Mar 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRZSKrOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40A149017;
	Sun, 24 Mar 2024 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322132; cv=none; b=WriSmSgucSphAIKKlaO1e/HhKJBk2+SIY1PcFOG+O/s0gCHrd3GLGnzpkey5rCHXbUpxotkPneq+PdRPWjiYsPpfYYudXIkgMiFZU7jNSlaqf6+7bbB8Ffqu3YMHJa9ZxLz+anIewBsRqCc4/tUqhUh3Dp0eJSyEzS7lAVmPQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322132; c=relaxed/simple;
	bh=h6ZYwpSBwtXJoNRDtu4RvndFREm1RakT/c8crUpd+T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIyUaFVvS1v/BdSehf0TEiZEFqAcbuBa7HVYGy6+h+jdtIebh1SLf97RudMu1h+GzGXBWDpvpX0Sk3P2DJpkegVf+Fl583M8EdUgyCLQzRJs263u5G/mYWpLudhT1KwpGX0W8e9ztHk889rt8blvQ6f6CsCBzzY3NZVfnyXwGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRZSKrOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000FFC433F1;
	Sun, 24 Mar 2024 23:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322131;
	bh=h6ZYwpSBwtXJoNRDtu4RvndFREm1RakT/c8crUpd+T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRZSKrOm93A2OcskCFRzOt8x7t3pGcHn6B6AmfyfvYDvWmkcqLzWPsH+4O4rYi9XC
	 imc2LxQiI3t/MqpXMpO02avTi1KN646jcv8Pjn4JFBqc0yW4+gbKPitige47xubWWr
	 MtG82l3JhkZwdNYMMFW8+ROOC4XtKDc9gdE1NufYtRDZ3jkehoWw4ClSKpnTaYd2Hh
	 yc3BrJo48h8O0DAXt0riefRLcYMGZZSzWz/nTzOKz71zFLr9aypoOeUa4nzBOpamnL
	 63LeOg7NXcfM2glzIwNKyGR2ROeRO7cffUmCFbBaYlID8IYA8IWqYlTCof26MVOuOb
	 gvIry1tv8qPPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 208/451] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Sun, 24 Mar 2024 19:08:04 -0400
Message-ID: <20240324231207.1351418-209-sashal@kernel.org>
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
index f9a87dcc5535b..e051cbb07dac0 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -131,13 +131,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
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


