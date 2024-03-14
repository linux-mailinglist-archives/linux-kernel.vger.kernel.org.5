Return-Path: <linux-kernel+bounces-103554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1487C108
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FCF1F214A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17DC74406;
	Thu, 14 Mar 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ/NyanS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A707353B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432793; cv=none; b=uhptHeYUpdksjtTVgVl9EkAX9g9khVVVyE5kIs1T8DKYNBMUWoRcv5TemtgAVjNltyZbWKpR8S8LzdGnqNyjI4P9GacTIwhVq5XsDXvqydB1t/p5EeaJRKG0SFhqU9jklx91pOTRYoGiSSWpvaChQxy25gPXK35mA6SaHzLoYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432793; c=relaxed/simple;
	bh=ES7Q8MZl4cOkK1KxgAtSOL1DyKymQMPLDHN9/tpG3/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgQckePK0SOihC7qM3WfzEM3MEKp2wa5A1KwOCvdzLqQHH4TT20cjdmG01OglbS2weNkrIlSePTirTJbAjR/vg1heDw6cdKuepUGmFQznCx/Id7YEJs2KIjEt7j4aXjIbeS+dwHLWScanrr1bUCDIxjvMOmF/N/lV07ZuwgvEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ/NyanS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710432790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tioFn9Iuis64TbgOqSI9aPe4MpctazXkMOa/EAVTGPk=;
	b=IQ/NyanSDhxvb2Z3kN8w9ToT9wz5H01oRzsLJrPk5wylWfQxcSBYw9q3g/dCeuXERi1O8N
	XOqnipZr891w0o+MGxAOmWoXvaoJ651rlq0nL+1tIReK6QNdd20ehGoaL4wVgtGA/NSiG6
	YmKpWakfO/DkTj5lKWNnPs/QJQz6eL8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-0LIaEzhXNZS88K9aMt_lnA-1; Thu,
 14 Mar 2024 12:13:08 -0400
X-MC-Unique: 0LIaEzhXNZS88K9aMt_lnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 187293C0CF06;
	Thu, 14 Mar 2024 16:13:08 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 406F540C6CBB;
	Thu, 14 Mar 2024 16:13:06 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v1 2/2] mm/madvise: don't perform madvise VMA walk for MADV_POPULATE_(READ|WRITE)
Date: Thu, 14 Mar 2024 17:13:00 +0100
Message-ID: <20240314161300.382526-3-david@redhat.com>
In-Reply-To: <20240314161300.382526-1-david@redhat.com>
References: <20240314161300.382526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We changed faultin_page_range() to no longer consume a VMA, because
faultin_page_range() might internally release the mm lock to lookup
the VMA again -- required to cleanly handle VM_FAULT_RETRY. But
independent of that, __get_user_pages() will always lookup the VMA
itself.

Now that we let __get_user_pages() just handle VMA checks in a way that
is suitable for MADV_POPULATE_(READ|WRITE), the VMA walk in madvise()
is just overhead. So let's just call madvise_populate()
on the full range instead.

There is one change in behavior: madvise_walk_vmas() would skip any VMA
holes, and if everything succeeded, it would return -ENOMEM after
processing all VMAs.

However, for MADV_POPULATE_(READ|WRITE) it's unlikely for the caller to
notice any difference: -ENOMEM might either indicate that there were VMA
holes or that populating page tables failed because there was not enough
memory. So it's unlikely that user space will notice the difference, and
that special handling likely only makes sense for some other madvise()
actions.

Further, we'd already fail with -ENOMEM early in the past if looking up the
VMA after dropping the MM lock failed because of concurrent VMA
modifications. So let's just keep it simple and avoid the madvise VMA
walk, and consistently fail early if we find a VMA hole.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/madvise.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1a073fcc4c0c0..a2dd70c4a2e6b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -901,26 +901,19 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 		return -EINVAL;
 }
 
-static long madvise_populate(struct vm_area_struct *vma,
-			     struct vm_area_struct **prev,
-			     unsigned long start, unsigned long end,
-			     int behavior)
+static long madvise_populate(struct mm_struct *mm, unsigned long start,
+		unsigned long end, int behavior)
 {
 	const bool write = behavior == MADV_POPULATE_WRITE;
-	struct mm_struct *mm = vma->vm_mm;
 	int locked = 1;
 	long pages;
 
-	*prev = vma;
-
 	while (start < end) {
 		/* Populate (prefault) page tables readable/writable. */
 		pages = faultin_page_range(mm, start, end, write, &locked);
 		if (!locked) {
 			mmap_read_lock(mm);
 			locked = 1;
-			*prev = NULL;
-			vma = NULL;
 		}
 		if (pages < 0) {
 			switch (pages) {
@@ -1021,9 +1014,6 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	case MADV_DONTNEED:
 	case MADV_DONTNEED_LOCKED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
-	case MADV_POPULATE_READ:
-	case MADV_POPULATE_WRITE:
-		return madvise_populate(vma, prev, start, end, behavior);
 	case MADV_NORMAL:
 		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
 		break;
@@ -1425,8 +1415,16 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	end = start + len;
 
 	blk_start_plug(&plug);
-	error = madvise_walk_vmas(mm, start, end, behavior,
-			madvise_vma_behavior);
+	switch (behavior) {
+	case MADV_POPULATE_READ:
+	case MADV_POPULATE_WRITE:
+		error = madvise_populate(mm, start, end, behavior);
+		break;
+	default:
+		error = madvise_walk_vmas(mm, start, end, behavior,
+					  madvise_vma_behavior);
+		break;
+	}
 	blk_finish_plug(&plug);
 	if (write)
 		mmap_write_unlock(mm);
-- 
2.43.2


