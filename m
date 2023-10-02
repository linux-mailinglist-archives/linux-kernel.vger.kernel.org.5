Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018457B4D94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjJBIsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbjJBIsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:48:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88019FF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:48:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702F8C433C8;
        Mon,  2 Oct 2023 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696236489;
        bh=Mbepew5UdVhXx+0duNyVREkgDb2p+7tZH/hGyq1uSvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zt1LD1UbmFQSJqxNvMaUKcv/oVjDpo81EnhRL2Hjzbqf1tcPjge8dF6ujgy208Nzb
         F+1NSJWlsIlm1fdVrMvmLvucwERK6NNoxXSvUX4R7gIdVhCBxrRcNTORZX0rFTXhI9
         LDXLtahAIuQbXFck8S2gq5/ojilc7kov9K9bK5O0kXRSaqIME6tR+2y6LKjDsp5hIn
         DQ/3VmfI8UTocJy4TtQo0XDLa06NGeszqtDgTilYY7SssOeXeV/glxTGr5k8iU8VZ5
         d0MmSGTf3RdMb96Ys5oC8Gx5I/AxyhJJFGt77GAuE4GNGBnsEXbOkLXRYPJPf4PFBZ
         XhyOJtGA2hpeQ==
Date:   Mon, 2 Oct 2023 11:47:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region
 when MEMINIT_EARLY
Message-ID: <20231002084708.GZ3303@kernel.org>
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <a6a20ff9-385c-639f-75cf-ce73a01d97cf@linux.dev>
 <20230929100252.GW3303@kernel.org>
 <15233624-f32e-172e-b2f6-7ca7bffbc96d@linux.dev>
 <20231001185934.GX3303@kernel.org>
 <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90342474-432a-9fe3-2f11-915a04f0053f@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:03:56PM +0800, Yajun Deng wrote:
> 
> On 2023/10/2 02:59, Mike Rapoport wrote:
> > On Fri, Sep 29, 2023 at 06:27:25PM +0800, Yajun Deng wrote:
> > > On 2023/9/29 18:02, Mike Rapoport wrote:
> > > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > > index 06be8821d833..b868caabe8dc 100644
> > > > > > > --- a/mm/page_alloc.c
> > > > > > > +++ b/mm/page_alloc.c
> > > > > > > @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
> > > > > > >     	unsigned int loop;
> > > > > > >     	/*
> > > > > > > -	 * When initializing the memmap, __init_single_page() sets the refcount
> > > > > > > -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
> > > > > > > -	 * refcount of all involved pages to 0.
> > > > > > > +	 * When initializing the memmap, memmap_init_range sets the refcount
> > > > > > > +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
> > > > > > > +	 * have to set the refcount of all involved pages to 0. Otherwise,
> > > > > > > +	 * we don't do it, as reserve_bootmem_region only set the refcount on
> > > > > > > +	 * reserve region ("reserved") in early context.
> > > > > > >     	 */
> > > > > > Again, why hotplug and early init should be different?
> > > > > I will add a comment that describes it will save boot time.
> > > > But why do we need initialize struct pages differently at boot time vs
> > > > memory hotplug?
> > > > Is there a reason memory hotplug cannot have page count set to 0 just like
> > > > for pages reserved at boot time?
> > > This patch just save boot time in MEMINIT_EARLY. If someone finds out that
> > > it can save time in
> > > 
> > > MEMINIT_HOTPLUG, I think it can be done in another patch later. I just
> > > keeping it in the same.
> > But it's not the same. It becomes slower after your patch and the code that
> > frees the pages for MEMINIT_EARLY and MEMINIT_HOTPLUG becomes non-uniform
> > for no apparent reason.
> 
> __free_pages_core will also be called by others, such as:
> deferred_free_range, do_collection and memblock_free_late.
> 
> We couldn't remove  'if (page_count(page))' even if we set page count to 0
> when MEMINIT_HOTPLUG.

That 'if' breaks the invariant that __free_pages_core is always called for
pages with initialized page count. Adding it may lead to subtle bugs and
random memory corruption so we don't want to add it at the first place.

-- 
Sincerely yours,
Mike.
