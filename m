Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3C751B66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjGMIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjGMIV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:21:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54675B96
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689236064; x=1720772064;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=edaI7hSFg+0GRPrWQELWxRH6SgeN/RazkSn5CecEiNA=;
  b=iJejp/+YOZ1YT00uVW48gAk0X5mySB+0+OTVzpwuaVcVDNDU3bvW/5tg
   Z8YmiNL4om0TxvGG5K+w1HaA1+WaTQcuu7SJIwkTJbxOYfG5uzBlKpJNo
   KvAHmrd+4UQ3v8SdJv4IgyAmiT48STBijYMfZhW4mGCf6659qF8s2vl96
   bEnP558h6Rxq3r7vWhrhegxp7nxoO+1Z90ngOhudtnDuZgiZGliN/8sH6
   KTjqqRqN9wnqvSlsUtr947vwX0ZrZojUS+ogP4b20X57bXPNoQIFZbUV8
   4X+E1Z5jV584X+ldWJs/BZX0PRBft5koBmVytYnkX7Kpj+hgtNYiYcaZb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363991303"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="363991303"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 01:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="757069203"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="757069203"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 01:13:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
References: <20230710065325.290366-1-ying.huang@intel.com>
        <20230710065325.290366-3-ying.huang@intel.com>
        <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
Date:   Thu, 13 Jul 2023 16:11:31 +0800
In-Reply-To: <ZK060sMG0GfC5gUS@dhcp22.suse.cz> (Michal Hocko's message of
        "Tue, 11 Jul 2023 13:19:46 +0200")
Message-ID: <877cr4dydo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Mon 10-07-23 14:53:25, Huang Ying wrote:
>> To auto-tune PCP high for each CPU automatically, an
>> allocation/freeing depth based PCP high auto-tuning algorithm is
>> implemented in this patch.
>> 
>> The basic idea behind the algorithm is to detect the repetitive
>> allocation and freeing pattern with short enough period (about 1
>> second).  The period needs to be short to respond to allocation and
>> freeing pattern changes quickly and control the memory wasted by
>> unnecessary caching.
>
> 1s is an ethernity from the allocation POV. Is a time based sampling
> really a good choice? I would have expected a natural allocation/freeing
> feedback mechanism. I.e. double the batch size when the batch is
> consumed and it requires to be refilled and shrink it under memory
> pressure (GFP_NOWAIT allocation fails) or when the surplus grows too
> high over batch (e.g. twice as much).  Have you considered something as
> simple as that?
> Quite honestly I am not sure time based approach is a good choice
> because memory consumptions tends to be quite bulky (e.g. application
> starts or workload transitions based on requests).

If my understanding were correct, we are targeting different allocation
and freeing patterns.

Your target pattern (A):

- allocate several GB or more (application starts) in short time
- allocate and free small number of pages in long time
- free several GB or more (application exits) in short time

My target pattern (B):

- allocate several hundreds MB, free small number, in short time
- free several hundreds MB, allocate small number, in short time
- repeat the above pattern for long time

For pattern A, my patchset will almost not help it.  It may be helpful
to increase PCP batch (I will do some test to verify that).  But, it may
be not a good idea to increase PCP high too much?  Because we need to
put more than several GB in PCP for long time.  At the same time, these
memory may be needed by other CPUs.  It's hard to determine how long
should we keep these pages in PCP.

My patchset will help pattern B via identify the allocation/freeing
depth and increasing PCP high to hold several hundreds MB in PCP.  Then
most allocation and freeing needs not to call buddy.  And when the
pattern completes, the PCP high will be restored and pages will be put
back in buddy.

I can observe the pattern B in kernel building and
netperf/SCTP_STREAM_MANY workload.  So, the zone lock contention
or page allocation/freeing latency reduction can be observed.  For
example, the alloc_count for kbuild is as follows,

        +-------------------------------------------------------------------+   
  90000 |-+    +      +     +      +      +      +      +     +      +     E|   
        |                        mm_pcp_alloc_count.0.2.alloc_count ***E****|   
  85000 |-+                                                **E           * *|   
        |              EE           E             EE    E**  *          E  *|   
  80000 |-+            EE          **            * *  **     *         *   *|   
        |         E    EEEE       E *    E      E  * *       *     E   *   *|   
  75000 |-+      E*    EE *       E *   ** E    *  EE        *    E*  E    *|   
        |       E * E *   *      *  *  * * *   E   E         *   * * E*    *|   
  70000 |-+    EE E EE    *E     E  * E  *E*   E             *   * * E     E|   
        |      E  E EE    *EE   E   *E   E*EEEE              E EE  *EE      |   
  65000 |EEE**EE  EEE     EE*  EE   EE   E EEE               EEEE  EE       |   
        |                 E * E             EE               EEE   E        |   
  60000 |-+                 *E*                                             |   
        |                   EE                                              |   
  55000 |-+    +      +     EE     +      +      +      +     +      +      |   
        +-------------------------------------------------------------------+   
        74     75     76    77     78     79     80     81    82     83     84  

The X axis is time in second, the Y axis is alloc count (start from 0,
++ for allocation, -- for freeing).  From the figure you can find that
from 75s on, the allocation depth and freeing depth is about 30000,
while repetitive period is about 1s.

IMHO, both pattern A and pattern B exists in reality.

>> To detect the repetitive allocation and freeing pattern, the
>> alloc/free depth is calculated for each tuning period (1 second) on
>> each CPU.  To calculate the alloc/free depth, we track the alloc
>> count.  Which increases for page allocation from PCP and decreases for
>> page freeing to PCP.  The alloc depth is the maximum alloc count
>> difference between the later large value and former small value.
>> While, the free depth is the maximum alloc count difference between
>> the former large value and the later small value.
>> 
>> Then, the average alloc/free depth in multiple tuning periods is
>> calculated, with the old alloc/free depth decay in the average
>> gradually.
>> 
>> Finally, the PCP high is set to be the smaller value of average alloc
>> depth and average free depth, after clamped between the default and
>> the max PCP high.  In this way, pure allocation or freeing will not
>> enlarge the PCP high because PCP doesn't help.
>> 
>> We have tested the algorithm with several workloads on Intel's
>> 2-socket server machines.
>
> How does this scheme deal with memory pressure?

If my understanding were correct, ZONE_RECLAIM_ACTIVE will be set when
kswapd is waken up (balance_pgdat()->set_reclaim_active()).  Then
(pcp->batch * 4) will be used as PCP high (free_unref_page_commit() ->
nr_pcp_high()).  So, the pages in PCP will be reduced.

Best Regards,
Huang, Ying
