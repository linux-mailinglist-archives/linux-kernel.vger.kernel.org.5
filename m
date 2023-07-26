Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04E6763777
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjGZNYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjGZNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990971FFA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3799961A3D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58562C433C8;
        Wed, 26 Jul 2023 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690377833;
        bh=RMJHNPuU7N+ifmLTxkLjkm+2qqsjVUIwz7cKJtDoWbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F/9e740JSt/fg+KTnjEJpsCcx4fWypXGT4Lr0x/lLPs12tVTqPVVtts97My4841L2
         /y+6z/mj00yqiKQzILkiDXsS2N2zxbWHEvy8NSSm184Y+cNuGwwEAGq1GiZBanFuy1
         Q7dkOwekJ13EVtH8hyPKeIH774ljmz6wBLSASLTYFCEUCyd/dH4q/DlLIlJRLEJYKp
         +PPNAMUTQcWOBXkpsE6x7Vtsx6Cj0tKmuo4yZ7po/JLR1ysZ0NCM8FCsGplIiyLGLl
         HLQDWxufS86yv1rLUUX0R9/gJ7fofNiJRxdT3V2R/7wV30kr/LAi8QiaPDCgc5u51G
         yoWqAIkRwoTUg==
Date:   Wed, 26 Jul 2023 16:23:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230726132317.GW1901145@kernel.org>
References: <20230718220106.GA3117638@google.com>
 <20230719054434.GG1901145@kernel.org>
 <20230719222604.GB3528218@google.com>
 <20230721112009.GP1901145@kernel.org>
 <ZMDP+D54MoI9boYJ@dhcp22.suse.cz>
 <20230726104845.GS1901145@kernel.org>
 <ZMEYU4AlS0Vw7XIj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMEYU4AlS0Vw7XIj@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:57:55PM +0200, Michal Hocko wrote:
> On Wed 26-07-23 13:48:45, Mike Rapoport wrote:
> > On Wed, Jul 26, 2023 at 09:49:12AM +0200, Michal Hocko wrote:
> > > On Fri 21-07-23 14:20:09, Mike Rapoport wrote:
> > > > On Wed, Jul 19, 2023 at 04:26:04PM -0600, Ross Zwisler wrote:
> > > > > On Wed, Jul 19, 2023 at 08:44:34AM +0300, Mike Rapoport wrote:
> > > > > > 3. Switch memblock to use bottom up allocations. Historically memblock
> > > > > > allocated memory from the top to avoid corrupting the kernel image and to
> > > > > > avoid exhausting precious ZONE_DMA. I believe we can use bottom-up
> > > > > > allocations with lower limit of memblock allocations set to 16M.
> > > > > > 
> > > > > > With the hack below no memblock allocations will end up in ZONE_MOVABLE:
> > > > > 
> > > > > Yep, I've confirmed that for my use cases at least this does the trick, thank
> > > > > you!  I had thought about moving the memblock allocations, but had no idea it
> > > > > was (basically) already supported and thought it'd be much riskier than just
> > > > > adjusting where ZONE_MOVABLE lived.
> > > > > 
> > > > > Is there a reason for this to not be a real option for users, maybe per a
> > > > > kernel config knob or something?  I'm happy to explore other options in this
> > > > > thread, but this is doing the trick so far.
> > > > 
> > > > I think we can make x86 always use bottom up.
> > > > 
> > > > To do this properly we'd need to set lower limit for memblock allocations
> > > > to MAX_DMA32_PFN and allow fallback below it so that early allocations
> > > > won't eat memory from ZONE_DMA32.
> > > > 
> > > > Aside from x86 boot being fragile in general I don't see why this wouldn't
> > > > work.
> > > 
> > > This would add a very subtle depency of a functionality on the specific
> > > boot allocator behavior and that is bad for long term maintenance.
> > 
> > What do you mean by "specific boot allocator behavior"?
> 
> I mean that the expectation that the boot allocator starts from low
> addresses and functionality depending on that is too fragile. This has
> already caused some problems in the past IIRC.

Well, any change in x86 boot sequence may cause all sorts of problems :)

We do some of the boot time allocations from low addresses when
movable_node is enabled and that is entirely implicit and buried deep
inside the code.

What I'm suggesting is to switch the allocations to bottom-up once and for
all with explicitly set lower limit and a defined semantics for a fallback.
 
This might cause some bumps in the beginning, but I don't expect it to be a
maintenance problem in the long run.

And it will free higher memory from early allocations for all usecases, not
just this one.

> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
