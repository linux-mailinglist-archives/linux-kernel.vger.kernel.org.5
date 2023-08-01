Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B276B8D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjHAPkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjHAPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:40:53 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843A2680;
        Tue,  1 Aug 2023 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690904438; x=1722440438;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=muE1e71Qs9F7v4+U0wdllHsFFSc1KZTzZO9B2QRYfko=;
  b=i2qGIPgwZRxvrG+Km15uGP4kehnjY1Df3+xUhMoqUukBOVjAEbnjLb2o
   kAFBQDD2BsieOoERl4gVR5xLTyeIXxzq4Y+h9VZ6vJ/i/AB7w2rYvH791
   bNrqOo8+CmNhAXGm3O7JHBYNhqs+lGfelWtMfk+VBdGuvH5xOE7UUY+oH
   Ke1HAZyxmFUcwhUmE5pRnLoBwT8n6rhJIZv6es3ELPSeuxPJI5LH8pQxa
   v9YrSgCOWJPJ93tr3Y5bXmEKqFgHe8cgjNi8idi17SBb+tBNyRFL+fOaw
   wXSf4A55BeQUK3NxprmXm8AE/TlQkmAV21ePZRsgyjHbKoRpHUv6asTOf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="435659315"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="435659315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794238163"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="794238163"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 08:40:32 -0700
Received: from [10.212.24.90] (kliang2-mobl1.ccr.corp.intel.com [10.212.24.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0098458068A;
        Tue,  1 Aug 2023 08:40:30 -0700 (PDT)
Message-ID: <faca2b35-fdd6-7394-edea-32dd59d3a16f@linux.intel.com>
Date:   Tue, 1 Aug 2023 11:40:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/4] perf parse-events x86: Avoid sorting
 uops_retired.slots
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
References: <20230801053634.1142634-1-irogers@google.com>
 <20230801053634.1142634-2-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230801053634.1142634-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-01 1:36 a.m., Ian Rogers wrote:
> As topdown.slots may appear as slots it may get confused with
> uops_retired.slots which is an invalid perf metric event group
> leader. Special case uops_retired.slots to avoid this confusion.
> 

Does any name with format "name.slots" cause the confusion? If so, I
don't think we can stop others from naming like the above format.

Is it better to hard code the topdown.slots/slots, rather than
uops_retired.slots?

Thanks,
Kan

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 7 ++++---
>  tools/perf/arch/x86/util/evsel.c  | 7 +++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index cbd582182932..b1ce0c52d88d 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -75,11 +75,12 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>  
>  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  {
> -	if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
> +	if (topdown_sys_has_perf_metrics() &&
> +	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>  		/* Ensure the topdown slots comes first. */
> -		if (strcasestr(lhs->name, "slots"))
> +		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
>  			return -1;
> -		if (strcasestr(rhs->name, "slots"))
> +		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
>  			return 1;
>  		/* Followed by topdown events. */
>  		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 81d22657922a..090d0f371891 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -40,12 +40,11 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
>  
>  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  {
> -	if (!evsel__sys_has_perf_metrics(evsel))
> +	if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
> +	    strcasestr(evsel->name, "uops_retired.slots"))
>  		return false;
>  
> -	return evsel->name &&
> -		(strcasestr(evsel->name, "slots") ||
> -		 strcasestr(evsel->name, "topdown"));
> +	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
>  }
>  
>  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
