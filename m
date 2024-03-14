Return-Path: <linux-kernel+bounces-103553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7F87C107
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432D4B22C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE0A73538;
	Thu, 14 Mar 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/WVZGVV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3473532
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432790; cv=none; b=AoIpqi+qYzWfWlk/zW3qclPGj+Ce6pwvEYQ2uF/RVoDnMMfNsgFkj4UOxR8aa3GHSXIXVYNXfnUqdWF081Bsa8oNSo7FaUJKUgm5QRUUPlxR2P85clqM4YsWMkU2p96oEIaecQwIFGKQBKWwir5UPKnBd1bVWtZX3hNxb/NuGwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432790; c=relaxed/simple;
	bh=bp5aoEas6NU+7l0xitaBemho4peHlQ/ffehJsTxIdOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtJGZWxlLZtRHNSMsq6oaCs5FKcf1P2fVD4bgSOVhJMAvD3EjBAQIxskse+EG0zQUJoCAYpRivvKGR+vFo9dSKdnONrlrsd2u7wF5F9rLYLZW/+TIwZXGGXBOp/EckO75Cm0hi/476HlIscb0rKZlxgFXOB2j1pK31myVFA1cUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/WVZGVV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710432787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQzaqtFO0M74UqxIFZdSZlCBtuv6/tpgFRgRP1U7oaM=;
	b=S/WVZGVVBeCjsAx67AcnC6z2/HyGy3SQrPQ+q1YS6wuumD7W8G3SXXpYJetgr4LARvFDOG
	seUeHB3PrTkGheZA0eE2nbS0KLK9OP6lQBmpQvgFX2adt7g2JR0s4DnojjZCSwroKHzgqv
	65KtBc2TBm0pMjnZmIJw673NWd1pxyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-m3ax5l6zMq6oyJh6GFMyXQ-1; Thu, 14 Mar 2024 12:13:03 -0400
X-MC-Unique: m3ax5l6zMq6oyJh6GFMyXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E8448047DA;
	Thu, 14 Mar 2024 16:13:03 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5781E40C6DB3;
	Thu, 14 Mar 2024 16:13:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH v1 0/2] mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly
Date: Thu, 14 Mar 2024 17:12:58 +0100
Message-ID: <20240314161300.382526-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Derrick reports that in some cases where pread() would fail with -EIO and
mmap()+access would generate a SIGBUS signal, MADV_POPULATE_READ /
MADV_POPULATE_WRITE will keep retrying forever and not fail with -EFAULT.

It all boils down to missing VM_FAULT_RETRY handling. Let's try to handle
that in a better way, similar to how ordinary GUP handles it.

Details in patch #1. In short, move special MADV_POPULATE_(READ|WRITE)
VMA handling into __get_user_pages(), and make faultin_page_range()
call __get_user_pages_locked(), which handles VM_FAULT_RETRY. Further,
avoid the now-useless madvise VMA walk, because __get_user_pages() will
perform the VMA lookup either way.

I briefly played with handling the FOLL_MADV_POPULATE checks in
__get_user_pages() a bit differently, integrating them with existing
handling, but it ended up looking worse. So I decided to keep it simple.

Likely, we need better selftests, but the reproducer from Darrick might
be a bit hard to convert into a simple selftest.

Note that using mlock() in Darricks reproducer results in a similar
endless retry. Likely, that is not what we want, and we should handle
VM_FAULT_RETRY in populate_vma_page_range() / __mm_populate() as well.
However, similarly using __get_user_pages_locked() might be more
complicated, because of the advanced VMA handling in
populate_vma_page_range().

Further, most populate_vma_page_range() callers simply ignore the return
values, so it's unclear in which cases we expect to just silently fail, or
where we'd want to retry+fail or endlessly retry instead.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Hugh Dickins <hughd@google.com>

David Hildenbrand (2):
  mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY
    properly
  mm/madvise: don't perform madvise VMA walk for
    MADV_POPULATE_(READ|WRITE)

 mm/gup.c      | 54 ++++++++++++++++++++++++++++++---------------------
 mm/internal.h | 10 ++++++----
 mm/madvise.c  | 43 +++++++++++++---------------------------
 3 files changed, 52 insertions(+), 55 deletions(-)


base-commit: f48159f866f422371bb1aad10eb4d05b29ca4d8c
-- 
2.43.2


