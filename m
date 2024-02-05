Return-Path: <linux-kernel+bounces-53270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7907884A2EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3587F28B73C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB37148786;
	Mon,  5 Feb 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh2Pe9fY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64982E3FD;
	Mon,  5 Feb 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159598; cv=none; b=OSKFGDUiGs7ixZ/J3wV23XGoSDFSILoEMK2Rs6wm2WEL+n7L6FbbxBpkTiMtbfUOLy9KrxX+7fE1UeAjw4iJnzgS/HudtK1McV/dPrBKg7ccHtbDz1mwiYeEfGItbh29ia2/zLfHZX6TepU5FAUPjAU6tc0v0K+nV0mXve9HzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159598; c=relaxed/simple;
	bh=24FU41oSYj4xFt0JsE0eIhXDNfjo9usWgVMXWyc9vzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV3BITW+RDFuEpgovbsDiqeCheSRiSV0dLzLqBa+0PG4JV0Z9u/XKhaGJpWgC/Ntj0k6ZCnISrkBp4np+1FOE8V2a/fKyfHhFsAqfv1kH5rZpkJDN6SSjlv6Owdd38a7dd6i9Sk4ATYi6s1xpYrNH2EbN3LtwWCEZccEwzAyS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh2Pe9fY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A85C43390;
	Mon,  5 Feb 2024 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159597;
	bh=24FU41oSYj4xFt0JsE0eIhXDNfjo9usWgVMXWyc9vzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mh2Pe9fYchh9i5SGvsYyXPPRAGJdbb4COKD/CZDghDcgfj60stOk+7wnZofU2Hnh2
	 aqXTgp/+sH3/SUSGMAPSQfWj/8trfZ0CUlc+AX0KPKRJUabYkMbq222DuhotCdfled
	 uybJhGMlsL+5mhIcYJ5d8tQ7xcpQJKinoh4GV4T6vhS5DdN8wUIggXj8aGMdihPzI5
	 ZXhulqsd9K/EwXPS5HILLqWiGycF/I8+fVuTpRxQ8WmOLsnaMbFJ0lzU3oNUKf9zVa
	 MRNcxOgb51R1LExf+lTNgquBQhWyF7kJMor4vDKmHH5F/wRp63x2zybhbBYSL/Ihpy
	 aEOj3hwk0t19Q==
Date: Mon, 5 Feb 2024 15:59:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] perf sched: Move curr_thread initialization to
 perf_sched__map()
Message-ID: <ZcEwKf8Jmd6yciWa@x1>
References: <20240205104616.132417-1-yangjihong1@huawei.com>
 <20240205104616.132417-4-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205104616.132417-4-yangjihong1@huawei.com>

On Mon, Feb 05, 2024 at 10:46:14AM +0000, Yang Jihong wrote:
> The curr_thread is used only for the 'perf sched map'. Put initialization
> in perf_sched__map() to reduce unnecessary actions in other commands.
> 
> Simple functional testing:
> 
>   # perf sched record perf bench sched messaging
>   # Running 'sched/messaging' benchmark:
>   # 20 sender and receiver processes per group
>   # 10 groups == 400 processes run
> 
>        Total time: 0.197 [sec]
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 15.526 MB perf.data (140095 samples) ]
> 
>   # perf sched map
>     *A0                                                               451264.532445 secs A0 => migration/0:15
>     *.                                                                451264.532468 secs .  => swapper:0
>      .  *B0                                                           451264.532537 secs B0 => migration/1:21
>      .  *.                                                            451264.532560 secs
>      .   .  *C0                                                       451264.532644 secs C0 => migration/2:27
>      .   .  *.                                                        451264.532668 secs
>      .   .   .  *D0                                                   451264.532753 secs D0 => migration/3:33
>      .   .   .  *.                                                    451264.532778 secs
>      .   .   .   .  *E0                                               451264.532861 secs E0 => migration/4:39
>      .   .   .   .  *.                                                451264.532886 secs
>      .   .   .   .   .  *F0                                           451264.532973 secs F0 => migration/5:45
>   <SNIP>
>      A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .   .   .   .    451264.790785 secs
>      A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .   .   .    451264.790858 secs
>      A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .   .    451264.790934 secs
>      A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .   .    451264.791004 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .   .    451264.791075 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .   .    451264.791143 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .   .    451264.791232 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .   .    451264.791336 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .   .    451264.791407 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7  .    451264.791484 secs
>      A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7  A7 *A7   451264.791553 secs
>   # echo $?
>   0
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-sched.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 26dbfa4aab61..54d79e560617 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3266,9 +3266,13 @@ static int perf_sched__map(struct perf_sched *sched)
>  {
>  	int rc = -1;
>  
> -	if (setup_map_cpus(sched))
> +	sched->curr_thread = calloc(MAX_CPUS, sizeof(*(sched->curr_thread)));
> +	if (!sched->curr_thread)
>  		return rc;
>  
> +	if (setup_map_cpus(sched))
> +		goto out_free_curr_thread;
> +
>  	if (setup_color_pids(sched))
>  		goto out_free_map_cpus;
>  
> @@ -3291,6 +3295,9 @@ static int perf_sched__map(struct perf_sched *sched)
>  out_free_map_cpus:
>  	free(sched->map.comp_cpus);
>  	perf_cpu_map__put(sched->map.cpus);
> +
> +out_free_curr_thread:
> +	free(sched->curr_thread);

	zfree(&sched->curr_thread);

>  	return rc;
>  }
>  
> @@ -3576,11 +3583,6 @@ int cmd_sched(int argc, const char **argv)
>  	unsigned int i;
>  	int ret = 0;
>  
> -	sched.curr_thread = calloc(MAX_CPUS, sizeof(*sched.curr_thread));
> -	if (!sched.curr_thread) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
>  	sched.cpu_last_switched = calloc(MAX_CPUS, sizeof(*sched.cpu_last_switched));
>  	if (!sched.cpu_last_switched) {
>  		ret = -ENOMEM;
> @@ -3662,7 +3664,6 @@ int cmd_sched(int argc, const char **argv)
>  out:
>  	free(sched.curr_pid);
>  	free(sched.cpu_last_switched);
> -	free(sched.curr_thread);
>  
>  	return ret;
>  }
> -- 
> 2.34.1

