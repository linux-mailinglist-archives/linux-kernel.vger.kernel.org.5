Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BBB7DECD6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjKBGYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:24:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFC8FB;
        Wed,  1 Nov 2023 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698906236; x=1730442236;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=STdydUh5mAz26anwvBBVVUpUuW54oz26dqCeLmmOLA0=;
  b=PVMR6Z1ACH2wLaUo8gFc2bzArURJjwhFFeZgMvx0GwN5G5UnILu8wGjj
   K/1MH/Dk/K5J80rvY3nzQLkxT/wGFGkENLfiaRWGHoe2+hL+qLhpre4BQ
   qeIJgbuWPVzbK2W42cNo5iXvYgyhne1ZyvuqFXpmFMgtSliHj2rGXJmV7
   +bQ92m6RDqfThZ5hR7otyLC6oSc0huf73jemxxTMcr+6n3JRQqZdCdNMz
   UMGF49esSiBF9L2gl8ww7L5xlPaODTnMaqGg+AFrLeGzQ6m1NC65e0EpR
   77ZpwL8EJGww/lLaOLPtjsSr36x3nr2sus3egbMVDv7p5jkA/6BI4Addq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="474885220"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="474885220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711036350"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="711036350"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:23:51 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, weixugc@google.com, apopple@nvidia.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, shy828301@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <3ilajsu7rlatugtmp63r6ussfdhqoxokj2vgmx3ki3zmx7f5po@i64b27upx5qx>
        (Michal Hocko's message of "Wed, 1 Nov 2023 14:56:13 +0100")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <20231031162216.GB3029315@cmpxchg.org>
        <3ilajsu7rlatugtmp63r6ussfdhqoxokj2vgmx3ki3zmx7f5po@i64b27upx5qx>
Date:   Thu, 02 Nov 2023 14:21:49 +0800
Message-ID: <87edh81xqa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Tue 31-10-23 12:22:16, Johannes Weiner wrote:
>> On Tue, Oct 31, 2023 at 04:56:27PM +0100, Michal Hocko wrote:
> [...]
>> > Is there any specific reason for not having a new interleave interface
>> > which defines weights for the nodemask? Is this because the policy
>> > itself is very dynamic or is this more driven by simplicity of use?
>> 
>> A downside of *requiring* weights to be paired with the mempolicy is
>> that it's then the application that would have to figure out the
>> weights dynamically, instead of having a static host configuration. A
>> policy of "I want to be spread for optimal bus bandwidth" translates
>> between different hardware configurations, but optimal weights will
>> vary depending on the type of machine a job runs on.
>
> I can imagine this could be achieved by numactl(8) so that the process
> management tool could set this up for the process on the start up. Sure
> it wouldn't be very dynamic after then and that is why I was asking
> about how dynamic the situation might be in practice.
>
>> That doesn't mean there couldn't be usecases for having weights as
>> policy as well in other scenarios, like you allude to above. It's just
>> so far such usecases haven't really materialized or spelled out
>> concretely. Maybe we just want both - a global default, and the
>> ability to override it locally. Could you elaborate on the 'get what
>> you pay for' usecase you mentioned?
>
> This is more or less just an idea that came first to my mind when
> hearing about bus bandwidth optimizations. I suspect that sooner or
> later we just learn about usecases where the optimization function
> maximizes not only bandwidth but also cost for that bandwidth. Consider
> a hosting system serving different workloads each paying different
> QoS.

I don't think pure software solution can enforce the memory bandwidth
allocation.  For that, we will need something like MBA (Memory Bandwidth
Allocation) as in the following URL,

https://www.intel.com/content/www/us/en/developer/articles/technical/introduction-to-memory-bandwidth-allocation.html

At lease, something like MBM (Memory Bandwidth Monitoring) as in the
following URL will be needed.

https://www.intel.com/content/www/us/en/developer/articles/technical/introduction-to-memory-bandwidth-monitoring.html

The interleave solution helps the cooperative workloads only.

> Do I know about anybody requiring that now? No! But we should really
> test the proposed interface for potential future extensions. If such an
> extension is not reasonable and/or we can achieve that by different
> means then great.

--
Best Regards,
Huang, Ying
