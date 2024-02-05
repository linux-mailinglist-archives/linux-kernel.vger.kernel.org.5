Return-Path: <linux-kernel+bounces-53277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFC084A301
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDAE1C24870
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E64EB55;
	Mon,  5 Feb 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXteL2r3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD484E1D1;
	Mon,  5 Feb 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159705; cv=none; b=Brjkxio5ZmJph/EIRAy+q91LD7obe6EVYWKFSMZkhSmK8Wt+1oOwtURoI4m17kVcpWkYp0/B49z/D2zHrjQAtLbmfyGhmLsk4B0hzcfgrItfSU8GHcYsshTHPtUeHoW1DZV0PLD6huJX8XbXszsvWeLW788OSbvirFygbHqcxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159705; c=relaxed/simple;
	bh=qD9zp37TlJaB9gD6Uqgvcewd1tv1LpYiBSx2wrUucoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyopDdJMkn2x15LQNnXk23huYSqVbgGX/ABYwuRyHxspUIHaPiVoK8KD9nJ0VcH4AL6d4ysP/JZg5yFC1sh/o+rGTbyYXm+yWDOh1jwzNr/RXLY2aYvnYFV/4DI2603cXL+sY129xiLWSHjv3D6SPFhWilG8K2aS5fmbmnYgAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXteL2r3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F26C43601;
	Mon,  5 Feb 2024 19:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159705;
	bh=qD9zp37TlJaB9gD6Uqgvcewd1tv1LpYiBSx2wrUucoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXteL2r3dcthFeAGBE999GG/d4Bf7wjliuH2UGu3tEjax6Xih3i9oDe9b8J6e0Ub9
	 5haFVQ2XEprqX6F8Ugh19+iV3RZTFIwZgRQ6hnZ/cXBgAx5V0eK64XSoFoOMZ0TqmC
	 2QpUwunSYhYURaEx4j8eCXrNswE6KmO0gS4CxhIt8IDbdl3RVYv1Jja0/CNMiu7DKS
	 j5uiDYoUUZH6QoNUGy5+z7Hu3WP/rb0RpXkicaq3dzyK3Lg+6wTzEFRgrAr4f4zY+K
	 T7+jrU7silz10yg1HCBI8BQZ75ixj6jovuWF6VE+DlWol69Z0+/VpLjWGCbaz9CzM+
	 GFlKivzoRSL5g==
Date: Mon, 5 Feb 2024 16:01:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf sched: Move curr_pid and cpu_last_switched
 initialization to perf_sched__{lat|map|replay}()
Message-ID: <ZcEwlR9itdN6tIL1@x1>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
 <20240205104616.132417-5-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205104616.132417-5-yangjihong1@huawei.com>

