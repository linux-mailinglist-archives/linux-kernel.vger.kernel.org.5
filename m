Return-Path: <linux-kernel+bounces-101432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A6787A709
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B321C21974
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA83F8D1;
	Wed, 13 Mar 2024 11:23:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FAB3F9C3;
	Wed, 13 Mar 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328996; cv=none; b=mCiu9fi3kTeYW81+RgpsSVufcH6ryy2nOT7WRZOJ4z6LzGBknWfBbIR0DSt1yx8v+m4cWLepQ6RdIMTeNbMT+Aa0GbCOyLT8OF7kDk+Ple+dRveNvf6XDTSUESFEpzs5uoqK6QDomkB3CnF7rGOPc1UUBth3wkTKgi39ORLDxD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328996; c=relaxed/simple;
	bh=1Ev87VJ8nP2uhWp4ncTlPvCTV/CBHhnDETcFmqJdwlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4kOgCQk+r+IB25nTxktskt0nZ80HyW7F7/nSNqZWKFqvYQNh+wX/2KdJEShSZ7hWkdcR4oCH5M/MnMcjX956aYjf+uonsSjLgaP39IpVvpLBwMQw5NvBBWYJ6+gp3BdwKEKa2BOBL/TBIpNF+7RVGDIYuiAJXu+ruG5uj6aiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8E211007;
	Wed, 13 Mar 2024 04:23:50 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DB763F73F;
	Wed, 13 Mar 2024 04:23:10 -0700 (PDT)
Message-ID: <993147ab-26b5-e497-d50f-0f500c8c81b8@arm.com>
Date: Wed, 13 Mar 2024 11:23:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/10] perf: Define common uncore capabilities
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-perf-users@vger.kernel.org, jialong.yang@shingroup.cn,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Will Deacon <will@kernel.org>
References: <cover.1710257512.git.robin.murphy@arm.com>
 <8496411b6ae9306b70cb90edafa4134b113a3cfe.1710257512.git.robin.murphy@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <8496411b6ae9306b70cb90edafa4134b113a3cfe.1710257512.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/03/2024 17:34, Robin Murphy wrote:
> Nearly all uncore/system PMUs share a common set of capbilities,
> so let's wrap those up in a single macro for ease of use.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/perf_event.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index b1fd832ed8bf..5d5db122005b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -293,6 +293,9 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>  #define PERF_PMU_CAP_NO_COMMON_EVENTS		0x0200
>  
> +#define PERF_PMU_UNCORE_CAPS \
> +(PERF_PMU_CAP_NO_SAMPLING| PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_COMMON_EVENTS)
> +

The most minor of nits: missing space before |. There is another one in
another commit that triggers checkpatch but that line gets deleted anyway.

>  struct perf_output_handle;
>  
>  #define PMU_NULL_DEV	((void *)(~0UL))

