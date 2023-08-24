Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E66786FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjHXM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjHXM4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:56:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07606CD0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692881791; x=1724417791;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WchCVHcquPopaM2xXvJm7NMGY+0W0sobFwO3R856VXM=;
  b=fSw/gjfPBp1dVvfpn5wQlJsdINebm8gV73FwooDtGcbH7dUay4TBl6LL
   FpSZsbOtWzJ9uDVq3BvoWb3O3kXh7vxfyoId1qQXADtw5lNsvJ8+pvruw
   bpFwi4Nx9mnyg1Of1cZbRi4R90q6rYlN1s6RebiAbZnejJpdquzDPMgjK
   eumbOKDtgflK1LZWXkUSSgKGlRDc7H7CoMLCp6nLW7PlGZFlMlCihRo3S
   bCkqudkwVXC/iklzitTSPxC58y8+ST/3CiTv5d7YBfoFmu0lXlaUjzJCG
   M/3n1gG4zsaqpM5eWG8wGh9B1NVT2rjMTrFJXPM0cuq6CPgMrGWn4OmDj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364603797"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364603797"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="983689896"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="983689896"
Received: from abedekar-mobl1.ger.corp.intel.com ([10.251.213.29])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:56:28 -0700
Date:   Thu, 24 Aug 2023 15:56:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        fenghua.yu@intel.com
Subject: Re: [PATCH 2/3] selftests/resctrl: Move run_benchmark() to a more
 fitting file
In-Reply-To: <69a1ed7c06c3c34a2e39b50ffcceb9774967203a.1692880423.git.maciej.wieczor-retman@intel.com>
Message-ID: <3978b8f7-1d80-d7-926a-72b2cfd923bd@linux.intel.com>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com> <69a1ed7c06c3c34a2e39b50ffcceb9774967203a.1692880423.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:

Thanks for this patch, the new location is much more appropriate and 
logical (more than once I've tried to look for this from the wrong file).

> Resctrlfs.c file contains mostly functions that interact in some way
> with resctrl FS entries while functions inside resctrl_val.c deal with
> measurements and benchmarking
> 
> Run_benchmark() function is located in resctrlfs.c file even though it's
> purpose is not interacting with the resctrl FS but to execute cache
> checking logic
> 
> Move run_benchmark() to resctrl_val.c just before resctrl_val() function
> that makes use of run_benchmark()

Please terminate your sentences in changelog with . like in normal 
writing.

> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl_val.c | 52 +++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
>  2 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index f0f6c5f6e98b..667542c084eb 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -621,6 +621,58 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
>  	return 0;
>  }
>  
> +/*
> + * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
> + *		   in specified signal. Direct benchmark stdio to /dev/null.
> + * @signum:	signal number
> + * @info:	signal info
> + * @ucontext:	user context in signal handling
> + *
> + * Return: void

This Return: void feels waste of screen space as if it wouldn't be 
obvious from the function signature.

> + */
> +void run_benchmark(int signum, siginfo_t *info, void *ucontext)
> +{
> +	int operation, ret, memflush;
> +	char **benchmark_cmd;
> +	size_t span;
> +	bool once;
> +	FILE *fp;
> +
> +	benchmark_cmd = info->si_ptr;
> +
> +	/*
> +	 * Direct stdio of child to /dev/null, so that only parent writes to
> +	 * stdio (console)
> +	 */
> +	fp = freopen("/dev/null", "w", stdout);
> +	if (!fp)
> +		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
> +
> +	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> +		/* Execute default fill_buf benchmark */
> +		span = strtoul(benchmark_cmd[1], NULL, 10);
> +		memflush =  atoi(benchmark_cmd[2]);
> +		operation = atoi(benchmark_cmd[3]);
> +		if (!strcmp(benchmark_cmd[4], "true"))
> +			once = true;
> +		else if (!strcmp(benchmark_cmd[4], "false"))
> +			once = false;
> +		else
> +			PARENT_EXIT("Invalid once parameter");
> +
> +		if (run_fill_buf(span, memflush, operation, once))
> +			fprintf(stderr, "Error in running fill buffer\n");
> +	} else {
> +		/* Execute specified benchmark */
> +		ret = execvp(benchmark_cmd[0], benchmark_cmd);
> +		if (ret)
> +			perror("wrong\n");
> +	}
> +
> +	fclose(stdout);
> +	PARENT_EXIT("Unable to run specified benchmark");
> +}
> +
>  /*
>   * resctrl_val:	execute benchmark and measure memory bandwidth on
>   *			the benchmark
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index a6d0b632cbc6..e3c94614c086 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -291,58 +291,6 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
>  	return 0;
>  }
>  
> -/*
> - * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
> - *		   in specified signal. Direct benchmark stdio to /dev/null.
> - * @signum:	signal number
> - * @info:	signal info
> - * @ucontext:	user context in signal handling
> - *
> - * Return: void
> - */
> -void run_benchmark(int signum, siginfo_t *info, void *ucontext)
> -{
> -	int operation, ret, memflush;
> -	char **benchmark_cmd;
> -	size_t span;
> -	bool once;
> -	FILE *fp;
> -
> -	benchmark_cmd = info->si_ptr;
> -
> -	/*
> -	 * Direct stdio of child to /dev/null, so that only parent writes to
> -	 * stdio (console)
> -	 */
> -	fp = freopen("/dev/null", "w", stdout);
> -	if (!fp)
> -		PARENT_EXIT("Unable to direct benchmark status to /dev/null");
> -
> -	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
> -		/* Execute default fill_buf benchmark */
> -		span = strtoul(benchmark_cmd[1], NULL, 10);
> -		memflush =  atoi(benchmark_cmd[2]);
> -		operation = atoi(benchmark_cmd[3]);
> -		if (!strcmp(benchmark_cmd[4], "true"))
> -			once = true;
> -		else if (!strcmp(benchmark_cmd[4], "false"))
> -			once = false;
> -		else
> -			PARENT_EXIT("Invalid once parameter");
> -
> -		if (run_fill_buf(span, memflush, operation, once))
> -			fprintf(stderr, "Error in running fill buffer\n");
> -	} else {
> -		/* Execute specified benchmark */
> -		ret = execvp(benchmark_cmd[0], benchmark_cmd);
> -		if (ret)
> -			perror("wrong\n");
> -	}
> -
> -	fclose(stdout);
> -	PARENT_EXIT("Unable to run specified benchmark");
> -}
> -
>  /*
>   * create_grp - Create a group only if one doesn't exist
>   * @grp_name:	Name of the group
> 

-- 
 i.

