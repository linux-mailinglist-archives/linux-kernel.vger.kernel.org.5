Return-Path: <linux-kernel+bounces-46758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC38443A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F261C25659
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5012A169;
	Wed, 31 Jan 2024 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PlVuM9Bk"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90784A2D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717210; cv=none; b=f9GFC0a7JOFJ4RqcNAdzM5wZpkXLxokLCJ+oc3w3XU+Ma+TwqGXyWPWI02Va+aIYd2OajcYDBeEwX99U7y3lTLGPKBkGRd+GW2eqdxPFrzlCcclOXb1zX3kpPFqA/81l9jKDPR4P8eHF+fGxYrElyDlABb/TikgrsoXdi9sgNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717210; c=relaxed/simple;
	bh=9XerCSIrO3MZAQg9oUAxkEq/vXCPX3FtEmSyOwTW9LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxDWbw5u46mYpFD2RaW8+d9waPMwlLga6xYFXAYQmM+1M7tM9aWBYhkH+g93VAye6OBcCLhSJFTYkG5mEMvhjYozJkxOgbGmcojcdE7Q0cEBJaS6fLROKzQxkHD+KttddDw9xMWMerUnXnJwCXoqTltFguCUQhYIzgmFmRYZqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PlVuM9Bk; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c00ce1e005so66599639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1706717208; x=1707322008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mOJLbseLPsvIbhLzLVD0YPyGdIC7j3P6ckn0xZuSAs=;
        b=PlVuM9BkHNgtvU+guqSm+4RFsZ/1pk5szYcqu5isIxlxjoHUhms4yywxNAKTkxalNO
         mX7WBVC3MlEV5dQ3BQZvzK7Bqdsq0zXHAGzVIqKTliQfcoCIH9yIU1avrBb+Ff9UTd2s
         5uWhO+QDF8BnSD+euIq06rdbzlDdqLnvPLFG9CDTDeckep4v4EcDQG10LQZ2SeaCyIdR
         L7SOB7VNFZ82xHVjp40L5KGSr1Osi3DCzGnvhnjtrjiFDrRql9chnlpSwFZ0WDSYbPIb
         udxuUr1O05CMntr37JI7bdtSqRMnD2OfSXvRGV1HgGSYbT1DrpOPqclUbh7VMaBHjkd4
         QwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717208; x=1707322008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mOJLbseLPsvIbhLzLVD0YPyGdIC7j3P6ckn0xZuSAs=;
        b=SmhYT9vrJkWvS6auD66KvFKyvPBVLSyg7v5H7Afysw/DWOjxUgZ56wTEfOXu4+1PBt
         jw+zA6m/AHhmpzObKpjOmtDs5M6XmFt/sE/TvzG+QNu87j6xcPYFJofDSS2ws6vvZMKE
         T+N6wsRnvt/oGvMyQ3GlXLyRYgbzlNVEfINsukWxEFmyiFRiCGNeSV9tfHO1O4pIGceg
         I5mw/O9ieuGHU5tfHdg7dZwWnhU+BuTIh6ZUT221Wzf240anp//Oa6OTzZgVKcKmDf1C
         2Gg6HEX+Rfa+wAtLBuP8facXYe28uw9kMSEyAUd7iowj5MBhPvAU3046j0iMGhSQ87aM
         vKuw==
X-Gm-Message-State: AOJu0Yx2LxVsSeH5oaOKU3yqXpkBOPTPORNUGVSF6LI9+psoLeodat5W
	tOQWvkuz00KtMU1+f7Vtwsnvy9ghdKDPm66lktUtNKtt4eh+7jQerp9NOI0SFFJAM8gbbdunDRe
	gIpjp6jKAQLfv0pAkfWczC+w+EvGw6xgMikdMbg==
X-Google-Smtp-Source: AGHT+IEl1wgTaicH/lywZEqksedrylK3qXk0XQIBiRAjl1TMWqSsoPkVo2//eTIJ77dWGhid47jFcTSpFMPuBuGRM80=
X-Received: by 2002:a6b:6513:0:b0:7c0:2579:1a2f with SMTP id
 z19-20020a6b6513000000b007c025791a2fmr1495741iob.11.1706717207711; Wed, 31
 Jan 2024 08:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205085959.32177-1-zong.li@sifive.com> <CANXhq0r6A48q+ehayaURLO6snDEjzVJO6Ti+1we-57i0ORT9yg@mail.gmail.com>
 <CANXhq0qqv3MBEt8zsWBT+gkdyt1PD4ZjDSrznEotdFM7M7K+yQ@mail.gmail.com>
 <CANXhq0qNA5JO1xZLbuL6ig1Ddws0m2azMwCyqLFgN3B0VZmvEw@mail.gmail.com>
 <CANXhq0o-MaEQY3m+0CNWK2Jv_pxqsjhhSJWtVR396wgKUzcbQw@mail.gmail.com> <25e2faa5-908c-4391-87db-8540d1f0e904@ghiti.fr>
