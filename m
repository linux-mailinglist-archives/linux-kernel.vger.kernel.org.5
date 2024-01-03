Return-Path: <linux-kernel+bounces-15763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2E823171
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D7B1C23830
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A551BDE7;
	Wed,  3 Jan 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODiwPOZ0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117B1BDC3;
	Wed,  3 Jan 2024 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D987DC433C8;
	Wed,  3 Jan 2024 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704300341;
	bh=M8pBSNIiUdoYN2rEiciHsGiO/2XHvrJs3DnNI6IvZDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODiwPOZ08n19KjW2aZVnjQInr3/wNnvBJAnE1xDPYagSDgM9Ntc5FQSFDbG9/0zUb
	 qclbRs1sjQH7YSCgvdqabyx8UrBv3cCIFzFekBcWAubfAyUHF8RMTUIsccPh61UHzv
	 5iDfnHL4bwnYteEAiW/hjq4APbyDlYBWueHJs38tQSfhLDbix5r8z8kRgMSnqQHMna
	 ngO79mG/jOTga+ME3torw2g/dDGbbk5mZUm69cUjWpJhQtwB/XakDvUkCsTLMr10xH
	 4jtEPi+tnfuRwin2v3ApzhMQDFQbFTBBok8cIObh2c30BtfKt1JhrpdEHWu6RiB3Tb
	 5tspqKtLHJvaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 89D9F403EF; Wed,  3 Jan 2024 13:45:38 -0300 (-03)
Date: Wed, 3 Jan 2024 13:45:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf record: Reduce memory for recording lost samples
 event
Message-ID: <ZZWPMsSm3JwAu7_R@kernel.org>
References: <20231207021627.1322884-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207021627.1322884-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Wed, Dec 06, 2023 at 06:16:27PM -0800, Ian Rogers escreveu:
> Reduce from PERF_SAMPLE_MAX_SIZE to "sizeof(*lost) +
> session->machines.host.id_hdr_size".
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>


Thanks, applied to perf-tools-next.

- Arnaldo


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Suggested in:
> https://lore.kernel.org/lkml/CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com/
> ---
>  tools/perf/builtin-record.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index eb5a398ddb1d..206110fc2799 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1954,7 +1954,8 @@ static void record__read_lost_samples(struct record *rec)
>  
>  				if (count.lost) {
>  					if (!lost) {
> -						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +						lost = zalloc(sizeof(*lost) +
> +							      session->machines.host.id_hdr_size);
>  						if (!lost) {
>  							pr_debug("Memory allocation failed\n");
>  							return;
> @@ -1970,7 +1971,8 @@ static void record__read_lost_samples(struct record *rec)
>  		lost_count = perf_bpf_filter__lost_count(evsel);
>  		if (lost_count) {
>  			if (!lost) {
> -				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
> +				lost = zalloc(sizeof(*lost) +
> +					      session->machines.host.id_hdr_size);
>  				if (!lost) {
>  					pr_debug("Memory allocation failed\n");
>  					return;
> -- 
> 2.43.0.rc2.451.g8631bc7472-goog
> 

-- 

- Arnaldo

