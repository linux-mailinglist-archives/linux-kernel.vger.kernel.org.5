Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DE793D26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbjIFMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjIFMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:53:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012EBE43;
        Wed,  6 Sep 2023 05:52:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDDC433C7;
        Wed,  6 Sep 2023 12:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694004779;
        bh=IEQWAcQjvy0vq8Wt0nLK8PBigx3I9ooqM2Ln/kxqa8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuTtdlafUYrrBR4SAd4A5R/rmJEvoZrOtMKNmsb1+9+RJvg+HEFQSBA3+UveWLrMe
         KoDhNOr7CWOoxzPSC/OPiRC7408bRdYFuz/ynqg+URjQETLUPKwqQfeJTOGjBeZcuw
         pj9P/EpNrGTxEq5Rre/G6MzazlxmXWsM2UPdcL/MsW6rZks1LQ49jcdMPLopbnpd8x
         9NQeCyC2esxQVktTzYzpLG7FUeUvdtomN5s3t8iJTCJJ6y/fmC5SyzaIo5IzpfFKOK
         qP8cZxRUwL7l7oWAWvPVze+ENNHIBivObQQ8xs1RSjkbOlrQPH2NcYMkem61+cQIHG
         P1FcuZSPKe2/w==
Date:   Wed, 6 Sep 2023 15:52:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add "Memory map" section
Message-ID: <20230906125214.GK3223@kernel.org>
References: <20230906074210.3051751-1-rppt@kernel.org>
 <ZPhurt9P7hnsVvua@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPhurt9P7hnsVvua@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:21:02PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 06, 2023 at 10:42:10AM +0300, Mike Rapoport wrote:
> > +The basic memory descriptor is called :ref:`struct page <Pages>` and it is
> > +essentially a union of several structures, each representing a page frame
> > +metadata for a paricular usage.
> 
> "each representing page frame metadata".  And "particular".

sure
 
> >  Folios
> > -======
> > +------
> >  
> > -.. admonition:: Stub
> > +`struct folio` represents a physically, virtually and logically contiguous
> > +set of bytes. It is a power-of-two in size, and it is aligned to that same
> > +power-of-two. It is at least as large as ``PAGE_SIZE``. If it is in the
> > +page cache, it is at a file offset which is a multiple of that
> > +power-of-two. It may be mapped into userspace at an address which is at an
> > +arbitrary page offset, but its kernel virtual address is aligned to its
> > +size.
> >  
> > -   This section is incomplete. Please list and describe the appropriate fields.
> > +`struct folio` occupies several consecutive entries in the memory map and
> > +has the following fields:
> > +
> > +``flags``
> > +  Identical to the page flags.
> > +
> > +``lru``
> > +  Least Recently Used list; tracks how recently this folio was used.
> > +
> > +``mlock_count``
> > +  Number of times this folio has been pinned by mlock().
> > +
> > +``mapping``
> > +  The file this page belongs to. Can be pagecache or swapcahe. For
> > +  anonymous memory refers to the `struct anon_vma`.
> > +
> > +``index``
> > +  Offset within the file, in units of pages. For anonymous memory, this is
> > +  the index from the beginning of the mmap.
> > +
> > +``private``
> > +  Filesystem per-folio data (see folio_attach_private()). Used for
> > +  ``swp_entry_t`` if folio is in the swap cache
> > +  (i.e. folio_test_swapcache() is true)
> > +
> > +``_mapcount``
> > +  Do not access this member directly. Use folio_mapcount() to find out how
> > +  many times this folio is mapped by userspace.
> > +
> > +``_refcount``
> > +  Do not access this member directly. Use folio_ref_count() to find how
> > +  many references there are to this folio.
> > +
> > +``memcg_data``
> > +  Memory Control Group data.
> > +
> > +``_folio_dtor``
> > +  Which destructor to use for this folio.
> > +
> > +``_folio_order``
> > +  The allocation order of a folio. Do not use directly, call folio_order().
> > +
> > +``_entire_mapcount``
> > +  How many times the entire folio is mapped as a single unit (for example
> > +  by a PMD or PUD entry). Does not include PTE-mapped subpages. This might
> > +  be useful for debugging, but to find out how many times the folio is
> > +  mapped look at folio_mapcount() or page_mapcount() or total_mapcount()
> > +  instead.
> > +  Do not use directly, call folio_entire_mapcount().
> > +
> > +``_nr_pages_mapped``
> > +  The total number of times the folio is mapped.
> > +  Do not use directly, call folio_mapcount().
> > +
> > +``_pincount``
> > +  Used to track pinning of the folio for DMA.
> > +  Do not use directly, call folio_maybe_dma_pinned().
> > +
> > +``_folio_nr_pages``
> > +  The number of pages in the folio.
> > +  Do not use directly, call folio_nr_pages().
> > +
> > +``_hugetlb_subpool``
> > +  HugeTLB subpool the folio beongs to.
> > +  Do not use directly, use accessor in ``include/linux/hugetlb.h``.
> > +
> > +``_hugetlb_cgroup``
> > +  Memory Control Group data for a HugeTLB folio.
> > +  Do not use directly, use accessor in ``include/linux/hugetlb_cgroup.h``.
> > +
> > +``_hugetlb_cgroup_rsvd``
> > +  Memory Control Group data for a HugeTLB folio.
> > +  Do not use directly, use accessor in ``include/linux/hugetlb_cgroup.h``.
> > +
> > +``_hugetlb_hwpoison``
> > +  List of failed (hwpoisoned) pages for a HugeTLB folio.
> > +  Do not use directly, call raw_hwp_list_head().
> > +
> > +``_deferred_list``
> > +  Folios to be split under memory pressure.
> 
> I don't understand why you've done all this instead of linking to the
> kernel-doc I wrote.

We can't have it both in Documentation/core-api/mm-api.rst and here without
sphinx complaining: 

Documentation/mm/physical_memory:561: include/linux/mm_types.h:3: WARNING: Duplicate C declaration, also defined at core-api/mm-api:3.
Declaration is '.. c:struct:: folio'.

-- 
Sincerely yours,
Mike.
