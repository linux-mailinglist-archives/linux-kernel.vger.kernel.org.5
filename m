Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988B77C6E74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378422AbjJLMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbjJLMuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:50:04 -0400
Received: from outbound-smtp56.blacknight.com (outbound-smtp56.blacknight.com [46.22.136.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BBC91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:50:02 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 8BB39FB099
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:50:00 +0100 (IST)
Received: (qmail 5189 invoked from network); 12 Oct 2023 12:50:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2023 12:50:00 -0000
Date:   Thu, 12 Oct 2023 13:49:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Subject: Re: [PATCH 09/10] mm, pcp: avoid to reduce PCP high unnecessarily
Message-ID: <20231012124958.dj5ug5hih3joa542@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-10-ying.huang@intel.com>
 <20231011140949.rwsqfb57vyuub6va@techsingularity.net>
 <87lec8ffij.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87lec8ffij.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:48:04PM +0800, Huang, Ying wrote:
> "
> On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
> instances in parallel (each with `make -j 28`) in 8 cgroup.  This
> simulates the kbuild server that is used by 0-Day kbuild service.
> With the patch, The number of pages allocated from zone (instead of
> from PCP) decreases 21.4%.
> "
> 
> I also showed the performance number for each step of optimization as
> follows (copied from the above patchset V2 link).
> 
> "
> 	build time   lock contend%	free_high	alloc_zone
> 	----------	----------	---------	----------
> base	     100.0	      13.5          100.0            100.0
> patch1	      99.2	      10.6	     19.2	      95.6
> patch3	      99.2	      11.7	      7.1	      95.6
> patch5	      98.4	      10.0	      8.2	      97.1
> patch7	      94.9	       0.7	      3.0	      19.0
> patch9	      94.9	       0.6	      2.7	      15.0  <--	this patch
> patch10	      94.9	       0.9	      8.8	      18.6
> "
> 
> Although I think the patch is helpful via avoiding the unnecessary
> pcp->high decaying, thus reducing the zone lock contention.  There's no
> visible benchmark score change for the patch.
> 

Thanks!

Given that it's another PCP field with an update in a relatively hot
path, I would suggest dropping this patch entirely if it does not affect
performance. It has the risk of being a magical heuristic that we forget
later whether it's even worthwhile.

-- 
Mel Gorman
SUSE Labs
