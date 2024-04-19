Return-Path: <linux-kernel+bounces-151910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A38AB5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F83B22ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9113C913;
	Fri, 19 Apr 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkEa3T9N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242EA23;
	Fri, 19 Apr 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555439; cv=none; b=DfQg4dLO1dkE/i0k6R6VkrvzmxI1yCZcLRwmXvRs07ZqVV9YgOAiBhyEFOZsobiDkPNCvo0QDjuFmoYHPgYX3o3OtXJwgXsIJHBYzgb6hkggqhuWA3yI5g67spFW1VMuhN7Xx56rBaayTsLu1tyP1kKqkHuCNN/pwJ2waGBQ9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555439; c=relaxed/simple;
	bh=A9cF8+qPoGkGUlM0Tsk5gyzSNwz4d8CWKiq4YwLBxfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ExcC5jEBO1NE62D/3DGAJ2Omxy/zWz3VhrK2WiA5qIOteEvq0LlE/Zdow0UnHMU7gsGK0VqhszQJRKVOwcu3obuc4gKOet8WDihcrCJfFGZGljITV2x3SDPy7fftRc6YMTX2Et2CcyCZ4+Vjls/eZqpC4algWMKwzC5M82e4/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkEa3T9N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713555437; x=1745091437;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=A9cF8+qPoGkGUlM0Tsk5gyzSNwz4d8CWKiq4YwLBxfc=;
  b=FkEa3T9NJVqiZL1wMunSxvcKmYe9/f07LuWiQyaldSejTLDiEExkb+6p
   QLkMsI7cL8R9gf4Eez1lgZSIbaSelGjDN/+FSIyNhbzC65RBUcLsK6QLY
   dahTLvOEi0kjQBGKOXQnfVkNCsalVw9MWXyvtQ5XpujBT1NxGlLPU19e5
   LUTcIlKVAyjg1lXy3A3bBRXdzWImwY+rFSYpV9rsag3yt1BpeVMePydj4
   CuN2zPZXWScNGViDC5NrH2Yt9SmELZmZmxNty52LxvoIkKy4pPOrKJOMR
   NpqEnyVUdJLaZ/OnWxYr3S8lTEaPLsNAVOh4sSXLzJDmQmXpSL+vQO7bN
   A==;
