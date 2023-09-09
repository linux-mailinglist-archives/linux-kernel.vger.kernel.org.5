Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B724799677
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbjIIFet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjIIFes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:34:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EFFE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:34:40 -0700 (PDT)
X-QQ-mid: bizesmtp70t1694237658tp4lqm5l
Received: from wangjiexun-virtual-machine.loca ( [120.225.34.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 09 Sep 2023 13:34:16 +0800 (CST)
X-QQ-SSF: 01200000000000101000000A0000000
X-QQ-FEAT: +ynUkgUhZJk0o36SX0cCUfGQV9qDkRzv+i3m9nOEfZ4tBTXD4SiKRaZDhN5Em
        lVKK2DEQCPmcLkWea5WU6iKm6c+tR+XU8dS0GuqHT16j/QsH62LtLWmjalr8bNlIcQ2ud2a
        0gDjOGNog3+zUi2sEZO9Vw5qGdQCEr8RofJ2awyNZbsGQAqq4YmHf/CnY734sZHyq9G1SO2
        mm0zJfCHABSyzTwCf5dR72xLxxaAplYOcoQgjRovbzy5YNuOtGC3PyB26g3XfCMRXVskTnv
        YA6CLEyhg87Katp6A6WY852e211B7uFiutz9Eae+Vsbbu0c7hxiWDNw2Sl20KfKv9xLFoId
        A87Q4NyWdFBGKA1pCw1ZIqTSoDhRCAeoGIeNIA5AdMJfC7NPJmRxbNWtcERMu1i3w+w8QH+
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6414762947535876167
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     akpm@linux-foundation.org, brauner@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, Jiexun Wang <wangjiexun@tinylab.org>
Subject: [PATCH 0/1] mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()
Date:   Sat,  9 Sep 2023 13:33:07 +0800
Message-Id: <cover.1694219361.git.wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I conducted real-time testing on the LicheePi 4A board using 
Cylictest and employed Ftrace for latency tracing. I observed 
that madvise_cold_or_pageout_pte_range() causes significant 
latency under memory pressure, which can be effectively reduced 
by adding cond_resched() within the loop.

The script I tested is as follows:

echo wakeup_rt > /sys/kernel/tracing/current_tracer
echo 1 > /sys/kernel/tracing/tracing_on
echo 0 > /sys/kernel/tracing/tracing_max_latency
stress-ng --cpu 4 --vm 4 --vm-bytes 2G &
cyclictest --mlockall --smp --priority=99 --distance=0 --duration=30m
echo 0 > /sys/kernel/tracing/tracing_on
cat /sys/kernel/tracing/trace 

The tracing results before modification are as follows:

# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 6.5.0-rt6-r1208-00003-g999d221864bf
# --------------------------------------------------------------------
# latency: 1969 us, #6/6, CPU#1 | (M:preempt_rt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: cyclictest-250 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _--------=> CPU#
#                   / _-------=> irqs-off/BH-disabled
#                  | / _------=> need-resched
#                  || / _-----=> need-resched-lazy
#                  ||| / _----=> hardirq/softirq
#                  |||| / _---=> preempt-depth
#                  ||||| / _--=> preempt-lazy-depth
#                  |||||| / _-=> migrate-disable
#                  ||||||| /     delay
#  cmd     pid     |||||||| time  |   caller
#     \   /        ||||||||  \    |    /
stress-n-264       1dn.h511    1us :      264:120:R   + [001]     250:  0:R cyclictest
stress-n-264       1dn.h511    6us : <stack trace>
 => __ftrace_trace_stack
 => __trace_stack
 => probe_wakeup
 => ttwu_do_activate
 => try_to_wake_up
 => wake_up_process
 => hrtimer_wakeup
 => __hrtimer_run_queues
 => hrtimer_interrupt
 => riscv_timer_interrupt
 => handle_percpu_devid_irq
 => generic_handle_domain_irq
 => riscv_intc_irq
 => handle_riscv_irq
 => do_irq
stress-n-264       1dn.h511    8us#: 0
stress-n-264       1d...3.. 1953us : __schedule
stress-n-264       1d...3.. 1956us+:      264:120:R ==> [001]     250:  0:R cyclictest
stress-n-264       1d...3.. 1968us : <stack trace>
 => __ftrace_trace_stack
 => __trace_stack
 => probe_wakeup_sched_switch
 => __schedule
 => preempt_schedule
 => migrate_enable
 => rt_spin_unlock
 => madvise_cold_or_pageout_pte_range
 => walk_pgd_range
 => __walk_page_range
 => walk_page_range
 => madvise_pageout
 => madvise_vma_behavior
 => do_madvise
 => sys_madvise
 => do_trap_ecall_u
 => ret_from_exception

The tracing results after modification are as follows:

# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 6.5.0-rt6-r1208-00003-g999d221864bf-dirty
# --------------------------------------------------------------------
# latency: 879 us, #6/6, CPU#2 | (M:preempt_rt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: cyclictest-212 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _--------=> CPU#
#                   / _-------=> irqs-off/BH-disabled
#                  | / _------=> need-resched
#                  || / _-----=> need-resched-lazy
#                  ||| / _----=> hardirq/softirq
#                  |||| / _---=> preempt-depth
#                  ||||| / _--=> preempt-lazy-depth
#                  |||||| / _-=> migrate-disable
#                  ||||||| /     delay
#  cmd     pid     |||||||| time  |   caller
#     \   /        ||||||||  \    |    /
stress-n-223       2dn.h413    1us :      223:120:R   + [002]     212:  0:R cyclictest
stress-n-223       2dn.h413    6us : <stack trace>
 => __ftrace_trace_stack
 => __trace_stack
 => probe_wakeup
 => ttwu_do_activate
 => try_to_wake_up
 => wake_up_process
 => hrtimer_wakeup
 => __hrtimer_run_queues
 => hrtimer_interrupt
 => riscv_timer_interrupt
 => handle_percpu_devid_irq
 => generic_handle_domain_irq
 => riscv_intc_irq
 => handle_riscv_irq
 => do_irq
stress-n-223       2dn.h413    9us!: 0
stress-n-223       2d...3..  850us : __schedule
stress-n-223       2d...3..  856us+:      223:120:R ==> [002]     212:  0:R cyclictest
stress-n-223       2d...3..  875us : <stack trace>
 => __ftrace_trace_stack
 => __trace_stack
 => probe_wakeup_sched_switch
 => __schedule
 => preempt_schedule
 => migrate_enable
 => free_unref_page_list
 => release_pages
 => free_pages_and_swap_cache
 => tlb_batch_pages_flush
 => tlb_flush_mmu
 => unmap_page_range
 => unmap_vmas
 => unmap_region
 => do_vmi_align_munmap.constprop.0
 => do_vmi_munmap
 => __vm_munmap
 => sys_munmap
 => do_trap_ecall_u
 => ret_from_exception

After the modification, the cause of maximum latency is no longer
madvise_cold_or_pageout_pte_range(), so this modification can 
reduce the latency caused by madvise_cold_or_pageout_pte_range().

Jiexun Wang (1):
  add cond_resched() in madvise_cold_or_pageout_pte_range()

 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.34.1

