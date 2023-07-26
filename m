Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBA762EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjGZH5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjGZH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:56:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E96F7299
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:49:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A53921D5C;
        Wed, 26 Jul 2023 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690357753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GONJa8tzUwqKA0Fz+wB3U1k6lRkAIjy3GSK0vW8uCcE=;
        b=joabLHJaqcBy5EOkcJ/+cXWbBd5JWYFFbiCuer3a/tc7fWHsOeV8TEvKSuciFuNDUBiJ6W
        K1lWHyWK28xzic4hIpByu5BwKQhKgITs56ZfTAF5OlP9c1v3b+qUR3Qqt++Fwd87LBqgjv
        DkBqFo4aQVUb02Kv1ckXdQQJHrgUOlM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C0341341F;
        Wed, 26 Jul 2023 07:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EPN5APnPwGTrMAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 26 Jul 2023 07:49:13 +0000
Date:   Wed, 26 Jul 2023 09:49:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <ZMDP+D54MoI9boYJ@dhcp22.suse.cz>
References: <20230718220106.GA3117638@google.com>
 <20230719054434.GG1901145@kernel.org>
 <20230719222604.GB3528218@google.com>
 <20230721112009.GP1901145@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721112009.GP1901145@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-07-23 14:20:09, Mike Rapoport wrote:
> On Wed, Jul 19, 2023 at 04:26:04PM -0600, Ross Zwisler wrote:
> > On Wed, Jul 19, 2023 at 08:44:34AM +0300, Mike Rapoport wrote:
> > > 3. Switch memblock to use bottom up allocations. Historically memblock
> > > allocated memory from the top to avoid corrupting the kernel image and to
> > > avoid exhausting precious ZONE_DMA. I believe we can use bottom-up
> > > allocations with lower limit of memblock allocations set to 16M.
> > > 
> > > With the hack below no memblock allocations will end up in ZONE_MOVABLE:
> > 
> > Yep, I've confirmed that for my use cases at least this does the trick, thank
> > you!  I had thought about moving the memblock allocations, but had no idea it
> > was (basically) already supported and thought it'd be much riskier than just
> > adjusting where ZONE_MOVABLE lived.
> > 
> > Is there a reason for this to not be a real option for users, maybe per a
> > kernel config knob or something?  I'm happy to explore other options in this
> > thread, but this is doing the trick so far.
> 
> I think we can make x86 always use bottom up.
> 
> To do this properly we'd need to set lower limit for memblock allocations
> to MAX_DMA32_PFN and allow fallback below it so that early allocations
> won't eat memory from ZONE_DMA32.
> 
> Aside from x86 boot being fragile in general I don't see why this wouldn't
> work.

This would add a very subtle depency of a functionality on the specific
boot allocator behavior and that is bad for long term maintenance.
-- 
Michal Hocko
SUSE Labs
