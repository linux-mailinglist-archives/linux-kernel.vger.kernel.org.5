Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AD7E9420
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjKMBdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMBdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:33:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CF1BFF;
        Sun, 12 Nov 2023 17:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699839192; x=1731375192;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6s0Zq5kC1eUCJkylNpmwGs+kVYT+CkdgpvKFUIcNZk0=;
  b=jgqo5b9Uzu4FdV44tnGXWgh5sppys3uLgR+A7nP3I9sgtQoLJgp7ckk2
   i2S39zNA2aGOss9hWQ14GNI5OAsi2CPbaBW+jsvI3IjJ2u4SSH2xdPW1n
   9LhFruVTKYifXuaVizAEh+rBuRQKmZ2uXWGU0LKQFOFZksMB1pW31BEEU
   EAWX5dKfdCAo/D6mqFKGSRiQEHYg0BSvrWpn5CCBxgdsErE3S0OhyiaaH
   R9U/5WTeXgU0ZFPo/mNy0d7bCLdgMZuP8JO1wX079nKW0APbmTeWVzzpb
   wh919ZGz1YztJRFbWgn8HJn2oSEdV8L6tgiJFERd2x/ifM6bFEVVjFAFX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="3451167"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="3451167"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 17:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="854834930"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="854834930"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 17:33:08 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mhocko@kernel.org>, <tj@kernel.org>, <lizefan.x@bytedance.com>,
        <hannes@cmpxchg.org>, <corbet@lwn.net>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>, <muchun.song@linux.dev>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
In-Reply-To: <ZU6KiRv7iy/cUY7N@memverge.com> (Gregory Price's message of "Fri,
        10 Nov 2023 14:54:49 -0500")
References: <20231109002517.106829-1-gregory.price@memverge.com>
        <87zfzmf80q.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZU6KiRv7iy/cUY7N@memverge.com>
Date:   Mon, 13 Nov 2023 09:31:07 +0800
Message-ID: <87v8a6fnhg.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Gregory Price <gregory.price@memverge.com> writes:

> On Fri, Nov 10, 2023 at 02:16:05PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > This patchset implements weighted interleave and adds a new cgroup
>> > sysfs entry: cgroup/memory.interleave_weights (excluded from root).
>> >
>> > The il_weight of a node is used by mempolicy to implement weighted
>> > interleave when `numactl --interleave=...` is invoked.  By default
>> > il_weight for a node is always 1, which preserves the default round
>> > robin interleave behavior.
>> 
>> IIUC, this makes it almost impossible to set the default weight of a
>> node from the node memory bandwidth information.  This will make the
>> life of users a little harder.
>> 
>> If so, how about use a new memory policy mode, for example
>> MPOL_WEIGHTED_INTERLEAVE, etc.
>>
>
> weights are also inherited from parent cgroups, so if you set them in
> parent slices you can automatically set update system settings.
>
> by default the parent slice weights will always be 1 until set
> otherwise.  Once they're set, children inherit naturally.
>
> Maybe there's an argument here for including interleave_weights in the
> root cgroup.

Even if the interleave_weights is introduced in root cgroup, the initial
default weight need to be 1 to be back-compatible with the original
MPOL_INTERLEAVE.

If we don't reuse MPOL_INTERLEAVE, but use a new memory policy mode (say
MPOL_WEIGHTED_INTERLEAVE).  The default values of the interleave weight
in root cgroup needn't to be 1.  So, we can provide a more helpful
default interleave weight based on the node memory bandwidth information
(e.g., from HMAT, CDAT, etc).  That will make users life much easier.
Do you agree?

--
Best Regards,
Huang, Ying
