Return-Path: <linux-kernel+bounces-46599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DA88441E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46B9B2CEA5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB558288E;
	Wed, 31 Jan 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jaO350FD"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD31272BA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711112; cv=none; b=ar0Cq3trNbk/SptCjcrbeoJ7067f7R6eMiuL/crIl8LVIVA9rUgdufwjmWZDSEgBU7XVrsGyeJ+mY60IizT0yHqYt8308eDCJPUGbg3vmIxzZNj3qg498N//ZNl/deUs7LYrkAG7Sv5AW/VMyFWWQQueGxPo3wTH5gqOgRec93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711112; c=relaxed/simple;
	bh=FZlnxQvoQ3Huh9/R+1tuKBqUrzgpcoSpQLTdNNrTEjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jL2qultY+murkzMPuVXx3SkcJ4N45w+k/PHvp37P2o96tKtY+H3blDl+pbc8ZhGJsB5cmWNz5srAUkMqc4Ekh2eKBYOcC1MICOYk5P44D84K5QkhjkU1RKFiC2BXhLFueJhYPEpYrb/vhipo6lHiYzg2uH5VYcaRrOACf9VXsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jaO350FD; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-363890fe589so7696575ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706711109; x=1707315909; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCdqXoIsPm+7CCFBVcWTPm9olbyUcfWHTxGQ4zGSJS8=;
        b=jaO350FDJkRQUslxSL3I4DzbR0xQevciYcDD4Be4SjshSxKQ7jVqR0W1pFxL30bmFU
         GVaQ2lpf8TGnYbZ8Ce3Ywh06xxDXO/O31AFCMqPZVWrY2YyM2wZkO2cKBm44ZsTYSe2O
         uSY3r+j8J045aqC6aafWRz51eaKfc39DScbPt9hAO9RY5uD5WFixTpxJFoYy5CC9Nmb8
         8uq3hzpXqCk1jR8VX2lD6WfU23XCEuzs8ZC/e+8l7gwRU63+3v/BI7mdFXh4vNQO+g7b
         Gc4K9mcaa7xlH8i1fNLt8Z8Z2WNTyuKeN68wjz04kwgCoj5d1cvD52IT1kvbcZgh15Ad
         Fm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711109; x=1707315909;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCdqXoIsPm+7CCFBVcWTPm9olbyUcfWHTxGQ4zGSJS8=;
        b=O7uCV7Xas+H5DI1Z5fc12iupPJ7V50KcUSXhTt68L+UqXkjN17/vzPds/anJ5DaQiV
         8jVA5/GO+aPVWlRIG/xZnFd2iIk3gbiXzmqEFn9wuTaof1XaKpxy6z83IQvAYYZkojFK
         NeHWvMFFcCN2W4nrz7R/8hh/Yf7viHb1YiAnenyTOtuQi89Vi2KkFdmEFSbYTjQ1BVwA
         2fvJCjnTXv+Be0iRerUgNqeHB6x6hZo3Aw+jdLjDLKWENF4IDQUdKFdAs6zcjdxhS6Di
         EKnxiNyLp1stUYnJ7TVUTic53TAXzWuB/6FJpCVU9sd3ZgJlqRJCqumnpOCZaXWWHpAP
         xDIg==
X-Gm-Message-State: AOJu0YwOZLlGPZCAmugLlI7JmVwy6IQV4nwr77+9Ybk1qZst0PtVxasw
	FvLIwBMmMM4em4tlQa3E0uyAKmciaabbRFwDi9iZGzsl/6tLG/iWkJFgFRC589sdPgOzQWNdjR9
	EIDvJIbJXVBMocUE0z+E0cBhvy/KFZZHT/5XzYQ==
X-Google-Smtp-Source: AGHT+IFH2VtYLytH0SW5zTMxqRdyp3vZvC0Z3Ml7WZCuG3APx8Od85SOTNHygIXjIoIiqe7jBFaHe1NY51yyBpEX4cs=
X-Received: by 2002:a05:6e02:50b:b0:363:800b:3fe0 with SMTP id
 d11-20020a056e02050b00b00363800b3fe0mr1882367ils.8.1706711109572; Wed, 31 Jan
 2024 06:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205085959.32177-1-zong.li@sifive.com> <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
 <CANXhq0qqv3MBEt8zsWBT+gkdyt1PD4ZjDSrznEotdFM7M7K+yQ@mail.gmail.com> <CANXhq0qNA5JO1xZLbuL6ig1Ddws0m2azMwCyqLFgN3B0VZmvEw@mail.gmail.com>
