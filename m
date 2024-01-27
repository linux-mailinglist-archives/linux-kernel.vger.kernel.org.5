Return-Path: <linux-kernel+bounces-41366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB283EFB7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E4DB21A6C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBFC28F5;
	Sat, 27 Jan 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd+09yD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2B12E62D;
	Sat, 27 Jan 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706383500; cv=none; b=mi+oLnbiVZje10HbxsiYbPfBqHMVsz4WCR/YBx7RahPkBPtlLGnp3g3YhNAfG85SpWAHa23asBiicZ3SlU1RbaJ8ZnnOY7WRNqtSsT53P2wLpaDWgLW0lNwQvY+EaERsKFGbsqEyFGU/jrnL6xU3XhMUls77x3vJHe4kdCGtuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706383500; c=relaxed/simple;
	bh=LvdfAq+NhKUYAsQW2JIELY3OO4IuTwCqqfuu9mALtOU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NXVnFqvEN7Fb595sW96J94FTkIKn5yADbi3v1PaZInXwsoaazrYQzw2d1/81ogxOL9fWcnNfvgRC3TwUY5OaP5jVw4NBSl17RtWFbfYHuIsfOqWREWyxa7Rk4jIZv4CJPHCYCT/U0FR4MBVRN4g9KAPe3lV3sce/INq08SC9Vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd+09yD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A6C433F1;
	Sat, 27 Jan 2024 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706383498;
	bh=LvdfAq+NhKUYAsQW2JIELY3OO4IuTwCqqfuu9mALtOU=;
	h=Date:From:To:Cc:Subject:From;
	b=sd+09yD7U9UJpYsvxtHhgIHhnHhDss2Pjv27qtdh+G/6embowWqBrnfw2sM99WdM3
	 LvvIZXxedo7b1aco5x6cOjzA24qHDvIS6H7lQdVwaXYyF2UWTl0KNTA8CjlTKimei3
	 7uBdlCCLbYjzYm9XNoQvclRZyrfE0KSdG+dxtxmH2WuhxoEj8JXlRqEUARv7snKV4k
	 ZY4k57+/k8ZlkTHhmafM3ZiewHGbL9lJ4scRUfG3mOEb1F3PGqhp2K9dotlKWWFng8
	 r0uxr8QWXQm/ncaQpwMK02snPIrRUmbTn0HEkzv3xdn0wQm19Wob//glzUmypVwG3h
	 EQvWJk/ZT3E2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id AB82940441; Sat, 27 Jan 2024 16:24:55 -0300 (-03)
Date: Sat, 27 Jan 2024 16:24:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: "perf test 103: perf all metrics test" failing on hybrid i7 14700k
Message-ID: <ZbVYhxQzodvh5Cob@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com

FYI:

root@number:~# grep -m1 "model name" /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-14700K

And see after that another hybrid machine, a Lenovo Thinkpad Carbon X1:

root@x1:~# grep -m1 "model name" /proc/cpuinfo
model name	: 13th Gen Intel(R) Core(TM) i7-1365U

back to the i7-14700K:

