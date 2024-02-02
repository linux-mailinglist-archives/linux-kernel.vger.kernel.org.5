Return-Path: <linux-kernel+bounces-49737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB98846EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20261F2853D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422E13E206;
	Fri,  2 Feb 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXwGtKj/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96213DBA6;
	Fri,  2 Feb 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872628; cv=none; b=ZVMB6T/VJz+izbiKuGiqSQ5I23lvjDpSxwelkQy1+zv6Ll0n4F2a7HkmPeu1UsOPUK9lrzSqmjnXN8BDopSaWXwpputjmH97nTGSuF9uoK4jNl5c72Y75A56rWD+MhizTwTsVxxGL11hbit/4Mu1EhF2j/NIQWElk4zps8MViBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872628; c=relaxed/simple;
	bh=kBeHgBaMwYGen1Lqpic1KCteiXsH/7+4PjqVtZlGm94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAtgYuyvfwAtXa+HOeTYgEdv2lZIDA3jiN23KEP8vK3lS6utygQny4ag26HD3Q0K4Y1/K0wCfAfNcG7p/aUFSIvTiZEyJMIKzLUKW8u6epXinMBqJF+cvTD6HLwMCg4c4psjZgDfc5r67FtG/0hZpIXzJ62LTmG5Jo5GHQhKmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXwGtKj/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706872626; x=1738408626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kBeHgBaMwYGen1Lqpic1KCteiXsH/7+4PjqVtZlGm94=;
  b=TXwGtKj/ez1ZJ2jJtprMECCwBz/Tj6sI/tHMbKGqO67Rnmv/luITCb5k
   q3UG70TOzpNnHEx3vO4qC1ktX5xcwueOLoxNW/UVoZJ1+NuCY0W+OlYin
   DO865nZP9cpdl2CWZWi/1B+wxQDXagbBX9SirAbLsItNxEHq/OBGRz8lr
   +6v2ojI6Q7BzPQKPUTJJS0B4ruz/o+DH22ShP6etfFMcIEPUZVKrFWdtI
   GVUTBO2SX3vtWZpZiyK11VEjd/2AZbfzLdQhTGxCJZ8+rv6DKUI0/Mz/A
   M90ADN1e3F6TQeZbmaeBTejrMfkQK3KB3x2mFocx4YuZEWmN8aku0NJRF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="3980014"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="3980014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4662086"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.118])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 03:17:02 -0800
Message-ID: <ce398eb3-2ded-4149-9ac8-4eb60a474a0d@intel.com>
Date: Fri, 2 Feb 2024 13:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf header: Set proper symbol name for vdso when
 build-id event found
Content-Language: en-US
To: Like Xu <like.xu.linux@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20231201111506.37155-1-likexu@tencent.com>
 <f50149fb-967c-4987-8d08-d6bb2a69bcf3@intel.com>
 <9d8c8900-699e-4879-8aca-d9371e77f097@gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9d8c8900-699e-4879-8aca-d9371e77f097@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/12/23 04:48, Like Xu wrote:
> On 14/12/2023 3:26 am, Adrian Hunter wrote:
>> On 1/12/23 13:15, Like Xu wrote:
>>> From: Like Xu <likexu@tencent.com>
>>>
>>> If using perf-record to sample a cpu-cycles:P event on a hypervisor process
>>> when '--kcore' is not enabled, user may find some surprise in perf-report:
>>>
>>> # perf report -i perf.data -v:
>>> # Overhead Command   Shared Object                Symbol
>>>      99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0xffffffffa10d1e30 B [k] 0x0000000000034ed0
>>>
>>> build id event received for vmlinux: d12116149f511f7dbd0b21c45d38d3d2ec09b87f [20]
>>> build id event received for kvm-intel.ko: a8fc0213abbafd97b10ce58ce84bec8519f9abce [20]
>>> build id event received for [vdso]: 4d56e381df8d2c051f6bc1ef69c0118c59d5c49f [20]
>>>
>>> # perf report:
>>> # Overhead  Command  Shared Object     Symbol
>>> # ........  .......  ................  .......................................
>>> #
>>>      99.71%  vcpu0    [kvm_intel]       [k] 0x0000000000034ed0
>>>       0.10%  vcpu0    [kernel.vmlinux]  [k] __lock_acquire.isra.29
>>>
>>> Users may be curious as to how 0x34ed0 was generated and wondered if this
>>> RIP came from the guest application but perf-script-D does not point to any
>>> samples of this address.
>>>
>>> Based on perf/tool implementation, this is actually an offset pointing to
>>> the vdso object (in this case it is the assembly __vmx_vcpu_run defined
>>> in arch/x86/kvm/vmx/vmenter.S). The pattern is not reproduced on perf-tool
>>> of some distributions, and git-bisect quickly identified the possible root
>>> cause, which leds to this straightforward fix and after this change:
>>>
>>> # perf report -i perf.data -v:
>>> # Overhead Command   Shared Object                Symbol
>>>      99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0x34ed0            B [k] __vmx_vcpu_run
>>>
>>> # perf report:
>>> # Overhead  Command  Shared Object     Symbol
>>> # ........  .......  ................  .......................................
>>> #
>>>      99.71%  vcpu0    [kvm_intel]       [k] __vmx_vcpu_run
>>>
>>> The fix also gets commit 1deec1bd96cc ("perf header: Set proper module name
>>> when build-id event found") lit again.
>>>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Ian Rogers <irogers@google.com>
>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>> Fixes: b2fe96a350de ("perf tools: Fix module symbol processing")
>>> Signed-off-by: Like Xu <likexu@tencent.com>
>>> ---
>>>   tools/perf/util/header.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>> index e86b9439ffee..a33d589511ff 100644
>>> --- a/tools/perf/util/header.c
>>> +++ b/tools/perf/util/header.c
>>> @@ -2305,8 +2305,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>>>                 if (!kmod_path__parse_name(&m, filename) && m.kmod)
>>>                   dso__set_module_info(dso, &m, machine);
>>> -
>>> -            dso->kernel = dso_space;
>>> +            else
>>> +                dso->kernel = dso_space;
>>
>> This is undoing some of b2fe96a350de ("perf tools: Fix module
>> symbol processing") without explanation.
> 
> Thanks for your comments.
> W/ this fix, "perf test -v object" looks OK.
> 
>>
>> Symbols in the .noinstr.text section don't seem to be
>> being resolved, so that could be the issue.  perf synthesizes
>> an MMAP record from /proc/modules, which works for .text
>> but perhaps not for .noinstr.text
> 
> Not sure if it covers the potentially broken features you mentioned above,
> would you be willing to provide a more detailed test command ?

I sent a patch that might help a bit:

https://lore.kernel.org/linux-perf-users/20240202110130.3553-3-adrian.hunter@intel.com/



