Return-Path: <linux-kernel+bounces-73162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9C285BE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B45B1F20F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE636F515;
	Tue, 20 Feb 2024 14:13:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94C73197
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438411; cv=none; b=Om3vk95h4eMk1fyMKQmSVydrZUcA64Z1AHNpFmKEVe8Jpjw7lY9KqcVSKGSqLdASDDfQzIuW5F36efkL2Iopb8BtmCf6dUtC/I2rfmBLYGyRym4FK5/E+nNNoR0b/v0Od7A7tUtxBOFmGMS/CYS0451dNUsItPOkHGhu5RcSSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438411; c=relaxed/simple;
	bh=a/bcvUYS8RrdPrVW1BVMBabZsS22xG8p15sj6qVxNR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCx3mZo8JhfqpY2qrlTs14tIHGWlZ2Ui/ubvcmhaMaWg8sdv56/Fflf6Rn/83stjPPww0y05DkbR9/xsgCqr3tRanB2by/hXTxrW/uMwdXPYAO6/7kJNyvQKT/O1PZLpUwwgqzQ5j4onF+nfb8VKcfoMER5qoyPzm+3hwjBoSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E29C433F1;
	Tue, 20 Feb 2024 14:13:29 +0000 (UTC)
Message-ID: <6f3b246e-7417-4455-abe4-ca3b42fdda4c@linux-m68k.org>
Date: Wed, 21 Feb 2024 00:13:25 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, linux-m68k@lists.linux-m68k.org,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20240219160126.510498-1-thuth@redhat.com>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20240219160126.510498-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/2/24 02:01, Thomas Huth wrote:
> We should not use any CONFIG switches in uapi headers since these
> only work during kernel compilation; they are not defined for
> userspace. Fix it by moving the struct pt_regs to the kernel-internal
> header instead - struct pt_regs does not seem to be required for
> the userspace headers on m68k at all.
> 
> Suggested-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Move the struct instead of changing the #ifdef
> 
>   See previous discussion here:
>   https://lore.kernel.org/lkml/6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org/

I am fine with this. FWIW the following architectures do
not define pt_regs in their uapi/ptrace.h header either:
arc, arm64, loongarch, nios2, openrisc, riscv, s390, xtensa
Though quite a few of them have a user_pt_regs instead.

So for me:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Geert, Arnd, do you have any thoughts on this?

Regards
Greg



>   arch/m68k/include/asm/ptrace.h      | 29 +++++++++++++++++++++++++++++
>   arch/m68k/include/uapi/asm/ptrace.h | 28 ----------------------------
>   scripts/headers_install.sh          |  1 -
>   3 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
> index ea5a80ca1ab33..f200712946603 100644
> --- a/arch/m68k/include/asm/ptrace.h
> +++ b/arch/m68k/include/asm/ptrace.h
> @@ -6,6 +6,35 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +/*
> + * This struct defines the way the registers are stored on the
> + * stack during a system call.
> + */
> +struct pt_regs {
> +	long     d1;
> +	long     d2;
> +	long     d3;
> +	long     d4;
> +	long     d5;
> +	long     a0;
> +	long     a1;
> +	long     a2;
> +	long     d0;
> +	long     orig_d0;
> +	long     stkadj;
> +#ifdef CONFIG_COLDFIRE
> +	unsigned format :  4; /* frame format specifier */
> +	unsigned vector : 12; /* vector offset */
> +	unsigned short sr;
> +	unsigned long  pc;
> +#else
> +	unsigned short sr;
> +	unsigned long  pc;
> +	unsigned format :  4; /* frame format specifier */
> +	unsigned vector : 12; /* vector offset */
> +#endif
> +};
> +
>   #ifndef PS_S
>   #define PS_S  (0x2000)
>   #define PS_M  (0x1000)
> diff --git a/arch/m68k/include/uapi/asm/ptrace.h b/arch/m68k/include/uapi/asm/ptrace.h
> index 5b50ea592e002..a83bfe36dd10a 100644
> --- a/arch/m68k/include/uapi/asm/ptrace.h
> +++ b/arch/m68k/include/uapi/asm/ptrace.h
> @@ -24,34 +24,6 @@
>   
>   #ifndef __ASSEMBLY__
>   
> -/* this struct defines the way the registers are stored on the
> -   stack during a system call. */
> -
> -struct pt_regs {
> -  long     d1;
> -  long     d2;
> -  long     d3;
> -  long     d4;
> -  long     d5;
> -  long     a0;
> -  long     a1;
> -  long     a2;
> -  long     d0;
> -  long     orig_d0;
> -  long     stkadj;
> -#ifdef CONFIG_COLDFIRE
> -  unsigned format :  4; /* frame format specifier */
> -  unsigned vector : 12; /* vector offset */
> -  unsigned short sr;
> -  unsigned long  pc;
> -#else
> -  unsigned short sr;
> -  unsigned long  pc;
> -  unsigned format :  4; /* frame format specifier */
> -  unsigned vector : 12; /* vector offset */
> -#endif
> -};
> -
>   /*
>    * This is the extended stack used by signal handlers and the context
>    * switcher: it's pushed after the normal "struct pt_regs".
> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> index f7d9b114de8f7..6bbccb43f7e72 100755
> --- a/scripts/headers_install.sh
> +++ b/scripts/headers_install.sh
> @@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
>   arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
>   arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>   arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
> -arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>   arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
>   arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
>   arch/x86/include/uapi/asm/auxvec.h:CONFIG_IA32_EMULATION

