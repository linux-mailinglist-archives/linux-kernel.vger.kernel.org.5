Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895077FA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353133AbjHQPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353159AbjHQPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF4530E1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7231B65828
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9EF1C433CA;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285624;
        bh=6uxie/2bpp4zoawaR0g8UbTUtiVTJv3xr2GiZ7zQz/s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hmBcS6LeNjacJIsVqaLleKWisEByI1pdUH2z6/NqSbXfZGqafxjco3E/Sb+alRqWw
         op1a2pVfOzlAuJASuw45rb37vJdUXkeB2uHzMypV0MS5TX/+/ec1BZa0A+2fv3aOFY
         rPkzXu9x8HTcY8KetdZnZuJ6S0DaPZjudGkNSYxVHPfWmXsmvm0WUJV0tZfD2j788S
         ekwryIV/8fPQA9MLFA4Vcf536gzoTnB95LVQS2KNvvvnKuOgw6R98TWGhxoHDO9Awl
         0B1f1T8OFHuVWRJ4l5GZx/VnkabVSRvFSoOiaUSl7lDO9ExGAb5j/U2ULqOFO17AnE
         pH+CjVtOvk8DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1A7AC59A4C;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169228562472.20811.8481326212732586626.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 15:20:24 +0000
References: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
In-Reply-To: <20230801141607.435192-1-CoelacanthusHex@gmail.com>
To:     Celeste Liu <coelacanthushex@gmail.com>
Cc:     linux-riscv@lists.infradead.org, palmer@rivosinc.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com,
        linux-kernel@vger.kernel.org, schwab@suse.de,
        David.Laight@ACULAB.COM, CoelacanthusHex@gmail.com,
        felixonmars@archlinux.org, c141028@gmail.com,
        shiqi@isrc.iscas.ac.cn, emil.renner.berthing@canonical.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  1 Aug 2023 22:15:16 +0800 you wrote:
> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv:
> entry: Save a0 prior syscall_enter_from_user_mode()").
> 
> After analysing code, we think that regs->a0 = -ENOSYS should only be
> executed when syscall != -1. In __seccomp_filter, when seccomp rejected
> this syscall with specified errno, they will set a0 to return number as
> syscall ABI, and then return -1. This return number is finally pass as
> return number of syscall_enter_from_user_mode, and then is compared with
> NR_syscalls after converted to ulong (so it will be ULONG_MAX). The
> condition syscall < NR_syscalls will always be false, so regs->a0 = -ENOSYS
> is always executed. It covered a0 set by seccomp, so we always get
> ENOSYS when match seccomp RET_ERRNO rule.
> 
> [...]

Here is the summary with links:
  - [v5] riscv: entry: set a0 = -ENOSYS only when syscall != -1
    https://git.kernel.org/riscv/c/52449c17bdd1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


