Return-Path: <linux-kernel+bounces-85332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD786B45D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C73B28AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFF51C10;
	Wed, 28 Feb 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JDFkxJ0h"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E31487DC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136747; cv=none; b=MC5M35hXie8M0ZtfzX5A0VlvvnoG7vBP8Qm4E0l1UB/DIdePk/hINxuc9yA975sDPNBQ2IVAnwbRoSfcFgKkKyrW0OBvuYsDyBPx7NIZfVoOK3nUT8WFPVIwSJogd1ndrPWsh+eTIEysksC18E1Zdz8NqTKVV19Acj19H4tH0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136747; c=relaxed/simple;
	bh=3UweN7WPB8HkIEI9xU6RyV0bUz6iEq9j8kAvjeh6lEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zjr65W/calFOwBR3bBloewI+cIMDCdtewz5oA2WhT21q0TjVKaG0v0LfNrbZ966TWpQ8y6yimBvFquM/+0C6oldtZY8v4AmOZpg6bfvW3pk2GO1ncuM3GmnsgzmhL4hqhoaM7jjIAvlIudPoa4b1K71ROnPrEt7Sg8bjYC45nF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDFkxJ0h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc9f4d1106so158085ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709136745; x=1709741545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctCs1OiEXfyqG2/re0ieLXZ0DdC09+Ht0deRSxCZ2Xo=;
        b=JDFkxJ0hL9dgrsG8mvdEqDaZkYjJMmIsCbd1MA/dtzFh9Og+F2XFyElVAVsDdcOUIn
         nUQe96C4JmOXiBI8mV+YqLUj5EZI+oJk+xg3+8LPEi/aAQgKHWwu3ccNfUVJFFbiEbCd
         fDgBoBwgs9cVKEFoKGslMEbE3X4whHDAIZyMmqasbq1Ucc8HVqbV8t8y/+2HPz5IsmXu
         QsthseezO//TDFN3nknLDEVPnaPCzyJ/zYae5BBlWeLvHJwm5JphFCUjSAJqAIal6zC1
         fEppPDdQ60NPevsNqfypHwp23wSmddXXohueTVI3gEOPYjblGxlvm8PjHwu8SHGqfDWg
         +nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136745; x=1709741545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctCs1OiEXfyqG2/re0ieLXZ0DdC09+Ht0deRSxCZ2Xo=;
        b=g9TqNr6nNTeUN2Pey3fhW5mKLkDflHS7EPDJXs09hfA+J3QWXcNqr3avIpu5EhlEKD
         wMZ8N5i/soMAIxI81DTgPH6icXQVGAi14omsvkntvWW+j3EQjSkBYZs4laPiECGAVCjZ
         bsZ7ZOaGP7069kJ8DOAa2Ll+DFOwVQYuTP5ZWtXcIsmwC5W+Jrfq/7Y3gwB57/zadVv3
         d2GnUzBbVyPCz3Bae2AaapwT7pqaQRLc5H3hItm6lMLe5kSQ39A149gTJ6AwzBGeYuTd
         AAgZ8tAqza2uhNMiQcyRevUKlKFGSlqT9WHF2ajn11nR2siZLcreYXzy7CwhkNSJx1Rg
         9KBw==
X-Forwarded-Encrypted: i=1; AJvYcCUsOEbvJCTb7dDeOnNTTonvmBt8ycaAkFrfYcTzWgIW/w2xDPpE2AJLSOkh6gXvFoslp/MT2ZlX1e+LMXhq26OtToaJfYkzQIemJbfZ
X-Gm-Message-State: AOJu0YzzLkSxziOW267QmhiZcRocBK2p/yUiwealdr3JxmE3GVdOtJ+l
	p+UT/rInU9bSG0A/4BFVoYBABWi5WSpwwGXR7LpB3yUj3K4t9P40rSYLBewfuM/PI5qrA9mjd2x
	0riiH32crJCi2xO3C4hlbAUhWxIXYMVXyXn0L
