Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73287749BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjHHUCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjHHUCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:02:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C121488B03;
        Tue,  8 Aug 2023 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691518836; x=1723054836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cktqoN6sRZ8Mcvz8yn3Xtu3xKyhgq3NAFOvqgJPCRZg=;
  b=Eq8VjCDqkUs+BE+BV2h8uUs/bf5gw2EKwU57k21Bjutt3HKE0ToBdXhi
   0uBKplzWIkP4T9lB04U3PaYY6CaH8UNipTPlRoyei5zR/jUg0loTkym9s
   zd06WTcOIBr4Wdgh/UHI1ppvVrIthUVKw6SwWncP1qoO3ifz+fTEcBPtT
   /RCmDg+vzZFF9GuHdbJPP/viovBMpR21T27NU2unjd4eOetb4CwjkMHvU
   abjBgtzmN5SXZaqPy2AE4usHMny71y67x0PZq4cYqkFw6nNaNHFCFKDT6
   RTK4RrKsqoILmdVM3G1dcgK87GVmzso+kvRgr4tPeW+sfYm5mQ4kp7pA+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373681645"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="373681645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708350174"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="708350174"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:38:49 -0700
Date:   Tue, 8 Aug 2023 10:38:48 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display zero tool counts
Message-ID: <ZNJ9qBoBt2spEy4Y@tassilo>
References: <20230801205452.3380578-1-irogers@google.com>
 <ZMwUI/YtEHsO3Cc8@kernel.org>
 <ZNEFt3w/wNCvdawF@tassilo>
 <ZNFJatDztFNS90d3@kernel.org>
 <ZNFMqzSAfno/+BcV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNFMqzSAfno/+BcV@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:57:31PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 07, 2023 at 04:43:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Aug 07, 2023 at 07:54:47AM -0700, Andi Kleen escreveu:
> > > On Thu, Aug 03, 2023 at 05:54:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers escreveu:
> > > > > Skip zero counts for tool events.
> > > > > 
> > > > > Reported-by: Andi Kleen <ak@linux.intel.com>
> > > > 
> > > > Andi,
> > > > 
> > > > 	Have you tested this? Can we please have your Tested-by?
> > > 
> > > I thought I had sent it earlier?
> > > 
> > > Tested-by: Andi Kleen <ak@linux.intel.com>
> > 
> > Yeah, you did it, sorry, somehow I didn't notice.
> > 
> > Applying.
> 
> Would be good to have the original link with your report and to figure
> out the cset that introduced the problem, so that we could have a Fixes
> tag to help justifying getting this into 6.5.

Just bisected it. The original patch was below. Remarkably it had a "Fixes"
tag too)

My report was 

https://lore.kernel.org/linux-perf-users/ZMlrzcVrVi1lTDmn@tassilo/

commit b897613510890d6e92b6a276a20f6c3d96fe90e8
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Dec 6 09:58:04 2022 -0800

    perf stat: Update event skip condition for system-wide per-thread mode and merged uncore and hybrid events

    In print_counter_aggrdata(), it skips some events that has no aggregate
    count.  It's actually for system-wide per-thread mode and merged uncore
    and hybrid events.

    Let's update the condition to check them explicitly.

    Fixes: 91f85f98da7ab8c3 ("perf stat: Display event stats using aggr counts")
