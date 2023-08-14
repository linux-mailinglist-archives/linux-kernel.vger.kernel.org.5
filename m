Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C777AF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjHNCCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjHNCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:01:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF519A0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 19:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691978490; x=1723514490;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=elP5MaPiK7sfhDGC7LIIpybcSaFP9t6Qc2Prs7OZsoI=;
  b=Wg+WicIz8p+/3pWqpLmCizpxyARbqR/8laNKbJVlhfPM38lG+FT/0Ech
   eqnOVBFYPqhSWAbjzEykH8yzoGainLG+Tq3yXW6W1JBS2lZ6IgfhK4VoV
   hKihe12YwQ6zmnyv2ijKbUk4idcINN7Wl8QaWGwMNB3TjFaBF/GkZfC2h
   QkTXix5gcBqKpAe7kDYBK1NF5tI3zWz0l9WP8/2L5FZ/Xo9/O6V5L3PMN
   ETXoZXNFHKnq6waDAbLz50+OFfXoUJ/iP5tS79M1utPO81eOzzluktL/8
   ORNp7xszoGtpwH/RbSY1HSzZPfcByltEd6QrmhFz7PTXaJohS6Uj33yfh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="369414378"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="369414378"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 19:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="979821263"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="979821263"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 19:01:28 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
References: <20230811090819.60845-1-ying.huang@intel.com>
        <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
Date:   Mon, 14 Aug 2023 09:59:51 +0800
In-Reply-To: <ZNYA6YWLqtDOdQne@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 11 Aug 2023 11:35:37 +0200")
Message-ID: <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Hi, Michal,

Michal Hocko <mhocko@suse.com> writes:

> On Fri 11-08-23 17:08:19, Huang Ying wrote:
>> If there is no memory allocation/freeing in the remote pageset after
>> some time (3 seconds for now), the remote pageset will be drained to
>> avoid memory wastage.
>> 
>> But in the current implementation, vmstat updater worker may not be
>> re-queued when we are waiting for the timeout (pcp->expire != 0) if
>> there are no vmstat changes, for example, when CPU goes idle.
>
> Why is that a problem?

The pages of the remote zone may be kept in the local per-CPU pageset
for long time as long as there's no page allocation/freeing on the
logical CPU.  In addition to the logical CPU goes idle, this is also
possible if the logical CPU is busy in the user space.

I will update the change log to include this.

--
Best Regards,
Huang, Ying

>> This is fixed via guaranteeing that the vmstat updater worker will
>> always be re-queued when we are waiting for the timeout.
>> 
>> We can reproduce the bug via allocating/freeing pages from remote
>> node, then go idle.  And the patch can fix it.
>> 
>> Fixes: 7cc36bbddde5 ("vmstat: on-demand vmstat workers V8")
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> ---
>>  mm/vmstat.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index b731d57996c5..111118741abf 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -856,8 +856,10 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
>>  				continue;
>>  			}
>>  
>> -			if (__this_cpu_dec_return(pcp->expire))
>> +			if (__this_cpu_dec_return(pcp->expire)) {
>> +				changes++;
>>  				continue;
>> +			}
>>  
>>  			if (__this_cpu_read(pcp->count)) {
>>  				drain_zone_pages(zone, this_cpu_ptr(pcp));
>> -- 
>> 2.39.2
