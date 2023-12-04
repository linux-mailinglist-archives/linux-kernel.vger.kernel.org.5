Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF51802D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbjLDIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjLDIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:21:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C42D8;
        Mon,  4 Dec 2023 00:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701678068; x=1733214068;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=SctStx0/2r6BjPSkyNIBJr82NmxzrJUg7/EEBCUvaYM=;
  b=cMF4sUax1Cw27Kw1kE/AQuZ12AbCLPNFK4rEZ8Pp4pa+pvPRiVpwwN4A
   fRrfnr84T9YNan01J2gKiD45PyZHijeEffLKELxTtMIguglUvd0Lz/q6g
   JQRi/LrRhwffHAC6YDYlK29JRwPfB38AXfcmYoozF2nQb73x/T6YwlcNC
   aaAfJXUp3zp0zc1ECR8KL8naZkJ9N3q2ragK0RPvMAIk/1ZLVzOkYuouM
   rGNjgNQ6ls3Puk6D77DRJj8CKFrm029QpyWnBnBnAgO2eqqTrgGV6QJvq
   T3CClQaK1hLAGYor1tUyn71ss7mCCZZY4v9YMGrWoWa79j70UWygPbnQv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="752026"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="752026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 00:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720242377"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="720242377"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 00:21:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Michal Hocko <mhocko@suse.com>, "tj@kernel.org" <tj@kernel.org>,
        "John Groves" <john@jagalactic.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
In-Reply-To: <ZW1IdPI11nhKcdZl@memverge.com> (Gregory Price's message of "Sun,
        3 Dec 2023 22:33:08 -0500")
References: <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
        <ZU6pR46kiuzPricM@slm.duckdns.org> <ZU6uxSrj75EiXise@memverge.com>
        <ZU7vjsSkGbRLza-K@slm.duckdns.org> <ZU74L9oxWOoTTfpM@memverge.com>
        <ZVNBMW8iJIGDyp0y@tiehlicka> <ZVOXWx8XNJJNC23A@memverge.com>
        <ZVOn2T_Qg_NTKlB2@tiehlicka> <ZVOzMEtDYB4l8qFy@memverge.com>
        <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZW1IdPI11nhKcdZl@memverge.com>
Date:   Mon, 04 Dec 2023 16:19:02 +0800
Message-ID: <87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price <gregory.price@memverge.com> writes:

> On Wed, Nov 15, 2023 at 01:56:53PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>>=20
>> Because we usually have multiple nodes in one mem-tier, I still think
>> mem-tier-based interface is simpler than node-based.  But, it seems more
>> complex to introduce mem-tier into mempolicy.  Especially if we have
>> per-task weights.  So, I am fine to go with node-based interface.
>>=20
>> > * cgroups: "this doesn't involve dynamic resource accounting /
>> >             enforcement at all" and "these aren't resource
>> > 	    allocations, it's unclear what the hierarchical
>> > 	    relationship mean".
>> >
>> > * node: too global, explore smaller scope first then expand.
>>=20
>> Why is it too global?  I understand that it doesn't cover all possible
>> use cases (although I don't know whether these use cases are practical
>> or not).  But it can provide a reasonable default per-node weight based
>> on available node performance information (such as, HMAT, CDAT, etc.).
>> And, quite some workloads can just use it.  I think this is an useful
>> feature.
>>
>
> Have been sharing notes with more folks.  Michal thinks a global set of
> weights is unintuitive and not useful, and would prefer to see the
> per-task weights first.
>
> Though this may have been in response to adding it as an attribute of
> nodes directly.=20
>
> Another proposal here suggested adding a new sysfs setting
> https://github.com/skhynix/linux/commit/61d2fcc7a880185df186fa2544edcd2f8=
785952a
>
>   $ tree /sys/kernel/mm/interleave_weight/
>   /sys/kernel/mm/interleave_weight/
>   =E2=94=9C=E2=94=80=E2=94=80 enabled [1]
>   =E2=94=9C=E2=94=80=E2=94=80 possible [2]
>   =E2=94=94=E2=94=80=E2=94=80 node
>       =E2=94=9C=E2=94=80=E2=94=80 node0
>       =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 interleave_weight [3]
>       =E2=94=94=E2=94=80=E2=94=80 node1
>           =E2=94=94=E2=94=80=E2=94=80 interleave_weight [3]
>
> (this could be changed to /sys/kernel/mm/mempolicy/...)
>
> I think the internal representation of this can be simplified greatly,
> over what the patch provides now, but maybe this solves the "it doesn't
> belong in these other components" issue.
>
> Answer: Simply leave it as a static global kobject in mempolicy, which
> also deals with many of the issues regarding race conditions.

Although personally I prefer to add interleave weight as an attribute of
nodes.  I understand that some people think it's not appropriate to
place anything node-specific there.  So, some place under /sys/kernel/mm
sounds reasonable too.

> If a user provides weights, use those.  If they do not, use globals.

Yes.  That is the target use case.

> On a cpuset rebind event (container migration, mems_allowed changes),
> manually set weights would have to remain, so in a bad case, the
> weights would be very out of line with the real distribution of memory.
>
> Example: if your nodemask is (0,1,2) and a migration changes it to
> (3,4,5), then unfortunately your weights will likely revert to [1,1,1]
>
> If set with global weights, they could automatically adjust.  It
> would not be perfect, but it would be better than the potential worst
> case above.  If that same migration occurs, the next allocation would
> simply use whatever the target node weights are in the global config.
>
> So if globally you have weights [3,2,1,1,2,3], and you move from
> nodemask (0,1,2) to (3,4,5), your weights change from [3,2,1] to
> [1,2,3].

That is nice.  And I prefer to emphasize the simple use case.  Users
don't need to specify interleave weight always.  Just use
MPOL_WEIGHTED_INTERLEAVE policy, and system will provide reasonable
default weight.

> If the structure is built as a matrix of (cpu_node,mem_nodes),
> the you can also optimize based on the node the task is running on.

The matrix stuff makes the situation complex.  If people do need
something like that, they can just use set_memorypolicy2() with user
specified weights.  I still believe that "make simple stuff simple, and
complex stuff possible".

> That feels very intuitive, deals with many race condition issues, and
> the global setting can actually be implemented without the need for
> set_mempolicy2 at all - which is certainly a bonus.
>
> Would love more thoughts here.  Will have a new RFC with set_mempolicy2,
> mbind2, and MPOL_WEIGHTED_INTERLEAVE soon that demonstrate the above.

Thanks for doing all these!

--
Best Regards,
Huang, Ying
