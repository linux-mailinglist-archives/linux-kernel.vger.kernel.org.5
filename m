Return-Path: <linux-kernel+bounces-117432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5D588AB5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66452986EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918612BE9B;
	Mon, 25 Mar 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsSPkAIJ"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454296CDC0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382545; cv=none; b=YFSZ/CojmhXuYmlmklos8c2pZN/M1s/VBu4ggbDu5N1qUS9JqeFbiJ7f8sfleqy8KbYRFe0Pj4kPb2pwg+X99uzGv57QVu1IHqnhzjbbqNxQOEZ5dTs/ExR9ViNprj+cIgtlMAexO4df0fQ27izUmLBf/pDWG6u5C5WRFnhqEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382545; c=relaxed/simple;
	bh=kSVsUjuwqotaj6qhKb87gTpFiLG+5fRuPhM3Mr6SrWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzFESnJJt3Ctr0eeegz0ZJV581Q4XfFK/c6gbsC3CaUywqDquiILSo7RyuFcD0BiUofMIWZBaWSpnSvVgS9IAAbP/9f38RtOQ8meH+Uv8/QlAvJusA0BfE94Y5FS3ZuFnVZ5avg/dQCpQ1w3QyDgKS6WRRUpvHGQ9i0Rdrjcjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsSPkAIJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-431347c6c99so480421cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711382542; x=1711987342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/giRn/qqAXBVBj5g6aUb8b1eWbkU+btmp3Th6MpOzhs=;
        b=HsSPkAIJGM7OKE0BaKaPb2Sr8BG63b66Gm/pxNtTsl6LtrHTCmFAKvK38/thbqaSRR
         yA7zEI8tZQfiXUhRZZYjlBMFJlTYmmWAYQ9nH766fO9SMavt+j1VunkvBlK/PJdRt4XU
         8FeRuY1gJIIWbC8Gh33QpH/LCaiBqLUuc6A4exKMbZeHYY9rjeP/6mX7mCdM0HMTeOIK
         bdDsqBEnpqz/uFqvlz++6pzN4kPFEG11CcOcXKLbjEhXh8PLI2bX1GIv2TobYFCqZRTR
         0PimvNiBh3qxXCdvR8cQriTijqvbmcchYLo69VU0sMUV3sVtCabdWzMejXYu8UQ3BHdc
         CWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711382542; x=1711987342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/giRn/qqAXBVBj5g6aUb8b1eWbkU+btmp3Th6MpOzhs=;
        b=gLqNQfryshrhNIbSH9DtQV4oGgnKvbcdu59lkxTv0OmB5m+XQGCxifkYT85nYXa9DX
         O9oIPla4h0W1UakHcZi7WM5A+zxMSi3mfMtP2WUPhXd2i6kN7nId3U+O8kltG58s1LQB
         F5peP0rSHhMNf6aBKU6OfT+/Z8JqmU7a78QGVIN6Tdb6M6G+Ygz7nXObR3C8yzP7dSwl
         TiueiB7KveSIPjrzz1v7hINSJ2bMoH6kmvwhb2EoNw0Kxoui8nrwF8YsirM4uEvftBok
         2l0bjtXtPCZ0sRwVTQB9kprpmc43D9v+1BA6/TwnkgP7QoIXIpZiGMAM4BV9Iv3A7KAH
         +MBw==
X-Gm-Message-State: AOJu0Yx4re/BcmMLInYeOQtgUOApxXffvMxIZ7z1baPVwpf2DTQZQOGH
	qtTQ1o23fZtc6E68Ks//fvMIBcy/D5MO5Iam2FSP5QgBHE3gQNNwDB/qRev7MgvCTYRVURTj0a5
	E1BIWLn3Uramr5QrPr968EsXApLEYmS3tmD6j
X-Google-Smtp-Source: AGHT+IHi0CSTS1fXwSdwD3T4W2vNXDe+zuonLuZRK2cJXQhFSW8Evog0ULVj6+qaqbxBvvFQwqBCpz+tGyr5p7SOZww=
X-Received: by 2002:a05:622a:4245:b0:431:5cda:54dd with SMTP id
 cq5-20020a05622a424500b004315cda54ddmr176310qtb.4.1711382542005; Mon, 25 Mar
 2024 09:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321071512.2916952-1-tmricht@linux.ibm.com> <20240321071512.2916952-2-tmricht@linux.ibm.com>
