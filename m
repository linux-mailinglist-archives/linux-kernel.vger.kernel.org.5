Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B97E7256
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKITac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKITaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:30:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF63C14
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:30:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102BFC433C8;
        Thu,  9 Nov 2023 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699558228;
        bh=phixewqizGe+SBDzZcFJRD1v4skCnp3xVsHaSY0lgYw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=huSZHBmEaowJqPBfCijYdwP27Yg2gGZpPEiF0Vd53KsJbxGmK3xVIMbbtzBUiWXAU
         j/PviM/cw/JkiczVOVrUspBfiAiDse0qJWJmJ/VyPG3uwLIg09qonzwNkEfeKHH3Tk
         iJLgS1eHUEecuH2IRfMqQyueXTo0uDBUTQpyZqR0PkcH1KYI0GD+q1+96C2tY44PDX
         fMlifMaNls50CWBjXKUpwtUPWNlRaxTPj+OKBC7joc92E0uV+Ungx4wOXeZF+tN9br
         68Sj4zCpY7DAPcZkXlpi3uAyK4xXfuXSuiciVWl/HmuCFGJTXjIStkSi3w2cyiMrmR
         +nFYB5UMJ/ZNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E865FC3274C;
        Thu,  9 Nov 2023 19:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] drivers: perf: Do not broadcast to other cpus when
 starting a counter
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169955822794.13763.6368866008257927086.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Nov 2023 19:30:27 +0000
References: <20231026084010.11888-1-alexghiti@rivosinc.com>
In-Reply-To: <20231026084010.11888-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, atishp@atishpatra.org,
        anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cleger@rivosinc.com, peterlin@andestech.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 26 Oct 2023 10:40:10 +0200 you wrote:
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
> [...]

Here is the summary with links:
  - [-fixes,v2] drivers: perf: Do not broadcast to other cpus when starting a counter
    https://git.kernel.org/riscv/c/61e3d993c8bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


