Return-Path: <linux-kernel+bounces-75774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCC985EEBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54ED6B240EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB913AE8;
	Thu, 22 Feb 2024 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AvbJR1Q5"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999BC12E59
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708565926; cv=none; b=LfKPuzripMPrO2PY2S6kXy3X45U/sSkuMLQOEWOpqGOYvjlO6tLWTrqvDF1mRgc9I/1Ux7gCEDHrAIsWdoXH70l/Z+9Y68Unb2PyDZVYdVreCF2nPQDq73upN23TcPMBD2k7ZnjUBssLyADQbe/xQr4qObdvNl3N80YJ+naAHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708565926; c=relaxed/simple;
	bh=Q9Taq4EtKMKF6wAoyNCHEaLEyTPFmapgMqbFfb4vUcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APsZRnd3cMjEU4ovrWORSueonHSt6+mvFjhE2gp8YGHIJ9tbeLQFdg3B2+ToIk/Swq28QC8n0Fd0A/qDhfSmW2/zYP+lKr2YYo9Treqm7hy1aY1chKxvHsv371TYJ+P+3r8lRE7HbAK76hvbfHLYoHcteF7aifIYklsRs5y+v3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvbJR1Q5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbe7e51f91so43385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708565924; x=1709170724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ecuhdx8vKpP5oyjYx58iW2nK4sfonA9XNeM3TeM774=;
        b=AvbJR1Q5qHHRiUVNIJTDjbuzJsg6hm/dc0Hunbs2lvO+4w4XaHxh8D3ttzwXJRjgjo
         hbcOh0h5/WLY7XkPveIbA/EuXATny+sL/jjIsMqlIy75imAESxCc/lQngkfhePAyjacO
         6ZDWfwoG01LrpYpwXdaFTcyu+mxsjhMVOtT5OJRmg384S8ivNov2wz4HY7FOybJDcEfU
         B4OhNXYRSJnZ8ss52rYfoL3T3DojVDU/SdyM+FDKue4zPKKPqfdES8jAh/kMnzxIxI8l
         akDXevB2HG3qeHwaYenQ+Co6oWWO88li8j8jziIFWV4tXeEl5sqDXZi/KWUpa1YU1Ot7
         aauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708565924; x=1709170724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ecuhdx8vKpP5oyjYx58iW2nK4sfonA9XNeM3TeM774=;
        b=F97UaJjf6XqivIz44lwIa/xIWmn5TB6NvdhLXCUG/AAcF9aNopMNhIzafrf3C8Emui
         2vC+2eqdWVdQdDHE/S9WkruIqL599q/W26F7VRhExCpJg8bTd6M8+9E3Y/Ofn/Ak+nkq
         3FU6jVIJg/Sk78Xo0do82C58o7oDbMi7IFMGaBabKbwpk6Syxqiz45dOGi6MtH2p46Sg
         Ne5uISYoB4MT5mykyYzEK3t8RYZURn2h/xgRMf23G4XksdXO5gvgBhg/TWM44YAm87Cl
         qOD5LfW9O/A61s/xfokywWJRGHboRiflsZqYKGTNYMAGzr/LM9QLn4/n+hNstgugoOJi
         qVxA==
X-Forwarded-Encrypted: i=1; AJvYcCXSrJ7aGyAU+W3U5UBvDlWcpYYnGEhsz7tg8INydD4SbjHSCzhLPPEMKZN2hVw/798cR0pGNtfxFME0x6q9jIpmhB6CJHd0qb6M8TgJ
X-Gm-Message-State: AOJu0YwzM22e7K6A4gIaO27HLRv9CN5nX1Wn7xekVpzUUcvsUW2XS+mu
	fSn2uPoyjdtFZEWKXxPZ5OqqDKPLSPuDWpWCmdz4pTIJIaxyBxius/bC6EQAunjcKVIvlWt9yUI
	0cMiWu2IbLKy5IVUzZZeok8nI0XULp9HoR9QJ
X-Google-Smtp-Source: AGHT+IHKmwQGkdy6B3Q+0VF6Ks8C/mbKfMnHjvENIeZblJbGXK2/boLb8GyOzETwOr8lcgtDPNiRkCjZq9u/Dij/lr4=
X-Received: by 2002:a17:903:434f:b0:1db:8eaf:7652 with SMTP id
 lo15-20020a170903434f00b001db8eaf7652mr351460plb.5.1708565923242; Wed, 21 Feb
 2024 17:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019140325.3660923-1-peterlin@andestech.com>
In-Reply-To: <20231019140325.3660923-1-peterlin@andestech.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 17:38:30 -0800
Message-ID: <CAP-5=fX4eu+E9d0fK90MW9V+qys354C0q4fdfw_TMPavzqR5sg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] riscv: andes: Support symbolic FW and HW raw events
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, ycliang@andestech.com, 
	dminus@andestech.com, n.shubin@yadro.com, locus84@andestech.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	tim609@andestech.com, dylan@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 7:07=E2=80=AFAM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> From: Locus Wei-Han Chen <locus84@andestech.com>
