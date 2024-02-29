Return-Path: <linux-kernel+bounces-86024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0FE86BEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9FB1F243AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A76364D6;
	Thu, 29 Feb 2024 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WU9db1Lq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F323DB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172118; cv=none; b=Q9DjoLM/83zlJu2rKVNM3vrY43Yw2+Ek7dAhhvy3kbAS5yS646Pg47n6oAYaN1eJUPivyYpgjXlKBccScdziZtOAYXjcYZ2h79W6JvNIhlahNZyyLx1QvWDr/ntmzWO+mDTz45nHeAdDoxSn2Zue8USSDCkbGoQdKhXQ4r88byY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172118; c=relaxed/simple;
	bh=ZnXVRBPSjh6UqPms6mxfcWJ6vX52wuM+E0Z4SkM6tlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riGXaipgXAUgHcasYqiX9fmJNl8FKCHO0KPDtg0EdkeDAOf5DLHw3CcuXs4yRGnC1EG7mAzJbq6RPkFwrBxIsa05L7ljPMS06VZaPoCYLY7y/1zKQz4Bh7kz7j6tPA5F6d1Zku9dArs06ksySDlY7So4rVBWX+r27to+unGcuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WU9db1Lq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc744f54d0so106255ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709172115; x=1709776915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDSp1+Yr48nay09vMiMuDFMCysAK1sPcsSwbOUnYdmU=;
        b=WU9db1Lq6Rv5a6wLOwQuPoN2bv09C0ZLDVPWKzCUIYQaVZn8VxH40GKdQzZV/L0ugu
         WMskXuNZ7hXlKME0GRIgbkFIK1wpQe0ycOTE7RwWg4LmXF/vKoZPuzfjgAxex2O5JWox
         Mk2YrV/jqrIFnnd8/DToSIZpWzhKtBU65kxE0uJbHvrPRK5xIJwXMKXKnCeThO4xZW82
         H806ZKijf09YpIEuyMDDYi3q5RQiZBA3IX0yYKXIUQQLA72IhTKc2oiWBgRFjOZwB6TU
         cts1ascdi452DvL45SP0e4e4ldiKFMuJi7eGRYACKPCv6Jsh/nWOqgk/M/EEj6IzexK+
         hWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709172115; x=1709776915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDSp1+Yr48nay09vMiMuDFMCysAK1sPcsSwbOUnYdmU=;
        b=dJiPheWq6BAp/FceX+s75lyWgcjA0Y1LQ6AVj1AarIjWlPM8ICW+lY7gUDagFJNzlw
         18YINsrAhBytINYTAxnpJIFRrVEywQ7hef6AjimUXZEVwo4spbbEKRMO9Qa41yLOomeL
         spZXPIpzPMPx50Y3GFeUVL9eH9MLHidjNH3gt4GPpHRHM+7rEG5BkL0SdihcqqL6MteK
         5pC8Yni9RLB/gkM42qjkN6mXDbNr433jgD3kZsnS+IKWLrH7C1Z2YUrx19QoJZHHQPoz
         xi1nw6PfmLDwOapZ09ekB2TBJWIqe/SIe4Xl2b+Nq2Dk2VslBFAVE657yl9SM0dW0V+C
         JrZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8eVVS7ZUONyJMrFgC2WKAt4m8XNrQxKSj+bnQlhEpHACMgNo9gGKxa0sr3k7gJ7SIVw/S1XZY/orSNceAOxotPOpDaB1ZtTbJh5Vi
X-Gm-Message-State: AOJu0YyXxbLkb9JvH48hfg3EgoVKvGQknGhFWE5EC3mHMURAE4S0CrVz
	z7yExGgqU346GfMggYXBFmGxRFt/pB5CGkta04wip7olY0NDnpYUYIxhTkAG9WFYki0HxhO2En+
	FaqCv/o+ZENA9rG7pRRC5Ci97RlwxeouHiQqK
X-Google-Smtp-Source: AGHT+IETuDKllbicy45vE3AeRAqiQXm+CMwM5js+/tlV62EHw4lwj3mYPzD8qUj4r2VaRBF7MelpvLgz396BhRz/Wnw=
X-Received: by 2002:a17:902:ec81:b0:1d9:2715:7e6c with SMTP id
 x1-20020a170902ec8100b001d927157e6cmr21281plg.19.1709172114023; Wed, 28 Feb
 2024 18:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228161227.484886-1-weilin.wang@intel.com>
 <20240228161227.484886-7-weilin.wang@intel.com> <CAP-5=fVmKy9tWoQga7fBoNFSrYnWWfPwrCg5tHGMpygZVkUvOQ@mail.gmail.com>
 <CO6PR11MB563505B42CE1821BD5CA4C45EE5F2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563505B42CE1821BD5CA4C45EE5F2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Feb 2024 18:01:41 -0800
Message-ID: <CAP-5=fUiw8ShMhjFAkORwj7P5EZ0jw+A6v9_0NbRo0Pd3ca-bA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] perf vendor events intel: Add MTL metric json files
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:36=E2=80=AFPM Wang, Weilin <weilin.wang@intel.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Wednesday, February 28, 2024 8:50 AM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.co=
m>;
> > Arnaldo Carvalho de Melo <acme@kernel.org>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Nam=
hyung
> > Kim <namhyung@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>;
> > Kan Liang <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org=
;
> > linux-kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; A=
lt,
> > Samantha <samantha.alt@intel.com>; Biggers, Caleb
> > <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v2 6/6] perf vendor events intel: Add MTL metri=
c json
> > files
> >
> > On Wed, Feb 28, 2024 at 8:12=E2=80=AFAM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Add MTL metric json file at TMA4.7 [1]. Some of the metrics' formulas=
 use
