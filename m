Return-Path: <linux-kernel+bounces-73266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2185C038
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E70D1C21CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98794762C3;
	Tue, 20 Feb 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKSESiIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B024876411;
	Tue, 20 Feb 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443747; cv=none; b=hHSs5rKyvhRUd6nmhLMQSwDAi0EMRj5d+Wadj1Qgaxtpewo4EGrm3+au3ePO8jrlyXTyj+MiXpC71Yg7MaovttBXRnH336raZzZGwAN6lbKnYVJQYIHI/hgxNGRLHZ1oMI2cFXoC+A0BtYt+4qpY7Mnt5Jx55SgJRL3mlCTQ4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443747; c=relaxed/simple;
	bh=kYdSQC9Wpn67FHvtXtQYWqDXcKHPW+LqtaL7SkwNwi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT7atA4s3HvZ22C2M8Bpn4a3TPT7sX6Y7yy6a5VPkFmiRsnZ+8nXuMreHKoqxAjAJbqWDKdKbvIQbDO5/yGsVrt3wwwYCn3Y3zQ7ohorT6ahXxv/pVnwl2FcC2VBvR/TlXC7Tbkr9LOZuBf0lF+Fg3NpR6z+5bjLtn62z+ny8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKSESiIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FBAC433C7;
	Tue, 20 Feb 2024 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708443747;
	bh=kYdSQC9Wpn67FHvtXtQYWqDXcKHPW+LqtaL7SkwNwi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKSESiICcx/M53se7cXMGIuBqSRu0lEsxQO4kEyir1C0mY1HApxU0ywXTySiBza8H
	 o7mZxG0z+8yJNa7lJa4DsWAVcOEn0ILt9ymEdWtgyPargeUKheiBNG6BPhACws+r5Z
	 NKbsz0/bNYALLwzaqc6U9IEVsrZqCpD6mrPlK7Oc586ZBQq8eRexCHykXL/kg9wykU
	 CSZIgjS/gWB41eHLJ07A5G/FlhxwtAIBInqQUKEy+R9IW4WkAlQGEqRe1OpgvbZd5h
	 a/3PxTN8+E+9RXAAIaXjO9mmU5P6iXPH8ChFSmfq3LiQBBz5y0HYQdlcv3LrI6nuRS
	 oJ2teBd2IxHZQ==
Date: Tue, 20 Feb 2024 12:42:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jann Horn <jannh@google.com>, Joe Mario <jmario@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Feng Tang <feng.tang@intel.com>, Andi Kleen <ak@linux.intel.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>,
	"Wang, Weilin" <weilin.wang@intel.com>
Subject: Re: [BUG] perf/x86/intel: HitM false-positives on Ice Lake / Tiger
 Lake (I think?)
Message-ID: <ZdTIYLoJOdyu62LU@x1>
References: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
 <CAP-5=fXsFBwt9ARmQja0pKGL-_Vms_NDKeaH5CX=_om1aSvssw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXsFBwt9ARmQja0pKGL-_Vms_NDKeaH5CX=_om1aSvssw@mail.gmail.com>

Just adding Joe Mario to the CC list.

On Mon, Feb 19, 2024 at 03:20:00PM -0800, Ian Rogers wrote:
> On Mon, Feb 19, 2024 at 5:01 AM Jann Horn <jannh@google.com> wrote:
> >
> > Hi!
> >
> > From what I understand, "perf c2c" shows bogus HitM events on Ice Lake
> > (and newer) because Intel added some feature where *clean* cachelines
> > can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
> > treats this mostly the same as snoop-forwarding of modified cache
> > lines (HitM)? On a Tiger Lake CPU, I can see addresses from the kernel
> > rodata section in "perf c2c report".
> >
> > This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Latency
> > Facility", table "Table 20-101. Data Source Encoding for Memory
> > Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
> > "XCORE FWD. This request was satisfied by a sibling core where either
> > a modified (cross-core HITM) or a non-modified (cross-core FWD)
> > cache-line copy was found."
> >
> > I don't see anything about this in arch/x86/events/intel/ds.c - if I
> > understand correctly, the kernel's PEBS data source decoding assumes
> > that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this needs
> > to be adjusted somehow - and maybe it just isn't possible to actually
> > distinguish between HitM and cross-core FWD in PEBS events on these
> > CPUs (without big-hammer chicken bit trickery)? Maybe someone from
> > Intel can clarify?
> >
> > (The SDM describes that E-cores on the newer 12th Gen have more
> > precise PEBS encodings that distinguish between "L3 HITM" and "L3
> > HITF"; but I guess the P-cores there maybe still don't let you
> > distinguish HITM/HITF?)
> >
> >
> > I think https://perfmon-events.intel.com/tigerLake.html is also
> > outdated, or at least it uses ambiguous grammar: The
> > MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event (EventSel=D2H UMask=04H) is
> > documented as "Counts retired load instructions where a cross-core
> > snoop hit in another cores caches on this socket, the data was
> > forwarded back to the requesting core as the data was modified
> > (SNOOP_HITM) or the L3 did not have the data(SNOOP_HIT_WITH_FWD)" -
> > from what I understand, a "cross-core FWD" should be a case where the
> > L3 does have the data, unless L3 has become non-inclusive on Ice Lake?
> >
> > On a Tiger Lake CPU, I can see this event trigger for the
> > sys_call_table, which is located in the rodata region and probably
> > shouldn't be containing Modified cache lines:
> >
> > # grep -A1 -w sys_call_table /proc/kallsyms
> > ffffffff82800280 D sys_call_table
> > ffffffff82801100 d vdso_mapping
> > # perf record -e mem_load_l3_hit_retired.xsnp_fwd:ppp --all-kernel -c 100 --data
> > ^C[ perf record: Woken up 11 times to write data ]
> > [ perf record: Captured and wrote 22.851 MB perf.data (43176 samples) ]
> > # perf script -F event,ip,sym,addr | egrep --color 'ffffffff828002[89abcdef]'
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002d8
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800288
> > ffffffff82526275 do_syscall_64
> > mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> > ffffffff82526275 do_syscall_64
> >
> >
> > (For what it's worth, there is a thread on LKML where "cross-core FWD"
> > got mentioned: <https://lore.kernel.org/lkml/b4aaf1ed-124d-1339-3e99-a120f6cc4d28@linux.intel.com/>)
> 
> +others better qualified than me to respond.
> 
> Hi Jann,
> 
> I'm not overly familiar with the issue, but it appears a similar issue
> has been reported for Broadwell Xeon here:
> https://community.intel.com/t5/Software-Tuning-Performance/Broadwell-Xeon-perf-c2c-showing-remote-HITM-but-remote-socket-is/td-p/1172120
> I'm not sure that thread will be particularly useful, but having the
> Intel people better qualified than me to answer is probably the better
> service of this email.
> 
> Thanks,
> Ian

