Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365B57D074E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376282AbjJTEP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjJTEPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:15:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E74138
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gemlUgVisWtTZh5bt5ZgoKVAVQjqpxFYZRLfuM3OkQ4=; b=HzvYEQZm/NkcpUNat/8nKTKpfF
        Xt28jHszC5uDQpn4Uc62WV5dSC6NCW+GnjQWa2/2RSxaaU9Bw+QeW6lmZ4eaQqQQZClX0ZaBB/8UU
        b7+8MNyFu/nZ9YZvgB+lE4GpV5g21t8RPpPSudrS/bxM4EXdzfbEAmG7PjzquRzfAmvHbXbxswbJn
        LN382U6ZhJumGsmOfObSAl4a7PuRgPQGwTu2PYLNembJcTG0YL23sNxem+9S+0Drxx1t+4bvvqjFx
        tFJGSPJHbrImfxCrRWa0Eb4X70XEmQY2TlCYHXBAk6ygZa7cF8JGSjOdBiMYR8QOnJb8Lwku3nwIb
        RcCuJbpw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtgvF-00B1Jv-VU; Fri, 20 Oct 2023 04:15:42 +0000
Date:   Fri, 20 Oct 2023 05:15:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     zhiguojiang <justinjiang@vivo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
Message-ID: <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:59:33AM +0800, zhiguojiang wrote:
> > > @@ -1261,43 +1305,6 @@ static unsigned int shrink_folio_list(struct
> > > list_head *folio_list,
> > >                       enum ttu_flags flags = TTU_BATCH_FLUSH;
> > >                       bool was_swapbacked =
> > > folio_test_swapbacked(folio);
> > > 
> > > -                     if (folio_test_dirty(folio)) {
> > > -                             /*
> > > -                              * Only kswapd can writeback
> > > filesystem folios
> > > -                              * to avoid risk of stack overflow.
> > > But avoid
> > > -                              * injecting inefficient single-folio
> > > I/O into
> > > -                              * flusher writeback as much as
> > > possible: only
> > > -                              * write folios when we've encountered
> > > many
> > > -                              * dirty folios, and when we've
> > > already scanned
> > > -                              * the rest of the LRU for clean
> > > folios and see
> > > -                              * the same dirty folios again (with
> > > the reclaim
> > > -                              * flag set).
> > > -                              */
> > > -                             if (folio_is_file_lru(folio) &&
> > > -                                     (!current_is_kswapd() ||
> > > - !folio_test_reclaim(folio) ||
> > > -                                      !test_bit(PGDAT_DIRTY,
> > > &pgdat->flags))) {
> > > -                                     /*
> > > -                                      * Immediately reclaim when
> > > written back.
> > > -                                      * Similar in principle to
> > > folio_deactivate()
> > > -                                      * except we already have the
> > > folio isolated
> > > -                                      * and know it's dirty
> > > -                                      */
> > > -                                     node_stat_mod_folio(folio,
> > > NR_VMSCAN_IMMEDIATE,
> > > -                                                     nr_pages);
> > > -                                     folio_set_reclaim(folio);
> > > -
> > > -                                     goto activate_locked;
> > > -                             }
> > > -
> > > -                             if (references == FOLIOREF_RECLAIM_CLEAN)
> > > -                                     goto keep_locked;
> > > -                             if (!may_enter_fs(folio, sc->gfp_mask))
> > > -                                     goto keep_locked;
> > > -                             if (!sc->may_writepage)
> > > -                                     goto keep_locked;
> > > -                     }
> > > -
> > >                       if (folio_test_pmd_mappable(folio))
> > >                               flags |= TTU_SPLIT_HUGE_PMD;
> > > 
> > 
> > I'm confused. Did you apply this on top of v1 by accident?
> Hi,
> According to my modified mm_vmscan_lru_shrink_inactive test tracelog, in the

You're missing David's point.  You've generated this patch against ...
something ... that isn't upstream.  Probably against v1 of your
patch.  Please check your git tree.

> 32 scanned inactive file pages, 20 were dirty, and the 20 dirty pages were
> not reclamed, but they took 20us to perform try_to_unmap.
> 
> I think unreclaimed dirty folio in inactive file lru can skip to perform
> try_to_unmap. Please help to continue review. Thanks.
> 
> kswapd0-99      (     99) [005] .....   687.793724:
> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 scan=32 isolate=32 reclamed=12
> nr_dirty=20 nr_unqueued_dirty=20 nr_writeback=0 nr_congested=0
> nr_immediate=0 nr_activate[0]=0 nr_activate[1]=20 nr_ref_keep=0
> nr_unmap_fail=0 priority=2 file=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC total=39
> exe=0 reference_cost=5 reference_exe=0 unmap_cost=21 unmap_exe=0
> dirty_unmap_cost=20 dirty_unmap_exe=0 pageout_cost=0 pageout_exe=0

Are you seeing measurable changes for any workloads?  It certainly seems
like you should, but it would help if you chose a test from mmtests and
showed how performance changed on your system.
