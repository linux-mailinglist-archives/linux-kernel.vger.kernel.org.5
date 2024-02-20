Return-Path: <linux-kernel+bounces-72250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACE85B128
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2381F245FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF0B55E47;
	Tue, 20 Feb 2024 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QGw1hmP7"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970451037
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398572; cv=none; b=TETveKCiFwbAQsojU9laeB3kvuFKQEHmujSrasKmyKI3xHe0ywL/fiTA8TrG+sDumXTc43nlEVVtfpPEDzlcv/lVx2prTtizcbIr7Qp9GUbar6QoZzFzJYgPH0+zJQEQlh8DtpvD0eyU3vUKjcB2MYMYClvmHzUisdo5gkSgOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398572; c=relaxed/simple;
	bh=nLsdeRM2kMT0rqU8RqRQi3T9SLAwzHnZJfXLLgc1La8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBHLOXQZFVjcTbNk0Fv9zbNr9Ys3V6c25k/jISxDnu1G9KoxVZLymLbqSpJnwFLx94uAMd3rOYEixhHdEuJmIA4nMcLb/WXq2gvyjJg9uq6dhD8QZEHHT0UgrxGv7cnapeMD2UmYj4ZQwv2APscLYb4ILIq7KOCcEBeN8eLjx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QGw1hmP7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21e6be74db4so2169210fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708398569; x=1709003369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7ZAELWlxvhcGb+UXJ1Ymbb5tqPk6n1CqXg9iAFFqFw=;
        b=QGw1hmP7mcIpITzFPeHboJ3MBM8icwj/uBHZ40Mha5h69tAzn4L055cr0o0tu/mJW2
         /rr3Ez1tto3ZoydZjKWllk7micMXWqv4y8pQbhPQjoN2edD+zfbLBbbBSwPeUwGHAlN5
         AsPj5chk9tTWCwOPBAi45hcqHaQCVVGeEl5+A+5kFA1Hx7dm+e5m4ZPTo7jmrJiiS559
         0bNArlOUepkXotw//Lf2L563veKFxhS00cdJm5xXo3IxQ7yBf7PbGDBXejqo7EN6sxKt
         kmSgYhXrwVBwytGiZHcFdQS8J6k/X2eiIz2KW6LsIGefeiqm8J2/MxyO1ivMXIvwAgsq
         CwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398569; x=1709003369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7ZAELWlxvhcGb+UXJ1Ymbb5tqPk6n1CqXg9iAFFqFw=;
        b=qhO0gGmiaQh+/nYyR52eSwwGj9FMeqk0MQRhoyxU4sl7dhMBBYdLknRi3uVX3xq4So
         EHxSyoPcx8JnkxQsnuTY81pHMPHYiB/BuxKQXaWsboL5/wOXopo90U6FTnKzcFVwZtLL
         aXOK/SLWE0PLneLCSgmJHTqKi7xfR4bsImKogUb8uXkuF61lTJt7YD11qYJOYSxr91Ig
         2mqTdHKkFHFSuC9uclPzBorpBuC2Kq4RWgHeWDgsQT/kCcMB2oUdsrFJtohJOjnZbhcp
         33/qYhY2sZAU4nMB3bNIUeLD5PNzN91VrZxMK6oYk0ZmjB5AE3XsoXGOmQ4JAJRZCT1T
         rzRg==
X-Forwarded-Encrypted: i=1; AJvYcCVPUNh1OipdeyiNeRnk97JLDExJjvMtYQZElnTFQEB/e6Bus+KFZrPyhdboAAJKJiWpx/AZEdbGTWvYdzXGoEMKiycgjOuRoi1b/K3D
X-Gm-Message-State: AOJu0YyavQvNn5H7xYUvJH7WMqDKi1JyBVAtxRR+fdPq59w85OdoXNe1
	OWpXBghRW7u+hK5ji3OVbIaUcPbZYoxg5f0ioNt/+MHiDyAjszIbPxZ6hBTez4M8ZD+ICrQ0o4M
	iqtIcqlFAo2KO5LDUa1taYfNl+ucbtAMb/RWw8Q==
X-Google-Smtp-Source: AGHT+IF8Arl9ZzkFwWEV3k8/Nuri9gUeLAraGKLPg4mSMgjX80U7BmJm474YLjTxp3ViVTGtdSR0F63P+aAqaiWw/po=
X-Received: by 2002:a05:6870:1649:b0:21e:8f7c:1a76 with SMTP id
 c9-20020a056870164900b0021e8f7c1a76mr7200124oae.39.1708398569637; Mon, 19 Feb
 2024 19:09:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org>
 <20230914020044.1397356-3-songshuaishuai@tinylab.org> <CAEEQ3w=Xeuoyd8T0RDv0Eoums1S5-kX4omAUsACQLGixJqio3w@mail.gmail.com>
 <27DC53FAEB131D26+df5f1be3-4185-07d7-21f8-ebb6ccdfcb23@tinylab.org>
