Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BB77C5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjHOCZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjHOCY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:24:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC72310C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGHqBFoHTGGxthfJ8DuweAb418DGrKcXt4a8moA6GQI=; b=PVDVlReZKuqzSo8dh817AjyvoY
        viyUIzFCHLMs6nOZEwBLcFpDo9T0ApL1NTCn2F0SxHmhVmPCYYtvs6dME31R6RP2gpn22J57JwUZc
        0jSS/CRJ0eJyupc0O1il2UGCRj2XSA/WTwc0BTi3BDULnQUX9tTYRvzJ0vogFaPCXSq7+7tNjPg4K
        nMO/EnIU7RoZVPMXk9cyq3uyeB2vDD0dHk6jVgYWKcMxINZ6O/TgqQ77vWI9QGGlzyX2eJwz+FHFl
        q2bTLJ2vfELgc5JquYvhpljVGLW/KF34q9ItZYlynJtJVax8u9eThdW+7VCyXVnNmfuMBjbncyCap
        UcTROjtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVjjf-005azd-HJ; Tue, 15 Aug 2023 02:24:43 +0000
Date:   Tue, 15 Aug 2023 03:24:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Message-ID: <ZNrh6w9ICu4rMrhV@casper.infradead.org>
References: <20230812210053.2325091-1-zokeefe@google.com>
 <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org>
 <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:04:47PM -0700, Zach O'Keefe wrote:
> > From a large folios perspective, filesystems do not implement a special
> > handler.  They call filemap_fault() (directly or indirectly) from their
> > ->fault handler.  If there is already a folio in the page cache which
> > satisfies this fault, we insert it into the page tables (no matter what
> > size it is).  If there is no folio, we call readahead to populate that
> > index in the page cache, and probably some other indices around it.
> > That's do_sync_mmap_readahead().
> >
> > If you look at that, you'll see that we check the VM_HUGEPAGE flag, and
> > if set we align to a PMD boundary and read two PMD-size pages (so that we
> > can do async readahead for the second page, if we're doing a linear scan).
> > If the VM_HUGEPAGE flag isn't set, we'll use the readahead algorithm to
> > decide how large the folio should be that we're reading into; if it's a
> > random read workload, we'll stick to order-0 pages, but if we're getting
> > good hit rate from the linear scan, we'll increase the size (although
> > we won't go past PMD size)
> >
> > There's also the ->map_pages() optimisation which handles page faults
> > locklessly, and will fail back to ->fault() if there's even a light
> > breeze.  I don't think that's of any particular use in answering your
> > question, so I'm not going into details about it.
> >
> > I'm not sure I understand the code that's being modified well enough to
> > be able to give you a straight answer to your question, but hopefully
> > this is helpful to you.
> 
> Thank you, this was great info. I had thought, incorrectly, that large
> folio work would eventually tie into that ->huge_fault() handler
> (should be dax_huge_fault() ?)
> 
> If that's the case, then faulting file-backed, non-DAX memory as
> (pmd-mapped-)THPs isn't supported at all, and no fault lies with the
> aforementioned patches.

Ah, wait, hang on.  You absolutely can get a PMD mapping by calling into
->fault.  Look at how finish_fault() works:

        if (pmd_none(*vmf->pmd)) {
                if (PageTransCompound(page)) {
                        ret = do_set_pmd(vmf, page);
                        if (ret != VM_FAULT_FALLBACK)
                                return ret;
                }

                if (vmf->prealloc_pte)
                        pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);

So if we find a large folio that is PMD mappable, and there's nothing
at vmf->pmd, we install a PMD-sized mapping at that spot.  If that
fails, we install the preallocated PTE table at vmf->pmd and continue to
trying set one or more PTEs to satisfy this page fault.

So why, you may be asking, do we have ->huge_fault.  Well, you should
ask the clown who did commit b96375f74a6d ... in fairness to me,
finish_fault() did not exist at the time, and the ability to return
a PMD-sized page was added later.

