Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07A75E594
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGWWfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjGWWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:35:15 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60CCE5C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:35:13 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57a551ce7e9so47002207b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690151713; x=1690756513;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUSbSB2mCMfMFHAYxwRiQA3gIugwk2fGEbZY8GkEjTo=;
        b=3D27d8ya3vH0G/T1jCu15x5AB5T1ggT7k5ACBc7anAc8xRgePijSQXSDiSm43Rtdh1
         kx0UzJnzgxBuY1qbYtXNkgP13NjfozHbR3s5RL7gEp/LqfrpbQMKGmbsjPIaxORFr1cn
         g3q7oTpKvwP6F6pOMrUCrCmobjOeS4eLDXeFPDDj+Tq3VFAXi+uglQvkX5ElcZp2o06/
         D9us/8JBSWfFkbtl/MPsnAA2aeXKMk3gFJ1Tdu2RXf584E+VT51mNdtOUO1BMd3X4iwk
         Hec7/X8hj5u47rEw4cY/omhxJZJMKe3jU3Jpzpr11vI7NFWmcQMEo/DbeQo01HQvoy1p
         B6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690151713; x=1690756513;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUSbSB2mCMfMFHAYxwRiQA3gIugwk2fGEbZY8GkEjTo=;
        b=kt0iv322cgnxoBZNt1o5NBbNeYII0jSySWMGkXahs33Ym5uL7aOiAdXirvREo8w7ic
         zgdReip3Y9E9+hxA3dnRsbakfyM5u4keORCQbCLUshUBuuLPEzPvElUAQWf7dW0AIcQy
         +zU0R9I4qYeuy/XpatUqk6Jx8wYFScehCAE/UD70UcniA2sa9G6ok5lVfzSZWNt46k4g
         FbcU7kwiQwJSvVcMQ5Y9D8nFyrjFRZQG0cY8pYLNLNKJ/kNt/kFroO3kep1+8cpZQ5UA
         XfCwBDrnA9bcRO5ubeGBtV5TjiocYkIUX1YMauipCwChx9LFwiIaPL4ARWjZ9yw5zvpu
         ArOw==
X-Gm-Message-State: ABy/qLbozL7oct2LEJ1CgiaaZR7MZEihCyXYzfowbeeksBX/lH/pE2cT
        7pXCpK2gXe21p5fSckqBYmqqRQ==
X-Google-Smtp-Source: APBJJlHu4gcYD0JKCreqQkRpf7N8PwoJpBQrx7bHnSSrbqs6cYtIiCQ7XOr0psELtSbwDmhcixB5CQ==
X-Received: by 2002:a81:88c6:0:b0:579:ed5f:5cd3 with SMTP id y189-20020a8188c6000000b00579ed5f5cd3mr5903716ywf.23.1690151712917;
        Sun, 23 Jul 2023 15:35:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q2-20020a0de702000000b00565271801b6sm2442804ywe.59.2023.07.23.15.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:35:12 -0700 (PDT)
Date:   Sun, 23 Jul 2023 15:35:07 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 11/13 fix] mm/khugepaged: delete khugepaged_collapse_pte_mapped_thps():
 fix
In-Reply-To: <a5dce57-6dfa-5559-4698-e817eb2f993@google.com>
Message-ID: <bfc6cab2-497f-32bf-dd5-98dc1987e4a9@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <a5dce57-6dfa-5559-4698-e817eb2f993@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though not yet detected by syzbot, this commit was making the same
mistake with mmap_locked as the previous commit: fix that.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1c773db26e88..41913730db4c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2380,19 +2380,17 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 				mmap_locked = false;
 				*result = hpage_collapse_scan_file(mm,
 					khugepaged_scan.address, file, pgoff, cc);
+				fput(file);
 				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
 					mmap_read_lock(mm);
-					mmap_locked = true;
-					if (hpage_collapse_test_exit(mm)) {
-						fput(file);
+					if (hpage_collapse_test_exit(mm))
 						goto breakouterloop;
-					}
 					*result = collapse_pte_mapped_thp(mm,
 						khugepaged_scan.address, false);
 					if (*result == SCAN_PMD_MAPPED)
 						*result = SCAN_SUCCEED;
+					mmap_read_unlock(mm);
 				}
-				fput(file);
 			} else {
 				*result = hpage_collapse_scan_pmd(mm, vma,
 					khugepaged_scan.address, &mmap_locked, cc);
-- 
2.35.3

