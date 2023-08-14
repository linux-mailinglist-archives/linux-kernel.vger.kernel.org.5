Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755A77BFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHNSqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjHNSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0010F4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692038659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXZG/qw2ayWAI5P15GI+5RH7awNhex4k3sDbvA4UjWg=;
        b=B8sRwKEmhT38vuT8PERxk18e8uinNXGJMc/kphOY5PtrtSu238Q8fnf5pLCn6UhaSYasDV
        S3XAEIssqm4RiuNJ9pjpV66MUSSjT97pL0HG1I9QO/pVJy2WHiwsLjtIdaoqDAMspb4q48
        CpUcHBlxrWpsb6DwnYvJZ8aTT/zFtCM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-mn3PNQf4PsSSiPtgox1FdA-1; Mon, 14 Aug 2023 14:44:18 -0400
X-MC-Unique: mn3PNQf4PsSSiPtgox1FdA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63d2b88325bso13401976d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038657; x=1692643457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXZG/qw2ayWAI5P15GI+5RH7awNhex4k3sDbvA4UjWg=;
        b=S6P0FcL5tQRq/HcqjxBZ4iByCWPtuW8f0mv3MyCgO76QiLLlh5zIfphBFbziqo8vdw
         6905vY+RW6kXE/PZZB1cTG3hWDaAlsXpbPCLXt+NK0eyrfMI4/xkY68oyllhgJLJNWgp
         fVAz5DFVv4XahLOZe3hG2mPQn/iddIRN6zAZ3elbN89N//Iq7h6o/wv0HZvKIuB1vteR
         3SwLZuqIDX0nD63MHu5dNVIOpMBXTH13XCxPqaJWVOyOlHVfUhwLgeqE2UkM4zApk4Ht
         eQZdMXxR4oHrxKR7u58omZfjfxz9GRHJw9wD5f92JqO4g5cAKRk4dzkGlZ3Bc7zZpwhD
         CR6Q==
X-Gm-Message-State: AOJu0YwUvI09nBK2EKPfccFgvRCfuakIdgMNk8JTbceI4KOX5LC8JQKE
        vMuB/7arpApI3vyaXipTxoyL6ffeyLhA5WfGcDN/meeI9DiwY6mqUpSoeS7XUNh/9e0+THKlBMb
        pNkIs6E9GH1CeVVvir+67rnK2
X-Received: by 2002:a05:6214:1d09:b0:635:d9d0:cccf with SMTP id e9-20020a0562141d0900b00635d9d0cccfmr14722031qvd.4.1692038657539;
        Mon, 14 Aug 2023 11:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNyKVLMZ66Hr3NQvsgtXcZ9D0YXzjmGtFWrY2Aeh8Bf9t6sbpvwCpEe2tOq//nQtrBk7xUeg==
X-Received: by 2002:a05:6214:1d09:b0:635:d9d0:cccf with SMTP id e9-20020a0562141d0900b00635d9d0cccfmr14722010qvd.4.1692038657287;
        Mon, 14 Aug 2023 11:44:17 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cb347000000b00630c0ed6339sm3566561qvf.64.2023.08.14.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:44:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH RFC v2 3/3] mm: Proper document tail pages fields for folio
Date:   Mon, 14 Aug 2023 14:44:11 -0400
Message-ID: <20230814184411.330496-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814184411.330496-1-peterx@redhat.com>
References: <20230814184411.330496-1-peterx@redhat.com>
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
support, etc., that we _may_ still use in the page structs, but not obvious
the relationship between that and the folio definitions), but also because
we have 32/64 bits layouts for struct page so it's unclear what we can use
and what we cannot when trying to find a new spot in folio struct.

We also have tricks like page->mapping, where we can reuse only the tail
page 1/2 but nothing more than tail page 2.  It is all mostly hidden, until
someone starts to read into a VM_BUG_ON_PAGE() of __split_huge_page_tail().

It's also unclear on how many fields we can reuse for a tail page.  The
real answer is (after help from Matthew): we have 7 WORDs guaranteed on 64
bits and 8 WORDs on 32 bits.  Nothing more than that is guaranteed to even
exist.

Let's document it clearly on what we can use and what we can't when
extending folio on reusing tail page fields, with 100% explanations on each
of them.  Hopefully after the doc update it will make it easier when:

  (1) Any reader to know exactly what field is where and for what, the
      relationships between folio tail pages and struct page definitions,

  (2) Any potential new fields to be added to a large folio, so we're clear
      which field one can still reuse.

This is assuming WORD is defined as sizeof(void *) on any archs, just like
the other comment in struct page we already have.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 41 ++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 829f5adfded1..9c744f70ae84 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -322,11 +322,40 @@ struct folio {
 		};
 		struct page page;
 	};
+	/*
+	 * Some of the tail page fields may not be reused by the folio
+	 * object because they're already been used by the page struct.  On
+	 * 32bits there're at least 8 WORDs while on 64 bits there're at
+	 * least 7 WORDs:
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
 			unsigned long _head_1;
-	/* public: */
+	/* public: WORD 2 */
 			unsigned char _folio_dtor;
 			unsigned char _folio_order;
 	/* private: 2 bytes can be reused later */
@@ -335,7 +364,7 @@ struct folio {
 	/* 4 bytes can be reused later (64 bits only) */
 			unsigned char _free_1_1[4];
 #endif
-	/* public: */
+	/* public: WORD 3 */
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
@@ -350,20 +379,20 @@ struct folio {
 		struct page __page_1;
 	};
 	union {
-		struct {
+		struct {	/* hugetlb folios */
 			unsigned long _flags_2;
 			unsigned long _head_2;
-	/* public: */
+	/* public: WORD 2 */
 			void *_hugetlb_subpool;
 			void *_hugetlb_cgroup;
 			void *_hugetlb_cgroup_rsvd;
 			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
-		struct {
+		struct {	/* non-hugetlb folios */
 			unsigned long _flags_2a;
 			unsigned long _head_2a;
-	/* public: */
+	/* public: WORD 2-3 */
 			struct list_head _deferred_list;
 	/* private: 8 more free bytes for either 32/64 bits */
 			unsigned char _free_2_1[8];
-- 
2.41.0

