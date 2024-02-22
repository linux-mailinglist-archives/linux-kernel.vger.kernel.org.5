Return-Path: <linux-kernel+bounces-77300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C2786037D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF681C24A73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D46E5E1;
	Thu, 22 Feb 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moqCb7pi"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675926AFAD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632483; cv=none; b=DAcfmJOoPi5tYIReVZ4zfO+UP0LBWf9X4NXNsaG9seOwONauZ1oQOdG5NTYGt++j0Elq/+Y24iLFHsdVSCBdVhbk4/mKV28COFtlFj1mSXGpyGhe91MeIpyUw8l6GSYTC2YmNuOQCTmDJJx+dRTCsZwYFl0VLliKAcfRIxHwiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632483; c=relaxed/simple;
	bh=82P1KJmwIp1GzLjUuOrvLBi/uz+qn/Qr7VEYjUni8CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Olly3ZGueAABJDq+NP052ZNNPK1apiPrKkjz6rvHTAZn6TIYDy3dK+4alAeEqU5ab7bpg6kuLGRld0FX9QdafISXYT17DDQC0GRWk04VnDYjBBXpSoyy77ucRXXeq8SvPi4TRrbCJzNt4vIcjFbVWHeIVZD+E0KI94oYzvDVC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moqCb7pi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so2714a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708632479; x=1709237279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGjajmrXJJz1DiKWcZdtHNQG+dgh6yAQECPS6jCJk9s=;
        b=moqCb7piLDVTFbEGYhl6L/AdHQGG1tZ93UBosuPQxWIwSAXsCbEXWsKbFfXr4iX6oH
         hMXHWkKBfdurFUuA5A68Xwfq0s4Pss5Gyzw5GFk2pnDFnezNLC/7bGM6T9Kk7R2l0Old
         gkH2yKQJzenJe9mfhPSCV/grduzf48tlqtZvtRUMA41EztoavZ8gOQwvpZtx6VlYtLjl
         D9CW/s/NYJKoEm/8qeVn4gUlokw3ZUT2IOttfuVSGJqVUWaGB81IkQkMwAf6MfUPF4qe
         OCfVdADilxzpCLOiUD90x13/RrhIl4w2F7niO7FB5BnkbiCzKI8B3ZhDGXPP/1qodFxt
         fOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632479; x=1709237279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGjajmrXJJz1DiKWcZdtHNQG+dgh6yAQECPS6jCJk9s=;
        b=jxg6L8znV02OZfGzxp9oRt+SSQ+tK6H0JMijOqCif2lnTe9yyuxWljdjnAG3BAKlIG
         JW8GnLYK5YnBs3K8BNbp9cI0TCmTgUJTwjwkfS7P9u05+7oSo3LhN5u1dVHK39/pagvD
         butwjBHFRgZCCkJ4zi56cnliOmIGGXNE/Rf1Ksq93DZkfsBZhRrjsvzz3h6rG9JbyRCa
         SvuNoRuhEov0NazDOWYfV8BNcrBO2XrnVxzXXL3gvlssYx6xbHO8dARAjYVVYxqnukKh
         8o9PCDGnrs106c+q5+yFGnFKTIKYoWuEBaz0B6c6Z+sYqgnEscSxNx5axAN1S5zXjD3c
         hK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjXF1EOyRGa2iooQWnOYOyzpalExUCGr1sOd5c7f9y7KYAN2HHzfvaIJwB5GdPN/Xz7cmbHyrmYPTHhggFUvYd0EQipG8OyvdxCd3K
X-Gm-Message-State: AOJu0Ywk761+2M1CAY2//ZvEM0Ba8gKhUQ+B9WFa7Bywit3p9tdaUjEm
	gMB+mR5RtIRC13D6Rnygn4htEDPRaf5MTh7Xct8jYeFoA/b5cCfTuSV2ntgLYIoF0iyQatNhnu+
	lNJbOG8l4YdbdmAVvDlVBzUANfOzeh/6xl5ZL
X-Google-Smtp-Source: AGHT+IFH7pQjMIQyqJyE2tlVt68jFcFGrK+k3c9V41QTz3+HY0KpOu9w8BIxTwkPrIEnO9fpPC5sSJH5y073HadJfAo=
X-Received: by 2002:a50:f615:0:b0:563:c0e0:667c with SMTP id
 c21-20020a50f615000000b00563c0e0667cmr570330edn.0.1708632479435; Thu, 22 Feb
 2024 12:07:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
 <CAP-5=fXsFBwt9ARmQja0pKGL-_Vms_NDKeaH5CX=_om1aSvssw@mail.gmail.com>
 <ZdTIYLoJOdyu62LU@x1> <05d29733-cfc4-42e1-bbb1-a496d9522d0e@linux.intel.com>