> > TPEBS
> > > retire_latency in MTL.
> > >
> > > [1] https://lore.kernel.org/all/20240214011820.644458-1-
> > irogers@google.com/
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  .../arch/x86/meteorlake/metricgroups.json     |  127 +
> > >  .../arch/x86/meteorlake/mtl-metrics.json      | 2531 +++++++++++++++=
++
> > >  2 files changed, 2658 insertions(+)
> > >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/meteorlake/metricgroups.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-
> > metrics.json
> > >
> > > diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.j=
son
> > b/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
> > > new file mode 100644
> > > index 000000000000..7a03835f262c
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
> > > @@ -0,0 +1,127 @@
> > > +{
> > > +    "Backend": "Grouping from Top-down Microarchitecture Analysis Me=
trics
> > spreadsheet",
> > > +    "Bad": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "BadSpec": "Grouping from Top-down Microarchitecture Analysis Me=
trics
> > spreadsheet",
> > > +    "BigFootprint": "Grouping from Top-down Microarchitecture Analys=
is
> > Metrics spreadsheet",
> > > +    "BrMispredicts": "Grouping from Top-down Microarchitecture Analy=
sis
> > Metrics spreadsheet",
> > > +    "Branches": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "C0Wait": "Grouping from Top-down Microarchitecture Analysis Met=
rics
> > spreadsheet",
> > > +    "CacheHits": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "CodeGen": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "Compute": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "Cor": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "DSB": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "DSBmiss": "Grouping from Top-down Microarchitecture Analysis Me=
trics
> > spreadsheet",
> > > +    "DataSharing": "Grouping from Top-down Microarchitecture Analysi=
s
> > Metrics spreadsheet",
> > > +    "Fed": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "FetchBW": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "FetchLat": "Grouping from Top-down Microarchitecture Analysis M=
etrics
> > spreadsheet",
> > > +    "Flops": "Grouping from Top-down Microarchitecture Analysis Metr=
ics
> > spreadsheet",
> > > +    "FpScalar": "Grouping from Top-down Microarchitecture Analysis M=
etrics
> > spreadsheet",
> > > +    "FpVector": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "Frontend": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "HPC": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "IcMiss": "Grouping from Top-down Microarchitecture Analysis Met=
rics
> > spreadsheet",
> > > +    "InsType": "Grouping from Top-down Microarchitecture Analysis Me=
trics
> > spreadsheet",
> > > +    "IntVector": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "L2Evicts": "Grouping from Top-down Microarchitecture Analysis M=
etrics
> > spreadsheet",
> > > +    "LSD": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "MachineClears": "Grouping from Top-down Microarchitecture Analy=
sis
> > Metrics spreadsheet",
> > > +    "Machine_Clears": "Grouping from Top-down Microarchitecture Anal=
ysis
> > Metrics spreadsheet",
> > > +    "Mem": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "MemOffcore": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "MemoryBW": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "MemoryBound": "Grouping from Top-down Microarchitecture Analysi=
s
> > Metrics spreadsheet",
> > > +    "MemoryLat": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "MemoryTLB": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "Memory_BW": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "Memory_Lat": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "MicroSeq": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "OS": "Grouping from Top-down Microarchitecture Analysis Metrics
> > spreadsheet",
> > > +    "Offcore": "Grouping from Top-down Microarchitecture Analysis Me=
trics
> > spreadsheet",
> > > +    "PGO": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "Pipeline": "Grouping from Top-down Microarchitecture Analysis M=
etrics
> > spreadsheet",
> > > +    "PortsUtil": "Grouping from Top-down Microarchitecture Analysis =
Metrics
> > spreadsheet",
> > > +    "Power": "Grouping from Top-down Microarchitecture Analysis Metr=
ics
> > spreadsheet",
> > > +    "Prefetches": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "Ret": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "Retire": "Grouping from Top-down Microarchitecture Analysis Met=
rics
> > spreadsheet",
> > > +    "SMT": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "Server": "Grouping from Top-down Microarchitecture Analysis Met=
rics
> > spreadsheet",
> > > +    "Snoop": "Grouping from Top-down Microarchitecture Analysis Metr=
ics
> > spreadsheet",
> > > +    "SoC": "Grouping from Top-down Microarchitecture Analysis Metric=
s
> > spreadsheet",
> > > +    "Summary": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "TmaL1": "Grouping from Top-down Microarchitecture Analysis Metr=
ics
> > spreadsheet",
> > > +    "TmaL2": "Grouping from Top-down Microarchitecture Analysis Metr=
ics
> > spreadsheet",
> > > +    "TmaL3mem": "Grouping from Top-down Microarchitecture Analysis
> > Metrics spreadsheet",
> > > +    "TopdownL1": "Metrics for top-down breakdown at level 1",
> > > +    "TopdownL2": "Metrics for top-down breakdown at level 2",
> > > +    "TopdownL3": "Metrics for top-down breakdown at level 3",
> > > +    "TopdownL4": "Metrics for top-down breakdown at level 4",
> > > +    "TopdownL5": "Metrics for top-down breakdown at level 5",
> > > +    "TopdownL6": "Metrics for top-down breakdown at level 6",
> > > +    "tma_L1_group": "Metrics for top-down breakdown at level 1",
> > > +    "tma_L2_group": "Metrics for top-down breakdown at level 2",
> > > +    "tma_L3_group": "Metrics for top-down breakdown at level 3",
> > > +    "tma_L4_group": "Metrics for top-down breakdown at level 4",
> > > +    "tma_L5_group": "Metrics for top-down breakdown at level 5",
> > > +    "tma_L6_group": "Metrics for top-down breakdown at level 6",
> > > +    "tma_alu_op_utilization_group": "Metrics contributing to
> > tma_alu_op_utilization category",
> > > +    "tma_assists_group": "Metrics contributing to tma_assists catego=
ry",
> > > +    "tma_backend_bound_aux_group": "Metrics contributing to
> > tma_backend_bound_aux category",
> > > +    "tma_backend_bound_group": "Metrics contributing to
> > tma_backend_bound category",
> > > +    "tma_bad_speculation_group": "Metrics contributing to
> > tma_bad_speculation category",
> > > +    "tma_base_group": "Metrics contributing to tma_base category",
> > > +    "tma_branch_mispredicts_group": "Metrics contributing to
> > tma_branch_mispredicts category",
> > > +    "tma_branch_resteers_group": "Metrics contributing to
> > tma_branch_resteers category",
> > > +    "tma_core_bound_group": "Metrics contributing to tma_core_bound
> > category",
> > > +    "tma_dram_bound_group": "Metrics contributing to tma_dram_bound
> > category",
> > > +    "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load
> > category",
> > > +    "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store
> > category",
> > > +    "tma_fetch_bandwidth_group": "Metrics contributing to
> > tma_fetch_bandwidth category",
> > > +    "tma_fetch_latency_group": "Metrics contributing to tma_fetch_la=
tency
> > category",
> > > +    "tma_fp_arith_group": "Metrics contributing to tma_fp_arith cate=
gory",
> > > +    "tma_fp_vector_group": "Metrics contributing to tma_fp_vector
> > category",
> > > +    "tma_frontend_bound_group": "Metrics contributing to
> > tma_frontend_bound category",
> > > +    "tma_heavy_operations_group": "Metrics contributing to
> > tma_heavy_operations category",
> > > +    "tma_int_operations_group": "Metrics contributing to
> > tma_int_operations category",
> > > +    "tma_issue2P": "Metrics related by the issue $issue2P",
> > > +    "tma_issueBM": "Metrics related by the issue $issueBM",
> > > +    "tma_issueBW": "Metrics related by the issue $issueBW",
> > > +    "tma_issueComp": "Metrics related by the issue $issueComp",
> > > +    "tma_issueD0": "Metrics related by the issue $issueD0",
> > > +    "tma_issueFB": "Metrics related by the issue $issueFB",
> > > +    "tma_issueFL": "Metrics related by the issue $issueFL",
> > > +    "tma_issueL1": "Metrics related by the issue $issueL1",
> > > +    "tma_issueLat": "Metrics related by the issue $issueLat",
> > > +    "tma_issueMC": "Metrics related by the issue $issueMC",
> > > +    "tma_issueMS": "Metrics related by the issue $issueMS",
> > > +    "tma_issueMV": "Metrics related by the issue $issueMV",
> > > +    "tma_issueRFO": "Metrics related by the issue $issueRFO",
> > > +    "tma_issueSL": "Metrics related by the issue $issueSL",
> > > +    "tma_issueSO": "Metrics related by the issue $issueSO",
> > > +    "tma_issueSmSt": "Metrics related by the issue $issueSmSt",
> > > +    "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
> > > +    "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
> > > +    "tma_issueTLB": "Metrics related by the issue $issueTLB",
> > > +    "tma_l1_bound_group": "Metrics contributing to tma_l1_bound
> > category",
> > > +    "tma_l3_bound_group": "Metrics contributing to tma_l3_bound
> > category",
> > > +    "tma_light_operations_group": "Metrics contributing to
> > tma_light_operations category",
> > > +    "tma_load_op_utilization_group": "Metrics contributing to
> > tma_load_op_utilization category",
> > > +    "tma_machine_clears_group": "Metrics contributing to
> > tma_machine_clears category",
> > > +    "tma_mem_latency_group": "Metrics contributing to tma_mem_latenc=
y
> > category",
> > > +    "tma_mem_scheduler_group": "Metrics contributing to
> > tma_mem_scheduler category",
> > > +    "tma_memory_bound_group": "Metrics contributing to
> > tma_memory_bound category",
> > > +    "tma_microcode_sequencer_group": "Metrics contributing to
> > tma_microcode_sequencer category",
> > > +    "tma_mite_group": "Metrics contributing to tma_mite category",
> > > +    "tma_nuke_group": "Metrics contributing to tma_nuke category",
> > > +    "tma_other_light_ops_group": "Metrics contributing to
> > tma_other_light_ops category",
> > > +    "tma_ports_utilization_group": "Metrics contributing to
> > tma_ports_utilization category",
> > > +    "tma_ports_utilized_0_group": "Metrics contributing to
> > tma_ports_utilized_0 category",
> > > +    "tma_ports_utilized_3m_group": "Metrics contributing to
> > tma_ports_utilized_3m category",
> > > +    "tma_resource_bound_group": "Metrics contributing to
> > tma_resource_bound category",
> > > +    "tma_retiring_group": "Metrics contributing to tma_retiring cate=
gory",
> > > +    "tma_serializing_operation_group": "Metrics contributing to
> > tma_serializing_operation category",
> > > +    "tma_store_bound_group": "Metrics contributing to tma_store_boun=
d
> > category",
> > > +    "tma_store_op_utilization_group": "Metrics contributing to
> > tma_store_op_utilization category"
> > > +}
> > > diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.js=
on
> > b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> > > new file mode 100644
> > > index 000000000000..12df19538fd6
> > > --- /dev/null
> > > +++ b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> > > @@ -0,0 +1,2531 @@
> > > +[
> > > +    {
> > > +        "BriefDescription": "C10 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C10_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C1 residency percent per core",
> > > +        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C1_Core_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C2 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C2_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C3 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C3_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C6 residency percent per core",
> > > +        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C6_Core_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C6 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C6_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C7 residency percent per core",
> > > +        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C7_Core_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C7 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C7_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C8 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C8_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "C9 residency percent per package",
> > > +        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "C9_Pkg_Residency",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of cycles spent in System Ma=
nagement
> > Interrupts.",
> > > +        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@sm=
i@ >
> > 0 else 0)",
> > > +        "MetricGroup": "smi",
> > > +        "MetricName": "smi_cycles",
> > > +        "MetricThreshold": "smi_cycles > 0.1",
> > > +        "ScaleUnit": "100%"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Number of SMI interrupts.",
> > > +        "MetricExpr": "msr@smi@",
> > > +        "MetricGroup": "smi",
> > > +        "MetricName": "smi_num",
> > > +        "ScaleUnit": "1SMI#"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to certain allocation restrictions.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_resource_bound_group",
> > > +        "MetricName": "tma_alloc_restriction",
> > > +        "MetricThreshold": "tma_alloc_restriction > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the total number of issue slots =
 that were
> > not consumed by the backend due to backend stalls",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_backend_bound",
> > > +        "MetricThreshold": "tma_backend_bound > 0.1",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "PublicDescription": "Counts the total number of issue slots=
  that were
> > not consumed by the backend due to backend stalls.  Note that uops must=
 be
> > available for consumption in order for this event to count.  If a uop i=
s not
> > available (IQ is empty), this event will not count.   The rest of these=
 subevents
> > count backend stalls, in cycles, due to an outstanding request which is
> > memory bound vs core bound.   The subevents are not slot based events a=
nd
> > therefore can not be precisely added or subtracted from the
> > Backend_Bound_Aux subevents which are slot based.",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the total number of issue slots =
 that were
> > not consumed by the backend due to backend stalls",
> > > +        "MetricExpr": "tma_backend_bound",
> > > +        "MetricGroup": "TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_backend_bound_aux",
> > > +        "MetricThreshold": "tma_backend_bound_aux > 0.2",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "PublicDescription": "Counts the total number of issue slots=
  that were
> > not consumed by the backend due to backend stalls.  Note that UOPS must=
 be
> > available for consumption in order for this event to count.  If a uop i=
s not
> > available (IQ is empty), this event will not count.  All of these subev=
ents count
> > backend stalls, in slots, due to a resource limitation.   These are not=
 cycle based
> > events and therefore can not be precisely added or subtracted from the
> > Backend_Bound subevents which are cycle based.  These subevents are
> > supplementary to Backend_Bound and can be used to analyze results from =
a
> > resource perspective at allocation.",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the total number of issue slots =
that were
> > not consumed by the backend because allocation is stalled due to a
> > mispredicted jump or a machine clear",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.ALL@ /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_bad_speculation",
> > > +        "MetricThreshold": "tma_bad_speculation > 0.15",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "PublicDescription": "Counts the total number of issue slots=
 that were
> > not consumed by the backend because allocation is stalled due to a
> > mispredicted jump or a machine clear. Only issue slots wasted due to fa=
st
> > nukes such as memory ordering nukes are counted. Other nukes are not
> > accounted for. Counts all issue slots blocked during this recovery wind=
ow
> > including relevant microcode flows and while uops are not yet available=
 in the
> > instruction queue (IQ). Also includes the issue slots that were consume=
d by
> > the backend but were thrown away because they were younger than the
> > mispredict or machine clear.",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of uops that are not =
from the
> > microsequencer.",
> > > +        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ -
> > cpu_atom@UOPS_RETIRED.MS@) / tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
> > > +        "MetricName": "tma_base",
> > > +        "MetricThreshold": "tma_base > 0.6",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to BACLEARS, which occurs when the Branch
> > Target Buffer (BTB) prediction or lack thereof, was corrected by a late=
r branch
> > predictor in the frontend",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@
> > / tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> > > +        "MetricName": "tma_branch_detect",
> > > +        "MetricThreshold": "tma_branch_detect > 0.05",
> > > +        "PublicDescription": "Counts the number of issue slots  that=
 were not
