Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F87784567
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbjHVPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjHVPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:24:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F8CD1;
        Tue, 22 Aug 2023 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VmtAtCcHRfR32PnwuVa9rLL2uGT/TuCRRqTlgyU2vBA=; b=M/0/D5T3AyM8nE1eiuk7zbB7kQ
        BJrm5LWDM76wZcpRlUeUCl5ar6M7LqHhjbON3vQMbyweMSxSFmB5OgRYyMzWmBnVFnL7cRXEIRI2k
        +n31COizrjThN1j9n443LMvLNQLHJUILNsqHPwBiXGmJhYz9WMrndPhu2WLjej9VojPyBazd4IAPZ
        3i2zAOqaXLdAgTzgiS0tE8XMBFu5jps70cx4hrqdbETII5iv5evh1/hveF6E8VBdkOPciXOwlGJeA
        jaQxBw/pZbJCFwqisyevMFsMIrN1oQcerGvlcS3NpR38lQxo3TF10oJ//HmzjywWxjVjY6ifAcgqY
        VYfbDqvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYTDW-00H50z-QD; Tue, 22 Aug 2023 15:22:50 +0000
Date:   Tue, 22 Aug 2023 16:22:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
Message-ID: <ZOTSyv6fuC1pkt76@casper.infradead.org>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
 <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0S-RjAapaDiJ+oZXpn1vs9niWx54iqzusUScS-BYu0hw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:39:43PM +0200, Jann Horn wrote:
> > Perhaps something else will want that same behaviour in future (it's
> > tempting, but difficult to guarantee correctness); for now, it is just
> > userfaultfd (but by saying "_armed" rather than "_missing", I'm half-
> > expecting uffd to add more such exceptional modes in future).
> 
> Hm, yeah, sounds okay. (I guess we'd also run into this if we ever
> wanted to make it possible to reliably install PTE markers with
> madvise() or something like that, which might be nice for allowing
> userspace to create guard pages without unnecessary extra VMAs...)

I don't know what a userspace API for this would look like, but I have
a dream of creating guard VMAs which only live in the maple tree and
don't require the allocation of a struct VMA.  Use some magic reserved
pointer value like XA_ZERO_ENTRY to represent them ... seems more
robust than putting a PTE marker in the page tables?

