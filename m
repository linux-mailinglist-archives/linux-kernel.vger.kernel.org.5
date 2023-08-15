Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F977D519
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239897AbjHOV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbjHOV0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDD619A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692134751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LA/KNe9RAueM9eTxmInOgxtXMAA1qFu1F1sExD6LA7g=;
        b=fu0Ij1pqmyanmlhiRtpuS+bnahwEJZDhyWZbAWYJmE9+MsfxAMhMCRoMpfHh30z0SVq/HN
        lraZRfWDlfIuoEhVlHNuLGtssGnuTLxUgm3aAtExCbedtFmWjPTzT1Iydu+irFzS4LWnYA
        3VsLl+xWK/yUEHh0HNAY/8yC6r23LLg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-cRje1ePVM8Cv1t5jh5-1RA-1; Tue, 15 Aug 2023 17:25:50 -0400
X-MC-Unique: cRje1ePVM8Cv1t5jh5-1RA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4059b5c3dd0so17917931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692134749; x=1692739549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA/KNe9RAueM9eTxmInOgxtXMAA1qFu1F1sExD6LA7g=;
        b=YokvLEd3UY4thXu6zpkKZ/06ktrXE2RjXs+3y4YgBUGBf8YvP5KhZ57AP3/N4xpB8k
         ncrShkDNDw5PWkMeiqKX4aMfsto8zXGgxyhtYjG7ZvmUHBVaDgSY5U0vmSwVVkDs7Rzt
         tIxzJ0GR2qN+XEkYn1ar/m/dZCHtPIzp8qvWzaGR67dVTc73UzFRdtHlzplJvobtW05W
         /A2FqKxjGXJWjIgCoMjVp5WEIfkGU4EGvscacMkNIlWDGcXrwI745aTUfFjY7kNDppbe
         EuTAc5fKkgITySiJh4yRgijKL5sVcea5rKuyb9BAsLXIk1y6vOV+N9DCXAXZ65/v8BOa
         0Hnw==
X-Gm-Message-State: AOJu0Yw8wuGtgkmZFpQ80VtVOsoibT0NGzIYaBePxCnkZIr+WzwWfcHc
        VB/b63l3AUUzJ6OLXX5bA4rZuX1c/4htZx8wHvssjKyXFzO00WKiEqUzgO+DIovnI4U+79+S1+v
        k/4J0JdxpAaRudI/lVS6F9eKsdw/v7IK7oy0C+rZnnraMqO7BAQqJbwPd/j+NVMn8VhzK6brJbx
        pKi+uyYA==
X-Received: by 2002:a05:622a:19a1:b0:3f6:a8e2:127b with SMTP id u33-20020a05622a19a100b003f6a8e2127bmr20518285qtc.5.1692134749412;
        Tue, 15 Aug 2023 14:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHBa7lM2k7nFCP/moqysB/BtWU5zxoKgZTm9XcpxszLJz8ZkxYyjeAst6aEvIPWdHt8/8WkQ==
X-Received: by 2002:a05:622a:19a1:b0:3f6:a8e2:127b with SMTP id u33-20020a05622a19a100b003f6a8e2127bmr20518247qtc.5.1692134748927;
        Tue, 15 Aug 2023 14:25:48 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id v10-20020ac873ca000000b0040554ed322dsm4025975qtp.62.2023.08.15.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:25:48 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v3] mm: Proper document tail pages fields for folio
Date:   Tue, 15 Aug 2023 17:25:47 -0400
Message-ID: <20230815212547.431693-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tail page struct reuse is over-comlicated.  Not only because we have
implicit uses of tail page fields (mapcounts, or private for thp swap
support, etc., that we may still use in the page structs, but not obvious
the relationship between that and the folio definitions), but also because
we have 32/64 bits layouts for struct page so it's unclear what we can use
and what we cannot when trying to find a new spot in folio struct.

It's also unclear on how many fields we can reuse for a tail page.  The
real answer is (after help from Matthew): we have 7 WORDs guaranteed on 64
bits and 8 WORDs on 32 bits.  Nothing more than that is guaranteed to even
exist.  That means nothing over page->_refcount field can be reused.

Let's document it clearly on what we can use and what we can't when
extending folio on reusing tail page fields, with explanations on each of
them.  Hopefully after the doc update it will make it easier when:

  (1) Any reader to know exactly what folio field is where and for what,
  the relationships between folio tail pages and struct page definitions,

  (2) Any potential new fields to be added to a large folio, so we're clear
  which field one can still reuse.

This is assuming WORD is defined as sizeof(void *) on any archs, just like
the other comment in struct page we already have.

The _mapcount/_refcount fields are also added for each tail page to clamp
the fields tight, with FOLIO_MATCH() making sure nothing messed up the
ordering.

Signed-off-by: Peter Xu <peterx@redhat.com>
---

rfcv1: https://lore.kernel.org/all/20230810204944.53471-1-peterx@redhat.com
rfcv2: https://lore.kernel.org/r/20230814184411.330496-1-peterx@redhat.com

