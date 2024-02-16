Return-Path: <linux-kernel+bounces-68240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBC8577B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DF11F2415C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0C168DD;
	Fri, 16 Feb 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ivXYoEPV"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA011426F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708072338; cv=none; b=sgOcsu7ejft16MvyTZEotdL072DzjSrDqZ48bMxs1OI/U4GgAfZ+mVN+GBkGzrwxniFqz9zgxm2xzFaSu2PwEODWsb/aYl34cdMwhn64ck93ztmZNM3bifwMxiCeIH77rpLO+1gRS2Vpr5nHuy5N1TRKiBzsmjLc4DeORSgBLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708072338; c=relaxed/simple;
	bh=ug0Nau7FmsCKu2qoK2PTbWQf/yT3DDFPY7Y3K/fFd6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z95tCgLv5Xi1uan3dWwoz7+ujWS4RyUI3U9efVDOHUFiEyPkDC8figmBixScYuN/oLiLZs/Hbwx9sAK36aIl/KgBdpjd2skW1JyR+SAN+I3JfHXRd6+R+pguSz/bqQ+XtgainzZjrwrkBZKPYgYgMwsDFCCQiw6UyR7HCnPj50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ivXYoEPV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-214c940145bso937255fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708072334; x=1708677134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PZvncXihxo7yAgHQV/j/ozYf1C+iY5LpyIlP+ilN9c=;
        b=ivXYoEPVCDuT7G6Biy2+FoMKJmlHosGx/Hn4nKct+Vj2PFelk7W5EoxjbViEV3uwt0
         IMrQOoy3wCMdaWAfVguXFRniLyIPHA0io3FHkNqscsx/8dRPSNYsaLk5X3PoUsQ4hgXm
         8YnCvlVBMPmfkDxCV0qQ9ikvYYK8wKOGiTLjHeG0al8HEi1Ff7JTkMWASkYRYsw/jXzN
         rUx9ea0HAUlVbq9Z0OF35u1gxBz2ZcLD844/H1dsXBjFc/hr7j2fD6jAoVHKeGmIkSuJ
         RldszG64fRFurfPulX2scQ6WfDcfjZOPm5k6yuSclkCJYXiVqUnD7lDIJyHWq77jf+M4
         pLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708072334; x=1708677134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PZvncXihxo7yAgHQV/j/ozYf1C+iY5LpyIlP+ilN9c=;
        b=INr5/Jy5hFNZ/Mc17S6IHfNfOMi4RelXxULNXwNeSZLsPYO1R/7ZHMsZJzk9wRQh/M
         u2M21s1l7LVMonRZwCCQtLBwpLPg8Pzir88HwSQxN1/iG3DtW+AZMOu7FKllgHWfPqGp
         EEmhoF15/x6SmcT1oGC4QHh90cbSZVQnSWafIs5PjhvQkinN6sC9Jz59v3EICfCTaplc
         qgwTS9je3FdOzgRq9lboPUe/afmsgkOMBmr+3GOU8EBlPDfdtvLNEj6MUcmsWbFrWfyt
         lqvzRihFcw09IWeK+B37aIPvPGj6dDE/KWaF1MpyasinpcFjXQpJJuxImO/e1a2su49j
         l+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU05cbRKL7NjzkzGn1Tb6BPO5kJ3rRBhYlpFjU7DWHT1hNLyKgQr0hjqIBiAvpMdZ+WJX4/H9f0jiTxblZMbsCmqzfs7qEKKMiFur08
X-Gm-Message-State: AOJu0YzIzscAReaCr/K3E+49jImrEni4r8zOf/rH+7C7FtcUVlgzCLNj
	Gh88N4rhYzS8r2vMeQGXwZmr4pxRE0RChH3ySLResqskzAcQMJVjSnjuS7SMxowNoQJjkSfA70R
	bTabhKU/25Rmb8SHJNUEgj+rVF1VqwG8BeEYHzQ==
X-Google-Smtp-Source: AGHT+IGk2vujS0HohM1TkwSna11Afce8YI2dg86O0y1FsZqcsyK8axakxMLHiW6ftDIaHOHLNg4IP46rbG4pyq+7788=
X-Received: by 2002:a05:6870:b69d:b0:21e:6b78:ff4c with SMTP id
 cy29-20020a056870b69d00b0021e6b78ff4cmr690883oab.20.1708072334540; Fri, 16
 Feb 2024 00:32:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org> <20230914020044.1397356-2-songshuaishuai@tinylab.org>