X-Google-Smtp-Source: AGHT+IF6C2Bk0WCV4pL0W7KObl7VCOoAgxFvvL3Nt5iTSKKrFcvkS3anQu2GUv5O3p2fh9OSQ46+4ElEuu3+LZZgtsA=
X-Received: by 2002:a17:902:d510:b0:1db:e1f6:b62 with SMTP id
 b16-20020a170902d51000b001dbe1f60b62mr58850plg.25.1709136744458; Wed, 28 Feb
 2024 08:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226201517.3540187-1-irogers@google.com> <0b2ff06f-099c-424a-97b5-fdf638892e41@linux.intel.com>
 <CAP-5=fVTOgOO=N7uf4CaANWu+WCCLXXMuNBnDdBOP3E6vijG_A@mail.gmail.com> <2b950564-fe20-4426-ac91-5b40a2087099@linux.intel.com>
In-Reply-To: <2b950564-fe20-4426-ac91-5b40a2087099@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Feb 2024 08:12:10 -0800
Message-ID: <CAP-5=fURvd4nx_-QLgRBWSoJbXDUqO=WbsLkqMgjiyucXHVrjw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events intel: Add umasks to PCU events.
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:55=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-02-27 9:12 p.m., Ian Rogers wrote:
> > On Tue, Feb 27, 2024 at 6:12=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-02-26 3:15 p.m., Ian Rogers wrote:
> >>> UMasks were being dropped leading to all PCU
> >>> UNC_P_POWER_STATE_OCCUPANCY events having the same encoding. Don't
> >>> drop the umask trying to be consistent with other sources of events
> >>> like libpfm4 [1]. This applies the change from [2].
> >>>
> >>> [1] https://sourceforge.net/p/perfmon2/libpfm4/ci/master/tree/lib/eve=
nts/intel_skx_unc_pcu_events.h#l30
> >>> [2] https://github.com/captain5050/perfmon/commit/661a229996493448095=
fb55415ed568ceabc631b
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>
> >> Thanks Ian.
> >>
> >> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Thanks,
> >> Kan
> >>
> >>>  tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json  | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json   | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json     | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json     | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json      | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json     | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json     | 3 ++=
+
> >>>  tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json   | 3 ++=
+
> >>>  9 files changed, 27 insertions(+)
> >>>
> >>> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.=
json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> >>> index 83d20130c217..9a0bc34c08e1 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> >>> @@ -396,6 +396,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -404,6 +405,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -412,6 +414,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.j=
son b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> >>> index 83d20130c217..9a0bc34c08e1 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> >>> @@ -396,6 +396,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -404,6 +405,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -412,6 +414,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power=
json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> >>> index c6254af7a468..ceef46046488 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> >>> @@ -144,6 +144,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -152,6 +153,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -160,6 +162,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> >>> index daebf1050acb..15097511cbd8 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> >>> @@ -428,6 +428,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -436,6 +437,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -444,6 +446,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> >>> index ee4dac6fc797..920cab6ffe37 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> >>> @@ -151,6 +151,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "Number of cores in C-State : C0 and C1=
 : This is an occupancy event that tracks the number of cores that are in t=
he chosen C-State.  It can be used by itself to get the average number of c=
ores in that C-state with thresholding to generate histograms, or with othe=
r PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -159,6 +160,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "Number of cores in C-State : C3 : This=
 is an occupancy event that tracks the number of cores that are in the chos=
en C-State.  It can be used by itself to get the average number of cores in=
 that C-state with thresholding to generate histograms, or with other PCU e=
vents and occupancy triggering to capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -167,6 +169,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "Number of cores in C-State : C6 and C7=
 : This is an occupancy event that tracks the number of cores that are in t=
he chosen C-State.  It can be used by itself to get the average number of c=
ores in that C-state with thresholding to generate histograms, or with othe=
r PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json=
 b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> >>> index 5df1ebfb89ea..4dac5810324b 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> >>> @@ -516,6 +516,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x40",
