Return-Path: <linux-kernel+bounces-21689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911078292CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7774289391
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510E63DF;
	Wed, 10 Jan 2024 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jAWRYXFH"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47C63A0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bee328027bso39998839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 19:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704857605; x=1705462405; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTJAAReDmCgeUKZ+956Wk5F3FplJWRu8shC9LpiGkOg=;
        b=jAWRYXFHAYfURSxZ91SQzcTSTZ+PVcnaxL3h55bLmGbMhqF19eqLrDiJNY64fv5XbH
         8xU8qECCr4wfFPq09ZlOCA7MJcIKtP/6+Ny4K/Vgpn/woALjM0CxtupioccUplkFWsBP
         3k9XygQGrGiy5tw0U0W2gcNTLA/I1GUnrMnmv9wNjrt0caS6C7tha1SKD0SrZ1ma69eE
         Cg7Rfsybxpp8U4R/NjgD/0UgdlvdUTBiK5NShkFWIUrra31kW3o2nR6DNYun/96Eoco5
         FlLY5TcHG2BOzW0RcPRw91i9FBAIBNDCEBohSHq1PM2IUi1kUo9XYXW3A14h0kKqA+RT
         7m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704857605; x=1705462405;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTJAAReDmCgeUKZ+956Wk5F3FplJWRu8shC9LpiGkOg=;
        b=f+FIWxUbGJ3MlDOxRNktJlw3KkNFYiYLq3zIxcRM5t+vmfz2hHFW/AaKYx66voiDkB
         fXQ8twWM3i5ynxKAJObjolFjWx8e2rycPOQlEi64o9xTASIJJSL96PsuCRUfYgKC5fe7
         tbLXOV/gWoMZP/Hk4m3fYyQKaCf3Pm/ZsuyElHJDkX87Gx2tj23cZeg4HJ+7WrxWMStu
         +VXZUaujERBbqpkJi7ZgzlbyrXwmyBMbho4f+ZlAm4zZ18/t232kKTn9gLMk76GBt5hR
         gTPqFu3T88HFGVaHhr2YvBzy/6xEPRyX11xNzIUP/4oKR1shnw+1MoGmZXScySOu4TnM
         uTmQ==
X-Gm-Message-State: AOJu0YylIeTTzbH9tQKLeuJm5S6oxZ/bIHP0flppORS+vzCyzKOHwDbw
	uCqlpbPoDshaFjpitGc/IfJ5FNEPQNx7mPBgPwS3kSl1tJ7prg==
X-Google-Smtp-Source: AGHT+IE+Q4lCxj83n8dzXZtXItlsHWcdYJuMOSNLQ15/SAx2kBai8iiFDS0hL5lBmDAKIsyRm/GyFDDg66IIJLFk4kI=
X-Received: by 2002:a6b:5f05:0:b0:7be:d961:6b0a with SMTP id
 t5-20020a6b5f05000000b007bed9616b0amr107497iob.18.1704857604934; Tue, 09 Jan
 2024 19:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205085959.32177-1-zong.li@sifive.com> <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
In-Reply-To: <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 10 Jan 2024 11:33:14 +0800
Message-ID: <CANXhq0qqv3MBEt8zsWBT+gkdyt1PD4ZjDSrznEotdFM7M7K+yQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
To: palmer@dabbelt.com, Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 2:34=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Tue, Dec 5, 2023 at 5:00=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote=
:
> >
> > CALLER_ADDRx returns caller's address at specified level, they are used
> > for several tracers. These macros eventually use
> > __builtin_return_address(n) to get the caller's address if arch doesn't
> > define their own implementation.
> >
> > In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, we n=
eed
> > to walk the stack frame to get the caller's address at specified level.
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
> >  arch/riscv/include/asm/ftrace.h    |  5 ++++
> >  arch/riscv/kernel/Makefile         |  2 ++
> >  arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++++
> >  3 files changed, 55 insertions(+)
> >  create mode 100644 arch/riscv/kernel/return_address.c
> >
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/f=
trace.h
> > index 2b2f5df7ef2c..42777f91a9c5 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -25,6 +25,11 @@
> >
> >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> >  #ifndef __ASSEMBLY__
> > +
> > +extern void *return_address(unsigned int level);
> > +
> > +#define ftrace_return_address(n) return_address(n)
> > +
> >  void MCOUNT_NAME(void);
> >  static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  {
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index fee22a3d1b53..40d054939ae2 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
> >  CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_patch.o  =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_sbi.o    =3D $(CC_FLAGS_FTRACE)
> > +CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
> >  endif
> >  CFLAGS_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
> >  CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override-init=
,)
> > @@ -46,6 +47,7 @@ obj-y +=3D irq.o
> >  obj-y  +=3D process.o
> >  obj-y  +=3D ptrace.o
> >  obj-y  +=3D reset.o
> > +obj-y  +=3D return_address.o
> >  obj-y  +=3D setup.o
> >  obj-y  +=3D signal.o
> >  obj-y  +=3D syscall_table.o
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
> > +       unsigned int level;
> > +       void *addr;
> > +};
> > +
> > +static bool save_return_addr(void *d, unsigned long pc)
> > +{
> > +       struct return_address_data *data =3D d;
> > +
> > +       if (!data->level) {
> > +               data->addr =3D (void *)pc;
> > +               return false;
> > +       }
> > +
> > +       --data->level;
> > +
> > +       return true;
> > +}
> > +NOKPROBE_SYMBOL(save_return_addr);
> > +
> > +void *return_address(unsigned int level)
> > +{
> > +       struct return_address_data data;
> > +
> > +       data.level =3D level + 3;
> > +       data.addr =3D NULL;
> > +
> > +       arch_stack_walk(save_return_addr, &data, current, NULL);
> > +
> > +       if (!data.level)
> > +               return data.addr;
> > +       else
> > +               return NULL;
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(return_address);
> > +NOKPROBE_SYMBOL(return_address);
> > --
> > 2.17.1
> >
>
> Hi Palmer and all,
> I was wondering whether this patch is good for everyone? Thanks

Hi Palmer,
Is there any chance to include this patch in 6.8-rc1? Thanks

