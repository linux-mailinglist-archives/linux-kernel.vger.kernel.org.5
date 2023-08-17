Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D177FE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354642AbjHQTCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354639AbjHQTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:02:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74852D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RJpdT2TuLX3rRzXEHlG8PsweP6fxFNpA/3TiJp72Sck=; b=EyNymHEPUnKYceBO6ggRNe0dHk
        SRAjEmv1T0PLwVNYmgMS60Wyu2dVgl5IAQAkhoP0RF4cXv+yk3KGFvARoXCaJG9rxr2gDazAolFC5
        T1USF2yfPy2/5CX9R2MUeBYgYcyfM1dqeZkcryawIY5HdFurvfMWp5z0EBR8PzXBAhAYLE0Nd1ETz
        0bTUzNCOxa/Kc+rWXVkvoJVPZ7V3kboycx+ZfU/xAwQTKXlYpv6e+1nywDB/8ozyIfVaJ7AwNd7xe
        Yqe7Kv/csfiF8A1hf/c2s79i0npK20cbzmgxPaQLZrxWpSUF+EokHACH8uhH05wJ3zVxGS6PQeOf/
        cucPPK4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWiFg-004uCD-0q; Thu, 17 Aug 2023 19:01:48 +0000
Date:   Thu, 17 Aug 2023 20:01:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zach O'Keefe <zokeefe@google.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Message-ID: <ZN5um2yIXFcxiFjS@casper.infradead.org>
References: <20230812210053.2325091-1-zokeefe@google.com>
 <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org>
 <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org>
 <CAAa6QmTA8aADSYbpxXU8kne0KqyeY7fCw5_QYSj0T7bCtPKmfA@mail.gmail.com>
 <ZN4QFNZlx8mK9pQm@casper.infradead.org>
 <CAAa6QmTi99exY+NtNDZFi74cs7AB2xpaZ_kej3pSaZVdAtbrKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmTi99exY+NtNDZFi74cs7AB2xpaZ_kej3pSaZVdAtbrKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:13:36AM -0700, Zach O'Keefe wrote:
> > > IIUC then, there is a bug in smaps THPeligible code when
> > > CONFIG_READ_ONLY_THP_FOR_FS is not set. Not obvious, but apparently
> > > this config is (according to it's Kconfig desc) khugepaged-only, so it
> > > should be fine for it to be disabled, yet allow
> > > do_sync_mmap_readahead() to install a pmd for file-backed memory.
> > > hugepage_vma_check() will need to be patched to fix this.
> >
> > I guess so ...
> 
> The easiest and most satisfying way to handle this -- and I think we
> talked about this before -- is relaxing that complicated
> file_thp_enabled() check when the file's mapping supports large
> folios. I think that makes sense to me, though I don't know all the
> details fs-side. Will we need any hook to give fs the chance to update
> any internal state on collapse?

If the filesystem has per-folio metadata, we need to give the filesystem
the chance to set that up.  I've vaguaely been wondering about using the
->migrate_folio callback for it.  At the moment, I think it just refuses
to work if the folio isn't order-0.

> > > But I have a larger question for you: should we care about
> > > /sys/kernel/mm/transparent_hugepage/enabled for file-fault? We
> > > currently don't. Seems weird that we can transparently get a hugepage
> > > when THP="never". Also, if THP="always", we might as well skip the
> > > VM_HUGEPAGE check, and try the final pmd install (and save khugepaged
> > > the trouble of attempting it later).
> >
> > I deliberately ignored the humungous complexity of the THP options.
> > They're overgrown and make my brain hurt. [..]
> 
> Same
> 
> > [..] Instead, large folios are
> > adaptive; they observe the behaviour of the user program and choose based
> > on history what to do.  This is far superior to having a sysadmin tell
> > us what to do!
> 
> I had written a bunch on this, but I arrived to the conclusion that
> (a) pmd-mapping here is ~ a free win, and (b) I'm not the best  person
> to argue for these knobs, given MADV_COLLAPSE ignores them entirely :P
> 
> ..But (sorry) what about MMF_DISABLE_THP?

Yeah, we ignore that too.  My rationale is -- as you said -- using the
PMDs is actually free, and it's really none of the app's business how
the page cache chooses to cache things.

