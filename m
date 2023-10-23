Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A297D375B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJWNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJWNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:02:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC878C4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=B2lHdII7y0t9EFQrBPYsBPbjRefoYBOVWqu3w2mnv70=; b=O1nHYnwtr7ojshj97P1daE4UEF
        nb6CYnenT2Dp4PzgY1CYu/WsX40Oh/1fRNWVRJP/GQF47FhDSoHDzowlFVIpoY28GxYHoyooq62ox
        zwlEbStLYVMTCk55e+ip/2VdpvtV/K4e4Vhx9QI/UCvPmseIfjKTWiHgNERgfSUe4z8Y1w4+aRX1x
        BgfBESIhpyHHHfhQxxNObjKZc35se6y1c7tIlBFDb+nPoLElPHagD4voM8wN2I2OJTMzCtgjND/6O
        sNaRdjXzcQ+BcPiQFgQ5uqsNvZlMZlekvzUuDdO305V5TUY6XEkyWxB1a0gf1gXCpRfWszttwCkgX
        8W24FODA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1quuZ0-00DvI4-AA; Mon, 23 Oct 2023 13:01:46 +0000
Date:   Mon, 23 Oct 2023 14:01:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     zhiguojiang <justinjiang@vivo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
Message-ID: <ZTZuui+0Ppe6cjgC@casper.infradead.org>
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
 <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
 <380bc753-5ee7-4bc7-a76e-a804d5179d87@vivo.com>
 <ZTZlR2qJivLIdgsB@casper.infradead.org>
 <4eacc9e4-65ba-4fd9-bd30-575b0f23b63e@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eacc9e4-65ba-4fd9-bd30-575b0f23b63e@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:44:55PM +0800, zhiguojiang wrote:
> 在 2023/10/23 20:21, Matthew Wilcox 写道:
> > On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
> > > > Are you seeing measurable changes for any workloads?  It certainly seems
> > > > like you should, but it would help if you chose a test from mmtests and
> > > > showed how performance changed on your system.
> > > In one mmtest, the max times for a invalid recyling of a folio_list dirty
> > > folio that does not support pageout and has been activated in
> > > shrink_folio_list() are: cost=51us, exe=2365us.
> > > 
> > > Calculate according to this formula: dirty_cost / total_cost * 100%, the
> > > recyling efficiency of dirty folios can be improved 53.13%、82.95%.
> > > 
> > > So this patch can optimize shrink efficiency and reduce the workload of
> > > kswapd to a certain extent.
> > > 
> > > kswapd0-96      (     96) [005] .....   387.218548:
> > > mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
> > > nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
> > > nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
> > > total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
> > > 
> > > kswapd0-96      (     96) [006] .....   412.822532:
> > > mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
> > > nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
> > > nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
> > > total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
> > I appreciate that you can put probes in and determine the cost, but do
> > you see improvements for a real workload?  Like doing a kernel compile
> > -- does it speed up at all?
> Can you help share a method for testing thread workload, like kswapd?

Something dirt simple like 'time make -j8'.