> > delivered by the frontend due to BACLEARS, which occurs when the Branch
> > Target Buffer (BTB) prediction or lack thereof, was corrected by a late=
r branch
> > predictor in the frontend. Includes BACLEARS due to all branch types in=
cluding
> > conditional and unconditional jumps, returns, and indirect branches.",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to branch mispredicts.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_bad_speculation_group",
> > > +        "MetricName": "tma_branch_mispredicts",
> > > +        "MetricThreshold": "tma_branch_mispredicts > 0.05",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to BTCLEARS, which occurs when the Branch
> > Target Buffer (BTB) predicts a taken branch.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> > > +        "MetricName": "tma_branch_resteer",
> > > +        "MetricThreshold": "tma_branch_resteer > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to the microcode sequencer (MS).",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
> > > +        "MetricName": "tma_cisc",
> > > +        "MetricThreshold": "tma_cisc > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles due to back=
end
> > bound stalls that are core execution bound and not attributed to outsta=
nding
> > demand load or store stalls.",
> > > +        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)"=
,
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_backend_bound_group",
> > > +        "MetricName": "tma_core_bound",
> > > +        "MetricThreshold": "tma_core_bound > 0.1",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to decode stalls.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
> > > +        "MetricName": "tma_decode",
> > > +        "MetricThreshold": "tma_decode > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of machine clears rel=
ative to
> > the number of nuke slots due to memory disambiguation.",
> > > +        "MetricExpr": "tma_nuke *
> > (cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ /
> > cpu_atom@MACHINE_CLEARS.SLOW@)",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> > > +        "MetricName": "tma_disambiguation",
> > > +        "MetricThreshold": "tma_disambiguation > 0.02",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles the core is=
 stalled due
