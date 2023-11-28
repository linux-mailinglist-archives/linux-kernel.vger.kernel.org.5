Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541127FC261
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbjK1OK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345591AbjK1OKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:10:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738E2D47
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=A7y0NaJ5ptNfygrxlKgEvacGOGqd4/7FIdJrvhOt2fQ=; b=uUVvi2npCvBXaVE6gIxQKBfIQv
        CTE+dhpfxOetIJE/TyjYvkaa02UjWwAMADAt6T2Ql/5IM2pVvPgkMzQDaNhUOXRIQnWEJ3KZU4IR1
        UlswKcp3yz+7Gx/z9sUTpUis/wl7HWwlhF2hbZs6KqIa/wn2hXngJNfxtBAOfgrt6a1WFka1UfPtB
        Uj+jvalgspDkRSf8OfGuFYGdS/Ni/y2F5Q8bJ6zkGY73N8lWnnKbPVDwY1Obu3NgtFM9Nv3Vx2HFk
        DhNgixO40A5MK3IkrL2eHOD4moFyH4mWH0osEBYHBPYEOSbj84SRv0+Z4rvHd9eHTF2e7J4pckxUw
        ZZ2OmDcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r7ylz-00CQ5n-W8; Tue, 28 Nov 2023 14:09:12 +0000
Date:   Tue, 28 Nov 2023 14:09:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Li <chrisl@kernel.org>
Cc:     "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH] mm/zswap: Replace kmap_atomic() with kmap_local_page()
Message-ID: <ZWX0h9JEAuw4qGyV@casper.infradead.org>
References: <20231127160058.586446-1-fabio.maria.de.francesco@linux.intel.com>
 <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuMakA-UbHi4Z5uCtB+6S0vcZiULKXu6GQh+7KBHQSR6Bg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 12:16:56PM -0800, Chris Li wrote:
> Hi Fabio,
> 
> On Mon, Nov 27, 2023 at 8:01 AM Fabio M. De Francesco
> <fabio.maria.de.francesco@linux.intel.com> wrote:
> >
> > kmap_atomic() has been deprecated in favor of kmap_local_page().
> >
> > Therefore, replace kmap_atomic() with kmap_local_page() in
> > zswap.c.
> >
> > kmap_atomic() is implemented like a kmap_local_page() which also
> > disables page-faults and preemption (the latter only in !PREEMPT_RT
> > kernels). The kernel virtual addresses returned by these two API are
> > only valid in the context of the callers (i.e., they cannot be handed to
> > other threads).
> >
> > With kmap_local_page() the mappings are per thread and CPU local like
> > in kmap_atomic(); however, they can handle page-faults and can be called
> > from any context (including interrupts). The tasks that call
> > kmap_local_page() can be preempted and, when they are scheduled to run
> > again, the kernel virtual addresses are restored and are still valid.
> 
> As far as I can tell, the kmap_atomic() is the same as
> kmap_local_page() with the following additional code before calling to
> "__kmap_local_page_prot(page, prot)", which is common between these
> two functions.
> 
>         if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                 migrate_disable();
>         else
>                 preempt_disable();
> 
>         pagefault_disable();
> 
> >From the performance perspective, kmap_local_page() does less so it
> has some performance gain. I am trying to think would it have another
> unwanted side effect of enabling interrupt and page fault while zswap
> decompressing a page.
> The decompression should not generate page fault. The interrupt
> enabling might introduce extra latency, but most of the page fault was
> having interrupt enabled anyway. The time spent in decompression is
> relatively small compared to the whole duration of the page fault. So
> the interrupt enabling during those short windows should be fine.
> "Should" is the famous last word.

Interrupts are enabled with kmap_atomic() too.  The difference is
whether we can be preempted by a higher-priority process.
