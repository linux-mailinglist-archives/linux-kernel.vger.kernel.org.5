Return-Path: <linux-kernel+bounces-79039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31AB861CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76467287733
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381071448F3;
	Fri, 23 Feb 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhQIw1MZ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814ED143C7F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717085; cv=none; b=bHAd3SL/k7bYQgxO4iz5SS6Zm92VhWNLFbIUjakNWgDXIzkZv0UXDXD7Zg/wkf3It+rf0SmjaCuEfxZvfkv+GEFp/gn+2ncSqEOzRPMhmxp6SsaOtyfJtIWEQj16KNzP2WMcWpHqsn1cS0NWgQexrIAIBjGECQFFkVUHGQhYmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717085; c=relaxed/simple;
	bh=q0iAtEV3JkMuKJHVr6M+Vh/WS39zhXP8J+I2Z84QrDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APWxD0xXOXcXGBvX0EH2bQeCOYIyaKh2umW7DSczYOGpT6oXNYHut1HGy/RqlBi7dtH5ZvOZBo3EJWNo1UwT1RlO4swYwZ3xe1KRiyTCjxEnP8clcFsE6zoAJ4fkQLdnCJV9nn8PmLhZ4Xyvybi6K/3TBWAt73qSuFmluHaN8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UhQIw1MZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso1913a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708717082; x=1709321882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Ei56rO+d2hPFaNX2QlE0LT758B0T2h/DVvm+aYD+0=;
        b=UhQIw1MZAUCPE4XCb5TO1RFNVkN4iLdRxaLQ/U5PSSBr+xhL0NszSg1lxaVXvIglqY
         xDgaIwSK4XlvSAE0Tx2akJAEIO6VFotdQjrX3VVXjxItdVQvXaebmE958iUcdf3iQNuz
         NnobDsDfUscqUjx8NMtwUK1MQ7LwmuV/4CtCqUmx5zUFjxsye3LTM0MEzqyCj5gexkye
         kfB+YqV8eQUy51yM4puZe3S1jjLdqq86yxkbwSaPcMIt+23O60TycfRyYamMUy+8dVxo
         zSnHBkl+rGqn77H53++vSSYkJPvoyJ69ke/rxlwvnLCtZLqj+bI8JxLkSSo6rGSC5Oa3
         hhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708717082; x=1709321882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Ei56rO+d2hPFaNX2QlE0LT758B0T2h/DVvm+aYD+0=;
        b=TNLsLgavn+JKY9D3/MKmX6FWQ92WUYiL/sK5LR7jILWqPZLklbEefsV8qmbrTwcniS
         oPH82ygMUhi5/hP9WEQuxJAt+9iEvrniQec+kuXNHMx0LKKkCqqz5APfcsAKESO35U/T
         vT/ZTUU2smr3tnj487Hgi7RqyPpq2SuF56TjTaJiNmTVKKxoTDcdT1hsrS8s/if2WUJB
         jeGVQ3w9BdVJsVsJE5xufO1jxH5iTU550sgEZovKPVnkk7/7pE+f9mbxcorjbj4s+Nyf
         xv3T/ZnXoEuNirQPXaC6zKpB2ZzbAYj6YTw0e6ewr55yJvLeOOiqgk4tUyTkeg7zOS8P
         gQkg==
X-Forwarded-Encrypted: i=1; AJvYcCU8nGShgBI9uPdvv8F/1XETpT2I2tHgX+cKiEW90hs739+q190SDihDKLE1M8UaOEKcEdAL7sevvfpyMKRKi5LqsxxLvbFixd2oEhsn
X-Gm-Message-State: AOJu0YxF0XZCnqBHz5dEAbgEH0LuvG2hGztCaXRdpKGSHnPB73ccwHdf
	t+++TH1ign0J60rGGFn15wOIGux1Lvziol8quFgx24QaRFLTPDkzs/ti2nxynv+w6rV2FePErtk
	c/WIit/pOOHvcs5pPf0BKtCLc7m2oxaXTNJKI
X-Google-Smtp-Source: AGHT+IGbFgpTFZj6aI9rDL1W91AgKD3/4EU+mIOLuj2k+nBXe55C4Zb5hKEHgJfZ57M0VkMCwx7SOWh6YcVjDwzp9wk=
X-Received: by 2002:a50:9f28:0:b0:562:9d2:8857 with SMTP id
 b37-20020a509f28000000b0056209d28857mr31091edf.6.1708717081634; Fri, 23 Feb
 2024 11:38:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez3RmV6SsVw9oyTXxQXHp3rqtKDk2qwJWo9TGvXCq7Xr-w@mail.gmail.com>
 <CAP-5=fXsFBwt9ARmQja0pKGL-_Vms_NDKeaH5CX=_om1aSvssw@mail.gmail.com>
 <ZdTIYLoJOdyu62LU@x1> <05d29733-cfc4-42e1-bbb1-a496d9522d0e@linux.intel.com>
 <CAG48ez2MVNBMcoa+Cm8CZR3ZAHfBms92RD+fEa-kCdirALxxjg@mail.gmail.com> <d5e10260-bec6-4499-9391-131450d5e43a@linux.intel.com>