> > to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
> > > +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_MISS@ /
> > tma_info_core_clks - max((cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ -
> > cpu_atom@LD_HEAD.L1_MISS_AT_RET@) / tma_info_core_clks, 0) *
> > cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_MISS@ /
> > cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_dram_bound",
> > > +        "MetricThreshold": "tma_dram_bound > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to a machine clear classified as a fast nuk=
e due
> > to memory ordering, memory disambiguation and memory renaming.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_machine_clears_group",
> > > +        "MetricName": "tma_fast_nuke",
> > > +        "MetricThreshold": "tma_fast_nuke > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to frontend bandwidth restrictions due to
> > decode, predecode, cisc, and other limitations.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_frontend_bound_group",
> > > +        "MetricName": "tma_fetch_bandwidth",
> > > +        "MetricThreshold": "tma_fetch_bandwidth > 0.1",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to frontend bandwidth restrictions due to
> > decode, predecode, cisc, and other limitations.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_frontend_bound_group",
> > > +        "MetricName": "tma_fetch_latency",
> > > +        "MetricThreshold": "tma_fetch_latency > 0.15",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of machine clears rel=
ative to
> > the number of nuke slots due to FP assists.",
> > > +        "MetricExpr": "tma_nuke *
> > (cpu_atom@MACHINE_CLEARS.FP_ASSIST@ /
> > cpu_atom@MACHINE_CLEARS.SLOW@)",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> > > +        "MetricName": "tma_fp_assist",
> > > +        "MetricThreshold": "tma_fp_assist > 0.02",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of floating point div=
ide
> > operations per uop.",
> > > +        "MetricExpr": "cpu_atom@UOPS_RETIRED.FPDIV@ /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
> > > +        "MetricName": "tma_fpdiv_uops",
> > > +        "MetricThreshold": "tma_fpdiv_uops > 0.2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to frontend stalls.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_frontend_bound",
> > > +        "MetricThreshold": "tma_frontend_bound > 0.2",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to instruction cache misses.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> > > +        "MetricName": "tma_icache_misses",
> > > +        "MetricThreshold": "tma_icache_misses > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "",
> > > +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@",
> > > +        "MetricName": "tma_info_core_clks",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "",
> > > +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@",
> > > +        "MetricName": "tma_info_core_clks_p",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Cycles Per Instruction",
> > > +        "MetricExpr": "tma_info_core_clks / INST_RETIRED.ANY",
> > > +        "MetricName": "tma_info_core_cpi",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions Per Cycle",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > tma_info_core_clks",
> > > +        "MetricName": "tma_info_core_ipc",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "",
> > > +        "MetricExpr": "6 * tma_info_core_clks",
> > > +        "MetricName": "tma_info_core_slots",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Uops Per Instruction",
> > > +        "MetricExpr": "cpu_atom@UOPS_RETIRED.ALL@ /
> > INST_RETIRED.ANY",
> > > +        "MetricName": "tma_info_core_upi",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percent of instruction miss cost that h=
it in DRAM",
> > > +        "MetricExpr": "100 *
> > cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_MISS@ /
> > cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
> > > +        "MetricName": "tma_info_frontend_inst_miss_cost_dramhit_perc=
ent",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percent of instruction miss cost that h=
it in the L2",
> > > +        "MetricExpr": "100 *
> > cpu_atom@MEM_BOUND_STALLS_IFETCH.L2_HIT@ /
> > cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
> > > +        "MetricName": "tma_info_frontend_inst_miss_cost_l2hit_percen=
t",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percent of instruction miss cost that h=
it in the L3",
> > > +        "MetricExpr": "100 *
> > cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_HIT@ /
> > cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
> > > +        "MetricName": "tma_info_frontend_inst_miss_cost_l3hit_percen=
t",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ratio of all branches which mispredict"=
,
> > > +        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ /
> > BR_INST_RETIRED.ALL_BRANCHES",
> > > +        "MetricName": "tma_info_inst_mix_branch_mispredict_ratio",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ratio between Mispredicted branches and
> > unknown branches",
> > > +        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ /
> > BACLEARS.ANY",
> > > +        "MetricName":
> > "tma_info_inst_mix_branch_mispredict_to_unknown_branch_ratio",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of all uops which are FPDiv =
uops",
> > > +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ /
> > UOPS_RETIRED.ALL",
> > > +        "MetricName": "tma_info_inst_mix_fpdiv_uop_ratio",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of all uops which are IDiv u=
ops",
> > > +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ /
> > UOPS_RETIRED.ALL",
> > > +        "MetricName": "tma_info_inst_mix_idiv_uop_ratio",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per Branch (lower number m=
eans
> > higher occurrence rate)",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > BR_INST_RETIRED.ALL_BRANCHES",
> > > +        "MetricName": "tma_info_inst_mix_ipbranch",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instruction per (near) call (lower numb=
er means
> > higher occurrence rate)",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > BR_INST_RETIRED.NEAR_CALL",
> > > +        "MetricName": "tma_info_inst_mix_ipcall",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per Far Branch",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > (cpu_atom@BR_INST_RETIRED.FAR_BRANCH@ / 2)",
> > > +        "MetricName": "tma_info_inst_mix_ipfarbranch",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per Load",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > MEM_UOPS_RETIRED.ALL_LOADS",
> > > +        "MetricName": "tma_info_inst_mix_ipload",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per retired conditional Br=
anch
> > Misprediction where the branch was not taken",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > (cpu_atom@BR_MISP_RETIRED.COND@ -
> > cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
> > > +        "MetricName": "tma_info_inst_mix_ipmisp_cond_ntaken",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per retired conditional Br=
anch
> > Misprediction where the branch was taken",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > BR_MISP_RETIRED.COND_TAKEN",
> > > +        "MetricName": "tma_info_inst_mix_ipmisp_cond_taken",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per retired indirect call =
or jump Branch
> > Misprediction",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > BR_MISP_RETIRED.INDIRECT",
> > > +        "MetricName": "tma_info_inst_mix_ipmisp_indirect",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per retired return Branch
> > Misprediction",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > BR_MISP_RETIRED.RETURN",
> > > +        "MetricName": "tma_info_inst_mix_ipmisp_ret",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per retired Branch Mispred=
iction",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > BR_MISP_RETIRED.ALL_BRANCHES",
> > > +        "MetricName": "tma_info_inst_mix_ipmispredict",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Instructions per Store",
> > > +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ /
> > MEM_UOPS_RETIRED.ALL_STORES",
> > > +        "MetricName": "tma_info_inst_mix_ipstore",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of all uops which are ucode =
ops",
> > > +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ /
> > UOPS_RETIRED.ALL",
> > > +        "MetricName": "tma_info_inst_mix_microcode_uop_ratio",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of all uops which are x87 uo=
ps",
> > > +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ /
> > UOPS_RETIRED.ALL",
> > > +        "MetricName": "tma_info_inst_mix_x87_uop_ratio",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of total non-speculative loa=
ds with a
> > address aliasing block",
> > > +        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.ADDRESS_ALIAS@ /
> > MEM_UOPS_RETIRED.ALL_LOADS",
> > > +        "MetricName": "tma_info_l1_bound_address_alias_blocks",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of total non-speculative loa=
ds that are
> > splits",
> > > +        "MetricExpr": "100 *
> > cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ /
> > MEM_UOPS_RETIRED.ALL_LOADS",
> > > +        "MetricName": "tma_info_l1_bound_load_splits",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Percentage of total non-speculative loa=
ds with a
> > store forward or unknown store address block",
> > > +        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ /
> > MEM_UOPS_RETIRED.ALL_LOADS",
> > > +        "MetricName": "tma_info_l1_bound_store_fwd_blocks",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Cycle cost per L2 hit",
> > > +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ /
> > MEM_LOAD_UOPS_RETIRED.L2_HIT",
> > > +        "MetricName": "tma_info_memory_cycles_per_demand_load_l2_hit=
",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Cycle cost per LLC hit",
> > > +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ /
> > MEM_LOAD_UOPS_RETIRED.L3_HIT",
> > > +        "MetricName": "tma_info_memory_cycles_per_demand_load_l3_hit=
",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "load ops retired per 1000 instruction",
> > > +        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ /
> > INST_RETIRED.ANY",
> > > +        "MetricName": "tma_info_memory_memloadpki",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Average CPU Utilization",
> > > +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
> > > +        "MetricName": "tma_info_system_cpu_utilization",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Fraction of cycles spent in Kernel mode=
",
> > > +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k /
> > CPU_CLK_UNHALTED.CORE",
> > > +        "MetricGroup": "Summary",
> > > +        "MetricName": "tma_info_system_kernel_utilization",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Average Frequency Utilization relative =
nominal
> > frequency",
> > > +        "MetricExpr": "tma_info_core_clks / CPU_CLK_UNHALTED.REF_TSC=
",
> > > +        "MetricGroup": "Power",
> > > +        "MetricName": "tma_info_system_turbo_utilization",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to Instruction Table Lookaside Buffer (IT=
LB)
> > misses.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB_MISS@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> > > +        "MetricName": "tma_itlb_misses",
> > > +        "MetricThreshold": "tma_itlb_misses > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles that the ol=
dest load of
> > the load buffer is stalled at retirement due to a load block.",
> > > +        "MetricExpr": "cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ /
> > tma_info_core_clks",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_l1_bound",
> > > +        "MetricThreshold": "tma_l1_bound > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles a core is s=
talled due to
> > a demand load which hit in the L2 Cache.",
> > > +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ /
> > tma_info_core_clks - max((cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ -
> > cpu_atom@LD_HEAD.L1_MISS_AT_RET@) / tma_info_core_clks, 0) *
> > cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ /
> > cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_l2_bound",
> > > +        "MetricThreshold": "tma_l2_bound > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles a core is s=
talled due to
> > a demand load which hit in the Last Level Cache (LLC) or other core wit=
h
> > HITE/F/M.",
> > > +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ /
> > tma_info_core_clks - max((cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ -
> > cpu_atom@LD_HEAD.L1_MISS_AT_RET@) / tma_info_core_clks, 0) *
> > cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ /
> > cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_l3_bound",
> > > +        "MetricThreshold": "tma_l3_bound > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles, relative t=
o the
> > number of mem_scheduler slots, in which uops are blocked due to load bu=
ffer
> > full",
> > > +        "MetricExpr": "tma_mem_scheduler *
> > cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ /
> > MEM_SCHEDULER_BLOCK.ALL",
> > > +        "MetricGroup":
> > "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
> > > +        "MetricName": "tma_ld_buffer",
> > > +        "MetricThreshold": "tma_ld_buffer > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the total number of issue slots =
that were
> > not consumed by the backend because allocation is stalled due to a mach=
ine
> > clear (nuke) of any kind including memory ordering and memory
> > disambiguation.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_bad_speculation_group",
> > > +        "MetricName": "tma_machine_clears",
> > > +        "MetricThreshold": "tma_machine_clears > 0.05",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to memory reservation stalls in which a
> > scheduler is not able to accept uops.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_resource_bound_group",
> > > +        "MetricName": "tma_mem_scheduler",
> > > +        "MetricThreshold": "tma_mem_scheduler > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles the core is=
 stalled due
