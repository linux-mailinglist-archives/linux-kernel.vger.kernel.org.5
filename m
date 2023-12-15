Return-Path: <linux-kernel+bounces-1543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D72814FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8ED1C23FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B113FB11;
	Fri, 15 Dec 2023 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nk6sQx8u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208841858;
	Fri, 15 Dec 2023 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702666396; x=1734202396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mYCm1tpF4T2wy/rWJOyyJQVigyW+uGBDg3FnCNcjKKE=;
  b=Nk6sQx8unGRqpOY0SsEMZT5CY5TC3pfscZg/n+U2RzNHOcniLjnF/qbn
   jAXsuGea+4nEZmuOuc8kh/Cib23vaz/lFbTFhJ2M184R0amsMREHfrioY
   XrFBifujmb6Kd19EIHAdOj1lx8GwnxEHUUN4fKLfH8El+cINKbMV8uLiS
   kEE7OMORJE0nxX9/LPWMYe1Eep6/YG7VH/aQFyaRtvZnFfdhHIBxZmaSm
   731iBsCdsoDHKYt80kVT4DVHOGvJAPeDbmMHcV8PF0pwxIHO7sUVrzfUF
   OOxoFrQLLdNI9Z/CHMJSWRD0k7hVEPxt+Ym1fuZWcAsC0Zt6nZedeForG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="461774439"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="461774439"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 10:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="809059585"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="809059585"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 10:53:15 -0800
Received: from [10.209.148.184] (kliang2-mobl1.ccr.corp.intel.com [10.209.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 33308580DAA;
	Fri, 15 Dec 2023 10:53:14 -0800 (PST)
Message-ID: <14957171-6abd-4fd6-9e05-669b4945c0df@linux.intel.com>
Date: Fri, 15 Dec 2023 13:53:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>, maz@kernel.org, marcan@marcan.st,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
 <ZXd7ZuxbNNsjAyqm@kernel.org>
 <07677ab2-c29b-499b-b473-f7535fb27a8c@linux.intel.com>
 <CAM9d7ci-VVhubefMqkSQgK-B2e2z4QU1=TLJtC49wbWW=VNc8g@mail.gmail.com>
 <CAP-5=fVd-0aSovYVsOmTo2dfKb5_PHz1KV7ePipi35_JbfJ6qQ@mail.gmail.com>
 <ZXim6U5251q0_bB2@FVFF77S0Q05N.cambridge.arm.com>
 <ZXxyanyZgWBTOnoK@kernel.org>
 <4658ca16-9749-434e-9296-3893aa2a34da@linux.intel.com>
 <ZXyaZjwrpy6toGf6@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZXyaZjwrpy6toGf6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-15 1:26 p.m., Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 15, 2023 at 12:59:22PM -0500, Liang, Kan escreveu:
>> On 2023-12-15 10:36 a.m., Arnaldo Carvalho de Melo wrote:
>>
>> #perf report --header-only | grep event
>> # event : name = cpu_atom/cycles:P/, , id = { 7360, 7361, 7362, 7363,
>> 7364, 7365, 7366, 7367, 7368, 7369 }, type = 0 (PERF_TYPE_HARDWARE),
>> size = 136, config = 0xa00000000, { sample_period, sample_freq } = 3000,
>> sample_type = IP|TID|TIME|PERIOD|IDENTIFIER, read_format = ID|LOST,
>> disabled = 1, inherit = 1, freq = 1, enable_on_exec = 1, precise_ip = 3,
>> sample_id_all = 1
>> # event : name = cpu_core/cycles:P/, , id = { 7370, 7371, 7372, 7373,
>> 7374, 7375, 7376, 7377, 7378, 7379, 7380, 7381 }, type = 0
>> (PERF_TYPE_HARDWARE), size = 136, config = 0x400000000, { sample_period,
>> sample_freq } = 3000, sample_type = IP|TID|TIME|PERIOD|IDENTIFIER,
>> read_format = ID|LOST, disabled = 1, inherit = 1, freq = 1,
>> enable_on_exec = 1, precise_ip = 3, sample_id_all = 1
>>
>> I think we should move all the modifiers after the "/". The below patch
>> can fix it.
>>
>> https://lore.kernel.org/lkml/20231215175455.1300261-1-kan.liang@linux.intel.com/
> 
> Right, I implemented it in a slightly different way, but end result
> should be the same:
> 
> From 5dd1b7ab1ba69ebb8e070923dcc214b7b489ffc2 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 15 Dec 2023 15:23:30 -0300
> Subject: [PATCH 1/1] perf evlist: Move event attributes to after the / when
>  uniquefying using the PMU name
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Looks good to me and verified.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/util/evlist.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 6f0892803c2249af..3a9505c99490b372 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2522,7 +2522,7 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
>  void evlist__uniquify_name(struct evlist *evlist)
>  {
>  	struct evsel *pos;
> -	char *new_name;
> +	char *new_name, *attributes;
>  	int ret;
>  
>  	if (perf_pmus__num_core_pmus() == 1)
> @@ -2535,8 +2535,16 @@ void evlist__uniquify_name(struct evlist *evlist)
>  		if (strchr(pos->name, '/'))
>  			continue;
>  
> -		ret = asprintf(&new_name, "%s/%s/",
> -			       pos->pmu_name, pos->name);
> +		attributes = strchr(pos->name, ':');
> +		if (attributes)
> +			*attributes = '\0';
> +
> +		ret = asprintf(&new_name, "%s/%s/%s",
> +			       pos->pmu_name, pos->name, attributes ? attributes + 1 : "");
> +
> +		if (attributes)
> +			*attributes = ':';
> +
>  		if (ret) {
>  			free(pos->name);
>  			pos->name = new_name;

