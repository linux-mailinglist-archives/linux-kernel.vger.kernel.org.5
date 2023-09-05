Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B1792CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbjIERtk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbjIERt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:49:27 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000DF53C;
        Tue,  5 Sep 2023 10:33:00 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-79536bc669dso109246239f.3;
        Tue, 05 Sep 2023 10:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935057; x=1694539857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO1FPtedkL47l4TfFe1IxuBcYOsSdt2mnyn3ookT8H0=;
        b=KeS/0lzLe4arM9GikLR5okGniCW5Yd0SFyxEkcJ31awtRiZMbJixYCzGtRBx97kMGF
         hQBJERCNnhh9dxwijEgtnzFvyFfQDqy0mGfGuRsITVi/XxWQwXCN46aOp3YHLtqGcMeI
         vwwXIsFK9Y3wxnB9aeOeejdTZetV0sSo8pAVcIx+GESqi5A6d49MnpvgkS/dl4P0eEXW
         yZiZTV7L4M+XGPi96pPGr/WAqBUJtHtPAuoZ4adJrIuTmTdLeI6JV4LxhdGtZXviT8L6
         6kENeQpYnXzUDYfn/X+CaT8/0obrRIkyB9FuHqY5fc4TJN8wtvYGOPBKFMxalYcCrSLA
         Tizg==
X-Gm-Message-State: AOJu0YzTESYJAJnklAvYPayLzOxwO9tISUGHPS4Y+2oLhEYfCXRgMf2i
        UhG7LZ27S1qwROXIBJZ1x/n3QAWjWs+fYRAol3k=
X-Google-Smtp-Source: AGHT+IHtteEAVcF3a6dBQVFAMiOijOcuoMZoT0qI0UGD52X/zurM+ZxwTiXAT0FEU0whUmY7A38sBD5vS8FG9EdnUWc=
X-Received: by 2002:a6b:4904:0:b0:787:953:514b with SMTP id
 u4-20020a6b4904000000b007870953514bmr16237718iob.3.1693935056803; Tue, 05 Sep
 2023 10:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230620170027.1861012-1-weilin.wang@intel.com>
 <CAM9d7cichi8QpVFjCDUf8e5aJEuZg1JPHtMBEs_FSNtsm8VoeA@mail.gmail.com> <CAM9d7chBM_z=vNKsLFTLVevXgd8=ZfS_XSX=999+jitrTJodTA@mail.gmail.com>
In-Reply-To: <CAM9d7chBM_z=vNKsLFTLVevXgd8=ZfS_XSX=999+jitrTJodTA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Sep 2023 10:30:45 -0700
Message-ID: <CAM9d7cjd022T5n6TyD96M_T5KNjHTDgjfK_mKKTZYMmKEKi58w@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add metric value validation test
To:     Weilin Wang <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>, ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Weilin,

Now I'm seeing occasional failures in this test.  Can you please take a look?

Thanks,
Namhyung


--8<--

