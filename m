Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAA080558F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbjLENLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbjLENLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32B196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701781916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=lA1LC57CIG1UYvxhxLnR8vGzyR00OB99JPqL//oPh3w=;
        b=hP6Tzj93U24EbkZPcuntbUl2n1tE74DAp3CjSW5S8kdiW+cPy7XMdFDKtkwcyvygi3TSeZ
        KsRHdCI/RCdalR6P90QaJeq4++sJ4k87pPZgDTJI0sNJd7k6Qo0GMIf4ZYCSVnumuJAp5e
        jkOst/SQGnoi3Du1Z7JRgjO3kwv8hTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-fEU-9voGMCemfT3nMTQ7YQ-1; Tue, 05 Dec 2023 08:11:55 -0500
X-MC-Unique: fEU-9voGMCemfT3nMTQ7YQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3712ef28so41297555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 05:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701781914; x=1702386714;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lA1LC57CIG1UYvxhxLnR8vGzyR00OB99JPqL//oPh3w=;
        b=KavanYRdcPPuOrt/Ej17EwLHIZAo8ySgl2AqUYL3KLC7HqDXwiXwgoPpWS27ws4BpI
         9oMwSoJGC5D5BSLpj+nVBjt0Y3aiw52pX3fYlgG6CTP81yTVMjJdRimNPlJhjJOdFzs+
         rJhInuZ42/Pf6YJSs2PNTWrZ49dM5z5/ReNDIB9LpYQrl5Zv5E0lUXs/XBKxpdP3F6mc
         sVBpqnlH7RE9lwmdM/9yFn9xhWfFf4exUl6540kTn7la/MCJ7e6NwLFgyikpTtDzsWbX
         8ZGE/DAa0QSrnJMe6yMSjk8SNrZRykfAqRpMfYDQgHbQQPnPjwtY8cLTnu0rdwhg085j
         70wQ==
X-Gm-Message-State: AOJu0Yyw+zmUI0eM6BioCSc+KWxBmb7mEEjBdfOfzG+E0nErFMFHT0SK
        0wCGtuFZ22CCw5TUjYg4b0Nq6K13qtsftT4kAwSuALf83z3g6OKD1Z+5wgV4rB7xQ7Z+ANtn2aa
        zItqgD8yoq7KtHX6C2OliwmzZGRZpHXNkJatp5NWEDpaUO3bYJW3NF9LYCKkqpAq73LPfCOTHgA
        /IxfPM
X-Received: by 2002:a05:600c:2186:b0:40b:5e1f:6fe0 with SMTP id e6-20020a05600c218600b0040b5e1f6fe0mr413909wme.53.1701781914376;
        Tue, 05 Dec 2023 05:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrVbVKBJFVsqeuDIIobr8Ha0Ijp7Q1bbVT8GJDHM8RKhwv5E1VtcVNFviVGH/KaDEU8lUTcw==
X-Received: by 2002:a05:600c:2186:b0:40b:5e1f:6fe0 with SMTP id e6-20020a05600c218600b0040b5e1f6fe0mr413892wme.53.1701781913953;
        Tue, 05 Dec 2023 05:11:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:300:1ec7:2962:8889:ef6? (p200300cbc72f03001ec7296288890ef6.dip0.t-ipconnect.de. [2003:cb:c72f:300:1ec7:2962:8889:ef6])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040b56f2cce3sm19482616wmb.23.2023.12.05.05.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:11:53 -0800 (PST)
Message-ID: <f891079f-f1c9-4920-8804-c668df4ea5d6@redhat.com>
Date:   Tue, 5 Dec 2023 14:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-35-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231204142146.91437-35-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.23 15:21, David Hildenbrand wrote:
> The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
> remove them.
> 
> Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
> baching during fork() soon.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

This is what I currently have (- any renaming):


 From 89c3180d6bbbf2236329b405b11e6a8a3cc2c088 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Nov 2023 10:15:17 +0100
Subject: [PATCH] mm/rmap: introduce folio_try_dup_anon_rmap_[pte|ptes|pmd]()

The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
remove them.

Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
baching during fork() soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  include/linux/mm.h   |   6 --
  include/linux/rmap.h | 143 ++++++++++++++++++++++++++++++-------------
  2 files changed, 99 insertions(+), 50 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 24c1c7c5a99c0..f7565b35ae931 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1964,12 +1964,6 @@ static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
  	return folio_maybe_dma_pinned(folio);
  }
  