> > to stores or loads.",
> > > +        "MetricExpr": "min(tma_backend_bound,
> > cpu_atom@LD_HEAD.ANY_AT_RET@ / tma_info_core_clks +
> > tma_store_bound)",
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_backend_bound_group",
> > > +        "MetricName": "tma_memory_bound",
> > > +        "MetricThreshold": "tma_memory_bound > 0.2",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of machine clears rel=
ative to
> > the number of nuke slots due to memory ordering.",
> > > +        "MetricExpr": "tma_nuke *
> > (cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ /
> > cpu_atom@MACHINE_CLEARS.SLOW@)",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> > > +        "MetricName": "tma_memory_ordering",
> > > +        "MetricThreshold": "tma_memory_ordering > 0.02",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of uops that are from=
 the
> > complex flows issued by the micro-sequencer (MS)",
> > > +        "MetricExpr": "cpu_atom@UOPS_RETIRED.MS@ /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
> > > +        "MetricName": "tma_ms_uops",
> > > +        "MetricThreshold": "tma_ms_uops > 0.05",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "PublicDescription": "Counts the number of uops that are fro=
m the
> > complex flows issued by the micro-sequencer (MS).  This includes uops f=
rom
> > flows due to complex instructions, faults, assists, and inserted flows.=
",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to IEC or FPC RAT stalls, which can be due =
to
> > FIQ or IEC reservation stalls in which the integer, floating point or S=
IMD
> > scheduler is not able to accept uops.",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_resource_bound_group",
> > > +        "MetricName": "tma_non_mem_scheduler",
> > > +        "MetricThreshold": "tma_non_mem_scheduler > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to a machine clear (slow nuke).",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_machine_clears_group",
> > > +        "MetricName": "tma_nuke",
> > > +        "MetricThreshold": "tma_nuke > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to other common frontend stalls not
> > categorized.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
> > > +        "MetricName": "tma_other_fb",
> > > +        "MetricThreshold": "tma_other_fb > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles that the ol=
dest load of
> > the load buffer is stalled at retirement due to a number of other load =
blocks.",
> > > +        "MetricExpr": "cpu_atom@LD_HEAD.OTHER_AT_RET@ /
> > tma_info_core_clks",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> > > +        "MetricName": "tma_other_l1",
> > > +        "MetricThreshold": "tma_other_l1 > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles the core is=
 stalled due
