Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1896A764E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjG0Ix2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjG0Iwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:52:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A611C8A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:34:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 514AF21AF5;
        Thu, 27 Jul 2023 08:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690446801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKEeRgCOuMXVv+dy5V7kKodknnAI3DeJtAcs76fCCWc=;
        b=BP0pIDFxBzhK5Y1rJuiurwlH5lPQtfJNnnWEM7+0TB+d6LT0v4q9d5tYr4k/D/WNEA52A2
        jI1g+AR9nVz6V1FoiG9e6yYdsW4E5DDziVWr/3bjIDIENjFTS8XY8UWI7RHpRe3lFGxe+d
        ycDDi0kmkCAHl/vhXGOhCEttTnzbHYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690446801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gKEeRgCOuMXVv+dy5V7kKodknnAI3DeJtAcs76fCCWc=;
        b=pJyh2Enik6eYxH8uTutVUUgCuv9AqFaORxpc4UFmv0i12YZc/ARvt/8QNNqrD4TXaC4ESt
        WG7HPmDhtosfLYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E45C13902;
        Thu, 27 Jul 2023 08:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Zi+gCtErwmQhUgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 27 Jul 2023 08:33:21 +0000
Message-ID: <167455a3-3a9f-6064-4063-5b74231141f9@suse.cz>
Date:   Thu, 27 Jul 2023 10:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm: page_alloc: consume available CMA space first
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Joonsoo Kim <js1304@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230726145304.1319046-1-hannes@cmpxchg.org>
 <ZMGuY7syh9x0Sf51@P9FQF9L96D>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZMGuY7syh9x0Sf51@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 01:38, Roman Gushchin wrote:
> On Wed, Jul 26, 2023 at 10:53:04AM -0400, Johannes Weiner wrote:
>> On a memcache setup with heavy anon usage and no swap, we routinely
>> see premature OOM kills with multiple gigabytes of free space left:
>> 
>>     Node 0 Normal free:4978632kB [...] free_cma:4893276kB
>> 
>> This free space turns out to be CMA. We set CMA regions aside for
>> potential hugetlb users on all of our machines, figuring that even if
>> there aren't any, the memory is available to userspace allocations.
>> 
>> When the OOMs trigger, it's from unmovable and reclaimable allocations
>> that aren't allowed to dip into CMA. The non-CMA regions meanwhile are
>> dominated by the anon pages.
>> 
>> 
>> Because we have more options for CMA pages, change the policy to
>> always fill up CMA first. This reduces the risk of premature OOMs.
> 
> I suspect it might cause regressions on small(er) devices where
> a relatively small cma area (Mb's) is often reserved for a use by various
> device drivers, which can't handle allocation failures well (even interim
> allocation failures). A startup time can regress too: migrating pages out of
> cma will take time.

Agreed, we should be more careful here.

> And given the velocity of kernel upgrades on such devices, we won't learn about
> it for next couple of years.
> 
>> Movable pages can be migrated out of CMA when necessary, but we don't
>> have a mechanism to migrate them *into* CMA to make room for unmovable
>> allocations. The only recourse we have for these pages is reclaim,
>> which due to a lack of swap is unavailable in our case.
> 
> Idk, should we introduce such a mechanism? Or use some alternative heuristics,
> which will be a better compromise between those who need cma allocations always
> pass and those who use large cma areas for opportunistic huge page allocations.
> Of course, we can add a boot flag/sysctl/per-cma-area flag, but I doubt we want
> really this.

At some point the solution was supposed to be ZONE_MOVABLE:
https://lore.kernel.org/linux-mm/1512114786-5085-1-git-send-email-iamjoonsoo.kim@lge.com/

But it was reverted due to IIRC some bugs, and Joonsoo going MIA.

> Thanks!

