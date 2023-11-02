Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940747DECCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjKBGNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:13:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0B5DB;
        Wed,  1 Nov 2023 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698905595; x=1730441595;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/i1nfGSh8lqsODaI9yo1bI1rYHQ0A82xnF/8KFBEOuc=;
  b=TdR+59P2Yivda+0YH6r80VDP582r4Ev5KAEF/Bedd0AFozTN8k/biKc2
   QUOFgCbiRFIKt4BxBzxricDVHPDYMLLn83boUSPk8JI1fa8Q7YffegajK
   hYPu0zHcDLXlJRfY71zOnB6H+lGtFNP6/Ns/81B5L583TJY3ZkUQ4m7fe
   szvKQs04MCyYhEbGp3twejwLPWQyoRzmj92ewAvKmPprMVJXRwUR2v/W1
   jnXLfhBBhynb3eM2BrOaHhJRSgFz4LyCwkBV41dQm5n3lMmoZnN3feH51
   bGY9cHv9asKPbnuGm05VRS3Jd2kv032yQLn7mj0nsmmYKMAupW70n6V9r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="368852981"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="368852981"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="2329842"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 23:13:11 -0700
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
In-Reply-To: <ivhxexthtfums73nkko6yoy635h3cpetv4sqaemrmqd5pbhpq6@6zrizaoxgdwi>
        (Michal Hocko's message of "Wed, 1 Nov 2023 15:01:22 +0100")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <87msvy6wn8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ivhxexthtfums73nkko6yoy635h3cpetv4sqaemrmqd5pbhpq6@6zrizaoxgdwi>
Date:   Thu, 02 Nov 2023 14:11:09 +0800
Message-ID: <87il6k1y82.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 01-11-23 10:21:47, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
> [...]
>> > Well, I am not convinced about that TBH. Sure it is probably a good fit
>> > for this specific CXL usecase but it just doesn't fit into many others I
>> > can think of - e.g. proportional use of those tiers based on the
>> > workload - you get what you pay for.
>> 
>> For "pay", per my understanding, we need some cgroup based
>> per-memory-tier (or per-node) usage limit.  The following patchset is
>> the first step for that.
>> 
>> https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com/
>
> Why do we need a sysfs interface if there are plans for cgroup API?

They are for different target.  The cgroup API proposed here is to
constrain the DRAM usage in a system with DRAM and CXL memory.  The less
you pay, the less DRAM and more CXL memory you use.

--
Best Regards,
Huang, Ying
