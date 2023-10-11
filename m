Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615627C5462
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbjJKMyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjJKMyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:54:35 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DEF98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:54:34 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id B5458FB0DC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:54:30 +0100 (IST)
Received: (qmail 17085 invoked from network); 11 Oct 2023 12:54:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2023 12:54:29 -0000
Date:   Wed, 11 Oct 2023 13:54:27 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 05/10] mm, page_alloc: scale the number of pages that are
 batch allocated
Message-ID: <20231011125427.dtwr2jerqzehjjxo@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-6-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230920061856.257597-6-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:18:51PM +0800, Huang Ying wrote:
> When a task is allocating a large number of order-0 pages, it may
> acquire the zone->lock multiple times allocating pages in batches.
> This may unnecessarily contend on the zone lock when allocating very
> large number of pages.  This patch adapts the size of the batch based
> on the recent pattern to scale the batch size for subsequent
> allocations.
> 
> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
> one socket with `make -j 112`.  With the patch, the cycles% of the
> spinlock contention (mostly for zone lock) decreases from 40.5% to
> 37.9% (with PCP size == 361).
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
