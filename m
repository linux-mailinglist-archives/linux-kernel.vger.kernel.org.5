Return-Path: <linux-kernel+bounces-77297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D8860377
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB571F2509C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD66AFB8;
	Thu, 22 Feb 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYhQ90J7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B4548F3;
	Thu, 22 Feb 2024 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632315; cv=none; b=WV3Ur6hfTxwiTd6IvnJ7wUGWMTRthoegFiWD1ADs7JAzpX+IXlkVyqnRuSYF7X99o8LaqPziYrGyoKspGkPWovIQSyvk3t0My3KHON0Zo88wBIyTpi0tcTsCSv67B7v4q4yMmmuyUAASTTUytjjPcKQlzHT5dmbsjfYiVBbP6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632315; c=relaxed/simple;
	bh=NNN5sIYqYmoNZjYzCoccvYjI75lw8cPlmAS3bA9uaqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2yrhPgCmWs+m1S1/go+mO/C/xXBqOXLBCg+znLbVi/6y9ZZ0o0S37r1FL97iuq35hco/cfcgjdPCj1Fa+qb5LqfwDdJJT5jWkznsZ483tr/Zx7GZiZhbeT14dmJQZwQoDaNx0EpU3HU2lqmfQY4idJmMZAJBCWSCvDZoq/l4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYhQ90J7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708632314; x=1740168314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NNN5sIYqYmoNZjYzCoccvYjI75lw8cPlmAS3bA9uaqQ=;
  b=MYhQ90J7Ah8DAE01j+Jpb2Lxda40odLF4oQBM0UvWUTrwRcKynuJDIAb
   0OBviFQFQAsGKReJ2/znXo4GD+Xnru1Ve4EU0mDuVn3zUMDT5B7ad7y7T
   p9YaW5OZForxUl0+KCoXTcraUsvi8j9JhCqgencfekm1hcOYuCUp6oKkh
   WLWcI38Tx0Q8StfrTMOabg9zYE1C/hcxKIWk2Nf4haoYZ/v4u3fVzT33G
   +kZf7+TWqzjZfR/GvLtIqGDH1THFaPYnCn2aPxVkpiGKzd9igIVvUMiOJ
   lAyc4sYEjF5ywZYF0XlMJ2Kmny78nwVSqCX6+ak5JjXFFjyi3ouJ/NVRt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13596797"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13596797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="936897396"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="936897396"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 12:05:12 -0800
Received: from [10.212.89.194] (kliang2-mobl1.ccr.corp.intel.com [10.212.89.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 241E1580DED;
	Thu, 22 Feb 2024 12:05:10 -0800 (PST)
Message-ID: <05d29733-cfc4-42e1-bbb1-a496d9522d0e@linux.intel.com>
Date: Thu, 22 Feb 2024 15:05:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] perf/x86/intel: HitM false-positives on Ice Lake / Tiger
 Lake (I think?)
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>
Cc: Joe Mario <jmario@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Feng Tang <feng.tang@intel.com>,
 Andi Kleen <ak@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 "Taylor, Perry" <perry.taylor@intel.com>,
 "Alt, Samantha" <samantha.alt@intel.com>,
 "Biggers, Caleb" <caleb.biggers@intel.com>,
 "Wang, Weilin" <weilin.wang@intel.com>
References: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
 <CAP-5=fXsFBwt9ARmQja0pKGL-_Vms_NDKeaH5CX=_om1aSvssw@mail.gmail.com>
 <ZdTIYLoJOdyu62LU@x1>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZdTIYLoJOdyu62LU@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jann,

Sorry for the late response.

On 2024-02-20 10:42 a.m., Arnaldo Carvalho de Melo wrote:
> Just adding Joe Mario to the CC list.
> 
> On Mon, Feb 19, 2024 at 03:20:00PM -0800, Ian Rogers wrote:
>> On Mon, Feb 19, 2024 at 5:01 AM Jann Horn <jannh@google.com> wrote:
>>>
>>> Hi!
>>>
>>> From what I understand, "perf c2c" shows bogus HitM events on Ice Lake
>>> (and newer) because Intel added some feature where *clean* cachelines
>>> can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
>>> treats this mostly the same as snoop-forwarding of modified cache
>>> lines (HitM)? On a Tiger Lake CPU, I can see addresses from the kernel
>>> rodata section in "perf c2c report".
>>>
>>> This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Latency
>>> Facility", table "Table 20-101. Data Source Encoding for Memory
>>> Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
>>> "XCORE FWD. This request was satisfied by a sibling core where either
>>> a modified (cross-core HITM) or a non-modified (cross-core FWD)
>>> cache-line copy was found."
>>>
>>> I don't see anything about this in arch/x86/events/intel/ds.c - if I
>>> understand correctly, the kernel's PEBS data source decoding assumes
>>> that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this needs
>>> to be adjusted somehow - and maybe it just isn't possible to actually
>>> distinguish between HitM and cross-core FWD in PEBS events on these
>>> CPUs (without big-hammer chicken bit trickery)? Maybe someone from
>>> Intel can clarify?
>>>
>>> (The SDM describes that E-cores on the newer 12th Gen have more
>>> precise PEBS encodings that distinguish between "L3 HITM" and "L3
>>> HITF"; but I guess the P-cores there maybe still don't let you
>>> distinguish HITM/HITF?)

Right, there is no way to distinguish HITM/HITF on Tiger Lake.

I think what we can do is to add both HITM and HITF for the 0x07 to
match the SDM description.

How about the below patch (not tested yet)?
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d49d661ec0a7..8c966b5b23cb 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -84,7 +84,7 @@ static u64 pebs_data_source[] = {
	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),  /* 0x04: L3 hit */
	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, MISS),  /* 0x05: L3 hit,
snoop miss */
	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HIT),   /* 0x06: L3 hit,
snoop hit */
-	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),  /* 0x07: L3 hit,
snoop hitm */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM) | P(SNOOPX, FWD),  /*
0x07: L3 hit, snoop hitm & fwd */
	OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HIT),  /* 0x08:
L3 miss snoop hit */
	OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM), /* 0x09:
L3 miss snoop hitm*/
	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, HIT),       /* 0x0a:
L3 miss, shared */


