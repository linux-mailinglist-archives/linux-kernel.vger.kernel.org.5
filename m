Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25175C5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGULVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGULVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20F61715
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4C16108F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9653AC433C7;
        Fri, 21 Jul 2023 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689938466;
        bh=BzBxawFQt5qhrvYcwhomchR2CqahWS/ymIYjhFBgoqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XsjvvGPpndF9yS3zP1iCeDpNZe+YlaD4Fu+pMZdGApEacI6HEiT8oezvPD51NEBB0
         q/4GqelFAXi5yTUMmT4AWwJBF2Y8EpmR799S8I3hmPZKSX1/2lPd9xfQzWm2Mq6fap
         hEELWiiOsbffDoGOx0cClUBH6q7EKI22E++bbcjJoQxf8Kpk2ReRo+h4nQHoGNj3+x
         T3q2EVBgKkQ2oGT6/FLcyKIRInUGqFMwSFULPS7z+WUMgFqD67qW8Y83NCyd1cBdIb
         kKLPEBUxR1h8NQlFU+/2vVnpiPCbzKndDpo8FLvRkGHhqd9Uejmq6rwYO2FfCrQJZW
         9rDoyzfh8AYvg==
Date:   Fri, 21 Jul 2023 14:20:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230721112009.GP1901145@kernel.org>
References: <20230718220106.GA3117638@google.com>
 <20230719054434.GG1901145@kernel.org>
 <20230719222604.GB3528218@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719222604.GB3528218@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 04:26:04PM -0600, Ross Zwisler wrote:
> On Wed, Jul 19, 2023 at 08:44:34AM +0300, Mike Rapoport wrote:
> > 3. Switch memblock to use bottom up allocations. Historically memblock
> > allocated memory from the top to avoid corrupting the kernel image and to
> > avoid exhausting precious ZONE_DMA. I believe we can use bottom-up
> > allocations with lower limit of memblock allocations set to 16M.
> > 
> > With the hack below no memblock allocations will end up in ZONE_MOVABLE:
> 
> Yep, I've confirmed that for my use cases at least this does the trick, thank
> you!  I had thought about moving the memblock allocations, but had no idea it
> was (basically) already supported and thought it'd be much riskier than just
> adjusting where ZONE_MOVABLE lived.
> 
> Is there a reason for this to not be a real option for users, maybe per a
> kernel config knob or something?  I'm happy to explore other options in this
> thread, but this is doing the trick so far.

I think we can make x86 always use bottom up.

To do this properly we'd need to set lower limit for memblock allocations
to MAX_DMA32_PFN and allow fallback below it so that early allocations
won't eat memory from ZONE_DMA32.

Aside from x86 boot being fragile in general I don't see why this wouldn't
work.

-- 
Sincerely yours,
Mike.
