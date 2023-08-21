Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18278257B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjHUIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHUIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:32:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F4EA6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692606751; x=1724142751;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nJtasNz7sa4gjo3p4OPIrhfF9GMcxzPE73svQO2Q3Nk=;
  b=DOTFU9E3IHd/KN6Tp3CaEkGA04O7CU7eJxHEhi6l5nuCUlcmRQo/hgHD
   wUqUlcBQ5a4w8uWNWHx872vBwBc5YCiUzes7hEkOboibYkhyaM6PFyWYI
   F7cAHj7IxO/HlpiK8c+txcx8naTrUw9MuI4FTaMFrmspb/2Q+Fx5el8lJ
   L04uwdSrTpIpYlxFEwi6Tc+phFwBXUYckPMhwUWMDjXPYu2ahxasyyls7
   PySzSKHTi4CdonL3RIuMKN4bok4numJFt1ZWuHqG/B0d+3FcuWJeyM/kL
   QP21+N6gPckQ1VEJO6irpH1NU/V3fA+oOAXlPPoJr5oB1WHUPjZoELS77
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="377271014"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="377271014"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="859404590"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="859404590"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:32:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
References: <20230811090819.60845-1-ying.huang@intel.com>
        <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
        <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
        <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
Date:   Mon, 21 Aug 2023 16:30:18 +0800
In-Reply-To: <ZOMYb27IulTpDFpe@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 21 Aug 2023 09:55:27 +0200")
Message-ID: <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 16-08-23 15:08:23, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Mon 14-08-23 09:59:51, Huang, Ying wrote:
>> >> Hi, Michal,
>> >> 
>> >> Michal Hocko <mhocko@suse.com> writes:
>> >> 
>> >> > On Fri 11-08-23 17:08:19, Huang Ying wrote:
>> >> >> If there is no memory allocation/freeing in the remote pageset after
>> >> >> some time (3 seconds for now), the remote pageset will be drained to
>> >> >> avoid memory wastage.
>> >> >> 
>> >> >> But in the current implementation, vmstat updater worker may not be
>> >> >> re-queued when we are waiting for the timeout (pcp->expire != 0) if
>> >> >> there are no vmstat changes, for example, when CPU goes idle.
>> >> >
>> >> > Why is that a problem?
>> >> 
>> >> The pages of the remote zone may be kept in the local per-CPU pageset
>> >> for long time as long as there's no page allocation/freeing on the
>> >> logical CPU.  In addition to the logical CPU goes idle, this is also
>> >> possible if the logical CPU is busy in the user space.
>> >
>> > But why is this a problem? Is the scale of the problem sufficient to
>> > trigger out of memory situations or be otherwise harmful?
>> 
>> This may trigger premature page reclaiming.  The pages in the PCP of the
>> remote zone would have been freed to satisfy the page allocation for the
>> remote zone to avoid page reclaiming.  It's highly possible that the
>> local CPU just allocate/free from/to the remote zone temporarily.
>
> I am slightly confused here but I suspect by zone you mean remote pcp.
> But more importantly is this a concern seen in real workload? Can you
> quantify it in some manner? E.g. with this patch we have X more kswapd
> scanning or even hit direct reclaim much less often.
>> So,
>> we should free PCP pages of the remote zone if there is no page
>> allocation/freeing from/to the remote zone for 3 seconds.
>
> Well, I would argue this depends a lot. There are workloads which really
> like to have CPUs idle and yet they would like to benefit from the
> allocator fast path after that CPU goes out of idle because idling is
> their power saving opportunity while workloads want to act quickly after
> there is something to run.
>
> That being said, we really need some numbers (ideally from real world)
> that proves this is not just a theoretical concern.

The behavior to drain the PCP of the remote zone (that is, remote PCP)
was introduced in commit 4ae7c03943fc ("[PATCH] Periodically drain non
local pagesets").  The goal of draining was well documented in the
change log.  IIUC, some of your questions can be answered there?

This patch just restores the original behavior changed by commit
7cc36bbddde5 ("vmstat: on-demand vmstat workers V8").

--
Best Regards,
Huang, Ying
