Return-Path: <linux-kernel+bounces-4358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC747817BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BC9B221EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261C42361;
	Mon, 18 Dec 2023 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAqGpUqb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857B740AB;
	Mon, 18 Dec 2023 20:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B30C433C8;
	Mon, 18 Dec 2023 20:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702931508;
	bh=3faOPrO+Vz+rLFKkSkQXxX3AWNfnSd028J3inec7y3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAqGpUqb7QgG5ESz3XiaFW/dVAMzThIcUFlj3cgxOhsZysXhOBRRuamyG3jFCiM+e
	 XmxE2WkHC6FjXyx8yBo6UlqPsVp9A6R9RTeQfCZyDrXRgg69G3V27xQcE8KWX8zxrm
	 aaE1xLarIJ1ndE2elglGlunkzOQtUXd4F/Ul+aDqzY5TJfyomSzdNOJEOgyQ5ulZ2v
	 wVoF+7XFiUulmwRnG1APVB45iFq3Tp2cc6SuAs4zXX/LQ0gs7pBYACGl8yrlbvkZDn
	 2N4qBxvC3vbU3r3Vft7YZ+Dh81eIxPxrFXhlQl3YWsvWnJEDPjrPSpPsbMnMoer2Dx
	 iw4Vx3uTYR7nA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 23E18403EF; Mon, 18 Dec 2023 17:31:46 -0300 (-03)
Date: Mon, 18 Dec 2023 17:31:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Make DSO tests a suite rather than
 individual
Message-ID: <ZYCsMpYtmsQr1_Ed@kernel.org>
References: <20231128194624.1419260-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128194624.1419260-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 28, 2023 at 11:46:24AM -0800, Ian Rogers escreveu:
> Make the DSO data tests a suite rather than individual so their output
> is grouped.

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c |  2 --
>  tools/perf/tests/dso-data.c     | 15 ++++++++++++---
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 113e92119e1d..9c09e4681c3a 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -62,8 +62,6 @@ static struct test_suite *generic_tests[] = {
>  	&suite__pmu,
>  	&suite__pmu_events,
>  	&suite__dso_data,
> -	&suite__dso_data_cache,
> -	&suite__dso_data_reopen,
>  	&suite__perf_evsel__roundtrip_name_test,
>  #ifdef HAVE_LIBTRACEEVENT
>  	&suite__perf_evsel__tp_sched_test,
> diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
> index deaefcdd8f09..5286ae8bd2d7 100644
> --- a/tools/perf/tests/dso-data.c
> +++ b/tools/perf/tests/dso-data.c
> @@ -393,6 +393,15 @@ static int test__dso_data_reopen(struct test_suite *test __maybe_unused, int sub
>  	return 0;
>  }
>  
> -DEFINE_SUITE("DSO data read", dso_data);
> -DEFINE_SUITE("DSO data cache", dso_data_cache);
> -DEFINE_SUITE("DSO data reopen", dso_data_reopen);
> +
> +static struct test_case tests__dso_data[] = {
> +	TEST_CASE("read", dso_data),
> +	TEST_CASE("cache", dso_data_cache),
> +	TEST_CASE("reopen", dso_data_reopen),
> +	{	.name = NULL, }
> +};
> +
> +struct test_suite suite__dso_data = {
> +	.desc = "DSO data tests",
> +	.test_cases = tests__dso_data,
> +};
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

-- 

- Arnaldo

