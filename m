Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D307D2818
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJWBmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjJWBl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:41:59 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C1F7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 18:41:56 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39N1fqHo020257;
        Mon, 23 Oct 2023 09:41:52 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 23 Oct 2023 09:41:52 +0800
Date:   Mon, 23 Oct 2023 09:41:49 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Subject: Re: [PATCH -fixes] drivers: perf: Do not broadcast to other cpus
 when starting a counter
Message-ID: <ZTXPXXjULgqikXjF@APC323>
References: <20231022144220.109469-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231022144220.109469-1-alexghiti@rivosinc.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39N1fqHo020257
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Sun, Oct 22, 2023 at 04:42:20PM +0200, Alexandre Ghiti wrote:
> This command:
> 
> $ perf record -e cycles:k -e instructions:k -c 10000 -m 64M dd if=/dev/zero of=/dev/null count=1000
> 
> gives rise to this kernel warning:
> 
> [  444.364395] WARNING: CPU: 0 PID: 104 at kernel/smp.c:775 smp_call_function_many_cond+0x42c/0x436
> [  444.364515] Modules linked in:
> [  444.364657] CPU: 0 PID: 104 Comm: perf-exec Not tainted 6.6.0-rc6-00051-g391df82e8ec3-dirty #73
> [  444.364771] Hardware name: riscv-virtio,qemu (DT)
> [  444.364868] epc : smp_call_function_many_cond+0x42c/0x436
> [  444.364917]  ra : on_each_cpu_cond_mask+0x20/0x32
> [  444.364948] epc : ffffffff8009f9e0 ra : ffffffff8009fa5a sp : ff20000000003800
> [  444.364966]  gp : ffffffff81500aa0 tp : ff60000002b83000 t0 : ff200000000038c0
> [  444.364982]  t1 : ffffffff815021f0 t2 : 000000000000001f s0 : ff200000000038b0
> [  444.364998]  s1 : ff60000002c54d98 a0 : ff60000002a73940 a1 : 0000000000000000
> [  444.365013]  a2 : 0000000000000000 a3 : 0000000000000003 a4 : 0000000000000100
> [  444.365029]  a5 : 0000000000010100 a6 : 0000000000f00000 a7 : 0000000000000000
> [  444.365044]  s2 : 0000000000000000 s3 : ffffffffffffffff s4 : ff60000002c54d98
> [  444.365060]  s5 : ffffffff81539610 s6 : ffffffff80c20c48 s7 : 0000000000000000
> [  444.365075]  s8 : 0000000000000000 s9 : 0000000000000001 s10: 0000000000000001
> [  444.365090]  s11: ffffffff80099394 t3 : 0000000000000003 t4 : 00000000eac0c6e6
> [  444.365104]  t5 : 0000000400000000 t6 : ff60000002e010d0
> [  444.365120] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [  444.365226] [<ffffffff8009f9e0>] smp_call_function_many_cond+0x42c/0x436
> [  444.365295] [<ffffffff8009fa5a>] on_each_cpu_cond_mask+0x20/0x32
> [  444.365311] [<ffffffff806e90dc>] pmu_sbi_ctr_start+0x7a/0xaa
> [  444.365327] [<ffffffff806e880c>] riscv_pmu_start+0x48/0x66
> [  444.365339] [<ffffffff8012111a>] perf_adjust_freq_unthr_context+0x196/0x1ac
> [  444.365356] [<ffffffff801237aa>] perf_event_task_tick+0x78/0x8c
> [  444.365368] [<ffffffff8003faf4>] scheduler_tick+0xe6/0x25e
> [  444.365383] [<ffffffff8008a042>] update_process_times+0x80/0x96
> [  444.365398] [<ffffffff800991ec>] tick_sched_handle+0x26/0x52
> [  444.365410] [<ffffffff800993e4>] tick_sched_timer+0x50/0x98
> [  444.365422] [<ffffffff8008a6aa>] __hrtimer_run_queues+0x126/0x18a
> [  444.365433] [<ffffffff8008b350>] hrtimer_interrupt+0xce/0x1da
> [  444.365444] [<ffffffff806cdc60>] riscv_timer_interrupt+0x30/0x3a
> [  444.365457] [<ffffffff8006afa6>] handle_percpu_devid_irq+0x80/0x114
> [  444.365470] [<ffffffff80065b82>] generic_handle_domain_irq+0x1c/0x2a
> [  444.365483] [<ffffffff8045faec>] riscv_intc_irq+0x2e/0x46
> [  444.365497] [<ffffffff808a9c62>] handle_riscv_irq+0x4a/0x74
> [  444.365521] [<ffffffff808aa760>] do_irq+0x7c/0x7e
> [  444.365796] ---[ end trace 0000000000000000 ]---
> 
> That's because the fix in commit 3fec323339a4 ("drivers: perf: Fix panic
> in riscv SBI mmap support") was wrong since there is no need to broadcast
> to other cpus when starting a counter, that's only needed in mmap when
> the counters could have already been started on other cpus, so simply
> remove this broadcast.
> 
> Fixes: 3fec323339a4 ("drivers: perf: Fix panic in riscv SBI mmap support")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Clément Léger <cleger@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 96c7f670c8f0..439da49dd0a9 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -543,8 +543,7 @@ static void pmu_sbi_ctr_start(struct perf_event *event, u64 ival)
>  
>  	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>  	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -		on_each_cpu_mask(mm_cpumask(event->owner->mm),
> -				 pmu_sbi_set_scounteren, (void *)event, 1);
> +		pmu_sbi_set_scounteren((void *)event);
>  }
>  
>  static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
> @@ -554,8 +553,7 @@ static void pmu_sbi_ctr_stop(struct perf_event *event, unsigned long flag)
>  
>  	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>  	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
> -		on_each_cpu_mask(mm_cpumask(event->owner->mm),
> -				 pmu_sbi_reset_scounteren, (void *)event, 1);
> +		pmu_sbi_set_scounteren((void *)event);

reset here? so the CY/IR bits can be cleared.

Thanks for the patch, fixed the warning seen on my boards.

Tested-by: Yu Chien Peter Lin <peterlin@andestech.com>

Best regards,
Peter Lin

>  
>  	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, hwc->idx, 1, flag, 0, 0, 0);
>  	if (ret.error && (ret.error != SBI_ERR_ALREADY_STOPPED) &&
