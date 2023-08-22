Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E084378498A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHVSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjHVSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DED810B;
        Tue, 22 Aug 2023 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J31tX1IjpfiCQxayR49GQoOflBRKi40HTvUBqvNFOZY=; b=RAzY/3FmhkOeez9WRyFLLv4ZSq
        U9rG0oMX7UlPyR/D8x7L4mEEOPnVmJVv72dkSFxz3K3fx+HJjz0yoyeOk1QTD4Bln2OjioJ+WG3UG
        CnjPXzmOixxB/77VgttDEjTQVN+QS8gKeI40gmVskiO5EQQ7Den2j/G96cP6WVrEfYYyC+vujh8og
        eJ/TUp3RaxHtDOKFUHYAODkAttL76BNxIck57m/l5uS1N1aQ2ZPhNzqFsS9g+ZZtgp8Bjfnnp5VzH
        Sh7M7AqyItqQzyxp6n+/g33j9JDbH/tinn2kkkuSh0EOjzNT3lsO7aLfQFQIinDdpU3s/xpPYqKx1
        u14eK8IA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYWNp-000KO8-5r; Tue, 22 Aug 2023 18:45:41 +0000
Date:   Tue, 22 Aug 2023 19:45:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Message-ID: <ZOUCVRxM8aPH6fva@casper.infradead.org>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
 <CAG48ez1XAePj5MUG8AUmnTjRLcxKre-NGYV82kB68-X8Rh6fxA@mail.gmail.com>
 <f2dc6d6b-c516-932-1598-a58e2afffe9a@google.com>
 <ZOTGvfO31pleXrPF@x1n>
 <1b7c7056-d742-86bf-fec-fdb024b2381@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7c7056-d742-86bf-fec-fdb024b2381@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:34:19AM -0700, Hugh Dickins wrote:
> (Yes, the locking is a bit confusing: but mainly for the unrelated reason,
> that with the split locking configs, we never quite know whether this lock
> is the same as that lock or not, and so have to be rather careful.)

Is it time to remove the PTE split locking config option?  I believe all
supported architectures have at least two levels of page tables, so if we
have split ptlocks, ptl and pml are always different from each other (it's
just that on two level machines, pmd == pud == p4d == pgd).  With huge
thread counts now being the norm, it's hard to see why anybody would want
to support SMP and !SPLIT_PTE_PTLOCKS.  To quote the documentation ...

  Split page table lock for PTE tables is enabled compile-time if
  CONFIG_SPLIT_PTLOCK_CPUS (usually 4) is less or equal to NR_CPUS.
  If split lock is disabled, all tables are guarded by mm->page_table_lock.

You can barely buy a wrist-watch without eight CPUs these days.