> > to a demand load miss which hits in the L2, LLC, DRAM or MMIO (Non-DRAM=
)
> > but could not be correctly attributed or cycles in which the load miss =
is waiting
> > on a request buffer.",
> > > +        "MetricExpr": "max(0, tma_memory_bound - (tma_store_bound +
> > tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound))",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_other_load_store",
> > > +        "MetricThreshold": "tma_other_load_store > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of uops retired exclu=
ding ms
> > and fp div uops.",
> > > +        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ -
> > cpu_atom@UOPS_RETIRED.MS@ - cpu_atom@UOPS_RETIRED.FPDIV@) /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
> > > +        "MetricName": "tma_other_ret",
> > > +        "MetricThreshold": "tma_other_ret > 0.3",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of machine clears rel=
ative to
> > the number of nuke slots due to page faults.",
> > > +        "MetricExpr": "tma_nuke *
> > (cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ /
> > cpu_atom@MACHINE_CLEARS.SLOW@)",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> > > +        "MetricName": "tma_page_fault",
> > > +        "MetricThreshold": "tma_page_fault > 0.02",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > delivered by the frontend due to wrong predecodes.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
> > > +        "MetricName": "tma_predecode",
> > > +        "MetricThreshold": "tma_predecode > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to the physical register file unable to acc=
ept an
> > entry (marble stalls).",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_resource_bound_group",
> > > +        "MetricName": "tma_register",
> > > +        "MetricThreshold": "tma_register > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to the reorder buffer being full (ROB stall=
s).",
> > > +        "MetricExpr":
> > "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_resource_bound_group",
> > > +        "MetricName": "tma_reorder_buffer",
> > > +        "MetricThreshold": "tma_reorder_buffer > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the total number of issue slots =
 that were
> > not consumed by the backend due to backend stalls",
> > > +        "MetricExpr": "tma_backend_bound",
> > > +        "MetricGroup":
> > "TopdownL2;tma_L2_group;tma_backend_bound_aux_group",
> > > +        "MetricName": "tma_resource_bound",
> > > +        "MetricThreshold": "tma_resource_bound > 0.2",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "PublicDescription": "Counts the total number of issue slots=
  that were
> > not consumed by the backend due to backend stalls.  Note that uops must=
 be
