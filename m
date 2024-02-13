Return-Path: <linux-kernel+bounces-62918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC08527D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F254C1F23519
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637D8F65;
	Tue, 13 Feb 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S1z3oMWG"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B7A939
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795632; cv=none; b=eYwef8rdP4NqCBJ0yIXIpwmoO4mRDIHWXHFOSo3NyhNjueYDdxZQ7F+O5/Y7Nz4o9ufI0ZVU9qNzwEoLXjT545MewWYvaXngDNVNr6dRHlrW8JAvsDblAGLcXzPx7qRdyh620hqqIfmWyCMt5JXqc+RoKb+aZOEKfjC27+NXS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795632; c=relaxed/simple;
	bh=o+bnbxJt2/ISJQVFBr+Zlv2HapBYYYq1ZQj6Gv8FlKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUOZmES+qkuq2tT6YNRaYVql//Ngy/rfvkptyth/N7GP2Khzo8a1UW/c3vyu+ktrK1w/GpSQ5vwgKMtLoGlD0tpuAZ/8zl9eZZxL/JPRNNdREu35Q0zlBim0Jg/Xx4YY3cHFdGvIc3ICRcBRZC7yzR95gZoc0YLqSgimF+3GGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S1z3oMWG; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 11:39:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707795628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LzrWm/uZNgee7Q71WecGWdzqs9MQq9878fLRObFe0wU=;
	b=S1z3oMWGwkXXzGknMuLKsQvbnQEoHi1RHTzZVbpv3wnw6FyixHdnmAdwGiiE6oKbKhOwPF
	vw2RbOyLQhNPaUOfNjzsFoFtG8XHOmQMO0XseaIUDoV/BkXQgvr1YUX6gvb0pP0mCm/fr9
	JjUnrTLvQFFHoRM55+3ot7yh0Dld2ag=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] perf tools: Fixup module symbol end address properly
Message-ID: <20240213033954.GB81405@debian-dev>
References: <20240212233322.1855161-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212233322.1855161-1-namhyung@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 12, 2024 at 03:33:22PM -0800, Namhyung Kim wrote:
> I got a strange error on ARM to fail on processing FINISHED_ROUND
> record.  It turned out that it was failing in symbol__alloc_hist()
> because the symbol size is too big.
> 
> When a sample is captured on a specific BPF program, it failed.  I've
> added a debug code and found the end address of the symbol is from
> the next module which is placed far way.
> 
>   ffff800008795778-ffff80000879d6d8: bpf_prog_1bac53b8aac4bc58_netcg_sock    [bpf]
>   ffff80000879d6d8-ffff80000ad656b4: bpf_prog_76867454b5944e15_netcg_getsockopt      [bpf]
>   ffff80000ad656b4-ffffd69b7af74048: bpf_prog_1d50286d2eb1be85_hn_egress     [bpf]   <---------- here
>   ffffd69b7af74048-ffffd69b7af74048: $x.5    [sha3_generic]
>   ffffd69b7af74048-ffffd69b7af740b8: crypto_sha3_init        [sha3_generic]
>   ffffd69b7af740b8-ffffd69b7af741e0: crypto_sha3_update      [sha3_generic]
> 
> The logic in symbols__fixup_end() just uses curr->start to update the
> prev->end.  But in this case, it won't work as it's too different.
> 
> I think ARM has a different kernel memory layout for modules and BPF
> than on x86.  Actually there's a logic to handle kernel and module
> boundary.  Let's do the same for symbols between different modules.

Even Arm32 and Arm64 kernel have different memory layout for modules
and kernel image.

eBPF program (JITed) should be allocated from the vmalloc region, for
Arm64, see bpf_jit_alloc_exec() in arch/arm64/net/bpf_jit_comp.c.

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/symbol.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 35975189999b..9ebdb8e13c0b 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -248,14 +248,31 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
>  		 * segment is very big.  Therefore do not fill this gap and do
>  		 * not assign it to the kernel dso map (kallsyms).
>  		 *
> +		 * Also BPF code can be allocated separately from text segments
> +		 * and modules.  So the last entry in a module should not fill
> +		 * the gap too.
> +		 *
>  		 * In kallsyms, it determines module symbols using '[' character
>  		 * like in:
>  		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
>  		 */
>  		if (prev->end == prev->start) {
> +			const char *prev_mod;
> +			const char *curr_mod;
> +
> +			if (!is_kallsyms) {
> +				prev->end = curr->start;
> +				continue;
> +			}
> +
> +			prev_mod = strchr(prev->name, '[');
> +			curr_mod = strchr(curr->name, '[');
> +
>  			/* Last kernel/module symbol mapped to end of page */
> -			if (is_kallsyms && (!strchr(prev->name, '[') !=
> -					    !strchr(curr->name, '[')))
> +			if (!prev_mod != !curr_mod)
> +				prev->end = roundup(prev->end + 4096, 4096);
> +			/* Last symbol in the previous module */
> +			else if (prev_mod && strcmp(prev_mod, curr_mod))

Should two consecutive moudles fall into this case? I think we need to assign
'prev->end = curr->start' for two two consecutive moudles.

If so, we should use a specific checking for eBPF program, e.g.:

                        else if (prev_mod && strcmp(prev_mod, curr_mod) &&
                                 (!strcmp(prev->name, "bpf") ||
                                  !strcmp(curr->name, "bpf")))

Thanks,
Leo

>  				prev->end = roundup(prev->end + 4096, 4096);
>  			else
>  				prev->end = curr->start;
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

