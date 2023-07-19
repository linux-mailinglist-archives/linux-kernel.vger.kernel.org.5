Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CC758FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGSIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSIAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E989D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED5EA612E1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49482C433C8;
        Wed, 19 Jul 2023 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689753616;
        bh=NTb4KuKKWr4nc9YdxvCXJe6mrt/xu9Zh8G0AeS4XV4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkDmlNul1ZIiLTrknFa35/tFU8UA4MAK9oBy4J9L/GcA7AU/vugIuFM4V1xVAjCrB
         suEHTw8Itt8Z6YtWAh03Xc3fuMufsLVMfNp34se3oOcgdObERDMTT4cyY0RThVwvZC
         29FT00hI+c0JvnGs/smwONyn3Vq/8tZRmhukMyLb7kRtE03PyW7B5Lb5jBY9nuFGyS
         pLOCEveAyWuJ/SZ/DK7B0B6BlFLjuaM81AZ2Cs4bB09dErIlmAtyEcgxSpd32+UY1F
         VPNoiPmlPiKeoIc6TneN0PUiiOczjUge+g9v8x8tzM3GPu85tB4I8MdurTRf0vVebm
         /Dom2D/x4X9Qw==
Date:   Wed, 19 Jul 2023 10:59:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230719075952.GH1901145@kernel.org>
References: <20230718220106.GA3117638@google.com>
 <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLd/WEZTH5rlwYjP@dhcp22.suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:14:48AM +0200, Michal Hocko wrote:
> On Tue 18-07-23 16:01:06, Ross Zwisler wrote:
> [...]
> > I do think that we need to fix this collision between ZONE_MOVABLE and memmap
> > allocations, because this issue essentially makes the movablecore= kernel
> > command line parameter useless in many cases, as the ZONE_MOVABLE region it
> > creates will often actually be unmovable.
> 
> movablecore is kinda hack and I would be more inclined to get rid of it
> rather than build more into it. Could you be more specific about your
> use case?
> 
> > Here are the options I currently see for resolution:
> > 
> > 1. Change the way ZONE_MOVABLE memory is allocated so that it is allocated from
> > the beginning of the NUMA node instead of the end. This should fix my use case,
> > but again is prone to breakage in other configurations (# of NUMA nodes, other
> > architectures) where ZONE_MOVABLE and memblock allocations might overlap.  I
> > think that this should be relatively straightforward and low risk, though.
> > 
> > 2. Make the code which processes the movablecore= command line option aware of
> > the memblock allocations, and have it choose a region for ZONE_MOVABLE which
> > does not have these allocations. This might be done by checking for
> > PageReserved() as we do with offlining memory, though that will take some boot
> > time reordering, or we'll have to figure out the overlap in another way. This
> > may also result in us having two ZONE_NORMAL zones for a given NUMA node, with
> > a ZONE_MOVABLE section in between them.  I'm not sure if this is allowed?
> 
> Yes, this is no problem. Zones are allowed to be sparse.

The current initialization order is roughly

* very early initialization with some memblock allocations
* determine zone locations and sizes
* initialize memory map	
  - memblock_alloc(lots of memory)
* lots of unrelated initializations that may allocate memory
* release free pages from memblock to the buddy allocator

With 2) we can make sure the memory map and early allocations won't be in
the ZONE_MOVABLE, but we'll still may have reserved pages there.

> > If
> > we can get it working, this seems like the most correct solution to me, but
> > also the most difficult and risky because it involves significant changes in
> > the code for memory setup at early boot.
> > 
> > Am I missing anything are there other solutions we should consider, or do you
> > have an opinion on which solution we should pursue?
> 
> If this really needs to be addressed than 2) is certainly a more robust
> approach.
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
