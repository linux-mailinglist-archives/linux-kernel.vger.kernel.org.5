Return-Path: <linux-kernel+bounces-29601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325F8310A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E241C21B04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B3184C;
	Thu, 18 Jan 2024 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AJ6VgDKv"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E3138A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539021; cv=none; b=OI4WjyqRtfIpcP6ARIJ6SMI6Lb2mBQErwpOmkPKghmaOQfqFKy55d0nbfP+ro4WGtHPli+2ZAbv8xV4wKGILXepchrklXhBRvEtbDGZ0pQx8i/kCY6TG8A23Q9xWZpNrvYzL8G0tANu+wQxJPt4FJ1bt2lub3TgiWLFS9SuuNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539021; c=relaxed/simple;
	bh=9y54p8f3U7fAOvV/a6ErT1Zn/mF3dyoC+RYR4mOlE2g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding; b=Sys6zx3KN26D1YUTB2yHxHG+U+rP7MR5BzJfxEhKy0ul0iN4yXqfO4pnicoExs7W+ZfzAKhPRcdGbu3AgSbYlZTL6vDhq0WZTALH/mVeRqEMUKQ2jo7qMAU4wGshMzEaT2UqxmarbISIPbtQGgb3Iy5aSUnwUfq21o+/xcUA0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AJ6VgDKv; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3619cc9cc65so576955ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705539019; x=1706143819; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T6+PUqnYVA+g50Opqgq8C85S5Y3X7o8IynG4S0vGrI=;
        b=AJ6VgDKvWwHVi1O9iRuO86BjZp/SyChIzxTF5THuUpO4PEKPb20NJUcOQdwY0f/4qg
         SFmVPX1JyDx/asY/aekynhzxPKwyFJSMMdH7XFDLWi98QuRM3DqELglaDPS7POvl5dZz
         +POrNJvqSH6TtRgJIWvz6iORW14cy5ULZWs3l52mNsYenAvbmEBQasBYiqZYUEdgHCEP
         +h5AyaNgw+EnD4Fek/m1Aoq0J1V5AUc5iSz6XfV/eHAolwgsOH9ObGW5DyEiK0b4QJOn
         9iC9q38r4X7Iz6iYq79x6CWX1+rj/AFu+RfPi9fRTAwhrzezofQMlWykqzHPKsKACo2C
         Hviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705539019; x=1706143819;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7T6+PUqnYVA+g50Opqgq8C85S5Y3X7o8IynG4S0vGrI=;
        b=QW2Nb7f4VBgIGLNi3T3ueX5czWNW8jInbf9yrP8jWzevD66e3OpQ/Qqw5Jm/eH2CW8
         W2UzIBsJ1R302p+dOuNbPX3XrN43AQrd7ycBSUX55BJcgcRWj9ER6cBwt/x0rMf/uKDU
         dM7jL963+qMJSTsz8RKTm5kx7seQJckKDrB3Oc88TxWkxz64RoF4QBPujWI55IZcI4cc
         AFz3AunyRhKuf6xEPqNJf+dRFXAMGs0uzfHnLLeIJmJ3TzILbZEdjcVysuCJ/SXM+EBD
         PummjF7qRRZ+GpCb2pj4giA66+2PmLuADEf3AWiQWcYm/ZJ7ZCS7+sCxSQNp/8IUY9/M
         F6Yg==
X-Gm-Message-State: AOJu0YyKxkdiGuIPW4jC2pAteXLwKLTKWcrxncGhD3TpybxtqD8gBxq+
	K77FRRtmHT9puqAZdUXXnehYUIwtA+7o3VKdx2QmhTsQtqmdR5tlKNwJYBb79HvLYlQbCvQ50eJ
	3ZSDKUy1NEcQ0F15k7YgUVf5PasojYmZcgtj5Vg==
X-Google-Smtp-Source: AGHT+IEztnAJuBWRCrV40VVKQMBOLrQVaqbPo6g4vRvGgSJFYuKBaidyQHihuBBVKuvITHf58HtS0rKgVyHFCdSjMVI=
X-Received: by 2002:a92:4a0e:0:b0:35f:efdc:764e with SMTP id
 m14-20020a924a0e000000b0035fefdc764emr155882ilf.32.1705539018934; Wed, 17 Jan
 2024 16:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205085959.32177-1-zong.li@sifive.com> <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
 <CANXhq0qqv3MBEt8zsWBT+gkdyt1PD4ZjDSrznEotdFM7M7K+yQ@mail.gmail.com>
