Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60272765CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjG0UGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjG0UGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:06:05 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E3C2D7D;
        Thu, 27 Jul 2023 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690488357; x=1722024357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Msn3P7XhihBuXIiP755PoG7r2oz2s+xBr5H2iJd5InA=;
  b=Tk6poIR7i+qalq+p0aRuMFmPpBlTQH98Osu9Wfuui4aI9zsK/isczqhg
   bpjyOQ9uoHfT61Tvw4UJ/RIWnZIUWTCHyyUw8OM4bpVPK0lr4wnGC3/Rg
   iPYNEupQgGLVF5OU4hlduyB9OGDXjYwHrT3W7O325ApyUxSa0R9PjAas9
   S1XpLuLIx2W4bikGzIAZktRBRnQFBEoTio+d6B0mR3QXMMoxlfSWbb2cA
   SNrsZ7onWpHNTLLZHpZw6/Ch5dGZVJuz6IG40t6O3mI2XQb9PTPWWiZmS
   5I09L+8fD2s0yZXPpdfVW8m5kTGBkJaq3upBA4F+i0L5RHjW9XBEGxekQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="365879766"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="365879766"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727147160"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="727147160"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:05:57 -0700
Date:   Thu, 27 Jul 2023 13:05:56 -0700
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
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Parse event sort/regroup fixes
Message-ID: <ZMLOJNGDlvlU1NBD@tassilo>
References: <20230719001836.198363-1-irogers@google.com>
 <ZLf4C/+x2ZSpb1Uz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLf4C/+x2ZSpb1Uz@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:49:47AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 18, 2023 at 05:18:33PM -0700, Ian Rogers escreveu:
> > Patch 1, fix:
> > perf stat -e cycles,slots,topdown-fe-bound
> > so that cycles isn't made a group leader (failure caused by PMUs
> > matching). Previously this event list would fail so not necessarily a
> > regression over previous perf release.
> > 
> > Patch 2, when regrouping events the leader needs to be updated due to
> > sorting. This fix causes larger event groups that then regress at
> > least the tigerlake metric test as the kernel PMU driver fails to
> > break the weak groups. This is a fix for a bug but the consequence of
> > fixing the bug is to make a passing test fail due to the kernel PMU
> > driver.
> > 
> > Patch 3, don't alter the list position of events without a group if
> > they don't need forcing into a group. Analysis showed this was the
> > cause of the issue reported by Andi Kleen:
> > https://lore.kernel.org/linux-perf-users/ZLBgbHkbrfGygM%2Fu@tassilo/
> 
> Andi,
> 
> 	Can you please check these patches and provide a Tested-by?

Tested-by: Andi Kleen <ak@linux.intel.com>

-Andi
