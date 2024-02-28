Return-Path: <linux-kernel+bounces-85390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D686B54E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165FF1C22531
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036E0200D9;
	Wed, 28 Feb 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Sb7jhpOp"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0736EF1B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139021; cv=none; b=FnI/6wQ584lysCJyXVecsZTCjdCZTdNUAsRDzUwke3v2ItQxu8I/n5uFhHRCq2BJNRkBHaAsTlvnwPAOox/t/NofEphMWj0KaNXCcpENhOO3fxN+e6EP0qRWD2nfCEVdO/oQui4M7Goa1rUMqLxVMuP3OV3IaKO0vqs0xJKGHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139021; c=relaxed/simple;
	bh=BiBX27pEhwITwVo5C7sbSnqQyBJ1loTaQ8Xc3torB48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK1wnLFSUUIcmrwt7C6znMucfn1pxx1w9Vx39+2/etueIxQEv62i/QOIcnM7Ghy6wwceG659+BdMs+QJX/TTpuQTJAnCFoqjSGxTFzRPmhmt72cg7YkCOgRAA0JQM2tjX6AcjmIo1oODNeNy2e7HLZY51KX8Z1tkvAGfZqWcba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sb7jhpOp; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36575bb8443so124475ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709139017; x=1709743817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68jx04FjE9yhBDBZIxU+vhwtrbcB6F4LvmQlvG6iqqo=;
        b=Sb7jhpOpNwYxRmGIZflWOUZgxB00C3+ckkDrHJBkdayd04YcklMoLUqk/ffY+QIl2l
         diOkYIQT5+PdN3jMHdHIuK1tFVgbkW6du2hxFkOVcmN4dlQkC9gVx0cKuOUWS+YgE7Xw
         VfzcjnEKXDkTI9h7yAm3cwEV7OgaPv+mVN3xbgexEYovw5URnMG8EgwWbfSW13BA+XlI
         glNl8ZrK7+xUCFHa/cMxR+m6FgplwsmJE5scqbjRD9XjyfxSehnWyK5g2qT4rAxvHCos
         RPM3Nlu8vReQJdvNAT1ARfIGcwrW404MRbQIP4dTiNa6kUwILH/bXtRa8RHmmn4Jz6Sj
         83pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709139017; x=1709743817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68jx04FjE9yhBDBZIxU+vhwtrbcB6F4LvmQlvG6iqqo=;
        b=IK+8KDlHvDSw7OFL9eXPCrVCjuNY2dgeqntnxhpBZtC98Cc2K0du6ifk93ESeX5iG6
         /ooZrBnvDoKf76hn0q3De22gWuNrJbJ4MagrycdamD020jOgaL/mUwnS5BL2BhFOayI2
         nfQ6lVnWGDCaB7vFW52F295VCUQFczRc49GNir6clLmzyNttG+M77MMT0m0DwGMQbGu3
         EEgIhf385/Z3hTKOmwRdE7HI1936v7ceqZn5oOwu2Ey+MB7HfyFIZzDFyLFX7psgxpeY
         t1754x29ssSU3HKYaHWXKS5LSo2sg3C+mU2k8vTveWMOUDx789E1mmJFvBru5MpXsOta
         v9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWUEvbHV2PGk3YAenOexNYmYqPlrQ8r/xGnmx4/FQN95VgbvQz8wcMvHibEFEqbMzPoGZSJ0NAa7OXlPip/zc5vikWEACWU6H5XsCTy
X-Gm-Message-State: AOJu0YyfLmKFw4MrwE5+KEAsUFQlUzVc3478VYFLJdZe+Ev8i35l+12Z
	sscmzgJw5kWAUWijhegXmYB9oAvprTAr1NPhkIG+7fYAfqvs5qdqbWL6t6Zj71SdBoIng4NNS3f
	gXz6xoF7IZwWeOgQeDIaX7HgmMCgO+yGAolKn
X-Google-Smtp-Source: AGHT+IFHsFYQSlPuee5CsJAu+ztLNUBeYnpoFXh7HhARc9OjCNlYL1QQqrrdqrT1kUllB+7SxvanOhZtS6/xipYFJvY=
X-Received: by 2002:a05:6e02:3d07:b0:363:77d7:b079 with SMTP id
 db7-20020a056e023d0700b0036377d7b079mr65316ilb.4.1709139017225; Wed, 28 Feb
 2024 08:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228161227.484886-1-weilin.wang@intel.com> <20240228161227.484886-7-weilin.wang@intel.com>
In-Reply-To: <20240228161227.484886-7-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Feb 2024 08:50:01 -0800
Message-ID: <CAP-5=fVmKy9tWoQga7fBoNFSrYnWWfPwrCg5tHGMpygZVkUvOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] perf vendor events intel: Add MTL metric json files
To: weilin.wang@intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:12=E2=80=AFAM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> Add MTL metric json file at TMA4.7 [1]. Some of the metrics' formulas use=
 TPEBS
