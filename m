Return-Path: <linux-kernel+bounces-93787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962B87348B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B26B1C215BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC296089F;
	Wed,  6 Mar 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egUpHwnQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C3605C8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721737; cv=none; b=qBTPSdIuZtmMmNVOwOj1ayoSoQyPSWzW+M5+DZvcwgEW5kECg5OIWWf0vIrf4lnr3gqYaBWAoIGuTB8NthTEc8XIVSMQ1n1iKhRgKDvJrL5MScKky+qJLInV094RWDAYV8D/gONdnPvZ/iR+icB5IanmQ0KsWFHiq6oITS9dFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721737; c=relaxed/simple;
	bh=PJKzqnHG6HtyEXo/aXT9kPop7Tc4xiPLd1rW13UePCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zv655Knfn9/dAb9uozgemXKibCgTi1lUidH3MIq++OCzhSo4t84lWPLLdHBOMnCVuU04OD+YlWOYGVNR/tYtzRxluRKS+tV6AgeDhrWld5cIGjiCFVInidT8Db7LkXZE4iWrsgy15aDCIpt1q8H+D4GDUuegXJ0fNm9DT5lxlDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egUpHwnQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3D9LYre9es5Pr/ZmF0ksBqg/v+REJVkPqwZxeVyu2sc=;
	b=egUpHwnQ9bOefbF/GDc94QJJh5HC1kfVnjG0cJCHvxMvVEGt3PkPR+t534oahk7QTBDodX
	MyFB0XPczxoJpgoPJvRLQM2xhNfQCwv/TINSNlBXII9AVICRN27mHrSDBC1hMeFY4J3AT0
	RpgBM7W2d1ZylU0AJfULQWzwhDZeBFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-uC-oagQgMFWs_CgooWNVxQ-1; Wed, 06 Mar 2024 05:42:11 -0500
X-MC-Unique: uC-oagQgMFWs_CgooWNVxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D81EA8007A2;
	Wed,  6 Mar 2024 10:42:10 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97C19112131D;
	Wed,  6 Mar 2024 10:42:04 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 02/13] mm/gup: Cache p4d in follow_p4d_mask()
Date: Wed,  6 Mar 2024 18:41:36 +0800
Message-ID: <20240306104147.193052-3-peterx@redhat.com>
In-Reply-To: <20240306104147.193052-1-peterx@redhat.com>
References: <20240306104147.193052-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Peter Xu <peterx@redhat.com>

Add a variable to cache p4d in follow_p4d_mask().  It's a good practise to
make sure all the following checks will have a consistent view of the entry.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index df83182ec72d..69a777f4fc5c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -772,16 +772,17 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 				    unsigned int flags,
 				    struct follow_page_context *ctx)
 {
-	p4d_t *p4d;
+	p4d_t *p4dp, p4d;
 
-	p4d = p4d_offset(pgdp, address);
-	if (p4d_none(*p4d))
+	p4dp = p4d_offset(pgdp, address);
+	p4d = READ_ONCE(*p4dp);
+	if (p4d_none(p4d))
 		return no_page_table(vma, flags);
-	BUILD_BUG_ON(p4d_huge(*p4d));
-	if (unlikely(p4d_bad(*p4d)))
+	BUILD_BUG_ON(p4d_huge(p4d));
+	if (unlikely(p4d_bad(p4d)))
 		return no_page_table(vma, flags);
 
-	return follow_pud_mask(vma, address, p4d, flags, ctx);
+	return follow_pud_mask(vma, address, p4dp, flags, ctx);
 }
 
 /**
-- 
2.44.0


