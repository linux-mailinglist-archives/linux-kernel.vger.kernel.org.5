Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24267AAB02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjIVH67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIVH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:58:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C183
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695369532; x=1726905532;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VSgEQk+bSFEoNsLLa87F/gjR0Fg53115/l50nZmCo7E=;
  b=kRBvTbuzTvSsjZ7xWP8B6XSgToddMq2r7+3ETynzE6sACOgiPZ8g8psq
   fK+T2OrMvypVxGxZyfmRY2YxdNaw0NR2fZGNbBosoKFQKd+JBVq5jZHOO
   +ZsfRz57SJtfrC5j/+3FYAHqJOZr/zESlSn6m3BISYAEmKDBqxxsTsocJ
   t7pM0pxCIgDIIOyVAQQsAJzG9FBrSuUbQsGmDeP1p8nz1BEud50dJcDeX
   UFoz6n9Q6KEVJJfqHqr+5LAO0+J+x2IYrCL7dWoq9bPmqRBNQ3W+/uMfD
   uxsxMhs+2gVoq3sxE+Xh3mOVu3MXw57+V73NpmY9dhoJysi+ZGPTvy+PX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="361022400"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="361022400"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 00:58:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="817692142"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="817692142"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 00:58:48 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "Pavel Tatashin" <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 02/10] cacheinfo: calculate per-CPU data cache size
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-3-ying.huang@intel.com>
        <20230920092402.pvqju4knnqkzqfiq@bogus>
Date:   Fri, 22 Sep 2023 15:56:41 +0800
In-Reply-To: <20230920092402.pvqju4knnqkzqfiq@bogus> (Sudeep Holla's message
        of "Wed, 20 Sep 2023 10:24:02 +0100")
Message-ID: <87cyyawshy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> On Wed, Sep 20, 2023 at 02:18:48PM +0800, Huang Ying wrote:
>> Per-CPU data cache size is useful information.  For example, it can be
>> used to determine per-CPU cache size.  So, in this patch, the data
>> cache size for each CPU is calculated via data_cache_size /
>> shared_cpu_weight.
>>
>> A brute-force algorithm to iterate all online CPUs is used to avoid
>> to allocate an extra cpumask, especially in offline callback.
>>
>
> You have not mentioned who will use this information ? Looking at the
> change, it is not exposed to the user-space. Also I see this is actually
> part of the series [1]. Is this info used in any of those patches ? Can you
> point me to the same ?

Yes.  It is used by [PATCH 03/10] of the series.  If the per-CPU data
cache size is large enough, we will cache more pages in the per-CPU
pageset to reduce the zone lock contention.

> Not all architecture use cacheinfo yet. How will the mm changes affect those
> platforms ?

If cacheinfo isn't available, we will fallback to the original
behavior.  That is, we will drain per-CPU pageset more often (that is,
cache less to improve cache-hot pages sharing between CPUs).

> --
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/all/20230920061856.257597-1-ying.huang@intel.com/

--
Best Regards,
Huang, Ying