> retire_latency in MTL.
>
> [1] https://lore.kernel.org/all/20240214011820.644458-1-irogers@google.co=
m/
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  .../arch/x86/meteorlake/metricgroups.json     |  127 +
>  .../arch/x86/meteorlake/mtl-metrics.json      | 2531 +++++++++++++++++
>  2 files changed, 2658 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroup=
s.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics=
json
>
> diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json =
b/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
> new file mode 100644
> index 000000000000..7a03835f262c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
> @@ -0,0 +1,127 @@
> +{
> +    "Backend": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "Bad": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "BadSpec": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "BigFootprint": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
> +    "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
> +    "Branches": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "C0Wait": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
> +    "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
> +    "CodeGen": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "Compute": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "DSB": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "DSBmiss": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "DataSharing": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
> +    "Fed": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "FetchBW": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "FetchLat": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "Flops": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
> +    "FpScalar": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "FpVector": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "Frontend": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "HPC": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "IcMiss": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
> +    "InsType": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "IntVector": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
> +    "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "MachineClears": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
> +    "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis=
 Metrics spreadsheet",
> +    "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "MemOffcore": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
> +    "MemoryBW": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "MemoryBound": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
> +    "MemoryLat": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
> +    "MemoryTLB": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
> +    "Memory_BW": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
> +    "Memory_Lat": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
> +    "MicroSeq": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "OS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
> +    "Offcore": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "PGO": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "Pipeline": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "PortsUtil": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
> +    "Power": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
> +    "Prefetches": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
> +    "Ret": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "Retire": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
> +    "SMT": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "Server": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
> +    "Snoop": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
> +    "SoC": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> +    "Summary": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
> +    "TmaL1": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
> +    "TmaL2": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
> +    "TmaL3mem": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
> +    "TopdownL1": "Metrics for top-down breakdown at level 1",
> +    "TopdownL2": "Metrics for top-down breakdown at level 2",
> +    "TopdownL3": "Metrics for top-down breakdown at level 3",
> +    "TopdownL4": "Metrics for top-down breakdown at level 4",
> +    "TopdownL5": "Metrics for top-down breakdown at level 5",
> +    "TopdownL6": "Metrics for top-down breakdown at level 6",
> +    "tma_L1_group": "Metrics for top-down breakdown at level 1",
> +    "tma_L2_group": "Metrics for top-down breakdown at level 2",
> +    "tma_L3_group": "Metrics for top-down breakdown at level 3",
> +    "tma_L4_group": "Metrics for top-down breakdown at level 4",
> +    "tma_L5_group": "Metrics for top-down breakdown at level 5",
> +    "tma_L6_group": "Metrics for top-down breakdown at level 6",
> +    "tma_alu_op_utilization_group": "Metrics contributing to tma_alu_op_=
utilization category",
> +    "tma_assists_group": "Metrics contributing to tma_assists category",
> +    "tma_backend_bound_aux_group": "Metrics contributing to tma_backend_=
bound_aux category",
> +    "tma_backend_bound_group": "Metrics contributing to tma_backend_boun=
d category",
> +    "tma_bad_speculation_group": "Metrics contributing to tma_bad_specul=
ation category",
> +    "tma_base_group": "Metrics contributing to tma_base category",
> +    "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_=
mispredicts category",
> +    "tma_branch_resteers_group": "Metrics contributing to tma_branch_res=
teers category",
> +    "tma_core_bound_group": "Metrics contributing to tma_core_bound cate=
gory",
> +    "tma_dram_bound_group": "Metrics contributing to tma_dram_bound cate=
gory",
> +    "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load catego=
ry",
> +    "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store cate=
gory",
> +    "tma_fetch_bandwidth_group": "Metrics contributing to tma_fetch_band=
width category",
> +    "tma_fetch_latency_group": "Metrics contributing to tma_fetch_latenc=
y category",
> +    "tma_fp_arith_group": "Metrics contributing to tma_fp_arith category=
",
> +    "tma_fp_vector_group": "Metrics contributing to tma_fp_vector catego=
ry",
> +    "tma_frontend_bound_group": "Metrics contributing to tma_frontend_bo=
und category",
> +    "tma_heavy_operations_group": "Metrics contributing to tma_heavy_ope=
rations category",
> +    "tma_int_operations_group": "Metrics contributing to tma_int_operati=
ons category",
> +    "tma_issue2P": "Metrics related by the issue $issue2P",
> +    "tma_issueBM": "Metrics related by the issue $issueBM",
> +    "tma_issueBW": "Metrics related by the issue $issueBW",
> +    "tma_issueComp": "Metrics related by the issue $issueComp",
> +    "tma_issueD0": "Metrics related by the issue $issueD0",
> +    "tma_issueFB": "Metrics related by the issue $issueFB",
> +    "tma_issueFL": "Metrics related by the issue $issueFL",
> +    "tma_issueL1": "Metrics related by the issue $issueL1",
> +    "tma_issueLat": "Metrics related by the issue $issueLat",
> +    "tma_issueMC": "Metrics related by the issue $issueMC",
> +    "tma_issueMS": "Metrics related by the issue $issueMS",
> +    "tma_issueMV": "Metrics related by the issue $issueMV",
> +    "tma_issueRFO": "Metrics related by the issue $issueRFO",
> +    "tma_issueSL": "Metrics related by the issue $issueSL",
> +    "tma_issueSO": "Metrics related by the issue $issueSO",
> +    "tma_issueSmSt": "Metrics related by the issue $issueSmSt",
> +    "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
> +    "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
> +    "tma_issueTLB": "Metrics related by the issue $issueTLB",
> +    "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category=
",
> +    "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category=
",
> +    "tma_light_operations_group": "Metrics contributing to tma_light_ope=
rations category",
> +    "tma_load_op_utilization_group": "Metrics contributing to tma_load_o=
p_utilization category",
> +    "tma_machine_clears_group": "Metrics contributing to tma_machine_cle=
ars category",
> +    "tma_mem_latency_group": "Metrics contributing to tma_mem_latency ca=
tegory",
> +    "tma_mem_scheduler_group": "Metrics contributing to tma_mem_schedule=
r category",
> +    "tma_memory_bound_group": "Metrics contributing to tma_memory_bound =
category",
> +    "tma_microcode_sequencer_group": "Metrics contributing to tma_microc=
ode_sequencer category",
> +    "tma_mite_group": "Metrics contributing to tma_mite category",
> +    "tma_nuke_group": "Metrics contributing to tma_nuke category",
> +    "tma_other_light_ops_group": "Metrics contributing to tma_other_ligh=
t_ops category",
> +    "tma_ports_utilization_group": "Metrics contributing to tma_ports_ut=
ilization category",
> +    "tma_ports_utilized_0_group": "Metrics contributing to tma_ports_uti=
lized_0 category",
> +    "tma_ports_utilized_3m_group": "Metrics contributing to tma_ports_ut=
ilized_3m category",
> +    "tma_resource_bound_group": "Metrics contributing to tma_resource_bo=
und category",
> +    "tma_retiring_group": "Metrics contributing to tma_retiring category=
",
> +    "tma_serializing_operation_group": "Metrics contributing to tma_seri=
alizing_operation category",
> +    "tma_store_bound_group": "Metrics contributing to tma_store_bound ca=
tegory",
> +    "tma_store_op_utilization_group": "Metrics contributing to tma_store=
_op_utilization category"
> +}
> diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json b=
/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> new file mode 100644
> index 000000000000..12df19538fd6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
> @@ -0,0 +1,2531 @@
> +[
> +    {
> +        "BriefDescription": "C10 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C10_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C1 residency percent per core",
> +        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C1_Core_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C2 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C2_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C3 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C3_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C6 residency percent per core",
> +        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Core_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C6 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C7 residency percent per core",
> +        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C7_Core_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C7 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C7_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C8 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C8_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "C9 residency percent per package",
> +        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "C9_Pkg_Residency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "Percentage of cycles spent in System Manage=
ment Interrupts.",
> +        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ >=
 0 else 0)",
> +        "MetricGroup": "smi",
> +        "MetricName": "smi_cycles",
> +        "MetricThreshold": "smi_cycles > 0.1",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "Number of SMI interrupts.",
> +        "MetricExpr": "msr@smi@",
> +        "MetricGroup": "smi",
> +        "MetricName": "smi_num",
> +        "ScaleUnit": "1SMI#"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to certain allocation restrictions.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / t=
ma_info_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group"=
,
> +        "MetricName": "tma_alloc_restriction",
> +        "MetricThreshold": "tma_alloc_restriction > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ / tma_info_core_sl=
ots",
> +        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricName": "tma_backend_bound",
> +        "MetricThreshold": "tma_backend_bound > 0.1",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that uops =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.   The rest of=
 these subevents count backend stalls, in cycles, due to an outstanding req=
uest which is memory bound vs core bound.   The subevents are not slot base=
d events and therefore can not be precisely added or subtracted from the Ba=
ckend_Bound_Aux subevents which are slot based.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "MetricExpr": "tma_backend_bound",
> +        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricName": "tma_backend_bound_aux",
> +        "MetricThreshold": "tma_backend_bound_aux > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that UOPS =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.  All of these=
 subevents count backend stalls, in slots, due to a resource limitation.   =
These are not cycle based events and therefore can not be precisely added o=
r subtracted from the Backend_Bound subevents which are cycle based.  These=
 subevents are supplementary to Backend_Bound and can be used to analyze re=
sults from a resource perspective at allocation.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a mi=
spredicted jump or a machine clear",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.ALL@ / tma_info_=
core_slots",
> +        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricName": "tma_bad_speculation",
> +        "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "Counts the total number of issue slots tha=
t were not consumed by the backend because allocation is stalled due to a m=
ispredicted jump or a machine clear. Only issue slots wasted due to fast nu=
kes such as memory ordering nukes are counted. Other nukes are not accounte=
d for. Counts all issue slots blocked during this recovery window including=
 relevant microcode flows and while uops are not yet available in the instr=
uction queue (IQ). Also includes the issue slots that were consumed by the =
backend but were thrown away because they were younger than the mispredict =
or machine clear.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of uops that are not from=
 the microsequencer.",
> +        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_R=
ETIRED.MS@) / tma_info_core_slots",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
> +        "MetricName": "tma_base",
> +        "MetricThreshold": "tma_base > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to BACLEARS, which occurs when the Branc=
h Target Buffer (BTB) prediction or lack thereof, was corrected by a later =
branch predictor in the frontend",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / tma_in=
fo_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> +        "MetricName": "tma_branch_detect",
> +        "MetricThreshold": "tma_branch_detect > 0.05",
> +        "PublicDescription": "Counts the number of issue slots  that wer=
e not delivered by the frontend due to BACLEARS, which occurs when the Bran=
ch Target Buffer (BTB) prediction or lack thereof, was corrected by a later=
 branch predictor in the frontend. Includes BACLEARS due to all branch type=