In-Reply-To: <20230914020044.1397356-2-songshuaishuai@tinylab.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 16 Feb 2024 16:32:03 +0800
Message-ID: <CAEEQ3wn2U0iwQrGGxt0rZ5r0a+iMKyxFQ2SOf9amY88jt-avcg@mail.gmail.com>
Subject: Re: [External] [PATCH 1/2] riscv: kexec_file: Split the loading of
 kernel and others
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

Why rename elf_kexec.c to kexec_elf.c =EF=BC=9F

On Thu, Sep 14, 2023 at 10:08=E2=80=AFAM Song Shuai <songshuaishuai@tinylab=
org> wrote:
>
> This is the preparative patch for kexec_file_load Image support.
>
> It separates the elf_kexec_load() as two parts:
> - the first part loads the vmlinux (or Image)
> - the second part loads other segments (e.g. initrd,fdt,purgatory)
>
> And the second part is exported as the load_extra_segments() function
> which would be used in both kexec-elf.c and kexec-image.c.
>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/include/asm/kexec.h         |   5 +
>  arch/riscv/kernel/Makefile             |   2 +-
>  arch/riscv/kernel/elf_kexec.c          | 469 -------------------------
>  arch/riscv/kernel/kexec_elf.c          | 147 ++++++++
>  arch/riscv/kernel/machine_kexec_file.c |   7 +
>  5 files changed, 160 insertions(+), 470 deletions(-)
>  delete mode 100644 arch/riscv/kernel/elf_kexec.c
>  create mode 100644 arch/riscv/kernel/kexec_elf.c
>
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexe=
c.h
> index 2b56769cb530..518825fe4160 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -67,6 +67,11 @@ int arch_kexec_apply_relocations_add(struct purgatory_=
info *pi,
>  struct kimage;
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cl=
eanup
> +
> +int load_extra_segments(struct kimage *image, unsigned long kernel_start=
,
> +                       unsigned long kernel_len, char *initrd,
> +                       unsigned long initrd_len, char *cmdline,
> +                       unsigned long cmdline_len);
>  #endif
>
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 95cf25d48405..1c62c639e875 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -86,7 +86,7 @@ endif
>  obj-$(CONFIG_HOTPLUG_CPU)      +=3D cpu-hotplug.o
>  obj-$(CONFIG_KGDB)             +=3D kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)       +=3D kexec_relocate.o crash_save_regs.o m=
achine_kexec.o
> -obj-$(CONFIG_KEXEC_FILE)       +=3D elf_kexec.o machine_kexec_file.o
> +obj-$(CONFIG_KEXEC_FILE)       +=3D kexec_elf.o machine_kexec_file.o
>  obj-$(CONFIG_CRASH_DUMP)       +=3D crash_dump.o
>  obj-$(CONFIG_CRASH_CORE)       +=3D crash_core.o
>
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.=
c
> deleted file mode 100644
> index e60fbd8660c4..000000000000
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ /dev/null
> @@ -1,469 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Load ELF vmlinux file for the kexec_file_load syscall.
> - *
> - * Copyright (C) 2021 Huawei Technologies Co, Ltd.
> - *
> - * Author: Liao Chang (liaochang1@huawei.com)
> - *
> - * Based on kexec-tools' kexec-elf-riscv.c, heavily modified
> - * for kernel.
> - */
> -
> -#define pr_fmt(fmt)    "kexec_image: " fmt
> -
> -#include <linux/elf.h>
> -#include <linux/kexec.h>
> -#include <linux/slab.h>
> -#include <linux/of.h>
> -#include <linux/libfdt.h>
> -#include <linux/types.h>
> -#include <linux/memblock.h>
> -#include <asm/setup.h>
> -
> -int arch_kimage_file_post_load_cleanup(struct kimage *image)
> -{
> -       kvfree(image->arch.fdt);
> -       image->arch.fdt =3D NULL;
> -
> -       vfree(image->elf_headers);
> -       image->elf_headers =3D NULL;
> -       image->elf_headers_sz =3D 0;
> -
> -       return kexec_image_post_load_cleanup_default(image);
> -}
> -
> -static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehd=
r,
> -                               struct kexec_elf_info *elf_info, unsigned=
 long old_pbase,
