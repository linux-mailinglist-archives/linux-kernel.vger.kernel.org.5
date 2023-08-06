Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A504D771389
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 05:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjHFD7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 23:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFD7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 23:59:35 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1837C1FDB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 20:59:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583f036d50bso39811407b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 20:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691294373; x=1691899173;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lrjEl367R/y3HI+4JKvQ0DDl1pq1Lit9a0Zn8ubupwU=;
        b=fPoU/fRuHX5caeTxQNTi6xCx7rooozWVX8OCkvcRFbiVcZeihuuZZlQmHVtAw45YAU
         kFT79lh292tEMsPH0yFic9OWUawFTESm7xFiS7iMD5hNLVpkpBLE1WwEzPp8KYPc9FvH
         766vba+m+Ozk/SUm7hZshVAuKp3hxt+fVNapmNcBwnLA8Tu4o53ObK+EGCiIS1gfH4rG
         uel9HuMTx0Oe+VPeKFnHbRMjn+5QkVxnK6oa0BwRKKK/2LR8eKx9092x6l95LvzWPB4R
         /SFh7mg0lNI5CkVsjDsRo/ouKCF7FXkkPaU6nGGyY8dfVtlmJW+KmCWlykivefXbbzzJ
         QLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691294373; x=1691899173;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrjEl367R/y3HI+4JKvQ0DDl1pq1Lit9a0Zn8ubupwU=;
        b=Fe5/7c8hNFPLnWLuGBqWzepqeX2yjkTloRO/uPUHFQWRThMf+n/BzzRQn/sdBbICTn
         i4CtaR7ZP/uN7t7LmUyU2dL6YQb53kd+6vqummU0MZX/Utkfm2R+drMcsb3sAbtphuFc
         AlktS7eLo92ami1ppq8M0/R9dZWaVtNB0zKVZwCZU26HEv/lKqV0omyOFbhf/UManCO0
         sCSPQjnWej03QkZwjYWoi9gqAXDPcVv3YH7Q5veonjhXfQuUbaGa4zX4nSfFq9zq10+m
         E7blQPDOz88FTDONPOacyY9nnuDu2rfpG2R5UIS2bQVkK7KeiMWTQHT4LxGAFNXEhM9c
         HPUA==
X-Gm-Message-State: AOJu0Yw42MnZ3QFAoKTcXDfOf5HwFYL+HUF9EuaxEO5reWkms1IYhtQH
        VNLvy/TLhA3fdfwveb/+YRfagQ==
X-Google-Smtp-Source: AGHT+IEL/z5m+be82hvNIbgvVlYv0KrLIPiuRdrdQbyoEcvhg0nO6N3eCW4FBoXQZBwSKC83ZFZFiw==
X-Received: by 2002:a0d:e253:0:b0:584:189c:13ec with SMTP id l80-20020a0de253000000b00584189c13ecmr5953081ywe.21.1691294373186;
        Sat, 05 Aug 2023 20:59:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p6-20020a815b06000000b00584554be59dsm1887384ywb.85.2023.08.05.20.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 20:59:32 -0700 (PDT)
Date:   Sat, 5 Aug 2023 20:59:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Hugh Dickins <hughd@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
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
Subject: [PATCH v3 10/13 fix2] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock(): fix2
In-Reply-To: <0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com>
Message-ID: <e0197433-8a47-6a65-534d-eda26eeb78b0@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com> <0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ptep_clear() instead of pte_clear(): when CONFIG_PAGE_TABLE_CHECK=y,
ptep_clear() adds some accounting, missing which would cause a BUG later.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Closes: https://lore.kernel.org/linux-mm/0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com/
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index bb76a5d454de..78fc1a24a1cc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1603,7 +1603,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		 * TLB flush can be left until pmdp_collapse_flush() does it.
 		 * PTE dirty? Shmem page is already dirty; file is read-only.
 		 */
-		pte_clear(mm, addr, pte);
+		ptep_clear(mm, addr, pte);
 		page_remove_rmap(page, vma, false);
 		nr_ptes++;
 	}
-- 
2.35.3