$ sudo ./perf test -v 105
105: perf metrics value validation                                   :
--- start ---
test child forked, pid 78217
Launch python validation script ./tests/shell/lib/perf_metric_validation.py
Output will be stored in: /tmp/__perf_test.program.ymbCm
Starting perf collection
Long workload: perf bench futex hash -r 2 -s
perf stat -j -M tma_branch_mispredicts -a true
perf stat -j -M tma_info_memory_core_l2_cache_fill_bw -a true
perf stat -j -M tma_retiring -a true
perf stat -j -M tma_info_bad_spec_branch_misprediction_cost -a true
perf stat -j -M tma_port_0 -a true
perf stat -j -M tma_itlb_misses -a true
perf stat -j -M tma_other_light_ops -a true
perf stat -j -M smi_cycles -a true
perf stat -j -M c7_core_residency -a true
perf stat -j -M tma_split_stores -a true
perf stat -j -M tma_info_frontend_dsb_coverage -a true
perf stat -j -M tma_info_frontend_icache_miss_latency -a true
perf stat -j -M tma_store_stlb_hit -a true
perf stat -j -M tma_dram_bound -a true
perf stat -j -M tma_info_system_dram_bw_use -a true
perf stat -j -M tma_info_bad_spec_ipmisp_cond_taken -a true
perf stat -j -M tma_info_botlnk_l0_core_bound_likely -a true
perf stat -j -M tma_machine_clears -a true
perf stat -j -M tma_info_system_kernel_cpi -a true
perf stat -j -M tma_decoder0_alone -a true
perf stat -j -M tma_info_system_cpu_utilization -a true
perf stat -j -M tma_clears_resteers -a true
perf stat -j -M tma_fp_vector_512b -a true
perf stat -j -M tma_dtlb_store -a true
perf stat -j -M tma_info_branches_cond_nt -a true
perf stat -j -M tma_info_memory_core_l3_cache_access_bw -a true
perf stat -j -M tma_info_memory_oro_load_l2_mlp -a true
perf stat -j -M c8_pkg_residency -a true
perf stat -j -M tma_mem_bandwidth -a true
perf stat -j -M tma_fp_vector_256b -a true
perf stat -j -M tma_branch_resteers -a true
perf stat -j -M tma_false_sharing -a true
perf stat -j -M tma_info_core_ilp -a true
perf stat -j -M tma_bad_speculation -a true
perf stat -j -M tma_info_system_power_license1_utilization -a true
perf stat -j -M tma_load_stlb_miss -a true
perf stat -j -M tma_info_system_average_frequency -a true
perf stat -j -M tma_info_frontend_fetch_upc -a true
perf stat -j -M tma_info_branches_cond_tk -a true
perf stat -j -M tma_info_bad_spec_ipmispredict -a true
perf stat -j -M tma_info_branches_callret -a true
perf stat -j -M tma_info_inst_mix_iparith_avx512 -a true
perf stat -j -M tma_info_frontend_l2mpki_code_all -a true
perf stat -j -M tma_divider -a true
perf stat -j -M tma_info_system_mem_parallel_reads -a true
perf stat -j -M tma_info_branches_jump -a true
perf stat -j -M tma_mixing_vectors -a true
perf stat -j -M tma_cisc -a true
perf stat -j -M tma_info_thread_ipc -a true
perf stat -j -M tma_lcp -a true
perf stat -j -M tma_assists -a true
perf stat -j -M tma_dtlb_load -a true
perf stat -j -M tma_info_memory_load_miss_real_latency -a true
perf stat -j -M tma_fetch_latency -a true
perf stat -j -M tma_info_bad_spec_ipmisp_ret -a true
perf stat -j -M tma_sq_full -a true
perf stat -j -M tma_info_pipeline_retire -a true
perf stat -j -M tma_info_memory_tlb_page_walks_utilization -a true
perf stat -j -M tma_store_latency -a true
perf stat -j -M tma_port_5 -a true
perf stat -j -M tma_info_memory_thread_l2_cache_fill_bw_1t -a true
perf stat -j -M tma_load_op_utilization -a true
perf stat -j -M tma_info_frontend_lsd_coverage -a true
perf stat -j -M tma_info_memory_thread_l3_cache_access_bw_1t -a true
perf stat -j -M tma_l3_hit_latency -a true
perf stat -j -M tma_info_system_kernel_utilization -a true
perf stat -j -M tma_backend_bound -a true
perf stat -j -M c7_pkg_residency -a true
perf stat -j -M tma_info_memory_fb_hpki -a true
perf stat -j -M tma_info_botlnk_l2_ic_misses -a true
perf stat -j -M tma_info_memory_l3mpki -a true
perf stat -j -M tma_l1_bound -a true
perf stat -j -M c6_pkg_residency -a true
perf stat -j -M tma_nop_instructions -a true
perf stat -j -M tma_load_stlb_hit -a true
perf stat -j -M tma_microcode_sequencer -a true
perf stat -j -M tma_mem_latency -a true
perf stat -j -M tma_data_sharing -a true
perf stat -j -M tma_core_bound -a true
perf stat -j -M tma_store_bound -a true
perf stat -j -M tma_store_op_utilization -a true
perf stat -j -M tsx_aborted_cycles -a true
perf stat -j -M tma_mispredicts_resteers -a true
perf stat -j -M tma_memory_operations -a true
perf stat -j -M tma_info_memory_oro_data_l2_mlp -a true
perf stat -j -M tma_4k_aliasing -a true
perf stat -j -M c10_pkg_residency -a true
perf stat -j -M tma_info_memory_mlp -a true
perf stat -j -M tma_fp_vector -a true
perf stat -j -M tma_info_bottleneck_big_code -a true
perf stat -j -M tma_info_core_flopc -a true
perf stat -j -M tma_memory_bound -a true
perf stat -j -M tma_info_memory_core_l3_cache_fill_bw -a true
perf stat -j -M tma_alu_op_utilization -a true
perf stat -j -M c9_pkg_residency -a true
perf stat -j -M tma_info_system_gflops -a true
perf stat -j -M tma_split_loads -a true
perf stat -j -M c2_pkg_residency -a true
perf stat -j -M tsx_cycles_per_transaction -a true
perf stat -j -M tma_branch_instructions -a true
perf stat -j -M tma_ms_switches -a true
perf stat -j -M c6_core_residency -a true
perf stat -j -M tma_streaming_stores -a true
perf stat -j -M tma_l3_bound -a true
perf stat -j -M tma_info_memory_l2mpki_load -a true
perf stat -j -M tma_slow_pause -a true
perf stat -j -M tma_info_frontend_ipunknown_branch -a true
perf stat -j -M tma_contested_accesses -a true
perf stat -j -M tma_info_bottleneck_branching_overhead -a true
perf stat -j -M tma_x87_use -a true
perf stat -j -M tma_frontend_bound -a true
perf stat -j -M tma_store_fwd_blk -a true
perf stat -j -M tma_info_system_mem_request_latency -a true
perf stat -j -M tma_info_bad_spec_ipmisp_indirect -a true
perf stat -j -M tma_info_system_turbo_utilization -a true
perf stat -j -M tma_heavy_operations -a true
perf stat -j -M tma_light_operations -a true
perf stat -j -M tma_ports_utilization -a true
perf stat -j -M tma_info_memory_l2hpki_load -a true
perf stat -j -M tma_dsb_switches -a true
perf stat -j -M tma_info_memory_l1mpki -a true
perf stat -j -M tma_info_memory_core_l1d_cache_fill_bw -a true
perf stat -j -M tma_info_core_core_clks -a true
perf stat -j -M tma_info_memory_tlb_code_stlb_mpki -a true
perf stat -j -M tma_info_memory_tlb_load_stlb_mpki -a true
perf stat -j -M tma_info_system_mem_read_latency -a true
perf stat -j -M tma_ports_utilized_2 -a true
perf stat -j -M tma_info_inst_mix_iparith -a true
perf stat -j -M tma_ports_utilized_3m -a true
perf stat -j -M tma_info_system_smt_2t_utilization -a true
perf stat -j -M tma_info_thread_slots -a true
perf stat -j -M tma_info_thread_clks -a true
perf stat -j -M tma_info_core_coreipc -a true
perf stat -j -M tma_info_memory_oro_load_l3_miss_latency -a true
perf stat -j -M tma_info_inst_mix_iparith_scalar_sp -a true
perf stat -j -M tma_lock_latency -a true
perf stat -j -M tma_info_inst_mix_ipflop -a true
perf stat -j -M tma_unknown_branches -a true
perf stat -j -M tma_info_bottleneck_memory_latency -a true
perf stat -j -M tma_serializing_operation -a true
perf stat -j -M tma_lsd -a true
perf stat -j -M tma_info_system_ipfarbranch -a true
perf stat -j -M tma_info_inst_mix_iptb -a true
perf stat -j -M tma_info_botlnk_l2_dsb_misses -a true
perf stat -j -M tma_mite -a true
perf stat -j -M tma_icache_misses -a true
perf stat -j -M tma_info_memory_l1mpki_load -a true
perf stat -j -M tma_fp_arith -a true
perf stat -j -M tma_info_memory_l2hpki_all -a true
perf stat -j -M tma_port_1 -a true
perf stat -j -M tma_info_system_power_license0_utilization -a true
perf stat -j -M tma_mite_4wide -a true
perf stat -j -M tma_info_frontend_dsb_switch_cost -a true
perf stat -j -M tma_info_thread_execute_per_issue -a true
perf stat -j -M tma_info_bad_spec_ipmisp_cond_ntaken -a true
perf stat -j -M tma_fp_scalar -a true
perf stat -j -M tma_info_inst_mix_ipswpf -a true
perf stat -j -M tma_info_inst_mix_bptkbranch -a true
perf stat -j -M tma_info_memory_l2mpki_all -a true
perf stat -j -M tma_info_inst_mix_instructions -a true
perf stat -j -M tma_info_inst_mix_ipload -a true
perf stat -j -M tma_info_thread_slots_utilization -a true
perf stat -j -M tma_info_thread_cpi -a true
perf stat -j -M tma_info_bottleneck_instruction_fetch_bw -a true
perf stat -j -M tma_info_inst_mix_ipbranch -a true
perf stat -j -M tma_ports_utilized_1 -a true
perf stat -j -M tma_info_inst_mix_iparith_avx256 -a true
perf stat -j -M tma_store_stlb_miss -a true
perf stat -j -M tma_dsb -a true
perf stat -j -M smi_num -a true
perf stat -j -M tsx_transactional_cycles -a true
perf stat -j -M tma_fp_vector_128b -a true
perf stat -j -M tma_fetch_bandwidth -a true
perf stat -j -M tma_fb_full -a true
perf stat -j -M tma_info_bottleneck_mispredictions -a true
perf stat -j -M tma_port_6 -a true
perf stat -j -M tma_info_frontend_l2mpki_code -a true
perf stat -j -M tma_info_core_fp_arith_utilization -a true
perf stat -j -M tma_info_inst_mix_iparith_avx128 -a true
perf stat -j -M tma_info_memory_l2mpki -a true
perf stat -j -M tma_info_bottleneck_memory_bandwidth -a true
perf stat -j -M tma_info_memory_thread_l1d_cache_fill_bw_1t -a true
perf stat -j -M tma_info_memory_oro_load_l2_miss_latency -a true
perf stat -j -M c3_pkg_residency -a true
perf stat -j -M tma_few_uops_instructions -a true
perf stat -j -M tma_info_pipeline_execute -a true
perf stat -j -M tma_info_frontend_ipdsb_miss_ret -a true
perf stat -j -M tma_info_memory_thread_l3_cache_fill_bw_1t -a true
perf stat -j -M tma_info_thread_uptb -a true
perf stat -j -M tma_info_inst_mix_ipcall -a true
perf stat -j -M tma_l2_bound -a true
perf stat -j -M tma_ports_utilized_0 -a true
perf stat -j -M tma_info_bottleneck_memory_data_tlbs -a true
perf stat -j -M tma_info_inst_mix_iparith_scalar_dp -a true
perf stat -j -M tma_info_inst_mix_ipstore -a true
perf stat -j -M tma_info_branches_other_branches -a true
perf stat -j -M tma_info_thread_uoppi -a true
perf stat -j -M tma_info_system_power_license2_utilization -a true
perf stat -j -M tsx_cycles_per_elision -a true
perf stat -j -M tma_info_memory_tlb_store_stlb_mpki -a true
perf stat -j -M
tma_backend_bound,tma_bad_speculation,tma_retiring,tma_frontend_bound
-a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78627]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1625344 operations/sec (+- 0.78%), total secs = 2
perf stat -j -M
tma_fetch_bandwidth,tma_frontend_bound,tma_fetch_latency -a perf bench
futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78637]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1622144 operations/sec (+- 0.25%), total secs = 2
perf stat -j -M
tma_machine_clears,tma_branch_mispredicts,tma_bad_speculation -a perf
bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78647]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1503103 operations/sec (+- 1.58%), total secs = 2
perf stat -j -M tma_core_bound,tma_memory_bound,tma_backend_bound -a
perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78680]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1415935 operations/sec (+- 2.26%), total secs = 2
perf stat -j -M tma_heavy_operations,tma_light_operations,tma_retiring
-a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78690]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1519872 operations/sec (+- 0.38%), total secs = 2
perf stat -j -M tma_other_light_ops -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78700]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1490816 operations/sec (+- 0.21%), total secs = 2
perf stat -j -M tma_split_stores -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78710]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1474816 operations/sec (+- 0.25%), total secs = 2
perf stat -j -M tma_store_stlb_hit -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78721]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1460032 operations/sec (+- 0.35%), total secs = 2
perf stat -j -M tma_dram_bound -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78732]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1421632 operations/sec (+- 0.56%), total secs = 2
perf stat -j -M tma_dtlb_store -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78742]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1431424 operations/sec (+- 0.24%), total secs = 2
perf stat -j -M tma_mem_bandwidth -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78752]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1344768 operations/sec (+- 1.51%), total secs = 2
perf stat -j -M tma_l3_hit_latency -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78765]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1369728 operations/sec (+- 1.18%), total secs = 2
perf stat -j -M tma_mem_latency -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78776]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1361536 operations/sec (+- 0.79%), total secs = 2
perf stat -j -M tma_data_sharing -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78786]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1302656 operations/sec (+- 1.90%), total secs = 2
perf stat -j -M tma_memory_operations -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78797]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1333184 operations/sec (+- 1.08%), total secs = 2
perf stat -j -M tma_4k_aliasing -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78807]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1268352 operations/sec (+- 2.13%), total secs = 2
perf stat -j -M tma_l3_bound -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78827]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1289408 operations/sec (+- 2.65%), total secs = 2
perf stat -j -M tma_store_fwd_blk -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78847]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1176256 operations/sec (+- 1.57%), total secs = 2
perf stat -j -M tma_lock_latency -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78857]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1050112 operations/sec (+- 2.42%), total secs = 2
perf stat -j -M tma_store_stlb_miss -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78867]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1117248 operations/sec (+- 1.96%), total secs = 2
perf stat -j -M tma_l2_bound -a perf bench futex hash -r 2 -s
# Running 'futex/hash' benchmark:
Run summary [PID 78877]: 8 threads, each operating on 1024 [private]
futexes for 2 secs.

