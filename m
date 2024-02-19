Return-Path: <linux-kernel+bounces-71489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5879385A61A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149DF2828A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A2C381C2;
	Mon, 19 Feb 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JzoW8wOL"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775A381C4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353412; cv=none; b=ZHpajGpCcnMCwenISePqPsp3Is4s/PN5gwG2MMRfvx8wuwFfew16v9YHwq1rKLRQtirccJyCpAI0aa8wfrPqMVVvTa3JgyrtV3WQdA2YwaG/tNQ1nhH5oZ2uNJz+OE/YigZrw1VJbQC3eS8ZowQKRyoqMma3B70Q4+a4OaS60dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353412; c=relaxed/simple;
	bh=k1wy1CnwpMGMs6jkrdQ6T1Tsue1hgcl4/4ZtfZnVmJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qBTAVG+01a1+yph9aYmandK8R4BXvMGNiavRUdlssjnH3FNTrmmrw3hZ6PN04Nh2+ZUp3oNWhfRif1m6RDvu1Aad51bZSZH85vVttVGqcOWaNRNZt/ncIIT/DJhH9pRNCnG3h5CHUctl+liyHpS/JBj1DXY6CZ4VgU0wQJ9Dg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JzoW8wOL; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so170627039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708353410; x=1708958210; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e/j4wH/8q2m/93ox5vboDjUwAf9Ak3MIjkr/fbj+5c=;
        b=JzoW8wOL4jUpfTbrKwO9xy8oF9Vn70x9g4HXAW5gO9c1dfpZXD3aXy9gw/HJVChJlE
         HhMw0/dskigiqwMXS+y+S085HTiCMeMKRv6DthYWeDrf73f5/UcV6ML4xi+0pawyyJaJ
         mA56FH18GDfRH7XNFQbvHXseGyTpSAGfqHKvFn2n74G8hhPVAUuogv3wVlblcM/sDya9
         QvE/z9F/IAPXGOrxZzy3l5jz8tyoBhCc2EJgLqeEFdslxn3om/PYdVtR8sQAxY0lHQjQ
         S+BSJrZzEo02UweZ8ck107my9CNy9heb6+8zxC5ND+bgJ/qFvg23xqtUuYPyHSl2fsTF
         WUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353410; x=1708958210;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e/j4wH/8q2m/93ox5vboDjUwAf9Ak3MIjkr/fbj+5c=;
        b=Ei72GtZWzDuwHrQ9Zo00PerqsUtjxVoHNJo+m0SwZd6QH1hXHs7aAUZwd0y0nw8k0f
         u4ADM6h7O5L5x92snFj8mcSXfGGVGKBZULrtZqO8CRsB4Z26pdGRH75kNq1RuilmQUmS
         qwBsTzSio7Dvk9kigRYvpl+I/nnP5YZlWMUSkHx9mtwTKPQOwb4fYIHQxBk0fGqfVmua
         zc+0t5R7GNwXb25KzYokQR2QXlq0sNWz0zcrkknccJUhtqaYAYvl7p/OF52z2FxqyKlk
         FinONhX+7hgBxxtBKKGG/28qDZxynifXXwzxKrMmFG02/yTYsi8gQSm33vdVkC4kVTCV
         eiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZI4WlY/F4lCJKkGCDUulyxszyTP4bkTb64jGRcZWKGluDNkGQmdibCl24r2/u0p02cnss5zrTo8Tjg/X0FqxD74vLjNlHfYxmECXl
X-Gm-Message-State: AOJu0YwRqzrIa6KwFn6LjbcRSnLjMuRrT3WCLB+MZQK1bwLh7rJuuiVH
	m70mRbrP09Y56G3CyajpUa9Rqfe/olfBBfWIzvUGSaxpxILd2QLm4M2+QNenrKm4c8t+y/gjglq
	bLi1MVIQoUH+v+HsyC+dMKWaHSEVsFluK4OQ6fA38f3fQea5Y
