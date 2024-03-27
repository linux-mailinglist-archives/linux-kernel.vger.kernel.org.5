Return-Path: <linux-kernel+bounces-121444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415C88E7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F8129F0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06C13958C;
	Wed, 27 Mar 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUDm825e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9D12F5A1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550166; cv=none; b=HCpHnCrHfskoAm5+V/67H8f6dx/87FTye37CO+Q3j1VvHi3IvMoLaDPpabsbGxdI1vNLELIcsdhHGY4EwFPQCyAGOQpszpFbh1XH1JQ+q7RMVQ435wVUEvBidRjRUKUhEMrfIJhxEpNKJMUcsqENplmh97+0uV0RXtxIwuGKvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550166; c=relaxed/simple;
	bh=UeAqZYsUe3IQ7GIsCviVUPL+EtqXbgXMMwMwYYdSoIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vrmjm9Mww6kUo6DYS1fyoLk1w6/qup5Th8RPS+m5sxQF+JwuFwBc8fAOqh1FUKi+GO++60gM4eySCCEkiYGr5nUT6gQBp8pGLhOmS0Vod0ivXvImpv51Ek5S++YiIgxoA+AmSCmcyOju6jC0bhSRWp1o7INSrvLyn5de1IT/p1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUDm825e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711550162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5X0RnZaVOLRhMTsaeQXkHZWLQRbPQMA3qc3xVHl4o8U=;
	b=PUDm825ejTbcnYcsf5F34e1PTb0ct957DbynHdeiXpTJ4c4XB9s3NLtnmIy0edEYYqqbXa
	HDp8ZysNDvH3ipr8xU2oWzuV5YopRVJij6ID+ZV+fJ5wDmI7XfG63fIOblTsoiEAkBzQ9+
	x+eqb6anvKJxGPhN3Y6M2KKsnD3VtZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-sXFsyY-OPDebimZQwGwPig-1; Wed, 27 Mar 2024 10:35:57 -0400
X-MC-Unique: sXFsyY-OPDebimZQwGwPig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6170101A58F;
	Wed, 27 Mar 2024 14:35:55 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 245851074E;
	Wed, 27 Mar 2024 14:35:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v1] mm: optimize CONFIG_PER_VMA_LOCK member placement in vm_area_struct
Date: Wed, 27 Mar 2024 15:35:48 +0100
Message-ID: <20240327143548.744070-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Currently, we end up wasting some memory in each vm_area_struct. Pahole
states that:
	[...]
	int                        vm_lock_seq;          /*    40     4 */

	/* XXX 4 bytes hole, try to pack */

	struct vma_lock *          vm_lock;              /*    48     8 */
	bool                       detached;             /*    56     1 */

	/* XXX 7 bytes hole, try to pack */
	[...]

Let's reduce the holes and memory wastage by moving the bool:
	[...]
	bool                       detached;             /*    40     1 */

	/* XXX 3 bytes hole, try to pack */

	int                        vm_lock_seq;          /*    44     4 */
	struct vma_lock *          vm_lock;              /*    48     8 */
	[...]

Effectively shrinking the vm_area_struct with CONFIG_PER_VMA_LOCK by
8 byte.

Likely, we could place "detached" in the lowest bit of vm_lock, but at
least on 64bit that won't really make a difference, so keep it simple.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4ae4684d1add..f56739dece7a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -671,6 +671,9 @@ struct vm_area_struct {
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
+	/* Flag to indicate areas detached from the mm->mm_mt tree */
+	bool detached;
+
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
@@ -687,9 +690,6 @@ struct vm_area_struct {
 	 */
 	int vm_lock_seq;
 	struct vma_lock *vm_lock;
-
-	/* Flag to indicate areas detached from the mm->mm_mt tree */
-	bool detached;
 #endif
 
 	/*
-- 
2.43.2