In-Reply-To: <d5e10260-bec6-4499-9391-131450d5e43a@linux.intel.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 23 Feb 2024 20:37:24 +0100
Message-ID: <CAG48ez0KZgZ65qGw+i291cjBpGQB+KmmR10X8QB06O3H2imbYw@mail.gmail.com>
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

On Fri, Feb 23, 2024 at 4:52=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
> On 2024-02-22 3:07 p.m., Jann Horn wrote:
> > On Thu, Feb 22, 2024 at 9:05=E2=80=AFPM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >> Hi Jann,
> >>
> >> Sorry for the late response.
> >>
> >> On 2024-02-20 10:42 a.m., Arnaldo Carvalho de Melo wrote:
> >>> Just adding Joe Mario to the CC list.
> >>>
> >>> On Mon, Feb 19, 2024 at 03:20:00PM -0800, Ian Rogers wrote:
> >>>> On Mon, Feb 19, 2024 at 5:01=E2=80=AFAM Jann Horn <jannh@google.com>=
 wrote:
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> From what I understand, "perf c2c" shows bogus HitM events on Ice L=
ake
> >>>>> (and newer) because Intel added some feature where *clean* cachelin=
es
> >>>>> can get snoop-forwarded ("cross-core FWD"), and the PMU apparently
> >>>>> treats this mostly the same as snoop-forwarding of modified cache
> >>>>> lines (HitM)? On a Tiger Lake CPU, I can see addresses from the ker=
nel
> >>>>> rodata section in "perf c2c report".
> >>>>>
> >>>>> This is mentioned in the SDM, Volume 3B, section "20.9.7 Load Laten=
cy
> >>>>> Facility", table "Table 20-101. Data Source Encoding for Memory
> >>>>> Accesses (Ice Lake and Later Microarchitectures)", encoding 07H:
> >>>>> "XCORE FWD. This request was satisfied by a sibling core where eith=
er
> >>>>> a modified (cross-core HITM) or a non-modified (cross-core FWD)
> >>>>> cache-line copy was found."
> >>>>>
> >>>>> I don't see anything about this in arch/x86/events/intel/ds.c - if =
I
> >>>>> understand correctly, the kernel's PEBS data source decoding assume=
s
> >>>>> that 0x07 means "L3 hit, snoop hitm" on these CPUs. I think this ne=
eds
> >>>>> to be adjusted somehow - and maybe it just isn't possible to actual=
ly
> >>>>> distinguish between HitM and cross-core FWD in PEBS events on these
> >>>>> CPUs (without big-hammer chicken bit trickery)? Maybe someone from
> >>>>> Intel can clarify?
> >>>>>
> >>>>> (The SDM describes that E-cores on the newer 12th Gen have more
> >>>>> precise PEBS encodings that distinguish between "L3 HITM" and "L3
> >>>>> HITF"; but I guess the P-cores there maybe still don't let you
> >>>>> distinguish HITM/HITF?)
> >>
> >> Right, there is no way to distinguish HITM/HITF on Tiger Lake.
> >
> > Aah, okay, thank you very much for the clarification!
> >
> >> I think what we can do is to add both HITM and HITF for the 0x07 to
> >> match the SDM description.
> >>
> >> How about the below patch (not tested yet)?
> >> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> >> index d49d661ec0a7..8c966b5b23cb 100644
> >> --- a/arch/x86/events/intel/ds.c
> >> +++ b/arch/x86/events/intel/ds.c
> >> @@ -84,7 +84,7 @@ static u64 pebs_data_source[] =3D {
> >>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),  /* 0x04: L3=
 hit */
> >>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, MISS),  /* 0x05: L3=
 hit,
> >> snoop miss */
> >>         OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HIT),   /* 0x06: L3=
 hit,
> >> snoop hit */
> >> -       OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),  /* 0x07: L3=
 hit,
> >> snoop hitm */
> >> +       OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM) | P(SNOOPX, F=
WD),  /*
> >> 0x07: L3 hit, snoop hitm & fwd */
> >>         OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HIT),  /=
* 0x08:
> >> L3 miss snoop hit */
> >>         OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM), /=
* 0x09:
> >> L3 miss snoop hitm*/
> >>         OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, HIT),       /=
* 0x0a:
> >> L3 miss, shared */
> >
> > (I'm not familiar enough with the perf semantics to know how the event
> > encoding works, maybe someone else can have a look?)
> >
>
> I can do the test to verify the settings and perf c2c. But I don't have
> a benchmark. Could you please share your benchmark with me?
> For example, the data you used in your example.
> # perf record -e mem_load_l3_hit_retired.xsnp_fwd:ppp --all-kernel -c
> 100 --data

It seems to be happening at a low rate in the background when I'm just
clicking around on websites or such; but it seems like compiling the
kernel with "make -j8" (where 8 is the number of hyperthreads my
Tiger Lake laptop has) causes it to happen at a somewhat higher rate,
a few times per second.

Sorry, I don't really have a particularly good microbenchmark or such
that makes this happen at an abnormally high rate...