In-Reply-To: <05d29733-cfc4-42e1-bbb1-a496d9522d0e@linux.intel.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Feb 2024 21:07:19 +0100
Message-ID: <CAG48ez2MVNBMcoa+Cm8CZR3ZAHfBms92RD+fEa-kCdirALxxjg@mail.gmail.com>
Subject: Re: [BUG] perf/x86/intel: HitM false-positives on Ice Lake / Tiger
 Lake (I think?)
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Feng Tang <feng.tang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>, 
	kernel list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	"Wang, Weilin" <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 9:05=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> Hi Jann,
>
> Sorry for the late response.
>
> On 2024-02-20 10:42 a.m., Arnaldo Carvalho de Melo wrote:
> > Just adding Joe Mario to the CC list.
> >
> > On Mon, Feb 19, 2024 at 03:20:00PM -0800, Ian Rogers wrote:
> >> On Mon, Feb 19, 2024 at 5:01=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
> >>>
> >>> Hi!
> >>>
> >>> From what I understand, "perf c2c" shows bogus HitM events on Ice Lak=
e
> >>> (and newer) because Intel added some feature where *clean* cachelines
> >>> can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
> >>> treats this mostly the same as snoop-forwarding of modified cache
> >>> lines (HitM)? On a Tiger Lake CPU, I can see addresses from the kerne=
l
> >>> rodata section in "perf c2c report".
> >>>
> >>> This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Latency
> >>> Facility", table "Table 20-101. Data Source Encoding for Memory
> >>> Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
> >>> "XCORE FWD. This request was satisfied by a sibling core where either
> >>> a modified (cross-core HITM) or a non-modified (cross-core FWD)
> >>> cache-line copy was found."
> >>>
> >>> I don't see anything about this in arch/x86/events/intel/ds.c - if I
> >>> understand correctly, the kernel's PEBS data source decoding assumes
> >>> that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this need=
s
> >>> to be adjusted somehow - and maybe it just isn't possible to actually
> >>> distinguish between HitM and cross-core FWD in PEBS events on these
> >>> CPUs (without big-hammer chicken bit trickery)? Maybe someone from
> >>> Intel can clarify?
> >>>
> >>> (The SDM describes that E-cores on the newer 12th Gen have more
> >>> precise PEBS encodings that distinguish between "L3 HITM" and "L3
> >>> HITF"; but I guess the P-cores there maybe still don't let you
> >>> distinguish HITM/HITF?)
>
> Right, there is no way to distinguish HITM/HITF on Tiger Lake.

Aah, okay, thank you very much for the clarification!

> I think what we can do is to add both HITM and HITF for the 0x07 to
> match the SDM description.
>
> How about the below patch (not tested yet)?
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index d49d661ec0a7..8c966b5b23cb 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -84,7 +84,7 @@ static u64 pebs_data_source[] =3D {
>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),  /* 0x04: L3 hi=
t */
>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, MISS),  /* 0x05: L3 hi=
t,
> snoop miss */
>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HIT),   /* 0x06: L3 hi=
t,
> snoop hit */
> -       OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),  /* 0x07: L3 hi=
t,
> snoop hitm */
> +       OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM) | P(SNOOPX, FWD)=
,  /*
> 0x07: L3 hit, snoop hitm & fwd */
>         OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HIT),  /* 0=
x08:
> L3 miss snoop hit */
>         OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM), /* 0=
x09:
> L3 miss snoop hitm*/
>         OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, HIT),       /* 0=
x0a:
> L3 miss, shared */

(I'm not familiar enough with the perf semantics to know how the event
encoding works, maybe someone else can have a look?)

>
>
> >>>
> >>>
> >>> I think https://perfmon-events.intel.com/tigerLake.html is also
> >>> outdated, or at least it uses ambiguous grammar: The
> >>> MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event (EventSel=3DD2H UMask=3D04H) i=
s
> >>> documented as "Counts retired load instructions where a cross-core
> >>> snoop hit in another cores caches on this socket, the data was
> >>> forwarded back to the requesting core as the data was modified
> >>> (SNOOP_HITM) or the L3 did not have the data(SNOOP_HIT_WITH_FWD)" -
> >>> from what I understand, a "cross-core FWD" should be a case where the
> >>> L3 does have the data, unless L3 has become non-inclusive on Ice Lake=
?
> >>>
>
> For the event, the BriefDescription in the event list json file gives a
> more accurate description.
> "BriefDescription": "Snoop hit a modified(HITM) or clean line(HIT_W_FWD)
> in another on-pkg core which forwarded the data back due to a retired
> load instruction.",
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/pmu-events/arch/x86/tigerlake/cache.json#n286

Ah, right, that's clearer.

