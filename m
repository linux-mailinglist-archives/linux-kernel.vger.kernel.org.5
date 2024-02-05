Return-Path: <linux-kernel+bounces-52691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 273D2849B75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898361F2462E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F612377F;
	Mon,  5 Feb 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEwAjSJg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DA1CD0C;
	Mon,  5 Feb 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138668; cv=none; b=i9P0/3Nmb7fNTRbh7AYTzYVsDlYV2K020veor+HL74iGMI5+8M3WEHiGkX226C4iGsC2HmLvCm0WILE0gcQibCk3uTYsqS0od/S5YLOz4tXH1WbVEouiNDEabF9Wo8CdjyVO5e9k9eNNMvZxKCbxg9iGOXmH9iuy42BdIeN0lek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138668; c=relaxed/simple;
	bh=MYkS9d2s6p9HKgiwTdKBmVmHZlIcyzTFIDk1v+yTDhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txRo6nyh45tzv6A9MKOwrgSBARkz6ZOyeBDRgWDPaHhrwwJrvh0OimEzdUsaJuIMbJOUl4U2MA3bNzY52zFzSta7vyQ53g3nKu6Hk+adKxQoZ2egeOe2uC4sH/Msw1fH8ydHbotaD1qj3tLIEzSAootX7gqLYF1Pa4GcGc5Jpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEwAjSJg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707138666; x=1738674666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MYkS9d2s6p9HKgiwTdKBmVmHZlIcyzTFIDk1v+yTDhg=;
  b=HEwAjSJg5dHWu/CRBT7FkhPMH025bzkdDevjX7xpRC9DlQmAuaPMjg3h
   IpWwR7Gkhnw9CtD23PO5GDanq9H9BUc/JUTcgoi74n2f0LnsIcJ8Veq9B
   qPbcrIywHxCU6BukqJagG0wFQKUOJ2FVd0yXuYlVDLOfq1YQv/coAI94r
   ZOM50Jeg2aU7PZ/mbALyU4y1NmrhocopDWCFQ16zgmRCZ9apttW9Yk/8i
   gJq6IZ3LiCW5FgaTpKSQgeOBeQwZEsM1SoKgUBPH3M64SP3KULNsUDvXU
   s/W8xezoiwRb3nztzHQw2f7w42FVaA2IxiGu8242qaVIFd3b4g96q2P3A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="677922"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="677922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1033021"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:11:01 -0800
Message-ID: <1ff39c81-f207-480a-8169-85b273631594@intel.com>
Date: Mon, 5 Feb 2024 15:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] perf: script: add field 'disasm' to display
 mnemonic instructions
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240122112054.1576835-1-changbin.du@huawei.com>
 <20240122112054.1576835-4-changbin.du@huawei.com>
 <f8c1b042-2b65-4dd7-a692-79fead351e5a@intel.com>
 <20240205121938.sl4ykpk25lgxhgfj@M910t>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240205121938.sl4ykpk25lgxhgfj@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/02/24 14:19, Changbin Du wrote:
> On Mon, Feb 05, 2024 at 11:23:21AM +0200, Adrian Hunter wrote:
>> On 22/01/24 13:20, Changbin Du wrote:
>>> In addition to the 'insn' field, this adds a new field 'disasm' to
>>> display mnemonic instructions instead of the raw code.
>>>
>>> $ sudo perf script -F +disasm
>>>        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
>>>        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
>>>               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	movq %rsp, %rdi
>>>               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	callq _dl_start+0x0
>>>
>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>>
>>> ---
>>> v2:
>>>   - update Documentation.
>>> ---
>>>  tools/perf/Documentation/perf-script.txt | 13 +++++++------
>>>  tools/perf/builtin-script.c              |  8 +++++++-
>>>  2 files changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
>>> index ff9a52e44688..578fa59f51a5 100644
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
>>>          Field list can be prepended with the type, trace, sw or hw,
>>>          to indicate to which event type the field list applies.
>>>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
>>> @@ -217,9 +218,9 @@ OPTIONS
>>>  	Instruction Trace decoding. For calls and returns, it will display the
>>>  	name of the symbol indented with spaces to reflect the stack depth.
>>>  
>>> -	When doing instruction trace decoding insn and insnlen give the
>>> -	instruction bytes and the instruction length of the current
>>> -	instruction.
>>> +	When doing instruction trace decoding, insn, disasm and insnlen give the
>>> +	instruction bytes, disassembled instructions (requires libcapstone support)
>>> +	and the instruction length of the current instruction respectively.
>>>  
>>>  	The synth field is used by synthesized events which may be created when
>>>  	Instruction Trace decoding.
>>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>>> index 4817a37f16e2..4ac9670704ff 100644
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
>>> +		printed += fprintf(fp, "\t\t");
>>
>> This is good, except if both 'insn' and 'disasm' are used together.
>> It either:
>>  a) without libcapstone, prints insn bytes twice
>>
>> 	Probably simpler to make 'disasm' without libcapstone
>> 	a fatal error explaining that perf needs to be built
>> 	with libcapstone support for 'disasm' to work.
>>
> Instead of fatal error, I print a warning message for this. Because
> perf_sample__fprintf_insn() cannot return negtive error number.

It could be validated in advance, perhaps in parse_output_fields().

> 
>>  b) with libcapstone, disassembly does not line up nicely
>>
>  
> 