X-CSE-ConnectionGUID: ZV7KbckUQM2lioeQCnopFA==
X-CSE-MsgGUID: Z8kFKsMNQp6zQRs7OMf4fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="12965047"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="12965047"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:37:16 -0700
X-CSE-ConnectionGUID: 74YC2/UDSumrLkTudLKmEw==
X-CSE-MsgGUID: rZeXRy7LTtyi5/Q2oNcf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="23867224"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 12:37:16 -0700
Received: from [10.212.13.6] (kliang2-mobl1.ccr.corp.intel.com [10.212.13.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 81F85206DFDC;
	Fri, 19 Apr 2024 12:37:12 -0700 (PDT)
Message-ID: <931b2a52-74ec-4094-962c-31237fafb803@linux.intel.com>
Date: Fri, 19 Apr 2024 15:37:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 John Garry <john.g.garry@oracle.com>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>,
 James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor
 <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang
 <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>,
 Stephane Eranian <eranian@google.com>
References: <20240314055051.1960527-1-irogers@google.com>
 <20240314055051.1960527-13-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240314055051.1960527-13-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-14 1:50 a.m., Ian Rogers wrote:
> Add a LoadEvents function that loads all event json files in a
> directory. In the Event constructor ensure all events are defined in
> the event json except for legacy events like "cycles". If the initial
> event isn't found then legacy_event1 is used, and if that isn't found
> legacy_event2 is used. This allows a single Event to have multiple
> event names as models will often rename the same event over time. If
> the event doesn't exist an exception is raised.
> 
> So that references to metrics can be added, add the MetricRef
> class. This doesn't validate as an event name and so provides an
> escape hatch for metrics to refer to each other.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/Build            | 12 ++--
>  tools/perf/pmu-events/amd_metrics.py   |  6 +-
>  tools/perf/pmu-events/arm64_metrics.py |  6 +-
>  tools/perf/pmu-events/intel_metrics.py |  6 +-
>  tools/perf/pmu-events/metric.py        | 77 +++++++++++++++++++++++++-
>  5 files changed, 95 insertions(+), 12 deletions(-)
>

make fails.

  GEN     pmu-events/arch/arm64/arm/cortex-a710/extra-metricgroups.json
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
  GEN     pmu-events/arch/arm64/arm/cortex-a73/extra-metrics.json
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/branch.json <-
pmu-events/arch/arm64/arm/cortex-a75/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/bus.json <-
pmu-events/arch/arm64/arm/cortex-a75/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/cache.json <-
pmu-events/arch/arm64/arm/cortex-a75/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/etm.json <-
pmu-events/arch/arm64/arm/cortex-a75/etm.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/exception.json <-
pmu-events/arch/arm64/arm/cortex-a75/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/instruction.json
<- pmu-events/arch/arm64/arm/cortex-a75/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/memory.json <-
pmu-events/arch/arm64/arm/cortex-a75/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/mmu.json <-
pmu-events/arch/arm64/arm/cortex-a75/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/pipeline.json <-
pmu-events/arch/arm64/arm/cortex-a75/pipeline.json dependency dropped.
  GEN     pmu-events/arch/arm64/arm/cortex-a73/extra-metricgroups.json
make[3]: *** [pmu-events/Build:58:
pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metrics.json'
make[3]: *** Waiting for unfinished jobs....
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:58:
pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metrics.json'
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:62:
pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metricgroups.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a57-a72/extra-metricgroups.json'
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:62:
pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metricgroups.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a65-e1/extra-metricgroups.json'
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    raise JSONDecodeError("Expecting value", s, err.value) from None
    for x in json.load(open(f"{directory}/{filename}")):
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
Traceback (most recent call last):
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 43, in <module>
    main()
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/arm64_metrics.py",
line 35, in main
    LoadEvents(directory)
  File
"/home/kan/tmp/perf-tools-next-test/tools/perf/pmu-events/metric.py",
line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
  File "/usr/lib64/python3.10/json/__init__.py", line 293, in load
    return loads(fp.read(),
  File "/usr/lib64/python3.10/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/lib64/python3.10/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/lib64/python3.10/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:62:
pmu-events/arch/arm64/arm/cortex-a710/extra-metricgroups.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a710/extra-metricgroups.json'
make[3]: *** [pmu-events/Build:58:
pmu-events/arch/arm64/arm/cortex-a710/extra-metrics.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a710/extra-metrics.json'
make[3]: *** [pmu-events/Build:62:
pmu-events/arch/arm64/arm/cortex-a73/extra-metricgroups.json] Error 1
make[3]: *** Deleting file
'pmu-events/arch/arm64/arm/cortex-a73/extra-metricgroups.json'
make[2]: *** [Makefile.perf:730: pmu-events/pmu-events-in.o] Error 2
make[1]: *** [Makefile.perf:264: sub-make] Error 2
make: *** [Makefile:70: all] Error 2


Thanks,
Kan

> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index e2db33577707..a2c5c04e5c46 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -42,11 +42,11 @@ ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
>  
>  $(ZEN_METRICS): pmu-events/amd_metrics.py
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) pmu-events/arch > $@
>  
>  $(ZEN_METRICGROUPS): pmu-events/amd_metrics.py
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) pmu-events/arch > $@
>  
>  # Generate ARM Json
>  ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
> @@ -55,11 +55,11 @@ ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
>  
>  $(ARM_METRICS): pmu-events/arm64_metrics.py
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) arch > $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) pmu-events/arch > $@
>  
>  $(ARM_METRICGROUPS): pmu-events/arm64_metrics.py
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) arch > $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) pmu-events/arch > $@
>  
>  # Generate Intel Json
>  INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
> @@ -68,11 +68,11 @@ INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json
>  
>  $(INTEL_METRICS): pmu-events/intel_metrics.py
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) pmu-events/arch > $@
>  
>  $(INTEL_METRICGROUPS): pmu-events/intel_metrics.py
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) pmu-events/arch > $@
>  
>  GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
>              $(ZEN_METRICS) $(ZEN_METRICGROUPS) \
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 7ab2ee4fdb17..4f728e7aae4a 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -1,6 +1,7 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
> +from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
> +                    MetricGroup)
>  import argparse
>  import json
>  import os
> @@ -27,6 +28,9 @@ def main() -> None:
>    )
>    _args = parser.parse_args()
>  
> +  directory = f"{_args.events_path}/x86/{_args.model}/"
> +  LoadEvents(directory)
> +
>    all_metrics = MetricGroup("",[])
>  
>    if _args.metricgroups:
> diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
> index a9f0e6bc751b..c9aa2d827a82 100755
> --- a/tools/perf/pmu-events/arm64_metrics.py
> +++ b/tools/perf/pmu-events/arm64_metrics.py
> @@ -1,6 +1,7 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
> +from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
> +                    MetricGroup)
>  import argparse
>  import json
>  import os
> @@ -30,6 +31,9 @@ def main() -> None:
>  
>    all_metrics = MetricGroup("",[])
>  
> +  directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
> +  LoadEvents(directory)
> +
>    if _args.metricgroups:
>      print(JsonEncodeMetricGroupDescriptions(all_metrics))
>    else:
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index f004c27640d2..04a19d05c6c1 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -1,6 +1,7 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
> +from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
> +                    MetricGroup)
>  import argparse
>  import json
>  import os
> @@ -27,6 +28,9 @@ def main() -> None:
>    )
>    _args = parser.parse_args()
>  
> +  directory = f"{_args.events_path}/x86/{_args.model}/"
> +  LoadEvents(directory)
> +
>    all_metrics = MetricGroup("",[])
>  
>    if _args.metricgroups:
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
> index dd8fd06940e6..03312cd6d491 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -3,10 +3,50 @@
>  import ast
>  import decimal
>  import json
> +import os
>  import re
>  from enum import Enum
>  from typing import Dict, List, Optional, Set, Tuple, Union
>  
> +all_events = set()
> +
> +def LoadEvents(directory: str) -> None:
> +  """Populate a global set of all known events for the purpose of validating Event names"""
> +  global all_events
> +  all_events = {
> +      "context\-switches",
> +      "cycles",
> +      "duration_time",
> +      "instructions",
> +      "l2_itlb_misses",
> +  }
> +  for file in os.listdir(os.fsencode(directory)):
> +    filename = os.fsdecode(file)
> +    if filename.endswith(".json"):
> +      for x in json.load(open(f"{directory}/{filename}")):
> +        if "EventName" in x:
> +          all_events.add(x["EventName"])
> +        elif "ArchStdEvent" in x:
> +          all_events.add(x["ArchStdEvent"])
> +
> +
> +def CheckEvent(name: str) -> bool:
> +  """Check the event name exists in the set of all loaded events"""
> +  global all_events
> +  if len(all_events) == 0:
> +    # No events loaded so assume any event is good.
> +    return True
> +
> +  if ':' in name:
> +    # Remove trailing modifier.
> +    name = name[:name.find(':')]
> +  elif '/' in name:
> +    # Name could begin with a PMU or an event, for now assume it is good.
> +    return True
> +
> +  return name in all_events
> +
> +
>  class MetricConstraint(Enum):
>    GROUPED_EVENTS = 0
>    NO_GROUP_EVENTS = 1
> @@ -317,9 +357,18 @@ def _FixEscapes(s: str) -> str:
>  class Event(Expression):
>    """An event in an expression."""
>  
> -  def __init__(self, name: str, legacy_name: str = ''):
> -    self.name = _FixEscapes(name)
> -    self.legacy_name = _FixEscapes(legacy_name)
> +  def __init__(self, *args: str):
> +    error = ""
> +    for name in args:
> +      if CheckEvent(name):
> +        self.name = _FixEscapes(name)
> +        return
> +      if error:
> +        error += " or " + name
> +      else:
> +        error = name
> +    global all_events
> +    raise Exception(f"No event {error} in:\n{all_events}")
>  
>    def ToPerfJson(self):
>      result = re.sub('/', '@', self.name)
> @@ -338,6 +387,28 @@ class Event(Expression):
>      return self
>  
>  
> +class MetricRef(Expression):
> +  """A metric reference in an expression."""
> +
> +  def __init__(self, name: str):
> +    self.name = _FixEscapes(name)
> +
> +  def ToPerfJson(self):
> +    return self.name
> +
> +  def ToPython(self):
> +    return f'MetricRef(r"{self.name}")'
> +
> +  def Simplify(self) -> Expression:
> +    return self
> +
> +  def Equals(self, other: Expression) -> bool:
> +    return isinstance(other, MetricRef) and self.name == other.name
> +
> +  def Substitute(self, name: str, expression: Expression) -> Expression:
> +    return self
> +
> +
>  class Constant(Expression):
>    """A constant within the expression tree."""
>  

