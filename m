Return-Path: <linux-kernel+bounces-119697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B9188CC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B449FB28028
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141912DD9C;
	Tue, 26 Mar 2024 18:43:45 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D44127B6A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478625; cv=none; b=gTMei/gLUzPOkQKEauo4XYfogJqBaSoPOCvVtgI5XJAEamV9bg92BAiMRnk/74mw9QUk1TIUQv6q/M2L/XK6ML3H1aakv0HwVHvvKcX57It5wRKrO8JGDYzpKrh9gRoCyDcwrMlpuGRvAIfFyUdNdEuzq8l06eWyCibBzuhp9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478625; c=relaxed/simple;
	bh=gnJurj1Z7nnKBazwQ+DpwwKiZ9LcAzlxixav3jk144Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFBj/ZH6ph/l+BGAfvPVLZ9PKlxtwlSH6vzBGVx5d2LxK51VCyqgQiPNE9/SfKu1s3kImID6Kmck4GS8Cynd8tNRSwoIDQLMnp2FzTK90EUCwVZyxAH37Wwk5X407DfWzerr3fY+uLLgCAw+SK6uqJM4WNV6BNgdw9xk6qS+29Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8811B1C0006;
	Tue, 26 Mar 2024 18:43:36 +0000 (UTC)
Message-ID: <a083fe56-19ba-4c12-8364-944d8bbcc043@ghiti.fr>
Date: Tue, 26 Mar 2024 19:43:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Mark __se_sys_* functions __used
Content-Language: en-US
To: Sami Tolvanen <samitolvanen@google.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Kees Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240326153712.1839482-2-samitolvanen@google.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240326153712.1839482-2-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Sami,

On 26/03/2024 16:37, Sami Tolvanen wrote:
> Clang doesn't think ___se_sys_* functions used even though they are
> aliased to __se_sys_*, resulting in -Wunused-function warnings when
> building rv32. For example:
>
>     mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrelease' [-Wunused-function]
>      1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>           | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE2'
>       221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
>           |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEFINEx'
>       231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from macro '__SYSCALL_DEFINEx'
>        81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)                         \
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from macro '__SYSCALL_SE_DEFINEx'
>        40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
>           |                     ^~~~~~~~~~~~~~~~~~~~
>     <scratch space>:30:1: note: expanded from here
>        30 | ___se_sys_process_mrelease
>           | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     1 warning generated.
>
> Mark the functions __used explicitly to fix the Clang warnings.
>
> Fixes: a9ad73295cc1 ("riscv: Fix syscall wrapper for >word-size arguments")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Do you have the link of the report? So we can add a Closes tag.


> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>   arch/riscv/include/asm/syscall_wrapper.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
> index 980094c2e976..ac80216549ff 100644
> --- a/arch/riscv/include/asm/syscall_wrapper.h
> +++ b/arch/riscv/include/asm/syscall_wrapper.h
> @@ -36,7 +36,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
>   					ulong)						\
>   			__attribute__((alias(__stringify(___se_##prefix##name))));	\
>   	__diag_pop();									\
> -	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
> +	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
> +			__used;								\
>   	static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
>   
>   #define SC_RISCV_REGS_TO_ARGS(x, ...) \
>
> base-commit: 4cece764965020c22cff7665b18a012006359095


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

As the commit fixed here was merged in 6.9, this should go into fixes.

Thanks,

Alex


