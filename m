Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19377C5802
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjJKPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjJKPZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:25:30 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0668F9D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:25:28 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-65b0557ec77so40622956d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697037927; x=1697642727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsMbz3DgW/xqFIUZu44mEh3KqlFcPH8UERBD82Y0mcs=;
        b=yISpp6h7OQ8K4n6j4HzeHWsOelH1sAOJuUZXb7x1fXddUqUrymWrLMif3PIDXMJNoY
         0Xl0sPdjvvhfCrt0JxgqR+lp3M4qWEiADlWXtxX1qnkfEVLFcBJkftFl5Iwa6NFmTE4L
         Ha/KX531hteBTZ1TOwshB0mC3j5x5xZlInK4+72HeQU5A2ulU27rd4FWqcV8jw//0CvO
         pu2AN0aWYZb4Qu4KdNkSqQ3XnrNt/wJzppZQ5RDtLtCPxuR6vEJ8EIbvHMOx121+Ko+y
         ayrZ83Oucwdj92mrtf9/ppVJMdxrr8mjGpX5t73p6gxdVGm0ZO9b5kduV8Ru25p82rH0
         osYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037927; x=1697642727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsMbz3DgW/xqFIUZu44mEh3KqlFcPH8UERBD82Y0mcs=;
        b=i2fIqyrL02fGDeoUFghf9myTII5V92qtIS6NGA3AvEftJAGW3mGGW0su6NI0OjP+J4
         c8HZbbO88k7KiykzMUwH1yvnRQ2x8vvXCKOZXbJttiCT9ATDpiYcUArto+OG+szhWfaP
         K8HRUxoy1JpRwhP3IEKyGcWwusIrnC7ZrCUJWp7f+Qs8dlV0yoRsVTNOO5S2vb6ANQ4T
         wuzemoefLuj76TIuwd1VQ7iMbPbC4+JZ86tn8FCERA+GAZqBdRkckkFecndcfXl2Nloe
         JqHxp3+ptNB4kw+gMnNLKL/6EbvmUiwwTL8Nk3++TMvPjmfgmmEalMtabC93WtblGH9c
         deNw==
X-Gm-Message-State: AOJu0YwTgYb90XvApdSx3zZ2hSX/8Fq2ojf5SYPacN0Ad1hkrKuTCwX8
        00UddKIxIys/bs/V+egED8Mpfg==
X-Google-Smtp-Source: AGHT+IGlLDv3+7x9FfABCsGgOa1is2cQYueStg/wwkdrU9pygWs8+xm3pd5+3iuNFglehPX6pSX/Vg==
X-Received: by 2002:a0c:f58c:0:b0:66c:fa81:3f25 with SMTP id k12-20020a0cf58c000000b0066cfa813f25mr4310240qvm.62.1697037927088;
        Wed, 11 Oct 2023 08:25:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id a12-20020a0ce38c000000b0064723b94a23sm5677557qvl.27.2023.10.11.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:25:26 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:25:25 -0400
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
Message-ID: <20231011152525.GA461170@cmpxchg.org>
References: <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010211200.GA129823@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:12:01PM -0400, Johannes Weiner wrote:
> On Mon, Oct 02, 2023 at 10:26:44PM -0400, Zi Yan wrote:
> > @@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
> >  
> >  		order = buddy_order(page);
> >  		move_to_free_list(page, zone, order, old_mt, new_mt);
> > +		/*
> > +		 * set page migratetype 1) only after we move all free pages in
> > +		 * one pageblock and 2) for all pageblocks within the page.
> > +		 *
> > +		 * for 1), since move_to_free_list() checks page migratetype with
> > +		 * old_mt and changing one page migratetype affects all pages
> > +		 * within the same pageblock, if we are moving more than
> > +		 * one free pages in the same pageblock, setting migratetype
> > +		 * right after first move_to_free_list() triggers the warning
> > +		 * in the following move_to_free_list().
> > +		 *
> > +		 * for 2), when a free page order is greater than pageblock_order,
> > +		 * all pageblocks within the free page need to be changed after
> > +		 * move_to_free_list().
> 
> I think this can be somewhat simplified.
> 
> There are two assumptions we can make. Buddies always consist of 2^n
> pages. And buddies and pageblocks are naturally aligned. This means
> that if this pageblock has the start of a buddy that straddles into
> the next pageblock(s), it must be the first page in the block. That in
> turn means we can move the handling before the loop.

Eh, scratch that. Obviously, a sub-block buddy can straddle blocks :(

So forget about my version of move_free_pages(). Only consider the
changes to find_straddling_buddy() and my question about multiple
blocks inside the requested range.

But I do have another question about your patch then. Say you have an
order-1 buddy that straddles into the block:

+       /* split at start_pfn if it is in the middle of a free page */
+       if (new_start_pfn != start_pfn && PageBuddy(pfn_to_page(new_start_pfn))) {
+               struct page *new_page = pfn_to_page(new_start_pfn);
+               int new_page_order = buddy_order(new_page);
+
+               if (new_start_pfn + (1 << new_page_order) > start_pfn) {
+                       /* change migratetype so that split_free_page can work */
+                       set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+                       split_free_page(new_page, buddy_order(new_page),
+                                       start_pfn - new_start_pfn);
+
+                       mt_changed_pfn = start_pfn;
+                       /* move to next page */
+                       start_pfn = new_start_pfn + (1 << new_page_order);
+               }
+       }

this will have changed the type of the block to new_mt.

But then the buddy scan will do this:

                move_to_free_list(page, zone, order, old_mt, new_mt);
+               /*
+                * set page migratetype 1) only after we move all free pages in
+                * one pageblock and 2) for all pageblocks within the page.
+                *
+                * for 1), since move_to_free_list() checks page migratetype with
+                * old_mt and changing one page migratetype affects all pages
+                * within the same pageblock, if we are moving more than
+                * one free pages in the same pageblock, setting migratetype
+                * right after first move_to_free_list() triggers the warning
+                * in the following move_to_free_list().
+                *
+                * for 2), when a free page order is greater than pageblock_order,
+                * all pageblocks within the free page need to be changed after
+                * move_to_free_list().

That move_to_free_list() will complain that the pages no longer match
old_mt, no?