In-Reply-To: <20240321071512.2916952-2-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 Mar 2024 09:02:08 -0700
Message-ID: <CAP-5=fWaMrQkqAcohCZC3LSkhjjqOLY0pnLPRofQi5SCKsYtqw@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] perf stat: do not fail on metrics on s390 zvm systems
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:15=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On s390 z/VM virtual machines command perf list also displays metrics:
>
>  # ./perf list | grep -A 20 'Metric Groups:'
>  Metric Groups:
>
>  No_group:
>   cpi
>        [Cycles per Instruction]
>   est_cpi
>        [Estimated Instruction Complexity CPI infinite Level 1]
>   finite_cpi
>        [Cycles per Instructions from Finite cache/memory]
>   l1mp
>        [Level One Miss per 100 Instructions]
>   l2p
>        [Percentage sourced from Level 2 cache]
>   l3p
>        [Percentage sourced from Level 3 on same chip cache]
>   l4lp
>        [Percentage sourced from Level 4 Local cache on same book]
>   l4rp
>        [Percentage sourced from Level 4 Remote cache on different book]
>   memp
>        [Percentage sourced from memory]
>   ....
>  #
>
> The command
>
>  # ./perf stat -M cpi -- true
>  event syntax error: '{CPU_CYCLES/metric-id=3DCPU_CYCLES/.....'
>                        \___ Bad event or PMU
>
>  Unable to find PMU or event on a PMU of 'CPU_CYCLES'
>
>  event syntax error: '{CPU_CYCLES/metric-id=3DCPU_CYCLES/...'
>                        \___ Cannot find PMU `CPU_CYCLES'.
>                             Missing kernel support?
>  #
>
> fails. Perf stat should not fail on metrics when the referenced
> CPU Counter Measurement PMU is not available.
>
> Output after:
>  # ./perf stat -M est_cpi -- sleep 1
>
>  Performance counter stats for 'sleep 1':
>
>      1,000,887,494 ns   duration_time   #     0.00 est_cpi
>
>        1.000887494 seconds time elapsed
>
>        0.000143000 seconds user
>        0.000662000 seconds sys
>
>  #
>
> Fixes: 7f76b3113068 ("perf list: Add IBM z16 event description for s390")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Ian Rogers <irogers@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/s390/cf_z16/transaction.json         | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index ec2ff78e2b5f..3ab1d3a6638c 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -2,71 +2,71 @@
>    {
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
> -    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL if has_event(TX_C_TEND) else 0"
>    },
>    {
>      "BriefDescription": "Cycles per Instruction",
>      "MetricName": "cpi",
> -    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) =
else 0"
>    },
>    {
>      "BriefDescription": "Problem State Instruction Ratio",
>      "MetricName": "prbstate",
> -    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if =
has_event(INSTRUCTIONS) else 0"
>    },
>    {
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
> -    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100 if has_event(INSTRUCTIONS) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 2 cache",
>      "MetricName": "l2p",
> -    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I=
_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I=
_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 3 on same chip ca=
che",
>      "MetricName": "l3p",
> -    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + D=
CW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW=
_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + D=
CW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW=
_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(=
DCW_REQ_CHIP_HIT) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 4 Local cache on =
same book",
>      "MetricName": "l4lp",
> -    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_O=
N_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + ID=
CW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDC=
W_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_=
ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_O=
N_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + ID=
CW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDC=
W_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_=
ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if ha=
s_event(DCW_REQ_DRAWER_HIT) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from Level 4 Remote cache on=
 different book",
>      "MetricName": "l4rp",
> -    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAW=
ER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITE=
S + L1D_DIR_WRITES)) * 100"
> +    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAW=
ER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITE=
S + L1D_DIR_WRITES)) * 100 if has_event(DCW_OFF_DRAWER) else 0"
>    },
>    {
>      "BriefDescription": "Percentage sourced from memory",
>      "MetricName": "memp",
> -    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_=
DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_=
MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + =
L1D_DIR_WRITES)) * 100"
> +    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_=
DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_=
MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + =
L1D_DIR_WRITES)) * 100 if has_event(DCW_ON_CHIP_MEMORY) else 0"
>    },
>    {
>      "BriefDescription": "Cycles per Instructions from Finite cache/memor=
y",
>      "MetricName": "finite_cpi",
> -    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
> +    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_=
MISSES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Instruction Complexity CPI infinite L=
evel 1",
>      "MetricName": "est_cpi",
> -    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS)"
> +    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INST=
RUCTIONS) if has_event(INSTRUCTIONS) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
>      "MetricName": "scpl1m",
> -    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
> +    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) i=
f has_event(L1C_TLB2_MISSES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
>      "MetricName": "tlb_percent",
> -    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_T=
LB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100 if has_event(=
CPU_CYCLES) else 0"
>    },
>    {
>      "BriefDescription": "Estimated Cycles per TLB Miss",
>      "MetricName": "tlb_miss",
> -    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
> +    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB=
2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) =
if has_event(DTLB2_MISSES) else 0"
>    }
>  ]
> --
> 2.44.0
>

