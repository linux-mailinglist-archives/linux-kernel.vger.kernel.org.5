Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883297A9129
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIUDOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIUDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:14:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75FF4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SCXgHyJZGhjaqUfFGquv/AGCdJtUKcQzBvEtg+zXiaw=; b=uWvzVrANKhUwfNVS1gqC2WUylG
        aUdYNAu9l4Ieft7wo+vsG3QeoCSM/PA5lNcacnFP+5rlwpHoRIKzPpPsaXXjtCpbt5bvQfbQgBvI4
        ZXb6za90QA3fv3lO2QybVH0CLLDJIz7MOm+EFnwB+xQwXs1QK2GrADxFjKRk0pLnNg+kOd1LKFpoM
        7+UbHm1b0GDoUzBTWsW6cxgclo9iD6NPUiJcUMUDO3lDs2FSWn6gL6zzErtMfTz2WRXTDDP+QcjWK
        m1eqIJq5we4lN7rf7spkLseHr4Mj1eLXcv/cq92QK39lHpNCy1eTpt8KEDd+apBa/xCPm04OkZRMU
        pv8rxvnA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qjA94-004sVS-2D;
        Thu, 21 Sep 2023 03:14:26 +0000
Date:   Wed, 20 Sep 2023 20:14:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Message-ID: <ZQu1EhQiV8h5Jsa6@bombadil.infradead.org>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <ZQuUl2DdwDlzKoeM@bombadil.infradead.org>
 <ZQuZdkxm/GMyS6wY@bombadil.infradead.org>
 <5ac6a387-0ca7-45ca-bebc-c3bdd48452cb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac6a387-0ca7-45ca-bebc-c3bdd48452cb@nvidia.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 07:05:25PM -0700, John Hubbard wrote:
> On 9/20/23 18:16, Luis Chamberlain wrote:
> > On Wed, Sep 20, 2023 at 05:55:51PM -0700, Luis Chamberlain wrote:
> > > Are there other known recipes test help test this stuff?
> > 
> > You know, it got me wondering... since how memory fragmented a system
> > might be by just running fstests, because, well, we already have
> > that automated in kdevops and it also has LBS support for all the
> > different large block sizes on 4k sector size. So if we just had a
> > way to "measure" or "quantify" memory fragmentation with a score,
> > we could just tally up how we did after 4 hours of testing for each
> > block size with a set of memory on the guest / target node / cloud
> > system.
> > 
> >    Luis
> 
> I thought about it, and here is one possible way to quantify
> fragmentation with just a single number. Take this with some
> skepticism because it is a first draft sort of thing:
> 
> a) Let BLOCKS be the number of 4KB pages (or more generally, then number
> of smallest sized objects allowed) in the area.
> 
> b) Let FRAGS be the number of free *or* allocated chunks (no need to
> consider the size of each, as that is automatically taken into
> consideration).
> 
> Then:
>       fragmentation percentage = (FRAGS / BLOCKS) * 100%
> 
> This has some nice properties. For one thing, it's easy to calculate.
> For another, it can discern between these cases:
> 
> Assume a 12-page area:
> 
> Case 1) 6 pages allocated allocated unevenly:
> 
> 1 page allocated | 1 page free | 1 page allocated | 5 pages free | 4 pages allocated
> 
> fragmentation = (5 FRAGS / 12 BLOCKS) * 100% = 41.7%
> 
> Case 2) 6 pages allocated evenly: every other page is allocated:
> 
> fragmentation = (12 FRAGS / 12 BLOCKS) * 100% = 100%

Thanks! Will try this!

BTW stress-ng might also be a nice way to do other pathalogical things here.

  Luis
