Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FC793FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbjIFPEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbjIFPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:04:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA553172E;
        Wed,  6 Sep 2023 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=groQG1OAW27aukn1St9p3F4vniNu3SS9OKbBgobN+Bs=; b=vp2bRP15Vy14N+6CcyGS9jmrcP
        TAXO05O33h8pa0eNO9YWZGsrcXlhOK6MePNEMxsU1EhgjZ/2zsxmIU2keEKBuYR/oNx+80NIWc7Be
        c3UP6l4nnPxpFoEPfjCG+vw1euWLVIH0mOUH8X9+E2A7YdpgFqvvD5XQA0HYIqc7sia9RKuScx8SH
        X1Aejmxr14zV7z3SHdaxmlAIVijEYo1Rv89K5afqfBIT60QAYdOCZ8FWxfJF076uYR80/zKKsAAnE
        haRt6wD6wtSU2S8ch7VHIsx4MAvw767NMktj08KTTbQfNiFzb/qk0+sby8p6sIOZBQnDs4ZWCZr0a
        S/LrKL/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdu4l-003JhT-NR; Wed, 06 Sep 2023 15:04:15 +0000
Date:   Wed, 6 Sep 2023 16:04:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add "Memory map" section
Message-ID: <ZPiU7/Rg8g+B58Wa@casper.infradead.org>
References: <20230906074210.3051751-1-rppt@kernel.org>
 <87ledjgy93.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ledjgy93.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:41:28AM -0600, Jonathan Corbet wrote:
> > +  All flags are declared in ``include/linux/page-flags.h``. There are a
> > +  number of macros defined for testing, clearing and setting the flags. Page
> > +  flags should not be accessed directly, but only using these macros.
> 
> It would sure be nice if we had documentation for what all the flags
> mean :)

When I figure them out, I'll let you know!

> > +``_mapcount``
> > +  If the page can be mapped to userspace, encodes the number of times this
> > +  page is referenced by a page table.
> > +  Do not use directly, call page_mapcount().
> 
> Have we figured out what mapcount really means yet? :)

Hah!  I know what this field means today!  In two hours time, I might
be less sure!  (Does LWN want to come along to that MM meeting and write
it up for an article?)

> > +``virtual``
> > +  Virtual address in the kernel direct map. Will be ``NULL`` for highmem
> > +  pages. Only defined for some architectures.
> 
> I'd say virtual is absent more often than present anymore, right?
> Perhaps it's worth being more explicit about that.  And maybe say to use
> page_address() rather than accessing it directly?

That's something I've been thinking about for the folio kernel-doc.
Just stop documenting the things that you "shouldn't use".
Non-kernel-doc comments in the source about what you should use instead,
but no kernel-doc comments to say "Use page_address() instead of this".

> > +For pages on unevictable "LRU list" ``lru`` is overlayed with an anonymous
> > +struct containing two fields:
> > +
> > +``__filler``
> > +  A dummy field that must be always even to avoid conflict with compound
> > +  page encoding.
> 
> Do we care about the constraints on this field's contents?  Presumably
> that is taken care of somewhere and nobody should mess with it?

I also think that documenting here which things are in a union with
other things is unnecessary.  If someone cares for such a level of
detail, they'd better be reading the source code instead of this.
Nobody should be using it, better to just leave it undocumented.

> > +``mapping``
> > +  The file this page belongs to. Can be pagecache or swapcahe. For

Oh, actually, no, it can't be swapcache.  If the page is in the
swapcache, you find its swapcache through swapcache_mapping().
That's because ->mapping is reused as an anon_vma pointer for anon
pages.

> > +  anonymous memory refers to the `struct anon_vma`.
> > +  See also ``include/linux/page-flags.h`` for ``PAGE_MAPPING_FLAGS``
> 
> It seems like putting in the types for fields like this would be useful;
> readers of the HTML docs can then follow the links and see what is
> actually pointed to.
> 
> > +``index``
> > +  Page offset within mapping. Overlaps with ``share``.
> > +
> > +``share``
> > +  Share count for fsdax. Overlaps with ``index``.

fsdax is not pagecache, so this probably shouldn't be documented here.

> I wonder if it might be better to structure it as if the splitting of
> struct page were already complete, with a section for each page
> descriptor type, even the ones that don't exist as separate entities
> yet?  Maybe that would make it easier for people to keep it current as
> they hack pieces out of struct page?

Yes.  Although I don't think we quite know what it's all going to
look like yet, which makes it challenging to document!