> > available for consumption in order for this event to count.  If a uop i=
s not
> > available (IQ is empty), this event will not count.",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
result in
> > retirement slots.",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ /
> > tma_info_core_slots",
> > > +        "MetricGroup": "TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_retiring",
> > > +        "MetricThreshold": "tma_retiring > 0.75",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles, relative t=
o the
> > number of mem_scheduler slots, in which uops are blocked due to RSV ful=
l
> > relative",
> > > +        "MetricExpr": "tma_mem_scheduler *
> > cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ /
> > MEM_SCHEDULER_BLOCK.ALL",
> > > +        "MetricGroup":
> > "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
> > > +        "MetricName": "tma_rsv",
> > > +        "MetricThreshold": "tma_rsv > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of issue slots  that =
were not
> > consumed by the backend due to scoreboards from the instruction queue
> > (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> > > +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ /
> > tma_info_core_slots",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_resource_bound_group",
> > > +        "MetricName": "tma_serialization",
> > > +        "MetricThreshold": "tma_serialization > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of machine clears rel=
ative to
> > the number of nuke slots due to SMC.",
> > > +        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.SMC@ /
> > cpu_atom@MACHINE_CLEARS.SLOW@)",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> > > +        "MetricName": "tma_smc",
> > > +        "MetricThreshold": "tma_smc > 0.02",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles, relative t=
o the
> > number of mem_scheduler slots, in which uops are blocked due to store b=
uffer
> > full",
> > > +        "MetricExpr": "tma_store_bound",
> > > +        "MetricGroup":
> > "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
> > > +        "MetricName": "tma_st_buffer",
> > > +        "MetricThreshold": "tma_st_buffer > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles that the ol=
dest load of
> > the load buffer is stalled at retirement due to a first level TLB miss.=
",
> > > +        "MetricExpr": "cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ /
> > tma_info_core_clks",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> > > +        "MetricName": "tma_stlb_hit",
> > > +        "MetricThreshold": "tma_stlb_hit > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles that the ol=
dest load of
> > the load buffer is stalled at retirement due to a second level TLB miss=
 requiring
> > a page walk.",
> > > +        "MetricExpr": "cpu_atom@LD_HEAD.PGWALK_AT_RET@ /
> > tma_info_core_clks",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> > > +        "MetricName": "tma_stlb_miss",
> > > +        "MetricThreshold": "tma_stlb_miss > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles the core is=
 stalled due
> > to store buffer full.",
> > > +        "MetricExpr": "tma_mem_scheduler *
> > (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ /
> > cpu_atom@MEM_SCHEDULER_BLOCK.ALL@)",
> > > +        "MetricGroup":
> > "TopdownL3;tma_L3_group;tma_memory_bound_group",
> > > +        "MetricName": "tma_store_bound",
> > > +        "MetricThreshold": "tma_store_bound > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Counts the number of cycles that the ol=
dest load of
> > the load buffer is stalled at retirement due to a store forward block."=
,
> > > +        "MetricExpr": "cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ /
> > tma_info_core_clks",
> > > +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> > > +        "MetricName": "tma_store_fwd_blk",
> > > +        "MetricThreshold": "tma_store_fwd_blk > 0.05",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_atom"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Uncore frequency per die [GHZ]",
> > > +        "MetricExpr": "tma_info_system_socket_clks / #num_dies /
> > duration_time / 1e9",
> > > +        "MetricGroup": "SoC",
> > > +        "MetricName": "UNCORE_FREQ",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric represents Core fraction of=
 cycles CPU
> > dispatched uops on execution ports for ALU operations.",
> > > +        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ +
> > cpu_core@UOPS_DISPATCHED.PORT_1@ +
> > cpu_core@UOPS_DISPATCHED.PORT_5_11@ +
> > cpu_core@UOPS_DISPATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
> > > +        "MetricGroup":
> > "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group",
> > > +        "MetricName": "tma_alu_op_utilization",
> > > +        "MetricThreshold": "tma_alu_op_utilization > 0.4",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates fraction of slots=
 the CPU
> > retired uops delivered by the Microcode_Sequencer as a result of Assist=
s",
> > > +        "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ /
> > tma_info_thread_slots",
> > > +        "MetricGroup":
> > "TopdownL4;tma_L4_group;tma_microcode_sequencer_group",
> > > +        "MetricName": "tma_assists",
> > > +        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_seque=
ncer >
> > 0.05 & tma_heavy_operations > 0.1)",
> > > +        "PublicDescription": "This metric estimates fraction of slot=
s the CPU
> > retired uops delivered by the Microcode_Sequencer as a result of Assist=
s.
> > Assists are long sequences of uops that are required in certain corner-=
cases for
> > operations that cannot be handled natively by the execution pipeline. F=
or
> > example; when working with very small floating point values (so-called
> > Denormals); the FP units are not set up to perform these operations nat=
ively.
> > Instead; a sequence of instructions to perform the computation on the
> > Denormals is injected into the pipeline. Since these microcode sequence=
s
> > might be dozens of uops long; Assists can be extremely deleterious to
> > performance and they can be avoided in many cases. Sample with:
> > ASSISTS.ANY",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates fraction of slots=
 the CPU
