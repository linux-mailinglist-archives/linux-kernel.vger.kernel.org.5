Return-Path: <linux-kernel+bounces-54837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EF84B441
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F45B24E81
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0194E135A69;
	Tue,  6 Feb 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1SKcg6/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846C135A5C;
	Tue,  6 Feb 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220202; cv=none; b=nAOmutOK180aDA2uvYPYg3LVWnZBH0rHtakxxZKIYi+X/fc2TbggeO9OKlx8CSsl5kohX6wMpNfA281C7UtzN8g2P2gZmEMNj8sGLfvCxQEsqEPQb/63Zw6gi9gsfuSGoul3BAU/96yboZ2ufSerPUHrrMbtwl7nLKb1uxMsKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220202; c=relaxed/simple;
	bh=JY/ecKxpqcoskN4SO4DbU7pB525Tsjxkek4gM3Dptkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7Bjm9XaWqMdYRYOFPqpF+Lleirdgfb9UrHJ3B0XjUku+wLrJ3c+JBqTW+UxxSnUIzpJ10aNg+FT8NNvi7PBccFHIB6fwSxf/ojGH+mxWte+BzYt263KlXSK9UORX9JhYJQlyEXbWgqjJbA5+LCti3GSs4PXqI7K71kS8Kr0iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1SKcg6/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707220200; x=1738756200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JY/ecKxpqcoskN4SO4DbU7pB525Tsjxkek4gM3Dptkg=;
  b=h1SKcg6/GRaDMl4Wo2NV3MR3c98emlsqaaFEeZ+POr62NQzjM7U3Apz0
   dTEI0DsQSai2CupKkpJsdlArybh52a6ywv0nEmAAl1d+Ez48zCL1v/hth
   5xwCrXT+L1GvR26qaD1M5F3BhOyd7RQjigiv54CFADEc1mJ6ccEyhVSN2
   wLTt9pyyXIJ+xjNKN4hjJVc7c6NptPYimEdUL3Som2ahI0Qfr8ygST6cN
   aKC33sff5NtKxONbHnCANwK81E3QXutSM0wq0czt9fxNvPPUdqZazJ05e
   ColPQlj+u+UyKKgTqwYnaAL52vO0nW22R9j+5UFnPiLBUgw0Lkxme/+KO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11375334"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11375334"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1232790"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.101])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:49:50 -0800