No change log since it changed quite a bit; I sent patch 1 separately as
non-rfc, while I merged the rest two patches because I just noticed I can
avoid reorder the fields, so no functional change should be intended, hence
no reason to split either.

Matthew, I wanted to remove the whole chunk of comments above the tail
pages from last version (which might fall into "over-documented" category),
but at last I still kept it; not only because I found that helpful to give
me a whole picture (maybe only me?), but also it's a good place to document
a few important things (e.g., on the fact that refcnt==0 is a must for all
tails).  I'm open to removing the chunk or part of it, if you think the
rest is still ok.

This of course also conflict so far with the other series to drop
folio_order/... but I can always rebase if this is not NACKed.

Comments welcomed, thanks.
---
 include/linux/mm_types.h | 69 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 81456fa5fda5..66f1b0814334 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -324,6 +324,35 @@ struct folio {
 		};
 		struct page page;
 	};
+	/*
+	 * Some of the tail page fields may not be reused by the folio
+	 * object because they have already been used by the page struct.
+	 * On 32bits there are at least 8 WORDs while on 64 bits there're
+	 * at least 7 WORDs, all ending at _refcount field.
+	 *
+	 * |--------+-------------+-------------------|
+	 * |  index | 32 bits     | 64 bits           |
+	 * |--------+-------------+-------------------|
+	 * |      0 | flags       | flags             |
+	 * |      1 | head        | head              |
+	 * |      2 | FREE        | FREE              |
+	 * |      3 | FREE [1]    | FREE [1]          |
+	 * |      4 | FREE        | FREE              |
+	 * |      5 | FREE        | private [2]       |
+	 * |      6 | mapcnt      | mapcnt+refcnt [3] |
+	 * |      7 | refcnt [3]  |                   |
+	 * |--------+-------------+-------------------|
+	 *
+	 * [1] "mapping" field.  It is free to use but needs to be with
+	 *     some caution due to poisoning, see TAIL_MAPPING_REUSED_MAX.
+	 *
+	 * [2] "private" field, used when THP_SWAP is on (but disabled on
+	 *     32 bits, so this index is FREE on 32bit or hugetlb folios).
+	 *     May need to be fixed finally.
+	 *
+	 * [3] "refcount" field must be zero for all tail pages.  See e.g.
+	 *     has_unmovable_pages() on page_ref_count() check and comment.
+	 */
 	union {
 		struct {
 			unsigned long _flags_1;
@@ -331,18 +360,29 @@ struct folio {
 	/* public: */
 			unsigned char _folio_dtor;
 			unsigned char _folio_order;
+	/* private: 2 bytes can be reused later */
+			unsigned char _free_1_0[2];
+	/* public: */
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
+	/* private: 4 bytes can be reused later (64 bits only) */
+			unsigned char _free_1_1[4];
+	/* Currently used by THP_SWAP, to be fixed */
+			void *_private_1;
+	/* public: */
 #endif
+	/* private: */
+			atomic_t _mapcount_1;
+			atomic_t _refcount_1;
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_1;
 	};
 	union {
-		struct {
+		struct {	/* hugetlb folios */
 			unsigned long _flags_2;
 			unsigned long _head_2;
 	/* public: */
@@ -351,13 +391,22 @@ struct folio {
 			void *_hugetlb_cgroup_rsvd;
 			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
+			atomic_t _mapcount_2;
+			atomic_t _refcount_2;
 		};
-		struct {
+		struct {	/* non-hugetlb folios */
 			unsigned long _flags_2a;
 			unsigned long _head_2a;
 	/* public: */
 			struct list_head _deferred_list;
-	/* private: the union with struct page is transitional */
+	/* private: 8 more free bytes for either 32/64 bits */
+			unsigned char _free_2_2[8];
+#ifdef CONFIG_64BIT
+	/* currently used by THP_SWAP, to be fixed */
+			void *_private_2a;
+#endif
+			atomic_t _mapcount_2a;
+			atomic_t _refcount_2a;
 		};
 		struct page __page_2;
 	};
@@ -382,12 +431,26 @@ FOLIO_MATCH(memcg_data, memcg_data);
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_head, _head_1);
+#ifdef CONFIG_64BIT
+FOLIO_MATCH(private, _private_1);
+#endif
+FOLIO_MATCH(_mapcount, _mapcount_1);
+FOLIO_MATCH(_refcount, _refcount_1);
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
+FOLIO_MATCH(_mapcount, _mapcount_2);
+FOLIO_MATCH(_refcount, _refcount_2);
+FOLIO_MATCH(flags, _flags_2a);
+FOLIO_MATCH(compound_head, _head_2a);
+FOLIO_MATCH(_mapcount, _mapcount_2a);
+FOLIO_MATCH(_refcount, _refcount_2a);
+#ifdef CONFIG_64BIT
+FOLIO_MATCH(private, _private_2a);
+#endif
 #undef FOLIO_MATCH
 
 /*
-- 
2.41.0

