Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F457AA22F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjIUVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjIUVMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:12:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631B1A9E8;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD95C611AA;
        Thu, 21 Sep 2023 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695313828;
        bh=Snl0TDHOoq+PcJkslOz6yzyz3jV/ILGMNVGDPT3ALVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sy+EhpEKmklRoXizWavrDSv+mOOfZ2nUh7nbNkMhlDLbnh4hSgBtM2DfmKEv4UzUL
         Pv6q7E7wnTnnSz2jaiJSSK97ktzV1tSKKpfyQ3VEqmLQ/I+fVqkhoc6rt2Al+4iGM9
         C9VSqdRkP4rrRuEL9YXgvk8jJTKJGqA4Ygoc1IFE=
Date:   Thu, 21 Sep 2023 09:30:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 0/8] Fix set_huge_pte_at() panic on arm64
Message-Id: <20230921093026.230b2991be551093e397f462@linux-foundation.org>
In-Reply-To: <20230921162007.1630149-1-ryan.roberts@arm.com>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 17:19:59 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Hi All,
> 
> This series fixes a bug in arm64's implementation of set_huge_pte_at(), which
> can result in an unprivileged user causing a kernel panic. The problem was
> triggered when running the new uffd poison mm selftest for HUGETLB memory. This
> test (and the uffd poison feature) was merged for v6.6-rc1. However, upon
> inspection there are multiple other pre-existing paths that can trigger this
> bug.
> 
> Ideally, I'd like to get this fix in for v6.6 if possible? And I guess it should
> be backported too, given there are call sites where this can theoretically
> happen that pre-date v6.6-rc1 (I've cc'ed stable@vger.kernel.org).

This gets you a naggygram from Greg.  The way to request a backport is
to add cc:stable to all the changelogs.  I'll make that change to my copy.


> Ryan Roberts (8):
>   parisc: hugetlb: Convert set_huge_pte_at() to take vma
>   powerpc: hugetlb: Convert set_huge_pte_at() to take vma
>   riscv: hugetlb: Convert set_huge_pte_at() to take vma
>   s390: hugetlb: Convert set_huge_pte_at() to take vma
>   sparc: hugetlb: Convert set_huge_pte_at() to take vma
>   mm: hugetlb: Convert set_huge_pte_at() to take vma
>   arm64: hugetlb: Convert set_huge_pte_at() to take vma
>   arm64: hugetlb: Fix set_huge_pte_at() to work with all swap entries
> 
>  arch/arm64/include/asm/hugetlb.h              |  2 +-
>  arch/arm64/mm/hugetlbpage.c                   | 22 ++++----------
>  arch/parisc/include/asm/hugetlb.h             |  2 +-
>  arch/parisc/mm/hugetlbpage.c                  |  4 +--
>  .../include/asm/nohash/32/hugetlb-8xx.h       |  3 +-
>  arch/powerpc/mm/book3s64/hugetlbpage.c        |  2 +-
>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |  2 +-
>  arch/powerpc/mm/nohash/8xx.c                  |  2 +-
>  arch/powerpc/mm/pgtable.c                     |  7 ++++-
>  arch/riscv/include/asm/hugetlb.h              |  2 +-
>  arch/riscv/mm/hugetlbpage.c                   |  3 +-
>  arch/s390/include/asm/hugetlb.h               |  8 +++--
>  arch/s390/mm/hugetlbpage.c                    |  8 ++++-
>  arch/sparc/include/asm/hugetlb.h              |  8 +++--
>  arch/sparc/mm/hugetlbpage.c                   |  8 ++++-
>  include/asm-generic/hugetlb.h                 |  6 ++--
>  include/linux/hugetlb.h                       |  6 ++--
>  mm/damon/vaddr.c                              |  2 +-
>  mm/hugetlb.c                                  | 30 +++++++++----------
>  mm/migrate.c                                  |  2 +-
>  mm/rmap.c                                     | 10 +++----
>  mm/vmalloc.c                                  |  5 +++-
>  22 files changed, 80 insertions(+), 64 deletions(-)

Looks scary but it's actually a fairly modest patchset.  It could
easily be all rolled into a single patch for ease of backporting. 
Maybe Greg has an opinion?

