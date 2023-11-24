Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428B47F7760
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjKXPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjKXPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:13:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224EF1725
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cpGcQbK5ALS/h/233m+c8jmOxYiT52WHP0nU+fSEvDI=; b=fX93P2C7tTpexgPCsWNuQcuoF5
        V4NbDi/cjiBJ3iFD2y4kQwA8+IY1jUY//C5gTL7Y8jlJWwizOacgMGtmLWvpyP1Jxtmlv8KsF+u2Q
        3AFGeeshrZuDXwCFRYI7nDjjzh5ZrGTMMIUvezBHV4zBK0vJKDx0VZIpALBPKeA84BikUEgoitHmR
        deGOVtSFkgHm/2kSyrhYPGpPu5pc1VH0zHdq1nq6ZFG84alWCsKV9908uETUg2hAyPf5y4SR2mvzr
        6bWeourxF/Pzo9Zfk32xV0m0+CJWq9as/ots/slGIkFbbfZPP1/KgynAsP/vY1Aix+BJgIpgbC0sJ
        +O0DhaJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6Xrz-008gyc-Bo; Fri, 24 Nov 2023 15:13:27 +0000
Date:   Fri, 24 Nov 2023 15:13:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Message-ID: <ZWC9lwDAjMZsNzoG@casper.infradead.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
> On 23/11/2023 15:59, Matthew Wilcox wrote:
> > On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
> >> This is v7 of a series to implement small-sized THP for anonymous memory
> >> (previously called "large anonymous folios"). The objective of this is to
> > 
> > I'm still against small-sized THP.  We've now got people asking whether
> > the THP counters should be updated when dealing with large folios that
> > are smaller than PMD sized.  It's sowing confusion, and we should go
> > back to large anon folios as a name.
> 
> I suspect I'm labouring the point here, but I'd like to drill into exactly what
> you are objecting to. Is it:
> 
> A) Using the name "small-sized THP" (which is currently only used in the commit
> logs and a couple of times in the documentation).

Yes, this is what I'm objecting to.

> B) Exposing the controls for this feature as an extension to the existing
> /sys/kernel/mm/transparent_hugepage/* sysfs interface (note the interface never
> uses the term "small-sized").

I don't object to the controls being here.  I still wish we didn't need
an interface to control them at all, but I don't have the time to become
an expert in anonymous memory and figure out how to make that happen.

> If A) then this is easily solved by choosing another descriptive name and
> updating those places. Personally I think it would be best to continue to use
> "THP" since we are exposing the feature through that interface. Perhaps "large
> folio THP".

I think that continues the confusion about the existing interfaces we
have which count THP (and mean "PMD sized THP").  I'd really prefer the
term "THP" to unambiguously mean PMD sized THP.  I don't understand why
you felt the need to move away from Large Anon Folios as a name.