s including conditional and unconditional jumps, returns, and indirect bran=
ches.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to branch mispredicts.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / tm=
a_info_core_slots",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group=
",
> +        "MetricName": "tma_branch_mispredicts",
> +        "MetricThreshold": "tma_branch_mispredicts > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to BTCLEARS, which occurs when the Branc=
h Target Buffer (BTB) predicts a taken branch.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / tma_i=
nfo_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> +        "MetricName": "tma_branch_resteer",
> +        "MetricThreshold": "tma_branch_resteer > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to the microcode sequencer (MS).",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / tma_info_core_s=
lots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group=
",
> +        "MetricName": "tma_cisc",
> +        "MetricThreshold": "tma_cisc > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles due to backend =
bound stalls that are core execution bound and not attributed to outstandin=
g demand load or store stalls.",
> +        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
> +        "MetricName": "tma_core_bound",
> +        "MetricThreshold": "tma_core_bound > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to decode stalls.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / tma_info_core=
_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group=
",
> +        "MetricName": "tma_decode",
> +        "MetricThreshold": "tma_decode > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to the number of nuke slots due to memory disambiguation.",
> +        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.DISAMBIGUATIO=
N@ / cpu_atom@MACHINE_CLEARS.SLOW@)",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> +        "MetricName": "tma_disambiguation",
> +        "MetricThreshold": "tma_disambiguation > 0.02",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
> +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_MISS@ / tma_in=
fo_core_clks - max((cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ - cpu_atom@LD_HEAD.=
L1_MISS_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS_LOAD.=
LLC_MISS@ / cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_dram_bound",
> +        "MetricThreshold": "tma_dram_bound > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to a machine clear classified as a fast nu=
ke due to memory ordering, memory disambiguation and memory renaming.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / tma_=
info_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group"=
,
> +        "MetricName": "tma_fast_nuke",
> +        "MetricThreshold": "tma_fast_nuke > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to frontend bandwidth restrictions due t=
o decode, predecode, cisc, and other limitations.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / t=
ma_info_core_slots",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group"=
,
> +        "MetricName": "tma_fetch_bandwidth",
> +        "MetricThreshold": "tma_fetch_bandwidth > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to frontend bandwidth restrictions due t=
o decode, predecode, cisc, and other limitations.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / tma=
_info_core_slots",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group"=
,
> +        "MetricName": "tma_fetch_latency",
> +        "MetricThreshold": "tma_fetch_latency > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to the number of nuke slots due to FP assists.",
> +        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / =
cpu_atom@MACHINE_CLEARS.SLOW@)",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> +        "MetricName": "tma_fp_assist",
> +        "MetricThreshold": "tma_fp_assist > 0.02",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of floating point divide =
operations per uop.",
> +        "MetricExpr": "cpu_atom@UOPS_RETIRED.FPDIV@ / tma_info_core_slot=
s",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
> +        "MetricName": "tma_fpdiv_uops",
> +        "MetricThreshold": "tma_fpdiv_uops > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to frontend stalls.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ / tma_info_core_sl=
ots",
> +        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricName": "tma_frontend_bound",
> +        "MetricThreshold": "tma_frontend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to instruction cache misses.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / tma_info_core=
_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> +        "MetricName": "tma_icache_misses",
> +        "MetricThreshold": "tma_icache_misses > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "",
> +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@",
> +        "MetricName": "tma_info_core_clks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "",
> +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@",
> +        "MetricName": "tma_info_core_clks_p",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction",
> +        "MetricExpr": "tma_info_core_clks / INST_RETIRED.ANY",
> +        "MetricName": "tma_info_core_cpi",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / tma_info_core_clks",
> +        "MetricName": "tma_info_core_ipc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "",
> +        "MetricExpr": "6 * tma_info_core_clks",
> +        "MetricName": "tma_info_core_slots",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Uops Per Instruction",
> +        "MetricExpr": "cpu_atom@UOPS_RETIRED.ALL@ / INST_RETIRED.ANY",
> +        "MetricName": "tma_info_core_upi",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percent of instruction miss cost that hit i=
n DRAM",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_MISS@ =
/ cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
> +        "MetricName": "tma_info_frontend_inst_miss_cost_dramhit_percent"=
,
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percent of instruction miss cost that hit i=
n the L2",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.L2_HIT@ / =
cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
> +        "MetricName": "tma_info_frontend_inst_miss_cost_l2hit_percent",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percent of instruction miss cost that hit i=
n the L3",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_HIT@ /=
 cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
> +        "MetricName": "tma_info_frontend_inst_miss_cost_l3hit_percent",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Ratio of all branches which mispredict",
> +        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / BR_INST_=
RETIRED.ALL_BRANCHES",
> +        "MetricName": "tma_info_inst_mix_branch_mispredict_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Ratio between Mispredicted branches and unk=
nown branches",
> +        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / BACLEARS=
ANY",
> +        "MetricName": "tma_info_inst_mix_branch_mispredict_to_unknown_br=
anch_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are FPDiv uops=
",
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / UOPS_RETIRED=
ALL",
> +        "MetricName": "tma_info_inst_mix_fpdiv_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are IDiv uops"=
,
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / UOPS_RETIRED.=
ALL",
> +        "MetricName": "tma_info_inst_mix_idiv_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_INST_RETIRED.ALL_=
BRANCHES",
> +        "MetricName": "tma_info_inst_mix_ipbranch",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurrence rate)",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_INST_RETIRED.NEAR=
_CALL",
> +        "MetricName": "tma_info_inst_mix_ipcall",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Far Branch",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_INST_RE=
TIRED.FAR_BRANCH@ / 2)",
> +        "MetricName": "tma_info_inst_mix_ipfarbranch",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Load",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / MEM_UOPS_RETIRED.ALL=
_LOADS",
> +        "MetricName": "tma_info_inst_mix_ipload",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired conditional Branch=
 Misprediction where the branch was not taken",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RE=
