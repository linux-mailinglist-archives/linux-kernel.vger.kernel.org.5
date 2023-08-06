Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A10771385
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 05:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHFDzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 23:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFDzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 23:55:43 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662101FD9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 20:55:39 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-58451ecf223so37443407b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691294138; x=1691898938;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m2K+k0UoOXs6D5uLva9XkEFbd09ZRm9Z7/lr2pw8hZw=;
        b=nHQK9bAViVteBZuYzu1hSOzZou4B7CZHQRLaLY6OQhD1zUjj/ni/sFz980Hez3g6xP
         +XJdU9vnCkIdIo4sxbPl3r3sYiHSM+SwI9Q4fpiZIBM4Eof2E8FuwdvUmKXrdVFtQlcx
         ww+ZM5dOPHj7CUMoYM0F9VEscwNfVfykgHQSeFqLDRH8X8nndU7fw98QPxNlNPhr9jfi
         w3PvJYAodiPLKRnlfP8VbYcBqtQImekRiz1F15mmV39CZybLJVmANRH5/iuTvgm0WOhL
         SpUQkdBJ71frR6f2MxShl/q+q+TV2Ok4ynKVWq7SSJQkDn4kFZWzeTN8D/KeteoSw1o9
         EKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691294138; x=1691898938;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2K+k0UoOXs6D5uLva9XkEFbd09ZRm9Z7/lr2pw8hZw=;
        b=ON0yhlDaI/sZ3u+pdGh0kf1E4YB9yGGN/uMChJQGLgmBpJk1CHU62kQzkiABneVjkN
         7OZf+7vQAadn1Safbp4D+nyczGEm5aLVd9ZIxPmH/P4amKt9O21UhnJn9q8DdDhOe4Km
         hVk64mkdSafZrcYIu6n9zPWnE8FRKjFnTKpdSRjeKZfHcf9yoVDn9sSkaAsfDaPLd+B3
         qGdNY0NozrJCXw5f9+r0D9jwMQre3FNkH/foIo8ppsV4TU94Sr4XUvEfIQt+S64OF62L
         T4yBdZrRBP0J/PQjV3sQZDr7t+r48WP4hnka6CiiD4lZ2wL9bj9eTHR4JgPrVHeo/dUR
         uY3Q==
X-Gm-Message-State: AOJu0YyVbKi4B2rQAmCusRkxY/eE8tveAZkN0FeCNRrWQKrqnNCCe2HF
        IFqiTGMBD6mqgCjevtnsNK84ZA==
X-Google-Smtp-Source: AGHT+IFiva5XFrTVBq0jEtYJXpVvro3rzuVZhewsSXihKRs8BSeQq4Tb3piHb2uK39Vd3DI+t0W0ew==
X-Received: by 2002:a0d:d488:0:b0:56d:5272:d540 with SMTP id w130-20020a0dd488000000b0056d5272d540mr6237470ywd.46.1691294138477;
        Sat, 05 Aug 2023 20:55:38 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a64-20020a0df143000000b00576e67820f3sm1861323ywf.66.2023.08.05.20.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 20:55:37 -0700 (PDT)
Date:   Sat, 5 Aug 2023 20:55:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Qi Zheng <zhengqi.arch@bytedance.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock()
In-Reply-To: <0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com>
Message-ID: <884f20fe-d642-3a5f-522a-d756c3443bb4@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com> <0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023, Qi Zheng wrote:
> On 2023/7/12 12:42, Hugh Dickins wrote:
> > Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
> > It does need mmap_read_lock(), but it does not need mmap_write_lock(),
> > nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
> > paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.
...
> > @@ -1681,47 +1634,76 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,
> > unsigned long addr,
> >   
> >     if (pte_none(ptent))
> >   			continue;
> > -		page = vm_normal_page(vma, addr, ptent);
> > -		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
> > +		/*
> > +		 * We dropped ptl after the first scan, to do the
> > mmu_notifier:
> > +		 * page lock stops more PTEs of the hpage being faulted in,
> > but
> > +		 * does not stop write faults COWing anon copies from existing
> > +		 * PTEs; and does not stop those being swapped out or
> > migrated.
> > +		 */
> > +		if (!pte_present(ptent)) {
> > +			result = SCAN_PTE_NON_PRESENT;
> >   			goto abort;
> > +		}
> > +		page = vm_normal_page(vma, addr, ptent);
> > +		if (hpage + i != page)
> > +			goto abort;
> > +
> > +		/*
> > +		 * Must clear entry, or a racing truncate may re-remove it.
> > +		 * TLB flush can be left until pmdp_collapse_flush() does it.
> > +		 * PTE dirty? Shmem page is already dirty; file is read-only.
> > +		 */
> > +		pte_clear(mm, addr, pte);
> 
> This is not non-present PTE entry, so we should call ptep_clear() to let
> page_table_check track the PTE clearing operation, right? Otherwise it
> may lead to false positives?

You are right: thanks a lot for catching that: fix patch follows.

Hugh