In-Reply-To: <CANXhq0qNA5JO1xZLbuL6ig1Ddws0m2azMwCyqLFgN3B0VZmvEw@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 31 Jan 2024 22:24:58 +0800
Message-ID: <CANXhq0o-MaEQY3m+0CNWK2Jv_pxqsjhhSJWtVR396wgKUzcbQw@mail.gmail.com>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
To: palmer@dabbelt.com, Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 8:50=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Jan 10, 2024 at 11:33=E2=80=AFAM Zong Li <zong.li@sifive.com> wro=
te:
> >
> > On Fri, Dec 29, 2023 at 2:34=E2=80=AFPM Zong Li <zong.li@sifive.com> wr=
ote:
> > >
> > > On Tue, Dec 5, 2023 at 5:00=E2=80=AFPM Zong Li <zong.li@sifive.com> w=
rote:
> > > >
> > > > CALLER_ADDRx returns caller's address at specified level, they are =
used
> > > > for several tracers. These macros eventually use
> > > > __builtin_return_address(n) to get the caller's address if arch doe=
sn't
> > > > define their own implementation.
> > > >
> > > > In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, =
we need
> > > > to walk the stack frame to get the caller's address at specified le=
vel.
> > > >
> > > > data.level started from 'level + 3' due to the call flow of getting
> > > > caller's address in RISC-V implementation. If we don't have additio=
nal
> > > > three iteration, the level is corresponding to follows:
> > > >
> > > > callsite -> return_address -> arch_stack_walk -> walk_stackframe
> > > > |           |                 |                  |
> > > > level 3     level 2           level 1            level 0
> > > >
> > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > ---
> > > >  arch/riscv/include/asm/ftrace.h    |  5 ++++
> > > >  arch/riscv/kernel/Makefile         |  2 ++
> > > >  arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 55 insertions(+)
> > > >  create mode 100644 arch/riscv/kernel/return_address.c
> > > >
> > > > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/a=
sm/ftrace.h
> > > > index 2b2f5df7ef2c..42777f91a9c5 100644
> > > > --- a/arch/riscv/include/asm/ftrace.h
> > > > +++ b/arch/riscv/include/asm/ftrace.h
> > > > @@ -25,6 +25,11 @@
> > > >
> > > >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> > > >  #ifndef __ASSEMBLY__
> > > > +
> > > > +extern void *return_address(unsigned int level);
> > > > +
> > > > +#define ftrace_return_address(n) return_address(n)
> > > > +
> > > >  void MCOUNT_NAME(void);
> > > >  static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > > >  {
> > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefil=
e
> > > > index fee22a3d1b53..40d054939ae2 100644
> > > > --- a/arch/riscv/kernel/Makefile
> > > > +++ b/arch/riscv/kernel/Makefile
> > > > @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
> > > >  CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
> > > >  CFLAGS_REMOVE_patch.o  =3D $(CC_FLAGS_FTRACE)
> > > >  CFLAGS_REMOVE_sbi.o    =3D $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
> > > >  endif
> > > >  CFLAGS_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
> > > >  CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override-=
init,)
> > > > @@ -46,6 +47,7 @@ obj-y +=3D irq.o
> > > >  obj-y  +=3D process.o
> > > >  obj-y  +=3D ptrace.o
> > > >  obj-y  +=3D reset.o
> > > > +obj-y  +=3D return_address.o
> > > >  obj-y  +=3D setup.o
> > > >  obj-y  +=3D signal.o
> > > >  obj-y  +=3D syscall_table.o
> > > > diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel=
/return_address.c
> > > > new file mode 100644
> > > > index 000000000000..c2008d4aa6e5
> > > > --- /dev/null
> > > > +++ b/arch/riscv/kernel/return_address.c
> > > > @@ -0,0 +1,48 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * This code come from arch/arm64/kernel/return_address.c
> > > > + *
> > > > + * Copyright (C) 2023 SiFive.
> > > > + */
> > > > +
> > > > +#include <linux/export.h>
> > > > +#include <linux/kprobes.h>
> > > > +#include <linux/stacktrace.h>
> > > > +
> > > > +struct return_address_data {
> > > > +       unsigned int level;
> > > > +       void *addr;
> > > > +};
> > > > +
> > > > +static bool save_return_addr(void *d, unsigned long pc)
> > > > +{
> > > > +       struct return_address_data *data =3D d;
> > > > +
> > > > +       if (!data->level) {
> > > > +               data->addr =3D (void *)pc;
> > > > +               return false;
> > > > +       }
> > > > +
> > > > +       --data->level;
> > > > +
> > > > +       return true;
> > > > +}
> > > > +NOKPROBE_SYMBOL(save_return_addr);
> > > > +
> > > > +void *return_address(unsigned int level)
> > > > +{
> > > > +       struct return_address_data data;
> > > > +
> > > > +       data.level =3D level + 3;
> > > > +       data.addr =3D NULL;
> > > > +
> > > > +       arch_stack_walk(save_return_addr, &data, current, NULL);
> > > > +
> > > > +       if (!data.level)
> > > > +               return data.addr;
> > > > +       else
> > > > +               return NULL;
> > > > +
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > +NOKPROBE_SYMBOL(return_address);
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > Hi Palmer and all,
> > > I was wondering whether this patch is good for everyone? Thanks
> >
> > Hi Palmer,
> > Is there any chance to include this patch in 6.8-rc1? Thanks
>
> Hi Palmer,
> I'm not sure if this patch is a feature or bug fix, would you consider
> it for 6.8-rcX? Thanks

Hi Palmer,
Sorry for pinging you again. I'm not sure if you saw this patch. The
irqsoff and wakeup tracer will use CALLER_ADDR1 and CALLER_ADDR2 to
obtain the caller's return address, but we are currently encountering
an issue in the RISC-V port where the wrong caller is identified. I
guess you can easily reproduce the situation using ftrace. Could you
share your thoughts on this when you have the time to take a look?
Thanks

