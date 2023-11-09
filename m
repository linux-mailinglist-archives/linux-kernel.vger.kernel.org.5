Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1737E703F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbjKIR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjKIR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:27:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A1E8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sx5gc6CzO6ARk+0DIC+sb4srkgbMkdfPH/0I6PsPo3Q=; b=TCp9iWZqfexJoSuBZL95DEpqqW
        Xe8trWVA85ipEAqdc8ml1pl2x4k6YiGk5Zz2L6iOBJBUDVnOVb0+2OekbOJMDLqu4bifLEYTZWm1Y
        uzQih9eKiWXcW3Ox+jUK30v62y6axGLEqIO6/kjYI8rghBuWerN0uze8B9T3OI/2xT6SFfoPZUIPr
        +08+zthG5r7gr83+KpxfpOeDm3JbZ+VEXsSm+m/diEVGNt8YUCoVd1jaRdGycni/fFVmnQtall5vR
        IUwgVgiDL7xueOD6fMiudeClLWhdJFcRtzw7t9rsHm4KkCRir7U9XntxQk5UV3QGc8h/+b711nniw
        RNe6qRYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r18oi-008Vwk-VQ; Thu, 09 Nov 2023 17:27:45 +0000
Date:   Thu, 9 Nov 2023 17:27:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, lstoakes@gmail.com, hughd@google.com,
        david@redhat.com, fengwei.yin@intel.com, vbabka@suse.cz,
        peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        riel@redhat.com, ying.huang@intel.com, hannes@cmpxchg.org,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
Message-ID: <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 09:47:24PM +0800, zhangpeng (AS) wrote:
> There is a stage in numa fault which will set pte as 0 in do_numa_page() :
> ptep_modify_prot_start() will clear the vmf->pte, until
> ptep_modify_prot_commit() assign a value to the vmf->pte.

[...]

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

Yes, this looks like a bug.

It seems to me that the easiest way to fix this is not to zero the pte
but to make it protnone?  That would send task 2 into do_numa_page()
where it would take the ptl, then check pte_same(), see that it's
changed and goto out, which will end up retrying the fault.

I'm not particularly expert at page table manipulation, so I'll let
somebody who is propose an actual patch.  Or you could try to do it?