X-Google-Smtp-Source: AGHT+IEKLm2RcJpX0Yzgc7TCjIYiyqGSZKCanrbTb1Kvtv83pUTLiLSVsrtf2qLypNmQ5Lqg6cFt5u1FOv6dN3UXASQ=
X-Received: by 2002:a5d:9a18:0:b0:7c7:344d:21ad with SMTP id
 s24-20020a5d9a18000000b007c7344d21admr6801531iol.0.1708353410077; Mon, 19 Feb
 2024 06:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202015102.26251-1-zong.li@sifive.com>
In-Reply-To: <20240202015102.26251-1-zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 19 Feb 2024 22:36:39 +0800
Message-ID: <CANXhq0odPmhqsWA8hNqbH8+0ShJjUJktXNC1vxidpwjct+sdCg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add CALLER_ADDRx support
To: palmer@dabbelt.com, paul.walmsley@sifive.com, alex@ghiti.fr, 
	conor.dooley@microchip.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 9:51=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> CALLER_ADDRx returns caller's address at specified level, they are used
> for several tracers. These macros eventually use
> __builtin_return_address(n) to get the caller's address if arch doesn't
> define their own implementation.
>
> In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, we nee=
d
> to walk the stack frame to get the caller's address at specified level.
>
> data.level started from 'level + 3' due to the call flow of getting
> caller's address in RISC-V implementation. If we don't have additional
> three iteration, the level is corresponding to follows:
>
> callsite -> return_address -> arch_stack_walk -> walk_stackframe
> |           |                 |                  |
> level 3     level 2           level 1            level 0
>
> Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>
> Changed in v2:
> - Rebase to v6.8-rc2
> - Add noinline attribute for return_address()
> - Add a fixes tag
>
>  arch/riscv/include/asm/ftrace.h    |  5 ++++
>  arch/riscv/kernel/Makefile         |  2 ++
>  arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 arch/riscv/kernel/return_address.c
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 329172122952..15055f9df4da 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -25,6 +25,11 @@
>
>  #define ARCH_SUPPORTS_FTRACE_OPS 1
>  #ifndef __ASSEMBLY__
> +
> +extern void *return_address(unsigned int level);
> +
> +#define ftrace_return_address(n) return_address(n)
> +
>  void MCOUNT_NAME(void);
>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  {
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..604d6bf7e476 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_patch.o  =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_sbi.o    =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
>  endif
>  CFLAGS_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
>  CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
> @@ -46,6 +47,7 @@ obj-y +=3D irq.o
>  obj-y  +=3D process.o
>  obj-y  +=3D ptrace.o
>  obj-y  +=3D reset.o
> +obj-y  +=3D return_address.o
>  obj-y  +=3D setup.o
>  obj-y  +=3D signal.o
>  obj-y  +=3D syscall_table.o
> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/retur=
n_address.c
> new file mode 100644
> index 000000000000..c8115ec8fb30
> --- /dev/null
> +++ b/arch/riscv/kernel/return_address.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This code come from arch/arm64/kernel/return_address.c
> + *
> + * Copyright (C) 2023 SiFive.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/kprobes.h>
> +#include <linux/stacktrace.h>
> +
> +struct return_address_data {
> +       unsigned int level;
> +       void *addr;
> +};
> +
> +static bool save_return_addr(void *d, unsigned long pc)
> +{
> +       struct return_address_data *data =3D d;
> +
> +       if (!data->level) {
> +               data->addr =3D (void *)pc;
> +               return false;
> +       }
> +
> +       --data->level;
> +
> +       return true;
> +}
> +NOKPROBE_SYMBOL(save_return_addr);
> +
> +noinline void *return_address(unsigned int level)
> +{
> +       struct return_address_data data;
> +
> +       data.level =3D level + 3;
> +       data.addr =3D NULL;
> +
> +       arch_stack_walk(save_return_addr, &data, current, NULL);
> +
> +       if (!data.level)
> +               return data.addr;
> +       else
> +               return NULL;
> +
> +}
> +EXPORT_SYMBOL_GPL(return_address);
> +NOKPROBE_SYMBOL(return_address);
> --
> 2.17.1
>

Hi all,
Is there anything that can be improved in this patch? Thanks.

