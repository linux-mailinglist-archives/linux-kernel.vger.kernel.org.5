Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F977FA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353139AbjHQPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353157AbjHQPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5E2D74;
        Thu, 17 Aug 2023 08:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AD865940;
        Thu, 17 Aug 2023 15:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8BDBC43395;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285625;
        bh=qR6kigngMHcRwuRvA7J2U593va9JFSML77bkafy5IPQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jt0wKcZDmE5NOyOJT0HC5QwXnRO0aqMe3XhQMCQivbQgcWq/a6TnuQxhPUG2V3y6y
         QUo9JC9e8TYNLH2KxgAns8ojt3vdIufLXNoepPipIq8tZ5roJbQe1QxfkJg+QPUjXy
         hAOOgK5QuQ0Dhy1hFUMk+dBflRBK4g6BhZmebBtoWkPqQO/qY/T39b7Y1E8/LKxvFR
         aieKn/nNBaiwFIFgbrjEOi9iA8VFWA+pLJLiQsZBxmCUYA9l0sR/385r5z3GF3msiM
         tzCN/TuI8z/d6FqLYeQRftBm8iiJCOSBjfoTsU6iZblqCyrp7Otp3IKi2Qwc3GYCdE
         fRnK71TCk9wsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D06B7E26D3B;
        Thu, 17 Aug 2023 15:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169228562484.20811.14246462375671910714.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 15:20:24 +0000
References: <20230809165648.21071-1-xingmingzheng@iscas.ac.cn>
In-Reply-To: <20230809165648.21071-1-xingmingzheng@iscas.ac.cn>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bmeng@tinylab.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        stable@vger.kernel.org, conor.dooley@microchip.com
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

On Thu, 10 Aug 2023 00:56:48 +0800 you wrote:
> Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the newer
> 20191213 version which moves some instructions from the I extension to the
> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
> that version, we should explicitly specifying Zicsr and Zifencei via -march
> to cope with the new changes. but this only occurs when binutils >= 2.36
> and GCC >= 11.1.0. It's a different story when binutils < 2.36.
> 
> [...]

Here is the summary with links:
  - [v5] riscv: Handle zicsr/zifencei issue between gcc and binutils
    https://git.kernel.org/riscv/c/ca09f772ccca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


