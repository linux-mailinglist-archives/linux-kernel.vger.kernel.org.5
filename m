Return-Path: <linux-kernel+bounces-10445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7982D81D477
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38332284430
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C811BFBF7;
	Sat, 23 Dec 2023 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uemhbo1J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F07FBF0;
	Sat, 23 Dec 2023 14:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678D8C433C7;
	Sat, 23 Dec 2023 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703340853;
	bh=CCUY08WIoSNK3muI170K6tB7kfEZyLKChs54gEUAiCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uemhbo1J1/FdgrBx7ZkNjSPyTPmothSmJ9sSKkcjmaXsVxw8Y0RaLp2dJIZJIc7uI
	 POy6n17lxoepqNJmYhjbXlx0JCJiR2AFW1i2BGBDxFKWi6XHfWP5m4Oso3I/z1qcfg
	 wWepBWMFpCbHAA9kG/QuWZ+6KjToTxOs69IjRI7fz2MymSj09rCkcSziQRKJjI1Q/7
	 zqB/f7scOCkmyZwpfdEiiRHqi5Yoe9PC69T3TiKXzLiLZWUX0UlLw212kETgcQy4wr
	 4hQEqbFoxlcPZQwxAV9esLFpVa3lhkMCkSux9ebZNmX+1TX70mLdhb6JeafsI1nCTu
	 7efifSAmVKpoQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 01F41403EF; Sat, 23 Dec 2023 11:14:10 -0300 (-03)
Date: Sat, 23 Dec 2023 11:14:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andi Kleen <ak@linux.intel.com>, linux-trace-devel@vger.kernel.org,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 14/52] perf annotate: Factor out evsel__get_arch()
Message-ID: <ZYbrMqdkmf2uT6Tm@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
 <20231110000012.3538610-15-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110000012.3538610-15-namhyung@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 09, 2023 at 03:59:33PM -0800, Namhyung Kim escreveu:
> The evsel__get_arch() is to get architecture info from the environ.
> It'll be used by other places later so let's factor it out.

evsel__get_arch():

  The "get" is mostly associated with refcounts, so at some point we
should rename it to some better name, not a reason to delay processing
this patch right now, so I'm applying it as is.
 
> Also add arch__is() to check the arch info by name.

cool
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 44 +++++++++++++++++++++++++++-----------
>  tools/perf/util/annotate.h |  2 ++
>  2 files changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 3364edf30f50..83e0996992af 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -804,6 +804,11 @@ static struct arch *arch__find(const char *name)
>  	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
>  }
>  
> +bool arch__is(struct arch *arch, const char *name)
> +{
> +	return !strcmp(arch->name, name);
> +}
> +
>  static struct annotated_source *annotated_source__new(void)
>  {
>  	struct annotated_source *src = zalloc(sizeof(*src));
> @@ -2340,15 +2345,8 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
>  	annotation__calc_percent(notes, evsel, symbol__size(sym));
>  }
>  
> -int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
> -		     struct annotation_options *options, struct arch **parch)
> +static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>  {
> -	struct symbol *sym = ms->sym;
> -	struct annotation *notes = symbol__annotation(sym);
> -	struct annotate_args args = {
> -		.evsel		= evsel,
> -		.options	= options,
> -	};
>  	struct perf_env *env = evsel__env(evsel);
>  	const char *arch_name = perf_env__arch(env);
>  	struct arch *arch;
> @@ -2357,23 +2355,43 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>  	if (!arch_name)
>  		return errno;
>  
> -	args.arch = arch = arch__find(arch_name);
> +	*parch = arch = arch__find(arch_name);
>  	if (arch == NULL) {
>  		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
>  		return ENOTSUP;
>  	}
>  
> -	if (parch)
> -		*parch = arch;
> -
>  	if (arch->init) {
>  		err = arch->init(arch, env ? env->cpuid : NULL);
>  		if (err) {
> -			pr_err("%s: failed to initialize %s arch priv area\n", __func__, arch->name);
> +			pr_err("%s: failed to initialize %s arch priv area\n",
> +			       __func__, arch->name);
>  			return err;
>  		}
>  	}
> +	return 0;
> +}
> +
> +int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
> +		     struct annotation_options *options, struct arch **parch)
> +{
> +	struct symbol *sym = ms->sym;
> +	struct annotation *notes = symbol__annotation(sym);
> +	struct annotate_args args = {
> +		.evsel		= evsel,
> +		.options	= options,
> +	};
> +	struct arch *arch = NULL;
> +	int err;
> +
> +	err = evsel__get_arch(evsel, &arch);
> +	if (err < 0)
> +		return err;
> +
> +	if (parch)
> +		*parch = arch;
>  
> +	args.arch = arch;
>  	args.ms = *ms;
>  	if (notes->options && notes->options->full_addr)
>  		notes->start = map__objdump_2mem(ms->map, ms->sym->start);
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index bc8b95e8b1be..e8b0173f5f00 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -59,6 +59,8 @@ struct ins_operands {
>  
>  struct arch;
>  
> +bool arch__is(struct arch *arch, const char *name);
> +
>  struct ins_ops {
>  	void (*free)(struct ins_operands *ops);
>  	int (*parse)(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms);
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 

- Arnaldo

