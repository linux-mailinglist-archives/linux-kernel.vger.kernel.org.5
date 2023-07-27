Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42240766067
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjG0Xug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjG0Xue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:50:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25630F7;
        Thu, 27 Jul 2023 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xkFsN0nLFndawtL4141L8X/JoZGbeREgGfgGd37885M=; b=Wg+GAAwUWeNRD75anK4VxNzaDo
        X2K8CQfGrt295ANJO9MWD0yKUmm9oNYH7OHJUwQWtmMqWEb+jHwUs1s7HqYVBcc+0KRh2NutXPRYm
        jfQnPEMeMZ63/IJLfMW83F/71lAtSU0C+I8ur0fwD7ItFB01Tifqk4Vo4eGj2mV/wnnwG5pKEmGaw
        +5v2XHg6xAHTRXHt1oX+RaQBRJV6sl18/QBCLXKPlfHVDzO+xtAO2czHNs+e6awlVwcdDlfJsALq4
        /M35/NoVH+Wjd2A9uTPjy7yrtt/BOvs7om4/ql2HC8ZJMWkb1lvNL8OyCjtUHXL7Zm0wA5X3CNk25
        cgaVlayA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qPAkX-007ylq-Qh; Thu, 27 Jul 2023 23:50:29 +0000
Date:   Fri, 28 Jul 2023 00:50:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <ZMMCxRGMsSd9H+J3@casper.infradead.org>
References: <20230728091849.7f32259d@canb.auug.org.au>
 <20230728092915.732d4115@canb.auug.org.au>
 <CAJuCfpHe72rCZgkGQpRnVQHOQFdH4Vd=uj9nWi5aA2_2nNDFLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHe72rCZgkGQpRnVQHOQFdH4Vd=uj9nWi5aA2_2nNDFLA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:40:20PM -0700, Suren Baghdasaryan wrote:
> On Thu, Jul 27, 2023 at 4:29 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > On Fri, 28 Jul 2023 09:18:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the mm tree got a conflict in:
> > >
> > >   mm/memory.c
> > >
> > > between commit:
> > >
> > >   657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock")
> > >
> > > from Linus' tree and commits:
> > >
> > >   69f6bbd1317f ("mm: handle userfaults under VMA lock")
> > >   a3bdf38e85aa ("mm: allow per-VMA locks on file-backed VMAs")
> > >
> > > from the mm tree.
> > >
> > > I fixed it up (I think, please check - see below) and can carry the fix
> > > as necessary. This is now fixed as far as linux-next is concerned, but
> > > any non trivial conflicts should be mentioned to your upstream
> > > maintainer when your tree is submitted for merging.  You may also want
> > > to consider cooperating with the maintainer of the conflicting tree to
> > > minimise any particularly complex conflicts.
> > >
> > > --
> > > Cheers,
> > > Stephen Rothwell
> > >
> > > diff --cc mm/memory.c
> > > index ca632b58f792,271982fab2b8..000000000000
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@@ -5392,32 -5597,18 +5597,21 @@@ retry
> > >       if (!vma)
> > >               goto inval;
> > >
> > > -     /* Only anonymous and tcp vmas are supported for now */
> > > -     if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
> > >  -    /* find_mergeable_anon_vma uses adjacent vmas which are not locked */
> > >  -    if (vma_is_anonymous(vma) && !vma->anon_vma)
> > > --            goto inval;
> > > --
> > >       if (!vma_start_read(vma))
> > >               goto inval;
> > >
> > >  +    /*
> > >  +     * find_mergeable_anon_vma uses adjacent vmas which are not locked.
> > >  +     * This check must happen after vma_start_read(); otherwise, a
> > >  +     * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
> > >  +     * from its anon_vma.
> > >  +     */
> > > -     if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
> > > -             goto inval_end_read;
> > > -
> > > -     /*
> > > -      * Due to the possibility of userfault handler dropping mmap_lock, avoid
> > > -      * it for now and fall back to page fault handling under mmap_lock.
> > > -      */
> > > -     if (userfaultfd_armed(vma))
> > > ++    if (unlikely(vma_is_anonymous(vma) && !vma_is_tcp(vma)))
> 
> Is the above extra '+' what compiler complains about?
> Patches from Linus' tree remove some code from that function, so
> applying them first should simplify the merge.

I see you're unfamiliar with the output of git diff --cc ...

