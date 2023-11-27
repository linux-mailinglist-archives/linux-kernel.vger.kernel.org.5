Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE57FAA98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjK0TuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjK0TuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:50:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7371B4;
        Mon, 27 Nov 2023 11:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701114628; x=1732650628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FOWlBJuI1QWETMszMwBkYk25m1g8XF0ebe/+lRpK/Yg=;
  b=gCObUKfTaJZdrOdFp7nSPUlKYVaHXKwxM4Ib2kwUkf/AyO8UOxcrYknA
   uZnA47b8xdfi8hPOez76FhBEHIygWJDkNgmBs4lUZnLm1me/JUoG/UsAU
   10j89ErBIwrikmgmoF29llZP1QjTnWKsaU37s6uir64TLsArK/yNwhEVA
   5oXXzJhDg5tmRTW1vid8kuG9mRRTrq8fYA2KEcWMJcruDVVvk0Rzhe1eq
   k7n9Fyf3uAM+VidsAC9KaHiS5dEvSrkKxGAR78tmKOSv8023GrpNcJ9rR
   gjZfGiMkDUckR1Sgf6btmUk1GDAhOfRHybL0AgsicTcU0DBxM+2f6jmwh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389930690"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="389930690"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 11:50:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="744669420"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="744669420"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 11:50:28 -0800
Date:   Mon, 27 Nov 2023 11:50:26 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZWTzAujHdrJ950F3@agluck-desk3>
References: <20230929181626.210782-1-tony.luck@intel.com>
 <20231004183623.17067-1-tony.luck@intel.com>
 <20231004183623.17067-3-tony.luck@intel.com>
 <20231019151211.GHZTFHS3osBIL1IJbF@fat_crate.local>
 <ZTa37L2nlnbok8dz@agluck-desk3>
 <20231114192324.GAZVPJLGZmfJBS181/@fat_crate.local>
 <ZVPu/hX9b7lUkrBY@agluck-desk3>
 <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121115448.GCZVyaiNkNvb4t2NxB@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:54:48PM +0100, Borislav Petkov wrote:
> On Tue, Nov 14, 2023 at 02:04:46PM -0800, Tony Luck wrote:
> > Whichever of the timer and the CMCI happens first will run. Second to
> > arrive will pend the interrupt and be handled when interrupts are
> > enabled as the first completes.
> 
> So I still don't like the timer calling machine_check_poll() and
> cmci_mc_poll_banks() doing the same without any proper synchronization
> between the two.

But it isn't doing the same thing.  The timer calls:

	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

and cmci_mc_poll_banks() calls:

	machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));

A bank is either in the bitmap of banks to poll from the timer,
or in one of the per-cpu bitmaps of banks "owned" by that CPU to
be checked when a CMCI occurs. But it can't be in both.

> Yes, when you get a CMCI interrupt, you poll and do the call the storm
> code. Now what happens if the polling runs from softirq context and you
> get a CMCI interrupt at exactly the same time. I.e., is
> machine_check_poll() reentrant and audited properly?

So nothing bad happens. If Linux was polling some set of banks from
the timer and is interrupted by CMCI, the interrupt will check some
disjoint set of banks. All the history tracking code is done per-bank,
so there is no overlap.

> I hope I'm making more sense.

Yes. Totally making sense. I was under the mistaken impression that
the mce timers used TIMER_IRQSAFE and the nested CMCI while processing
a timed poll couldn't happen. So I learned something here too.

I'll think of some comment to add to the history tracking code
to summarize this thread.

-Tony
