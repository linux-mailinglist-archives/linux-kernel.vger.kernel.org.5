Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A217E0067
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbjKCHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjKCHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:12:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740C9186;
        Fri,  3 Nov 2023 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698995562; x=1730531562;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jmqohwjW/b1Gj1tSFbJgVKBOkBp3iU7UqUowR8+rmss=;
  b=EOiG2iHA6ysPWC2VFS/X0pIkxZO/DhpqII76iOWigBbejSUWoomh8tSF
   I4DMmuDp0OhadX2RNr1RrMM+d0t7A85ODkSJQy2llwr+YzCLU89aCl6cm
   Ak5+ELXc4YPIcvPcLG97nED+rqmuNNPze62YCk56lsjHHIGPJI2j5sphr
   dhCEt4UqUBsVjuMRBpsZmX6hnDw5+QQdFT2SaHs0eVV+yI6qI9+v36m5L
   O09oEJzR8/8uKM3Yj3fW2x3UV8PaKb7ikDA4hlY11LAGDr0KfWzBeOHLb
   DGcYB2tNsaijCyF3twYecHYp6mtAZUAbxa1GS8jsShbIHnF/bBwoCI3GX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="386065255"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="386065255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 00:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905256191"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="905256191"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 00:12:38 -0700
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
In-Reply-To: <fe7ns7dvrhwp6o7fnn53wt7tuidsncjctgav4bdirwfmjxarne@3oyfe22mxc35>
        (Michal Hocko's message of "Thu, 2 Nov 2023 10:28:11 +0100")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ivhxexthtfums73nkko6yoy635h3cpetv4sqaemrmqd5pbhpq6@6zrizaoxgdwi>
        <87il6k1y82.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fe7ns7dvrhwp6o7fnn53wt7tuidsncjctgav4bdirwfmjxarne@3oyfe22mxc35>
Date:   Fri, 03 Nov 2023 15:10:37 +0800
Message-ID: <87jzqzz502.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Thu 02-11-23 14:11:09, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Wed 01-11-23 10:21:47, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> > [...]
>> >> > Well, I am not convinced about that TBH. Sure it is probably a good fit
>> >> > for this specific CXL usecase but it just doesn't fit into many others I
>> >> > can think of - e.g. proportional use of those tiers based on the
>> >> > workload - you get what you pay for.
>> >> 
>> >> For "pay", per my understanding, we need some cgroup based
>> >> per-memory-tier (or per-node) usage limit.  The following patchset is
>> >> the first step for that.
>> >> 
>> >> https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com/
>> >
>> > Why do we need a sysfs interface if there are plans for cgroup API?
>> 
>> They are for different target.  The cgroup API proposed here is to
>> constrain the DRAM usage in a system with DRAM and CXL memory.  The less
>> you pay, the less DRAM and more CXL memory you use.
>
> Right, but why the usage distribution requires its own interface and
> cannot be combined with the access control part of it?

Per my understanding, they are orthogonal.

Weighted-interleave is a memory allocation policy, other memory
allocation policies include local first, etc.

Usage limit is to constrain the usage of specific memory types
(e.g. DRAM) for a cgroup.  It can be used together with local first
policy and some other memory allocation policy.

--
Best Regards,
Huang, Ying
