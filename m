Return-Path: <linux-kernel+bounces-70839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631C859D11
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754C3B22102
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61820DF7;
	Mon, 19 Feb 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XgtKFXMg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC420B21
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328133; cv=none; b=Tp3s7pjYdhk1eIxJolvn3CsxdT2XeGCZwynnbdklLGy/i5IjcgCcVQSKVuiG/WtNKnQWi/Bo4TmVICHyXP6ZcsmqTVBbwKy4wPyvPmCncydQWZy/GhOBcB8ezoDizG+tUCRrcpTCo0hQ4bkBrGHBG/PVn4MvhifAywV6HqanjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328133; c=relaxed/simple;
	bh=7dCzav5dH27QqAYFaoUlp6tHsC0og/ofPmuEl8G6vRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcc1gLg3Xb50EgZ4zGNZg/RmcNXbuy9Y/hZTKMWjMyLftJ4F9KSGL3yMlhlJnPf6P9MsaxmO2zeyt1Fj4bROr+5K65m0ZyfR+9AC0g5JB768vPmS6UfBTGVkKOPHLt4TVsIlxFPHqCswXsr/YcoBc3cyguQDq3ztB4W1FYqPiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XgtKFXMg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708328132; x=1739864132;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7dCzav5dH27QqAYFaoUlp6tHsC0og/ofPmuEl8G6vRA=;
  b=XgtKFXMgGw8HDXaIcEoZ2r2vz8FaBYoTepMpKPnz1AzsFHwDq4ettlVP
   iHrdl2pJM0J0iMVF/p6MYR1kkTDxfVJfnlMIIB6h1O6YGEAu6ZjNNmQiz
   0sV+VkosVZJjih2AEHRApt2x/KKY+JihJM/XFgZ0JaT1/bjWyH71B/Lv7
   hCDHz0wIXCcVsUnoEIW+W/8qXCsMB4ANmgFMJRlVRW8LflVchQlfFFMeR
   +TMY+UHyQuMepTVsuUO99m0A8WayfsFS5IIvJfpFMmbd1brshMPnhKVpg
   cKqbdnvACeNJ93nHf8wPvIhjqk5ifjBWSWp/s8SUKCro3b5lOm5FLNlfL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2258451"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2258451"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:35:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4316196"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 23:35:26 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Juri Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Daniel
 Bristot de Oliveira <bristot@redhat.com>,  Valentin Schneider
 <vschneid@redhat.com>,  linux-kernel@vger.kernel.org,  Luca Abeni
 <luca.abeni@santannapisa.it>,  Tommaso Cucinotta
 <tommaso.cucinotta@santannapisa.it>,  Thomas Gleixner
 <tglx@linutronix.de>,  Joel Fernandes <joel@joelfernandes.org>,  Vineeth
 Pillai <vineeth@bitbyteword.org>,  Shuah Khan <skhan@linuxfoundation.org>,
  Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lu@intel.com>, Kairui Song
 <kasong@tencent.com>, Guo Ziliang <guo.ziliang@zte.com.cn>
Subject: Re: [PATCH v5 0/7] SCHED_DEADLINE server infrastructure
In-Reply-To: <cover.1699095159.git.bristot@kernel.org> (Daniel Bristot de
	Oliveira's message of "Sat, 4 Nov 2023 11:59:17 +0100")
References: <cover.1699095159.git.bristot@kernel.org>
Date: Mon, 19 Feb 2024 15:33:30 +0800
Message-ID: <8734tosyb9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Daniel,

Thanks a lot for your great patchset!

We have a similar starvation issue in mm subsystem too.  Details are in
the patch description of the below commit.  In short, task A is busy
looping on some event, while task B will signal the event after some
work.  If the priority of task A is higher than that of task B, task B
may be starved.

IIUC, if task A is RT task while task B is fair task, then your patchset
will solve the issue.  If both task A and task B is RT tasks, is there
some way to solve the issue?

Now, we use a ugly schedule_timeout_uninterruptible(1) in the loop to
resolve the issue, is there something better?

Best Regards,
Huang, Ying

--------------------------8<---------------------------------------
commit 029c4628b2eb2ca969e9bf979b05dc18d8d5575e
Author: Guo Ziliang <guo.ziliang@zte.com.cn>
Date:   Wed Mar 16 16:15:03 2022 -0700

    mm: swap: get rid of livelock in swapin readahead
    
    In our testing, a livelock task was found.  Through sysrq printing, same
    stack was found every time, as follows:
    
      __swap_duplicate+0x58/0x1a0
      swapcache_prepare+0x24/0x30
      __read_swap_cache_async+0xac/0x220
      read_swap_cache_async+0x58/0xa0
      swapin_readahead+0x24c/0x628
      do_swap_page+0x374/0x8a0
      __handle_mm_fault+0x598/0xd60
      handle_mm_fault+0x114/0x200
      do_page_fault+0x148/0x4d0
      do_translation_fault+0xb0/0xd4
      do_mem_abort+0x50/0xb0
    
    The reason for the livelock is that swapcache_prepare() always returns
    EEXIST, indicating that SWAP_HAS_CACHE has not been cleared, so that it
    cannot jump out of the loop.  We suspect that the task that clears the
    SWAP_HAS_CACHE flag never gets a chance to run.  We try to lower the
    priority of the task stuck in a livelock so that the task that clears
    the SWAP_HAS_CACHE flag will run.  The results show that the system
    returns to normal after the priority is lowered.
    
    In our testing, multiple real-time tasks are bound to the same core, and
    the task in the livelock is the highest priority task of the core, so
    the livelocked task cannot be preempted.
    
    Although cond_resched() is used by __read_swap_cache_async, it is an
    empty function in the preemptive system and cannot achieve the purpose
    of releasing the CPU.  A high-priority task cannot release the CPU
    unless preempted by a higher-priority task.  But when this task is
    already the highest priority task on this core, other tasks will not be
    able to be scheduled.  So we think we should replace cond_resched() with
    schedule_timeout_uninterruptible(1), schedule_timeout_interruptible will
    call set_current_state first to set the task state, so the task will be
    removed from the running queue, so as to achieve the purpose of giving
    up the CPU and prevent it from running in kernel mode for too long.
    
    (akpm: ugly hack becomes uglier.  But it fixes the issue in a
    backportable-to-stable fashion while we hopefully work on something
    better)
    
    Link: https://lkml.kernel.org/r/20220221111749.1928222-1-cgel.zte@gmail.com
    Signed-off-by: Guo Ziliang <guo.ziliang@zte.com.cn>
    Reported-by: Zeal Robot <zealci@zte.com.cn>
    Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
    Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
    Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
    Acked-by: Hugh Dickins <hughd@google.com>
    Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
    Cc: Michal Hocko <mhocko@kernel.org>
    Cc: Minchan Kim <minchan@kernel.org>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: Roger Quadros <rogerq@kernel.org>
    Cc: Ziliang Guo <guo.ziliang@zte.com.cn>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8d4104242100..ee67164531c0 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -478,7 +478,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * __read_swap_cache_async(), which has set SWAP_HAS_CACHE
 		 * in swap_map, but not yet added its page to swap cache.
 		 */
-		cond_resched();
+		schedule_timeout_uninterruptible(1);
 	}
 
 	/*

