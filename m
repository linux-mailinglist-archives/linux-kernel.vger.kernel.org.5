Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D59D793462
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIFEUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjIFET6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:19:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9CCFE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 21:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973984; x=1725509984;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yBIgy9uWf/VMtrwstdvfcWOrvmslXDBJ4tqIjdwS/RM=;
  b=B4npVnnSGYrPV6mHZV0pwFKf4LhS7UFVa/Yu1Oo2x7fmyw/GyFOW9hx/
   4jckbruR8Rwg29NNKHew85uMtKtT29WVuypRwER6u/mvAznrD0j8s08J6
   uMP+xnOtenT39eR1uFowNK9S1saEj3hrzxjhT4Cc98xbaLrbLRkJ6zZ1B
   DOklSUy9+KSkJFzn5dur976It7UMs+65H4cAwys40b+nWOIn1IkbaSSC/
   kbm3MxcTq5A4rptcHVzenavaQK1/3iXeCSlt8Z4B4eQDB+qJGv/bBHwnc
   tbpuPSsCUu/0onsS1im3hjzM9C6tkFs3ko8xV7Vh9k2306TtizpmNkP4W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375870174"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375870174"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="741363272"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="741363272"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:19:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: fix draining remote pageset
References: <20230811090819.60845-1-ying.huang@intel.com>
        <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
        <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
        <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
        <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz>
        <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz>
        <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
        <703e284d-186a-5699-f06c-761e51115ae0@suse.cz>
Date:   Wed, 06 Sep 2023 12:17:27 +0800
In-Reply-To: <703e284d-186a-5699-f06c-761e51115ae0@suse.cz> (Vlastimil Babka's
        message of "Tue, 5 Sep 2023 18:52:29 +0200")
Message-ID: <87zg202aw8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka <vbabka@suse.cz> writes:

> On 8/25/23 19:06, Lameter, Christopher wrote:
>> On Tue, 22 Aug 2023, Michal Hocko wrote:
>> 
>>> Yes, this doesn't really show any actual correctness problem so I do not
>>> think this is sufficient to change the code. You would need to show that
>>> the existing behavior is actively harmful.
>> 
>> Having some pages from a remote NUMA node stuck in a pcp somewhere is 
>> making that memory unusable. It is usually rate that these remote pages 
>> are needed again and so they may remain there for a long time if the 
>> situation is right.
>> 
>> And he is right that the intended behavior of freeing the remote pages 
>> has been disabled by the patch.
>> 
>> So I think there is sufficient rationale to apply these fixes.
>
> I wonder if this the optimum way to handle the NOHZ case? IIUC there we use
> quiet_vmstat() to call refresh_cpu_vm_stats(). I'd expect if there were
> pending remote pages to flush, it would be best to do it immediately, and
> not keep a worker being requeued and only do that after the pcp->expires
> goes zero.
>
> However quiet_vmstat() even calls the refresh with do_pagesets == false. Why
> do we even refresh the stats at that moment if the delayed update is pending
> anyway?

According to commit f01f17d3705b ("mm, vmstat: make quiet_vmstat
lighter") and the comments in quiet_vmstat().  The pending worker will
not be canceled to avoid long latency of idle entry.

> And could we maybe make sure that in that case the flush is done on
> the first delayed update in that case and not expiring like this?

This sounds reasonable.  How to identify whether the current CPU is in
NOHZ state? Via tick_get_tick_sched()->tick_stopped?

--
Best Regards,
Huang, Ying