Averaged 1174847 operations/sec (+- 0.74%), total secs = 2
Workload:  perf bench futex hash -r 2 -s
Total metrics collected:  197
Non-negative metric count:  197
Total Test Count:  100
Passed Test Count:  96
Test validation finished. Final report:
[
    {
        "Workload": "perf bench futex hash -r 2 -s",
        "Report": {
            "Metric Validation Statistics": {
                "Total Rule Count": 100,
                "Passed Rule Count": 96
            },
            "Tests in Category": {
                "PositiveValueTest": {
                    "Total Tests": 197,
                    "Passed Tests": 197,
                    "Failed Tests": []
                },
                "RelationshipTest": {
                    "Total Tests": 5,
                    "Passed Tests": 5,
                    "Failed Tests": []
                },
                "SingleMetricTest": {
                    "Total Tests": 95,
                    "Passed Tests": 91,
                    "Failed Tests": [
                        {
                            "RuleIndex": 6,
                            "RangeLower": "0",
                            "RangeUpper": "100",
                            "ErrorThreshold": 5,
                            "Failure": [
                                {
                                    "MetricName": "tma_split_stores",
                                    "CollectedValue": []
                                },
                                {
                                    "MetricName": "tma_4k_aliasing",
                                    "CollectedValue": []
                                },
                                {
                                    "MetricName": "tma_l3_bound",
                                    "CollectedValue": []
                                },
                                {
                                    "MetricName": "tma_store_fwd_blk",
                                    "CollectedValue": []
                                }
                            ]
                        }
                    ]
                }
            },
            "Errors": []
        }
    }
]
test child finished with -1
---- end ----
perf metrics value validation: FAILED!



On Thu, Jun 22, 2023 at 2:35 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Jun 21, 2023 at 5:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jun 20, 2023 at 10:00 AM Weilin Wang <weilin.wang@intel.com> wrote:
> > >
> > > This is the fifth version of metric value validation tests.
> > >
> > > We made the following changes from v4 to v5:
> > >  - Update "()" to "{}" to avoid creating sub shell and successfully skip test on non-Intel
> > >  platform. [Ravi]
> > >
> > > v4: https://lore.kernel.org/lkml/20230618172820.751560-1-weilin.wang@intel.com/
> > >
> > > Weilin Wang (3):
> > >   perf test: Add metric value validation test
> > >   perf test: Add skip list for metrics known would fail
> > >   perf test: Rerun failed metrics with longer workload
> >
> > Tested-by: Namhyung Kim <namhyung@kernel.org>
>
> Applied to perf-tools-next, thanks!
