Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE887B6F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjJCQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240561AbjJCQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:55:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB6136
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696352133; x=1727888133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pOmDbgmKcuR1roL2tpS4qxKkRr99cuVsIxqAedHHY30=;
  b=hl+rTVuFffzSCFHmqCz9ICBuQmXM5kpRMV9GRrJWEOXkXrANyNSTdl/1
   y69jERJ46mnkPO89xjVSSqgUmr35zNOjXEKPzqm83zBon0OYVUcbG9BLy
   IbGG0SHm/31E8phyhalO+6GqW/AplBWPsmrOuZy6iGfeTPa4gb/cJvzNa
   OS+3LZ1sOEJDgYTxW+M8l+85K0Brxsq6+Ehwlx1bsGsfbwd5h2TNOhucO
   5Tp2v3bVpeFKjNQc8aDleMUgeJ1l/s+R0gVbnGPre2XKO1Cym6n7z5yhB
   2znvCzYz6JJjU75vh4xdayzr/FZu7LkTAEiZRcrB/zDUro6Z+RsVdbCvi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="413836513"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="413836513"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816755076"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="816755076"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:55:26 -0700
Date:   Tue, 3 Oct 2023 09:55:25 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Message-ID: <ZRxHfTF1YrlONXPL@tassilo>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
 <20231002213752.GB1539@noisy.programming.kicks-ass.net>
 <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
 <20231003102733.GC1539@noisy.programming.kicks-ass.net>
 <ZRwuE8LPkwtkjX5C@tassilo>
 <20231003163300.GF1539@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003163300.GF1539@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 06:33:00PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 03, 2023 at 08:06:59AM -0700, Andi Kleen wrote:
> > > I'm thinking we should do something like expose branch_counter_nr and
> > > branch_counter_width in the sysfs node, and then rename this extra field
> > > to counters.
> > > 
> > > Then userspace can do something like:
> > > 
> > > 	for (i = 0; i < branch_counter_nr; i++) {
> > > 		counter[i] = counters & ((1 << branch_counter_width) - 1);
> > > 		counters >>= branch_counter_width;
> > > 	}
> > > 
> > > to extract the actual counter values.
> > 
> > perf script/report won't necessarily have access to the sysfs
> > values if they run on a different system
> > 
> > It would need extra PT style metadata written by perf record to
> > perf.data and read by the user tools.
> > 
> > Seems complicated. It would be better if it just parsed on its own.
> 
> Well, you really don't want to repeat the 4,2 thing in every event, that
> seems daft (and a waste of space, because how large do we want those
> fields to be etc..).

It's just a few bits? It could be an extra 16bit field or so per event.

There are probably other self describing encodings for the numbers
(e.g. some variant of LEB128 on a sub byte level), but that might be more
expensive to store it.

What would worry me is that various users would just hard code and then
fail later. There are lots of non perf tools perf.data parsers around
these days.

-Andi

