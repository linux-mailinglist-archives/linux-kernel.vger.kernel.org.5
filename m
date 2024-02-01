Return-Path: <linux-kernel+bounces-47796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9493845302
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF07B27DED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446A15AAA0;
	Thu,  1 Feb 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vif9AKy4"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF51552E8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777011; cv=none; b=GNUSYu7S0iDTr8TPIf/RKczILLoHbZTvIB7jJ+sAgGXGe4/fLxW3GvzcPuAgeOBTeSZeSLPf6U8Yi/jtSvQDng8NbrQGaU5rlias4qL/jbYXRW1HoI5RKuDF71o9bBpo8wQKgpY8pFd5N9HhEzFHvVhUkC4NBQ0cqoqgDH7PIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777011; c=relaxed/simple;
	bh=caRiEumFCPq9dz62VPtTqvTRIzwur2FXfF55WfqVmFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bh7Z9wxWPywHyljFqBPDYlcAq8eOd4WXDDLabymPpBOZoPE8FgRdPWoV3GXIhalr4DsY7Y05OsBz6BuTbRFxqILU2A5c4jmLo7XgvP+/PKMLopzqNcFrxlS/bpMUN/ci61oJq3yfAnJmKMU6JqenkYQYUPPuXmE7LWDxan3JjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Vif9AKy4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bed9f5d35dso27028439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706777008; x=1707381808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao4eLU5tdpHEycqvq3kREW2Bipgab7R6ZJUONGAvtxk=;
        b=Vif9AKy4UkH1/bSHJ4UJbjlnGFLnTdshLMqiZsYoIPSzvfAPO+6V9MBBTSfEfh4YDz
         VdgqanOTyly5f/fvgXBY8TnfYb5TDouqcNqGK7/A9xMuOlnECGqIWQBtYEVzvx7VkaGH
         sMapPvyTHyPFDCPAniNayf9lzkoMnvENjZ0uDeAqK/Epr3d3WpzZnfABZECu1LHKPd8y
         tD3XEC1puUHS6lA1Q45i8ByiympXvX2nfj6E/0CnMT3OHdAseu15IZXFTeclz00U91nM
         2gRivec+kEteYztPO6vGEIQ+3c1PsEC8T+Rh9eCPW1/QlbPxdoVXvHwL2ciFrkAZMfnj
         3WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777008; x=1707381808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao4eLU5tdpHEycqvq3kREW2Bipgab7R6ZJUONGAvtxk=;
        b=RxslDwvjO8sFzn/fcVUeoBWiXcxPk+92+IxLzOWKfzKa3neIKsCUgqy5AHcmMTDYYv
         7O9c+Mv1bWzhA+MY9cTYifXIrBsKZKbcTfwKPXfp45HyxIZD7d7o6Bkd5au1tkHxYUNo
         A5lZMagpCmXmm7JqGSt+SnbaTq3R9Ji2gDVOPhY+CwIofP7qRDjMJOKf2ix/SBwWOiCu
         E/Audmj9k9uBN1Y8AvRFLzOiVcRIoYBaKJtNcRQIpNEKKOAMWARlQTOkf+Zx+hs3oAS3
         bfVcOdmP4UKjkdbefUzk4VOaiRY92k6zCH94LbQ8Ni8WZM3PhGfekeyatFByYUPqJgbb
         M8Tg==
X-Gm-Message-State: AOJu0YxPobcJ2o7CVGLuSPXpizYDwp1Iixm/PZ4r3h5Qy90TIo+CfZ8N
	eAHqQ96rAqYb3O1MKCJzEdTI0hxv6SkCfEOZcd/urdkVyJHMF/SRSH0BSsb6eCwsM8wcYuHuoU6
	a+oSFmpC7h5TZQnw7I/3uGGSTPjVKUeK0bIObDA==
X-Google-Smtp-Source: AGHT+IHBzPPfuPk7WAEZLvLmarQrhiLi8C68HmDuy98JSViVi9R3hkGEt5C9YikDQVvMEz5qfy2pE+Jb/kaAS9dUBag=
X-Received: by 2002:a05:6602:17c5:b0:7c0:31a7:a755 with SMTP id
 z5-20020a05660217c500b007c031a7a755mr526890iox.8.1706777008498; Thu, 01 Feb
 2024 00:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205085959.32177-1-zong.li@sifive.com> <139cdbd6-73d9-4452-94ce-825689b7c0c8@ghiti.fr>
In-Reply-To: <139cdbd6-73d9-4452-94ce-825689b7c0c8@ghiti.fr>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 1 Feb 2024 16:43:17 +0800
Message-ID: <CANXhq0oA7LsKev+5gZCtNzCJ64RVOyimM1yQnY0kqs22VE6S4A@mail.gmail.com>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:10=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
> On 05/12/2023 09:59, Zong Li wrote:
> > CALLER_ADDRx returns caller's address at specified level, they are used
> > for several tracers. These macros eventually use
> > __builtin_return_address(n) to get the caller's address if arch doesn't
> > define their own implementation.
> >
> > In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, we n=
eed
> > to walk the stack frame to get the caller's address at specified level.
>
>
> Is that a bug in gcc or something expected for riscv in general?
>

