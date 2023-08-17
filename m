Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB0577F658
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbjHQMTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350825AbjHQMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:18:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D02D50
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+MuyupV+mEo0a8sy4kXCfy1lN0SMoP5voFKVS9XKlr0=; b=eyMaKs5jzocpH7Imu9V+zeeKOE
        eYFowVnB5AbsXcFF2s8nHH46fLC7W1yPJXDie60Rsbes8bAoC5ODQgpuzG7a5guV3FBAUHjLUShag
        Vq8fWt5/2RLVoR345mT63PqPgNllkQFJu7t6QI2O8ud9i1KZ0IvawmdUTtCouSCr+nWJc1TT1TjWF
        II3H1UOkxaMe0UljaN08VPj6LNE2KDsCz+yueer4M7hBnQRWf2p+otlI9arzAMA9gsjYXbyvYwdJg
        +86YmG94ry+cS2HeWBbB4/Y5W2f+OCSYCD1CRZoj9P6h2ERFobUgr9bnfcn/OnOPZ7tYULDB3n/GV
        OCuiURGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWbxM-003Bnx-AV; Thu, 17 Aug 2023 12:18:28 +0000
Date:   Thu, 17 Aug 2023 13:18:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Message-ID: <ZN4QFNZlx8mK9pQm@casper.infradead.org>
References: <20230812210053.2325091-1-zokeefe@google.com>
 <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org>
 <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org>
 <CAAa6QmTA8aADSYbpxXU8kne0KqyeY7fCw5_QYSj0T7bCtPKmfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAa6QmTA8aADSYbpxXU8kne0KqyeY7fCw5_QYSj0T7bCtPKmfA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 02:31:06PM -0700, Zach O'Keefe wrote:
> On Mon, Aug 14, 2023 at 7:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > So if we find a large folio that is PMD mappable, and there's nothing
> > at vmf->pmd, we install a PMD-sized mapping at that spot.  If that
> > fails, we install the preallocated PTE table at vmf->pmd and continue to
> > trying set one or more PTEs to satisfy this page fault.
> 
> Aha! I see. I did not expect ->fault() to have this logic, as I had
> incorrectly thought (aka assumed) the pmd vs pte-mapping logic split
> at create_huge_pmd(); i.e. do_huge_pmd_anonymous_page(), or
> ->huge_fault(), or fallback to pte-mapping. It seems very weird to me
> that hugepage_vma_check() "artificially" says "no" to file and shmem
> along the fault path, so they can go and do their own thing in
> ->fault().

Wow, hugepage_vma_check() is a very complicated function.  I'm glad I
ignored it!

> IIUC then, there is a bug in smaps THPeligible code when
> CONFIG_READ_ONLY_THP_FOR_FS is not set. Not obvious, but apparently
> this config is (according to it's Kconfig desc) khugepaged-only, so it
> should be fine for it to be disabled, yet allow
> do_sync_mmap_readahead() to install a pmd for file-backed memory.
> hugepage_vma_check() will need to be patched to fix this.

I guess so ...

> But I have a larger question for you: should we care about
> /sys/kernel/mm/transparent_hugepage/enabled for file-fault? We
> currently don't. Seems weird that we can transparently get a hugepage
> when THP="never". Also, if THP="always", we might as well skip the
> VM_HUGEPAGE check, and try the final pmd install (and save khugepaged
> the trouble of attempting it later).

I deliberately ignored the humungous complexity of the THP options.
They're overgrown and make my brain hurt.  Instead, large folios are
adaptive; they observe the behaviour of the user program and choose based
on history what to do.  This is far superior to having a sysadmin tell
us what to do!