-static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
-					  struct page *page)
-{
-	return folio_needs_cow_for_dma(vma, page_folio(page));
-}
-
  /**
   * is_zero_page - Query if a page is a zero page
   * @page: The page to query
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 06951909bb39b..98862ab7347f2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -354,68 +354,123 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
  #endif
  }
  
-static inline void __page_dup_rmap(struct page *page, bool compound)
+static inline int __folio_try_dup_anon_rmap(struct folio *folio,
+		struct page *page, unsigned int nr_pages,
+		struct vm_area_struct *src_vma, enum rmap_mode mode)
  {
-	VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
+	bool maybe_pinned;
+	int i;
  
-	if (compound) {
-		struct folio *folio = (struct folio *)page;
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
  
-		VM_BUG_ON_PAGE(compound && !PageHead(page), page);
+	/*
+	 * If this folio may have been pinned by the parent process,
+	 * don't allow to duplicate the mappings but instead require to e.g.,
+	 * copy the subpage immediately for the child so that we'll always
+	 * guarantee the pinned folio won't be randomly replaced in the
+	 * future on write faults.
+	 */
+	maybe_pinned = likely(!folio_is_device_private(folio)) &&
+		       unlikely(folio_needs_cow_for_dma(src_vma, folio));
+
+	/*
+	 * No need to check+clear for already shared PTEs/PMDs of the
+	 * folio. But if any page is PageAnonExclusive, we must fallback to
+	 * copying if the folio maybe pinned.
+	 */
+	if (likely(mode == RMAP_MODE_PTE)) {
+		if (unlikely(maybe_pinned)) {
+			for (i = 0; i < nr_pages; i++)
+				if (PageAnonExclusive(page + i))
+					return -EBUSY;
+		}
+		do {
+			if (PageAnonExclusive(page))
+				ClearPageAnonExclusive(page);
+			atomic_inc(&page->_mapcount);
+		} while (page++, --nr_pages > 0);
+	} else if (mode == RMAP_MODE_PMD) {
+		if (PageAnonExclusive(page)) {
+			if (unlikely(maybe_pinned))
+				return -EBUSY;
+			ClearPageAnonExclusive(page);
+		}
  		atomic_inc(&folio->_entire_mapcount);
-	} else {
-		atomic_inc(&page->_mapcount);
  	}
+	return 0;
  }
  
  /**
- * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
- *			    anonymous page
- * @page: the page to duplicate the mapping for
- * @compound: the page is mapped as compound or as a small page
- * @vma: the source vma
+ * folio_try_dup_anon_rmap_ptes - try duplicating PTE mappings of a page range
+ *				  of a folio
+ * @folio:	The folio to duplicate the mappings of
+ * @page:	The first page to duplicate the mappings of
+ * @nr_pages:	The number of pages of which the mapping will be duplicated
+ * @src_vma:	The vm area from which the mappings are duplicated
   *
- * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
+ * The page range of the folio is defined by [page, page + nr_pages)
   *
- * Duplicating the mapping can only fail if the page may be pinned; device
- * private pages cannot get pinned and consequently this function cannot fail.
+ * The caller needs to hold the page table lock and the
+ * vma->vma_mm->write_protect_seq.
+ *
+ * Duplicating the mappings can only fail if the folio may be pinned; device
+ * private folios cannot get pinned and consequently this function cannot fail.
+ *
+ * If duplicating the mappings succeeded, the duplicated PTEs have to be R/O in
+ * the parent and the child. They must *not* be writable after this call.
+ *
+ * Returns 0 if duplicating the mappings succeeded. Returns -EBUSY otherwise.
+ */
+static inline int folio_try_dup_anon_rmap_ptes(struct folio *folio,
+		struct page *page, unsigned int nr_pages,
+		struct vm_area_struct *src_vma)
+{
+	return __folio_try_dup_anon_rmap(folio, page, nr_pages, src_vma,
+					 RMAP_MODE_PTE);
+}
+#define folio_try_dup_anon_rmap_pte(folio, page, vma) \
+	folio_try_dup_anon_rmap_ptes(folio, page, 1, vma)
+
+/**
+ * folio_try_dup_anon_rmap_pmd - try duplicating a PMD mapping of a page range
+ *				 of a folio
+ * @folio:	The folio to duplicate the mapping of
+ * @page:	The first page to duplicate the mapping of
+ * @src_vma:	The vm area from which the mapping is duplicated
+ *
+ * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
+ *
+ * The caller needs to hold the page table lock and the
+ * vma->vma_mm->write_protect_seq.
+ *
+ * Duplicating the mapping can only fail if the folio may be pinned; device
+ * private folios cannot get pinned and consequently this function cannot fail.
   *
- * If duplicating the mapping succeeds, the page has to be mapped R/O into
- * the parent and the child. It must *not* get mapped writable after this call.
+ * If duplicating the mapping succeeds, the duplicated PMD has to be R/O in
+ * the parent and the child. They must *not* be writable after this call.
   *
   * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
   */
+static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
+		struct page *page, struct vm_area_struct *src_vma)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	return __folio_try_dup_anon_rmap(folio, page, HPAGE_PMD_NR, src_vma,
+					 RMAP_MODE_PMD);
+#else
+	WARN_ON_ONCE(true);
+#endif
+}
+
  static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
  					 struct vm_area_struct *vma)
  {
-	VM_BUG_ON_PAGE(!PageAnon(page), page);
-
-	/*
-	 * No need to check+clear for already shared pages, including KSM
-	 * pages.
-	 */
-	if (!PageAnonExclusive(page))
-		goto dup;
+	struct folio *folio = page_folio(page);
  
-	/*
-	 * If this page may have been pinned by the parent process,
-	 * don't allow to duplicate the mapping but instead require to e.g.,
-	 * copy the page immediately for the child so that we'll always
-	 * guarantee the pinned page won't be randomly replaced in the
-	 * future on write faults.
-	 */
-	if (likely(!is_device_private_page(page) &&
-	    unlikely(page_needs_cow_for_dma(vma, page))))
-		return -EBUSY;
-
-	ClearPageAnonExclusive(page);
-	/*
-	 * It's okay to share the anon page between both processes, mapping
-	 * the page R/O into both processes.
-	 */
-dup:
-	__page_dup_rmap(page, compound);
-	return 0;
+	if (likely(!compound))
+		return folio_try_dup_anon_rmap_pte(folio, page, vma);
+	return folio_try_dup_anon_rmap_pmd(folio, page, vma);
  }
  
  /**
-- 
2.41.0


-- 
Cheers,

David / dhildenb

