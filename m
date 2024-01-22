Return-Path: <linux-kernel+bounces-32782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08308836005
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF851F27AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37B3A1DC;
	Mon, 22 Jan 2024 10:47:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7553A8CB;
	Mon, 22 Jan 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920423; cv=none; b=A63WCMCsLQaTqFJAF4QA6rpBPhu0G67jEjZuOcZH2S2y/zIdppj95VOIm0Bwyies8P3iEkJjMq4+E+fjVoB6QcAoMfaTHwaR0DaQXiSrP6B4cyMAHf6x0cbCacz42OCaKnfv1sU61NcQzQ75CiV+05az3MmaWnDQrQhuxtRgXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920423; c=relaxed/simple;
	bh=fhaYFQB3dnbEhnIGIDw2KFqMrc6HBf6DGrphFIMQKhQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITSdaBkU2YeKxnbMbHYPMv9/Xgnd9aD8TBniI1pvnxtTvqo3douBi2tglZceXlxXVzNkCa6gagEkXkkoqgRwdTWSVRXYYi+XnjT50j3GH3SnSWnT6WHR7K0zr/SYj+8p+054BVzmNgAX0RQeD6NR8InNbCyUw233UQbJtDL4Bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TJRhg2sZpzsWLL;
	Mon, 22 Jan 2024 18:45:55 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E1BA1400FD;
	Mon, 22 Jan 2024 18:46:55 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 22 Jan
 2024 18:46:54 +0800
Date: Mon, 22 Jan 2024 18:46:46 +0800
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
Message-ID: <20240122104646.oqa7jnmd6ed2dzdw@M910t>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-4-changbin.du@huawei.com>
 <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
 <20240120074009.zmywqj6irtedivqk@M910t>
 <e8e5ea25-326b-4565-b0e8-1583b09dba65@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e8e5ea25-326b-4565-b0e8-1583b09dba65@intel.com>
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Mon, Jan 22, 2024 at 11:59:13AM +0200, Adrian Hunter wrote:
> On 20/01/24 09:40, Changbin Du wrote:
> > On Fri, Jan 19, 2024 at 08:39:36PM +0200, Adrian Hunter wrote:
> >> On 19/01/24 12:48, Changbin Du wrote:
> >>> In addition to the 'insn' field, this adds a new field 'disasm' to
> >>> display mnemonic instructions instead of the raw code.
> >>>
> >>> $ sudo perf script -F +disasm
> >>>        perf-exec 1443864 [006] 2275506.209848:          psb:  psb offs: 0                                      0 [unknown] ([unknown])
> >>>        perf-exec 1443864 [006] 2275506.209848:          cbr:  cbr: 41 freq: 4100 MHz (114%)                    0 [unknown] ([unknown])
> >>>               ls 1443864 [006] 2275506.209905:          1  branches:uH:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
> >>>               ls 1443864 [006] 2275506.209908:          1  branches:uH:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
> >>>
> >>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> >>> ---
> >>>  tools/perf/Documentation/perf-script.txt | 7 ++++---
> >>>  tools/perf/builtin-script.c              | 8 +++++++-
> >>>  2 files changed, 11 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> >>> index ff9a52e44688..fc79167c6bf8 100644
> >>> --- a/tools/perf/Documentation/perf-script.txt
> >>> +++ b/tools/perf/Documentation/perf-script.txt
> >>> @@ -132,9 +132,10 @@ OPTIONS
> >>>          Comma separated list of fields to print. Options are:
> >>>          comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
> >>>          srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
> >>> -        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
> >>> -        phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
> >>> -        machine_pid, vcpu, cgroup, retire_lat.
> >>> +        brstackinsn, brstackinsnlen, brstackoff, callindent, insn, disasm,
> >>> +        insnlen, synth, phys_addr, metric, misc, srccode, ipc, data_page_size,
> >>> +        code_page_size, ins_lat, machine_pid, vcpu, cgroup, retire_lat.
> >>> +
> >>
> >> Further down, there are explanations for insn and insnlen.  disasm
> >> could be added there.
> >>
> > Updated as:
> > 
> > 	When doing instruction trace decoding, insn, disasm and insnlen give the
> > 	instruction bytes, disassembled instructions and the instruction length
> > 	of the current instruction respectively.
> 
> I wondered about mentioning that disasm needs perf to be compiled with
> disassembler support, but with a permissive license it seems likely
> that libcapstone support would generally be built into perf, so that
> should be fine.
> 
Yes, libcapstone has a permissive license. It's available on most Linux distros.

So, I updated as below:

	When doing instruction trace decoding, insn, disasm and insnlen give the
	instruction bytes, disassembled instructions (requires libcapstone support)
	and the instruction length of the current instruction respectively.

-- 
Cheers,
Changbin Du

