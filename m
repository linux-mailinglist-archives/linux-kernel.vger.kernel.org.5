Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1087EDE12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjKPJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPJ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:59:09 -0500
Received: from outbound-smtp16.blacknight.com (outbound-smtp16.blacknight.com [46.22.139.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05EC5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:59:04 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id C087B1C405A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:59:02 +0000 (GMT)
Received: (qmail 17829 invoked from network); 16 Nov 2023 09:59:02 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.19])
  by 81.17.254.26 with ESMTPA; 16 Nov 2023 09:59:02 -0000
Date:   Thu, 16 Nov 2023 09:59:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, hannes@cmpxchg.org, quic_pkondeti@quicinc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] mm: page_alloc: correct high atomic reserve
 calculations
Message-ID: <20231116095901.72oqtjoiqzt3tfhj@techsingularity.net>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <905d99651423ee85aeb7a71982b95ee9bb05ee99.1699104759.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <905d99651423ee85aeb7a71982b95ee9bb05ee99.1699104759.git.quic_charante@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 06:20:49PM +0530, Charan Teja Kalla wrote:
> reserve_highatomic_pageblock() aims to reserve the 1% of the managed
> pages of a zone, which is used for the high order atomic allocations.
> 
> It uses the below calculation to reserve:
> static void reserve_highatomic_pageblock(struct page *page, ....) {
> 
>    .......
>    max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
> 
>    if (zone->nr_reserved_highatomic >= max_managed)
>        goto out;
> 
>    zone->nr_reserved_highatomic += pageblock_nr_pages;
>    set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>    move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> 
> out:
>    ....
> }
> 
> Since we are always appending the 1% of zone managed pages count to
> pageblock_nr_pages, the minimum it is turning into 2 pageblocks as the
> nr_reserved_highatomic is incremented/decremented in pageblock sizes.
> 
> Encountered a system(actually a VM running on the Linux kernel) with the
> below zone configuration:
> Normal free:7728kB boost:0kB min:804kB low:1004kB high:1204kB
> reserved_highatomic:8192KB managed:49224kB
> 
> The existing calculations making it to reserve the 8MB(with pageblock
> size of 4MB) i.e. 16% of the zone managed memory.  Reserving such high
> amount of memory can easily exert memory pressure in the system thus may
> lead into unnecessary reclaims till unreserving of high atomic reserves.
> 
> Since high atomic reserves are managed in pageblock size granules, as
> MIGRATE_HIGHATOMIC is set for such pageblock, fix the calculations for
> high atomic reserves as,  minimum is pageblock size , maximum is
> approximately 1% of the zone managed pages.
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

This patch in isolation seems fine with the caveat that such a small
system may find the atomic reserves to be borderline useless.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
