Return-Path: <linux-kernel+bounces-128934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7F896204
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284DF28BB90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E99817579;
	Wed,  3 Apr 2024 01:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnTw24CG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB10134B2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107977; cv=none; b=rhV2BlOEx/OZYBkvwi12lzETeQXNBMcxqppiz3Ny49t+gnZtKXuHa9yoOvy0TcJLIZOtPtUBQ5dDvdVY3THr/QKgezcHzEPsUoCvRCc1ddUN45oVws8Rn6Shf7Gt5+cLcOFl6sKWMvu77s5KP5AOiY0P+5sB1++kDpqv3hmwhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107977; c=relaxed/simple;
	bh=oqREDFbRsB5mY8hvUf0QtLekrY+T63pjwUoG14JNFrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqaBQdBrqdKwoAxtUjCJ9suf2txfBOd1+VWPmUxcgHNM59lYGIVPwvobLMiumazi6yZyBh3AS3Aindec4StlkSQYuPRUB+xqeSvd6jAANyI4O1Hq0vUuhXyGp9zQCgeldXZA4RmyEwGfQPLJzLMPHpgVh5IqebXcf8nWqyYPaGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnTw24CG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712107975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ynux/F/qmq0vm7Pu7L1906YdTD8uR3G8JQyOTFf45Q=;
	b=SnTw24CGlBD2GEd/O0lRbL+TqtSOwWsFb7SDb5byk6WTftMkGYnR0XKQ+QfyKSdWOlJYpX
	gNYAxP+pJ210eOtg6s9evIs7knx0alS1WM37+WjToeEmKr6hQ14Y+a72zRy/G95rWwIwi5
	vR7w4u95bvhPpmx5lZvuGhVOl+R1A4c=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-Co_-N685O5uFN6fq81JDJw-1; Tue, 02 Apr 2024 21:32:53 -0400
X-MC-Unique: Co_-N685O5uFN6fq81JDJw-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4d8837d610fso904742e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 18:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712107973; x=1712712773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ynux/F/qmq0vm7Pu7L1906YdTD8uR3G8JQyOTFf45Q=;
        b=kmatSzGV8KszFpK838VWBvz8q6hOk5OhwLJqjXHkghyTACnjAL4We0R38Xln2zZPgo
         LehAWrWgM7FuOpcUS+kIakT06XVY13xN6om+lrcMenewbRqbL4+/PuvE++uZajAyAJ/L
         dz1PLnWPLVE1p8LVEGwBGAeGEVwCqN9A7xy/NCPi7fKPbKrbUCSoCVI3H9jTOFih1TVT
         vlNLhLei+fb+cHbtvyyBHblz0BL8B3vWx5EbB1mCAF+1E83neK+lykdj0HJ3bb2vfiTU
         JAxbuBYaaAF/09+mgb7e7VLut2MqsqbJ2W9n4SUHfr/42n7O67St+iweYhiVOnyJdZ8N
         UFiA==
X-Forwarded-Encrypted: i=1; AJvYcCVIcA3GwENPX6h26PQjbi4prLmEqyPVYQo6rk+z3tOz59k5qo04UOC9PYHdGXzbNJkbvJhYSx2JgYIARGKYyWWZIIP/mIAb9SGtaNnu
X-Gm-Message-State: AOJu0YyN/o/q95Ou8u0j8aD/o7lzmI3TqNpilbqELxKKcebclsYkPY36
	68BESXLq1x37/grpeX8owHkct9wZ0ejrRRC2/ep6FzKNgLHW+WZ2dj5DShhhO6E22hqELIrFpR3
	GvA9AALRnhSvRFfcjxX1BB9SRtgjnlwXeCr461LsFV8aOw2pZW3WDSwcq3a6UVg==
X-Received: by 2002:a05:6102:588c:b0:478:9533:a75a with SMTP id ju12-20020a056102588c00b004789533a75amr2155412vsb.1.1712107972841;
        Tue, 02 Apr 2024 18:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9+hYqxzCimkmspOuHcmCsRdwFLI47CvtrgBTMbK0H1Qo/OVIYE/CpCTqBmVGSH1xwK+vwHQ==
X-Received: by 2002:a05:6102:588c:b0:478:9533:a75a with SMTP id ju12-20020a056102588c00b004789533a75amr2155389vsb.1.1712107972182;
        Tue, 02 Apr 2024 18:32:52 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068ff8bda6c7sm6031687qvb.92.2024.04.02.18.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 18:32:51 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Ryan Roberts <ryan.roberts@arm.com>,
	loongarch@lists.linux.dev
Subject: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail pages
Date: Tue,  2 Apr 2024 21:32:47 -0400
Message-ID: <20240403013249.1418299-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403013249.1418299-1-peterx@redhat.com>
References: <20240403013249.1418299-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

PageAnonExclusive() used to forbid tail pages for hugetlbfs, as that used
to be called mostly in hugetlb specific paths and the head page was
guaranteed.

As we move forward towards merging hugetlb paths into generic mm, we may
start to pass in tail hugetlb pages (when with cont-pte/cont-pmd huge
pages) for such check.  Allow it to properly fetch the head, in which case
the anon-exclusiveness of the head will always represents the tail page.

There's already a sign of it when we look at the fast-gup which already
contain the hugetlb processing altogether: we used to have a specific
commit 5805192c7b72 ("mm/gup: handle cont-PTE hugetlb pages correctly in
gup_must_unshare() via GUP-fast") covering that area.  Now with this more
generic change, that can also go away.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/page-flags.h |  8 +++++++-
 mm/internal.h              | 10 ----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 888353c209c0..225357f48a79 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1095,7 +1095,13 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
 static __always_inline int PageAnonExclusive(const struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
-	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	/*
+	 * Allow the anon-exclusive check to work on hugetlb tail pages.
+	 * Here hugetlb pages will always guarantee the anon-exclusiveness
+	 * of the head page represents the tail pages.
+	 */
+	if (PageHuge(page) && !PageHead(page))
+		page = compound_head(page);
 	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 9512de7398d5..87f6e4fd56a5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1259,16 +1259,6 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
 		smp_rmb();
 
-	/*
-	 * During GUP-fast we might not get called on the head page for a
-	 * hugetlb page that is mapped using cont-PTE, because GUP-fast does
-	 * not work with the abstracted hugetlb PTEs that always point at the
-	 * head page. For hugetlb, PageAnonExclusive only applies on the head
-	 * page (as it cannot be partially COW-shared), so lookup the head page.
-	 */
-	if (unlikely(!PageHead(page) && PageHuge(page)))
-		page = compound_head(page);
-
 	/*
 	 * Note that PageKsm() pages cannot be exclusive, and consequently,
 	 * cannot get pinned.
-- 
2.44.0


