Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17607E7513
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbjKIXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIXWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:22:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8403420F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 15:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mc6OzgcBVY8B61ieg8s3Enizv9IsIEbGxDPtpfAWkvg=; b=ge2SwE5jZ8Pg+BCnDdpbmmvw1S
        7X7Pwcus6b5uPZaCjSO2mFFX6C4j27TVv0ypW7tt6YBXRJ3n4VOfXBvw8gq7R8Ehm84RsvD982LSJ
        53h1jhbLHsvonZH191u+jmsBOzLdz+0lT5YWepKl9d8eIAhUbY2+IJL6Vh4K68zCm3lKH6r7M2rFZ
        O8i6XphYWB2UkhltblXkHcSpYI08HXX154gCbUaQXBPOEgAmkWKjeifCZIZzObtzJuopb2ZYU0C8u
        vujodut9+csevS7q/chyE7GyZ5zJo87DLelQn5tSnoU7+6jSyiAzxe00Pvhps5zwo0NJ2atjJ+AYa
        zyc0jd0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1ELV-00A0ax-Ul; Thu, 09 Nov 2023 23:21:57 +0000
Date:   Thu, 9 Nov 2023 23:21:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, lstoakes@gmail.com, hughd@google.com,
        david@redhat.com, fengwei.yin@intel.com, vbabka@suse.cz,
        peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        riel@redhat.com, ying.huang@intel.com, hannes@cmpxchg.org,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Message-ID: <ZU1plX2mDgKbkAJ0@casper.infradead.org>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I went spelunking to try to find out more about this issue, and I
discovered it's Aneesh's fault from 2017 ...

On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
> Hi everyone,
> 
> There is a performance issue that has been bothering us recently.
> This problem can reproduce in the latest mainline version (Linux 6.6).
> 
> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
> to avoid performance problems caused by major fault.
> 
> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
> ptep_modify_prot_start() will clear the vmf->pte, until
> ptep_modify_prot_commit() assign a value to the vmf->pte.
> 
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private
> anonymous page is generated after the COW is triggered. Mlockall can
> lock COW pages (anonymous pages), but the original file pages cannot
> be locked and may be reclaimed. If the global variable (private anon page)
> is accessed when vmf->pte is zero which is concurrently set by numa fault,
> a file page fault will be triggered.
> 
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
> 
> Our problem scenario is as follows:
> 
> task 1                      task 2
> ------                      ------
> /* scan global variables */
> do_numa_page()
>   spin_lock(vmf->ptl)
>   ptep_modify_prot_start()
>   /* set vmf->pte as null */
>                             /* Access global variables */
>                             handle_pte_fault()
>                               /* no pte lock */
>                               do_pte_missing()
>                                 do_fault()
>                                   do_read_fault()
>   ptep_modify_prot_commit()
>   /* ptep update done */
>   pte_unmap_unlock(vmf->pte, vmf->ptl)
>                                     do_fault_around()
>                                     __do_fault()
>                                       filemap_fault()
>                                         /* page cache is not available
>                                         and a major fault is triggered */
>                                         do_sync_mmap_readahead()
>                                         /* page_not_uptodate and goto
>                                         out_retry. */
> 
> Is there any way to avoid such a major fault?
> 
> -- 
> Best Regards,
> Peng
> 
