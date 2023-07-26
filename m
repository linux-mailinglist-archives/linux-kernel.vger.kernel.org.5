Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE676401F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjGZUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGZUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2339A1FCF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9EFD61CAD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5203C433C8;
        Wed, 26 Jul 2023 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690401982;
        bh=AZeY2z2NgjtDYunEIr50xtoXJGuiXouk66tb+dsJ1MI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2IXrfCmJqtltWZGEj/Lku8/N3y+UngB1KKljhSCAnveW/mCwPRDhYaGnKkxap07lq
         /tVOUwWYwVEaxczH37wPjqTlIO0YJm1hjkSyqGRrmPgwzMnbes1A50U/J/N0H4HY0B
         0MpwG6XlHXzCBaq2H3pBgB8lT9ik2s0Y3rxFi/I8=
Date:   Wed, 26 Jul 2023 13:06:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Subject: Re: [PATCH v2] mm: page_alloc: consume available CMA space first
Message-Id: <20230726130620.7cd312fdd07722f6050e8bb8@linux-foundation.org>
In-Reply-To: <20230726150705.GA1365610@cmpxchg.org>
References: <20230726145304.1319046-1-hannes@cmpxchg.org>
        <20230726150705.GA1365610@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 11:07:05 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On a memcache setup with heavy anon usage and no swap, we routinely
> see premature OOM kills with multiple gigabytes of free space left:
> 
>     Node 0 Normal free:4978632kB [...] free_cma:4893276kB
> 
> This free space turns out to be CMA. We set CMA regions aside for
> potential hugetlb users on all of our machines, figuring that even if
> there aren't any, the memory is available to userspace allocations.
> 
> When the OOMs trigger, it's from unmovable and reclaimable allocations
> that aren't allowed to dip into CMA. The non-CMA regions meanwhile are
> dominated by the anon pages.
> 
> Movable pages can be migrated out of CMA when necessary, but we don't
> have a mechanism to migrate them *into* CMA to make room for unmovable
> allocations. The only recourse we have for these pages is reclaim,
> which due to a lack of swap is unavailable in our case.
> 
> Because we have more options for CMA pages, change the policy to
> always fill up CMA first. This reduces the risk of premature OOMs.

This conflicts significantly (and more than textually) with "mm:
optimization on page allocation when CMA enabled", which has been
languishing in mm-unstable in an inadequately reviewed state since May
11.  Please suggest a way forward?

