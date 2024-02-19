Return-Path: <linux-kernel+bounces-72128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBB85AFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EFF1C21976
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5385676E;
	Mon, 19 Feb 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5KL6WPN"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120154F94
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384817; cv=none; b=ASXj4u7c5rtk3UcW0Djh7cVCABC21b1Abxv+qP+Fxi4YWJB0WY1NhQpjgob/ZV+GzF7FzsrwmllZ4AxLotaAvCUVbRZY0q7VtosUiFSyi1ikO+z2GEnWht0Cg0OVe0d2IQEDT+sNxa63CsZNY0xU0W8Hwno77qOeAygrMDbUZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384817; c=relaxed/simple;
	bh=SrmZXUdwYcI0Wb1S6dn/yNTrATUSfBRul1wownfAy6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoufFbm94buuiQVHdYGy1u9QGuaaP+OjYJ16xYZxs21O1ONhE0mYxMsgrgZDRYextpa87vYZXpAUB2g2UZiUmf+PDi0ICo7xfdCQbzUPU6M1W8pft3VnG4teWVq8oLdh3oWAdIK3Fc1GWEEnLCLKVUpbUTzWsqoDeloZuZClsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5KL6WPN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbe7e51f91so211485ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708384815; x=1708989615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrmZXUdwYcI0Wb1S6dn/yNTrATUSfBRul1wownfAy6U=;
        b=W5KL6WPNAQ/xL1ZHAkYr0B0O8rzat2SHj5D/6Jb52v+j9E24dOlWZkswHgBun4qUOY
         +d5L4IirPtcmwNV/AGAEy4c5OBOmDEEUy00NDz8t7FrGvXGZDoEdpJnnvLBKjTivadoM
         q7qvku+2VAkM+SxdRb1nYS9y3c6aqnh9gzCA38rzL3vgfgwkDr8tbs2tvYpRIN9jnSVw
         yyqsSDD4/5KBnAs8B7RpdqF0a6WUqNVX/ki0WBBwu4ifK6m9kOXLAQS655z6mNQeFCvG
         NdVqCeim0BRqz7pvVdcGPGdM2y54eDMAs+pGOEyzvX65lp31jNutlZ8BbPxCl22vWEtF
         NU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708384815; x=1708989615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrmZXUdwYcI0Wb1S6dn/yNTrATUSfBRul1wownfAy6U=;
        b=ABW4bNm7+XzhixfAEcVL2nNiwz+NCn9zrkQ8ksxFTgmIv6iXhhHO86Om5KHZNcB8oj
         FnyxxUzeEdzD2gtUJtHwPpqip324nqq3kje5yuAMdYfbCyIKolxAi2WDjBSqglhctDIk
         AOVqsvWyIz7turFoHqm4se7pls+YiE4OQS61GOW2ucMx8hWMpsg85Gc+7DDIWGg7Oz7D
         WlJtKpYjjOAJgqIzj3csN5CTZRFOCSS65cemSRQsxGqW0j67qvUTkMRnXoSN+P6Ja9xB
         1oUtvUbKqDmWoX5um6HdWbiS5XOQgdr5iME24Crb+sl+YP/6H1WWHQM6DAc6DlApJeQI
         Yf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW7N7Kdih2SPPA9GuWpXouC8kf125BGavMhlC8PAapB+3SsaHe73G63CcxHk1p1s2AKz7eaTOjTvEYDm4BFpMTyZUOgGMHsgLTGhoY
X-Gm-Message-State: AOJu0YwuoxvtguJaSqkxUtmSTI8jWPe+E3IMLI/W8xiZYxgMvyjLe+JR
	3WMbyirmMj/5JlHWdS5cMW812aSrfsP0PWhB4ThISHaEv5aQqtIDu1b1E4KGLtphek+Toam7Pxt
	ZtQfFnkz155Wnshakrlv7GZx35QGHtgD7KWU/
X-Google-Smtp-Source: AGHT+IEwvZzgko2mNXlN6svPu4bbKQCxp72X2gWcMmLsxRTNMGvG4TxkpT7FZTJ709tC42y3e1vYwXuhP1Eiq4mTe/w=
X-Received: by 2002:a17:902:fb4f:b0:1d9:aa55:e4c1 with SMTP id
 lf15-20020a170902fb4f00b001d9aa55e4c1mr388526plb.20.1708384814851; Mon, 19
 Feb 2024 15:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
