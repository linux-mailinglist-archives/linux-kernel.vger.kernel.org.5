Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A67E6B71
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjKINsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKINr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:47:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55058272C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:47:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62B4712FC;
        Thu,  9 Nov 2023 05:48:40 -0800 (PST)
Received: from [10.1.25.14] (e126510-lin.cambridge.arm.com [10.1.25.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F5F3F64C;
        Thu,  9 Nov 2023 05:47:54 -0800 (PST)
Message-ID: <d497b8c4-4e77-8d43-9d9f-1bb60785a4c0@arm.com>
Date:   Thu, 9 Nov 2023 13:47:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64/syscall: Remove duplicate declaration
Content-Language: en-GB
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20231109101958.225593-1-kevin.brodsky@arm.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <20231109101958.225593-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 11:19, Kevin Brodsky wrote:
> Commit 6ac19f96515e ("arm64: avoid prototype warnings for syscalls")
> added missing declarations to various syscall wrapper macros.
> It however proved a little too zealous in __SYSCALL_DEFINEx(), as
> a declaration for __arm64_sys##name was already present.
>
> This likely wouldn't have happened if declarations were consistently
> located, ideally just before the corresponding definition.
> Accordingly, this patch removes the old declaration line in
> __SYSCALL_DEFINEx(), and moves any other declaration that does not
> directly precede the corresponding definition.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/include/asm/syscall_wrapper.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/syscall_wrapper.h b/arch/arm64/include/asm/syscall_wrapper.h
> index 17f687510c48..0d1ec3280f89 100644
> --- a/arch/arm64/include/asm/syscall_wrapper.h
> +++ b/arch/arm64/include/asm/syscall_wrapper.h
> @@ -18,10 +18,10 @@
>  #ifdef CONFIG_COMPAT
>  
>  #define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
> -	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\
>  	ALLOW_ERROR_INJECTION(__arm64_compat_sys##name, ERRNO);				\
>  	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
>  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
> +	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs);		\

This doesn't make sense, the declaration needs to stay before the call
to ALLOW_ERROR_INJECTION() (I wasn't building with
CONFIG_FUNCTION_ERROR_INJECTION). Will post a v2 that simply removes the
added declaration in __SYSCALL_DEFINEx() without moving existing
declarations - sorry for the noise.

Kevin

>  	asmlinkage long __arm64_compat_sys##name(const struct pt_regs *regs)		\
>  	{										\
>  		return __se_compat_sys##name(SC_ARM64_REGS_TO_ARGS(x,__VA_ARGS__));	\
> @@ -50,7 +50,6 @@
>  #endif /* CONFIG_COMPAT */
>  
>  #define __SYSCALL_DEFINEx(x, name, ...)						\
> -	asmlinkage long __arm64_sys##name(const struct pt_regs *regs);		\
>  	ALLOW_ERROR_INJECTION(__arm64_sys##name, ERRNO);			\
>  	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
>  	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
> @@ -70,8 +69,8 @@
>  
>  #define SYSCALL_DEFINE0(sname)							\
>  	SYSCALL_METADATA(_##sname, 0);						\
> -	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
>  	ALLOW_ERROR_INJECTION(__arm64_sys_##sname, ERRNO);			\
> +	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused);	\
>  	asmlinkage long __arm64_sys_##sname(const struct pt_regs *__unused)
>  
>  #define COND_SYSCALL(name)							\