root@number:~# perf test -v 103
103: perf all metrics test                                           :
--- start ---
test child forked, pid 149355
Testing tma_core_bound
Testing tma_info_core_ilp
Testing tma_info_memory_l2mpki
Testing tma_memory_bound
Testing tma_info_bad_spec_branch_misprediction_cost
Testing tma_info_bad_spec_ipmisp_cond_ntaken
Testing tma_info_bad_spec_ipmisp_cond_taken
Testing tma_info_bad_spec_ipmisp_indirect
Testing tma_info_bad_spec_ipmisp_ret
Testing tma_info_bad_spec_ipmispredict
Testing tma_info_bottleneck_mispredictions
Testing tma_info_branches_callret
Testing tma_info_branches_cond_nt
Testing tma_info_branches_cond_tk
Testing tma_info_branches_jump
Testing tma_info_branches_other_branches
Testing tma_branch_mispredicts
Testing tma_clears_resteers
Testing tma_machine_clears
Testing tma_mispredicts_resteers
Testing tma_icache_misses
Testing tma_info_bottleneck_big_code
Testing tma_itlb_misses
Testing tma_unknown_branches
Testing tma_info_inst_mix_bptkbranch
Testing tma_info_inst_mix_ipbranch
Testing tma_info_inst_mix_ipcall
Testing tma_info_inst_mix_iptb
Testing tma_info_system_ipfarbranch
Testing tma_info_thread_uptb
Testing tma_info_memory_fb_hpki
Testing tma_info_memory_l1mpki
Testing tma_info_memory_l1mpki_load
Testing tma_info_memory_l2hpki_all
Testing tma_info_memory_l2hpki_load
Testing tma_info_memory_l2mpki_all
Testing tma_info_memory_l2mpki_load
Testing tma_info_memory_l3mpki
Testing tma_l1_bound
Testing tma_l2_bound
Testing tma_l3_bound
Testing tma_fp_scalar
Testing tma_fp_vector
Testing tma_fp_vector_128b
Testing tma_fp_vector_256b
Testing tma_int_vector_128b
Testing tma_int_vector_256b
Testing tma_port_0
Testing tma_x87_use
Testing tma_info_botlnk_l0_core_bound_likely
Testing tma_info_core_fp_arith_utilization
Testing tma_info_pipeline_execute
Testing tma_info_system_gflops
Testing tma_info_thread_execute_per_issue
Testing tma_dsb
Testing tma_info_frontend_dsb_coverage
Testing tma_decoder0_alone
Testing tma_dsb_switches
Testing tma_info_botlnk_l2_dsb_misses
Testing tma_info_frontend_dsb_switch_cost
Testing tma_info_frontend_ipdsb_miss_ret
Testing tma_mite
Testing tma_contested_accesses
Testing tma_false_sharing
Testing tma_backend_bound
Testing tma_backend_bound_aux
Testing tma_bad_speculation
Testing tma_frontend_bound
Testing tma_retiring
Testing tma_info_botlnk_l2_ic_misses
Testing tma_info_bottleneck_instruction_fetch_bw
Testing tma_info_frontend_fetch_upc
Testing tma_info_frontend_icache_miss_latency
Testing tma_info_frontend_ipunknown_branch
Testing tma_info_frontend_lsd_coverage
Testing tma_info_memory_tlb_code_stlb_mpki
Testing tma_fetch_bandwidth
Testing tma_lsd
Testing tma_branch_resteers
Testing tma_lcp
Testing tma_ms_switches
Testing tma_info_core_flopc
Testing tma_info_inst_mix_iparith
Testing tma_info_inst_mix_iparith_avx128
Testing tma_info_inst_mix_iparith_avx256
Testing tma_info_inst_mix_iparith_scalar_dp
Testing tma_info_inst_mix_iparith_scalar_sp
Testing tma_info_inst_mix_ipflop
Testing tma_fetch_latency
Testing tma_avx_assists
Testing tma_fp_arith
Testing tma_fp_assists
Testing tma_info_system_cpu_utilization
Testing tma_info_system_dram_bw_use
Testing tma_shuffles
Testing tma_info_frontend_l2mpki_code
Testing tma_info_frontend_l2mpki_code_all
Testing tma_info_inst_mix_ipload
Testing tma_info_inst_mix_ipstore
Testing tma_info_bottleneck_memory_bandwidth
Testing tma_info_bottleneck_memory_data_tlbs
Testing tma_info_bottleneck_memory_latency
Testing tma_info_memory_core_l1d_cache_fill_bw
Testing tma_info_memory_core_l2_cache_fill_bw
Testing tma_info_memory_core_l3_cache_access_bw
Testing tma_info_memory_core_l3_cache_fill_bw
Testing tma_info_memory_load_miss_real_latency
Testing tma_info_memory_mlp
Testing tma_info_memory_thread_l1d_cache_fill_bw_1t
Testing tma_info_memory_thread_l2_cache_fill_bw_1t
Testing tma_info_memory_thread_l3_cache_access_bw_1t
Testing tma_info_memory_thread_l3_cache_fill_bw_1t
Testing tma_info_memory_tlb_load_stlb_mpki
Testing tma_info_memory_tlb_page_walks_utilization
Testing tma_info_memory_tlb_store_stlb_mpki
Testing tma_info_system_mem_parallel_reads
Testing tma_info_system_mem_read_latency
Testing tma_info_system_mem_request_latency
Testing tma_info_thread_cpi
Testing tma_fb_full
Testing tma_mem_bandwidth
Testing tma_sq_full
Testing tma_streaming_stores
Testing tma_dram_bound
Testing tma_store_bound
Testing tma_l3_hit_latency
Testing tma_mem_latency
Testing tma_store_latency
Testing tma_dtlb_load
Testing tma_dtlb_store
Testing tma_load_stlb_hit
Testing tma_load_stlb_miss
Testing tma_store_stlb_hit
Testing tma_store_stlb_miss
Testing tma_info_memory_oro_data_l2_mlp
Testing tma_info_memory_oro_load_l2_mlp
Testing tma_info_memory_oro_load_l2_miss_latency
Testing tma_info_memory_oro_load_l3_miss_latency
Testing tma_microcode_sequencer
Testing tma_info_core_clks
Testing tma_info_core_clks_p
Testing tma_info_core_cpi
Testing tma_info_core_ipc
Testing tma_info_core_slots
Testing tma_info_core_upi
Testing tma_info_frontend_inst_miss_cost_dramhit_percent
Testing tma_info_frontend_inst_miss_cost_l2hit_percent
Testing tma_info_frontend_inst_miss_cost_l3hit_percent
Testing tma_info_inst_mix_branch_mispredict_ratio
Testing tma_info_inst_mix_branch_mispredict_to_unknown_branch_ratio
Testing tma_info_inst_mix_fpdiv_uop_ratio
Testing tma_info_inst_mix_idiv_uop_ratio
Testing tma_info_inst_mix_ipfarbranch
Testing tma_info_inst_mix_ipmisp_cond_ntaken
Testing tma_info_inst_mix_ipmisp_cond_taken
Testing tma_info_inst_mix_ipmisp_indirect
Testing tma_info_inst_mix_ipmisp_ret
Testing tma_info_inst_mix_ipmispredict
Testing tma_info_inst_mix_microcode_uop_ratio
Testing tma_info_inst_mix_x87_uop_ratio
Testing tma_info_l1_bound_address_alias_blocks
Testing tma_info_l1_bound_load_splits
Testing tma_info_l1_bound_store_fwd_blocks
Testing tma_info_memory_cycles_per_demand_load_dram_hit
Testing tma_info_memory_cycles_per_demand_load_l2_hit
Testing tma_info_memory_cycles_per_demand_load_l3_hit
Testing tma_info_memory_memloadpki
Testing tma_info_system_kernel_cpi
Testing tma_info_system_kernel_utilization
Testing tma_data_sharing
Testing tma_lock_latency
Testing tma_fused_instructions
Testing tma_info_pipeline_ipassist
Testing tma_info_pipeline_retire
Testing tma_info_pipeline_strings_cycles
Testing tma_info_thread_clks
Testing tma_info_thread_uoppi
Testing tma_int_operations
Testing tma_memory_operations
Testing tma_non_fused_branches
Testing tma_nop_instructions
Testing tma_other_light_ops
Testing tma_ports_utilization
Testing tma_ports_utilized_0
Testing tma_ports_utilized_1
Metric 'tma_ports_utilized_1' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 69.150 usec (+- 0.224 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.411 usec
  Average data synthesis took: 56.534 usec (+- 0.025 usec)
  Average num. events: 255.000 (+- 0.000)
  Average time per event 0.222 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.482356148 seconds time elapsed

       0.553851000 seconds user
       0.915151000 seconds sys
Testing tma_ports_utilized_2
Metric 'tma_ports_utilized_2' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 52.913 usec (+- 0.026 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.080 usec
  Average data synthesis took: 56.637 usec (+- 0.024 usec)
  Average num. events: 256.000 (+- 0.000)
  Average time per event 0.221 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.241983709 seconds time elapsed

       0.457768000 seconds user
       0.778312000 seconds sys
Testing tma_ports_utilized_3m
Metric 'tma_ports_utilized_3m' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 52.617 usec (+- 0.026 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.074 usec
  Average data synthesis took: 56.215 usec (+- 0.022 usec)
  Average num. events: 258.000 (+- 0.000)
  Average time per event 0.218 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/UOPS_EXECUTED.CYCLES_GE_3/                                        (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.235490934 seconds time elapsed

       0.432792000 seconds user
       0.796901000 seconds sys
Testing tma_serializing_operation
Testing C10_Pkg_Residency
Testing C1_Core_Residency
Testing C2_Pkg_Residency
Testing C3_Pkg_Residency
Testing C6_Core_Residency
Testing C6_Pkg_Residency
Testing C7_Core_Residency
Testing C7_Pkg_Residency
Testing C8_Pkg_Residency
Testing C9_Pkg_Residency
Testing tma_info_system_average_frequency
Testing tma_info_system_turbo_utilization
Testing tma_info_inst_mix_ipswpf
Testing tma_info_bottleneck_branching_overhead
Testing tma_info_core_coreipc
Testing tma_info_thread_ipc
Testing tma_heavy_operations
Testing tma_light_operations
Testing tma_info_core_core_clks
Testing tma_info_system_smt_2t_utilization
Testing tma_info_thread_slots_utilization
Testing UNCORE_FREQ
Testing tma_info_system_socket_clks
Testing tma_info_inst_mix_instructions
Testing tma_info_thread_slots
Testing tma_base
Testing tma_ms_uops
Testing tma_resource_bound
Testing tma_alloc_restriction
Testing tma_branch_detect
Testing tma_branch_resteer
Testing tma_cisc
Testing tma_decode
Testing tma_divider
Testing tma_fast_nuke
Testing tma_few_uops_instructions
Testing tma_fpdiv_uops
Testing tma_mem_scheduler
Testing tma_non_mem_scheduler
Testing tma_nuke
Testing tma_other_fb
Testing tma_other_load_store
Testing tma_other_ret
Testing tma_predecode
Testing tma_register
Testing tma_reorder_buffer
Testing tma_serialization
Testing tma_assists
Testing tma_disambiguation
Testing tma_fp_assist
Testing tma_ld_buffer
Testing tma_memory_ordering
Testing tma_other_l1
Testing tma_page_fault
Testing tma_rsv
Testing tma_smc
Testing tma_split_loads
Testing tma_split_stores
Testing tma_st_buffer
Testing tma_stlb_hit
Testing tma_stlb_miss
Testing tma_store_fwd_blk
Testing tma_alu_op_utilization
Testing tma_load_op_utilization
Testing tma_mixing_vectors
Testing tma_page_faults
Testing tma_store_op_utilization
Testing tma_memory_fence
Metric 'tma_memory_fence' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 52.176 usec (+- 0.040 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.065 usec
  Average data synthesis took: 57.213 usec (+- 0.091 usec)
  Average num. events: 254.000 (+- 0.000)
  Average time per event 0.225 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/MISC2_RETIRED.LFENCE/                                          (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.240821329 seconds time elapsed

       0.450033000 seconds user
       0.783502000 seconds sys
Testing tma_port_1
Testing tma_port_6
Testing tma_slow_pause
Metric 'tma_slow_pause' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 53.172 usec (+- 0.028 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.085 usec
  Average data synthesis took: 59.325 usec (+- 0.107 usec)
  Average num. events: 257.000 (+- 0.000)
  Average time per event 0.231 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.272733971 seconds time elapsed

       0.486217000 seconds user
       0.779214000 seconds sys
Testing smi_cycles
Testing smi_num
Testing tsx_aborted_cycles
Testing tsx_cycles_per_elision
Testing tsx_cycles_per_transaction
Testing tsx_transactional_cycles
test child finished with -1
---- end ----
perf all metrics test: FAILED!
root@number:~#


And on another hybrid machine, a Lenovo Thinkpad Carbon X1:

root@x1:~# grep -m1 "model name" /proc/cpuinfo
model name	: 13th Gen Intel(R) Core(TM) i7-1365U
root@x1:~# perf test -v 103
103: perf all metrics test                                           :
--- start ---
test child forked, pid 248913
Testing tma_core_bound
Testing tma_info_core_ilp
Testing tma_info_memory_l2mpki
Testing tma_memory_bound
Testing tma_info_bad_spec_branch_misprediction_cost
Testing tma_info_bad_spec_ipmisp_cond_ntaken
Testing tma_info_bad_spec_ipmisp_cond_taken
Testing tma_info_bad_spec_ipmisp_indirect
Testing tma_info_bad_spec_ipmisp_ret
Testing tma_info_bad_spec_ipmispredict
Testing tma_info_bottleneck_mispredictions
Testing tma_info_branches_callret
Testing tma_info_branches_cond_nt
Testing tma_info_branches_cond_tk
Testing tma_info_branches_jump
Testing tma_info_branches_other_branches
Testing tma_branch_mispredicts
Testing tma_clears_resteers
Testing tma_machine_clears
Testing tma_mispredicts_resteers
Testing tma_icache_misses
Testing tma_info_bottleneck_big_code
Testing tma_itlb_misses
Testing tma_unknown_branches
Testing tma_info_inst_mix_bptkbranch
Testing tma_info_inst_mix_ipbranch
Testing tma_info_inst_mix_ipcall
Testing tma_info_inst_mix_iptb
Testing tma_info_system_ipfarbranch
Testing tma_info_thread_uptb
Testing tma_info_memory_fb_hpki
Testing tma_info_memory_l1mpki
Testing tma_info_memory_l1mpki_load
Testing tma_info_memory_l2hpki_all
Testing tma_info_memory_l2hpki_load
Testing tma_info_memory_l2mpki_all
Testing tma_info_memory_l2mpki_load
Testing tma_info_memory_l3mpki
Testing tma_l1_bound
Testing tma_l2_bound
Testing tma_l3_bound
Testing tma_fp_scalar
Testing tma_fp_vector
Testing tma_fp_vector_128b
Testing tma_fp_vector_256b
Testing tma_int_vector_128b
Testing tma_int_vector_256b
Testing tma_port_0
Testing tma_x87_use
Testing tma_info_botlnk_l0_core_bound_likely
Testing tma_info_core_fp_arith_utilization
Testing tma_info_pipeline_execute
Testing tma_info_system_gflops
Testing tma_info_thread_execute_per_issue
Testing tma_dsb
Testing tma_info_frontend_dsb_coverage
Testing tma_decoder0_alone
Testing tma_dsb_switches
Testing tma_info_botlnk_l2_dsb_misses
Testing tma_info_frontend_dsb_switch_cost
Testing tma_info_frontend_ipdsb_miss_ret
Testing tma_mite
Testing tma_contested_accesses
Testing tma_false_sharing
Testing tma_backend_bound
Testing tma_backend_bound_aux
Testing tma_bad_speculation
Testing tma_frontend_bound
Testing tma_retiring
Testing tma_info_botlnk_l2_ic_misses
Testing tma_info_bottleneck_instruction_fetch_bw
Testing tma_info_frontend_fetch_upc
Testing tma_info_frontend_icache_miss_latency
Testing tma_info_frontend_ipunknown_branch
Testing tma_info_frontend_lsd_coverage
Testing tma_info_memory_tlb_code_stlb_mpki
Testing tma_fetch_bandwidth
Testing tma_lsd
Testing tma_branch_resteers
Testing tma_lcp
Testing tma_ms_switches
Testing tma_info_core_flopc
Testing tma_info_inst_mix_iparith
Testing tma_info_inst_mix_iparith_avx128
Testing tma_info_inst_mix_iparith_avx256
Testing tma_info_inst_mix_iparith_scalar_dp
Testing tma_info_inst_mix_iparith_scalar_sp
Testing tma_info_inst_mix_ipflop
Testing tma_fetch_latency
Testing tma_avx_assists
Testing tma_fp_arith
Testing tma_fp_assists
Testing tma_info_system_cpu_utilization
Testing tma_info_system_dram_bw_use
Testing tma_shuffles
Testing tma_info_frontend_l2mpki_code
Testing tma_info_frontend_l2mpki_code_all
Testing tma_info_inst_mix_ipload
Testing tma_info_inst_mix_ipstore
Testing tma_info_bottleneck_memory_bandwidth
Testing tma_info_bottleneck_memory_data_tlbs
Testing tma_info_bottleneck_memory_latency
Testing tma_info_memory_core_l1d_cache_fill_bw
Testing tma_info_memory_core_l2_cache_fill_bw
Testing tma_info_memory_core_l3_cache_access_bw
Testing tma_info_memory_core_l3_cache_fill_bw
Testing tma_info_memory_load_miss_real_latency
Testing tma_info_memory_mlp
Testing tma_info_memory_thread_l1d_cache_fill_bw_1t
Testing tma_info_memory_thread_l2_cache_fill_bw_1t
Testing tma_info_memory_thread_l3_cache_access_bw_1t
Testing tma_info_memory_thread_l3_cache_fill_bw_1t
Testing tma_info_memory_tlb_load_stlb_mpki
Testing tma_info_memory_tlb_page_walks_utilization
Testing tma_info_memory_tlb_store_stlb_mpki
Testing tma_info_system_mem_parallel_reads
Testing tma_info_system_mem_read_latency
Testing tma_info_system_mem_request_latency
Testing tma_info_thread_cpi
Testing tma_fb_full
Testing tma_mem_bandwidth
Testing tma_sq_full
Testing tma_streaming_stores
Testing tma_dram_bound
Testing tma_store_bound
Testing tma_l3_hit_latency
Testing tma_mem_latency
Testing tma_store_latency
Testing tma_dtlb_load
Testing tma_dtlb_store
Testing tma_load_stlb_hit
Testing tma_load_stlb_miss
Testing tma_store_stlb_hit
Testing tma_store_stlb_miss
Testing tma_info_memory_oro_data_l2_mlp
Testing tma_info_memory_oro_load_l2_mlp
Testing tma_info_memory_oro_load_l2_miss_latency
Testing tma_info_memory_oro_load_l3_miss_latency
Testing tma_microcode_sequencer
Testing tma_info_core_clks
Testing tma_info_core_clks_p
Testing tma_info_core_cpi
Testing tma_info_core_ipc
Testing tma_info_core_slots
Testing tma_info_core_upi
Testing tma_info_frontend_inst_miss_cost_dramhit_percent
Testing tma_info_frontend_inst_miss_cost_l2hit_percent
Testing tma_info_frontend_inst_miss_cost_l3hit_percent
Testing tma_info_inst_mix_branch_mispredict_ratio
Testing tma_info_inst_mix_branch_mispredict_to_unknown_branch_ratio
Testing tma_info_inst_mix_fpdiv_uop_ratio
Testing tma_info_inst_mix_idiv_uop_ratio
Testing tma_info_inst_mix_ipfarbranch
Testing tma_info_inst_mix_ipmisp_cond_ntaken
Testing tma_info_inst_mix_ipmisp_cond_taken
Testing tma_info_inst_mix_ipmisp_indirect
Testing tma_info_inst_mix_ipmisp_ret
Testing tma_info_inst_mix_ipmispredict
Testing tma_info_inst_mix_microcode_uop_ratio
Testing tma_info_inst_mix_x87_uop_ratio
Testing tma_info_l1_bound_address_alias_blocks
Testing tma_info_l1_bound_load_splits
Testing tma_info_l1_bound_store_fwd_blocks
Testing tma_info_memory_cycles_per_demand_load_dram_hit
Testing tma_info_memory_cycles_per_demand_load_l2_hit
Testing tma_info_memory_cycles_per_demand_load_l3_hit
Testing tma_info_memory_memloadpki
Testing tma_info_system_kernel_cpi
Testing tma_info_system_kernel_utilization
Testing tma_data_sharing
Testing tma_lock_latency
Testing tma_fused_instructions
Testing tma_info_pipeline_ipassist
Testing tma_info_pipeline_retire
Testing tma_info_pipeline_strings_cycles
Testing tma_info_thread_clks
Testing tma_info_thread_uoppi
Testing tma_int_operations
Testing tma_memory_operations
Testing tma_non_fused_branches
Testing tma_nop_instructions
Testing tma_other_light_ops
Testing tma_ports_utilization
Testing tma_ports_utilized_0
Testing tma_ports_utilized_1
Metric 'tma_ports_utilized_1' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 75.810 usec (+- 0.039 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.547 usec
  Average data synthesis took: 81.631 usec (+- 0.033 usec)
  Average num. events: 257.000 (+- 0.000)
  Average time per event 0.318 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.786980972 seconds time elapsed

       0.649608000 seconds user
       1.128060000 seconds sys
Testing tma_ports_utilized_2
Metric 'tma_ports_utilized_2' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 77.342 usec (+- 0.042 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.578 usec
  Average data synthesis took: 85.115 usec (+- 0.033 usec)
  Average num. events: 256.000 (+- 0.000)
  Average time per event 0.332 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.829972757 seconds time elapsed

       0.651383000 seconds user
       1.146739000 seconds sys
Testing tma_ports_utilized_3m
Metric 'tma_ports_utilized_3m' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 76.760 usec (+- 0.043 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.567 usec
  Average data synthesis took: 82.118 usec (+- 0.031 usec)
  Average num. events: 257.000 (+- 0.000)
  Average time per event 0.320 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/UOPS_EXECUTED.CYCLES_GE_3/                                        (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.798830992 seconds time elapsed

       0.626191000 seconds user
       1.159087000 seconds sys
Testing tma_serializing_operation
Testing C10_Pkg_Residency
Testing C1_Core_Residency
Testing C2_Pkg_Residency
Testing C3_Pkg_Residency
Testing C6_Core_Residency
Testing C6_Pkg_Residency
Testing C7_Core_Residency
Testing C7_Pkg_Residency
Testing C8_Pkg_Residency
Testing C9_Pkg_Residency
Testing tma_info_system_average_frequency
Testing tma_info_system_turbo_utilization
Testing tma_info_inst_mix_ipswpf
Testing tma_info_bottleneck_branching_overhead
Testing tma_info_core_coreipc
Testing tma_info_thread_ipc
Testing tma_heavy_operations
Testing tma_light_operations
Testing tma_info_core_core_clks
Testing tma_info_system_smt_2t_utilization
Testing tma_info_thread_slots_utilization
Testing UNCORE_FREQ
Testing tma_info_system_socket_clks
Testing tma_info_inst_mix_instructions
Testing tma_info_thread_slots
Testing tma_base
Testing tma_ms_uops
Testing tma_resource_bound
Testing tma_alloc_restriction
Testing tma_branch_detect
Testing tma_branch_resteer
Testing tma_cisc
Testing tma_decode
Testing tma_divider
Testing tma_fast_nuke
Testing tma_few_uops_instructions
Testing tma_fpdiv_uops
Testing tma_mem_scheduler
Testing tma_non_mem_scheduler
Testing tma_nuke
Testing tma_other_fb
Testing tma_other_load_store
Testing tma_other_ret
Testing tma_predecode
Testing tma_register
Testing tma_reorder_buffer
Testing tma_serialization
Testing tma_assists
Testing tma_disambiguation
Testing tma_fp_assist
Testing tma_ld_buffer
Testing tma_memory_ordering
Testing tma_other_l1
Testing tma_page_fault
Testing tma_rsv
Testing tma_smc
Testing tma_split_loads
Testing tma_split_stores
Testing tma_st_buffer
Testing tma_stlb_hit
Testing tma_stlb_miss
Testing tma_store_fwd_blk
Testing tma_alu_op_utilization
Testing tma_load_op_utilization
Testing tma_mixing_vectors
Testing tma_page_faults
Testing tma_store_op_utilization
Testing tma_memory_fence
Metric 'tma_memory_fence' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 74.959 usec (+- 0.035 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.530 usec
  Average data synthesis took: 80.259 usec (+- 0.030 usec)
  Average num. events: 255.000 (+- 0.000)
  Average time per event 0.315 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/MISC2_RETIRED.LFENCE/                                          (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.781118961 seconds time elapsed

       0.643719000 seconds user
       1.127896000 seconds sys
Testing tma_port_1
Testing tma_port_6
Testing tma_slow_pause
Metric 'tma_slow_pause' not printed in:
# Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 75.389 usec (+- 0.044 usec)
  Average num. events: 49.000 (+- 0.000)
  Average time per event 1.539 usec
  Average data synthesis took: 80.662 usec (+- 0.031 usec)
  Average num. events: 256.000 (+- 0.000)
  Average time per event 0.315 usec

 Performance counter stats for 'perf bench internals synthesize':

     <not counted>      cpu_core/TOPDOWN.SLOTS/                                                 (0.00%)
     <not counted>      cpu_core/topdown-retiring/                                              (0.00%)
     <not counted>      cpu_core/topdown-mem-bound/                                             (0.00%)
     <not counted>      cpu_core/topdown-bad-spec/                                              (0.00%)
     <not counted>      cpu_core/topdown-fe-bound/                                              (0.00%)
     <not counted>      cpu_core/topdown-be-bound/                                              (0.00%)
     <not counted>      cpu_core/RESOURCE_STALLS.SCOREBOARD/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.1_PORTS_UTIL/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.BOUND_ON_LOADS/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.PAUSE/                                        (0.00%)
     <not counted>      cpu_core/CYCLE_ACTIVITY.STALLS_TOTAL/                                        (0.00%)
     <not counted>      cpu_core/CPU_CLK_UNHALTED.THREAD/                                        (0.00%)
     <not counted>      cpu_core/ARITH.DIV_ACTIVE/                                              (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.2_PORTS_UTIL,umask=0xc/                                        (0.00%)
     <not counted>      cpu_core/EXE_ACTIVITY.3_PORTS_UTIL,umask=0x80/                                        (0.00%)

       1.765949472 seconds time elapsed

       0.636513000 seconds user
       1.119875000 seconds sys
Testing smi_cycles
Testing smi_num
Testing tsx_aborted_cycles
Testing tsx_cycles_per_elision
Testing tsx_cycles_per_transaction
Testing tsx_transactional_cycles
test child finished with -1
---- end ----
perf all metrics test: FAILED!
root@x1:~#

