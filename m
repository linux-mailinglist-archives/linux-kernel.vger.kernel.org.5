Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE07AADC2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjIVJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:23:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C96192;
        Fri, 22 Sep 2023 02:23:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32460C433C7;
        Fri, 22 Sep 2023 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695374593;
        bh=dXskQX5Hl5xkPtfaxV8tcYegxNU8vst41m8wxd6lccM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HC7A5qwRYefrtsRKDVgbV8LB3GlGNnwCiuzuBjBf//079Vr5pHlHx7w33piVwkMSg
         KdakR66MrSNSkYJO3jbZwCr/w2VTw33wUH/TvBJA0dAAYl+WQ5Z5GVudGyrcU4/vOf
         0KADD+v5vZCFHY1cz6sqX/igDr/hO6uHWrXxgxmY=
Date:   Fri, 22 Sep 2023 11:23:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Fix set_huge_pte_at() panic on arm64
Message-ID: <2023092208-sitcom-playpen-b62d@gregkh>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
 <20230921093026.230b2991be551093e397f462@linux-foundation.org>
 <7c5c2c00-d657-44fd-b478-743b43c57e8a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5c2c00-d657-44fd-b478-743b43c57e8a@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 05:35:54PM +0100, Ryan Roberts wrote:
> On 21/09/2023 17:30, Andrew Morton wrote:
> > On Thu, 21 Sep 2023 17:19:59 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> > 
> >> Hi All,
> >>
> >> This series fixes a bug in arm64's implementation of set_huge_pte_at(), which
> >> can result in an unprivileged user causing a kernel panic. The problem was
> >> triggered when running the new uffd poison mm selftest for HUGETLB memory. This
> >> test (and the uffd poison feature) was merged for v6.6-rc1. However, upon
> >> inspection there are multiple other pre-existing paths that can trigger this
> >> bug.
> >>
> >> Ideally, I'd like to get this fix in for v6.6 if possible? And I guess it should
> >> be backported too, given there are call sites where this can theoretically
> >> happen that pre-date v6.6-rc1 (I've cc'ed stable@vger.kernel.org).
> > 
> > This gets you a naggygram from Greg.  The way to request a backport is
> > to add cc:stable to all the changelogs.  I'll make that change to my copy.
> 
> Ahh, sorry about that... I just got the same moan from the kernel test robot too.
> 
> > 
> > 
> >> Ryan Roberts (8):
> >>   parisc: hugetlb: Convert set_huge_pte_at() to take vma
> >>   powerpc: hugetlb: Convert set_huge_pte_at() to take vma
> >>   riscv: hugetlb: Convert set_huge_pte_at() to take vma
> >>   s390: hugetlb: Convert set_huge_pte_at() to take vma
> >>   sparc: hugetlb: Convert set_huge_pte_at() to take vma
> >>   mm: hugetlb: Convert set_huge_pte_at() to take vma
> >>   arm64: hugetlb: Convert set_huge_pte_at() to take vma
> >>   arm64: hugetlb: Fix set_huge_pte_at() to work with all swap entries
> >>
> >>  arch/arm64/include/asm/hugetlb.h              |  2 +-
> >>  arch/arm64/mm/hugetlbpage.c                   | 22 ++++----------
> >>  arch/parisc/include/asm/hugetlb.h             |  2 +-
> >>  arch/parisc/mm/hugetlbpage.c                  |  4 +--
> >>  .../include/asm/nohash/32/hugetlb-8xx.h       |  3 +-
> >>  arch/powerpc/mm/book3s64/hugetlbpage.c        |  2 +-
> >>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |  2 +-
> >>  arch/powerpc/mm/nohash/8xx.c                  |  2 +-
> >>  arch/powerpc/mm/pgtable.c                     |  7 ++++-
> >>  arch/riscv/include/asm/hugetlb.h              |  2 +-
> >>  arch/riscv/mm/hugetlbpage.c                   |  3 +-
> >>  arch/s390/include/asm/hugetlb.h               |  8 +++--
> >>  arch/s390/mm/hugetlbpage.c                    |  8 ++++-
> >>  arch/sparc/include/asm/hugetlb.h              |  8 +++--
> >>  arch/sparc/mm/hugetlbpage.c                   |  8 ++++-
> >>  include/asm-generic/hugetlb.h                 |  6 ++--
> >>  include/linux/hugetlb.h                       |  6 ++--
> >>  mm/damon/vaddr.c                              |  2 +-
> >>  mm/hugetlb.c                                  | 30 +++++++++----------
> >>  mm/migrate.c                                  |  2 +-
> >>  mm/rmap.c                                     | 10 +++----
> >>  mm/vmalloc.c                                  |  5 +++-
> >>  22 files changed, 80 insertions(+), 64 deletions(-)
> > 
> > Looks scary but it's actually a fairly modest patchset.  It could
> > easily be all rolled into a single patch for ease of backporting. 
> > Maybe Greg has an opinion?
> 
> Yes, I thought about doing that; or perhaps 2 patches - one for the interface
> change across all arches and core code, and one for the actual bug fix?

I have no issues with taking patch series, or one big patch, into stable
trees, they just have to match up with what is in Linus's tree.

so if it makes more sense to have this as a series (like you did here),
wonderful, make it a patch series.  Do not go out of your way to do
things differently just for stable kernels, that is not necessary or
needed at all.

thanks,

greg k-h