On Mon, Feb 05, 2024 at 10:46:15AM +0000, Yang Jihong wrote:
> +static int setup_cpus_switch_event(struct perf_sched *sched)
> +{
> +	unsigned int i;
> +
> +	sched->cpu_last_switched = calloc(MAX_CPUS, sizeof(*(sched->cpu_last_switched)));
> +	if (!sched->cpu_last_switched)
> +		return -1;
> +
> +	sched->curr_pid = malloc(MAX_CPUS * sizeof(*(sched->curr_pid)));
> +	if (!sched->curr_pid) {
> +		free(sched->cpu_last_switched);

		zfree(&sched->cpu_last_switched);

> +		return -1;
> +	}
> +
> +	for (i = 0; i < MAX_CPUS; i++)
> +		sched->curr_pid[i] = -1;
> +
> +	return 0;
> +}
> +
> +static void free_cpus_switch_event(struct perf_sched *sched)
> +{
> +	free(sched->curr_pid);
> +	free(sched->cpu_last_switched);

	zfree(&sched->curr_pid);
	zfree(&sched->cpu_last_switched);

> +}
> +
>  static int perf_sched__lat(struct perf_sched *sched)
>  {
> +	int rc = -1;
>  	struct rb_node *next;
>  
>  	setup_pager();
>  
> +	if (setup_cpus_switch_event(sched))
> +		return rc;
> +
>  	if (perf_sched__read_events(sched))
> -		return -1;
> +		goto out_free_cpus_switch_event;
>  
>  	perf_sched__merge_lat(sched);
>  	perf_sched__sort_lat(sched);
> @@ -3203,7 +3233,11 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	print_bad_events(sched);
>  	printf("\n");
>  
> -	return 0;
> +	rc = 0;
> +
> +out_free_cpus_switch_event:
> +	free_cpus_switch_event(sched);
> +	return rc;
>  }
>  
>  static int setup_map_cpus(struct perf_sched *sched)
> @@ -3270,9 +3304,12 @@ static int perf_sched__map(struct perf_sched *sched)
>  	if (!sched->curr_thread)
>  		return rc;
>  
> -	if (setup_map_cpus(sched))
> +	if (setup_cpus_switch_event(sched))
>  		goto out_free_curr_thread;
>  
> +	if (setup_map_cpus(sched))
> +		goto out_free_cpus_switch_event;
> +
>  	if (setup_color_pids(sched))
>  		goto out_free_map_cpus;
>  
> @@ -3296,6 +3333,9 @@ static int perf_sched__map(struct perf_sched *sched)
>  	free(sched->map.comp_cpus);
>  	perf_cpu_map__put(sched->map.cpus);
>  
> +out_free_cpus_switch_event:
> +	free_cpus_switch_event(sched);
> +
>  out_free_curr_thread:
>  	free(sched->curr_thread);
>  	return rc;
> @@ -3309,6 +3349,10 @@ static int perf_sched__replay(struct perf_sched *sched)
>  	mutex_init(&sched->start_work_mutex);
>  	mutex_init(&sched->work_done_wait_mutex);
>  
> +	ret = setup_cpus_switch_event(sched);
> +	if (ret)
> +		goto out_mutex_destroy;
> +
>  	calibrate_run_measurement_overhead(sched);
>  	calibrate_sleep_measurement_overhead(sched);
>  
> @@ -3316,7 +3360,7 @@ static int perf_sched__replay(struct perf_sched *sched)
>  
>  	ret = perf_sched__read_events(sched);
>  	if (ret)
> -		goto out_mutex_destroy;
> +		goto out_free_cpus_switch_event;
>  
>  	printf("nr_run_events:        %ld\n", sched->nr_run_events);
>  	printf("nr_sleep_events:      %ld\n", sched->nr_sleep_events);
> @@ -3342,6 +3386,9 @@ static int perf_sched__replay(struct perf_sched *sched)
>  	sched->thread_funcs_exit = true;
>  	destroy_tasks(sched);
>  
> +out_free_cpus_switch_event:
> +	free_cpus_switch_event(sched);
> +
>  out_mutex_destroy:
>  	mutex_destroy(&sched->start_work_mutex);
>  	mutex_destroy(&sched->work_done_wait_mutex);
> @@ -3580,21 +3627,7 @@ int cmd_sched(int argc, const char **argv)
>  		.switch_event	    = replay_switch_event,
>  		.fork_event	    = replay_fork_event,
>  	};
> -	unsigned int i;
> -	int ret = 0;
> -
> -	sched.cpu_last_switched = calloc(MAX_CPUS, sizeof(*sched.cpu_last_switched));
> -	if (!sched.cpu_last_switched) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -	sched.curr_pid = malloc(MAX_CPUS * sizeof(*sched.curr_pid));
> -	if (!sched.curr_pid) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -	for (i = 0; i < MAX_CPUS; i++)
> -		sched.curr_pid[i] = -1;
> +	int ret;
>  
>  	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
>  					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> @@ -3605,9 +3638,9 @@ int cmd_sched(int argc, const char **argv)
>  	 * Aliased to 'perf script' for now:
>  	 */
>  	if (!strcmp(argv[0], "script")) {
> -		ret = cmd_script(argc, argv);
> +		return cmd_script(argc, argv);
>  	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
> -		ret = __cmd_record(argc, argv);
> +		return __cmd_record(argc, argv);
>  	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
>  		sched.tp_handler = &lat_ops;
>  		if (argc > 1) {
> @@ -3616,7 +3649,7 @@ int cmd_sched(int argc, const char **argv)
>  				usage_with_options(latency_usage, latency_options);
>  		}
>  		setup_sorting(&sched, latency_options, latency_usage);
> -		ret = perf_sched__lat(&sched);
> +		return perf_sched__lat(&sched);
>  	} else if (!strcmp(argv[0], "map")) {
>  		if (argc) {
>  			argc = parse_options(argc, argv, map_options, map_usage, 0);
> @@ -3625,7 +3658,7 @@ int cmd_sched(int argc, const char **argv)
>  		}
>  		sched.tp_handler = &map_ops;
>  		setup_sorting(&sched, latency_options, latency_usage);
> -		ret = perf_sched__map(&sched);
> +		return perf_sched__map(&sched);
>  	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
>  		sched.tp_handler = &replay_ops;
>  		if (argc) {
> @@ -3633,7 +3666,7 @@ int cmd_sched(int argc, const char **argv)
>  			if (argc)
>  				usage_with_options(replay_usage, replay_options);
>  		}
> -		ret = perf_sched__replay(&sched);
> +		return perf_sched__replay(&sched);
>  	} else if (!strcmp(argv[0], "timehist")) {
>  		if (argc) {
>  			argc = parse_options(argc, argv, timehist_options,
> @@ -3649,21 +3682,16 @@ int cmd_sched(int argc, const char **argv)
>  				parse_options_usage(NULL, timehist_options, "w", true);
>  			if (sched.show_next)
>  				parse_options_usage(NULL, timehist_options, "n", true);
> -			ret = -EINVAL;
> -			goto out;
> +			return -EINVAL;
>  		}
>  		ret = symbol__validate_sym_arguments();
>  		if (ret)
> -			goto out;
> +			return ret;
>  
> -		ret = perf_sched__timehist(&sched);
> +		return perf_sched__timehist(&sched);
>  	} else {
>  		usage_with_options(sched_usage, sched_options);
>  	}
>  
> -out:
> -	free(sched.curr_pid);
> -	free(sched.cpu_last_switched);
> -
> -	return ret;
> +	return 0;
>  }
> -- 
> 2.34.1