In-Reply-To: <25e2faa5-908c-4391-87db-8540d1f0e904@ghiti.fr>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 1 Feb 2024 00:06:37 +0800
Message-ID: <CANXhq0qt8R2+zFx5pPiassNjb2JtGcFb5RRcdK+15PxhuSS1Ng@mail.gmail.com>
Subject: Re: [PATCH] riscv: add CALLER_ADDRx support
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: palmer@dabbelt.com, Palmer Dabbelt <palmer@rivosinc.com>, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:46=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wr=
ote:
>
> Hi Zong,
>
> On 31/01/2024 15:24, Zong Li wrote:
> > On Thu, Jan 18, 2024 at 8:50=E2=80=AFAM Zong Li <zong.li@sifive.com> wr=
ote:
> >> On Wed, Jan 10, 2024 at 11:33=E2=80=AFAM Zong Li <zong.li@sifive.com> =
wrote:
> >>> On Fri, Dec 29, 2023 at 2:34=E2=80=AFPM Zong Li <zong.li@sifive.com> =
wrote:
> >>>> On Tue, Dec 5, 2023 at 5:00=E2=80=AFPM Zong Li <zong.li@sifive.com> =
wrote:
> >>>>> CALLER_ADDRx returns caller's address at specified level, they are =
used
> >>>>> for several tracers. These macros eventually use
> >>>>> __builtin_return_address(n) to get the caller's address if arch doe=
sn't
> >>>>> define their own implementation.
> >>>>>
> >>>>> In RISC-V, __builtin_return_address(n) only works when n =3D=3D 0, =
we need
> >>>>> to walk the stack frame to get the caller's address at specified le=
vel.
> >>>>>
> >>>>> data.level started from 'level + 3' due to the call flow of getting
> >>>>> caller's address in RISC-V implementation. If we don't have additio=
nal
> >>>>> three iteration, the level is corresponding to follows:
> >>>>>
> >>>>> callsite -> return_address -> arch_stack_walk -> walk_stackframe
> >>>>> |           |                 |                  |
> >>>>> level 3     level 2           level 1            level 0
> >>>>>
> >>>>> Signed-off-by: Zong Li <zong.li@sifive.com>
> >>>>> ---
> >>>>>   arch/riscv/include/asm/ftrace.h    |  5 ++++
> >>>>>   arch/riscv/kernel/Makefile         |  2 ++
> >>>>>   arch/riscv/kernel/return_address.c | 48 +++++++++++++++++++++++++=
+++++
> >>>>>   3 files changed, 55 insertions(+)
> >>>>>   create mode 100644 arch/riscv/kernel/return_address.c
> >>>>>
> >>>>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/a=
sm/ftrace.h
> >>>>> index 2b2f5df7ef2c..42777f91a9c5 100644
> >>>>> --- a/arch/riscv/include/asm/ftrace.h
> >>>>> +++ b/arch/riscv/include/asm/ftrace.h
> >>>>> @@ -25,6 +25,11 @@
> >>>>>
> >>>>>   #define ARCH_SUPPORTS_FTRACE_OPS 1
> >>>>>   #ifndef __ASSEMBLY__
> >>>>> +
> >>>>> +extern void *return_address(unsigned int level);
> >>>>> +
> >>>>> +#define ftrace_return_address(n) return_address(n)
> >>>>> +
> >>>>>   void MCOUNT_NAME(void);
> >>>>>   static inline unsigned long ftrace_call_adjust(unsigned long addr=
)
> >>>>>   {
> >>>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefil=
e
> >>>>> index fee22a3d1b53..40d054939ae2 100644
> >>>>> --- a/arch/riscv/kernel/Makefile
> >>>>> +++ b/arch/riscv/kernel/Makefile
> >>>>> @@ -7,6 +7,7 @@ ifdef CONFIG_FTRACE
> >>>>>   CFLAGS_REMOVE_ftrace.o =3D $(CC_FLAGS_FTRACE)
> >>>>>   CFLAGS_REMOVE_patch.o  =3D $(CC_FLAGS_FTRACE)
> >>>>>   CFLAGS_REMOVE_sbi.o    =3D $(CC_FLAGS_FTRACE)
> >>>>> +CFLAGS_REMOVE_return_address.o =3D $(CC_FLAGS_FTRACE)
> >>>>>   endif
> >>>>>   CFLAGS_syscall_table.o +=3D $(call cc-option,-Wno-override-init,)
> >>>>>   CFLAGS_compat_syscall_table.o +=3D $(call cc-option,-Wno-override=
-init,)
> >>>>> @@ -46,6 +47,7 @@ obj-y +=3D irq.o
> >>>>>   obj-y  +=3D process.o
> >>>>>   obj-y  +=3D ptrace.o
> >>>>>   obj-y  +=3D reset.o
> >>>>> +obj-y  +=3D return_address.o
> >>>>>   obj-y  +=3D setup.o
> >>>>>   obj-y  +=3D signal.o
> >>>>>   obj-y  +=3D syscall_table.o
> >>>>> diff --git a/arch/riscv/kernel/return_address.c b/arch/riscv/kernel=
/return_address.c
> >>>>> new file mode 100644
> >>>>> index 000000000000..c2008d4aa6e5
> >>>>> --- /dev/null
> >>>>> +++ b/arch/riscv/kernel/return_address.c
> >>>>> @@ -0,0 +1,48 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>> +/*
> >>>>> + * This code come from arch/arm64/kernel/return_address.c
> >>>>> + *
> >>>>> + * Copyright (C) 2023 SiFive.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/export.h>
> >>>>> +#include <linux/kprobes.h>
> >>>>> +#include <linux/stacktrace.h>
> >>>>> +
> >>>>> +struct return_address_data {
> >>>>> +       unsigned int level;
> >>>>> +       void *addr;
> >>>>> +};
> >>>>> +
> >>>>> +static bool save_return_addr(void *d, unsigned long pc)
> >>>>> +{
> >>>>> +       struct return_address_data *data =3D d;
> >>>>> +
> >>>>> +       if (!data->level) {
> >>>>> +               data->addr =3D (void *)pc;
> >>>>> +               return false;
> >>>>> +       }
> >>>>> +
> >>>>> +       --data->level;
> >>>>> +
> >>>>> +       return true;
> >>>>> +}
> >>>>> +NOKPROBE_SYMBOL(save_return_addr);
> >>>>> +
> >>>>> +void *return_address(unsigned int level)
> >>>>> +{
> >>>>> +       struct return_address_data data;
> >>>>> +
> >>>>> +       data.level =3D level + 3;
> >>>>> +       data.addr =3D NULL;
> >>>>> +
> >>>>> +       arch_stack_walk(save_return_addr, &data, current, NULL);
> >>>>> +
> >>>>> +       if (!data.level)
> >>>>> +               return data.addr;
> >>>>> +       else
> >>>>> +               return NULL;
> >>>>> +
> >>>>> +}
> >>>>> +EXPORT_SYMBOL_GPL(return_address);
> >>>>> +NOKPROBE_SYMBOL(return_address);
> >>>>> --
> >>>>> 2.17.1
> >>>>>
> >>>> Hi Palmer and all,
> >>>> I was wondering whether this patch is good for everyone? Thanks
> >>> Hi Palmer,
> >>> Is there any chance to include this patch in 6.8-rc1? Thanks
> >> Hi Palmer,
> >> I'm not sure if this patch is a feature or bug fix, would you consider
> >> it for 6.8-rcX? Thanks
> > Hi Palmer,
> > Sorry for pinging you again. I'm not sure if you saw this patch. The
> > irqsoff and wakeup tracer will use CALLER_ADDR1 and CALLER_ADDR2 to
> > obtain the caller's return address, but we are currently encountering
> > an issue in the RISC-V port where the wrong caller is identified. I
> > guess you can easily reproduce the situation using ftrace. Could you
> > share your thoughts on this when you have the time to take a look?
> > Thanks
>
>
> I'm not Palmer but I'll take a look at your patch today :)
>

Hi Alexandre,

I appreciate your assistance in reviewing this patch, Thanks a lot. :)

> Thanks,
>
> Alex
>
>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

