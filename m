Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2C7A0122
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjINKDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbjINKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:13 -0400
Received: from outbound-smtp16.blacknight.com (outbound-smtp16.blacknight.com [46.22.139.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB01BF9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:03:07 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id A5C9A1C3D57
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:03:06 +0100 (IST)
Received: (qmail 24834 invoked from network); 14 Sep 2023 10:03:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Sep 2023 10:03:06 -0000
Date:   Thu, 14 Sep 2023 11:03:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: page_alloc: move free pages when converting
 block during isolation
Message-ID: <20230914100304.v7ztao3rz6ubp6o3@techsingularity.net>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230911195023.247694-4-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:41:44PM -0400, Johannes Weiner wrote:
> When claiming a block during compaction isolation, move any remaining
> free pages to the correct freelists as well, instead of stranding them
> on the wrong list. Otherwise, this encourages incompatible page mixing
> down the line, and thus long-term fragmentation.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Hmm, this is potentially expensive in some cases but it's also correct.
Given how expensive the whole path is, I doubt it's noticable and some of
this activity will be !direct_compaction anyway and relatively invisible
even if I'm not a fan of hiding overhead in kthreads. Either way;

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
