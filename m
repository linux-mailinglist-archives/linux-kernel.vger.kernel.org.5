Return-Path: <linux-kernel+bounces-31500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F5B832F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C64B24682
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98E55E63;
	Fri, 19 Jan 2024 18:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E14T+hQh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FCE54BDC;
	Fri, 19 Jan 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689586; cv=none; b=pOds1UQF0PmrBpOUOOI7pJjiKYf3/K43+BRBdZdkRysQCwspJMHt8CeJlfacYWVlJgptkp6sBDJTG2oOwKdBnkPgTRCVyJbY5E3luQWnkD8UD5IvbNNSh1BlWx5K6MPkceZx8L++cXbUmMLSCwcBRklXYzGjk6usr6jTBRrd/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689586; c=relaxed/simple;
	bh=rMsgSzeEDymn7q6KcngVvG3bqG6DLe88XdjShmFT6Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU4rgifY/At2DQ2RAdZGA6nVbELbaHReAiyykMvW0+JHm4TDrNu+DG5lBDEv/s41DDnfC6pyTmwO11UZ1ow/aunCYxZVyJuq/5r9nHRLS+tzn4WvHBpJ7s+Ybj+WJCb6sMLF+lpRdgoOK3UK7yBhvfIIqrdr6UaoKHMkk/fcMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E14T+hQh; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705689585; x=1737225585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rMsgSzeEDymn7q6KcngVvG3bqG6DLe88XdjShmFT6Ms=;
  b=E14T+hQh7P/kFm2QhHvgVNTJECMy5qXO3k4vwT5vKqFBBnAlBo8LOHwn
   6HXiSMev/a3XOE5FZzZu4VoBRGjnv5TI691pxuxuRedld91QISN8+6l61
   a/7ohm/iA9GlDfDnd2JfkN+7+30LIsrUc8kS8XYzTlXu/orxJUk+jta5M
   rzKl3fEYtJAfMRQkrl8UGLiU/o8sACwXFKSjy12j3kJAMJcs57wI8DDYR
   16seJfuBzBP92i1uCFquABwZMKgEZIsNJ2D4V6lpNR1SAvCBAJc79gJBY
   ASe1ps6OTtvkxpo6U41B3G4bBtzSlaayfLLfDMmDFAgXk0BMsqsSzOfpf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="404578828"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="404578828"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:39:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="778042534"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778042534"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:39:39 -0800
Message-ID: <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
Date: Fri, 19 Jan 2024 20:39:36 +0200
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
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240119104856.3617986-4-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/24 12:48, Changbin Du wrote:
> In addition to the 'insn' field, this adds a new field 'disasm' to
> display mnemonic instructions instead of the raw code.
> 
> $ sudo perf script -F +disasm
>        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
>        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
>               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
>               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 7 ++++---
>  tools/perf/builtin-script.c              | 8 +++++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index ff9a52e44688..fc79167c6bf8 100644
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

Further down, there are explanations for insn and insnlen.  disasm
could be added there.

>          Field list can be prepended with the type, trace, sw or hw,
>          to indicate to which event type the field list applies.
>          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 4817a37f16e2..12d886694f6c 100644
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
> +		printed += fprintf(fp, " insn: ");
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