TIRED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
> +        "MetricName": "tma_info_inst_mix_ipmisp_cond_ntaken",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired conditional Branch=
 Misprediction where the branch was taken",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.COND=
_TAKEN",
> +        "MetricName": "tma_info_inst_mix_ipmisp_cond_taken",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired indirect call or j=
ump Branch Misprediction",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.INDI=
RECT",
> +        "MetricName": "tma_info_inst_mix_ipmisp_indirect",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired return Branch Misp=
rediction",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.RETU=
RN",
> +        "MetricName": "tma_info_inst_mix_ipmisp_ret",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired Branch Mispredicti=
on",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.ALL_=
BRANCHES",
> +        "MetricName": "tma_info_inst_mix_ipmispredict",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Store",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / MEM_UOPS_RETIRED.ALL=
_STORES",
> +        "MetricName": "tma_info_inst_mix_ipstore",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are ucode ops"=
,
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / UOPS_RETIRED.AL=
L",
> +        "MetricName": "tma_info_inst_mix_microcode_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are x87 uops",
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / UOPS_RETIRED.A=
LL",
> +        "MetricName": "tma_info_inst_mix_x87_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads w=
ith a address aliasing block",
> +        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.ADDRESS_ALIAS@ / MEM_UOP=
S_RETIRED.ALL_LOADS",
> +        "MetricName": "tma_info_l1_bound_address_alias_blocks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads t=
hat are splits",
> +        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / ME=
M_UOPS_RETIRED.ALL_LOADS",
> +        "MetricName": "tma_info_l1_bound_load_splits",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads w=
ith a store forward or unknown store address block",
> +        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / MEM_UOPS=
_RETIRED.ALL_LOADS",
> +        "MetricName": "tma_info_l1_bound_store_fwd_blocks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Cycle cost per L2 hit",
> +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ / MEM_LOAD=
_UOPS_RETIRED.L2_HIT",
> +        "MetricName": "tma_info_memory_cycles_per_demand_load_l2_hit",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Cycle cost per LLC hit",
> +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ / MEM_LOA=
D_UOPS_RETIRED.L3_HIT",
> +        "MetricName": "tma_info_memory_cycles_per_demand_load_l3_hit",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "load ops retired per 1000 instruction",
> +        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / INST=
_RETIRED.ANY",
> +        "MetricName": "tma_info_memory_memloadpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average CPU Utilization",
> +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
> +        "MetricName": "tma_info_system_cpu_utilization",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles spent in Kernel mode",
> +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALT=
ED.CORE",
> +        "MetricGroup": "Summary",
> +        "MetricName": "tma_info_system_kernel_utilization",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> +        "MetricExpr": "tma_info_core_clks / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "tma_info_system_turbo_utilization",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to Instruction Table Lookaside Buffer (I=
TLB) misses.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB_MISS@ / tma_info_c=
ore_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
> +        "MetricName": "tma_itlb_misses",
> +        "MetricThreshold": "tma_itlb_misses > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a load block.",
> +        "MetricExpr": "cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / tma_info_core=
_clks",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_l1_bound",
> +        "MetricThreshold": "tma_l1_bound > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles a core is stall=
ed due to a demand load which hit in the L2 Cache.",
> +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ / tma_info=
_core_clks - max((cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ - cpu_atom@LD_HEAD.L1=
_MISS_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS_LOAD.L2=
_HIT@ / cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_l2_bound",
> +        "MetricThreshold": "tma_l2_bound > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles a core is stall=
ed due to a demand load which hit in the Last Level Cache (LLC) or other co=
re with HITE/F/M.",
> +        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ / tma_inf=
o_core_clks - max((cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ - cpu_atom@LD_HEAD.L=
1_MISS_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS_LOAD.L=
LC_HIT@ / cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_l3_bound",
> +        "MetricThreshold": "tma_l3_bound > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles, relative to th=
e number of mem_scheduler slots, in which uops are blocked due to load buff=
er full",
> +        "MetricExpr": "tma_mem_scheduler * cpu_atom@MEM_SCHEDULER_BLOCK.=
LD_BUF@ / MEM_SCHEDULER_BLOCK.ALL",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
> +        "MetricName": "tma_ld_buffer",
> +        "MetricThreshold": "tma_ld_buffer > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a ma=
chine clear (nuke) of any kind including memory ordering and memory disambi=
guation.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ =
/ tma_info_core_slots",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group=
",
> +        "MetricName": "tma_machine_clears",
> +        "MetricThreshold": "tma_machine_clears > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to memory reservation stalls in which a sc=
heduler is not able to accept uops.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / tma_in=
fo_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group"=
,
> +        "MetricName": "tma_mem_scheduler",
> +        "MetricThreshold": "tma_mem_scheduler > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to stores or loads.",
> +        "MetricExpr": "min(tma_backend_bound, cpu_atom@LD_HEAD.ANY_AT_RE=
T@ / tma_info_core_clks + tma_store_bound)",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
> +        "MetricName": "tma_memory_bound",
> +        "MetricThreshold": "tma_memory_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to the number of nuke slots due to memory ordering.",
> +        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.MEMORY_ORDERI=
NG@ / cpu_atom@MACHINE_CLEARS.SLOW@)",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> +        "MetricName": "tma_memory_ordering",
> +        "MetricThreshold": "tma_memory_ordering > 0.02",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of uops that are from the=
 complex flows issued by the micro-sequencer (MS)",
> +        "MetricExpr": "cpu_atom@UOPS_RETIRED.MS@ / tma_info_core_slots",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
> +        "MetricName": "tma_ms_uops",
> +        "MetricThreshold": "tma_ms_uops > 0.05",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "PublicDescription": "Counts the number of uops that are from th=
e complex flows issued by the micro-sequencer (MS).  This includes uops fro=
m flows due to complex instructions, faults, assists, and inserted flows.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to IEC or FPC RAT stalls, which can be due=
 to FIQ or IEC reservation stalls in which the integer, floating point or S=
IMD scheduler is not able to accept uops.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / tm=
a_info_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group"=
,
> +        "MetricName": "tma_non_mem_scheduler",
> +        "MetricThreshold": "tma_non_mem_scheduler > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to a machine clear (slow nuke).",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / tma_info=
_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group"=
,
> +        "MetricName": "tma_nuke",
> +        "MetricThreshold": "tma_nuke > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to other common frontend stalls not cate=
gorized.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / tma_info_core_=
slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group=
",
> +        "MetricName": "tma_other_fb",
> +        "MetricThreshold": "tma_other_fb > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a number of other =
load blocks.",
> +        "MetricExpr": "cpu_atom@LD_HEAD.OTHER_AT_RET@ / tma_info_core_cl=
ks",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> +        "MetricName": "tma_other_l1",
> +        "MetricThreshold": "tma_other_l1 > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a demand load miss which hits in the L2, LLC, DRAM or MMIO (Non=
-DRAM) but could not be correctly attributed or cycles in which the load mi=
ss is waiting on a request buffer.",
> +        "MetricExpr": "max(0, tma_memory_bound - (tma_store_bound + tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound))",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_other_load_store",
> +        "MetricThreshold": "tma_other_load_store > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of uops retired excluding=
 ms and fp div uops.",
> +        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_R=
ETIRED.MS@ - cpu_atom@UOPS_RETIRED.FPDIV@) / tma_info_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
> +        "MetricName": "tma_other_ret",
> +        "MetricThreshold": "tma_other_ret > 0.3",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to the number of nuke slots due to page faults.",
> +        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ /=
 cpu_atom@MACHINE_CLEARS.SLOW@)",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> +        "MetricName": "tma_page_fault",
