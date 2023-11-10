Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD487E83EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjKJUb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKJUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:31:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0475FF0;
        Thu,  9 Nov 2023 22:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699597091; x=1731133091;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=d3E/urWJ+WAtgq1ZPh+D0M58tD9eQzNWMlKG+spWjAQ=;
  b=K0Q1FRaqZCxOpICYU3gJY3aCIqXw1TSJmehR/7Z/YxrJW98/daRZsa1D
   HaZm8uWPS/ALgFhbRPo8BJvsfQ4D2THMpWFDYZVsIkRKJVW9LRYPNhpPH
   fq61qrPZ2PlXs6HuUorOADdsBg9hRzzP2QN1KjeQGh6zeAMQixdSZz46S
   YgP265FTGBp7aY7eIp0ihLkM863tvFYAUbE6DrIlobdrK6OiMc01dpvYV
   8+Yp3dPAOFpJIt0AWKXS/v5u8E8XTdX68sFaaQickwn7yya1C+uwNV2Mc
   wiO6lPDMK5dApMO5TmV3dJtf161akjzmhXOYa+ZGL/vVJFNutnb4WsdyT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389946752"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="389946752"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="798534270"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="798534270"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 22:18:06 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, corbet@lwn.net, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
In-Reply-To: <20231109002517.106829-1-gregory.price@memverge.com> (Gregory
        Price's message of "Wed, 8 Nov 2023 19:25:14 -0500")
References: <20231109002517.106829-1-gregory.price@memverge.com>
Date:   Fri, 10 Nov 2023 14:16:05 +0800
Message-ID: <87zfzmf80q.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Price <gourry.memverge@gmail.com> writes:

> This patchset implements weighted interleave and adds a new cgroup
> sysfs entry: cgroup/memory.interleave_weights (excluded from root).
>
> The il_weight of a node is used by mempolicy to implement weighted
> interleave when `numactl --interleave=...` is invoked.  By default
> il_weight for a node is always 1, which preserves the default round
> robin interleave behavior.

IIUC, this makes it almost impossible to set the default weight of a
node from the node memory bandwidth information.  This will make the
life of users a little harder.

If so, how about use a new memory policy mode, for example
MPOL_WEIGHTED_INTERLEAVE, etc.

> Interleave weights denote the number of pages that should be
> allocated from the node when interleaving occurs and have a range
> of 1-255.  The weight of a node can never be 0, and instead the
> preferred way to prevent allocation is to remove the node from the
> cpuset or mempolicy altogether.
>
> For example, if a node's interleave weight is set to 5, 5 pages
> will be allocated from that node before the next node is scheduled
> for allocations.
>
> # Set node weight for node 0 to 5
> echo 0:5 > /sys/fs/cgroup/user.slice/memory.interleave_weights
>
> # Set node weight for node 1 to 3
> echo 1:3 > /sys/fs/cgroup/user.slice/memory.interleave_weights
>
> # View the currently set weights
> cat /sys/fs/cgroup/user.slice/memory.interleave_weights
> 0:5,1:3
>
> Weights will only be displayed for possible nodes.
>
> With this it becomes possible to set an interleaving strategy
> that fits the available bandwidth for the devices available on
> the system. An example system:
>
> Node 0 - CPU+DRAM, 400GB/s BW (200 cross socket)
> Node 1 - CXL Memory. 64GB/s BW, on Node 0 root complex
>
> In this setup, the effective weights for a node set of [0,1]
> may be may be [86, 14] (86% of memory on Node 0, 14% on node 1)
> or some smaller fraction thereof to encourge quicker rounds
> for better overall distribution.
>
> This spreads memory out across devices which all have different
> latency and bandwidth attributes in a way that can maximize the
> available resources.
>

--
Best Regards,
Huang, Ying