In-Reply-To: <27DC53FAEB131D26+df5f1be3-4185-07d7-21f8-ebb6ccdfcb23@tinylab.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 20 Feb 2024 11:09:18 +0800
Message-ID: <CAEEQ3w=inDq41OYrpBDpTJ=UKJivaytj_SbxRMfuwJaRRvWfFA@mail.gmail.com>
Subject: Re: [External] [PATCH 2/2] riscv: kexec_file: Support loading Image
 binary file
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	lihuafei1@huawei.com, conor.dooley@microchip.com, liaochang1@huawei.com, 
	guoren@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com, 
	evan@rivosinc.com, sunilvl@ventanamicro.com, xianting.tian@linux.alibaba.com, 
	samitolvanen@google.com, masahiroy@kernel.org, apatel@ventanamicro.com, 
	jszhang@kernel.org, duwe@suse.de, eric.devolder@oracle.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Song Shuai,

On Mon, Feb 19, 2024 at 5:53=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
>
> Hi, yunhui:
>
> =E5=9C=A8 2024/2/16 16:54, yunhui cui =E5=86=99=E9=81=93:
> > Hi Shuai,
> >
> > On Thu, Sep 14, 2023 at 10:09=E2=80=AFAM Song Shuai <songshuaishuai@tin=
ylab.org> wrote:
> >>
> >> This patch creates image_kexec_ops to load Image binary file
> >> for kexec_file_load() syscall.
> >>
> >> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> >> ---
> >>   arch/riscv/include/asm/image.h         |  2 +
> >>   arch/riscv/include/asm/kexec.h         |  1 +
> >>   arch/riscv/kernel/Makefile             |  2 +-
> >>   arch/riscv/kernel/kexec_image.c        | 97 ++++++++++++++++++++++++=
++
> >>   arch/riscv/kernel/machine_kexec_file.c |  1 +
> >>   5 files changed, 102 insertions(+), 1 deletion(-)
> >>   create mode 100644 arch/riscv/kernel/kexec_image.c
> >>
> >> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/i=
mage.h
> >> index e0b319af3681..8927a6ea1127 100644
> >> --- a/arch/riscv/include/asm/image.h
> >> +++ b/arch/riscv/include/asm/image.h
> >> @@ -30,6 +30,8 @@
> >>                                RISCV_HEADER_VERSION_MINOR)
> >>
> >>   #ifndef __ASSEMBLY__
> >> +#define riscv_image_flag_field(flags, field)\
> >> +                              (((flags) >> field##_SHIFT) & field##_M=
ASK)
> >>   /**
> >>    * struct riscv_image_header - riscv kernel image header
> >>    * @code0:             Executable code
> >> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/k=
exec.h
> >> index 518825fe4160..b9ee8346cc8c 100644
> >> --- a/arch/riscv/include/asm/kexec.h
> >> +++ b/arch/riscv/include/asm/kexec.h
> >> @@ -56,6 +56,7 @@ extern riscv_kexec_method riscv_kexec_norelocate;
> >>
> >>   #ifdef CONFIG_KEXEC_FILE
> >>   extern const struct kexec_file_ops elf_kexec_ops;
> >> +extern const struct kexec_file_ops image_kexec_ops;
> >>
> >>   struct purgatory_info;
> >>   int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> >> index 1c62c639e875..9ecba3231a36 100644
> >> --- a/arch/riscv/kernel/Makefile
> >> +++ b/arch/riscv/kernel/Makefile
> >> @@ -86,7 +86,7 @@ endif
> >>   obj-$(CONFIG_HOTPLUG_CPU)      +=3D cpu-hotplug.o
> >>   obj-$(CONFIG_KGDB)             +=3D kgdb.o
> >>   obj-$(CONFIG_KEXEC_CORE)       +=3D kexec_relocate.o crash_save_regs=
o machine_kexec.o
> >> -obj-$(CONFIG_KEXEC_FILE)       +=3D kexec_elf.o machine_kexec_file.o
> >> +obj-$(CONFIG_KEXEC_FILE)       +=3D kexec_elf.o kexec_image.o machine=
_kexec_file.o
> >>   obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
> >>   obj-$(CONFIG_CRASH_CORE)       +=3D crash_core.o
> >>
> >> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec=
_image.c
> >> new file mode 100644
> >> index 000000000000..b6aa7f59bd53
> >> --- /dev/null
> >> +++ b/arch/riscv/kernel/kexec_image.c
> >> @@ -0,0 +1,97 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * RISC-V Kexec image loader
> >> + *
> >> + */
> >> +
> >> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
> >> +
> >> +#include <linux/err.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/kexec.h>
> >> +#include <linux/pe.h>
> >> +#include <linux/string.h>
> >> +#include <asm/byteorder.h>
> >> +#include <asm/image.h>
> >> +
> >> +static int image_probe(const char *kernel_buf, unsigned long kernel_l=
en)
> >> +{
> >> +       const struct riscv_image_header *h =3D
> >> +               (const struct riscv_image_header *)(kernel_buf);
> >> +
> >> +       if (!h || (kernel_len < sizeof(*h)))
> >> +               return -EINVAL;
> >> +
> >> +       /* According to Documentation/riscv/boot-image-header.rst,
> >> +        * use "magic2" field to check when version >=3D 0.2.
> >> +        */
> >> +
> >> +       if (h->version >=3D RISCV_HEADER_VERSION &&
> >> +           memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
> >> +               return -EINVAL;
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static void *image_load(struct kimage *image,
> >> +                               char *kernel, unsigned long kernel_len=
,
> >> +                               char *initrd, unsigned long initrd_len=
,
> >> +                               char *cmdline, unsigned long cmdline_l=
en)
> >> +{
> >> +       struct riscv_image_header *h;
> >> +       u64 flags;
> >> +       bool be_image, be_kernel;
> >> +       struct kexec_buf kbuf;
> >> +       int ret;
> >> +
> >> +       /* Check Image header */
> >> +       h =3D (struct riscv_image_header *)kernel;
> >> +       if (!h->image_size) {
> >> +               ret =3D -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       /* Check endianness */
> >> +       flags =3D le64_to_cpu(h->flags);
> >> +       be_image =3D riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE=
);
> >> +       be_kernel =3D IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> >> +       if (be_image !=3D be_kernel) {
> >> +               ret =3D -EINVAL;
> >> +               goto out;
> >> +       }
> >> +
> >> +       /* Load the kernel image */
> >> +       kbuf.image =3D image;
> >> +       kbuf.buf_min =3D 0;
> >> +       kbuf.buf_max =3D ULONG_MAX;
> >> +       kbuf.top_down =3D false;
> >> +
> >> +       kbuf.buffer =3D kernel;
> >> +       kbuf.bufsz =3D kernel_len;
> >> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >> +       kbuf.memsz =3D le64_to_cpu(h->image_size);
> >> +       kbuf.buf_align =3D le64_to_cpu(h->text_offset);
> >> +
> >> +       ret =3D kexec_add_buffer(&kbuf);
> >> +       if (ret) {
> >> +               pr_err("Error add kernel image ret=3D%d\n", ret);
> >> +               goto out;
> >> +       }
> >> +
> >> +       image->start =3D kbuf.mem;
> >> +
> >> +       pr_info("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n"=
,
> >> +                               kbuf.mem, kbuf.bufsz, kbuf.memsz);
> >
> > pr_info() or pr_debug()? >
> >
> >> +
> >> +       ret =3D load_extra_segments(image, kbuf.mem, kbuf.memsz,
> >> +                                 initrd, initrd_len, cmdline, cmdline=
_len);
> >> +
> >> +out:
> >> +       return ret ? ERR_PTR(ret) : NULL;
> >> +}
> >> +
> >> +const struct kexec_file_ops image_kexec_ops =3D {
> >> +       .probe =3D image_probe,
> >> +       .load =3D image_load,
> >> +};
> >> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kerne=
l/machine_kexec_file.c
> >> index aedb8c16a283..5dc700834f1e 100644
> >> --- a/arch/riscv/kernel/machine_kexec_file.c
> >> +++ b/arch/riscv/kernel/machine_kexec_file.c
> >> @@ -17,6 +17,7 @@
> >>
> >>   const struct kexec_file_ops * const kexec_file_loaders[] =3D {
> >>          &elf_kexec_ops,
> >> +       &image_kexec_ops,
> >>          NULL
> >>   };
> >>
> >> --
> >> 2.20.1
> >>
> >
> > I tested these two patches. It works when
> > CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY is not enabled. When
> > CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY is enabled, the error is as
> > follows:
> >
> > [45.712019] Unknown rela relocation: 34
> > [45.712258] Error loading purgatory ret=3D-8
> >
> > How to fix it? >
> > Thanks=EF=BC=8C
> > Yunhui
> >
> Thanks for your attention to this series and RV kdump/kexec stack.
>
> As you noticed, this series and the kexec-tools RV support patches[1]
> didn't get any positive responses and have been suspended for a few
> months. And I'm now struggling in my own job, so really sorry that I
> have no time to continue these works.
>
> Although that, I would like to reply to your comments in case anyone
> wants to push this series:
>
> Comment1: Why rename elf_kexec.c to kexec_elf.c =EF=BC=9F
> - s390 uses kexec_{elf,image}.c file names, so I followed it.
Okay, so are arm64/x86.

> Comment2: pr_info() or pr_debug()?
> - pr_debug() seems better.
>
> Comment3: Unknown rela relocation: 34
>
> - The CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY was enabled when I posted
> this series, I didn't see this relocation error at that time.
>
> If you want to fix this relocation error, you need to figure out who
> hold the R_RISCV_ADD16 (34), and how it was generated (compiler options
> or other RV kernel configures). This commit 0f5f46a869a5 ("riscv: kexec:
> Remove -fPIE for PURGATORY_CFLAGS") may help.

Have you tested it with the top commit of linux-next? Can you share the .co=
nfig?

Thanks

