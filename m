Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151107C77FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442277AbjJLUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347400AbjJLUkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:40:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C7BD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:40:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50B19C433D9;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143225;
        bh=9KbQtT2qxorQkpHqYco5V41LAlQnh15tqWdih4fBMXA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GU3r0N2sfzWoDsLG+uAmN6p0ZSygLIlecg488h0SEJMLL90wTLvXXxr4SL+z7rdJm
         SMZi88JL+iohFArDgOQ3GjIF5yAtNdZRXy210WJ+jUcCWajE3iZhiqTvycuaFTeKu4
         TwPThhYfO4f/UKSjYY9LsH/aFW/ez1PYA+lkc0jkR4dEUUKhYKYo9kFiVqUl/yB8Xb
         LR2Ie3VZrXimbgg2AFmx+vclVtsQz8BLJLN4rfC/hFaBXI+rgb4nRrOzcBdSzHQo0J
         Y1SWxJsJQwgU2tLaT6kpWtfSVT2yEg7lDdp9OIrdB78VAtoxkwU5ycdEM+JoehAtah
         k+RHGua/B5z7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 332C4C595C3;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] drivers: perf: Fix panic in riscv SBI mmap support
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169714322520.23371.17105611293776534650.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 20:40:25 +0000
References: <20231006082010.11963-1-alexghiti@rivosinc.com>
In-Reply-To: <20231006082010.11963-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, atishp@atishpatra.org,
        anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  6 Oct 2023 10:20:10 +0200 you wrote:
> The following panic can happen when mmap is called before the pmu add
> callback which sets the hardware counter index: this happens for example
> with the following command `perf record --no-bpf-event -n kill`.
> 
> [   99.461486] CPU: 1 PID: 1259 Comm: perf Tainted: G            E      6.6.0-rc4ubuntu-defconfig #2
> [   99.461669] Hardware name: riscv-virtio,qemu (DT)
> [   99.461748] epc : pmu_sbi_set_scounteren+0x42/0x44
> [   99.462337]  ra : smp_call_function_many_cond+0x126/0x5b0
> [   99.462369] epc : ffffffff809f9d24 ra : ffffffff800f93e0 sp : ff60000082153aa0
> [   99.462407]  gp : ffffffff82395c98 tp : ff6000009a218040 t0 : ff6000009ab3a4f0
> [   99.462425]  t1 : 0000000000000004 t2 : 0000000000000100 s0 : ff60000082153ab0
> [   99.462459]  s1 : 0000000000000000 a0 : ff60000098869528 a1 : 0000000000000000
> [   99.462473]  a2 : 000000000000001f a3 : 0000000000f00000 a4 : fffffffffffffff8
> [   99.462488]  a5 : 00000000000000cc a6 : 0000000000000000 a7 : 0000000000735049
> [   99.462502]  s2 : 0000000000000001 s3 : ffffffff809f9ce2 s4 : ff60000098869528
> [   99.462516]  s5 : 0000000000000002 s6 : 0000000000000004 s7 : 0000000000000001
> [   99.462530]  s8 : ff600003fec98bc0 s9 : ffffffff826c5890 s10: ff600003fecfcde0
> [   99.462544]  s11: ff600003fec98bc0 t3 : ffffffff819e2558 t4 : ff1c000004623840
> [   99.462557]  t5 : 0000000000000901 t6 : ff6000008feeb890
> [   99.462570] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [   99.462658] [<ffffffff809f9d24>] pmu_sbi_set_scounteren+0x42/0x44
> [   99.462979] Code: 1060 4785 97bb 00d7 8fd9 9073 1067 6422 0141 8082 (9002) 0013
> [   99.463335] Kernel BUG [#2]
> 
> [...]

Here is the summary with links:
  - [-fixes] drivers: perf: Fix panic in riscv SBI mmap support
    https://git.kernel.org/riscv/c/3fec323339a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


