Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B786478D284
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbjH3DZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjH3DYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:24:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC2113
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oNvnXO07Rwkegf1zt9eCJPkOO0J/3P+q6I5X1kBu2TE=; b=ah7a8XAekVCtIlWVVydgHbN5Xy
        zdlPIXS7LZ6eeaP5CqURZFZabefgSkFVv8lLCdfjW49mF59UeOse+2I8nt0g85NAi/aMXTAfJpgs7
        kzuFSX2516YLzN3hU93+elZswyb4i6wl+QvXP7I80+qrpqM5N37/L7MYDeLfngsB9ksWgi2z/4ekn
        YR8jYM1TUbk72bRUWmr86emsCmQMFBnkyaRy1IpgI8ZAc5S7e6XXpjpV7U1PkxFnvYxqFrkuwurRL
        csd+MNwAK6q1IbePisPus4d4Lms0V7xMzCwSewa4r8puNd+Iiy//957XuzhfJxpC+t3TVw1cX1jnw
        O0+7Rezg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qbBom-00APwj-K4; Wed, 30 Aug 2023 03:24:32 +0000
Date:   Wed, 30 Aug 2023 04:24:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: Tighten up cmdline_parse_stack_guard_gap()
Message-ID: <ZO62cBiupJaqk0UZ@casper.infradead.org>
References: <20230828052212.748872-1-anshuman.khandual@arm.com>
 <ZO3pz+3fAihhrtMU@casper.infradead.org>
 <c90a582d-37b9-4260-b82b-42cc7166773e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c90a582d-37b9-4260-b82b-42cc7166773e@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:47:12AM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/29/23 18:21, Matthew Wilcox wrote:
> > On Mon, Aug 28, 2023 at 10:52:12AM +0530, Anshuman Khandual wrote:
> >> -static int __init cmdline_parse_stack_guard_gap(char *p)
> >> +static int __init cmdline_parse_stack_guard_gap(char *str)
> >>  {
> >>  	unsigned long val;
> >> -	char *endptr;
> >>  
> >> -	val = simple_strtoul(p, &endptr, 10);
> >> -	if (!*endptr)
> >> -		stack_guard_gap = val << PAGE_SHIFT;
> >> +	if (!str)
> >> +		return 0;
> > 
> > Please explain how this function can be called with a NULL pointer.
> 
> This is an additional check just in case. We have similar constructs
> in the following __setup() functions as well.

In case of _what_?  Somebody goes insane and decides to start calling
__setup functions with NULL pointers?  We don't test "Did the VFS call
this filesystem with a NULL inode pointer" because that would make
ZERO sense.  Defensive programming doesn't need to defend against an
insane kernel core.

> __setup("hashdist=", set_hashdist)
> __setup("numa_balancing=", setup_numabalancing)
> __setup("transparent_hugepage=", setup_transparent_hugepage)

Those should have this stupid NULL check removed.

> > Now you've removed the abillity for someone to say stack_guard_gap=0,
> > which seems potentially useful.
> 
> In that case, should the following two scenarios be differentiated ?
> 
> * stack_guard_gap=	- Retains DEFAULT_STACK_GUARD_GAP
> * stack_guard_gap=0	- Changes to 0 pages

I don't know.  You appear to have run into the scenario where
'stack_guard_gap=' was specified.  What did you expect it to do?
