Return-Path: <linux-kernel+bounces-15775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9542823195
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BE3B21AE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB01BDF4;
	Wed,  3 Jan 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB7r6Sxb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B01C281;
	Wed,  3 Jan 2024 16:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A51C433C8;
	Wed,  3 Jan 2024 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704300749;
	bh=VtXoDttPy1wmHFZ3VGVNPiIcXXUrQfZPdt9duGyvrxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oB7r6SxbtD3RNXZuECMcwk3KMEM6n32jzuVuyRW8u4oZsmnx9goaqA0Ko2s9fK3Vw
	 w9Pl2FcmeQdvluyonLv+zvnip5ma1ntvPVH+DGFPb5VX/Hf/SyB+DVoAjI7neYDn8R
	 LB/kdh42xDRRFZUMRPxi8j3ctCVBx74hwjs66OQ7Pa1wfa5nfqEa2pt9cJIbewldFN
	 ljEvAFJJHVoIV/T0yafnN4g4NTFmmF335zVD5N+Y8c7FYfL/s1lBK4sfKrt/OHaWNs
	 3WNmE+YUGeyQJcGr3SxEODc0k/x3scxZvWs7Muv9wxv+2AEvCFFON3LpsdikLHac3e
	 hi2SgYZHSxLEw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id E8FD1403EF; Wed,  3 Jan 2024 13:52:26 -0300 (-03)
Date: Wed, 3 Jan 2024 13:52:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, adrian.hunter@intel.com, eranian@google.com,
	irogers@google.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH v3] perf vendor events amd: Add Zen 4 memory controller
 events
Message-ID: <ZZWQygNA4ez-ikE8@kernel.org>
References: <e0d8a7e8ca8ee3e378d8029e80b456ac327d6419.1701238314.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d8a7e8ca8ee3e378d8029e80b456ac327d6419.1701238314.git.sandipan.das@amd.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 29, 2023 at 11:55:04AM +0530, Sandipan Das escreveu:
> Make the jevents parser aware of the Unified Memory Controller (UMC) PMU
> and add events taken from Section 8.2.1 "UMC Performance Monitor Events"
> of the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
> processors. The events capture UMC command activity such as CAS, ACTIVATE,
> PRECHARGE etc. while the metrics derive data bus utilization and memory
> bandwidth out of these events.
> 
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---

Thanks, applied to perf-tools-next.

- Arnaldo

 
> v3:
>  - Rebase on top of latest perf-tools-next branch.
> 
> v2: https://lore.kernel.org/all/3a7245598265737ae4296fa6b0ab03a51708c502.1696425185.git.sandipan.das@amd.com/
> v1: https://lore.kernel.org/all/a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com/
> 
> ---
>  .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
>  .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
>  tools/perf/pmu-events/jevents.py              |   2 +
>  3 files changed, 187 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> 
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json b/tools/perf/pmu-events/arch/x86/a.mdzen4/memory-controller.json
> new file mode 100644
> index 000000000000..55263e5e4f69
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> @@ -0,0 +1,101 @@
> +[
> +  {
> +    "EventName": "umc_mem_clk",
> +    "PublicDescription": "Number of memory clock cycles.",
> +    "EventCode": "0x00",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.all",
> +    "PublicDescription": "Number of ACTIVATE commands sent.",
> +    "EventCode": "0x05",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.rd",
> +    "PublicDescription": "Number of ACTIVATE commands sent for reads.",
> +    "EventCode": "0x05",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.wr",
> +    "PublicDescription": "Number of ACTIVATE commands sent for writes.",
> +    "EventCode": "0x05",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.all",
> +    "PublicDescription": "Number of PRECHARGE commands sent.",
> +    "EventCode": "0x06",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.rd",
> +    "PublicDescription": "Number of PRECHARGE commands sent for reads.",
> +    "EventCode": "0x06",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.wr",
> +    "PublicDescription": "Number of PRECHARGE commands sent for writes.",
> +    "EventCode": "0x06",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.all",
> +    "PublicDescription": "Number of CAS commands sent.",
> +    "EventCode": "0x0a",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.rd",
> +    "PublicDescription": "Number of CAS commands sent for reads.",
> +    "EventCode": "0x0a",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.wr",
> +    "PublicDescription": "Number of CAS commands sent for writes.",
> +    "EventCode": "0x0a",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.all",
> +    "PublicDescription": "Number of clocks used by the data bus.",
> +    "EventCode": "0x14",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.rd",
> +    "PublicDescription": "Number of clocks used by the data bus for reads.",
> +    "EventCode": "0x14",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.wr",
> +    "PublicDescription": "Number of clocks used by the data bus for writes.",
> +    "EventCode": "0x14",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> index 5e6a793acf7b..96e06401c6cb 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> @@ -330,5 +330,89 @@
>      "MetricGroup": "data_fabric",
>      "PerPkg": "1",
>      "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "umc_data_bus_utilization",
> +    "BriefDescription": "Memory controller data bus utilization.",
> +    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_rate",
> +    "BriefDescription": "Memory controller CAS command rate.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_read_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_write_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for writes.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_mem_read_bandwidth",
> +    "BriefDescription": "Estimated memory read bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_mem_write_bandwidth",
> +    "BriefDescription": "Estimated memory write bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_mem_bandwidth",
> +    "BriefDescription": "Estimated combined memory bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_read_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_rate",
> +    "BriefDescription": "Memory controller CAS command rate.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_activate_cmd_rate",
> +    "BriefDescription": "Memory controller ACTIVATE command rate.",
> +    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_precharge_cmd_rate",
> +    "BriefDescription": "Memory controller PRECHARGE command rate.",
> +    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 0093c998cb6e..53ab050c8fa4 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -286,6 +286,7 @@ class JsonEvent:
>            'imx8_ddr': 'imx8_ddr',
>            'L3PMC': 'amd_l3',
>            'DFPMC': 'amd_df',
> +          'UMCPMC': 'amd_umc',
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
>            'ali_drw': 'ali_drw',
> @@ -354,6 +355,7 @@ class JsonEvent:
>          ('SampleAfterValue', 'period='),
>          ('UMask', 'umask='),
>          ('NodeType', 'type='),
> +        ('RdWrMask', 'rdwrmask='),
>      ]
>      for key, value in event_fields:
>        if key in jd and jd[key] != '0':
> -- 
> 2.34.1
> 

-- 

- Arnaldo