Message-ID: <bd5ed9b2-cbb7-4b8b-b7b8-5db2eff75f17@intel.com>
Date: Tue, 6 Feb 2024 13:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] perf: script: Intro capstone disasm engine to show
 instruction trace
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
References: <20240206112929.1035548-1-changbin.du@huawei.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240206112929.1035548-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/02/24 13:29, Changbin Du wrote:
> This series introduces capstone disassembler engine to print instructions of
> Intel PT trace, which was printed via the XED tool.
> 
> The advantages compared to XED tool:
>     * Support arm, arm64, x86-32, x86_64, s390 (more could be supported),
>       xed only for x86_64.
>     * More friendly to read. Immediate address operands are shown as symbol+offs.
> 
> Display raw instructions:
>     $ sudo perf record --event intel_pt//u -- ls
>     $ sudo perf script --insn-trace
>                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 48 3d 01 f0 ff ff
>                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so) insn: 73 01
>                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so) insn: c3
>                 perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf) insn: 85 c0
>                 perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf) insn: 75 12
>                 perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf) insn: 49 8b 84 24 a8 00 00 00
>                 perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf) insn: 48 8b 50 20
> 
> Display mnemonic instructions:
>     $ sudo perf script --insn-trace=disasm
>                 perf 17423 [000] 423271.557970005:      7f2d95f16217 __GI___ioctl+0x7 (/lib/x86_64-linux-gnu/libc-2.27.so)		cmpq $-0xfff, %rax
>                 perf 17423 [000] 423271.557970005:      7f2d95f1621d __GI___ioctl+0xd (/lib/x86_64-linux-gnu/libc-2.27.so)		jae __GI___ioctl+0x10
>                 perf 17423 [000] 423271.557970338:      7f2d95f1621f __GI___ioctl+0xf (/lib/x86_64-linux-gnu/libc-2.27.so)		retq
>                 perf 17423 [000] 423271.557970338:      5593ad3346d7 perf_evsel__enable_cpu+0x97 (/work/linux/tools/perf/perf)		testl %eax, %eax
>                 perf 17423 [000] 423271.557970338:      5593ad3346d9 perf_evsel__enable_cpu+0x99 (/work/linux/tools/perf/perf)		jne perf_evsel__enable_cpu+0xad
>                 perf 17423 [000] 423271.557970338:      5593ad3346db perf_evsel__enable_cpu+0x9b (/work/linux/tools/perf/perf)		movq 0xa8(%r12), %rax
>                 perf 17423 [000] 423271.557970338:      5593ad3346e3 perf_evsel__enable_cpu+0xa3 (/work/linux/tools/perf/perf)		movq 0x20(%rax), %rdx
>                 perf 17423 [000] 423271.557970338:      5593ad3346e7 perf_evsel__enable_cpu+0xa7 (/work/linux/tools/perf/perf)		cmpl %edx, %ebx
>                 perf 17423 [000] 423271.557970338:      5593ad3346e9 perf_evsel__enable_cpu+0xa9 (/work/linux/tools/perf/perf)		jl perf_evsel__enable_cpu+0x60
>                 perf 17423 [000] 423271.557970338:      5593ad3346eb perf_evsel__enable_cpu+0xab (/work/linux/tools/perf/perf)		xorl %eax, %eax
> 
> v7:
>   - remove redundant space for raw instruction.
>   - rename sample__fprintf_insn() as sample__fprintf_insn_asm() and make it empty if libcapstone is not available.
> v6:
>   - make '-F +disasm' fatal if libcapstone is not supported. (Adrian Hunter)
>   - display with perf version --build-options. (Adrian Hunter)
>   - exclude libcapstone from make_minimal. (Adrian Hunter)
> v5:
>   - fixes and improments suggested by Adrian Hunter
> v4:
>   - rename 'insn_disam' to 'disasm' (Adrian Hunter)
> v3:
>   - fix s390 detection. (Thomas Richter)
> v2:
>   - add a new field 'insn_disam' instead of changing the default output.
>   - preserve the old --xed option.
> 
> Changbin Du (5):
>   perf: build: introduce the libcapstone
>   perf: util: use capstone disasm engine to show assembly instructions
>   perf: script: add field 'disasm' to display mnemonic instructions
>   perf: script: add raw|disasm arguments to --insn-trace option
>   perf: script: prefer capstone to XED
> 
>  tools/build/Makefile.feature               |   2 +
>  tools/build/feature/Makefile               |   4 +
>  tools/build/feature/test-all.c             |   4 +
>  tools/build/feature/test-libcapstone.c     |  11 ++
>  tools/perf/Documentation/perf-intel-pt.txt |  14 ++-
>  tools/perf/Documentation/perf-script.txt   |  20 +--
>  tools/perf/Makefile.config                 |  21 ++++
>  tools/perf/Makefile.perf                   |   3 +
>  tools/perf/builtin-script.c                |  45 +++++--
>  tools/perf/builtin-version.c               |   1 +
>  tools/perf/tests/make                      |   4 +-
>  tools/perf/ui/browsers/res_sample.c        |   2 +-
>  tools/perf/ui/browsers/scripts.c           |   2 +-
>  tools/perf/util/Build                      |   1 +
>  tools/perf/util/print_insn.c               | 135 +++++++++++++++++++++
>  tools/perf/util/print_insn.h               |  16 +++
>  16 files changed, 258 insertions(+), 27 deletions(-)
>  create mode 100644 tools/build/feature/test-libcapstone.c
>  create mode 100644 tools/perf/util/print_insn.c
>  create mode 100644 tools/perf/util/print_insn.h
> 

For whole patch set:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>