> >
> > There's something wrong on Ivytown, I don't see a umask format in uncor=
e_pmu:
> > ```
> > $ ls /sys/devices/uncore_pcu/format/
> > edge   filter_band0  filter_band2  occ_edge    occ_sel
> > event  filter_band1  filter_band3  occ_invert  thresh
> > ```
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/x86/events/intel/uncore_snbep.c#n1606
> >
> > It does exist for skylake though:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/x86/events/intel/uncore_snbep.c#n4145
> >
> > Kan, what's the right way to deal with this?
>
> There is no umask in the uncore spec. Please see P120 of the spec.
> https://www.intel.com/content/www/us/en/develop/download/intel-xeon-proce=
ssor-e5-2600-v2-product-family-uncore-performance-monitoring-reference.html
>
> It should be occ_sel.
> The occ_sel =3D (the umask from the event list >> 6) & 0x3.
>
> I don't think we want to change either the kernel or the perf tool.
> There is nothing to help either if we add the occ_sel in the original
> event list. So it seems the only choice should be handling it in the
> convertor tool.
>
> Is it possible to check the UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 in IVT
> and use "Filter": "occ_sel=3D0x1" to replace "UMask": "0x40"?
>
> It seems everything in the filter will directly be appended. Is my
> understanding correct?

Yep. From the manual:
C0 =3D 1
C3 =3D 2
C6=3D 3
So I'll need to fix all 3 events during the conversion to perf json.
The same problem exists for haswell and broadwell, so I'll do the fix
on those architectures too. I was able to test on a jaketown but the
kernel source makes me think the same fix is necessary there too. I'll
send out a new patch with this.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> > Thanks,
> > Ian
> >
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -524,6 +525,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -532,6 +534,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> >>> index b3ee5d741015..a83e07dce947 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> >>> @@ -235,6 +235,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in C0.  It can be used by itself to get the a=
verage number of cores in C0, with thresholding to generate histograms, or =
with other PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -243,6 +244,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in C0.  It can be used by itself to get the a=
verage number of cores in C0, with thresholding to generate histograms, or =
with other PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -251,6 +253,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in C0.  It can be used by itself to get the a=
verage number of cores in C0, with thresholding to generate histograms, or =
with other PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> >>> index c6254af7a468..ceef46046488 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> >>> @@ -144,6 +144,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -152,6 +153,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -160,6 +162,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "This is an occupancy event that tracks=
 the number of cores that are in the chosen C-State.  It can be used by its=
elf to get the average number of cores in that C-state with thresholding to=
 generate histograms, or with other PCU events and occupancy triggering to =
capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.j=
son b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> >>> index a61ffca2dfea..dcf268467db9 100644
> >>> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> >>> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> >>> @@ -150,6 +150,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "Number of cores in C-State : C0 and C1=
 : This is an occupancy event that tracks the number of cores that are in t=
he chosen C-State.  It can be used by itself to get the average number of c=
ores in that C-state with thresholding to generate histograms, or with othe=
r PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0x40",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -158,6 +159,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "Number of cores in C-State : C3 : This=
 is an occupancy event that tracks the number of cores that are in the chos=
en C-State.  It can be used by itself to get the average number of cores in=
 that C-state with thresholding to generate histograms, or with other PCU e=
vents and occupancy triggering to capture other details.",
> >>> +        "UMask": "0x80",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >>> @@ -166,6 +168,7 @@
> >>>          "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
> >>>          "PerPkg": "1",
> >>>          "PublicDescription": "Number of cores in C-State : C6 and C7=
 : This is an occupancy event that tracks the number of cores that are in t=
he chosen C-State.  It can be used by itself to get the average number of c=
ores in that C-state with thresholding to generate histograms, or with othe=
r PCU events and occupancy triggering to capture other details.",
> >>> +        "UMask": "0xc0",
> >>>          "Unit": "PCU"
> >>>      },
> >>>      {
> >