In-Reply-To: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Feb 2024 15:20:00 -0800
Message-ID: <CAP-5=fXsFBwt9ARmQja0pKGL-_Vms_NDKeaH5CX=_om1aSvssw@mail.gmail.com>
Subject: Re: [BUG] perf/x86/intel: HitM false-positives on Ice Lake / Tiger
 Lake (I think?)
To: Jann Horn <jannh@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Feng Tang <feng.tang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Stephane Eranian <eranian@google.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"Biggers, Caleb" <caleb.biggers@intel.com>, "Wang, Weilin" <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 5:01=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> Hi!
>
> From what I understand, "perf c2c" shows bogus HitM events on Ice Lake
> (and newer) because Intel added some feature where *clean* cachelines
> can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
> treats this mostly the same as snoop-forwarding of modified cache
> lines (HitM)? On a Tiger Lake CPU, I can see addresses from the kernel
> rodata section in "perf c2c report".
>
> This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Latency
> Facility", table "Table 20-101. Data Source Encoding for Memory
> Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
> "XCORE FWD. This request was satisfied by a sibling core where either
> a modified (cross-core HITM) or a non-modified (cross-core FWD)
> cache-line copy was found."
>
> I don't see anything about this in arch/x86/events/intel/ds.c - if I
> understand correctly, the kernel's PEBS data source decoding assumes
> that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this needs
> to be adjusted somehow - and maybe it just isn't possible to actually
> distinguish between HitM and cross-core FWD in PEBS events on these
> CPUs (without big-hammer chicken bit trickery)? Maybe someone from
> Intel can clarify?
>
> (The SDM describes that E-cores on the newer 12th Gen have more
> precise PEBS encodings that distinguish between "L3 HITM" and "L3
> HITF"; but I guess the P-cores there maybe still don't let you
> distinguish HITM/HITF?)
>
>
> I think https://perfmon-events.intel.com/tigerLake.html is also
> outdated, or at least it uses ambiguous grammar: The
> MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event (EventSel=3DD2H UMask=3D04H) is
> documented as "Counts retired load instructions where a cross-core
> snoop hit in another cores caches on this socket, the data was
> forwarded back to the requesting core as the data was modified
> (SNOOP_HITM) or the L3 did not have the data(SNOOP_HIT_WITH_FWD)" -
> from what I understand, a "cross-core FWD" should be a case where the
> L3 does have the data, unless L3 has become non-inclusive on Ice Lake?
>
> On a Tiger Lake CPU, I can see this event trigger for the
> sys_call_table, which is located in the rodata region and probably
> shouldn't be containing Modified cache lines:
>
> # grep -A1 -w sys_call_table /proc/kallsyms
> ffffffff82800280 D sys_call_table
> ffffffff82801100 d vdso_mapping
> # perf record -e mem_load_l3_hit_retired.xsnp_fwd:ppp --all-kernel -c 100=
 --data
> ^C[ perf record: Woken up 11 times to write data ]
> [ perf record: Captured and wrote 22.851 MB perf.data (43176 samples) ]
> # perf script -F event,ip,sym,addr | egrep --color 'ffffffff828002[89abcd=
ef]'
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002d8
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800280
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff82800288
> ffffffff82526275 do_syscall_64
> mem_load_l3_hit_retired.xsnp_fwd:ppp: ffffffff828002b8
> ffffffff82526275 do_syscall_64
>
>
> (For what it's worth, there is a thread on LKML where "cross-core FWD"
> got mentioned: <https://lore.kernel.org/lkml/b4aaf1ed-124d-1339-3e99-a120=
f6cc4d28@linux.intel.com/>)

+others better qualified than me to respond.

Hi Jann,

I'm not overly familiar with the issue, but it appears a similar issue
has been reported for Broadwell Xeon here:
https://community.intel.com/t5/Software-Tuning-Performance/Broadwell-Xeon-p=
erf-c2c-showing-remote-HITM-but-remote-socket-is/td-p/1172120
I'm not sure that thread will be particularly useful, but having the
Intel people better qualified than me to answer is probably the better
service of this email.

Thanks,
Ian