> > retired uops as a result of handing SSE to AVX* or AVX* to SSE transiti=
on
> > Assists.",
> > > +        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ /
> > tma_info_thread_slots",
> > > +        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group=
",
> > > +        "MetricName": "tma_avx_assists",
> > > +        "MetricThreshold": "tma_avx_assists > 0.1",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This category represents fraction of sl=
ots where no
> > uops are being delivered due to a lack of required resources for accept=
ing new
> > uops in the Backend",
> > > +        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ /
> > (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@
> > + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) +
> > 0 * tma_info_thread_slots",
> > > +        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_backend_bound",
> > > +        "MetricThreshold": "tma_backend_bound > 0.2",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "PublicDescription": "This category represents fraction of s=
lots where
> > no uops are being delivered due to a lack of required resources for acc=
epting
> > new uops in the Backend. Backend is the portion of the processor core w=
here
> > the out-of-order scheduler dispatches ready uops into their respective
> > execution units; and once completed these uops get retired according to
> > program order. For example; stalls due to data-cache misses or stalls d=
ue to
> > the divider unit being overloaded are both categorized under Backend Bo=
und.
> > Backend Bound is further divided into two main categories: Memory Bound
> > and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This category represents fraction of sl=
ots wasted
> > due to incorrect speculations",
> > > +        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bou=
nd +
> > tma_retiring), 0)",
> > > +        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> > > +        "MetricName": "tma_bad_speculation",
> > > +        "MetricThreshold": "tma_bad_speculation > 0.15",
> > > +        "MetricgroupNoGroup": "TopdownL1",
> > > +        "PublicDescription": "This category represents fraction of s=
lots wasted
> > due to incorrect speculations. This include slots used to issue uops th=
at do not
> > eventually get retired and slots for which the issue-pipeline was block=
ed due to
> > recovery from earlier incorrect speculation. For example; wasted work d=
ue to
> > miss-predicted branches are categorized under Bad Speculation category.
> > Incorrect data speculation followed by Memory Ordering Nukes is another
> > example.",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric represents fraction of slot=
s the CPU has
> > wasted due to Branch Misprediction",
> > > +        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ /
> > (cpu_core@topdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@
> > + cpu_core@topdown\\-retiring@ + cpu_core@topdown\\-be\\-bound@) +
> > 0 * tma_info_thread_slots",
> > > +        "MetricGroup":
> > "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group;tma_bad_specula
> > tion_group;tma_issueBM",
> > > +        "MetricName": "tma_branch_mispredicts",
> > > +        "MetricThreshold": "tma_branch_mispredicts > 0.1 &
> > tma_bad_speculation > 0.15",
> > > +        "MetricgroupNoGroup": "TopdownL2",
> > > +        "PublicDescription": "This metric represents fraction of slo=
ts the CPU
> > has wasted due to Branch Misprediction.  These slots are either wasted =
by
> > uops fetched from an incorrectly speculated program path; or stalls whe=
n the
> > out-of-order part of the machine needs to recover its state from a spec=
ulative
> > path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics:
> > tma_info_bad_spec_branch_misprediction_cost,
> > tma_info_bottleneck_mispredictions, tma_mispredicts_resteers",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric represents fraction of cycl=
es the CPU
> > was stalled due to Branch Resteers",
> > > +        "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ /
> > tma_info_thread_clks + tma_unknown_branches",
> > > +        "MetricGroup":
> > "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_group",
> > > +        "MetricName": "tma_branch_resteers",
> > > +        "MetricThreshold": "tma_branch_resteers > 0.05 &
> > (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15)",
> > > +        "PublicDescription": "This metric represents fraction of cyc=
les the CPU
> > was stalled due to Branch Resteers. Branch Resteers estimates the Front=
end
> > delay in fetching operations from corrected path; following all sorts o=
f miss-
> > predicted branches. For example; branchy code with lots of miss-predict=
ions
> > might get categorized under Branch Resteers. Note the value of this nod=
e may
> > overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric represents fraction of cycl=
es the CPU
> > was stalled due staying in C0.1 power-performance optimized state (Fast=
er
> > wakeup time; Smaller power savings).",
> > > +        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ /
> > tma_info_thread_clks",
> > > +        "MetricGroup":
> > "C0Wait;TopdownL4;tma_L4_group;tma_serializing_operation_group",
> > > +        "MetricName": "tma_c01_wait",
> > > +        "MetricThreshold": "tma_c01_wait > 0.05 &
> > (tma_serializing_operation > 0.1 & (tma_core_bound > 0.1 &
> > tma_backend_bound > 0.2))",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric represents fraction of cycl=
es the CPU
> > was stalled due staying in C0.2 power-performance optimized state (Slow=
er
> > wakeup time; Larger power savings).",
> > > +        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ /
> > tma_info_thread_clks",
> > > +        "MetricGroup":
> > "C0Wait;TopdownL4;tma_L4_group;tma_serializing_operation_group",
> > > +        "MetricName": "tma_c02_wait",
> > > +        "MetricThreshold": "tma_c02_wait > 0.05 &
> > (tma_serializing_operation > 0.1 & (tma_core_bound > 0.1 &
> > tma_backend_bound > 0.2))",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates fraction of cycle=
s the CPU
> > retired uops originated from CISC (complex instruction set computer)
> > instruction",
> > > +        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)=
",
> > > +        "MetricGroup":
> > "TopdownL4;tma_L4_group;tma_microcode_sequencer_group",
> > > +        "MetricName": "tma_cisc",
> > > +        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequence=
r >
> > 0.05 & tma_heavy_operations > 0.1)",
> > > +        "PublicDescription": "This metric estimates fraction of cycl=
es the CPU
> > retired uops originated from CISC (complex instruction set computer)
> > instruction. A CISC instruction has multiple uops that are required to =
perform
> > the instruction's functionality as in the case of read-modify-write as =
an
> > example. Since these instructions require multiple uops they may or may=
 not
> > imply sub-optimal use of machine resources. Sample with:
> > FRONTEND_RETIRED.MS_FLOWS",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric represents fraction of cycl=
es the CPU
> > was stalled due to Branch Resteers as a result of Machine Clears",
> > > +        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_specula=
tion) *
> > cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
> > > +        "MetricGroup":
> > "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_branch_resteers_gr
> > oup;tma_issueMC",
> > > +        "MetricName": "tma_clears_resteers",
> > > +        "MetricThreshold": "tma_clears_resteers > 0.05 &
> > (tma_branch_resteers > 0.05 & (tma_fetch_latency > 0.1 &
> > tma_frontend_bound > 0.15))",
> > > +        "PublicDescription": "This metric represents fraction of cyc=
les the CPU
> > was stalled due to Branch Resteers as a result of Machine Clears. Sampl=
e with:
> > INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound,
> > tma_machine_clears, tma_microcode_sequencer, tma_ms_switches",
> > > +        "ScaleUnit": "100%",
> > > +        "Unit": "cpu_core"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "This metric estimates fraction of cycle=
s while the
> > memory subsystem was handling synchronizations due to contested
> > accesses",
> > > +        "MetricExpr":
> > "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ *
> > min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@:retire_latency,
> > 24 * tma_info_system_core_frequency) +
> > cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ *
> > min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@:retire_latency, 25
> > * tma_info_system_core_frequency) *
> > (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ /
> > (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ +
> > cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) * (1
> > + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ /
> > cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
> >
> > Thanks Weilin! The modifier on an event doesn't usually have the colon
> > when there is a slash. So:
> > cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@:retire_latency
> > Should be:
> > cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@retire_latency
> Thanks Ian! I will update this accordingly.
>
> > The modifiers also tend to be a single character.  The modifier 'R' is
> > unused, so I wonder we can use it here so that we can support these
> > events not just in metrics.
> Do you mean we use 'R' instead of "retire_latency" in all the formulas? I=
 could do this
> Update.

I think 'R' is more consistent with all the other event modifiers, but
I also like that your name is intention revealing. I think as we work
this into a more architecture neutral thing it is likely we'll want
retirement latency to just be like an event, in which case the
modifier could be combined with other modifiers. So
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD:uR could mean the
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD event with retirement latency only
sampled in user land. Somebody may have a different preference on
which letter, but R doesn't look unreasonable to me.

Thanks,
Ian

> >
> > Ian
>