>
> This patch adds the Andes AX45 JSON files in the perf tool,
> allowing perf to be used with symbolic event names.
>
> Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes v1 -> v2:
>   - No change
> ---
>  .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
>  .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
>  .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
>  .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
>  5 files changed, 330 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.=
json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructi=
ons.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch=
json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/=
tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> new file mode 100644
> index 000000000000..9b4a032186a7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> @@ -0,0 +1,68 @@
> +[
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ILLEGAL_INSN"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SET_TIMER"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.jso=
n b/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
> new file mode 100644
> index 000000000000..713a08c1a40f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
> @@ -0,0 +1,127 @@
> +[
> +       {
> +               "EventCode": "0x10",
> +               "EventName": "cycle_count",
> +               "BriefDescription": "Cycle count"
> +       },
> +       {
> +               "EventCode": "0x20",
> +               "EventName": "inst_count",
> +               "BriefDescription": "Retired instruction count"
> +       },
> +       {
> +               "EventCode": "0x30",
> +               "EventName": "int_load_inst",
> +               "BriefDescription": "Integer load instruction count"
> +       },
> +       {
> +               "EventCode": "0x40",
> +               "EventName": "int_store_inst",
> +               "BriefDescription": "Integer store instruction count"
> +       },
> +       {
> +               "EventCode": "0x50",
> +               "EventName": "atomic_inst",
> +               "BriefDescription": "Atomic instruction count"
> +       },
> +       {
> +               "EventCode": "0x60",
> +               "EventName": "sys_inst",
> +               "BriefDescription": "System instruction count"
> +       },
> +       {
> +               "EventCode": "0x70",
> +               "EventName": "int_compute_inst",
> +               "BriefDescription": "Integer computational instruction co=
unt"
> +       },
> +       {
> +               "EventCode": "0x80",
> +               "EventName": "condition_br",
> +               "BriefDescription": "Conditional branch instruction count=
"
> +       },
> +       {
> +               "EventCode": "0x90",
> +               "EventName": "taken_condition_br",
> +               "BriefDescription": "Taken conditional branch instruction=
 count"
> +       },
> +       {
> +               "EventCode": "0xA0",
> +               "EventName": "jal_inst",
> +               "BriefDescription": "JAL instruction count"
> +       },
> +       {
> +               "EventCode": "0xB0",
> +               "EventName": "jalr_inst",
> +               "BriefDescription": "JALR instruction count"
> +       },
> +       {
> +               "EventCode": "0xC0",
> +               "EventName": "ret_inst",
> +               "BriefDescription": "Return instruction count"
> +       },
> +       {
> +               "EventCode": "0xD0",
> +               "EventName": "control_trans_inst",
> +               "BriefDescription": "Control transfer instruction count"
> +       },
> +       {
> +               "EventCode": "0xE0",
> +               "EventName": "ex9_inst",
> +               "BriefDescription": "EXEC.IT instruction count"
> +       },
> +       {
> +               "EventCode": "0xF0",
> +               "EventName": "int_mul_inst",
> +               "BriefDescription": "Integer multiplication instruction c=
ount"
> +       },
> +       {
> +               "EventCode": "0x100",
> +               "EventName": "int_div_rem_inst",
> +               "BriefDescription": "Integer division/remainder instructi=
on count"
> +       },
> +       {
> +               "EventCode": "0x110",
> +               "EventName": "float_load_inst",
> +               "BriefDescription": "Floating-point load instruction coun=
t"
> +       },
> +       {
> +               "EventCode": "0x120",
> +               "EventName": "float_store_inst",
> +               "BriefDescription": "Floating-point store instruction cou=
nt"
> +       },
> +       {
> +               "EventCode": "0x130",
> +               "EventName": "float_add_sub_inst",
> +               "BriefDescription": "Floating-point addition/subtraction =
instruction count"
> +       },
> +       {
> +               "EventCode": "0x140",
> +               "EventName": "float_mul_inst",
> +               "BriefDescription": "Floating-point multiplication instru=
ction count"
> +       },
> +       {
> +               "EventCode": "0x150",
> +               "EventName": "float_fused_muladd_inst",
> +               "BriefDescription": "Floating-point fused multiply-add in=
struction count"
> +       },
> +       {
> +               "EventCode": "0x160",
> +               "EventName": "float_div_sqrt_inst",
> +               "BriefDescription": "Floating-point division or square-ro=
ot instruction count"
> +       },
> +       {
> +               "EventCode": "0x170",
> +               "EventName": "other_float_inst",
> +               "BriefDescription": "Other floating-point instruction cou=
nt"
> +       },
> +       {
> +               "EventCode": "0x180",
> +               "EventName": "int_mul_add_sub_inst",
> +               "BriefDescription": "Integer multiplication and add/sub i=
nstruction count"
> +       },
> +       {
> +               "EventCode": "0x190",
> +               "EventName": "retired_ops",
> +               "BriefDescription": "Retired operation count"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json b/to=
ols/perf/pmu-events/arch/riscv/andes/ax45/memory.json
> new file mode 100644
> index 000000000000..c7401b526c77
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
> @@ -0,0 +1,57 @@
> +[
> +       {
> +               "EventCode": "0x01",
> +               "EventName": "ilm_access",
> +               "BriefDescription": "ILM access"
> +       },
> +       {
> +               "EventCode": "0x11",
> +               "EventName": "dlm_access",
> +               "BriefDescription": "DLM access"
> +       },
> +       {
> +               "EventCode": "0x21",
> +               "EventName": "icache_access",
> +               "BriefDescription": "ICACHE access"
> +       },
> +       {
> +               "EventCode": "0x31",
> +               "EventName": "icache_miss",
> +               "BriefDescription": "ICACHE miss"
> +       },
> +       {
> +               "EventCode": "0x41",
> +               "EventName": "dcache_access",
> +               "BriefDescription": "DCACHE access"
> +       },
> +       {
> +               "EventCode": "0x51",
> +               "EventName": "dcache_miss",
> +               "BriefDescription": "DCACHE miss"
> +       },
> +       {
> +               "EventCode": "0x61",
> +               "EventName": "dcache_load_access",
> +               "BriefDescription": "DCACHE load access"
> +       },
> +       {
> +               "EventCode": "0x71",
> +               "EventName": "dcache_load_miss",
> +               "BriefDescription": "DCACHE load miss"
> +       },
> +       {
> +               "EventCode": "0x81",
> +               "EventName": "dcache_store_access",
> +               "BriefDescription": "DCACHE store access"
> +       },
> +       {
> +               "EventCode": "0x91",
> +               "EventName": "dcache_store_miss",
> +               "BriefDescription": "DCACHE store miss"
> +       },
> +       {
> +               "EventCode": "0xA1",
> +               "EventName": "dcache_wb",
> +               "BriefDescription": "DCACHE writeback"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json b=
/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
> new file mode 100644
> index 000000000000..a6d378cbaa74
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
> @@ -0,0 +1,77 @@
> +[
> +       {
> +               "EventCode": "0xB1",
> +               "EventName": "cycle_wait_icache_fill",
> +               "BriefDescription": "Cycles waiting for ICACHE fill data"
> +       },
> +       {
> +               "EventCode": "0xC1",
> +               "EventName": "cycle_wait_dcache_fill",
> +               "BriefDescription": "Cycles waiting for DCACHE fill data"
> +       },
> +       {
> +               "EventCode": "0xD1",
> +               "EventName": "uncached_ifetch_from_bus",
> +               "BriefDescription": "Uncached ifetch data access from bus=
"
> +       },
> +       {
> +               "EventCode": "0xE1",
> +               "EventName": "uncached_load_from_bus",
> +               "BriefDescription": "Uncached load data access from bus"
> +       },
> +       {
> +               "EventCode": "0xF1",
> +               "EventName": "cycle_wait_uncached_ifetch",
> +               "BriefDescription": "Cycles waiting for uncached ifetch d=
ata from bus"
> +       },
> +       {
> +               "EventCode": "0x101",
> +               "EventName": "cycle_wait_uncached_load",
> +               "BriefDescription": "Cycles waiting for uncached load dat=
a from bus"
> +       },
> +       {
> +               "EventCode": "0x111",
> +               "EventName": "main_itlb_access",
> +               "BriefDescription": "Main ITLB access"
> +       },
> +       {
> +               "EventCode": "0x121",
> +               "EventName": "main_itlb_miss",
> +               "BriefDescription": "Main ITLB miss"
> +       },
> +       {
> +               "EventCode": "0x131",
> +               "EventName": "main_dtlb_access",
> +               "BriefDescription": "Main DTLB access"
> +       },
> +       {
> +               "EventCode": "0x141",
> +               "EventName": "main_dtlb_miss",
> +               "BriefDescription": "Main DTLB miss"
> +       },
> +       {
> +               "EventCode": "0x151",
> +               "EventName": "cycle_wait_itlb_fill",
> +               "BriefDescription": "Cycles waiting for Main ITLB fill da=
ta"
> +       },
> +       {
> +               "EventCode": "0x161",
> +               "EventName": "pipe_stall_cycle_dtlb_miss",
> +               "BriefDescription": "Pipeline stall cycles caused by Main=
 DTLB miss"
> +       },
> +       {
> +               "EventCode": "0x02",
> +               "EventName": "mispredict_condition_br",
> +               "BriefDescription": "Misprediction of conditional branche=
s"
> +       },
> +       {
> +               "EventCode": "0x12",
> +               "EventName": "mispredict_take_condition_br",
> +               "BriefDescription": "Misprediction of taken conditional b=
ranches"
> +       },
> +       {
> +               "EventCode": "0x22",
> +               "EventName": "mispredict_target_ret_inst",
> +               "BriefDescription": "Misprediction of targets of Return i=
nstructions"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> index c61b3d6ef616..5bf09af14c1b 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -15,3 +15,4 @@
>  #
>  #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
>  0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> +0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> --
> 2.34.1
>

