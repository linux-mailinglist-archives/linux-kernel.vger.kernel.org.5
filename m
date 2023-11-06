Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129977E27F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjKFPAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKFPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CAEEA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BAE8C433CD;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=peZY9vSBSFS+886zmL37gCP8MxGJChhA03rKB6LCEB4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qBhTiM8+9gJCXB0dEvVGmPLGjM8eZGhjtTsrGKdQOLMPdO4kvQRcxYBKNVEKNwOne
         80xrFEOTgIxf5qQjVM/ttXtcCCdtGpMdxteh7NORBuz1ETDWG8rMXShZuk2GDSWYef
         l9f2wonlOp3Jpbn3l2AR9H8m0rSq0kcMHMUiEVak8OLalsvP/u3kSmWFuNm3uXzhgz
         JD2AT8jKqz0UyyWqqPTEv85teuL1c6kMM4bXuKm+VYvOiLND4682jbWh1ec5bqSF3x
         Dmqqy4fY1SzC8HEqLG7Co/uUBqFY1o6361m+l9CqUTAJop3gtXHk/iUkPu9ftnnbO3
         32rOl0iX95+fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 220C2E00099;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] riscv: add userland instruction dump to RISC-V splats
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282913.16503.13862568711524021522.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230912021349.28302-1-cuiyunhui@bytedance.com>
In-Reply-To: <20230912021349.28302-1-cuiyunhui@bytedance.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        bjorn@rivosinc.com, conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Sep 2023 10:13:49 +0800 you wrote:
> Add userland instruction dump and rename dump_kernel_instr()
> to dump_instr().
> 
> An example:
> [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> [    0.823817] Run /init as init process
> [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be18 in bb[10000+5fb000]
> [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gbd644290aa72-dirty #187
> [    0.841373] Hardware name:  , BIOS
> [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 0000003fffcafda0
> [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 0000000000000000
> [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 0000000000000000
> [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 0000003fffcafe18
> [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
> [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
> [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
> [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 0000000000000000
> [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause: 0000000000000002
> [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 (8053) f002
> [    0.851016] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
> 
> [...]

Here is the summary with links:
  - [v6] riscv: add userland instruction dump to RISC-V splats
    https://git.kernel.org/riscv/c/b8a03a634129

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


