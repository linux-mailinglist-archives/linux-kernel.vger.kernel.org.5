Return-Path: <linux-kernel+bounces-52289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8AB84965B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDCBB216E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5912B71;
	Mon,  5 Feb 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIrK+qNd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFE125BB;
	Mon,  5 Feb 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125007; cv=none; b=qiXC8Lwtgk1sQAKIJytcQf4n1TWwHgEDWYwwuU3cMUjCjprq4qK5nvJa6ZS5W/nPu79dO/mUshNl7A5Usp71+edbaQ8lbDMqescoqatoaEEIzMCpmA6mUDcYvLjt8kzNTH0E4mWmeGa5dwD6meFV01zQJaonGyNe0upsw0ohM7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125007; c=relaxed/simple;
	bh=ko6rApyixerLqoyBttIoaqJ9suv9OgBvHgI7V7WR3YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDsR4sxph2KoSWQA7zSfcbm5NPby3u9L20B+REJhBpDdpmgb69J2r0EGcwQZ/wH4MVJ+uP4B3D0SdfnctcQVbbgKc3SMQeqg+GYCldnbzBERHO2HLVMRnqHQzt3eGTboKQtN0w1NxkJs6vmdQCqqtsljtpAj2aJ6gIzl95GXiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIrK+qNd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707125005; x=1738661005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ko6rApyixerLqoyBttIoaqJ9suv9OgBvHgI7V7WR3YE=;
  b=RIrK+qNdUqiYfUqw22FoN2UuTpAL8OymCjA5qdcdkv04Ul3U76jWAAEp
   heTI2gpVUr5slYsexXjotCo+PALXCu1qv8W5oUFjBJOVXlMA86bYFqwEt
   VI9HKnyjbhhjziPfEekm4893UK22bBcRHWyn0EblwAK0AX47v4tJ3bT/J
   J2oblSJ2br4EwlUObuSTREtIRYuSHOXZk/lIM+wzRnoswSQRNxG9+tU6Y
   1wjziRwFjos6wWAbtfz9WLXBC8CeGg1aqOKPkRQFnfhszX98eMvAy/oRl
   5prCVhuuBCfii2uDVOERh/g7r/McavRi7tKzvOMxtIooZFK7jH1NA5NnQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="18010593"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="18010593"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:23:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="31765259"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 01:23:21 -0800
Message-ID: <f8c1b042-2b65-4dd7-a692-79fead351e5a@intel.com>
Date: Mon, 5 Feb 2024 11:23:21 +0200
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
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com
References: <20240122112054.1576835-1-changbin.du@huawei.com>
 <20240122112054.1576835-4-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240122112054.1576835-4-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/24 13:20, Changbin Du wrote:
> In addition to the 'insn' field, this adds a new field 'disasm' to
> display mnemonic instructions instead of the raw code.
> 
> $ sudo perf script -F +disasm
>        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
>        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
>               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	movq %rsp, %rdi
>               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	callq _dl_start+0x0
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> ---
> v2:
>   - update Documentation.
> ---
>  tools/perf/Documentation/perf-script.txt | 13 +++++++------
>  tools/perf/builtin-script.c              |  8 +++++++-
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index ff9a52e44688..578fa59f51a5 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -132,9 +132,10 @@ OPTIONS
>          Comma separated list of fields to print. Options are:
>          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
> -        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
> -        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> -        machine_pid, vcpu, cgroup, retire_lat.
> +        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, disasm,
> +        insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
> +        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
> +
>          Field list can be prepended with the type, trace, sw or hw,
>          to indicate to which event type the field list applies.
>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> @@ -217,9 +218,9 @@ OPTIONS
>  	Instruction Trace decoding. For calls and returns, it will display the
>  	name of the symbol indented with spaces to reflect the stack depth.
>  
> -	When doing instruction trace decoding insn and insnlen give the
> -	instruction bytes and the instruction length of the current
> -	instruction.
> +	When doing instruction trace decoding, insn, disasm and insnlen give the
> +	instruction bytes, disassembled instructions (requires libcapstone support)
> +	and the instruction length of the current instruction respectively.
>  
>  	The synth field is used by synthesized events which may be created when
>  	Instruction Trace decoding.
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4817a37f16e2..4ac9670704ff 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -135,6 +135,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_CGROUP          = 1ULL << 39,
>  	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
>  	PERF_OUTPUT_DSOFF           = 1ULL << 41,
> +	PERF_OUTPUT_DISASM          = 1ULL << 42,
>  };
>  
>  struct perf_script {
> @@ -190,6 +191,7 @@ struct output_option {
>  	{.str = "bpf-output",   .field = PERF_OUTPUT_BPF_OUTPUT},
>  	{.str = "callindent", .field = PERF_OUTPUT_CALLINDENT},
>  	{.str = "insn", .field = PERF_OUTPUT_INSN},
> +	{.str = "disasm", .field = PERF_OUTPUT_DISASM},
>  	{.str = "insnlen", .field = PERF_OUTPUT_INSNLEN},
>  	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
>  	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
> @@ -1515,6 +1517,10 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  		printed += fprintf(fp, " insn: ");
>  		printed += sample__fprintf_insn_raw(sample, fp);
>  	}
> +	if (PRINT_FIELD(DISASM) && sample->insn_len) {
> +		printed += fprintf(fp, "\t\t");

This is good, except if both 'insn' and 'disasm' are used together.
It either:
 a) without libcapstone, prints insn bytes twice

	Probably simpler to make 'disasm' without libcapstone
	a fatal error explaining that perf needs to be built
	with libcapstone support for 'disasm' to work.

 b) with libcapstone, disassembly does not line up nicely

> +		printed += sample__fprintf_insn(sample, thread, machine, fp);
> +	}
>  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
>  
> @@ -3900,7 +3906,7 @@ int cmd_script(int argc, const char **argv)
>  		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff,"
>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
>  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
> -		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
> +		     "brstackinsnlen,brstackoff,callindent,insn,disasm,insnlen,synth,"
>  		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
>  		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
>  		     parse_output_fields),


