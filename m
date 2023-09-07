Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39780797721
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbjIGQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbjIGQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:21:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A456EAB;
        Thu,  7 Sep 2023 09:18:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F45EC32793;
        Thu,  7 Sep 2023 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694096489;
        bh=hSt7wsfPeE4rNbCQRwe/nzPw00nFbicSqlMNJAavVXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hq4EgHob8Xz11Jt01iQuCv6mdAgm4oyPxYuMOwNfhNmJrHtz+cQCmz6q92IYJ0DLd
         UazsxN91/INTH9Br2V3olWabeTIVlYJO52nXCQ2ggD1oEuITJAjJLSK7hUiJwPnO70
         7f8/j8UPOF3UYyDS9X+PWokSTj6zjyAMmkLWkFLpO+CManj6qRNQkyPJ/iJXPiQvre
         NTMGcZaA/Vt7S7QwsaeayyvOCxNCPVq1Uvxf2tVco+ENRLE9gsTI+Y8UmpebkLC6Z6
         1iy3Ngf2nAawdUtlOUcF/GiIj00iYxPar/M+w3xxXkAaA1x5UQ9y8sAkfa77+xuvON
         QhPuYSD+rL/Vw==
Date:   Thu, 7 Sep 2023 17:20:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add "Memory map" section
Message-ID: <20230907142043.GL3223@kernel.org>
References: <20230906074210.3051751-1-rppt@kernel.org>
 <87ledjgy93.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ledjgy93.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:41:28AM -0600, Jonathan Corbet wrote:
> Mike Rapoport <rppt@kernel.org> writes:
> 
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> >
> > Briefly describe memory map and add sub-sections for pages, folios and
> > ptdescs.
> >
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> >  Documentation/mm/physical_memory.rst | 338 ++++++++++++++++++++++++++-
> >  1 file changed, 332 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> > index 531e73b003dd..e3318897bf57 100644
> > --- a/Documentation/mm/physical_memory.rst
> > +++ b/Documentation/mm/physical_memory.rst
> 
> > +the selection of the memory model. Memory models are described in more
> > +detail in Documentation/mm/memory-model.rst
> > +
> > +The basic memory descriptor is called :ref:`struct page <Pages>` and it is
> > +essentially a union of several structures, each representing a page frame
> > +metadata for a paricular usage.
> > +
> > +In many cases the entries in the memory map are not treated as `struct page`,
> > +but rather as different types of descriptors such as :ref:`struct folio
> > +<Folios>`, :ref:`struct ptdesc <ptdesc>` or `struct slab`.
> 
> I would hope that just saying "struct folio" would do the right thing;
> did that not happen for you?

`struct folio` links to core-api/mm-api.rst, I wanted a link to the "Folio"
section here.
 
> > -   This section is incomplete. Please list and describe the appropriate fields.
> > +Common fields
> > +~~~~~~~~~~~~~
> > +
> > +``flags``
> > +  This field contains flags which describe the status of the page and
> > +  additional information about the page, like, for instance, zone, section
> > +  and node this page belongs to. Several flags determine how the page is
> > +  used, sometimes in combination with ``page_type`` field. Other flags
> > +  determine the state of the page, for instance if it is dirty or should be
> > +  reclaimed, what LRU list this page is on and many others.
> > +
> > +  All flags are declared in ``include/linux/page-flags.h``. There are a
> > +  number of macros defined for testing, clearing and setting the flags. Page
> > +  flags should not be accessed directly, but only using these macros.
> 
> It would sure be nice if we had documentation for what all the flags
> mean :)

This alone would take another several months :)
 
> > +  The layout of the ``flags`` field depends on the kernel configuration. It
> > +  is affeted by selection of the memory model, section size for SPARSEMEM
> > +
> > +``virtual``
> > +  Virtual address in the kernel direct map. Will be ``NULL`` for highmem
> > +  pages. Only defined for some architectures.
> 
> I'd say virtual is absent more often than present anymore, right?
> Perhaps it's worth being more explicit about that.  And maybe say to use
> page_address() rather than accessing it directly?
> 
> > +Fields shared between multiple types
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +``_mapcount``
> > +  If the page can be mapped to userspace, encodes the number of times this
> > +  page is referenced by a page table.
> > +  Do not use directly, call page_mapcount().
> 
> Have we figured out what mapcount really means yet? :)

It's a number, isn't it? :)
 
> > +``mlock_count``
> > +  Number of times the page has been pinned by mlock().
> > +
> > +Pages on free lists used by the page allocator are linked to the relevant
> > +list with eithter of the two below fields:
> 
> Spellcheckers are your friend :)

I was sure checkpatch.pl does that :(
 
> > +``buddy_list``
> > +  Links the page to one of the free lists in the buddy allocator. Overlaps
> > +  with ``lru``.
> > +
> > +``pcp_list``
> > +  Links the page to a per-cpu free list. Overlaps with ``lru``.
> > +
> > +``mapping``
> > +  The file this page belongs to. Can be pagecache or swapcahe. For
> > +  anonymous memory refers to the `struct anon_vma`.
> > +  See also ``include/linux/page-flags.h`` for ``PAGE_MAPPING_FLAGS``
> 
> It seems like putting in the types for fields like this would be useful;
> readers of the HTML docs can then follow the links and see what is
> actually pointed to.
 
Does sphinx create references for defines? (presuming someone will add
kernel-doc description for them)

> >  Folios
> > -======
> > +------
> 
> As Willy said, linking to the existing docs might be better here.
 
...
 
> It's good to see this documentation being filled in!
> 
> An overall concern that comes to mind is that you're documenting
> something that is very much a moving target.  It's already a bit of an
> awkward fit with the page types that have been split out into their own
> structures, and will become more so as that work proceeds.  The document
> seems likely to go out of date quickly.

I hesitated quite a lot about writing this documentation exactly because of
page types being a moving target. And I decided to give it a go to have
something that will show up in git grep and hopefully people would update
the documentation along with the code changes. (Sorry Willy, I know it's
more work for you).

An alternative is to wait until we completely get rid of struct page and
have this undocumented for quite some time.
 
> I wonder if it might be better to structure it as if the splitting of
> struct page were already complete, with a section for each page
> descriptor type, even the ones that don't exist as separate entities
> yet?  Maybe that would make it easier for people to keep it current as
> they hack pieces out of struct page?

After reading your and Willy's comments, I think description of the fields
in "API reference" style is not what I want to see in this document in the
end. I'd prefer it to target people who want to dig deeper into mm and
understand how things work rather than how to use them.

That's why I think linking kernel-doc here would be suboptimal here because
kernel-doc is API reference and does not describe internal workings in the
majority of cases.

Starting with the comments we have in the code (both kernel-doc and not)
with some additions and alterations seems to me a good starting point.

Just some thoughts :)
 
> Just a thought.
> 
> Thanks,
> 
> jon

-- 
Sincerely yours,
Mike.