> -                               unsigned long new_pbase)
> -{
> -       int i;
> -       int ret =3D 0;
> -       size_t size;
> -       struct kexec_buf kbuf;
> -       const struct elf_phdr *phdr;
> -
> -       kbuf.image =3D image;
> -
> -       for (i =3D 0; i < ehdr->e_phnum; i++) {
> -               phdr =3D &elf_info->proghdrs[i];
> -               if (phdr->p_type !=3D PT_LOAD)
> -                       continue;
> -
> -               size =3D phdr->p_filesz;
> -               if (size > phdr->p_memsz)
> -                       size =3D phdr->p_memsz;
> -
> -               kbuf.buffer =3D (void *) elf_info->buffer + phdr->p_offse=
t;
> -               kbuf.bufsz =3D size;
> -               kbuf.buf_align =3D phdr->p_align;
> -               kbuf.mem =3D phdr->p_paddr - old_pbase + new_pbase;
> -               kbuf.memsz =3D phdr->p_memsz;
> -               kbuf.top_down =3D false;
> -               ret =3D kexec_add_buffer(&kbuf);
> -               if (ret)
> -                       break;
> -       }
> -
> -       return ret;
> -}
> -
> -/*
> - * Go through the available phsyical memory regions and find one that ho=
ld
> - * an image of the specified size.
> - */
> -static int elf_find_pbase(struct kimage *image, unsigned long kernel_len=
,
> -                         struct elfhdr *ehdr, struct kexec_elf_info *elf=
_info,
> -                         unsigned long *old_pbase, unsigned long *new_pb=
ase)
> -{
> -       int i;
> -       int ret;
> -       struct kexec_buf kbuf;
> -       const struct elf_phdr *phdr;
> -       unsigned long lowest_paddr =3D ULONG_MAX;
> -       unsigned long lowest_vaddr =3D ULONG_MAX;
> -
> -       for (i =3D 0; i < ehdr->e_phnum; i++) {
> -               phdr =3D &elf_info->proghdrs[i];
> -               if (phdr->p_type !=3D PT_LOAD)
> -                       continue;
> -
> -               if (lowest_paddr > phdr->p_paddr)
> -                       lowest_paddr =3D phdr->p_paddr;
> -
> -               if (lowest_vaddr > phdr->p_vaddr)
> -                       lowest_vaddr =3D phdr->p_vaddr;
> -       }
> -
> -       kbuf.image =3D image;
> -       kbuf.buf_min =3D lowest_paddr;
> -       kbuf.buf_max =3D ULONG_MAX;
> -
> -       /*
> -        * Current riscv boot protocol requires 2MB alignment for
> -        * RV64 and 4MB alignment for RV32
> -        *
> -        */
> -       kbuf.buf_align =3D PMD_SIZE;
> -       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> -       kbuf.memsz =3D ALIGN(kernel_len, PAGE_SIZE);
> -       kbuf.top_down =3D false;
> -       ret =3D arch_kexec_locate_mem_hole(&kbuf);
> -       if (!ret) {
> -               *old_pbase =3D lowest_paddr;
> -               *new_pbase =3D kbuf.mem;
> -               image->start =3D ehdr->e_entry - lowest_vaddr + kbuf.mem;
> -       }
> -       return ret;
> -}
> -
> -static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
> -{
> -       unsigned int *nr_ranges =3D arg;
> -
> -       (*nr_ranges)++;
> -       return 0;
> -}
> -
> -static int prepare_elf64_ram_headers_callback(struct resource *res, void=
 *arg)
