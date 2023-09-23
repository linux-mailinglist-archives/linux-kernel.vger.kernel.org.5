Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B90C7AC2A4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjIWOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjIWOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:24:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ADF1AD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 07:24:31 -0700 (PDT)
X-QQ-mid: bizesmtp78t1695479063tck4ueym
Received: from wangjiexun-virtual-machine.loca ( [223.104.251.16])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Sep 2023 22:24:21 +0800 (CST)
X-QQ-SSF: 01200000000000201000000A0000000
X-QQ-FEAT: qOAV9bwDT/nVkw7SLrIQ5tcEIZ2s+un9FHMautATaeZAujzZa51biRWX8PpAl
        Zr9MUQkh2XVoGmvg6ivkt8StLHEUEljiOV4wjFBMeF0bOJWmGDHHHMeilT7uI6uu2VahxLR
        fqGpdBate+FEFSRo46G123DpvMPE2MNqTzXnABCvs6V+F8/3K9Q8xfeMRgXsRPaJuYDpmwJ
        MWsEK//ZHWe8YLD2nurxLv1M7o4Qh8rqvhymIPsbGxnAid3iuAkOasXYtkB9akMURIFsIr9
        LDgiClioTiRkc1uz/S++ebogBfErAVP00oNTV5X0oew6fY2iUWnfWWlQ5BaJCTb7Rtt0cXu
        E0tzee31zhDw6Ceu9e2IQoGD1AZjBEkWGpKq8UxJp217QZzspc=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15516014622260427791
From:   Jiexun Wang <wangjiexun@tinylab.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org
Subject: BUG: swap: significant latency caused by folio_batch_move_lru()
Date:   Sat, 23 Sep 2023 22:24:20 +0800
Message-Id: <20230923142420.120397-1-wangjiexun@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [43.154.54.12 listed in list.dnswl.org]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.154.54.12 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone:

I found that folio_batch_move_lru() causes significant latency 
under memory pressure. I try to add cond_resched() but get BUG message:

BUG: sleeping function called from invalid context at mm/swap.c

I tested on the LicheePi 4A board using Cylictest for latency testing and
Ftrace for latency tracing. The board uses TH1520 processor and has a
memory size of 8GB. The kernel version is 6.5.0 with the PREEMPT_RT
patch applied.

The tracing results of wakeup_rt tracer are:

# tracer: wakeup_rt
#
# wakeup_rt latency trace v1.1.5 on 6.5.0-rt6-r1208-00004-gca3876fc69a6-dirty
# --------------------------------------------------------------------
# latency: 1689 us, #6/6, CPU#0 | (M:preempt_rt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: cyclictest-217 (uid:0 nice:0 policy:1 rt_prio:99)
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
stress-n-232       0dn.h413    1us+:      232:120:R   + [000]     217:  0:R cyclictest
stress-n-232       0dn.h413   12us : <stack trace>
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
stress-n-232       0dn.h413   19us#: 0
stress-n-232       0d...3.. 1671us : __schedule
stress-n-232       0d...3.. 1676us+:      232:120:R ==> [000]     217:  0:R cyclictest
stress-n-232       0d...3.. 1687us : <stack trace>
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

I obtained more detailed information with display-graph option:

