Return-Path: <linux-kernel+bounces-52109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DC7849435
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C43A1F241E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341B101C5;
	Mon,  5 Feb 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6akfyxE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA533111A4;
	Mon,  5 Feb 2024 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116934; cv=none; b=kvyG+MIE54dZ8jkyjIzMMGu6/bIMHP5gprcgyXnjpVU9cy0qKfKiHfA6E64addXqbppXJBGnhPf7GmPiIpHz23jEt9j+mN061dt9Ozx8Mj0yRwAyME4RhdmFxgKmCmJMalxGA/8upSAq8T9lRQ9wQj3Z1N6p/FxKs/Tsm8p4N/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116934; c=relaxed/simple;
	bh=3BQM3PovqatipnssNZT1y5G4ghRel3gulOBnOGOJNnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvOvJgt4Ea+rKA9SK4s7cwP5wA+X8JyUvWZsvyGU+Nk/V4REZcTtjYtXSurHkSUVPhtTbWRrV8gP+ZiuBortFgO+0M6fSp86PlRCB9B4vwAd0ahT7kA6Mpym24g1G5b0AR/l86QVBTw1hLRR8XTO/TMJ4iYGQQN4pyH8joWQBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6akfyxE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707116932; x=1738652932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3BQM3PovqatipnssNZT1y5G4ghRel3gulOBnOGOJNnY=;
  b=G6akfyxEapfqBNa7m908bV3zb2Cg615CbgH8WOMRH4fcxSRoK3o6L58T
   E9nmlwAgvo04Wkimc05jk38rrwKupV/ERYwwE7+2JWemo9OizgQE++AuY
   LrLVd9NkY7lkIlfRjt+sWWMVdXtcxMRxIUV1KER7athwMf7DnMMcqNoC7
   ezqwkv2qiBdNmIt/2k3zRRbiDqxlpKDEDiq0UbYUdr0LJe5RUCqH80MFg
   eZ04VNQPS430+VmAWxd8LwaZ0jUupOZ6J2FPbDm9/1V1lx2VtsFDOj5CU
   u++Jji5mgtcWUSsybIT1jNUQUii9sT+aixBzCTPkI3RM6Vv9amLbOeeLX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="4281531"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4281531"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 23:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="38051905"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.164])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 23:08:48 -0800
Message-ID: <4983cc09-20ad-450b-8eba-219f75a5fab2@intel.com>
Date: Mon, 5 Feb 2024 09:08:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf script: Make it possible to see perf's kernel
 and module memory mappings
Content-Language: en-US
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Like Xu <like.xu.linux@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20240202110130.3553-1-adrian.hunter@intel.com>
 <20240202110130.3553-2-adrian.hunter@intel.com>
 <CAM9d7cipqHheaZOj9Qr56COjjdU2Qk1pLtUzkjZxtq4g3irLww@mail.gmail.com>
 <CA+JHD91GR=Jry_=Es4m+JnySjMoKrfajW40ZHq+eYFaF9Vsngg@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CA+JHD91GR=Jry_=Es4m+JnySjMoKrfajW40ZHq+eYFaF9Vsngg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/02/24 03:56, Arnaldo Carvalho de Melo wrote:
> 
> 
> On Fri, Feb 2, 2024, 10:50 PM Namhyung Kim <namhyung@kernel.org <mailto:namhyung@kernel.org>> wrote:
> 
>     On Fri, Feb 2, 2024 at 3:01 AM Adrian Hunter <adrian.hunter@intel.com <mailto:adrian.hunter@intel.com>> wrote:
>     >
>     > Dump kmaps if verbose > 2.
> 
>     Maybe we can add '--debug kmap' option rather than using an
>     arbitrary verbose level.

That is a global option but would only work for tools that are
explicitly programmed to do the dump.  Could just do perf script
and perf report?

> 
> 
> I think we have 'perf report --mmap', no?

Only shows user space maps.  Could add 'perf report --kmaps'?

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-report.txt#n542 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-report.txt#n542>
> 
> - Arnaldo
> 
> Sent from smartphone
> 
> 
>     Thanks,
>     Namhyung
> 
>     >
>     > Example:
>     >
>     >   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel
>     >   build id event received for /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko: 0691d75e10e72ebbbd45a44c59f6d00a5604badf [20]
>     >   Map: 0-3a3 4f5d8 [kvm_intel].modinfo
>     >   Map: 0-5240 5f280 [kvm_intel]__versions
>     >   Map: 0-30 64 [kvm_intel].note.Linux
>     >   Map: 0-14 644c0 [kvm_intel].orc_header
>     >   Map: 0-5297 43680 [kvm_intel].rodata
>     >   Map: 0-5bee 3b837 [kvm_intel].text.unlikely
>     >   Map: 0-7e0 41430 [kvm_intel].noinstr.text
>     >   Map: 0-2080 713c0 [kvm_intel].bss
>     >   Map: 0-26 705c8 [kvm_intel].data..read_mostly
>     >   Map: 0-5888 6a4c0 [kvm_intel].data
>     >   Map: 0-22 70220 [kvm_intel].data.once
>     >   Map: 0-40 705f0 [kvm_intel].data..percpu
>     >   Map: 0-1685 41d20 [kvm_intel].init.text
>     >   Map: 0-4b8 6fd60 [kvm_intel].init.data
>     >   Map: 0-380 70248 [kvm_intel]__dyndbg
>     >   Map: 0-8 70218 [kvm_intel].exit.data
>     >   Map: 0-438 4f980 [kvm_intel]__param
>     >   Map: 0-5f5 4ca0f [kvm_intel].rodata.str1.1
>     >   Map: 0-3657 493b8 [kvm_intel].rodata.str1.8
>     >   Map: 0-e0 70640 [kvm_intel].data..ro_after_init
>     >   Map: 0-500 70ec0 [kvm_intel].gnu.linkonce.this_module
>     >   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kernel/arch/x86/kvm/kvm-intel.ko
>     >
>     > The example above shows how the module section mappings are all wrong
>     > except for the main .text mapping at 0xffffffffc13a7000.
>     >
>     > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com <mailto:adrian.hunter@intel.com>>
>     > ---
>     >  tools/perf/builtin-script.c | 13 +++++++++++++
>     >  1 file changed, 13 insertions(+)
>     >
>     > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>     > index b1f57401ff23..e764b319ef59 100644
>     > --- a/tools/perf/builtin-script.c
>     > +++ b/tools/perf/builtin-script.c
>     > @@ -3806,6 +3806,16 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
>     >         return 0;
>     >  }
>     >
>     > +static void dump_kmaps(struct perf_session *session)
>     > +{
>     > +       int save_verbose = verbose;
>     > +
>     > +       pr_debug("Kernel and module maps:\n");
>     > +       verbose = 0; /* Suppress verbose to print a summary only */
>     > +       maps__fprintf(machine__kernel_maps(&session->machines.host), stderr);
>     > +       verbose = save_verbose;
>     > +}
>     > +
>     >  int cmd_script(int argc, const char **argv)
>     >  {
>     >         bool show_full_info = false;
>     > @@ -4366,6 +4376,9 @@ int cmd_script(int argc, const char **argv)
>     >
>     >         flush_scripting();
>     >
>     > +       if (verbose > 2)
>     > +               dump_kmaps(session);
>     > +
>     >  out_delete:
>     >         if (script.ptime_range) {
>     >                 itrace_synth_opts__clear_time_range(&itrace_synth_opts);
>     > --
>     > 2.34.1
>     >
> 


