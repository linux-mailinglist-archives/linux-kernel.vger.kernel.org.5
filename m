Return-Path: <linux-kernel+bounces-52502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A653F84990F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1884E1F20F15
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC31B7F2;
	Mon,  5 Feb 2024 11:42:17 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F61B5B2;
	Mon,  5 Feb 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133337; cv=none; b=MHkarTeu4GSvER9W15nIRVsskgN6gmcp0kq9s5W3kChSTEP7VgeCAdTecBUun+JkmAuZdK+NRqMl2g066I3qVoVSumIKLbxxAm2lwLVpdWYP9ll/qw/5g7aBvfEwTq8qmWa1CzBE+bJjDKCsNonMjDTy6ZNxTtSeERNYAI2iFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133337; c=relaxed/simple;
	bh=EshFlkhiftLg/bHBAsbRfzDaghSEmFcjRUNQjPQ4a7Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9rPlq15d4Sk3giu1e9YzLm9uqF6426rdAjtOCjQ1O2APXvBV4fbIutbPu1/XZXuhcD22jpVGD2sFHIh9Y6qwjCEMvRdgK6qkqQaE5MALCr5lT01xpfVyTx9aWvI4NnDfUHbEBqApajA6AwFCi8t+/7XjGktjB63TnTINkzqdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TT4Dw6Lv5z1Q8Mm;
	Mon,  5 Feb 2024 19:40:16 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 189471402E0;
	Mon,  5 Feb 2024 19:42:12 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 5 Feb
 2024 19:42:10 +0800
Date: Mon, 5 Feb 2024 19:41:53 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, Andi
 Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
	<changbin.du@gmail.com>
Subject: Re: [PATCH v5 3/5] perf: script: add field 'disasm' to display
 mnemonic instructions
Message-ID: <20240205114153.7y4hwxaiewql4gk5@M910t>
References: <20240122112054.1576835-1-changbin.du@huawei.com>
 <20240122112054.1576835-4-changbin.du@huawei.com>
 <f8c1b042-2b65-4dd7-a692-79fead351e5a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8c1b042-2b65-4dd7-a692-79fead351e5a@intel.com>
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Mon, Feb 05, 2024 at 11:23:21AM +0200, Adrian Hunter wrote:
> On 22/01/24 13:20, Changbin Du wrote:
> > In addition to the 'insn' field, this adds a new field 'disasm' to
> > display mnemonic instructions instead of the raw code.
> > 
> > $ sudo perf script -F +disasm
> >        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
> >        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
> >               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	movq %rsp, %rdi
> >               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)	callq _dl_start+0x0
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > 
> > ---
> > v2:
> >   - update Documentation.
> > ---
> >  tools/perf/Documentation/perf-script.txt | 13 +++++++------
> >  tools/perf/builtin-script.c              |  8 +++++++-
> >  2 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index ff9a52e44688..578fa59f51a5 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -132,9 +132,10 @@ OPTIONS
> >          Comma separated list of fields to print. Options are:
> >          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
> >          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
> > -        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
> > -        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> > -        machine_pid, vcpu, cgroup, retire_lat.
> > +        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, disasm,
> > +        insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
> > +        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
> > +
> >          Field list can be prepended with the type, trace, sw or hw,
> >          to indicate to which event type the field list applies.
> >          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> > @@ -217,9 +218,9 @@ OPTIONS
> >  	Instruction Trace decoding. For calls and returns, it will display the
> >  	name of the symbol indented with spaces to reflect the stack depth.
> >  
> > -	When doing instruction trace decoding insn and insnlen give the
> > -	instruction bytes and the instruction length of the current
> > -	instruction.
> > +	When doing instruction trace decoding, insn, disasm and insnlen give the
> > +	instruction bytes, disassembled instructions (requires libcapstone support)
> > +	and the instruction length of the current instruction respectively.
> >  
> >  	The synth field is used by synthesized events which may be created when
> >  	Instruction Trace decoding.
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 4817a37f16e2..4ac9670704ff 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -135,6 +135,7 @@ enum perf_output_field {
> >  	PERF_OUTPUT_CGROUP          = 1ULL << 39,
> >  	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
> >  	PERF_OUTPUT_DSOFF           = 1ULL << 41,
> > +	PERF_OUTPUT_DISASM          = 1ULL << 42,
> >  };
> >  
> >  struct perf_script {
> > @@ -190,6 +191,7 @@ struct output_option {
> >  	{.str = "bpf-output",   .field = PERF_OUTPUT_BPF_OUTPUT},
> >  	{.str = "callindent", .field = PERF_OUTPUT_CALLINDENT},
> >  	{.str = "insn", .field = PERF_OUTPUT_INSN},
> > +	{.str = "disasm", .field = PERF_OUTPUT_DISASM},
> >  	{.str = "insnlen", .field = PERF_OUTPUT_INSNLEN},
> >  	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
> >  	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
> > @@ -1515,6 +1517,10 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
> >  		printed += fprintf(fp, " insn: ");
> >  		printed += sample__fprintf_insn_raw(sample, fp);
> >  	}
> > +	if (PRINT_FIELD(DISASM) && sample->insn_len) {
> > +		printed += fprintf(fp, "\t\t");
> 
> This is good, except if both 'insn' and 'disasm' are used together.
> It either:
>  a) without libcapstone, prints insn bytes twice
>
> 	Probably simpler to make 'disasm' without libcapstone
> 	a fatal error explaining that perf needs to be built
> 	with libcapstone support for 'disasm' to work.
> 
>  b) with libcapstone, disassembly does not line up nicely
>
I prefer to #a which is simpler. I'll rename sample__fprintf_insn() to
sample__fprintf_insn_asm() wihtout fallback to raw version.

> > +		printed += sample__fprintf_insn(sample, thread, machine, fp);
> > +	}
> >  	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
> >  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
> >  
> > @@ -3900,7 +3906,7 @@ int cmd_script(int argc, const char **argv)
> >  		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff,"
> >  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
> >  		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
> > -		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
> > +		     "brstackinsnlen,brstackoff,callindent,insn,disasm,insnlen,synth,"
> >  		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
> >  		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat",
> >  		     parse_output_fields),
> 

-- 
Cheers,
Changbin Du

