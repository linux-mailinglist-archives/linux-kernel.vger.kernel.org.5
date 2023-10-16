Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508077CB49A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjJPU0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:26:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5753FB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:26:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so5199036276.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697487990; x=1698092790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QPTkYTZnZrVHU5549J4NxQtUsfCC6J7hkeHUTqjG73g=;
        b=HPmzhCRcz8rXAKtgvWcNkxSlVT89c1cmDCsPRiJQ56gLUulaYRRSJKFP9XyrVhaOtv
         kVmmfRyE/rhume1iHtA71nFFx0Q4a1aRNsIVHstwG2E5wRsC4MHCig58nuOrurOJzYaz
         519V8z6P/CuPh5xFS1J5v8BJH7mB/zHzAFGAld1hbBnv7jI2vFSTEUyBT392dhGQvhkT
         XsWI44aI/mJJ9REZa/PKOVGtpIMks11frEavhmzoIEl0koCAmfg28pKvW/Oc0bevxKwk
         D9AhrYLHC8qVt+DMC6VTailTr6REtoWQGhYdf6MMoPGyxMUz3a8tXgUX7l9ddcTCf2Iu
         t2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487990; x=1698092790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPTkYTZnZrVHU5549J4NxQtUsfCC6J7hkeHUTqjG73g=;
        b=npcmxfl86pBQ3o8glB7VXtDPV0Ei5r8d5ivs5Bg90peQ2aaXZ4ZXwkD9Spbn5aO1F1
         My6iBkPQzgbSUEV+AqfM8hdKic06ZHLUP6bjNXaXlwP9/GqgQeV9MKuB27FJ+9khSPNF
         M3KyqtzExNayDXwu3jCFy9V7OJ6S5tKXIGOIsEa5yCR/V+IHBeUgVdp/cdJMaegYzJot
         mxfsVa/v5YJy12bwC/GXWfdTR4FLeJG0yTeq6lhGMtZuPlp1bzMTkQBawMdF2zIo02ns
         1bwHXSnJnWFKHQui/qevQWxlMVbWkgv76MaN7bAwHcQI219oqgz9cyPXl4ZKbTgbjTHl
         bLIg==
X-Gm-Message-State: AOJu0YwCAPaVfb2xOXWujKmw1OlmP/cjBuIoV+x0zoB8u9RBheQeU5mZ
        5xY2zL/xFa01YF0sfG8/rzYbzg==
X-Google-Smtp-Source: AGHT+IH0aqxF5tM4qI4FzYmXFdKpzIDnQGEHkOoW4o2/zudOgQHqT6Yuybzsu5DHMDv6uGyO/k+xMQ==
X-Received: by 2002:a25:abc6:0:b0:d9a:6316:42c8 with SMTP id v64-20020a25abc6000000b00d9a631642c8mr117592ybi.54.1697487990516;
        Mon, 16 Oct 2023 13:26:30 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id pe10-20020a056214494a00b0066d0d3daa58sm3644963qvb.24.2023.10.16.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:26:30 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:26:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20231016202629.GA1042487@cmpxchg.org>
References: <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
 <20231016143717.GH470544@cmpxchg.org>
 <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
 <20231016185113.GI470544@cmpxchg.org>
 <6F2C52B6-2031-4694-A124-0DFDE9F88E88@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F2C52B6-2031-4694-A124-0DFDE9F88E88@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:49:49PM -0400, Zi Yan wrote:
> On 16 Oct 2023, at 14:51, Johannes Weiner wrote:
> 
> > On Mon, Oct 16, 2023 at 11:00:33AM -0400, Zi Yan wrote:
> >> On 16 Oct 2023, at 10:37, Johannes Weiner wrote:
> >>
> >>> On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
> >>>>> The attached patch has all the suggested changes, let me know how it
> >>>>> looks to you. Thanks.
> >>>>
> >>>> The one I sent has free page accounting issues. The attached one fixes them.
> >>>
> >>> Do you still have the warnings? I wonder what went wrong.
> >>
> >> No warnings. But something with the code:
> >>
> >> 1. in your version, split_free_page() is called without changing any pageblock
> >> migratetypes, then split_free_page() is just a no-op, since the page is
> >> just deleted from the free list, then freed via different orders. Buddy allocator
> >> will merge them back.
> >
> > Hm not quite.
> >
> > If it's the tail block of a buddy, I update its type before
> > splitting. The splitting loop looks up the type of each block for
> > sorting it onto freelists.
> >
> > If it's the head block, yes I split it first according to its old
> > type. But then I let it fall through to scanning the block, which will
> > find that buddy, update its type and move it.
> 
> That is the issue, since split_free_page() assumes the pageblocks of
> that free page have different types. It basically just free the page
> with different small orders summed up to the original free page order.
> If all pageblocks of the free page have the same migratetype, __free_one_page()
> will merge these small order pages back to the original order free page.

duh, of course, you're right. Thanks for patiently explaining this.

> >> 2. in my version, I set pageblock migratetype to new_mt before split_free_page(),
> >> but it causes free page accounting issues, since in the case of head, free pages
> >> are deleted from new_mt when they are in old_mt free list and the accounting
> >> decreases new_mt free page number instead of old_mt one.
> >
> > Right, that makes sense.
> >
> >> Basically, split_free_page() is awkward as it relies on preset migratetypes,
> >> which changes migratetypes without deleting the free pages from the list first.
> >> That is why I came up with the new split_free_page() below.
> >
> > Yeah, the in-between thing is bad. Either it fixes the migratetype
> > before deletion, or it doesn't do the deletion. I'm thinking it would
> > be simpler to move the deletion out instead.
> 
> Yes and no. After deletion, a free page no longer has PageBuddy set and
> has buddy_order information cleared. Either we reset PageBuddy and order
> to the deleted free page, or split_free_page() needs to be changed to
> accept pages without the information (basically remove the PageBuddy
> and order check code).

Good point, that requires extra care.

It's correct in the code now, but it deserves a comment, especially
because of the "buddy" naming in the new split function.

> >> Hmm, if CONFIG_ARCH_FORCE_MAX_ORDER can make a buddy have more than one
> >> pageblock and in turn makes an in-use page have more than one pageblock,
> >> we will have problems. Since in isolate_single_pageblock(), an in-use page
> >> can have part of its pageblock set to a different migratetype and be freed,
> >> causing the free page with unmatched migratetypes. We might need to
> >> free pages at pageblock_order if their orders are bigger than pageblock_order.
> >
> > Is this a practical issue? You mentioned that right now only gigantic
> > pages can be larger than a pageblock, and those are freed in order-0
> > chunks.
> 
> Only if the system allocates a page (non hugetlb pages) with >pageblock_order
> and frees it with the same order. I just do not know if such pages exist on
> other arch than x86. Maybe I just think too much.

Hm, I removed LRU pages from the handling (and added the warning) but
I left in PageMovable(). The only users are z3fold, zsmalloc and
memory ballooning. AFAICS none of them can be bigger than a pageblock.
Let me remove that and add a warning for that case as well.

This way, we only attempt to migrate hugetlb, where we know the free
path - and get warnings for anything else that's larger than expected.

This seems like the safest option. On the off chance that there is a
regression, it won't jeopardize anybody's systems, while the warning
provides all the information we need to debug what's going on.

> > From a0460ad30a24cf73816ac40b262af0ba3723a242 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Mon, 16 Oct 2023 12:32:21 -0400
> > Subject: [PATCH] mm: page_isolation: prepare for hygienic freelists
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

> It looks good to me. Thanks.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thank you for all your help!