> +        "MetricThreshold": "tma_page_fault > 0.02",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not delivered by the frontend due to wrong predecodes.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / tma_info_c=
ore_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group=
",
> +        "MetricName": "tma_predecode",
> +        "MetricThreshold": "tma_predecode > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to the physical register file unable to ac=
cept an entry (marble stalls).",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / tma_info_co=
re_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group"=
,
> +        "MetricName": "tma_register",
> +        "MetricThreshold": "tma_register > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to the reorder buffer being full (ROB stal=
ls).",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / tma_i=
nfo_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group"=
,
> +        "MetricName": "tma_reorder_buffer",
> +        "MetricThreshold": "tma_reorder_buffer > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots  tha=
t were not consumed by the backend due to backend stalls",
> +        "MetricExpr": "tma_backend_bound",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_aux_gro=
up",
> +        "MetricName": "tma_resource_bound",
> +        "MetricThreshold": "tma_resource_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "PublicDescription": "Counts the total number of issue slots  th=
at were not consumed by the backend due to backend stalls.  Note that uops =
must be available for consumption in order for this event to count.  If a u=
op is not available (IQ is empty), this event will not count.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that resu=
lt in retirement slots.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ / tma_info_core_sl=
ots",
> +        "MetricGroup": "TopdownL1;tma_L1_group",
> +        "MetricName": "tma_retiring",
> +        "MetricThreshold": "tma_retiring > 0.75",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles, relative to th=
e number of mem_scheduler slots, in which uops are blocked due to RSV full =
relative",
> +        "MetricExpr": "tma_mem_scheduler * cpu_atom@MEM_SCHEDULER_BLOCK.=
RSV@ / MEM_SCHEDULER_BLOCK.ALL",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
> +        "MetricName": "tma_rsv",
> +        "MetricThreshold": "tma_rsv > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots  that were=
 not consumed by the backend due to scoreboards from the instruction queue =
(IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / tma_in=
fo_core_slots",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group"=
,
> +        "MetricName": "tma_serialization",
> +        "MetricThreshold": "tma_serialization > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to the number of nuke slots due to SMC.",
> +        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.SMC@ / cpu_at=
om@MACHINE_CLEARS.SLOW@)",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
> +        "MetricName": "tma_smc",
> +        "MetricThreshold": "tma_smc > 0.02",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles, relative to th=
e number of mem_scheduler slots, in which uops are blocked due to store buf=
fer full",
> +        "MetricExpr": "tma_store_bound",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
> +        "MetricName": "tma_st_buffer",
> +        "MetricThreshold": "tma_st_buffer > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a first level TLB =
miss.",
> +        "MetricExpr": "cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / tma_info_cor=
e_clks",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> +        "MetricName": "tma_stlb_hit",
> +        "MetricThreshold": "tma_stlb_hit > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a second level TLB=
 miss requiring a page walk.",
> +        "MetricExpr": "cpu_atom@LD_HEAD.PGWALK_AT_RET@ / tma_info_core_c=
lks",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> +        "MetricName": "tma_stlb_miss",
> +        "MetricThreshold": "tma_stlb_miss > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to store buffer full.",
> +        "MetricExpr": "tma_mem_scheduler * (cpu_atom@MEM_SCHEDULER_BLOCK=
ST_BUF@ / cpu_atom@MEM_SCHEDULER_BLOCK.ALL@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_store_bound",
> +        "MetricThreshold": "tma_store_bound > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a store forward bl=
ock.",
> +        "MetricExpr": "cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / tma_info_core_=
clks",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
> +        "MetricName": "tma_store_fwd_blk",
> +        "MetricThreshold": "tma_store_fwd_blk > 0.05",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Uncore frequency per die [GHZ]",
> +        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duratio=
n_time / 1e9",
> +        "MetricGroup": "SoC",
> +        "MetricName": "UNCORE_FREQ",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution ports for ALU operations.",
> +        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS=
_DISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_D=
ISPATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
> +        "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_gro=
up",
> +        "MetricName": "tma_alu_op_utilization",
> +        "MetricThreshold": "tma_alu_op_utilization > 0.4",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops delivered by the Microcode_Sequencer as a result of Assis=
ts",
> +        "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slot=
s",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_g=
roup",
> +        "MetricName": "tma_assists",
> +        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer=
 > 0.05 & tma_heavy_operations > 0.1)",
