Return-Path: <linux-kernel+bounces-41369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D8483EFBB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA31F23746
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8412E62B;
	Sat, 27 Jan 2024 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9E0yrrt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2582E62A;
	Sat, 27 Jan 2024 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383689; cv=none; b=Z9g6vWRLXWaXjzrFtAuCZHzKP6Su6e++/AxW4RlQ2hMF054v3s0MInKl/LWqjjMhaCSHMuX+kKpjuPUNkP5kShC9oiY4UTD/uPKMSgMlsa9B4NvMBb9e2UWxfCXEOx1JJN/xeD5joq4v53PPv1acUlhOVfWY9zS1y8kmWLvi4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383689; c=relaxed/simple;
	bh=YMYC8xwt8ah1USUk80LJ7Mt2nKL7aHi1219QW6IDjng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0MhZ5kGV/MPLZvztniv0tZsTzAHidhVka8ezAWq9UHSWkZBONB2TSCPSRpkdh2xgfoNu8KYw1nFYxebLXIUNCgKwqe6u+jl2+RGpqjvzN0InkNMLWjITWshhVnDxaPEUXW9AK08Jlp7NAkHwqGB3Lf7MV1AzcAC/V0hBFyc77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9E0yrrt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104E7C433F1;
	Sat, 27 Jan 2024 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706383689;
	bh=YMYC8xwt8ah1USUk80LJ7Mt2nKL7aHi1219QW6IDjng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9E0yrrtTGewSobcxMxtcNm7YC2CWC/gCv1fmW3G4AEbRdGwPq8MOW9jjaWrrFkmU
	 H1hoTmaxwPGzvccZJQ2+cBsZr8k8fo0R0dgZ+Q67V+uZJE1hTmk+76vkr2PGnvmvgM
	 DNpIM8J23VSvQ8JnQgxb1FKROWxjH2HaJ7wY/ZmGFXCIasvsVMe4jAkjLCWXmpG9ef
	 dy0k8rBYTllg5MjvyVPJYwNrhcOLpNgjkJEO+jrbOItU6pizkOkas3NlRpKqAqkaIj
	 PwjfT0+19xX9GJSGkmFeyAEH1xA214KR5ZXX1kfs/zg2BRntbX5KUfHikWb5J36q83
	 DYkwVgFnqKmxA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BC43A40441; Sat, 27 Jan 2024 16:28:06 -0300 (-03)
Date: Sat, 27 Jan 2024 16:28:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Fix duplicate initialization of data->id in
 evsel__parse_sample()
Message-ID: <ZbVZRrPp9YusOHzB@kernel.org>
References: <20240127025756.4041808-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127025756.4041808-1-yangjihong1@huawei.com>
X-Url: http://acmel.wordpress.com

Em Sat, Jan 27, 2024 at 02:57:56AM +0000, Yang Jihong escreveu:
> data->id has been initialized at line 2362, remove duplicate initialization.
> 
> Fixes: 3ad31d8a0df2 ("perf evsel: Centralize perf_sample initialization")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> ---
>  tools/perf/util/evsel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 4d14f14f2506..a0f36a6b8a2d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2363,7 +2363,6 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	data->period = evsel->core.attr.sample_period;
>  	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>  	data->misc    = event->header.misc;
> -	data->id = -1ULL;
>  	data->data_src = PERF_MEM_DATA_SRC_NONE;
>  	data->vcpu = -1;
>  
> -- 
> 2.34.1
> 

-- 

- Arnaldo

