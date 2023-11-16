Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB597ED8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbjKPB3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbjKPB3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:29:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70101BF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700098164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m4Nmkq0cr3qM8eU/2c8RM1XZmbD+yMVfcEDigP2nYM=;
        b=MqOjT7Fci5yrpWa33B2q5gKSg1vCmiVYiKxFz5mY56b/A3vh18DQRUnsJ3ZOA6Ppv34ngf
        SdtNNqi1wVt7JMBgHWV2fY/TX7MTBfYJAWMdeuS65/M/BkEoLjNB8lWBQpo907QZKdwokz
        RK8KXwvkkeq/f4Vggm/dtwXytIv5S9k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-WEUvw7azPfWEV7Xuhjq34Q-1; Wed, 15 Nov 2023 20:29:23 -0500
X-MC-Unique: WEUvw7azPfWEV7Xuhjq34Q-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-420c7034fddso915891cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700098163; x=1700702963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m4Nmkq0cr3qM8eU/2c8RM1XZmbD+yMVfcEDigP2nYM=;
        b=DV0nlCQpnC2ux22Ay1mhabMQ5MnA5ZlP6AMDXiqLB9O4LG3tVmpAWcV7CU+v+kp4WS
         JXOCNUIBolIEOhtPTuFUsXgDo26ZH1aUwMg2+Xb3V6hIhD7+PrvO35Q7uVewUEYXKfhS
         xxqgRCJBT/Z3+p1NaSw3I+nadYR0/XQOnSS27dnUnhASmeEZOEZXQZPBTukLlPefjALc
         E4Ud/4Kg+ImdvXJYUinFjyiLEtjbDlrB9tLnaR2jZ766FjmTOuz0tlSYPOglyXj+eicp
         AmvWzy0WlPdKk68s8pbwQpvV36GOB8ACljJ6aQzPl3b9cHPtInUce6LucpeBpsS0c+0J
         P2eg==
X-Gm-Message-State: AOJu0YygplLJBAkFgFsQPSr046zRK//umVntqA7h0xxk12sSxC/E8PJZ
        eWDdJsuqBhB1PRmWLQ7uJDSFt1dhZ0ya+BwAQh6kSJ3+lGvq2NoO5Wq36KI2P0Hj1KLwltPJQnL
        EisMjOgxCsWzkXYdT6VCx7BboG1QwGIfDfk9H1CDUAceKCEvIAu2/pSJxOfClNRP76jczcG8N7p
        1RFZX8Rg==
X-Received: by 2002:ac8:1496:0:b0:421:9fe5:6dc1 with SMTP id l22-20020ac81496000000b004219fe56dc1mr6484684qtj.3.1700098163039;
        Wed, 15 Nov 2023 17:29:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEPgMVSzfIxtQlfIF+wS0OHZ+NUQWxFmPrijPw2JerykvyjqCin/P2xZqUrm2jMmgcDcZfrw==
X-Received: by 2002:ac8:1496:0:b0:421:9fe5:6dc1 with SMTP id l22-20020ac81496000000b004219fe56dc1mr6484654qtj.3.1700098162561;
        Wed, 15 Nov 2023 17:29:22 -0800 (PST)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id c24-20020ac85198000000b0041e383d527esm3922598qtn.66.2023.11.15.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 17:29:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, peterx@redhat.com,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC 07/12] mm/gup: Refactor record_subpages() to find 1st small page
Date:   Wed, 15 Nov 2023 20:29:03 -0500
Message-ID: <20231116012908.392077-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116012908.392077-1-peterx@redhat.com>
References: <20231116012908.392077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the fast-gup functions take a tail page to operate, always need to do
page mask calculations before feeding that into record_subpages().

Merge that logic into record_subpages(), so that we always take a head
page, and leave the rest calculation to record_subpages().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 424d45e1afb3..69dae51f3eb1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2763,11 +2763,14 @@ static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
 }
 #endif
 
-static int record_subpages(struct page *page, unsigned long addr,
-			   unsigned long end, struct page **pages)
+static int record_subpages(struct page *head, unsigned long sz,
+			   unsigned long addr, unsigned long end,
+			   struct page **pages)
 {
+	struct page *page;
 	int nr;
 
+	page = nth_page(head, (addr & (sz - 1)) >> PAGE_SHIFT);
 	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
 		pages[nr] = nth_page(page, nr);
 
@@ -2804,8 +2807,8 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	/* hugepages are never "special" */
 	VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pte_page(pte);
+	refs = record_subpages(page, sz, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2870,8 +2873,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pmd_page(orig);
+	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2914,8 +2917,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 					     pages, nr);
 	}
 
-	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pud_page(orig);
+	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
@@ -2954,8 +2957,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 
 	BUILD_BUG_ON(pgd_devmap(orig));
 
-	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
-	refs = record_subpages(page, addr, end, pages + *nr);
+	page = pgd_page(orig);
+	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
 	folio = try_grab_folio(page, refs, flags);
 	if (!folio)
-- 
2.41.0

