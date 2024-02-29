Return-Path: <linux-kernel+bounces-87569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8386D5FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60DE288809
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614716FF47;
	Thu, 29 Feb 2024 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jqna82+R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7E16FF21;
	Thu, 29 Feb 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241475; cv=none; b=E8haD1j5Wfshv1qwlJrDmY4Kc68vhOFAauUHOXTdQQdbQkY1Fn9PE6VWB0Wgb6Il+qzYg7vDPmvz0eW060JUyjrh0zlpRlviW/xHPjTFF89gQolj3XYQpSBM54/AOIrvlaHREF+VFUg+M8lvEtgIgD8+HLoE/ECK9s2O3Ixm1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241475; c=relaxed/simple;
	bh=48SPLz2ZW2N1t+uqG8Wjgsd5Q/oGZByKDeVhfI1fnOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k3pvCePKFxsJEjzCLfmXiybuRIYCf9Oj58iYcFU0XDP+G1jISrlOguLecBfeoJU4jpElXJIzzfJbd9q2kh4Y6MZlk3sXfmaMe8crUusqhzCrsvQjdZAdjQeEH98yiGzL4tGf5dWfCUoPOPE06K8JnKmmhp5ybBOtgKw6XbEGSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jqna82+R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709241474; x=1740777474;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=48SPLz2ZW2N1t+uqG8Wjgsd5Q/oGZByKDeVhfI1fnOg=;
  b=Jqna82+RQNQALS6hENlpc4UuRD9SxQ1F6IYcUMe/yuiNRIULbAVu5cng
   BvsT/2e2yIiWRrxKwtnT+0yGDwymS0nef6tpaV8YzXQ9Phm33TCC6En/l
   7wEGiKprJsEXdfLJT3mxzpp8ZAzyql39/QxFeNu1xieo8JFWss46TJN0N
   AsxoSrJcJflvL8K1x9dhPRI4NlRgmAEWvo+tPGwJ1LWrLrj/X81XhHwET
   4r5a1vadT2b7DVlBxZXej3+yk28VPF4tJK5gmHYHISQi8hM0KFIeUw2nT
   AOZq95qk152GRWdq8lOHBo30+jCrDtyx6JwGv46SAgNY503qI9KaG4sIa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29175709"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="29175709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:17:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12646048"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:17:53 -0800
