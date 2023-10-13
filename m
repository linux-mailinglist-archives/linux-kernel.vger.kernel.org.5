Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD667C80B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjJMIti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjJMIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:49:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D77136
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:49:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F714C433C7;
        Fri, 13 Oct 2023 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697186967;
        bh=HgjG8dXJseeEMaKwgvPf4GwIryB+0yn5uNjJ0rz99XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjGAhUltjuJA2XNhwyr0qRX/QPcKHGR+xBp7blnN3CuekjNPJ10dK91M1VFr5rrsF
         f72hv/KgddY+FYgM1hwIMzc7xFAFjz445ykEmp9+VOxwaSoaKkWENedQOn53yRgXU8
         Zka5wtoybkbuDL02DBSwi7IyJM/ki5Ole9zKoOngTXaEGBX140BMqYhDtTx0DaIvV/
         QCgGQzK7ppL+F+60BNLBXWGDHUJH36P6h+9VfFS9wMINIvdDfxBHplPXaNJ6VijI7g
         jF02GmDzScVqJzyzOAmfx+stRpltbFk+6aoa7A6Ak2WR1T9n536wb0EY/xPelkej7a
         Wqop4NhhKsy/Q==
Date:   Fri, 13 Oct 2023 11:48:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region
 when MEMINIT_EARLY
Message-ID: <20231013084827.GT3303@kernel.org>
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <f144b910-cd9f-a571-ce9b-a0a8b509c28a@redhat.com>
 <2f8c4741-5c7f-272d-9cef-9fda9fbc7ca6@linux.dev>
 <5382bf2d-5aa0-1498-8169-3248be4b5af3@linux.dev>
 <bf7143f4-9d50-cfc4-0ef6-d312a2cc896b@redhat.com>
 <38cd0cb9-efe9-b98a-2768-ccb48da8b812@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38cd0cb9-efe9-b98a-2768-ccb48da8b812@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:53:22PM +0800, Yajun Deng wrote:
> 
> On 2023/10/12 17:23, David Hildenbrand wrote:
> > On 10.10.23 04:31, Yajun Deng wrote:
> > > 
> > > On 2023/10/8 16:57, Yajun Deng wrote:
> > > > > 
> > > > > That looks wrong. if the page count would by pure luck be 0
> > > > > already for hotplugged memory, you wouldn't clear the reserved
> > > > > flag.
> > > > > 
> > > > > These changes make me a bit nervous.
> > > > 
> > > > Is 'if (page_count(page) || PageReserved(page))' be safer? Or do I
> > > > need to do something else?
> > > > 
> > > 
> > > How about the following if statement? But it needs to add more patch
> > > like v1 ([PATCH 2/4] mm: Introduce MEMINIT_LATE context).
> > > 
> > > It'll be safer, but more complex. Please comment...
> > > 
> > >     if (context != MEMINIT_EARLY || (page_count(page) ||
> > > PageReserved(page)) {
> > > 
> > 
> > Ideally we could make initialization only depend on the context, and not
> > check for count or the reserved flag.
> > 
> 
> This link is v1,
> https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
> 
> If we could make initialization only depend on the context, I'll modify it
> based on v1.

Although ~20% improvement looks impressive, this is only optimization of a
fraction of the boot time, and realistically, how much 56 msec saves from
the total boot time when you boot a machine with 190G of RAM?

I still think the improvement does not justify the churn, added complexity
and special casing of different code paths of initialization of struct pages.
 
> @Mike,  By the way,  this code will cost more time:
> 
>                 if (context == MEMINIT_HOTPLUG)
>                         flags = INIT_PAGE_COUNT | INIT_PAGE_RESERVED;
>                 __init_single_page(page, pfn, zone, nid, flags);
> 
> 
> [    0.014999] On node 0, zone DMA32: 31679 pages in unavailable ranges
> [    0.311560] ACPI: PM-Timer IO Port: 0x508
> 
> 
> This code will cost less time:
> 
>                 __init_single_page(page, pfn, zone, nid, 0);
>                 if (context == MEMINIT_HOTPLUG) {
>                         init_page_count(page);
>                         __SetPageReserved(page);
> 
> [    0.014299] On node 0, zone DMA32: 31679 pages in unavailable ranges
> [    0.250223] ACPI: PM-Timer IO Port: 0x508
> 

-- 
Sincerely yours,
Mike.