In-Reply-To: <CANXhq0qqv3MBEt8zsWBT+gkdyt1PD4ZjDSrznEotdFM7M7K+yQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 18 Jan 2024 08:50:08 +0800
Message-ID: <CANXhq0qNA5JO1xZLbuL6ig1Ddws0m2azMwCyqLFgN3B0VZmvEw@mail.gmail.com>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
To: palmer@dabbelt.com, Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 11:33=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
>
> On Fri, Dec 29, 2023 at 2:34=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Tue, Dec 5, 2023 at 5:00=E2=80=AFPM Zong Li <zong.li@sifive.com> wro=
te:
> > >
> > > CALLER_ADDRx returns caller's address at specified level, they are us=
ed
> > > for several tracers. These macros eventually use
> > > __builtin_return_address(n) to get the caller's address if arch doesn=
't
> > > define their own implementation.
> > >
> > > In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, we=
 need
> > > to walk the stack frame to get the caller's address at specified leve=
l.
> > >
> > > data.level started from 'level + 3' due to the call flow of getting
> > > caller's address in RISC-V implementation. If we don't have additiona=
l
> > > three iteration, the level is corresponding to follows:
> > >
> > > callsite -> return_address -> arch_stack_walk -> walk_stackframe
> > > |           |                 |                  |
> > > level 3     level 2           level 1            level 0
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  arch/riscv/include/asm/ftrace.h    |  5 ++++
> > >  arch/riscv/kernel/Makefile         |  2 ++
> > >  arch/riscv/kernel/return_address.c | 48 ++++++++++++++++++++++++++++=
++
> > >  3 files changed, 55 insertions(+)
> > >  create mode 100644 arch/riscv/kernel/return_address.c
> > >
> > > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm=
/ftrace.h
> > > index 2b2f5df7ef2c..42777f91a9c5 100644
> > > --- a/arch/riscv/include/asm/ftrace.h
> > > +++ b/arch/riscv/include/asm/ftrace.h
> > > @@ -25,6 +25,11 @@
> > >
> > >  #define ARCH_SUPPORTS_FTRACE_OPS 1
> > >  #ifndef __ASSEMBLY__
> > > +
> > > +extern void *return_address(unsigned int level);
> > > +
> > > +#define ftrace_return_address(n) return_address(n)
> > > +
> > >  void MCOUNT_NAME(void);
> > >  static inline unsigned long ftrace_call_adjust(unsigned long addr)
> > >  {
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index fee22a3d1b53..40d054939ae2 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
> > >  CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
> > >  CFLAGS_REMOVE_patch.o  =3D $(CC_FLAGS_FTRACE)
> > >  CFLAGS_REMOVE_sbi.o    =3D $(CC_FLAGS_FTRACE)
> > > +CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
> > >  endif
> > >  CFLAGS_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
> > >  CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override-in=
it,)
> > > @@ -46,6 +47,7 @@ obj-y +=3D irq.o
> > >  obj-y  +=3D process.o
> > >  obj-y  +=3D ptrace.o
> > >  obj-y  +=3D reset.o
> > > +obj-y  +=3D return_address.o
> > >  obj-y  +=3D setup.o
> > >  obj-y  +=3D signal.o
> > >  obj-y  +=3D syscall_table.o
> > > diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel/r=
eturn_address.c
> > > new file mode 100644
> > > index 000000000000..c2008d4aa6e5
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/return_address.c
> > > @@ -0,0 +1,48 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * This code come from arch/arm64/kernel/return_address.c
> > > + *
> > > + * Copyright (C) 2023 SiFive.
> > > + */
> > > +
> > > +#include <linux/export.h>
> > > +#include <linux/kprobes.h>
> > > +#include <linux/stacktrace.h>
> > > +
> > > +struct return_address_data {
> > > +       unsigned int level;
> > > +       void *addr;
> > > +};
> > > +
> > > +static bool save_return_addr(void *d, unsigned long pc)
> > > +{
> > > +       struct return_address_data *data =3D d;
> > > +
> > > +       if (!data->level) {
> > > +               data->addr =3D (void *)pc;
> > > +               return false;
> > > +       }
> > > +
> > > +       --data->level;
> > > +
> > > +       return true;
> > > +}
> > > +NOKPROBE_SYMBOL(save_return_addr);
> > > +
> > > +void *return_address(unsigned int level)
> > > +{
> > > +       struct return_address_data data;
> > > +
> > > +       data.level =3D level + 3;
> > > +       data.addr =3D NULL;
> > > +
> > > +       arch_stack_walk(save_return_addr, &data, current, NULL);
> > > +
> > > +       if (!data.level)
> > > +               return data.addr;
> > > +       else
> > > +               return NULL;
> > > +
> > > +}
> > > +EXPORT_SYMBOL_GPL(return_address);
> > > +NOKPROBE_SYMBOL(return_address);
> > > --
> > > 2.17.1
> > >
> >
> > Hi Palmer and all,
> > I was wondering whether this patch is good for everyone? Thanks
>
> Hi Palmer,
> Is there any chance to include this patch in 6.8-rc1? Thanks

Hi Palmer,
I'm not sure if this patch is a feature or bug fix, would you consider
it for 6.8-rcX? Thanks

