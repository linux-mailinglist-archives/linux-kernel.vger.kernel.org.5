Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1537DDCF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjKAHF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjKAHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:05:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA619E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA7CC433C7;
        Wed,  1 Nov 2023 07:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698822305;
        bh=j9ykpsBlFRKe7DDjM3F4E4o0mNxil1zOXhS2aCHKGpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YjjLTuv/okiR0psaAHUqPoY3KJE0Gv/tCKYbFkgJeyb0/c+tpUKx31DNUnNenjA7w
         6s/plmHRr6YIa6EK1qtNHfQ/Zzk/6z628H5q4SCaF1nNjBfaEekACsBKoWbTGxnkj6
         s7fbZnl47gRFwAAgaXkIFGcOvegKVhGlPlQSiEelu40AL15FkE8pp9BWxhgb0/cw6d
         M7fnP1rqhZyQE7NQPx20WxeguOaxMr7WqpRAEWRkAlqXL8FCgjYQI4wsNn/H2Dj5kl
         Ov7/yxXdxQFd21AEobNmSkerlr9FQKjoq6Liz3/kzE1ljkqF9R4cXxwIjJVgoKEnsb
         SJAKIeqWUglow==
Message-ID: <5d80e129-b3b3-4bad-b432-897728113bb7@kernel.org>
Date:   Wed, 1 Nov 2023 16:05:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Support RANDOMIZE_KSTACK_OFFSET
To:     Song Shuai <songshuaishuai@tinylab.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, keescook@chromium.org,
        guoren@kernel.org, bjorn@rivosinc.com, jszhang@kernel.org,
        conor.dooley@microchip.com, andy.chiu@sifive.com,
        samitolvanen@google.com, coelacanthushex@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231101064423.1906122-1-songshuaishuai@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 15:44, Song Shuai wrote:
> Inspired from arm64's implement -- commit 70918779aec9
> ("arm64: entry: Enable random_kstack_offset support")
> 
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).
> 
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_trap_ecall_u() at the function level.
> 
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
> Testing with randomize_kstack_offset=y cmdline, lkdtm/stack-entropy.sh
> showed appropriate stack offset instead of zero.
> ---
>  arch/riscv/Kconfig        |  1 +
>  arch/riscv/kernel/traps.c | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..0e843de33f0c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -100,6 +100,7 @@ config RISCV
>  	select HAVE_ARCH_KGDB_QXFER_PKT
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> +	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>  	select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 19807c4d3805..3f869b2d47c3 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -6,6 +6,7 @@
>  #include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/randomize_kstack.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/signal.h>
> @@ -296,9 +297,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  	}
>  }
>  
> -asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
> +asmlinkage __visible __trap_section  __no_stack_protector
> +void do_trap_ecall_u(struct pt_regs *regs)
>  {
>  	if (user_mode(regs)) {
> +

White line change.

>  		long syscall = regs->a7;
>  
>  		regs->epc += 4;
> @@ -308,10 +311,23 @@ asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs *regs)
>  
>  		syscall = syscall_enter_from_user_mode(regs, syscall);
>  
> +		add_random_kstack_offset();
> +
>  		if (syscall >= 0 && syscall < NR_syscalls)
>  			syscall_handler(regs, syscall);
>  		else if (syscall != -1)
>  			regs->a0 = -ENOSYS;
> +		/*
> +		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> +		 * so the maximum stack offset is 1k bytes (10 bits).
> +		 *
> +		 * The actual entropy will be further reduced by the compiler when
> +		 * applying stack alignment constraints: 16-byte (i.e. 4-bit) aligned
> +		 * for RV32I or RV64I.
> +		 *
> +		 * The resulting 6 bits of entropy is seen in SP[9:4].
> +		 */
> +		choose_random_kstack_offset(get_random_u16());
>  
>  		syscall_exit_to_user_mode(regs);
>  	} else {

-- 
Damien Le Moal
Western Digital Research

