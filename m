Return-Path: <linux-kernel+bounces-68277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE0D85781A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0132818CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A318B1A;
	Fri, 16 Feb 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Gwqqjk3g"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560B1798E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073666; cv=none; b=GsJTvdaKnq2BQy0MWqlCABA5zgPn1BKHFjFANCBETNihj9z+Ni8xnONuQpIJpt2rlX3YCSS1aGuQcb+R6eRk6X7zxOA6QD9leQBF2mimC6xU5JCsYootBW3dFAPNY3grSvTdLWW/zPGymhSdj4sc/XJOnCddhfqqJVk4zkhszNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073666; c=relaxed/simple;
	bh=wUnJlhXN5xJsNtcSu4XQvbCP/mZi6xj/MxSEUg4NvmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnhSx6qLe9Q0bmMHQXxSCrTHH6XuEDaTEwmqqRF1phpfeCX1aWn58orEpmGlYKNvhxjPcb7P0dnR1XuGYsbae6YEUO8pFoUuCBnMGWzB4b9MgkcvNKedpR8d29uMAq28asKQ/b79adwt/o+uPzJITVZcL9bJjMZstiFqPe8LPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Gwqqjk3g; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c03b92998eso1458181b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708073662; x=1708678462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrVST/Z5WtDwWgZNk13lbgOP4HCxWcuGncW6P4GuUMc=;
        b=Gwqqjk3gfy32MG26PRGqfdQAAB70aoFfkqIskZQbCWCvIXLENVHbTu0El31gljq8n6
         Qx0nejMUQhWQq/hw5D26mdEmCJIEelBxdLgEimizY5qpP7ZrOTq+dQ/U6Hncwe2HaOnW
         TZCEZcR3g5RckBwIVPyKOF2IK0AoukR8gg++b3b8nl7qcwtcCil+6g+3I6Blnl7kpwLN
         e4iDeM/ZMKFBCreTzSwKZpTl/XExO2Ic80eqKMRqdomyHWdHRdQsTNtZO2tZFnREMDyK
         Zya18LvjKjId6Hjl9WZ5PKgCZGEGe8NT72NEeynkIkyW2Ykr1qSntfTTq7UTg1ZVPrTR
         yApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708073662; x=1708678462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrVST/Z5WtDwWgZNk13lbgOP4HCxWcuGncW6P4GuUMc=;
        b=gWDJKFY0iIYax1eMnXNnMpZqsrm4KzXa7LtSAceaYZTpRkBembKcZ/rjb4AbcQCVz2
         Ym/uOMgyQQLGguLtP3MfAKB/QyVUUxGQWX5jTKy6/Vo+Aue5IaS3ARN2kn9H3QOo9WZ+
         NkKN6k3KcuxnLi0iAfxHp8e80UHylB+V7JEhD3cXoHFbav+FvoYbAA3asQr22Dr9roq3
         fdfEUI3oBqimXttBkgbGm9Bq+1G7tMkKTiLd/UDZsDCN5rIKKOAlHFfixmD5ZENLlPMJ
         C33gCqD0Xw1+ZgI59QT8hcBt4IEwUTLW26txfsvV25/7DI1E58C3HvpwbMcty+VvJ1DN
         GGlw==
X-Forwarded-Encrypted: i=1; AJvYcCULisPXoY0wtuXe/HxtqiLjxZuwUTDoqDPT5p8e7tEf0LOZVif/3s2BokJOftxg9o0YJpidpMO86y8RJ1nVpkdgQfGSzPH0esGy2e6B
X-Gm-Message-State: AOJu0YzlRrlAIPLdIC0eRQJUkcT1p3/gwa0CNFC70Kt5eD/k+AzS9kBC
	SoEWJGy8eXWWGA5ipn9wD2eyr7uJEvDPP+XKbS8PNw4rxHyjHwt8YzOoReoUPMSZk/ylpVED+Ri
	e7tH9+Z0F3Z6ModBX89E0rHnQ6bbL68B0OG9UOg==
X-Google-Smtp-Source: AGHT+IHqCPE0xpAZuuiCUgJ5CUxaYFmPjOqnf5jWWoWOwkDmmW6aMuFCCP07tRBLL93h3SIt6pRyafPMdwHFuLplVuE=
X-Received: by 2002:a05:6870:ac1e:b0:21e:5a35:b1cf with SMTP id
 kw30-20020a056870ac1e00b0021e5a35b1cfmr2138392oab.35.1708073662625; Fri, 16
 Feb 2024 00:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org> <20230914020044.1397356-3-songshuaishuai@tinylab.org>
In-Reply-To: <20230914020044.1397356-3-songshuaishuai@tinylab.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 16 Feb 2024 16:54:11 +0800
Message-ID: <CAEEQ3w=Xeuoyd8T0RDv0Eoums1S5-kX4omAUsACQLGixJqio3w@mail.gmail.com>
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

Hi Shuai,