I think it isn't supported for riscv in general.

>
> >
> > data.level started from 'level + 3' due to the call flow of getting
> > caller's address in RISC-V implementation. If we don't have additional
> > three iteration, the level is corresponding to follows:
> >
> > callsite -> return_address -> arch_stack_walk -> walk_stackframe
> > |           |                 |                  |
> > level 3     level 2           level 1            level 0
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >   arch/riscv/include/asm/ftrace.h    |  5 ++++
> >   arch/riscv/kernel/Makefile         |  2 ++
> >   arch/riscv/kernel/return_address.c | 48 +++++++++++++++++++++++++++++=
+
> >   3 files changed, 55 insertions(+)
> >   create mode 100644 arch/riscv/kernel/return_address.c
> >
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/f=
trace.h
> > index 2b2f5df7ef2c..42777f91a9c5 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -25,6 +25,11 @@
> >
> >   #define ARCH_SUPPORTS_FTRACE_OPS 1
> >   #ifndef __ASSEMBLY__
> > +
> > +extern void *return_address(unsigned int level);
> > +
> > +#define ftrace_return_address(n) return_address(n)
> > +
> >   void MCOUNT_NAME(void);
> >   static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >   {
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index fee22a3d1b53..40d054939ae2 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
> >   CFLAGS_REMOVE_ftrace.o      =3D $(CC_FLAGS_FTRACE)
> >   CFLAGS_REMOVE_patch.o       =3D $(CC_FLAGS_FTRACE)
> >   CFLAGS_REMOVE_sbi.o =3D $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_return_address.o       =3D $(CC_FLAGS_FTRACE)
> >   endif
> >   CFLAGS_syscall_table.o      +=3D $(call cc-option,-Wno-override-init,=
)
> >   CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override-ini=
t,)
> > @@ -46,6 +47,7 @@ obj-y       +=3D irq.o
> >   obj-y       +=3D process.o
> >   obj-y       +=3D ptrace.o
> >   obj-y       +=3D reset.o
> > +obj-y        +=3D return_address.o
> >   obj-y       +=3D setup.o
> >   obj-y       +=3D signal.o
> >   obj-y       +=3D syscall_table.o
> > diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/ret=
urn_address.c
> > new file mode 100644
> > index 000000000000..c2008d4aa6e5
> > --- /dev/null
> > +++ b/arch/riscv/kernel/return_address.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * This code come from arch/arm64/kernel/return_address.c
> > + *
> > + * Copyright (C) 2023 SiFive.
> > + */
> > +
> > +#include <linux/export.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/stacktrace.h>
> > +
> > +struct return_address_data {
> > +     unsigned int level;
> > +     void *addr;
> > +};
> > +
> > +static bool save_return_addr(void *d, unsigned long pc)
> > +{
> > +     struct return_address_data *data =3D d;
> > +
> > +     if (!data->level) {
> > +             data->addr =3D (void *)pc;
> > +             return false;
> > +     }
> > +
> > +     --data->level;
> > +
> > +     return true;
> > +}
> > +NOKPROBE_SYMBOL(save_return_addr);
> > +
> > +void *return_address(unsigned int level)
>
>
> Maybe return_address() should be noinline to make sure it's not inlined
> as it would break the "+ 3"? Not sure it's necessary though.

Yes, thanks for pointing it out. We should ensure it's not inlined in
any case. I will send the next version.

>
>
> > +{
> > +     struct return_address_data data;
> > +
> > +     data.level =3D level + 3;
> > +     data.addr =3D NULL;
> > +
> > +     arch_stack_walk(save_return_addr, &data, current, NULL);
> > +
> > +     if (!data.level)
> > +             return data.addr;
> > +     else
> > +             return NULL;
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(return_address);
> > +NOKPROBE_SYMBOL(return_address);
>
>
> And I see that with this patch, ftrace_return_address() is now defined
> whether CONFIG_FRAME_POINTER is set or not, is that correct?

Yes, that is what I understand. In this patch, the
ftrace_return_address() is still defined to return_address() when
CONFIG_FRAME_POINTER isn't enabled, and return_address still works
because riscv port can walk stackframe without fp.

>
> This looks like a fix to me so that should go into -fixes with a Fixes
> tag (but we'll have to make sure that the "+ 3" is correct on all
> backports...):
>
> Fixes: 10626c32e382 ("riscv/ftrace: Add basic support")

The return_address() invokes arch_stack_walk(), which enabled by the
'5cb0080f1bfd ("riscv: Enable ARCH_STACKWALK")'

I guess that we are not able to apply it on all backports. Is this
right? "+3" is correct after enabling ARCH_STACKWALK.

>
> And you can finally add for your v2 (or not if you don't respin):
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the review, Alexandre. I will add it in v2:)

>
> Thanks and sorry for the delay!
>
> Alex
>

