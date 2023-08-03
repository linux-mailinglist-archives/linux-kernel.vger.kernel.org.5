Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2238E76EDA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjHCPKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbjHCPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D910D2;
        Thu,  3 Aug 2023 08:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE35A61DF4;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 226B5C433CA;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691075423;
        bh=tZJ7tXVDkdspZw9aq8GHx3NudtBiKp17JwhiNPFjWqY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=vE+IQSLw+4DWc8DAqB9eWzLVYCnRl49lI14R1eMMNF3ZE/PFk05i+2io8QpOkdVY3
         Sd7UkDfcVeLZ6v3ym2r86oqnUC+htOED3yhAZbFnqy1FQdFy+w7/+Yp1SgpkdDN9N0
         il9Eh2yPQgJKxWqdDwRHf7bY/rTI7CDRdco+bs4PNpCsfGB2rh6z0m9LV6Q1+v6vZt
         gSMK1uaWurqRh7TmcRplXhEQ20RLbch25mwLX7k/rIQKAQinRbZO5VNc1NNjyUedyI
         gsEWgl9YuZbrKJalAlXvO3qyKc7cCC4JrUPhye+URlYBsV4+TAagOiojQ8mCoWXyo6
         Gr5GbX7dvGo3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A960C595D1;
        Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542303.19238.12982353248491606719.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 15:10:23 +0000
References: <20230724100917.309061-1-suagrfillet@gmail.com>
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     linux-riscv@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        xianting.tian@linux.alibaba.com, anup@brainfault.org,
        robh@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
        conor.dooley@microchip.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Jul 2023 18:09:16 +0800 you wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
> from the physical start of the kernel to the actual start of the DRAM.
> 
> The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].
> 
> [...]

Here is the summary with links:
  - [RESEND,-fixes,1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
    https://git.kernel.org/riscv/c/fbe7d19d2b7f
  - [RESEND,-fixes,2/2] Documentation: kdump: Add va_kernel_pa_offset for RISCV64
    https://git.kernel.org/riscv/c/640c503d7dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


