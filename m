Return-Path: <linux-kernel+bounces-24622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16982BF4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA782877CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32FC6A010;
	Fri, 12 Jan 2024 11:35:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AA67E92;
	Fri, 12 Jan 2024 11:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E771424;
	Fri, 12 Jan 2024 03:36:16 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679643F73F;
	Fri, 12 Jan 2024 03:35:28 -0800 (PST)
Message-ID: <2c9f5893-450c-012b-b748-a8fe8ddfae86@arm.com>
Date: Fri, 12 Jan 2024 11:35:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] perf data convert: Fix segfault when converting to json
 on arm64
Content-Language: en-US
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20240111232923.8138-1-ilkka@os.amperecomputing.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240111232923.8138-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/01/2024 23:29, Ilkka Koskinen wrote:
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
> ---
>  tools/perf/util/data-convert-json.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 5bb3c2ba95ca..5d6de1cef546 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -97,6 +97,11 @@ static void output_json_format(FILE *out, bool comma, int depth, const char *for
>  static void output_json_key_string(FILE *out, bool comma, int depth,
>  		const char *key, const char *value)
>  {
> +	if (!value) {
> +		pr_info("No value set for key %s\n", key);
> +		return;
> +	}
> +
>  	output_json_delimiters(out, comma, depth);
>  	output_json_string(out, key);
>  	fputs(": ", out);


It looks like this would hide new errors on any of the other fields that
output_json_key_string() is called on. Maybe it would be better to only
wrap the call to output cpu_desc with the if? If that's the only one
that we think is optional, and even better only do it for arm64.

I mention this because the test for 'perf data convert' only checks for
valid json syntax, but not any fields. So we might want to avoid others
going missing.

Thanks
James

