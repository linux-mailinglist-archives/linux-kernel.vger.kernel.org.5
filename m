Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64D27835D4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjHUWeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:33:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61915FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692657238; x=1724193238;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=y1oGB6OYm+lMPRY3bo4wb8Bk5yhL5dA7ScBZDtcGFU0=;
  b=HeRKqaM2scTn79yXqqKd6gXgAd/xkxVxL+RGOKwOrcRE/e9OiL4rPiZl
   A9bWkoBxKaUdNWcNvOANNYhT1A5PRwPPW+TXzkonKpXlus2HWkvgRznLA
   NXSKlQHbxfldBbQfgGVJzJmcUMIJJyWivpM2mDVLrAHDFM39EuaI1/iAx
   OJBmMV0ARDwnwLhXdmP981FkmkUuu8U9xUQBLKbNFJduGIkJcQox8+NCi
   N20s0BUpaIXfJgo4OfiBpHyk7mqG0NjG//dSXVvf+SFH3G1PJ3YthS+jq
   JY2PWp2xAopkcTtbqykx52lgYsfspwNgPUY6nsjy53sfheN1/B0mOmSCd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354038682"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="354038682"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 15:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765533793"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="765533793"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 15:33:55 -0700
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
        <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz>
Date:   Tue, 22 Aug 2023 06:31:42 +0800
In-Reply-To: <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 21 Aug 2023 11:27:38 +0200")
Message-ID: <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon 21-08-23 16:30:18, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Wed 16-08-23 15:08:23, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> >> 
>> >> > On Mon 14-08-23 09:59:51, Huang, Ying wrote:
>> >> >> Hi, Michal,
>> >> >> 
>> >> >> Michal Hocko <mhocko@suse.com> writes:
>> >> >> 
>> >> >> > On Fri 11-08-23 17:08:19, Huang Ying wrote:
>> >> >> >> If there is no memory allocation/freeing in the remote pageset after
>> >> >> >> some time (3 seconds for now), the remote pageset will be drained to
>> >> >> >> avoid memory wastage.
>> >> >> >> 
>> >> >> >> But in the current implementation, vmstat updater worker may not be
>> >> >> >> re-queued when we are waiting for the timeout (pcp->expire != 0) if
>> >> >> >> there are no vmstat changes, for example, when CPU goes idle.
>> >> >> >
>> >> >> > Why is that a problem?
>> >> >> 
>> >> >> The pages of the remote zone may be kept in the local per-CPU pageset
>> >> >> for long time as long as there's no page allocation/freeing on the
>> >> >> logical CPU.  In addition to the logical CPU goes idle, this is also
>> >> >> possible if the logical CPU is busy in the user space.
>> >> >
>> >> > But why is this a problem? Is the scale of the problem sufficient to
>> >> > trigger out of memory situations or be otherwise harmful?
>> >> 
>> >> This may trigger premature page reclaiming.  The pages in the PCP of the
>> >> remote zone would have been freed to satisfy the page allocation for the
>> >> remote zone to avoid page reclaiming.  It's highly possible that the
>> >> local CPU just allocate/free from/to the remote zone temporarily.
>> >
>> > I am slightly confused here but I suspect by zone you mean remote pcp.
>> > But more importantly is this a concern seen in real workload? Can you
>> > quantify it in some manner? E.g. with this patch we have X more kswapd
>> > scanning or even hit direct reclaim much less often.
>> >> So,
>> >> we should free PCP pages of the remote zone if there is no page
>> >> allocation/freeing from/to the remote zone for 3 seconds.
>> >
>> > Well, I would argue this depends a lot. There are workloads which really
>> > like to have CPUs idle and yet they would like to benefit from the
>> > allocator fast path after that CPU goes out of idle because idling is
>> > their power saving opportunity while workloads want to act quickly after
>> > there is something to run.
>> >
>> > That being said, we really need some numbers (ideally from real world)
>> > that proves this is not just a theoretical concern.
>> 
>> The behavior to drain the PCP of the remote zone (that is, remote PCP)
>> was introduced in commit 4ae7c03943fc ("[PATCH] Periodically drain non
>> local pagesets").  The goal of draining was well documented in the
>> change log.  IIUC, some of your questions can be answered there?
>> 
>> This patch just restores the original behavior changed by commit
>> 7cc36bbddde5 ("vmstat: on-demand vmstat workers V8").
>
> Let me repeat. You need some numbers to show this is needed.

I have done some test for this patch as follows,

- Run some workloads, use `numactl` to bind CPU to node 0 and memory to
  node 1.  So the PCP of the CPU on node 0 for zone on node 1 will be
  filled.

- After workloads finish, idle for 60s

- Check /proc/zoneinfo

With the original kernel, the number of pages in the PCP of the CPU on
node 0 for zone on node 1 is non-zero after idle.  With the patched
kernel, that becomes 0 after idle.  We avoid to keep pages in the remote
PCP during idle.

This is the number I have.  If you think it isn't enough to justify the
patch, then I'm OK too (although I think it's enough).  Because the
remote PCP will be drained later when some pages are allocated/freed on
the CPU.

--
Best Regards,
Huang, Ying
