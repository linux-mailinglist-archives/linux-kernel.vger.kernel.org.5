Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996F57CF59B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbjJSKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjJSKrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:47:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881A5119;
        Thu, 19 Oct 2023 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697712442; x=1729248442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qz0qCHWdU2DO8LEEMx8unupi23tCgui51q2IYAY/sYQ=;
  b=XjkD9CROdo90T7uBXSdiCkt8uCVronaZZz9sttNg2GIzcEXATTEShLXw
   tsRZFe6TJv/D/gtkDCQYu/JUfdJPUkRrCcFImb6LCxofWwjUEjeFASZnD
   8PaNLqaEWqUodgJJ1qRfUjW2ad3rIdOrSvPR0sDpsOpQep8o3qJC8GUJE
   OBU39ih2drsvXfZc4xIoYpz9qDhiiNTvV2oKyz52Ny0VpGHCgrfK7c/QE
   b37FwZzxEtQA5Tivx1mKvtXcTtyqeteJfHcf2cmirn450ennLKAbSGrIN
   VY8v90ywAsFDvARkPq5bDQvbT+f1K3K5Bxs1+tr/5uw1UKN9AFuk7APOP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="385095787"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="385095787"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="847636117"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="847636117"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.14])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:47:17 -0700
Message-ID: <8a2ea58f-f835-4d1a-8bd6-3a63b3b0db94@intel.com>
Date:   Thu, 19 Oct 2023 13:47:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp
 trace
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-2-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231014074513.1668000-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/23 10:45, Leo Yan wrote:
> An AUX trace can contain timestamp, but in some situations, the hardware
> trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
> the same source with CPU's time, thus the decoder can not use the
> timestamp trace for samples.
> 
> This patch introduces 'T' itrace option. If users know the platforms

"If users know" <- how would users know?  Could the kernel
or tools also figure it out?

> they are working on have the same time counter with CPUs, users can
> use this new option to tell a decoder for using timestamp trace as
> kernel time.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/Documentation/itrace.txt | 1 +
>  tools/perf/util/auxtrace.c          | 3 +++
>  tools/perf/util/auxtrace.h          | 3 +++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> index a97f95825b14..19cc179be9a7 100644
> --- a/tools/perf/Documentation/itrace.txt
> +++ b/tools/perf/Documentation/itrace.txt
> @@ -25,6 +25,7 @@
>  		q	quicker (less detailed) decoding
>  		A	approximate IPC
>  		Z	prefer to ignore timestamps (so-called "timeless" decoding)
> +		T	use the timestamp trace as kernel time
>  
>  	The default is all events i.e. the same as --itrace=iybxwpe,
>  	except for perf script where it is --itrace=ce
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a0368202a746..f528c4364d23 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1638,6 +1638,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>  		case 'Z':
>  			synth_opts->timeless_decoding = true;
>  			break;
> +		case 'T':
> +			synth_opts->use_timestamp = true;
> +			break;
>  		case ' ':
>  		case ',':
>  			break;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 29eb82dff574..55702215a82d 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -99,6 +99,7 @@ enum itrace_period_type {
>   * @remote_access: whether to synthesize remote access events
>   * @mem: whether to synthesize memory events
>   * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
> + * @use_timestamp: use the timestamp trace as kernel time
>   * @vm_time_correlation: perform VM Time Correlation
>   * @vm_tm_corr_dry_run: VM Time Correlation dry-run
>   * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
> @@ -146,6 +147,7 @@ struct itrace_synth_opts {
>  	bool			remote_access;
>  	bool			mem;
>  	bool			timeless_decoding;
> +	bool			use_timestamp;
>  	bool			vm_time_correlation;
>  	bool			vm_tm_corr_dry_run;
>  	char			*vm_tm_corr_args;
> @@ -678,6 +680,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
>  "				q:			quicker (less detailed) decoding\n" \
>  "				A:			approximate IPC\n" \
>  "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
> +"				T:			use the timestamp trace as kernel time\n" \
>  "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
>  "				concatenate multiple options. Default is iybxwpe or cewp\n"
>  

