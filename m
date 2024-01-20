Return-Path: <linux-kernel+bounces-31738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC3833324
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A7F2847B1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF52117;
	Sat, 20 Jan 2024 07:40:34 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3520E0;
	Sat, 20 Jan 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705736433; cv=none; b=f8DDH6DT1kr40E90IMvalCOPgy8OIox8kZ0c6W+IeyLS5w3p261XG7ERHYsN/Eol8N2pxKa+PNfVH8vwaSuUvAd8q2OwC5OuaGYJ0Py5F2zFe/pt9M24mVEE+OKdcMprip8SZ2n4dKJTIH5pG0TSRd7SBDx7iLnBa/7R1URAst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705736433; c=relaxed/simple;
	bh=DK3ghbFPsHGabBYFt8kKgAMXO/QN31xOrKeG8qgEeFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNha4N4/c+HvlHNgIIjMG43l0fUv7hCpudxMUpTVJNzTcv2ctwKSAHj7oTMpbxCBMG54sviy1xbbAQ4t+q7JCRwa5FopaNEBdRTzRB3UCv3y2a/ryWjM84OGnwP78eJOTow21bsJh1IKxdIJ1JITfQlMybE2iLs1IFrQjvKgiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TH7fM2sNgz1Q84y;
	Sat, 20 Jan 2024 15:39:23 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id A89DA140390;
	Sat, 20 Jan 2024 15:40:20 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 20 Jan
 2024 15:40:19 +0800
Date: Sat, 20 Jan 2024 15:40:09 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo
 Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 3/5] perf: script: add field 'disasm' to display
 mnemonic instructions
Message-ID: <20240120074009.zmywqj6irtedivqk@M910t>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-4-changbin.du@huawei.com>
 <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Fri, Jan 19, 2024 at 08:39:36PM +0200, Adrian Hunter wrote:
> On 19/01/24 12:48, Changbin Du wrote:
> > In addition to the 'insn' field, this adds a new field 'disasm' to
> > display mnemonic instructions instead of the raw code.
> > 
> > $ sudo perf script -F +disasm
> >        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
> >        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
> >               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
> >               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/Documentation/perf-script.txt | 7 ++++---
> >  tools/perf/builtin-script.c              | 8 +++++++-
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index ff9a52e44688..fc79167c6bf8 100644
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
> 
> Further down, there are explanations for insn and insnlen.  disasm
> could be added there.
> 
Updated as:

	When doing instruction trace decoding, insn, disasm and insnlen give the
	instruction bytes, disassembled instructions and the instruction length
	of the current instruction respectively.

> >          Field list can be prepended with the type, trace, sw or hw,
> >          to indicate to which event type the field list applies.
> >          e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 4817a37f16e2..12d886694f6c 100644
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
> > +		printed += fprintf(fp, " insn: ");
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

