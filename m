Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C637C77FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347408AbjJLUkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjJLUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:40:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946C6D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:40:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30413C433CA;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697143225;
        bh=RJYjlHao0cVFQqQVSXf8FCtMqfCMn4CflRRAPd8qbNw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p5fq5XIR7FD+n0KR4vUu+03TZqi9TccSEbUY4oC80uaAmHoBiLDiJxjwXYXi9V3xn
         A3J7TLVkV/eUkkqk9mYdRAewxcv8zCz4IkGYrW4wvFAUj9v6c7YA7Pvyqgi0pec0Jd
         1lW19WOUkrV2ndC1OrWS0DGHkDyrPMWqVjpJbkfRz/4ZDM2hFooxLbtSw0/kY6kWpp
         MyD5sOFYWoSJGlBG15th4Nzbs8cLxTK+leP9WxNU/bPTdDKT+lHMQVM+2tBiLkJfvV
         nXPIkhOUGVqo5/REKH/4FQjcEgZ1It3v78Azbzl1wCpmGQ9nkrIoPp7AvvculG5ASt
         ETVxO/OT1GvGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13BDDC595C4;
        Thu, 12 Oct 2023 20:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next v2] riscv: kdump: fix crashkernel reserving problem on
 RISC-V
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169714322507.23371.6628705957236576989.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 20:40:25 +0000
References: <20230925024333.730964-1-chenjiahao16@huawei.com>
In-Reply-To: <20230925024333.730964-1-chenjiahao16@huawei.com>
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-riscv@lists.infradead.org, bhe@redhat.com,
        thunder.leizhen@huawei.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, alexghiti@rivosinc.com,
        ajones@ventanamicro.com, jszhang@kernel.org,
        sunilvl@ventanamicro.com, robh@kernel.org, bjorn@rivosinc.com,
        zephray@outlook.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Mon, 25 Sep 2023 10:43:33 +0800 you wrote:
> When testing on risc-v QEMU environment with "crashkernel="
> parameter enabled, a problem occurred with the following
> message:
> 
> [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000 (128 MB)
> [    0.000000] crashkernel reserved: 0x0000000177e00000 - 0x0000000277e00000 (4096 MB)
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:779 __insert_resource+0x8e/0xd0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc2-next-20230920 #1
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] epc : __insert_resource+0x8e/0xd0
> [    0.000000]  ra : insert_resource+0x28/0x4e
> [    0.000000] epc : ffffffff80017344 ra : ffffffff8001742e sp : ffffffff81203db0
> [    0.000000]  gp : ffffffff812ece98 tp : ffffffff8120dac0 t0 : ff600001f7ff2b00
> [    0.000000]  t1 : 0000000000000000 t2 : 3428203030303030 s0 : ffffffff81203dc0
> [    0.000000]  s1 : ffffffff81211e18 a0 : ffffffff81211e18 a1 : ffffffff81289380
> [    0.000000]  a2 : 0000000277dfffff a3 : 0000000177e00000 a4 : 0000000177e00000
> [    0.000000]  a5 : ffffffff81289380 a6 : 0000000277dfffff a7 : 0000000000000078
> [    0.000000]  s2 : ffffffff81289380 s3 : ffffffff80a0bac8 s4 : ff600001f7ff2880
> [    0.000000]  s5 : 0000000000000280 s6 : 8000000a00006800 s7 : 000000000000007f
> [    0.000000]  s8 : 0000000080017038 s9 : 0000000080038ea0 s10: 0000000000000000
> [    0.000000]  s11: 0000000000000000 t3 : ffffffff80a0bc00 t4 : ffffffff80a0bc00
> [    0.000000]  t5 : ffffffff80a0bbd0 t6 : ffffffff80a0bc00
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [    0.000000] [<ffffffff80017344>] __insert_resource+0x8e/0xd0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Failed to add a Crash kernel resource at 177e00000
> 
> [...]

Here is the summary with links:
  - [-next,v2] riscv: kdump: fix crashkernel reserving problem on RISC-V
    https://git.kernel.org/riscv/c/1d6cd2146c2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


