Return-Path: <linux-kernel+bounces-78641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CBE861654
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B940D1C2448B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34083CA6;
	Fri, 23 Feb 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZF2Jgaei"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9882D81;
	Fri, 23 Feb 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703522; cv=none; b=pFfiMlzb8+TUhhJdimu9E3oDCH4wxYPGPZGwUxJvd/p97tG1OumBvRDOorIEfbLE6WXstSRXm1JqxVsSDjHL9+XzaGI4MC7X9j6y3MEOVgSeb6IZp1NqzPbNMLpMu8XNKvjl6jG/a4XmzIfR3glEzYZbHl21l0DAO6sGYuniMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703522; c=relaxed/simple;
	bh=kbIxDzehcaZDxExHt/YYOzGZCyd5MNnCfCeLop29BeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rywWuj1UkIff9R4iYJzT/MNI0ObWHi7njexuamFdDyZB6qx9WGjMwR1fHWchXWDZ4b9GiyH+dgnavFh7zj3qSHfwuR1Dc1bXTqeCPW7Xp4LqahVCnVSVgXT39S1VuCSxrOoTc3EbItua9NyqW5Dx8d1ZNCPU53ODUAhMRLqdLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZF2Jgaei; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703521; x=1740239521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kbIxDzehcaZDxExHt/YYOzGZCyd5MNnCfCeLop29BeI=;
  b=ZF2Jgaei/lLhhlQigMFhzk81UowJ1HHswPIjVN8hh78g1KCBrwnzbaWk
   GGUSznA32ob0MRbAbqYh+oy3X+EKuFMt3+OtflB23weQW9ToOdqkJsT7M
   vrWRObfAzK3F7Z8ZWYJiUSlKCd7F1OyAhUnrCl/iLcfUtNqX9a7kqlfly
   ocq7YDEeUbqpSS0x2brPrDpcc2C/nKriNtwGjcP7Ym9LQUzd4sGkCVap3
   wFMW021sPRQvTwQLS1bs5a6oNPEk/Gax3q8a1NQEMsaOkN5JJY50jazly
   4DoP4SgVFrl+dlzW2qKBLEjS63Ot+ZcBe/IYVwNZHz4uPF80woHrwYlkg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3153061"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3153061"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10642742"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:52:01 -0800
