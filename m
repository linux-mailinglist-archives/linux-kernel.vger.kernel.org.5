Return-Path: <linux-kernel+bounces-53264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C484A2DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70143287A18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12460482DC;
	Mon,  5 Feb 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiL6U2P8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDC482C7;
	Mon,  5 Feb 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159529; cv=none; b=quZOKBDo7pro3QK5jU5aR6Qssp2uQBh4IHFup5H/dSlMHCkfWH37O5URmO17hi19JSFH3eI7DMc1u08NYoIZy2N2A90kq47wi8jHVLvZl7Z47/y2qrbLGmXDAThqqxhEE89gZEeTTIyJ6JLPIPGoQT+3dG5twCFXmNKFgQ277so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159529; c=relaxed/simple;
	bh=WfCVbiVD64UcCoqFBq0h3S0MaSSkABL+RCJVRJ0X68Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5avwIJ/3n7oOwmQazrTVfBVZbxyPnvdXdxUmTb50TRT7BsxCiMH23qB3GzXPRKfTB4255XecJtGd5CfFd80t/2bIG35/ehwd0ldFuNaF5Pn6xV3qWSgtQHi+vvbHiAqn7+Q4qquwDzPdk01uWddeJzUKq/Tl5r0Ayq+sk7fpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiL6U2P8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB597C433C7;
	Mon,  5 Feb 2024 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159528;
	bh=WfCVbiVD64UcCoqFBq0h3S0MaSSkABL+RCJVRJ0X68Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FiL6U2P8U2aB1r0t4SsxEk993K9gMguLFZrxzuLYwVy3zBOF5s0gwV6kcIt/pR+FG
	 NSv51Yvf8K7xJgmxUj7qCn13dWnhfdlJY7IhLQkow1dj2800jWJfFmykmIsoit+Spm
	 3p65YKE1Y0e/PP/Pcc41/kDtqWFmz7t3zWPn3pfDdbRwP8Eef2P/GhMdLlPtc2yv3a
	 LgugLEbI+jSrphpHSFW59U/YpPxB7kHZwFwEyKu9dS7M5G+kgRNzjW+RhFdjd2M1ss
	 bf8BPMgtUjZW+W5AOMF+rhRvCzOkGCfLvOKnNd3jqx+HcPEgbwjLkyuM5nvm558u4t
	 L8Ou+VqOxJoYA==
Date: Mon, 5 Feb 2024 15:58:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] perf sched: Fix memory leak in perf_sched__map()
Message-ID: <ZcEv5BBvNEye4ZYf@x1>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
 <20240205104616.132417-3-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205104616.132417-3-yangjihong1@huawei.com>

On Mon, Feb 05, 2024 at 10:46:13AM +0000, Yang Jihong wrote:
> +++ b/tools/perf/builtin-sched.c
> @@ -3267,20 +3264,34 @@ static int setup_color_cpus(struct perf_sched *sched)
>  
>  static int perf_sched__map(struct perf_sched *sched)
>  {
> +	int rc = -1;
> +
>  	if (setup_map_cpus(sched))
> -		return -1;
> +		return rc;
>  
>  	if (setup_color_pids(sched))
> -		return -1;
> +		goto out_free_map_cpus;

I think renaming the goto labels to what they will do, dropping a
refcount, is more clear, i.e.:

		goto out_put_map_cpus;

>  
>  	if (setup_color_cpus(sched))
> -		return -1;
> +		goto out_free_color_pids;
>  
>  	setup_pager();
>  	if (perf_sched__read_events(sched))
> -		return -1;
> +		goto out_free_color_cpus;
> +
> +	rc = 0;
>  	print_bad_events(sched);
> -	return 0;
> +
> +out_free_color_cpus:
> +	perf_cpu_map__put(sched->map.color_cpus);
> +
> +out_free_color_pids:
> +	perf_thread_map__put(sched->map.color_pids);
> +
> +out_free_map_cpus:
> +	free(sched->map.comp_cpus);

Please use:

	zfree(&sched->map.comp_cpus);

> +	perf_cpu_map__put(sched->map.cpus);
> +	return rc;
>  }

