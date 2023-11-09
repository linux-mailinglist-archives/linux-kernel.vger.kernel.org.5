Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B47E7257
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjKITaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKITaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:30:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D623ABC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:30:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165E7C433C9;
        Thu,  9 Nov 2023 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699558228;
        bh=KqVoMWqDd+E2EyR7rl60ZOeBi5OJfRT+yFEADYzm+Io=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tVF2iN1FInSUL+GFPK8pXeonyFJ2l4wEFqyYJj40cNm+DLeZTF5RInzK6QM5xQLHC
         FGMwZgQ8H6wKKQKYmC4RNErwZtzeSnGE7ySZV85tef3vqJdBJWy+eZWfn0MzbyXtGd
         U/AFCSTaoesrK0U2VwfaZHCwaTQoPFiUzOTZWLERGMlkHZaEoswH3lWK5wOOf+JIsV
         cOBenYMpWLyZpCi9Qf6dakgysHtyAhtXMH+fit+veNmAaad12xzvPMAXsXswECkwSS
         UpqKO0eljvaLKZK6Vq6AldHFhSiZTcCtf5tiS6ZaH/C84Luw/O3DuxHRsh/HRLY3Jx
         FVmHBcWL60YHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0F80C43158;
        Thu,  9 Nov 2023 19:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers: perf: Check find_first_bit() return value
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169955822798.13763.2357053646375342945.git-patchwork-notify@kernel.org>
Date:   Thu, 09 Nov 2023 19:30:27 +0000
References: <20231109082128.40777-1-alexghiti@rivosinc.com>
In-Reply-To: <20231109082128.40777-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, atishp@atishpatra.org,
        anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  9 Nov 2023 09:21:28 +0100 you wrote:
> We must check the return value of find_first_bit() before using the
> return value as an index array since it happens to overflow the array
> and then panic:
> 
> [  107.318430] Kernel BUG [#1]
> [  107.319434] CPU: 3 PID: 1238 Comm: kill Tainted: G            E      6.6.0-rc6ubuntu-defconfig #2
> [  107.319465] Hardware name: riscv-virtio,qemu (DT)
> [  107.319551] epc : pmu_sbi_ovf_handler+0x3a4/0x3ae
> [  107.319840]  ra : pmu_sbi_ovf_handler+0x52/0x3ae
> [  107.319868] epc : ffffffff80a0a77c ra : ffffffff80a0a42a sp : ffffaf83fecda350
> [  107.319884]  gp : ffffffff823961a8 tp : ffffaf8083db1dc0 t0 : ffffaf83fecda480
> [  107.319899]  t1 : ffffffff80cafe62 t2 : 000000000000ff00 s0 : ffffaf83fecda520
> [  107.319921]  s1 : ffffaf83fecda380 a0 : 00000018fca29df0 a1 : ffffffffffffffff
> [  107.319936]  a2 : 0000000001073734 a3 : 0000000000000004 a4 : 0000000000000000
> [  107.319951]  a5 : 0000000000000040 a6 : 000000001d1c8774 a7 : 0000000000504d55
> [  107.319965]  s2 : ffffffff82451f10 s3 : ffffffff82724e70 s4 : 000000000000003f
> [  107.319980]  s5 : 0000000000000011 s6 : ffffaf8083db27c0 s7 : 0000000000000000
> [  107.319995]  s8 : 0000000000000001 s9 : 00007fffb45d6558 s10: 00007fffb45d81a0
> [  107.320009]  s11: ffffaf7ffff60000 t3 : 0000000000000004 t4 : 0000000000000000
> [  107.320023]  t5 : ffffaf7f80000000 t6 : ffffaf8000000000
> [  107.320037] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [  107.320081] [<ffffffff80a0a77c>] pmu_sbi_ovf_handler+0x3a4/0x3ae
> [  107.320112] [<ffffffff800b42d0>] handle_percpu_devid_irq+0x9e/0x1a0
> [  107.320131] [<ffffffff800ad92c>] generic_handle_domain_irq+0x28/0x36
> [  107.320148] [<ffffffff8065f9f8>] riscv_intc_irq+0x36/0x4e
> [  107.320166] [<ffffffff80caf4a0>] handle_riscv_irq+0x54/0x86
> [  107.320189] [<ffffffff80cb0036>] do_irq+0x64/0x96
> [  107.320271] Code: 85a6 855e b097 ff7f 80e7 9220 b709 9002 4501 bbd9 (9002) 6097
> [  107.320585] ---[ end trace 0000000000000000 ]---
> [  107.320704] Kernel panic - not syncing: Fatal exception in interrupt
> [  107.320775] SMP: stopping secondary CPUs
> [  107.321219] Kernel Offset: 0x0 from 0xffffffff80000000
> [  107.333051] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> [...]

Here is the summary with links:
  - drivers: perf: Check find_first_bit() return value
    https://git.kernel.org/riscv/c/c6e316ac0553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