Received: from [10.212.83.84] (kliang2-mobl1.ccr.corp.intel.com [10.212.83.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0FDF4580DA9;
	Fri, 23 Feb 2024 07:51:57 -0800 (PST)
Message-ID: <d5e10260-bec6-4499-9391-131450d5e43a@linux.intel.com>
Date: Fri, 23 Feb 2024 10:51:56 -0500
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
To: Jann Horn <jannh@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
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
 <ZdTIYLoJOdyu62LU@x1> <05d29733-cfc4-42e1-bbb1-a496d9522d0e@linux.intel.com>
 <CAG48ez2MVNBMcoa+Cm8CZR3ZAHfBms92RD+fEa-kCdirALxxjg@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAG48ez2MVNBMcoa+Cm8CZR3ZAHfBms92RD+fEa-kCdirALxxjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-02-22 3:07 p.m., Jann Horn wrote:
> On Thu, Feb 22, 2024 at 9:05 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>> Hi Jann,
>>
>> Sorry for the late response.
>>
>> On 2024-02-20 10:42 a.m., Arnaldo Carvalho de Melo wrote:
>>> Just adding Joe Mario to the CC list.
>>>
>>> On Mon, Feb 19, 2024 at 03:20:00PM -0800, Ian Rogers wrote:
>>>> On Mon, Feb 19, 2024 at 5:01 AM Jann Horn <jannh@google.com> wrote:
>>>>>
>>>>> Hi!
>>>>>
>>>>> From what I understand, "perf c2c" shows bogus HitM events on Ice Lake
>>>>> (and newer) because Intel added some feature where *clean* cachelines
>>>>> can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
>>>>> treats this mostly the same as snoop-forwarding of modified cache
>>>>> lines (HitM)? On a Tiger Lake CPU, I can see addresses from the kernel
>>>>> rodata section in "perf c2c report".
>>>>>
>>>>> This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Latency
>>>>> Facility", table "Table 20-101. Data Source Encoding for Memory
>>>>> Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
>>>>> "XCORE FWD. This request was satisfied by a sibling core where either
>>>>> a modified (cross-core HITM) or a non-modified (cross-core FWD)
>>>>> cache-line copy was found."
>>>>>
>>>>> I don't see anything about this in arch/x86/events/intel/ds.c - if I
>>>>> understand correctly, the kernel's PEBS data source decoding assumes
>>>>> that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this needs
>>>>> to be adjusted somehow - and maybe it just isn't possible to actually
>>>>> distinguish between HitM and cross-core FWD in PEBS events on these
>>>>> CPUs (without big-hammer chicken bit trickery)? Maybe someone from
>>>>> Intel can clarify?
>>>>>
>>>>> (The SDM describes that E-cores on the newer 12th Gen have more
>>>>> precise PEBS encodings that distinguish between "L3 HITM" and "L3
>>>>> HITF"; but I guess the P-cores there maybe still don't let you
>>>>> distinguish HITM/HITF?)
>>
>> Right, there is no way to distinguish HITM/HITF on Tiger Lake.
> 
> Aah, okay, thank you very much for the clarification!
> 
>> I think what we can do is to add both HITM and HITF for the 0x07 to
>> match the SDM description.
>>
>> How about the below patch (not tested yet)?
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index d49d661ec0a7..8c966b5b23cb 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -84,7 +84,7 @@ static u64 pebs_data_source[] = {
>>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),  /* 0x04: L3 hit */
>>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, MISS),  /* 0x05: L3 hit,
>> snoop miss */
>>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HIT),   /* 0x06: L3 hit,
>> snoop hit */
>> -       OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),  /* 0x07: L3 hit,
>> snoop hitm */
>> +       OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM) | P(SNOOPX, FWD),  /*
>> 0x07: L3 hit, snoop hitm & fwd */
>>         OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HIT),  /* 0x08:
>> L3 miss snoop hit */
>>         OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM), /* 0x09:
>> L3 miss snoop hitm*/
>>         OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, HIT),       /* 0x0a:
>> L3 miss, shared */
> 
> (I'm not familiar enough with the perf semantics to know how the event
> encoding works, maybe someone else can have a look?)
>

I can do the test to verify the settings and perf c2c. But I don't have
a benchmark. Could you please share your benchmark with me?
For example, the data you used in your example.
# perf record -e mem_load_l3_hit_retired.xsnp_fwd:ppp --all-kernel -c
100 --data

Thanks,
Kan
>>
>>
>>>>>
>>>>>
>>>>> I think https://perfmon-events.intel.com/tigerLake.html is also
>>>>> outdated, or at least it uses ambiguous grammar: The
>>>>> MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event (EventSel=D2H UMask=04H) is
>>>>> documented as "Counts retired load instructions where a cross-core
>>>>> snoop hit in another cores caches on this socket, the data was
>>>>> forwarded back to the requesting core as the data was modified
>>>>> (SNOOP_HITM) or the L3 did not have the data(SNOOP_HIT_WITH_FWD)" -
>>>>> from what I understand, a "cross-core FWD" should be a case where the
>>>>> L3 does have the data, unless L3 has become non-inclusive on Ice Lake?
>>>>>
>>
>> For the event, the BriefDescription in the event list json file gives a
>> more accurate description.
>> "BriefDescription": "Snoop hit a modified(HITM) or clean line(HIT_W_FWD)
>> in another on-pkg core which forwarded the data back due to a retired
>> load instruction.",
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/pmu-events/arch/x86/tigerlake/cache.json#n286
> 
> Ah, right, that's clearer.
> 