>>>
>>>
>>> I think https://perfmon-events.intel.com/tigerLake.html is also
>>> outdated, or at least it uses ambiguous grammar: The
>>> MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event (EventSel=D2H UMask=04H) is
>>> documented as "Counts retired load instructions where a cross-core
>>> snoop hit in another cores caches on this socket, the data was
>>> forwarded back to the requesting core as the data was modified
>>> (SNOOP_HITM) or the L3 did not have the data(SNOOP_HIT_WITH_FWD)" -
>>> from what I understand, a "cross-core FWD" should be a case where the
>>> L3 does have the data, unless L3 has become non-inclusive on Ice Lake?
>>>

For the event, the BriefDescription in the event list json file gives a
more accurate description.
"BriefDescription": "Snoop hit a modified(HITM) or clean line(HIT_W_FWD)
in another on-pkg core which forwarded the data back due to a retired
load instruction.",
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/x86/tigerlake/cache.json#n286

Thanks,
Kan
>>> On a Tiger Lake CPU, I can see this event trigger for the
>>> sys_call_table, which is located in the rodata region and probably
>>> shouldn't be containing Modified cache lines:
>>>
>>> # grep -A1 -w sys_call_table /proc/kallsyms
>>> ffffffff82800280 D sys_call_table
>>> ffffffff82801100 d vdso_mapping
>>> # perf record -e mem_load_l3_hit_retired.xsnp_fwd:ppp --all-kernel -c 100 --data
>>> ^C[ perf record: Woken up 11 times to write data ]
>>> [ perf record: Captured and wrote 22.851 MB perf.data (43176 samples) ]
>>> # perf script -F event,ip,sym,addr | egrep --color 'ffffffff828002[89abcdef]'
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002d8
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800288
>>> ffffffff82526275 do_syscall_64
>>> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
>>> ffffffff82526275 do_syscall_64
>>>
>>>
>>> (For what it's worth, there is a thread on LKML where "cross-core FWD"
>>> got mentioned: <https://lore.kernel.org/lkml/b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com/>)
>>
>> +others better qualified than me to respond.
>>
>> Hi Jann,
>>
>> I'm not overly familiar with the issue, but it appears a similar issue
>> has been reported for Broadwell Xeon here:
>> https://community.intel.com/t5/Software-Tuning-Performance/Broadwell-Xeon-perf-c2c-showing-remote-HITM-but-remote-socket-is/td-p/1172120
>> I'm not sure that thread will be particularly useful, but having the
>> Intel people better qualified than me to answer is probably the better
>> service of this email.
>>
>> Thanks,
>> Ian
> 

