Return-Path: <linux-kernel+bounces-79728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA98E8625DC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E081F2187C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33E84778E;
	Sat, 24 Feb 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFgTMPRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118E46558;
	Sat, 24 Feb 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789779; cv=none; b=ldrO6lNYaM7fTeXaZ05bpPDE2YOhQ3UT8CPLXbXvDF58kE1nmcEg0Cuyceh/9Vpd+usLzNU6MESdyqxSjBoNIXAlcP6K+QgGG3mtKZBndaGgLBa43PUSLCuQaVwVlxccbR+E4uTcbXljTFT6EM1rLzuYv0ud0PZPWftW+zAq1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789779; c=relaxed/simple;
	bh=JhKIpi/5c6m6jLWrTAC+y0zdzh3KN93tgDycxt99TUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDHlot/zcgEEAOpPWlTDe1n9Xc04Sj60ZjHpuFpJosIcmgPRoxLkXAH3JYEiJK8B7rCWwZqa3o/bt0LGWuFMehxbn8C/c5OONpieP9HVtwcMARjtW6ent7FAbj/k3Ru372NdorjAD+xFVCpGuVx9IEi3coAMMJroJysW4v+AWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFgTMPRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B40FC433F1;
	Sat, 24 Feb 2024 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708789778;
	bh=JhKIpi/5c6m6jLWrTAC+y0zdzh3KN93tgDycxt99TUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFgTMPRifsogZ8rVCApbX8LuzPxzgwkbz5lsW7bMS7exPBXVEBQfc4JXGpkeKqPH8
	 6DjhFtT1jvA73iACGTnkhu/OZLFVi1IVnt07el+S91xmqR91Fmvv1BZo0CeDs7bT+f
	 EN1MZFlKX4h16gYYZFVjfZY4rYwMylTNj8eM0ADD0ka6Bl13WI0F16xcMHDYOPAO/5
	 5/HgRB1KPuyTEnwcJKkP3xGRFagQV+sv4/Cp/ti4EBwss+kuhT4+l0VhrdStxnEv37
	 nShK2i99e6JU5y4I5iCDXGPxEM+yQO+YB+0mXHfB0ypRrpAenoh0k42N51KuhxQifE
	 trPDdkTaD58aA==
Date: Sat, 24 Feb 2024 12:49:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	Evgeny Pistun <kotborealis@awooo.ru>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf data convert: Fix segfault when converting to
 json when cpu_desc isn't set
Message-ID: <ZdoQD1UJkl-IFSJG@x1>
References: <20240223220458.15282-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223220458.15282-1-ilkka@os.amperecomputing.com>

On Fri, Feb 23, 2024 at 02:04:58PM -0800, Ilkka Koskinen wrote:
> Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
> assigned.
> 
> Running
> 	$ perf data convert --to-json perf.data.json
> 
> ends up calling output_json_string() with NULL pointer, which causes a
> segmentation fault.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> ---
> 
> v1:
>     - https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
> v2:
>     - Changed the patch based on James's comments.
> v3:
>     - The architecture is checked from the actual data file to allow one to do
>       conversion on another system. (thanks to James for the feedback)
>     - https://lore.kernel.org/all/20240117215101.77713-1-ilkka@os.amperecomputing.com/
> v4:
>     - Made the fix more generic in case there are other architectures where cpu_desc
>       isn't assigned as asked by Namhyung
>     - Rephrased the subject line
> ---
> 
> tools/perf/util/data-convert-json.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 5bb3c2ba95ca..09d57efd2d9d 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -284,7 +284,9 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
>  	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
>  	output_json_key_string(out, true, 2, "arch", header->env.arch);
>  
> -	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
> +	if (header->env.cpu_desc)
> +		output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
> +
>  	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
>  	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
>  	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);
> -- 
> 2.43.0

