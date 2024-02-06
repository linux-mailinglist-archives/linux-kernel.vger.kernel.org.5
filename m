Return-Path: <linux-kernel+bounces-54176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEBE84ABDC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EBF1F22024
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D05676A;
	Tue,  6 Feb 2024 02:01:21 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94656766;
	Tue,  6 Feb 2024 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184881; cv=none; b=uO7Dp1GjDRxNz1MHpboN95pV/Q7SGvoAAvRStUAcDTSUyHTCw8v4iZf3aWVpPc8LSrhRi8aQ1Js0hjJRL1LQxXUgNkKTyfakMEwSGtArYpbzKXAyqbelIxs4HFdfopxW63hP/xNPDpiYXnpXtevLivLJOjQ10rEjBeC+AwQul+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184881; c=relaxed/simple;
	bh=g2gs+PLoG8TO2j1dfjrzwjYBnkJkfG+zCzc2b+8IHT8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpoA+aBNOVEapxw2c+VgrWWNMMMAGixuMIb5u0Iqpc5yYa4ZLomyNUq7+oHWdqsFVH8UVUluCCd1AoiQ8iou0YWXisTAYJSZmJwaRCDB8aZa/Q6VGK+v6xwgvpz2JDrvbWMJ7s/DnuZFs1GvrUYqRp9f5QgvV+eUfOPC+1jn2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTRJ85pd4z29lLK;
	Tue,  6 Feb 2024 09:59:20 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A51E140382;
	Tue,  6 Feb 2024 10:01:16 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Tue, 6 Feb
 2024 10:01:14 +0800
Date: Tue, 6 Feb 2024 10:00:56 +0800
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
Message-ID: <20240206020056.tpy2c6ycok4podjd@M910t>
References: <20240122112054.1576835-1-changbin.du@huawei.com>
 <20240122112054.1576835-4-changbin.du@huawei.com>
 <f8c1b042-2b65-4dd7-a692-79fead351e5a@intel.com>
 <20240205121938.sl4ykpk25lgxhgfj@M910t>
 <1ff39c81-f207-480a-8169-85b273631594@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ff39c81-f207-480a-8169-85b273631594@intel.com>
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Mon, Feb 05, 2024 at 03:10:58PM +0200, Adrian Hunter wrote:
> On 5/02/24 14:19, Changbin Du wrote:
> > On Mon, Feb 05, 2024 at 11:23:21AM +0200, Adrian Hunter wrote:
> >>>  struct perf_script {
> >>> @@ -190,6 +191,7 @@ struct output_option {
> >>>  	{.str = "bpf-output",   .field = PERF_OUTPUT_BPF_OUTPUT},
> >>>  	{.str = "callindent", .field = PERF_OUTPUT_CALLINDENT},
> >>>  	{.str = "insn", .field = PERF_OUTPUT_INSN},
> >>> +	{.str = "disasm", .field = PERF_OUTPUT_DISASM},
> >>>  	{.str = "insnlen", .field = PERF_OUTPUT_INSNLEN},
> >>>  	{.str = "brstackinsn", .field = PERF_OUTPUT_BRSTACKINSN},
> >>>  	{.str = "brstackoff", .field = PERF_OUTPUT_BRSTACKOFF},
> >>> @@ -1515,6 +1517,10 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
> >>>  		printed += fprintf(fp, " insn: ");
> >>>  		printed += sample__fprintf_insn_raw(sample, fp);
> >>>  	}
> >>> +	if (PRINT_FIELD(DISASM) && sample->insn_len) {
> >>> +		printed += fprintf(fp, "\t\t");
> >>
> >> This is good, except if both 'insn' and 'disasm' are used together.
> >> It either:
> >>  a) without libcapstone, prints insn bytes twice
> >>
> >> 	Probably simpler to make 'disasm' without libcapstone
> >> 	a fatal error explaining that perf needs to be built
> >> 	with libcapstone support for 'disasm' to work.
> >>
> > Instead of fatal error, I print a warning message for this. Because
> > perf_sample__fprintf_insn() cannot return negtive error number.
> 
> It could be validated in advance, perhaps in parse_output_fields().
>
I did as below:

--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3112,6 +3112,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
                        rc = -EINVAL;
                        goto out;
                }
+#ifndef HAVE_LIBCAPSTONE_SUPPORT
+               if (change != REMOVE && strcmp(tok, "disasm") == 0) {
+                       fprintf(stderr, "Field \"disasm\" requires perf to be built with libcapstone support.\n");
+                       rc = -EINVAL;
+                       goto out;
+               }
+#endif

Then,
$ sudo perf script -F +disasm
Field "disasm" requires perf to be built with libcapstone support.

 Usage: perf script [<options>]
 ...

> > 
> >>  b) with libcapstone, disassembly does not line up nicely
> >>
> >  
> > 
> 

-- 
Cheers,
Changbin Du

