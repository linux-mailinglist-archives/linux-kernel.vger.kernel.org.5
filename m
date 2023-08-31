Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39F178E9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbjHaJ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjHaJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:58:11 -0400
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B319A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:58:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id DF3C51E63
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:58:03 +0100 (IST)
Received: (qmail 434 invoked from network); 31 Aug 2023 09:58:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Aug 2023 09:58:03 -0000
Date:   Thu, 31 Aug 2023 10:58:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Usama Arif <usama.arif@bytedance.com>
Subject: Re: [External] [v3 4/4] mm: hugetlb: Skip initialization of gigantic
 tail struct pages if freed by HVO
Message-ID: <20230831095801.76rtpgdsvdijbw5t@techsingularity.net>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
 <a5ec4389-e7c1-2af5-2a47-495bdcac149c@bytedance.com>
 <A5CD653A-DAA6-481F-963E-AB04D2170088@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <A5CD653A-DAA6-481F-963E-AB04D2170088@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 02:21:06PM +0800, Muchun Song wrote:
> 
> 
> > On Aug 30, 2023, at 18:27, Usama Arif <usama.arif@bytedance.com> wrote:
> > On 28/08/2023 12:33, Muchun Song wrote:
> >>> On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> >>> 
> >>> The new boot flow when it comes to initialization of gigantic pages
> >>> is as follows:
> >>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> >>> the region after the first struct page is marked as noinit.
> >>> - This results in only the first struct page to be
> >>> initialized in reserve_bootmem_region. As the tail struct pages are
> >>> not initialized at this point, there can be a significant saving
> >>> in boot time if HVO succeeds later on.
> >>> - Later on in the boot, HVO is attempted. If its successful, only the first
> >>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> >>> after the head struct page are initialized. If it is not successful,
> >>> then all of the tail struct pages are initialized.
> >>> 
> >>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> >> This edition is simpler than before ever, thanks for your work.
> >> There is premise that other subsystems do not access vmemmap pages
> >> before the initialization of vmemmap pages associated withe HugeTLB
> >> pages allocated from bootmem for your optimization. However, IIUC, the
> >> compacting path could access arbitrary struct page when memory fails
> >> to be allocated via buddy allocator. So we should make sure that
> >> those struct pages are not referenced in this routine. And I know
> >> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
> >> the same issue, but I don't find any code to prevent this from
> >> happening. I need more time to confirm this, if someone already knows,
> >> please let me know, thanks. So I think HugeTLB should adopt the similar
> >> way to prevent this.
> >> Thanks.
> > 
> > Thanks for the reviews.
> > 
> > So if I understand it correctly, the uninitialized pages due to the optimization in this patch and due to DEFERRED_STRUCT_PAGE_INIT should be treated in the same way during compaction. I see that in isolate_freepages during compaction there is a check to see if PageBuddy flag is set and also there are calls like __pageblock_pfn_to_page to check if the pageblock is valid.
> > 
> > But if the struct page is uninitialized then they would contain random data and these checks could pass if certain bits were set?
> > 
> > Compaction is done on free list. I think the uninitialized struct pages atleast from DEFERRED_STRUCT_PAGE_INIT would be part of freelist, so I think their pfn would be considered for compaction.
> > 
> > Could someone more familiar with DEFERRED_STRUCT_PAGE_INIT and compaction confirm how the uninitialized struct pages are handled when compaction happens? Thanks!
> 
> Hi Mel,
> 
> Could you help us answer this question? I think you must be the expert of
> CONFIG_DEFERRED_STRUCT_PAGE_INIT. I summarize the context here. As we all know,
> some struct pages are uninnitialized when CONFIG_DEFERRED_STRUCT_PAGE_INIT is
> enabled, if someone allocates a larger memory (e.g. order is 4) via buddy
> allocator and fails to allocate the memory, then we will go into the compacting
> routine, which will traverse all pfns and use pfn_to_page to access its struct
> page, however, those struct pages may be uninnitialized (so it's arbitrary data).
> Our question is how to prevent the compacting routine from accessing those
> uninitialized struct pages? We'll be appreciated if you know the answer.
> 

I didn't check the code but IIRC, the struct pages should be at least
valid and not contain arbitrary data once page_alloc_init_late finishes.

-- 
Mel Gorman
SUSE Labs
