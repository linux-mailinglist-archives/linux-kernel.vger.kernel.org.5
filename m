Return-Path: <linux-kernel+bounces-31501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BC832F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF601F2739F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7F56744;
	Fri, 19 Jan 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJQ0KhC9"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0915646F;
	Fri, 19 Jan 2024 18:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689599; cv=none; b=jOf/wLCcxYjg+1rl/v/4TnGmlz59R5YfLV/9RdK1VCtozswu0XxgwIeF4arOc9XdYUW0jqnl4xUnvtuixRTpKRibpfp1wUIzTa/2gVlPEjqFs/qv34JBsFaV6VLNfgUbetUx8PAfdBTQmVB9/zIvC4c5XL0O8hzZiD3HuBqYmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689599; c=relaxed/simple;
	bh=GmTo+zo9MZvforZe7zyJqxYLUpq1eO507+/j5BlBDtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGZHw0wzipqHhmtqboBWcJRC2M5eOOGi1j0+QPC2Ccgn2a8EdcWkpwQuysH/+quEwnzZ56asBHmBESqcHO7qXaXAo1uH6VnRRZUbI50/HGEHa2vWZ+BAzkp8p62pPWOweGkp23zeelKlUJ9dMu2fhhFXIegkwtJ+jfIqZfD31YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJQ0KhC9; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705689598; x=1737225598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GmTo+zo9MZvforZe7zyJqxYLUpq1eO507+/j5BlBDtw=;
  b=nJQ0KhC91cHjRIdiFuKRQ5H+ehLGKTj/jVGiKV8DtMdt72cqIIvSNfe8
   13l0RtcgwCB7FkSPGwbp1/STQ6TeAGpHEN3RIabaK28qpHJRSaI224sXy
   ZPIHIO3lyP7kjX34oLU6JagIV1fAN+hTwTWQdLI27o4xygzJgm8rNJo5A
   pqRPDqIes7FbORTJmanbnHcvJW6otf2twRSCbhBltau5y9vKszEXv8PWv
   jCJ+zeAhVaqQczOOyIiSfa32AUK7vAvnv6pATayxjzg2VrH/6OihahWFD
   dUAkJZaPNNo3xJ8Wobu5FxFQUOWa1VyTSCRRga2PUlJ5P9C+4kfl8m3UK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="404578894"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="404578894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:39:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="778042597"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778042597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:39:53 -0800
Message-ID: <dea4ffb9-9442-4b5a-bf1c-73a7fe6652d9@intel.com>
Date: Fri, 19 Jan 2024 20:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] perf: script: add raw|disasm arguments to
 --insn-trace option
Content-Language: en-US
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-5-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240119104856.3617986-5-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/24 12:48, Changbin Du wrote:
> Now '--insn-trace' accept a argument to specify the output format:
>   - raw: display raw instructions.
>   - disasm: display mnemonic instructions (if capstone is installed).
> 
> $ sudo perf script --insn-trace=raw
>               ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: 48 89 e7
>               ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: e8 e8 0c 00 00
>               ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: f3 0f 1e fa
> 
> $ sudo perf script --insn-trace=disasm
>               ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
>               ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
>               ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: illegal instruction
>               ls 1443864 [006] 2275506.209908875:      7f216b426df4 _dl_start+0x4 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: pushq %rbp
>               ls 1443864 [006] 2275506.209908875:      7f216b426df5 _dl_start+0x5 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rbp
>               ls 1443864 [006] 2275506.209908875:      7f216b426df8 _dl_start+0x8 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: pushq %r15
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-script.txt |  6 +++---
>  tools/perf/builtin-script.c              | 17 +++++++++++++----
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index fc79167c6bf8..9ae54f5bcb4d 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -442,9 +442,9 @@ include::itrace.txt[]
>  	will be printed. Each entry has function name and file/line. Enabled by
>  	default, disable with --no-inline.
>  
> ---insn-trace::
> -	Show instruction stream for intel_pt traces. Combine with --xed to
> -	show disassembly.
> +--insn-trace[=<raw|disasm>]::
> +	Show raw or mnemonic instruction stream for intel_pt traces. You can
> +	also combine raw instructions with --xed to show disassembly.

Perhaps this is a bit clearer:

Show instruction stream in bytes (raw) or disassembled (disasm)
for intel_pt traces. The default is 'raw'. To use xed, combine
'raw' with --xed to show disassembly done by xed.

>  
>  --xed::
>  	Run xed disassembler on output. Requires installing the xed disassembler.
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 12d886694f6c..2e3752b3b65a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3769,10 +3769,19 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
>  #endif
>  
>  static int parse_insn_trace(const struct option *opt __maybe_unused,
> -			    const char *str __maybe_unused,
> -			    int unset __maybe_unused)
> +			    const char *str, int unset __maybe_unused)
>  {
> -	parse_output_fields(NULL, "+insn,-event,-period", 0);
> +	const char *fields = "+insn,-event,-period";
> +
> +	if (str) {
> +		if (strcmp(str, "disasm") == 0)
> +			fields = "+disasm,-event,-period";
> +		else if (strlen(str) != 0 && strcmp(str, "raw") != 0) {
> +			fprintf(stderr, "Only accept raw|disasm\n");
> +			return -EINVAL;
> +		}
> +	}
> +	parse_output_fields(NULL, fields, 0);
>  	itrace_parse_synth_opts(opt, "i0ns", 0);
>  	symbol_conf.nanosecs = true;
>  	return 0;
> @@ -3918,7 +3927,7 @@ int cmd_script(int argc, const char **argv)
>  		   "only consider these symbols"),
>  	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
>  		    "Use with -S to list traced records within address range"),
> -	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
> +	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, "raw|disasm",
>  			"Decode instructions from itrace", parse_insn_trace),
>  	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
>  			"Run xed disassembler on output", parse_xed),


