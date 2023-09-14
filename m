Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5927A010C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjINKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjINKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:00:40 -0400
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D8B3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:00:35 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 3AAE91C3F00
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:00:34 +0100 (IST)
Received: (qmail 14551 invoked from network); 14 Sep 2023 10:00:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Sep 2023 10:00:34 -0000
Date:   Thu, 14 Sep 2023 11:00:29 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: page_alloc: fix up block types when merging
 compatible blocks
Message-ID: <20230914100029.eyb45y45jei2md3h@techsingularity.net>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230911195023.247694-3-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:41:43PM -0400, Johannes Weiner wrote:
> The buddy allocator coalesces compatible blocks during freeing, but it
> doesn't update the types of the subblocks to match. When an allocation
> later breaks the chunk down again, its pieces will be put on freelists
> of the wrong type. This encourages incompatible page mixing (ask for
> one type, get another), and thus long-term fragmentation.
> 
> Update the subblocks when merging a larger chunk, such that a later
> expand() will maintain freelist type hygiene.
> 
> v2:
> - remove spurious change_pageblock_range() move (Zi Yan)
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I'm not 100% convinced on the amount of harm this causes but given that
it's a relatively rare condition, I didn't think about the consequences
too deeply. The patch certainly has merit so;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
