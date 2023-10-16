Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB67C9FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjJPGfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjJPGfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:35:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA4DA2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:35:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9292C433C9;
        Mon, 16 Oct 2023 06:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697438102;
        bh=h7+mxeWvHopjpfHs2M8yjcff71cFlFkVRyP3Nk6y5ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jstQ79TMlhwJYum7iRHmZ3sYsFdhRBmZNHatoTTONDq4i2VQqXW4b1vYrdUg/4W4D
         tlcZBRLmwsoxhCxp2qZ1j72B+TV1FNXpWTD05OpkfF4MNLn1I3OjkCatEbRfabkrdw
         xmSZi6ogdkNHGS/Qoiahu87CmPpHSDzkUNceJ1o3/NlM2gpdleDNJrUK73R+snwRKt
         37IBhXMSnmeXRRg+FfbxX5WojUbiHSneflTGBGzRToWbiQ2Qsr07mGm9CQMau4f7RK
         16wgGzy6tVlgGlc6D3sxIERes1x6pjk9mh9x6XwGZLEMggjmILqnLoXBLsgbvC11f6
         cr4DtyhYP+exA==
Date:   Mon, 16 Oct 2023 09:33:57 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region
 when MEMINIT_EARLY
Message-ID: <20231016063357.GU3303@kernel.org>
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
 <20230929083018.GU3303@kernel.org>
 <f144b910-cd9f-a571-ce9b-a0a8b509c28a@redhat.com>
 <2f8c4741-5c7f-272d-9cef-9fda9fbc7ca6@linux.dev>
 <5382bf2d-5aa0-1498-8169-3248be4b5af3@linux.dev>
 <bf7143f4-9d50-cfc4-0ef6-d312a2cc896b@redhat.com>
 <38cd0cb9-efe9-b98a-2768-ccb48da8b812@linux.dev>
 <20231013084827.GT3303@kernel.org>
 <1c91dd62-886d-bb05-8aee-22191a8a2d8e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c91dd62-886d-bb05-8aee-22191a8a2d8e@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 05:29:19PM +0800, Yajun Deng wrote:
> 
> On 2023/10/13 16:48, Mike Rapoport wrote:
> > On Thu, Oct 12, 2023 at 05:53:22PM +0800, Yajun Deng wrote:
> > > On 2023/10/12 17:23, David Hildenbrand wrote:
> > > > On 10.10.23 04:31, Yajun Deng wrote:
> > > > > On 2023/10/8 16:57, Yajun Deng wrote:
> > > > > > > That looks wrong. if the page count would by pure luck be 0
> > > > > > > already for hotplugged memory, you wouldn't clear the reserved
> > > > > > > flag.
> > > > > > > 
> > > > > > > These changes make me a bit nervous.
> > > > > > Is 'if (page_count(page) || PageReserved(page))' be safer? Or do I
> > > > > > need to do something else?
> > > > > > 
> > > > > How about the following if statement? But it needs to add more patch
> > > > > like v1 ([PATCH 2/4] mm: Introduce MEMINIT_LATE context).
> > > > > 
> > > > > It'll be safer, but more complex. Please comment...
> > > > > 
> > > > >      if (context != MEMINIT_EARLY || (page_count(page) ||
> > > > > PageReserved(page)) {
> > > > > 
> > > > Ideally we could make initialization only depend on the context, and not
> > > > check for count or the reserved flag.
> > > > 
> > > This link is v1,
> > > https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
> > > 
> > > If we could make initialization only depend on the context, I'll modify it
> > > based on v1.
> > Although ~20% improvement looks impressive, this is only optimization of a
> > fraction of the boot time, and realistically, how much 56 msec saves from
> > the total boot time when you boot a machine with 190G of RAM?
> 
> There are a lot of factors that can affect the total boot time. 56 msec
> saves may be insignificant.
> 
> But if we look at the boot log, we'll see there's a significant time jump.
> 
> before:
> 
> [    0.250334] ACPI: PM-Timer IO Port: 0x508
> [    0.618994] Memory: 173413056K/199884452K available (18440K kernel code,
> 
> after:
> 
> [    0.260229] software IO TLB: area num 32.
> [    0.563497] Memory: 173413056K/199884452K available (18440K kernel code,
> 
> Memory initialization is time consuming in the boot log.

You just confirmed that 56 msec is insignificant and then you send again
the improvement of ~60 msec in memory initialization.

What does this improvement gain in percentage of total boot time?
 
> > I still think the improvement does not justify the churn, added complexity
> > and special casing of different code paths of initialization of struct pages.
> 
> 
> Because there is a loop, if the order is MAX_ORDER, the loop will run 1024
> times. The following 'if' would be safer:
> 
> 'if (context != MEMINIT_EARLY || (page_count(page) || >> PageReserved(page))
> {'

No, it will not.

As the matter of fact any condition here won't be 'safer' because it makes
the code more complex and less maintainable. 
Any future change in __free_pages_core() or one of it's callers will have
to reason what will happen with that condition after the change.

-- 
Sincerely yours,
Mike.
