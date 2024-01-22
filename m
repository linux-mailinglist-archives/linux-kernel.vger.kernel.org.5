Return-Path: <linux-kernel+bounces-32682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F411835ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0C01F255EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C872E39FDD;
	Mon, 22 Jan 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+nEUDLj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2139FC3;
	Mon, 22 Jan 2024 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917564; cv=none; b=sCyzVXPsiYjD0ulecNRl6MoIDTwAG7QMJtzyCIYye83YgJSIM6jdG3qeFYT0iee6XLofEqL4bqPpqgm1tcSX5tRcn/5B/nbWTQIUB2KjNHA5XSoCa4Sqf5Rud1O1+lNqvM9VMeBRwurrYBGx389yyDUhZG7VVDScN640hI2odF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917564; c=relaxed/simple;
	bh=yI7BkxiARwJDyFyiI+RWi3YWMjcFaJI85oGbC+zm07U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaVmq9aq8Yeu+FbCu0idveUd/sj2nQIHTpTIO7nk73WYVOfeZU1EQWMIVKbCbVPyLTARKECq8Qs6NmOVzHm7DB08tW9bbQeqvrfPCC+07Lzpovn7JxXWZsWiPhGkdHqvgUAzPEn4uF7N6TLOIhZNfRzKI2mm1q82gRocKW5p+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+nEUDLj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705917563; x=1737453563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yI7BkxiARwJDyFyiI+RWi3YWMjcFaJI85oGbC+zm07U=;
  b=n+nEUDLjxiMlGLQXgZBRdX3FT1v1sixGX2DCjyzSEyyVGrx/urUPm61a
   H5jff2brU8IP/M9JXAN7ssQJvaO0/RY9pWo4RbVdCRkUbfzp+4dapZJVH
   VQGLkFhzAzgmmfqgTAiFUz/kDX5SsCX6qW0liuXs9l/hgFd9p28uezq/T
   yyP7brbV/lz3kWCHvoXx1Z7IP7AWT7ifUIvSspWSwJ1msCghj0XyEbCPb
   NFOXn4g3EKt8wqpclWM93ZnK8YBei5Lii/eol+vcRq7YAAGxrbeLJW4CW
   MS/kAdVQqnd8fc1evd4xmK/mL1RDrZ4cgbz+SaOdPz0n1G7b4iMKcl4g3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="58037"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="58037"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1162228"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.40.86])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:59:17 -0800
Message-ID: <e8e5ea25-326b-4565-b0e8-1583b09dba65@intel.com>
Date: Mon, 22 Jan 2024 11:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] perf: script: add field 'disasm' to display
 mnemonic instructions
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-4-changbin.du@huawei.com>
 <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
 <20240120074009.zmywqj6irtedivqk@M910t>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240120074009.zmywqj6irtedivqk@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/24 09:40, Changbin Du wrote:
> On Fri, Jan 19, 2024 at 08:39:36PM +0200, Adrian Hunter wrote:
>> On 19/01/24 12:48, Changbin Du wrote:
>>> In addition to the 'insn' field, this adds a new field 'disasm' to
>>> display mnemonic instructions instead of the raw code.
>>>
>>> $ sudo perf script -F +disasm
>>>        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
>>>        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
>>>               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
>>>               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
>>>
>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>> ---
>>>  tools/perf/Documentation/perf-script.txt | 7 ++++---
>>>  tools/perf/builtin-script.c              | 8 +++++++-
>>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
>>> index ff9a52e44688..fc79167c6bf8 100644
>>> --- a/tools/perf/Documentation/perf-script.txt
>>> +++ b/tools/perf/Documentation/perf-script.txt
>>> @@ -132,9 +132,10 @@ OPTIONS
>>>          Comma separated list of fields to print. Options are:
>>>          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
>>>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
>>> -        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
>>> -        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
>>> -        machine_pid, vcpu, cgroup, retire_lat.
>>> +        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, disasm,
>>> +        insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
>>> +        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
>>> +
>>
>> Further down, there are explanations for insn and insnlen.  disasm
>> could be added there.
>>
> Updated as:
> 
> 	When doing instruction trace decoding, insn, disasm and insnlen give the
> 	instruction bytes, disassembled instructions and the instruction length
> 	of the current instruction respectively.

I wondered about mentioning that disasm needs perf to be compiled with
disassembler support, but with a permissive license it seems likely
that libcapstone support would generally be built into perf, so that
should be fine.

> 
>>>          Field list can be prepended with the type, trace, sw or hw,
>>>          to indicate to which event type the field list applies.
>>>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index 4817a37f16e2..12d886694f6c 100644
>>> --- a/tools/perf/builtin-script.c
>>> +++ b/tools/perf/builtin-script.c
>>> @@ -135,6 +135,7 @@ enum perf_output_field {
>>>  	PERF_OUTPUT_CGROUP          = 1ULL << 39,
>>>  	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
>>>  	PERF_OUTPUT_DSOFF           = 1ULL << 41,
>>> +	PERF_OUTPUT_DISASM          = 1ULL << 42,
>>>  };
>>>  
>>>  struct perf_script {
>>> @@ -190,6 +191,7 @@ struct output_option {
>>>  	{.str = "bpf-output",   .field = PERF_OUTPUT_BPF_OUTPUT},
>>>  	{.str = "callindent", .field = PERF_OUTPUT_CALLINDENT},
>>>  	{.str = "insn", .field = PERF_OUTPUT_INSN},
>>> +	{.str = "disasm", .field = PERF_OUTPUT_DISASM},
>>>  	{.str = "insnlen", .field = PERF_OUTPUT_INSNLEN},
>>>  	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
>>>  	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
>>> @@ -1515,6 +1517,10 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>>>  		printed += fprintf(fp, " insn: ");
>>>  		printed += sample__fprintf_insn_raw(sample, fp);
>>>  	}
>>> +	if (PRINT_FIELD(DISASM) && sample->insn_len) {
>>> +		printed += fprintf(fp, " insn: ");
>>> +		printed += sample__fprintf_insn(sample, thread, machine, fp);
>>> +	}
>>>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>>>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
>>>  
>>> @@ -3900,7 +3906,7 @@ int cmd_script(int argc, const char **argv)
>>>  		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff,"
>>>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
>>>  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
>>> -		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
>>> +		     "brstackinsnlen,brstackoff,callindent,insn,disasm,insnlen,synth,"
>>>  		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
>>>  		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
>>>  		     parse_output_fields),
>>
> 


