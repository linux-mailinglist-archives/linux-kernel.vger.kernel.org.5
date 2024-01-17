Return-Path: <linux-kernel+bounces-29158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0A8309CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CD11C20DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD7D21A09;
	Wed, 17 Jan 2024 15:30:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051E219F8;
	Wed, 17 Jan 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505421; cv=none; b=qnJ/6NhIc/yNlfkY4d2DLsq8H0Fyiid3lcmu8dGIop6eMlr84rb42taRTM7/XO46C1FFO7kM3QBoHC5Qsz5XzPBydpHG2egXM8yKK6JY5SNHWX4y3Ao1mdHb8+aAz8t8clmN3f24K2Ho2+iiXQqc1d0Fuw5x7m/oQZELLa6wzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505421; c=relaxed/simple;
	bh=yIx1wkyn02/INYYU+ZhCD2MmJkqNNSXwqwE1qujHHOY=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=eCu5K8jew+n3PzPdot7h0KDvTJ8Wzkq6Sf3RU4WnMjw+bT2G6meXQfaX0D0YlzWJM3j/uUPF2rBWCdrDTVXlFdn3G6PLcIMuaBWojEGaq5/91V0qrDNa5EKSn5Fpisj+R5aLNjQvZhYyy+fEP/CO5MTHq2mSXOExZYuayaOVn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6550E11FB;
	Wed, 17 Jan 2024 07:31:04 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFA853F5A1;
	Wed, 17 Jan 2024 07:30:16 -0800 (PST)
Message-ID: <19913e91-b055-d767-2cb8-c6bc53671728@arm.com>
Date: Wed, 17 Jan 2024 15:30:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] perf data convert: Fix segfault when converting to
 json on arm64
Content-Language: en-US
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
References: <20240117071331.59725-1-ilkka@os.amperecomputing.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240117071331.59725-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17/01/2024 07:13, Ilkka Koskinen wrote:
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
> v1:
> 	- https://lore.kernel.org/all/20240111232923.8138-1-ilkka@os.amperecomputing.com/
> v2:
> 	- Changed the patch based on James's comments.
> ---
> tools/perf/util/data-convert-json.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 5bb3c2ba95ca..e8b006c3581f 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -284,7 +284,13 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
>  	output_json_key_string(out, true, 2, "os-release", header->env.os_release);
>  	output_json_key_string(out, true, 2, "arch", header->env.arch);
>  
> +#if !defined(__aarch64__)

I think this needs to read from header->env.arch, otherwise it won't
work if you run data convert on another machine.

I'm assuming that perf data convert is one of the commands that runs on
a pre-recorded file, rather than a command that creates the perf.data
file to begin with?

> +	/*
> +	 * arm64 doesn't have Model section in /proc/cpuinfo and, thus, cpu-desc
> +	 * is not set.
> +	 */
>  	output_json_key_string(out, true, 2, "cpu-desc", header->env.cpu_desc);
> +#endif
>  	output_json_key_string(out, true, 2, "cpuid", header->env.cpuid);
>  	output_json_key_format(out, true, 2, "nrcpus-online", "%u", header->env.nr_cpus_online);
>  	output_json_key_format(out, true, 2, "nrcpus-avail", "%u", header->env.nr_cpus_avail);