> +        "PublicDescription": "This metric estimates fraction of slots th=
e CPU retired uops delivered by the Microcode_Sequencer as a result of Assi=
sts. Assists are long sequences of uops that are required in certain corner=
-cases for operations that cannot be handled natively by the execution pipe=
line. For example; when working with very small floating point values (so-c=
alled Denormals); the FP units are not set up to perform these operations n=
atively. Instead; a sequence of instructions to perform the computation on =
the Denormals is injected into the pipeline. Since these microcode sequence=
s might be dozens of uops long; Assists can be extremely deleterious to per=
formance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops as a result of handing SSE to AVX* or AVX* to SSE transit=
ion Assists.",
> +        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thr=
ead_slots",
> +        "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
> +        "MetricName": "tma_avx_assists",
> +        "MetricThreshold": "tma_avx_assists > 0.1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
> +        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdow=
n\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retir=
ing@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_backend_bound",
> +        "MetricThreshold": "tma_backend_bound > 0.2",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
> +        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
> +        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_bad_speculation",
> +        "MetricThreshold": "tma_bad_speculation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Branch Misprediction",
> +        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@t=
opdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-=
retiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_gro=
up;tma_bad_speculation_group;tma_issueBM",
> +        "MetricName": "tma_branch_mispredicts",
> +        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specu=
lation > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Branch Misprediction.  These slots are either wast=
ed by uops fetched from an incorrectly speculated program path; or stalls w=
hen the out-of-order part of the machine needs to recover its state from a =
speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics=
: tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredi=
ctions, tma_mispredicts_resteers",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers",
> +        "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_inf=
o_thread_clks + tma_unknown_branches",
> +        "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latenc=
y_group",
> +        "MetricName": "tma_branch_resteers",
> +        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_late=
ncy > 0.1 & tma_frontend_bound > 0.15)",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers. Branch Resteers estimates the F=
rontend delay in fetching operations from corrected path; following all sor=
ts of miss-predicted branches. For example; branchy code with lots of miss-=
predictions might get categorized under Branch Resteers. Note the value of =
this node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_B=
RANCHES",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.1 power-performance optimized state (F=
aster wakeup time; Smaller power savings).",
> +        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_=
clks",
> +        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_op=
eration_group",
> +        "MetricName": "tma_c01_wait",
> +        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.2 power-performance optimized state (S=
lower wakeup time; Larger power savings).",
> +        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_=
clks",
> +        "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_op=
eration_group",
> +        "MetricName": "tma_c02_wait",
> +        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU retired uops originated from CISC (complex instruction set computer) =
instruction",
> +        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_g=
roup",
> +        "MetricName": "tma_cisc",
> +        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1)",
> +        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU retired uops originated from CISC (complex instruction set computer)=
 instruction. A CISC instruction has multiple uops that are required to per=
form the instruction's functionality as in the case of read-modify-write as=
 an example. Since these instructions require multiple uops they may or may=
 not imply sub-optimal use of machine resources. Sample with: FRONTEND_RETI=
RED.MS_FLOWS",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers as a result of Machine Clears",
> +        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation=
) * cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
> +        "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma=
_branch_resteers_group;tma_issueMC",
> +        "MetricName": "tma_clears_resteers",
> +        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_res=
teers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers as a result of Machine Clears. S=
ample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, t=
ma_machine_clears, tma_microcode_sequencer, tma_ms_switches",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to contested acc=
esses",
> +        "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * mi=
n(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@:retire_latency, 24 * tma_info=
_system_core_frequency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * min(=
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@:retire_latency, 25 * tma_info_sy=
stem_core_frequency) * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (c=
pu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD=
L3_HIT.SNOOP_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / c=
pu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",

Thanks Weilin! The modifier on an event doesn't usually have the colon
when there is a slash. So:
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@:retire_latency
Should be:
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@retire_latency
The modifiers also tend to be a single character.  The modifier 'R' is
unused, so I wonder we can use it here so that we can support these
events not just in metrics.

Ian