...
     1168 us |   0)  stress--204   |  .n..... |               |  unmap_region() {
     1171 us |   0)  stress--204   |  .n..... |               |    lru_add_drain() {
     1175 us |   0)  stress--204   |  .n..1.. |               |      lru_add_drain_cpu() {
     1184 us |   0)  stress--204   |  .n..1.. |               |        folio_batch_move_lru() {
     1187 us |   0)  stress--204   |  .n..1.. |               |          folio_lruvec_lock_irqsave() {
     1190 us |   0)  stress--204   |  .n..1.. |   3.000 us    |            _raw_spin_lock_irqsave();
     1196 us |   0)  stress--204   |  dn..2.. |   8.667 us    |          }
     1200 us |   0)  stress--204   |  dn..2.. |               |          lru_add_fn() {
     1204 us |   0)  stress--204   |  dn..3.. |   2.667 us    |            folio_mapping();
     1213 us |   0)  stress--204   |  dn..2.. |               |            __mod_lruvec_state() {
     1215 us |   0)  stress--204   |  dn..2.. |   2.667 us    |              __mod_node_page_state();
     1221 us |   0)  stress--204   |  dn..2.. |               |              __mod_memcg_lruvec_state() {
     1224 us |   0)  stress--204   |  dn..2.. |   2.334 us    |                cgroup_rstat_updated();
     1229 us |   0)  stress--204   |  dn..2.. |   9.000 us    |              }
     1232 us |   0)  stress--204   |  dn..2.. | + 19.000 us   |            }
     1234 us |   0)  stress--204   |  dn..2.. |   2.667 us    |            __mod_zone_page_state();
     1239 us |   0)  stress--204   |  dn..2.. |   4.334 us    |            mem_cgroup_update_lru_size();
     1246 us |   0)  stress--204   |  dn..2.. | + 46.333 us   |          }
     1249 us |   0)  stress--204   |  dn..2.. |               |          lru_add_fn() {
     1252 us |   0)  stress--204   |  dn..3.. |   2.333 us    |            folio_mapping();
     1258 us |   0)  stress--204   |  dn..2.. |               |            __mod_lruvec_state() {
     1261 us |   0)  stress--204   |  dn..2.. |   2.333 us    |              __mod_node_page_state();
     1266 us |   0)  stress--204   |  dn..2.. |               |              __mod_memcg_lruvec_state() {
     1270 us |   0)  stress--204   |  dn..2.. |   2.333 us    |                cgroup_rstat_updated();
     1276 us |   0)  stress--204   |  dn..2.. | + 10.333 us   |              }
     1278 us |   0)  stress--204   |  dn..2.. | + 20.000 us   |            }
     1281 us |   0)  stress--204   |  dn..2.. |   4.000 us    |            __mod_zone_page_state();
     1287 us |   0)  stress--204   |  dn..2.. |   4.000 us    |            mem_cgroup_update_lru_size();
...
     1696 us |   0)  stress--204   |  dn..2.. |               |          lru_add_fn() {
     1700 us |   0)  stress--204   |  dn..3.. |   2.666 us    |            folio_mapping();
     1706 us |   0)  stress--204   |  dn..2.. |               |            __mod_lruvec_state() {
     1710 us |   0)  stress--204   |  dn..2.. |   2.667 us    |              __mod_node_page_state();
     1716 us |   0)  stress--204   |  dn..2.. |               |              __mod_memcg_lruvec_state() {
     1720 us |   0)  stress--204   |  dn..2.. |   2.334 us    |                cgroup_rstat_updated();
     1726 us |   0)  stress--204   |  dn..2.. |   9.667 us    |              }
     1728 us |   0)  stress--204   |  dn..2.. | + 22.000 us   |            }
     1731 us |   0)  stress--204   |  dn..2.. |   2.666 us    |            __mod_zone_page_state();
     1736 us |   0)  stress--204   |  dn..2.. |   2.333 us    |            mem_cgroup_update_lru_size();
     1740 us |   0)  stress--204   |  dn..2.. | + 44.666 us   |          }
     1744 us |   0)  stress--204   |  dn..2.. |   3.333 us    |          _raw_spin_unlock_irqrestore();
     1750 us |   0)  stress--204   |  .n..1.. |               |          release_pages() {
     1756 us |   0)  stress--204   |  .n..1.. |   3.667 us    |            __mem_cgroup_uncharge_list();
     1762 us |   0)  stress--204   |  .n..1.. |   2.667 us    |            free_unref_page_list();
     1769 us |   0)  stress--204   |  .n..1.. | + 18.667 us   |          }
     1772 us |   0)  stress--204   |  .n..1.. | ! 588.000 us  |        }
     1777 us |   0)  stress--204   |  .n..1.. | ! 600.000 us  |      }
     1780 us |   0)  stress--204   |  .n..... |   2.667 us    |      mlock_drain_local();
     1785 us |   0)  stress--204   |  .n..... | ! 614.000 us  |    }
...

I attempted to unlock and call cond_resched() within the loop:

@@ -217,6 +217,12 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
                move_fn(lruvec, folio);
 
                folio_set_lru(folio);
+
+               if (i % 4 == 0) {
+                       if (lruvec)
+                               unlock_page_lruvec_irqrestore(lruvec, flags);
+                       cond_resched();
+                       lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
        }
 
        if (lruvec)

Then I received BUG messages continuously:

BUG: sleeping function called from invalid context at ...

I noticed that there are also locks at the outer layer of this function.
I also attempted to release the locks, but still received the same BUG info.
I wonder if the internal of this function is non-preemptible?
Or do I have any means to reduce the latency caused by this function?

Best regards,
Jiexun Wang