> -{
> -       struct crash_mem *cmem =3D arg;
> -
> -       cmem->ranges[cmem->nr_ranges].start =3D res->start;
> -       cmem->ranges[cmem->nr_ranges].end =3D res->end;
> -       cmem->nr_ranges++;
> -
> -       return 0;
> -}
> -
> -static int prepare_elf_headers(void **addr, unsigned long *sz)
> -{
> -       struct crash_mem *cmem;
> -       unsigned int nr_ranges;
> -       int ret;
> -
> -       nr_ranges =3D 1; /* For exclusion of crashkernel region */
> -       walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback=
);
> -
> -       cmem =3D kmalloc(struct_size(cmem, ranges, nr_ranges), GFP_KERNEL=
);
> -       if (!cmem)
> -               return -ENOMEM;
> -
> -       cmem->max_nr_ranges =3D nr_ranges;
> -       cmem->nr_ranges =3D 0;
> -       ret =3D walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_header=
s_callback);
> -       if (ret)
> -               goto out;
> -
> -       /* Exclude crashkernel region */
> -       ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk_re=
s.end);
> -       if (!ret)
> -               ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz)=
;
> -
> -out:
> -       kfree(cmem);
> -       return ret;
> -}
> -
> -static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
> -                                unsigned long cmdline_len)
> -{
> -       int elfcorehdr_strlen;
> -       char *cmdline_ptr;
> -
> -       cmdline_ptr =3D kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
> -       if (!cmdline_ptr)
> -               return NULL;
> -
> -       elfcorehdr_strlen =3D sprintf(cmdline_ptr, "elfcorehdr=3D0x%lx ",
> -               image->elf_load_addr);
> -
> -       if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
> -               pr_err("Appending elfcorehdr=3D<addr> exceeds cmdline siz=
e\n");
> -               kfree(cmdline_ptr);
> -               return NULL;
> -       }
> -
> -       memcpy(cmdline_ptr + elfcorehdr_strlen, cmdline, cmdline_len);
> -       /* Ensure it's nul terminated */
> -       cmdline_ptr[COMMAND_LINE_SIZE - 1] =3D '\0';
> -       return cmdline_ptr;
> -}
> -
> -static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> -                           unsigned long kernel_len, char *initrd,
> -                           unsigned long initrd_len, char *cmdline,
> -                           unsigned long cmdline_len)
> -{
> -       int ret;
> -       unsigned long old_kernel_pbase =3D ULONG_MAX;
> -       unsigned long new_kernel_pbase =3D 0UL;
> -       unsigned long initrd_pbase =3D 0UL;
> -       unsigned long headers_sz;
> -       unsigned long kernel_start;
> -       void *fdt, *headers;
> -       struct elfhdr ehdr;
> -       struct kexec_buf kbuf;
> -       struct kexec_elf_info elf_info;
> -       char *modified_cmdline =3D NULL;
> -
> -       ret =3D kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_=
info);
> -       if (ret)
> -               return ERR_PTR(ret);
> -
> -       ret =3D elf_find_pbase(image, kernel_len, &ehdr, &elf_info,
> -                            &old_kernel_pbase, &new_kernel_pbase);
> -       if (ret)
> -               goto out;
> -       kernel_start =3D image->start;
> -       pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> -
> -       /* Add the kernel binary to the image */
> -       ret =3D riscv_kexec_elf_load(image, &ehdr, &elf_info,
> -                                  old_kernel_pbase, new_kernel_pbase);
> -       if (ret)
> -               goto out;
> -
> -       kbuf.image =3D image;
> -       kbuf.buf_min =3D new_kernel_pbase + kernel_len;
> -       kbuf.buf_max =3D ULONG_MAX;
> -
> -       /* Add elfcorehdr */
> -       if (image->type =3D=3D KEXEC_TYPE_CRASH) {
> -               ret =3D prepare_elf_headers(&headers, &headers_sz);
> -               if (ret) {
> -                       pr_err("Preparing elf core header failed\n");
> -                       goto out;
> -               }
> -
> -               kbuf.buffer =3D headers;
> -               kbuf.bufsz =3D headers_sz;
> -               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> -               kbuf.memsz =3D headers_sz;
> -               kbuf.buf_align =3D ELF_CORE_HEADER_ALIGN;
> -               kbuf.top_down =3D true;
> -
> -               ret =3D kexec_add_buffer(&kbuf);
> -               if (ret) {
> -                       vfree(headers);
> -                       goto out;
> -               }
> -               image->elf_headers =3D headers;
> -               image->elf_load_addr =3D kbuf.mem;
> -               image->elf_headers_sz =3D headers_sz;
> -
> -               pr_debug("Loaded elf core header at 0x%lx bufsz=3D0x%lx m=
emsz=3D0x%lx\n",
> -                        image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> -
> -               /* Setup cmdline for kdump kernel case */
> -               modified_cmdline =3D setup_kdump_cmdline(image, cmdline,
> -                                                      cmdline_len);
> -               if (!modified_cmdline) {
> -                       pr_err("Setting up cmdline for kdump kernel faile=
d\n");
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> -               cmdline =3D modified_cmdline;
> -       }
> -
> -#ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
> -       /* Add purgatory to the image */
> -       kbuf.top_down =3D true;
> -       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> -       ret =3D kexec_load_purgatory(image, &kbuf);
> -       if (ret) {
> -               pr_err("Error loading purgatory ret=3D%d\n", ret);
> -               goto out;
> -       }
> -       ret =3D kexec_purgatory_get_set_symbol(image, "riscv_kernel_entry=
",
> -                                            &kernel_start,
> -                                            sizeof(kernel_start), 0);
> -       if (ret)
> -               pr_err("Error update purgatory ret=3D%d\n", ret);
> -#endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
> -
> -       /* Add the initrd to the image */
> -       if (initrd !=3D NULL) {
> -               kbuf.buffer =3D initrd;
> -               kbuf.bufsz =3D kbuf.memsz =3D initrd_len;
> -               kbuf.buf_align =3D PAGE_SIZE;
> -               kbuf.top_down =3D true;
> -               kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> -               ret =3D kexec_add_buffer(&kbuf);
> -               if (ret)
> -                       goto out;
> -               initrd_pbase =3D kbuf.mem;
> -               pr_notice("Loaded initrd at 0x%lx\n", initrd_pbase);
> -       }
> -
> -       /* Add the DTB to the image */
> -       fdt =3D of_kexec_alloc_and_setup_fdt(image, initrd_pbase,
> -                                          initrd_len, cmdline, 0);
> -       if (!fdt) {
> -               pr_err("Error setting up the new device tree.\n");
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> -
> -       fdt_pack(fdt);
> -       kbuf.buffer =3D fdt;
> -       kbuf.bufsz =3D kbuf.memsz =3D fdt_totalsize(fdt);
> -       kbuf.buf_align =3D PAGE_SIZE;
> -       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> -       kbuf.top_down =3D true;
> -       ret =3D kexec_add_buffer(&kbuf);
> -       if (ret) {
> -               pr_err("Error add DTB kbuf ret=3D%d\n", ret);
> -               goto out_free_fdt;
> -       }
> -       /* Cache the fdt buffer address for memory cleanup */
> -       image->arch.fdt =3D fdt;
> -       pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
> -       goto out;
> -
> -out_free_fdt:
> -       kvfree(fdt);
> -out:
> -       kfree(modified_cmdline);
> -       kexec_free_elf_info(&elf_info);
> -       return ret ? ERR_PTR(ret) : NULL;
> -}
> -
> -#define RV_X(x, s, n)  (((x) >> (s)) & ((1 << (n)) - 1))
> -#define RISCV_IMM_BITS 12
> -#define RISCV_IMM_REACH (1LL << RISCV_IMM_BITS)
> -#define RISCV_CONST_HIGH_PART(x) \
> -       (((x) + (RISCV_IMM_REACH >> 1)) & ~(RISCV_IMM_REACH - 1))
> -#define RISCV_CONST_LOW_PART(x) ((x) - RISCV_CONST_HIGH_PART(x))
> -
> -#define ENCODE_ITYPE_IMM(x) \
> -       (RV_X(x, 0, 12) << 20)
> -#define ENCODE_BTYPE_IMM(x) \
> -       ((RV_X(x, 1, 4) << 8) | (RV_X(x, 5, 6) << 25) | \
> -       (RV_X(x, 11, 1) << 7) | (RV_X(x, 12, 1) << 31))
> -#define ENCODE_UTYPE_IMM(x) \
> -       (RV_X(x, 12, 20) << 12)
> -#define ENCODE_JTYPE_IMM(x) \
> -       ((RV_X(x, 1, 10) << 21) | (RV_X(x, 11, 1) << 20) | \
> -       (RV_X(x, 12, 8) << 12) | (RV_X(x, 20, 1) << 31))
> -#define ENCODE_CBTYPE_IMM(x) \
> -       ((RV_X(x, 1, 2) << 3) | (RV_X(x, 3, 2) << 10) | (RV_X(x, 5, 1) <<=
 2) | \
> -       (RV_X(x, 6, 2) << 5) | (RV_X(x, 8, 1) << 12))
> -#define ENCODE_CJTYPE_IMM(x) \
> -       ((RV_X(x, 1, 3) << 3) | (RV_X(x, 4, 1) << 11) | (RV_X(x, 5, 1) <<=
 2) | \
> -       (RV_X(x, 6, 1) << 7) | (RV_X(x, 7, 1) << 6) | (RV_X(x, 8, 2) << 9=
) | \
> -       (RV_X(x, 10, 1) << 8) | (RV_X(x, 11, 1) << 12))
> -#define ENCODE_UJTYPE_IMM(x) \
> -       (ENCODE_UTYPE_IMM(RISCV_CONST_HIGH_PART(x)) | \
> -       (ENCODE_ITYPE_IMM(RISCV_CONST_LOW_PART(x)) << 32))
> -#define ENCODE_UITYPE_IMM(x) \
> -       (ENCODE_UTYPE_IMM(x) | (ENCODE_ITYPE_IMM(x) << 32))
> -
> -#define CLEAN_IMM(type, x) \
> -       ((~ENCODE_##type##_IMM((uint64_t)(-1))) & (x))
> -
> -int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> -                                    Elf_Shdr *section,
> -                                    const Elf_Shdr *relsec,
> -                                    const Elf_Shdr *symtab)
> -{
> -       const char *strtab, *name, *shstrtab;
> -       const Elf_Shdr *sechdrs;
> -       Elf64_Rela *relas;
> -       int i, r_type;
> -
> -       /* String & section header string table */
> -       sechdrs =3D (void *)pi->ehdr + pi->ehdr->e_shoff;
> -       strtab =3D (char *)pi->ehdr + sechdrs[symtab->sh_link].sh_offset;
> -       shstrtab =3D (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_=
offset;
> -
> -       relas =3D (void *)pi->ehdr + relsec->sh_offset;
> -
> -       for (i =3D 0; i < relsec->sh_size / sizeof(*relas); i++) {
> -               const Elf_Sym *sym;     /* symbol to relocate */
> -               unsigned long addr;     /* final location after relocatio=
n */
> -               unsigned long val;      /* relocated symbol value */
> -               unsigned long sec_base; /* relocated symbol value */
> -               void *loc;              /* tmp location to modify */
> -
> -               sym =3D (void *)pi->ehdr + symtab->sh_offset;
> -               sym +=3D ELF64_R_SYM(relas[i].r_info);
> -
> -               if (sym->st_name)
> -                       name =3D strtab + sym->st_name;
> -               else
> -                       name =3D shstrtab + sechdrs[sym->st_shndx].sh_nam=
e;
> -
> -               loc =3D pi->purgatory_buf;
> -               loc +=3D section->sh_offset;
> -               loc +=3D relas[i].r_offset;
> -
> -               if (sym->st_shndx =3D=3D SHN_ABS)
> -                       sec_base =3D 0;
> -               else if (sym->st_shndx >=3D pi->ehdr->e_shnum) {
> -                       pr_err("Invalid section %d for symbol %s\n",
> -                              sym->st_shndx, name);
> -                       return -ENOEXEC;
> -               } else
> -                       sec_base =3D pi->sechdrs[sym->st_shndx].sh_addr;
> -
> -               val =3D sym->st_value;
> -               val +=3D sec_base;
> -               val +=3D relas[i].r_addend;
> -
> -               addr =3D section->sh_addr + relas[i].r_offset;
> -
> -               r_type =3D ELF64_R_TYPE(relas[i].r_info);
> -
> -               switch (r_type) {
> -               case R_RISCV_BRANCH:
> -                       *(u32 *)loc =3D CLEAN_IMM(BTYPE, *(u32 *)loc) |
> -                                ENCODE_BTYPE_IMM(val - addr);
> -                       break;
> -               case R_RISCV_JAL:
> -                       *(u32 *)loc =3D CLEAN_IMM(JTYPE, *(u32 *)loc) |
> -                                ENCODE_JTYPE_IMM(val - addr);
> -                       break;
> -               /*
> -                * With no R_RISCV_PCREL_LO12_S, R_RISCV_PCREL_LO12_I
> -                * sym is expected to be next to R_RISCV_PCREL_HI20
> -                * in purgatory relsec. Handle it like R_RISCV_CALL
> -                * sym, instead of searching the whole relsec.
> -                */
> -               case R_RISCV_PCREL_HI20:
> -               case R_RISCV_CALL_PLT:
> -               case R_RISCV_CALL:
> -                       *(u64 *)loc =3D CLEAN_IMM(UITYPE, *(u64 *)loc) |
> -                                ENCODE_UJTYPE_IMM(val - addr);
> -                       break;
> -               case R_RISCV_RVC_BRANCH:
> -                       *(u32 *)loc =3D CLEAN_IMM(CBTYPE, *(u32 *)loc) |
> -                                ENCODE_CBTYPE_IMM(val - addr);
> -                       break;
> -               case R_RISCV_RVC_JUMP:
> -                       *(u32 *)loc =3D CLEAN_IMM(CJTYPE, *(u32 *)loc) |
> -                                ENCODE_CJTYPE_IMM(val - addr);
> -                       break;
> -               case R_RISCV_ADD32:
> -                       *(u32 *)loc +=3D val;
> -                       break;
> -               case R_RISCV_SUB32:
> -                       *(u32 *)loc -=3D val;
> -                       break;
> -               /* It has been applied by R_RISCV_PCREL_HI20 sym */
> -               case R_RISCV_PCREL_LO12_I:
> -               case R_RISCV_ALIGN:
> -               case R_RISCV_RELAX:
> -                       break;
> -               default:
> -                       pr_err("Unknown rela relocation: %d\n", r_type);
> -                       return -ENOEXEC;
> -               }
> -       }
> -       return 0;
> -}
> -
> -const struct kexec_file_ops elf_kexec_ops =3D {
> -       .probe =3D kexec_elf_probe,
> -       .load  =3D elf_kexec_load,
> -};
> diff --git a/arch/riscv/kernel/kexec_elf.c b/arch/riscv/kernel/kexec_elf.=
c
> new file mode 100644
> index 000000000000..f41272da6b2f
> --- /dev/null
> +++ b/arch/riscv/kernel/kexec_elf.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Load ELF vmlinux file for the kexec_file_load syscall.
> + *
> + * Copyright (C) 2021 Huawei Technologies Co, Ltd.
> + *
> + * Author: Liao Chang (liaochang1@huawei.com)
> + *
> + * Based on kexec-tools' kexec-elf-riscv.c, heavily modified
> + * for kernel.
> + */
> +
> +#define pr_fmt(fmt)    "kexec_image: " fmt
> +
> +#include <linux/elf.h>
> +#include <linux/kexec.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/libfdt.h>
> +#include <linux/types.h>
> +#include <linux/memblock.h>
> +#include <asm/setup.h>
> +
> +static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehd=
r,
> +                               struct kexec_elf_info *elf_info, unsigned=
 long old_pbase,
> +                               unsigned long new_pbase)
> +{
> +       int i;
> +       int ret =3D 0;
> +       size_t size;
> +       struct kexec_buf kbuf;
> +       const struct elf_phdr *phdr;
> +
> +       kbuf.image =3D image;
> +
> +       for (i =3D 0; i < ehdr->e_phnum; i++) {
> +               phdr =3D &elf_info->proghdrs[i];
> +               if (phdr->p_type !=3D PT_LOAD)
> +                       continue;
> +
> +               size =3D phdr->p_filesz;
> +               if (size > phdr->p_memsz)
> +                       size =3D phdr->p_memsz;
> +
> +               kbuf.buffer =3D (void *) elf_info->buffer + phdr->p_offse=
t;
> +               kbuf.bufsz =3D size;
> +               kbuf.buf_align =3D phdr->p_align;
> +               kbuf.mem =3D phdr->p_paddr - old_pbase + new_pbase;
> +               kbuf.memsz =3D phdr->p_memsz;
> +               kbuf.top_down =3D false;
> +               ret =3D kexec_add_buffer(&kbuf);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * Go through the available phsyical memory regions and find one that ho=
ld
> + * an image of the specified size.
> + */
> +static int elf_find_pbase(struct kimage *image, unsigned long kernel_len=
,
> +                         struct elfhdr *ehdr, struct kexec_elf_info *elf=
_info,
> +                         unsigned long *old_pbase, unsigned long *new_pb=
ase)
> +{
> +       int i;
> +       int ret;
> +       struct kexec_buf kbuf;
> +       const struct elf_phdr *phdr;
> +       unsigned long lowest_paddr =3D ULONG_MAX;
> +       unsigned long lowest_vaddr =3D ULONG_MAX;
> +
> +       for (i =3D 0; i < ehdr->e_phnum; i++) {
> +               phdr =3D &elf_info->proghdrs[i];
> +               if (phdr->p_type !=3D PT_LOAD)
> +                       continue;
> +
> +               if (lowest_paddr > phdr->p_paddr)
> +                       lowest_paddr =3D phdr->p_paddr;
> +
> +               if (lowest_vaddr > phdr->p_vaddr)
> +                       lowest_vaddr =3D phdr->p_vaddr;
> +       }
> +
> +       kbuf.image =3D image;
> +       kbuf.buf_min =3D lowest_paddr;
> +       kbuf.buf_max =3D ULONG_MAX;
> +
> +       /*
> +        * Current riscv boot protocol requires 2MB alignment for
> +        * RV64 and 4MB alignment for RV32
> +        *
> +        */
> +       kbuf.buf_align =3D PMD_SIZE;
> +       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> +       kbuf.memsz =3D ALIGN(kernel_len, PAGE_SIZE);
> +       kbuf.top_down =3D false;
> +       ret =3D arch_kexec_locate_mem_hole(&kbuf);
> +       if (!ret) {
> +               *old_pbase =3D lowest_paddr;
> +               *new_pbase =3D kbuf.mem;
> +               image->start =3D ehdr->e_entry - lowest_vaddr + kbuf.mem;
> +       }
> +       return ret;
> +}
> +
> +static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
> +                           unsigned long kernel_len, char *initrd,
> +                           unsigned long initrd_len, char *cmdline,
> +                           unsigned long cmdline_len)
> +{
> +       int ret;
> +       unsigned long old_kernel_pbase =3D ULONG_MAX;
> +       unsigned long new_kernel_pbase =3D 0UL;
> +       struct elfhdr ehdr;
> +       struct kexec_elf_info elf_info;
> +
> +       ret =3D kexec_build_elf_info(kernel_buf, kernel_len, &ehdr, &elf_=
info);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       ret =3D elf_find_pbase(image, kernel_len, &ehdr, &elf_info,
> +                            &old_kernel_pbase, &new_kernel_pbase);
> +       if (ret)
> +               goto out;
> +
> +       pr_notice("The entry point of kernel at 0x%lx\n", image->start);
> +
> +       /* Add the kernel binary to the image */
> +       ret =3D riscv_kexec_elf_load(image, &ehdr, &elf_info,
> +                                  old_kernel_pbase, new_kernel_pbase);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D load_extra_segments(image, image->start, kernel_len,
> +                                 initrd, initrd_len, cmdline, cmdline_le=
n);
> +out:
> +       kexec_free_elf_info(&elf_info);
> +       return ret ? ERR_PTR(ret) : NULL;
> +}
> +
> +

Remove extra blank lines.

> +const struct kexec_file_ops elf_kexec_ops =3D {
> +       .probe =3D kexec_elf_probe,
> +       .load  =3D elf_kexec_load,
> +};
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index 6ebd3ab5a9eb..aedb8c16a283 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -7,6 +7,13 @@
>   * Author: Liao Chang (liaochang1@huawei.com)
>   */
>  #include <linux/kexec.h>
> +#include <linux/elf.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/libfdt.h>
> +#include <linux/types.h>
> +#include <linux/memblock.h>
> +#include <asm/setup.h>
>
>  const struct kexec_file_ops * const kexec_file_loaders[] =3D {
>         &elf_kexec_ops,
> --
> 2.20.1
>

Thanks,
Yunhui

