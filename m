Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF17762B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHIOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjHIOkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F9E2107
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D626C63C61
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41280C433CC;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691592021;
        bh=rS1VmWngCPrpnlr93e2OHzvT/pKtGX1S57FyWy3qM2M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dBZYMRaMdKwDDcfKgHAVBp4WysQCa1YCVUBQwYN2ahYEnn1HcKCYXhJMi4hGlDTmX
         OZvjLyrUQqj73yo7fenV96uNsHyUKdZaRc1QEP6/cnnR78XOr2+ESS4IYAvGf0sg0G
         puTi5bM7Qb15nmV13MrNo4XXBsFA2jkHJEtbfXiOv7/5N/TwWLbExGPSwDMnff/UXI
         3M1CaUDGkM1yFcK5xQVlHe1QnXKHVhu8m17pUAnGSWhH1OsfM7YVywSO0Se2J40534
         jqs6Elf111OeGVNFbB8Tbqa9cGXo6UlbKj302wIp5HFGrA5Gokh5ows60BN90g6HGJ
         F4ay19kBN6J2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25A66E330A1;
        Wed,  9 Aug 2023 14:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: fix 2 instances of
 -Wmissing-variable-declarations
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169159202114.17533.15862327157630311285.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 14:40:21 +0000
References: <20230808-riscv_static-v2-1-2a1e2d2c7a4f@google.com>
In-Reply-To: <20230808-riscv_static-v2-1-2a1e2d2c7a4f@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, lkp@intel.com
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

On Tue, 08 Aug 2023 09:35:00 -0700 you wrote:
> I'm looking to enable -Wmissing-variable-declarations behind W=1. 0day
> bot spotted the following instance in ARCH=riscv builds:
> 
>   arch/riscv/mm/init.c:276:7: warning: no previous extern declaration
>   for non-static variable 'trampoline_pg_dir'
>   [-Wmissing-variable-declarations]
>   276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>       |       ^
>   arch/riscv/mm/init.c:276:1: note: declare 'static' if the variable is
>   not intended to be used outside of this translation unit
>   276 | pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>       | ^
>   arch/riscv/mm/init.c:279:7: warning: no previous extern declaration
>   for non-static variable 'early_pg_dir'
>   [-Wmissing-variable-declarations]
>   279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>       |       ^
>   arch/riscv/mm/init.c:279:1: note: declare 'static' if the variable is
>   not intended to be used outside of this translation unit
>   279 | pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>       | ^
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: fix 2 instances of -Wmissing-variable-declarations
    https://git.kernel.org/riscv/c/d2402048bc8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


