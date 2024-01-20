Return-Path: <linux-kernel+bounces-31734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D1283331A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9227B283D40
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE192106;
	Sat, 20 Jan 2024 07:26:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6520E0;
	Sat, 20 Jan 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705735613; cv=none; b=ANKs0X0RovSSi+lntaRL82uIBTw+K0fb+G+vWxRgIX4iL3LRIasnixgq46cdT7FgEUjWIZ7HddBe8Dnp/cRiz/vT+2vb8O/Kk3y2dkMb45hfYKevpkk8HpEJgGbwILtBNuAIPrtQmAa3ZalZTpbV18GotnuB+ZLt22touB5w5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705735613; c=relaxed/simple;
	bh=fDiS5PJVy3c8YgT3PhH7ahy/iTnk+XRxlziL/RLR5Vs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkxPOw4y83+Ejj9fv6gMAGKt79sOjen/tqzVjcfDt4aYNTEYF8Vf2zZUzwNAPYaITwqns7gEu3D0ASD50g4zuCkuhhhYxIp6DImOccbYvIxXq04HrsP/ZN1EhUl1vxugSWWCjIAIwTLSleN3SQUkSmjmO3wMzH/xV4pwJs7cGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TH7Lb157rzXgVq;
	Sat, 20 Jan 2024 15:25:43 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 398FB18005D;
	Sat, 20 Jan 2024 15:26:49 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 20 Jan
 2024 15:26:47 +0800
Date: Sat, 20 Jan 2024 15:26:37 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>
Subject: Re: [PATCH v4 5/5] perf: script: prefer capstone to XED
Message-ID: <20240120072637.w6stvbdeynppnfa6@M910t>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-6-changbin.du@huawei.com>
 <adb07ef9-4609-4cb4-b5e4-8e0af00bac16@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <adb07ef9-4609-4cb4-b5e4-8e0af00bac16@intel.com>
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Fri, Jan 19, 2024 at 08:40:20PM +0200, Adrian Hunter wrote:
> On 19/01/24 12:48, Changbin Du wrote:
> > Now perf can show assembly instructions with libcapstone for x86, and the
> > capstone is better in general.
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/Documentation/perf-intel-pt.txt | 11 +++++------
> >  tools/perf/ui/browsers/res_sample.c        |  2 +-
> >  tools/perf/ui/browsers/scripts.c           |  2 +-
> >  3 files changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> > index 2109690b0d5f..8e62f23f7178 100644
> > --- a/tools/perf/Documentation/perf-intel-pt.txt
> > +++ b/tools/perf/Documentation/perf-intel-pt.txt
> > @@ -115,9 +115,8 @@ toggle respectively.
> >  
> >  perf script also supports higher level ways to dump instruction traces:
> >  
> > -	perf script --insn-trace --xed
> > +	perf script --insn-trace=disasm
> 
> Please add also:
> 
> or to use the xed disassembler, which requires installing the xed tool
> (see XED below):
> 
> 	perf script --insn-trace --xed
>
Added, thanks.

> >  
> > -Dump all instructions. This requires installing the xed tool (see XED below)
> >  Dumping all instructions in a long trace can be fairly slow. It is usually better
> >  to start with higher level decoding, like
> >  
> > @@ -130,12 +129,12 @@ or
> >  and then select a time range of interest. The time range can then be examined
> >  in detail with
> >  
> > -	perf script --time starttime,stoptime --insn-trace --xed
> > +	perf script --time starttime,stoptime --insn-trace=disasm
> >  
> >  While examining the trace it's also useful to filter on specific CPUs using
> >  the -C option
> >  
> > -	perf script --time starttime,stoptime --insn-trace --xed -C 1
> > +	perf script --time starttime,stoptime --insn-trace=disasm -C 1
> >  
> >  Dump all instructions in time range on CPU 1.
> >  
> > @@ -1306,7 +1305,7 @@ Without timestamps, --per-thread must be specified to distinguish threads.
> >  
> >  perf script can be used to provide an instruction trace
> >  
> > - $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
> > + $ perf script --guestkallsyms $KALLSYMS --insn-trace=disasm -F+ipc | grep -C10 vmresume | head -21
> >         CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
> >         CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
> >         CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
> > @@ -1407,7 +1406,7 @@ There were none.
> >  
> >  'perf script' can be used to provide an instruction trace showing timestamps
> >  
> > - $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
> > + $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace=disasm -F+ipc | grep -C10 vmresume | head -21
> >         CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
> >         CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
> >         CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
> > diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> > index 7cb2d6678039..1022baefaf45 100644
> > --- a/tools/perf/ui/browsers/res_sample.c
> > +++ b/tools/perf/ui/browsers/res_sample.c
> > @@ -83,7 +83,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
> >  		     r->tid ? "--tid " : "",
> >  		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
> >  		     extra_format,
> > -		     rstype == A_ASM ? "-F +insn --xed" :
> > +		     rstype == A_ASM ? "-F +insn_disasm" :
> 
> insn_disasm -> disasm
>
Fixed. I forgot to commit this change for last version.

> >  		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
> >  		     symbol_conf.inline_name ? "--inline" : "",
> >  		     "--show-lost-events ",
> > diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> > index 47d2c7a8cbe1..3efc76c621c4 100644
> > --- a/tools/perf/ui/browsers/scripts.c
> > +++ b/tools/perf/ui/browsers/scripts.c
> > @@ -107,7 +107,7 @@ static int list_scripts(char *script_name, bool *custom,
> >  	if (evsel)
> >  		attr_to_script(scriptc.extra_format, &evsel->core.attr);
> >  	add_script_option("Show individual samples", "", &scriptc);
> > -	add_script_option("Show individual samples with assembler", "-F +insn --xed",
> > +	add_script_option("Show individual samples with assembler", "-F +insn_disasm",
> 
> insn_disasm -> disasm
>
Fixed.

> >  			  &scriptc);
> >  	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
> >  			  &scriptc);
> 

-- 
Cheers,
Changbin Du