On Thu, Sep 14, 2023 at 10:09=E2=80=AFAM Song Shuai <songshuaishuai@tinylab=
org> wrote:
>
> This patch creates image_kexec_ops to load Image binary file
> for kexec_file_load() syscall.
>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/include/asm/image.h         |  2 +
>  arch/riscv/include/asm/kexec.h         |  1 +
>  arch/riscv/kernel/Makefile             |  2 +-
>  arch/riscv/kernel/kexec_image.c        | 97 ++++++++++++++++++++++++++
>  arch/riscv/kernel/machine_kexec_file.c |  1 +
>  5 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/kexec_image.c
>
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/imag=
e.h
> index e0b319af3681..8927a6ea1127 100644
> --- a/arch/riscv/include/asm/image.h
> +++ b/arch/riscv/include/asm/image.h
> @@ -30,6 +30,8 @@
>                               RISCV_HEADER_VERSION_MINOR)
>
>  #ifndef __ASSEMBLY__
> +#define riscv_image_flag_field(flags, field)\
> +                              (((flags) >> field##_SHIFT) & field##_MASK=
)
>  /**
>   * struct riscv_image_header - riscv kernel image header
>   * @code0:             Executable code
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexe=
c.h
> index 518825fe4160..b9ee8346cc8c 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -56,6 +56,7 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops elf_kexec_ops;
> +extern const struct kexec_file_ops image_kexec_ops;
>
>  struct purgatory_info;
>  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 1c62c639e875..9ecba3231a36 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -86,7 +86,7 @@ endif
>  obj-$(CONFIG_HOTPLUG_CPU)      +=3D cpu-hotplug.o
>  obj-$(CONFIG_KGDB)             +=3D kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)       +=3D kexec_relocate.o crash_save_regs.o m=
achine_kexec.o
> -obj-$(CONFIG_KEXEC_FILE)       +=3D kexec_elf.o machine_kexec_file.o
> +obj-$(CONFIG_KEXEC_FILE)       +=3D kexec_elf.o kexec_image.o machine_ke=
xec_file.o
>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
>  obj-$(CONFIG_CRASH_CORE)       +=3D crash_core.o
>
> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_im=
age.c
> new file mode 100644
> index 000000000000..b6aa7f59bd53
> --- /dev/null
> +++ b/arch/riscv/kernel/kexec_image.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V Kexec image loader
> + *
> + */
> +
> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/pe.h>
> +#include <linux/string.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +
> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +       const struct riscv_image_header *h =3D
> +               (const struct riscv_image_header *)(kernel_buf);
> +
> +       if (!h || (kernel_len < sizeof(*h)))
> +               return -EINVAL;
> +
> +       /* According to Documentation/riscv/boot-image-header.rst,
> +        * use "magic2" field to check when version >=3D 0.2.
> +        */
> +
> +       if (h->version >=3D RISCV_HEADER_VERSION &&
> +           memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static void *image_load(struct kimage *image,
> +                               char *kernel, unsigned long kernel_len,
> +                               char *initrd, unsigned long initrd_len,
> +                               char *cmdline, unsigned long cmdline_len)
> +{
> +       struct riscv_image_header *h;
> +       u64 flags;
> +       bool be_image, be_kernel;
> +       struct kexec_buf kbuf;
> +       int ret;
> +
> +       /* Check Image header */
> +       h =3D (struct riscv_image_header *)kernel;
> +       if (!h->image_size) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Check endianness */
> +       flags =3D le64_to_cpu(h->flags);
> +       be_image =3D riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE);
> +       be_kernel =3D IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> +       if (be_image !=3D be_kernel) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       /* Load the kernel image */
> +       kbuf.image =3D image;
> +       kbuf.buf_min =3D 0;
> +       kbuf.buf_max =3D ULONG_MAX;
> +       kbuf.top_down =3D false;
> +
> +       kbuf.buffer =3D kernel;
> +       kbuf.bufsz =3D kernel_len;
> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       kbuf.memsz =3D le64_to_cpu(h->image_size);
> +       kbuf.buf_align =3D le64_to_cpu(h->text_offset);
> +
> +       ret =3D kexec_add_buffer(&kbuf);
> +       if (ret) {
> +               pr_err("Error add kernel image ret=3D%d\n", ret);
> +               goto out;
> +       }
> +
> +       image->start =3D kbuf.mem;
> +
> +       pr_info("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> +                               kbuf.mem, kbuf.bufsz, kbuf.memsz);

pr_info() or pr_debug()?


> +
> +       ret =3D load_extra_segments(image, kbuf.mem, kbuf.memsz,
> +                                 initrd, initrd_len, cmdline, cmdline_le=
n);
> +
> +out:
> +       return ret ? ERR_PTR(ret) : NULL;
> +}
> +
> +const struct kexec_file_ops image_kexec_ops =3D {
> +       .probe =3D image_probe,
> +       .load =3D image_load,
> +};
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index aedb8c16a283..5dc700834f1e 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -17,6 +17,7 @@
>
>  const struct kexec_file_ops * const kexec_file_loaders[] =3D {
>         &elf_kexec_ops,
> +       &image_kexec_ops,
>         NULL
>  };
>
> --
> 2.20.1
>

I tested these two patches. It works when
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY is not enabled. When
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY is enabled, the error is as
follows:

[45.712019] Unknown rela relocation: 34
[45.712258] Error loading purgatory ret=3D-8

How to fix it?

Thanks=EF=BC=8C
Yunhui

