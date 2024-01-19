Return-Path: <linux-kernel+bounces-31502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41AA832F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3605288146
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100BC537E2;
	Fri, 19 Jan 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtCjUuuu"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A82E3E1;
	Fri, 19 Jan 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689630; cv=none; b=obEEkLPDzW8h28J6U8n5KxuM3UwH6gwF9q/VXXaGRxUb10r29BWoVf1j8ETm40KHpZbKrpoDORnZufuTgx14Bd7FDyPdPbSy6EOCETIOFsG04DxTZaCKvJaxlQS5sIZCgKkV4VgvF8cUmqRQiXreFoAu4DAOt4i8aH2XUarqwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689630; c=relaxed/simple;
	bh=5m8msFh7nqEp42yc2uI9YbR41y1ZDp/mYMLA7+pSIh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2JhTTBOLDByGP8VS0fv6J8MzGeKPPcSKu1n9XA3DTgBCGID2fDrwQsb5WlxnnIqyno6BpG7jCeFkECIAXS3TOo97K9mF3THM9n7s4T0XmZ93LGWq0U79kqSHdZ13MpTPjQuImI0SR9aksyUd76hL8tNIt88enETwKE9d5eJwxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtCjUuuu; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705689628; x=1737225628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5m8msFh7nqEp42yc2uI9YbR41y1ZDp/mYMLA7+pSIh4=;
  b=VtCjUuuumnabo0D4sw76qB7bpKdMFSjra9SjHGj57YZs2SaCIz+0KbKj
   uYXQBrV/SgM6zDWtR3HRg1g37CIAnUP6j3xs52+IJh92Y0KSCcvpiyTLv
   8UNraakU/AM0SoHBOsyqkxXRJb1kLbPld4fvA2/h8FFvAddvUx8O7u8ll
   lxIubM4TPb1PKpABpBk79emJLKeF+BDcKRrZ9Xs/6/Nrzc7lQivyxYNnh
   H1fywR8Z2BOS3GoxO1PPp7MSAU1qllLzbxT6PNp8zg9X+nRIWN8zRNAYK
   ioFsoSInPXKrlmD3mlli3CFPQIn2Km966MKY+62xB4qbv9Yh4sGfVg2el
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="404578946"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="404578946"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:40:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="778042862"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="778042862"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.208])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:40:23 -0800
Message-ID: <adb07ef9-4609-4cb4-b5e4-8e0af00bac16@intel.com>
Date: Fri, 19 Jan 2024 20:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] perf: script: prefer capstone to XED
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
 <20240119104856.3617986-6-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240119104856.3617986-6-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/24 12:48, Changbin Du wrote:
> Now perf can show assembly instructions with libcapstone for x86, and the
> capstone is better in general.
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/Documentation/perf-intel-pt.txt | 11 +++++------
>  tools/perf/ui/browsers/res_sample.c        |  2 +-
>  tools/perf/ui/browsers/scripts.c           |  2 +-
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index 2109690b0d5f..8e62f23f7178 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -115,9 +115,8 @@ toggle respectively.
>  
>  perf script also supports higher level ways to dump instruction traces:
>  
> -	perf script --insn-trace --xed
> +	perf script --insn-trace=disasm

Please add also:

or to use the xed disassembler, which requires installing the xed tool
(see XED below):

	perf script --insn-trace --xed

>  
> -Dump all instructions. This requires installing the xed tool (see XED below)
>  Dumping all instructions in a long trace can be fairly slow. It is usually better
>  to start with higher level decoding, like
>  
> @@ -130,12 +129,12 @@ or
>  and then select a time range of interest. The time range can then be examined
>  in detail with
>  
> -	perf script --time starttime,stoptime --insn-trace --xed
> +	perf script --time starttime,stoptime --insn-trace=disasm
>  
>  While examining the trace it's also useful to filter on specific CPUs using
>  the -C option
>  
> -	perf script --time starttime,stoptime --insn-trace --xed -C 1
> +	perf script --time starttime,stoptime --insn-trace=disasm -C 1
>  
>  Dump all instructions in time range on CPU 1.
>  
> @@ -1306,7 +1305,7 @@ Without timestamps, --per-thread must be specified to distinguish threads.
>  
>  perf script can be used to provide an instruction trace
>  
> - $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
> + $ perf script --guestkallsyms $KALLSYMS --insn-trace=disasm -F+ipc | grep -C10 vmresume | head -21
>         CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
>         CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
>         CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
> @@ -1407,7 +1406,7 @@ There were none.
>  
>  'perf script' can be used to provide an instruction trace showing timestamps
>  
> - $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
> + $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace=disasm -F+ipc | grep -C10 vmresume | head -21
>         CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
>         CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
>         CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
> diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
> index 7cb2d6678039..1022baefaf45 100644
> --- a/tools/perf/ui/browsers/res_sample.c
> +++ b/tools/perf/ui/browsers/res_sample.c
> @@ -83,7 +83,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
>  		     r->tid ? "--tid " : "",
>  		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
>  		     extra_format,
> -		     rstype == A_ASM ? "-F +insn --xed" :
> +		     rstype == A_ASM ? "-F +insn_disasm" :

insn_disasm -> disasm

>  		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
>  		     symbol_conf.inline_name ? "--inline" : "",
>  		     "--show-lost-events ",
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index 47d2c7a8cbe1..3efc76c621c4 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -107,7 +107,7 @@ static int list_scripts(char *script_name, bool *custom,
>  	if (evsel)
>  		attr_to_script(scriptc.extra_format, &evsel->core.attr);
>  	add_script_option("Show individual samples", "", &scriptc);
> -	add_script_option("Show individual samples with assembler", "-F +insn --xed",
> +	add_script_option("Show individual samples with assembler", "-F +insn_disasm",

insn_disasm -> disasm

>  			  &scriptc);
>  	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
>  			  &scriptc);


