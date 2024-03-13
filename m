Return-Path: <linux-kernel+bounces-101856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF587AC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945CC28D5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FEA75807;
	Wed, 13 Mar 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ0DS0S+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB78757F3;
	Wed, 13 Mar 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347893; cv=none; b=YCuxkkGLY8Cb8MKZBYgTmUPgmLKWGTOXqLiWRNg5FhCoLirou5lRjOTltFbsSD9BQz/R7hHmz/E+hZT8mJ+uMnTnrDHtx0WQtgcPF5dsUu3dGs9+pfd69a4cUBNifJVaoAkA1CgmYXhnoGtAsOwIrHbXDAFVAFBkT3GgVoAYiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347893; c=relaxed/simple;
	bh=D0GiyscWZhyFGmz8dbFWduhr88O7Faca/K9usrz4a34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppZRx2T3fjWT/SG2irqeVdyweSVuLyjQWOlH2etJfiejKWH0QUNeYBkPwUklVgIPupkcqq4YUKyiWw2QyQ6621fASkd9YPY8LXUfbxAaHXZcrCOH6ls60V8GSfHtO7igLh27oJIY2OBoq0bcxyycNgcwMRxnIwvXv6OrD6Bc8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ0DS0S+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77946C433C7;
	Wed, 13 Mar 2024 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347893;
	bh=D0GiyscWZhyFGmz8dbFWduhr88O7Faca/K9usrz4a34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQ0DS0S+vLNg7xE8bC3AuODsBt+nHNcrFbOj5VoYJhE9Y9uVC7pJddrdk+P525Loe
	 ZDsvmOt7UmwEDQ5+mngmOjfhTSz9AQAqVJQgwaN+j6EhKbLZARV0OjlnwZ9zv+WNX0
	 51a6qO39MqtYnN+WmVnxKeWFJRmeE++gp7Zi5bvWWjsZ2Ddg6loHqPMNY+iwjF2Ndd
	 6luN6uDkzxy5dW8BLZ9UsIWbHIXidGLuZHuUXwNtfYtd92pmKPp3Emzf9rDKrf5JdU
	 HvNC10lbi9GkVDcKZXp0c3yoWy9TRgrTIikKMglLLtx3BhAm7abhRhQ6dVjsZrPerY
	 fWsvMS3BDcMYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Guo Xuenan <guoxuenan@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 53/60] readahead: avoid multiple marked readahead pages
Date: Wed, 13 Mar 2024 12:37:00 -0400
Message-ID: <20240313163707.615000-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ]

ra_alloc_folio() marks a page that should trigger next round of async
readahead.  However it rounds up computed index to the order of page being
allocated.  This can however lead to multiple consecutive pages being
marked with readahead flag.  Consider situation with index == 1, mark ==
1, order == 0.  We insert order 0 page at index 1 and mark it.  Then we
bump order to 1, index to 2, mark (still == 1) is rounded up to 2 so page
at index 2 is marked as well.  Then we bump order to 2, index is
incremented to 4, mark gets rounded to 4 so page at index 4 is marked as
well.  The fact that multiple pages get marked within a single readahead
window confuses the readahead logic and results in readahead window being
trimmed back to 1.  This situation is triggered in particular when maximum
readahead window size is not a power of two (in the observed case it was
768 KB) and as a result sequential read throughput suffers.

Fix the problem by rounding 'mark' down instead of up.  Because the index
is naturally aligned to 'order', we are guaranteed 'rounded mark' == index
iff 'mark' is within the page we are allocating at 'index' and thus
exactly one page is marked with readahead flag as required by the
readahead code and sequential read performance is restored.

This effectively reverts part of commit b9ff43dd2743 ("mm/readahead: Fix
readahead with large folios").  The commit changed the rounding with the
rationale:

"...  we were setting the readahead flag on the folio which contains the
last byte read from the block.  This is wrong because we will trigger
readahead at the end of the read without waiting to see if a subsequent
read is going to use the pages we just read."

Although this is true, the fact is this was always the case with read
sizes not aligned to folio boundaries and large folios in the page cache
just make the situation more obvious (and frequent).  Also for sequential
read workloads it is better to trigger the readahead earlier rather than
later.  It is true that the difference in the rounding and thus earlier
triggering of the readahead can result in reading more for semi-random
workloads.  However workloads really suffering from this seem to be rare.
In particular I have verified that the workload described in commit
b9ff43dd2743 ("mm/readahead: Fix readahead with large folios") of reading
random 100k blocks from a file like:

[reader]
bs=100k
rw=randread
numjobs=1
size=64g
runtime=60s

is not impacted by the rounding change and achieves ~70MB/s in both cases.

[jack@suse.cz: fix one more place where mark rounding was done as well]
  Link: https://lkml.kernel.org/r/20240123153254.5206-1-jack@suse.cz
Link: https://lkml.kernel.org/r/20240104085839.21029-1-jack@suse.cz
Fixes: b9ff43dd2743 ("mm/readahead: Fix readahead with large folios")
Signed-off-by: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Guo Xuenan <guoxuenan@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/readahead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3f..1d1a84deb5bc5 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -469,7 +469,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 
 	if (!folio)
 		return -ENOMEM;
-	mark = round_up(mark, 1UL << order);
+	mark = round_down(mark, 1UL << order);
 	if (index == mark)
 		folio_set_readahead(folio);
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
@@ -577,7 +577,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * It's the expected callback index, assume sequential access.
 	 * Ramp up sizes, and push forward the readahead window.
 	 */
-	expected = round_up(ra->start + ra->size - ra->async_size,
+	expected = round_down(ra->start + ra->size - ra->async_size,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
-- 
2.43.0