Received: from [10.212.85.217] (kliang2-mobl1.ccr.corp.intel.com [10.212.85.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id ADBF3580D37;
	Thu, 29 Feb 2024 13:17:50 -0800 (PST)
Message-ID: <7ec53a59-10d7-4a85-90b7-1337a0a42815@linux.intel.com>
Date: Thu, 29 Feb 2024 16:17:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/20] perf jevents: Add br metric group for branch
 statistics on Intel
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang
 <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>,
 Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>,
 James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
References: <20240229001806.4158429-1-irogers@google.com>
 <20240229001806.4158429-6-irogers@google.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240229001806.4158429-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-28 7:17 p.m., Ian Rogers wrote:
> The br metric group for branches itself comprises metric groups for
> total, taken, conditional, fused and far metric groups using json
> events. Condtional taken and not taken metrics are specific to Icelake
> and later generations, so a model to generation look up is added.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/intel_metrics.py | 139 +++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index 1096accea2aa..bee5da19d19d 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -19,6 +19,7 @@ LoadEvents(directory)
>  
>  interval_sec = Event("duration_time")
>  
> +

Unnecessary empty line.

Thanks,
Kan

>  def Idle() -> Metric:
>    cyc = Event("msr/mperf/")
>    tsc = Event("msr/tsc/")
> @@ -127,11 +128,149 @@ def Tsx() -> Optional[MetricGroup]:
>      return MetricGroup('transaction', metrics)
>  
>  
> +def IntelBr():
> +  ins = Event("instructions")
> +
> +  def Total() -> MetricGroup:
> +    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
> +    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
> +                     "BR_INST_RETIRED.MISPRED",
> +                     "BR_MISP_EXEC.ANY")
> +    br_clr = None
> +    try:
> +      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
> +    except:
> +      pass
> +
> +    br_r = d_ratio(br_all, interval_sec)
> +    ins_r = d_ratio(ins, br_all)
> +    misp_r = d_ratio(br_m_all, br_all)
> +    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
> +
> +    return MetricGroup("br_total", [
> +        Metric("br_total_retired",
> +               "The number of branch instructions retired per second.", br_r,
> +               "insn/s"),
> +        Metric(
> +            "br_total_mispred",
> +            "The number of branch instructions retired, of any type, that were "
> +            "not correctly predicted as a percentage of all branch instrucions.",
> +            misp_r, "100%"),
> +        Metric("br_total_insn_between_branches",
> +               "The number of instructions divided by the number of branches.",
> +               ins_r, "insn"),
> +        Metric("br_total_insn_fe_resteers",
> +               "The number of resync branches per second.", clr_r, "req/s"
> +               ) if clr_r else None
> +    ])
> +
> +  def Taken() -> MetricGroup:
> +    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
> +    br_m_tk = None
> +    try:
> +      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
> +                      "BR_MISP_RETIRED.TAKEN_JCC",
> +                      "BR_INST_RETIRED.MISPRED_TAKEN")
> +    except:
> +      pass
> +    br_r = d_ratio(br_all, interval_sec)
> +    ins_r = d_ratio(ins, br_all)
> +    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
> +    return MetricGroup("br_taken", [
> +        Metric("br_taken_retired",
> +               "The number of taken branches that were retired per second.",
> +               br_r, "insn/s"),
> +        Metric(
> +            "br_taken_mispred",
> +            "The number of retired taken branch instructions that were "
> +            "mispredicted as a percentage of all taken branches.", misp_r,
> +            "100%") if misp_r else None,
> +        Metric(
> +            "br_taken_insn_between_branches",
> +            "The number of instructions divided by the number of taken branches.",
> +            ins_r, "insn"),
> +    ])
> +
> +  def Conditional() -> Optional[MetricGroup]:
> +    try:
> +      br_cond = Event("BR_INST_RETIRED.COND",
> +                      "BR_INST_RETIRED.CONDITIONAL",
> +                      "BR_INST_RETIRED.TAKEN_JCC")
> +      br_m_cond = Event("BR_MISP_RETIRED.COND",
> +                        "BR_MISP_RETIRED.CONDITIONAL",
> +                        "BR_MISP_RETIRED.TAKEN_JCC")
> +    except:
> +      return None
> +
> +    br_cond_nt = None
> +    br_m_cond_nt = None
> +    try:
> +      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
> +      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
> +    except:
> +      pass
> +    br_r = d_ratio(br_cond, interval_sec)
> +    ins_r = d_ratio(ins, br_cond)
> +    misp_r = d_ratio(br_m_cond, br_cond)
> +    taken_metrics = [
> +        Metric("br_cond_retired", "Retired conditional branch instructions.",
> +               br_r, "insn/s"),
> +        Metric("br_cond_insn_between_branches",
> +               "The number of instructions divided by the number of conditional "
> +               "branches.", ins_r, "insn"),
> +        Metric("br_cond_mispred",
> +               "Retired conditional branch instructions mispredicted as a "
> +               "percentage of all conditional branches.", misp_r, "100%"),
> +    ]
> +    if not br_m_cond_nt:
> +      return MetricGroup("br_cond", taken_metrics)
> +
> +    br_r = d_ratio(br_cond_nt, interval_sec)
> +    ins_r = d_ratio(ins, br_cond_nt)
> +    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
> +
> +    not_taken_metrics = [
> +        Metric("br_cond_retired", "Retired conditional not taken branch instructions.",
> +               br_r, "insn/s"),
> +        Metric("br_cond_insn_between_branches",
> +               "The number of instructions divided by the number of not taken conditional "
> +               "branches.", ins_r, "insn"),
> +        Metric("br_cond_mispred",
> +               "Retired not taken conditional branch instructions mispredicted as a "
> +               "percentage of all not taken conditional branches.", misp_r, "100%"),
> +    ]
> +    return MetricGroup("br_cond", [
> +        MetricGroup("br_cond_nt", not_taken_metrics),
> +        MetricGroup("br_cond_tkn", taken_metrics),
> +    ])
> +
> +  def Far() -> Optional[MetricGroup]:
> +    try:
> +      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
> +    except:
> +      return None
> +
> +    br_r = d_ratio(br_far, interval_sec)
> +    ins_r = d_ratio(ins, br_far)
> +    return MetricGroup("br_far", [
> +        Metric("br_far_retired", "Retired far control transfers per second.",
> +               br_r, "insn/s"),
> +        Metric(
> +            "br_far_insn_between_branches",
> +            "The number of instructions divided by the number of far branches.",
> +            ins_r, "insn"),
> +    ])
> +
> +  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
> +                     description="breakdown of retired branch instructions")
> +
> +
>  all_metrics = MetricGroup("", [
>      Idle(),
>      Rapl(),
>      Smi(),
>      Tsx(),
> +    IntelBr(),
>  ])
>  
>  if args.metricgroups:

