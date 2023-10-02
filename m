Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F817B50E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjJBLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjJBLLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:11:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C5BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:11:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33FBC433CB;
        Mon,  2 Oct 2023 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696245112;
        bh=kbkrwKTyIxylaq6Q7PjftUb//yn55MwJY/P5RMw2Ddw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNWQHKrqVZDQP0mmpkxARDUq+RNr6KswvMEDjZDX4RVENMK8hvS9EUzVFtndr8B2y
         rBSxbYVgClaPoG4LUz/4glx4iD/b/wxCWNh1O7GEH5+2g7Hx5iNXETPVqKhQNzjpko
         sEuRciF/UNG5g5YUROS4Nd56PyxAbmjeaOqAwEBSHp2wleTnp8PiO2aY5I6WeidB8d
         fEYpj3Q+mcTKf751o+R4yMdR/fGEsCrqA5Xx3tB2UJxb7ZFVBOdf3jR2p/zOugFx8a
         A36bF0lBnIyZcQ4tpDfEZF2xLrXv/oJdgzf9IelJ9XeBC33/nFHAMxNbAPEtHqV923
         8No7Txsv48EDw==
Date:   Mon, 2 Oct 2023 14:10:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region
 when MEMINIT_EARLY
Message-ID: <20231002111051.GA3303@kernel.org>
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
 <20231002084708.GZ3303@kernel.org>
 <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7e6f67a-4cac-73bd-1d5e-5020c6c8423d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:56:51AM +0200, David Hildenbrand wrote:
> On 02.10.23 10:47, Mike Rapoport wrote:
> > On Mon, Oct 02, 2023 at 03:03:56PM +0800, Yajun Deng wrote:
> > > 
> > > On 2023/10/2 02:59, Mike Rapoport wrote:
> > > > On Fri, Sep 29, 2023 at 06:27:25PM +0800, Yajun Deng wrote:
> > > > > On 2023/9/29 18:02, Mike Rapoport wrote:
> > > > > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > > > > index 06be8821d833..b868caabe8dc 100644
> > > > > > > > > --- a/mm/page_alloc.c
> > > > > > > > > +++ b/mm/page_alloc.c
> > > > > > > > > @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
> > > > > > > > >      	unsigned int loop;
> > > > > > > > >      	/*
> > > > > > > > > -	 * When initializing the memmap, __init_single_page() sets the refcount
> > > > > > > > > -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
> > > > > > > > > -	 * refcount of all involved pages to 0.
> > > > > > > > > +	 * When initializing the memmap, memmap_init_range sets the refcount
> > > > > > > > > +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
> > > > > > > > > +	 * have to set the refcount of all involved pages to 0. Otherwise,
> > > > > > > > > +	 * we don't do it, as reserve_bootmem_region only set the refcount on
> > > > > > > > > +	 * reserve region ("reserved") in early context.
> > > > > > > > >      	 */
> > > > > > > > Again, why hotplug and early init should be different?
> > > > > > > I will add a comment that describes it will save boot time.
> > > > > > But why do we need initialize struct pages differently at boot time vs
> > > > > > memory hotplug?
> > > > > > Is there a reason memory hotplug cannot have page count set to 0 just like
> > > > > > for pages reserved at boot time?
> > > > > This patch just save boot time in MEMINIT_EARLY. If someone finds out that
> > > > > it can save time in
> > > > > 
> > > > > MEMINIT_HOTPLUG, I think it can be done in another patch later. I just
> > > > > keeping it in the same.
> > > > But it's not the same. It becomes slower after your patch and the code that
> > > > frees the pages for MEMINIT_EARLY and MEMINIT_HOTPLUG becomes non-uniform
> > > > for no apparent reason.
> > > 
> > > __free_pages_core will also be called by others, such as:
> > > deferred_free_range, do_collection and memblock_free_late.
> > > 
> > > We couldn't remove  'if (page_count(page))' even if we set page count to 0
> > > when MEMINIT_HOTPLUG.
> > 
> > That 'if' breaks the invariant that __free_pages_core is always called for
> > pages with initialized page count. Adding it may lead to subtle bugs and
> > random memory corruption so we don't want to add it at the first place.
> 
> As long as we have to special-case memory hotplug, we know that we are
> always coming via generic_online_page() in that case. We could either move
> some logic over there, or let __free_pages_core() know what it should do.

Looks like the patch rather special cases MEMINIT_EARLY, although I didn't
check throughfully other code paths. 
Anyway, relying on page_count() to be correct in different ways for
different callers of __free_pages_core() does not sound right to me.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
