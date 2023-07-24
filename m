Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F0D75F962
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjGXOIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGXOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733E810F7;
        Mon, 24 Jul 2023 07:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CA86122B;
        Mon, 24 Jul 2023 14:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E216C433CD;
        Mon, 24 Jul 2023 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690207657;
        bh=yJDglkZ69B603sL7BeUHvjoxeRNk+8xDWg58Yi3E/AI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vHHS1QO/PlqrNj6l1P3SDKyUrJuZcJHe9d9sVEkMQoVGQlpeIh7SGq0+Acgd2g1IM
         Fu6m1/VCEpVngYzJZaB2QM0Ni3rYShFSsQDRd5nZb3tiqcRG4bESPfHVGVwbmrkJhK
         /TJme+jeS+PzpIYQ70a+n5EpV6HOCI2Gg6Cc/0PgICmzYWYPlbaAFujUA1XOaDpGUE
         KCV2H9IY4kt75TMRsIJsygiRu7uUl5kkJlCB5a+q8nLCCyrT+JSJrwc2+xks9hZ1rS
         f2YOr5Pt3C6VndfQoY2MYVDsrdQNLn1lrdGeUjDhGLQuBvLHqsRZeGbgNeAoI0RYnC
         XabZghh8XjYwQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so6701749e87.0;
        Mon, 24 Jul 2023 07:07:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLb77fobzzllg/Q3Ih3XEWLp6H8TaB8CKSdscyMmAF+l8wfImuJ7
        UbPmM4EbkMh6IaM4a6VXN/DxhWkhfenqnd1wekA=
X-Google-Smtp-Source: APBJJlFZ8zC3PkDZEElJ5M8PX8NPaWxpuESI4wQl5zSmYaJG8JpiAVT48WFrX1C+Vk2njVyNK6igvYJE9fBaL+U0mV4=
X-Received: by 2002:a05:6512:214d:b0:4f8:742f:3bed with SMTP id
 s13-20020a056512214d00b004f8742f3bedmr4640541lfr.37.1690207654938; Mon, 24
 Jul 2023 07:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230722123850.634544-1-alexghiti@rivosinc.com> <20230722123850.634544-4-alexghiti@rivosinc.com>
In-Reply-To: <20230722123850.634544-4-alexghiti@rivosinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 24 Jul 2023 16:07:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGy10_C69QeNwCFcKkzHfCoo7_u=pAhZ6Q3U8NdVTRfbA@mail.gmail.com>
Message-ID: <CAMj1kXGy10_C69QeNwCFcKkzHfCoo7_u=pAhZ6Q3U8NdVTRfbA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] arm64: libstub: Move KASLR handling functions to kaslr.c
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 at 14:42, Alexandre Ghiti <alexghiti@rivosinc.com> wrot=
e:
>
> This prepares for riscv to use the same functions to handle the p=C4=A5ys=
ical
> kernel move when KASLR is enabled.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

This looks fine to me.

I can stick this on a stable branch in the EFI tree, but I don't have
anything queued up for the next window anyway, so you might as well
just take it directly.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/include/asm/efi.h              |   2 +
>  drivers/firmware/efi/libstub/Makefile     |   2 +-
>  drivers/firmware/efi/libstub/arm64-stub.c | 117 ++--------------
>  drivers/firmware/efi/libstub/efistub.h    |   8 ++
>  drivers/firmware/efi/libstub/kaslr.c      | 159 ++++++++++++++++++++++
>  5 files changed, 183 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/kaslr.c
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 4cf2cb053bc8..46273ee89445 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -168,4 +168,6 @@ static inline void efi_capsule_flush_cache_range(void=
 *addr, int size)
>
>  efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f);
>
> +void efi_icache_sync(unsigned long start, unsigned long end);
> +
>  #endif /* _ASM_EFI_H */
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index 16d64a34d1e1..11aba8a041ec 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -86,7 +86,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)        +=3D efi-stub.o s=
tring.o intrinsics.o systable.o \
>                                    screen_info.o efi-stub-entry.o
>
>  lib-$(CONFIG_ARM)              +=3D arm32-stub.o
> -lib-$(CONFIG_ARM64)            +=3D arm64.o arm64-stub.o smbios.o
> +lib-$(CONFIG_ARM64)            +=3D kaslr.o arm64.o arm64-stub.o smbios.=
o
>  lib-$(CONFIG_X86)              +=3D x86-stub.o
>  lib-$(CONFIG_RISCV)            +=3D riscv.o riscv-stub.o
>  lib-$(CONFIG_LOONGARCH)                +=3D loongarch.o loongarch-stub.o
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware=
/efi/libstub/arm64-stub.c
> index 770b8ecb7398..452b7ccd330e 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -14,42 +14,6 @@
>
>  #include "efistub.h"
>
> -/*
> - * Distro versions of GRUB may ignore the BSS allocation entirely (i.e.,=
 fail
> - * to provide space, and fail to zero it). Check for this condition by d=
ouble
> - * checking that the first and the last byte of the image are covered by=
 the
> - * same EFI memory map entry.
> - */
> -static bool check_image_region(u64 base, u64 size)
> -{
> -       struct efi_boot_memmap *map;
> -       efi_status_t status;
> -       bool ret =3D false;
> -       int map_offset;
> -
> -       status =3D efi_get_memory_map(&map, false);
> -       if (status !=3D EFI_SUCCESS)
> -               return false;
> -
> -       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> -               efi_memory_desc_t *md =3D (void *)map->map + map_offset;
> -               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SIZE=
;
> -
> -               /*
> -                * Find the region that covers base, and return whether
> -                * it covers base+size bytes.
> -                */
> -               if (base >=3D md->phys_addr && base < end) {
> -                       ret =3D (base + size) <=3D end;
> -                       break;
> -               }
> -       }
> -
> -       efi_bs_call(free_pool, map);
> -
> -       return ret;
> -}
> -
>  efi_status_t handle_kernel_image(unsigned long *image_addr,
>                                  unsigned long *image_size,
>                                  unsigned long *reserve_addr,
> @@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *image_=
addr,
>  {
>         efi_status_t status;
>         unsigned long kernel_size, kernel_codesize, kernel_memsize;
> -       u32 phys_seed =3D 0;
> -       u64 min_kimg_align =3D efi_get_kimg_min_align();
> -
> -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> -               efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FIXE=
D_GUID;
> -               void *p;
> -
> -               if (efi_nokaslr) {
> -                       efi_info("KASLR disabled on kernel command line\n=
");
> -               } else if (efi_bs_call(handle_protocol, image_handle,
> -                                      &li_fixed_proto, &p) =3D=3D EFI_SU=
CCESS) {
> -                       efi_info("Image placement fixed by loader\n");
> -               } else {
> -                       status =3D efi_get_random_bytes(sizeof(phys_seed)=
,
> -                                                     (u8 *)&phys_seed);
> -                       if (status =3D=3D EFI_NOT_FOUND) {
> -                               efi_info("EFI_RNG_PROTOCOL unavailable\n"=
);
> -                               efi_nokaslr =3D true;
> -                       } else if (status !=3D EFI_SUCCESS) {
> -                               efi_err("efi_get_random_bytes() failed (0=
x%lx)\n",
> -                                       status);
> -                               efi_nokaslr =3D true;
> -                       }
> -               }
> -       }
>
>         if (image->image_base !=3D _text) {
>                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has=
 bogus value\n");
> @@ -98,50 +37,15 @@ efi_status_t handle_kernel_image(unsigned long *image=
_addr,
>         kernel_codesize =3D __inittext_end - _text;
>         kernel_memsize =3D kernel_size + (_end - _edata);
>         *reserve_size =3D kernel_memsize;
> +       *image_addr =3D (unsigned long)_text;
>
> -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> -               /*
> -                * If KASLR is enabled, and we have some randomness avail=
able,
> -                * locate the kernel at a randomized offset in physical m=
emory.
> -                */
> -               status =3D efi_random_alloc(*reserve_size, min_kimg_align=
,
> -                                         reserve_addr, phys_seed,
> -                                         EFI_LOADER_CODE);
> -               if (status !=3D EFI_SUCCESS)
> -                       efi_warn("efi_random_alloc() failed: 0x%lx\n", st=
atus);
> -       } else {
> -               status =3D EFI_OUT_OF_RESOURCES;
> -       }
> -
> -       if (status !=3D EFI_SUCCESS) {
> -               if (!check_image_region((u64)_text, kernel_memsize)) {
> -                       efi_err("FIRMWARE BUG: Image BSS overlaps adjacen=
t EFI memory region\n");
> -               } else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
> -                          (u64)_end < EFI_ALLOC_LIMIT) {
> -                       /*
> -                        * Just execute from wherever we were loaded by t=
he
> -                        * UEFI PE/COFF loader if the placement is suitab=
le.
> -                        */
> -                       *image_addr =3D (u64)_text;
> -                       *reserve_size =3D 0;
> -                       return EFI_SUCCESS;
> -               }
> -
> -               status =3D efi_allocate_pages_aligned(*reserve_size, rese=
rve_addr,
> -                                                   ULONG_MAX, min_kimg_a=
lign,
> -                                                   EFI_LOADER_CODE);
> -
> -               if (status !=3D EFI_SUCCESS) {
> -                       efi_err("Failed to relocate kernel\n");
> -                       *reserve_size =3D 0;
> -                       return status;
> -               }
> -       }
> -
> -       *image_addr =3D *reserve_addr;
> -       memcpy((void *)*image_addr, _text, kernel_size);
> -       caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesize=
);
> -       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> +       status =3D efi_kaslr_relocate_kernel(image_addr,
> +                                          reserve_addr, reserve_size,
> +                                          kernel_size, kernel_codesize,
> +                                          kernel_memsize,
> +                                          efi_kaslr_get_phys_seed(image_=
handle));
> +       if (status !=3D EFI_SUCCESS)
> +               return status;
>
>         return EFI_SUCCESS;
>  }
> @@ -159,3 +63,8 @@ unsigned long primary_entry_offset(void)
>          */
>         return (char *)primary_entry - _text;
>  }
> +
> +void efi_icache_sync(unsigned long start, unsigned long end)
> +{
> +       caches_clean_inval_pou(start, end);
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/ef=
i/libstub/efistub.h
> index 6aa38a1bf126..b1a1037567ba 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1132,6 +1132,14 @@ const u8 *__efi_get_smbios_string(const struct efi=
_smbios_record *record,
>
>  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
>                      unsigned long code_size);
> +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> +                                      unsigned long *reserve_addr,
> +                                      unsigned long *reserve_size,
> +                                      unsigned long kernel_size,
> +                                      unsigned long kernel_codesize,
> +                                      unsigned long kernel_memsize,
> +                                      u32 phys_seed);
> +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
>
>  asmlinkage efi_status_t __efiapi
>  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
> diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/=
libstub/kaslr.c
> new file mode 100644
> index 000000000000..be0c8ab0982a
> --- /dev/null
> +++ b/drivers/firmware/efi/libstub/kaslr.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Helper functions used by the EFI stub on multiple
> + * architectures to deal with physical address space randomization.
> + */
> +#include <linux/efi.h>
> +
> +#include "efistub.h"
> +
> +/**
> + * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KASLR
> + * @image_handle:      Handle to the image
> + *
> + * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOCOL
> + * that will be used to move the kernel physical mapping.
> + *
> + * Return:     the random seed
> + */
> +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
> +{
> +       efi_status_t status;
> +       u32 phys_seed;
> +       efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FIXED_GUID;
> +       void *p;
> +
> +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> +               return 0;
> +
> +       if (efi_nokaslr) {
> +               efi_info("KASLR disabled on kernel command line\n");
> +       } else if (efi_bs_call(handle_protocol, image_handle,
> +                              &li_fixed_proto, &p) =3D=3D EFI_SUCCESS) {
> +               efi_info("Image placement fixed by loader\n");
> +       } else {
> +               status =3D efi_get_random_bytes(sizeof(phys_seed),
> +                                             (u8 *)&phys_seed);
> +               if (status =3D=3D EFI_SUCCESS) {
> +                       return phys_seed;
> +               } else if (status =3D=3D EFI_NOT_FOUND) {
> +                       efi_info("EFI_RNG_PROTOCOL unavailable\n");
> +                       efi_nokaslr =3D true;
> +               } else if (status !=3D EFI_SUCCESS) {
> +                       efi_err("efi_get_random_bytes() failed (0x%lx)\n"=
,
> +                               status);
> +                       efi_nokaslr =3D true;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Distro versions of GRUB may ignore the BSS allocation entirely (i.e.,=
 fail
> + * to provide space, and fail to zero it). Check for this condition by d=
ouble
> + * checking that the first and the last byte of the image are covered by=
 the
> + * same EFI memory map entry.
> + */
> +static bool check_image_region(u64 base, u64 size)
> +{
> +       struct efi_boot_memmap *map;
> +       efi_status_t status;
> +       bool ret =3D false;
> +       int map_offset;
> +
> +       status =3D efi_get_memory_map(&map, false);
> +       if (status !=3D EFI_SUCCESS)
> +               return false;
> +
> +       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> +               efi_memory_desc_t *md =3D (void *)map->map + map_offset;
> +               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SIZE=
;
> +
> +               /*
> +                * Find the region that covers base, and return whether
> +                * it covers base+size bytes.
> +                */
> +               if (base >=3D md->phys_addr && base < end) {
> +                       ret =3D (base + size) <=3D end;
> +                       break;
> +               }
> +       }
> +
> +       efi_bs_call(free_pool, map);
> +
> +       return ret;
> +}
> +
> +/**
> + * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR en=
abled)
> + * @image_addr: Pointer to the current kernel location
> + * @reserve_addr:      Pointer to the relocated kernel location
> + * @reserve_size:      Size of the relocated kernel
> + * @kernel_size:       Size of the text + data
> + * @kernel_codesize:   Size of the text
> + * @kernel_memsize:    Size of the text + data + bss
> + * @phys_seed:         Random seed used for the relocation
> + *
> + * If KASLR is not enabled, this function relocates the kernel to a fixe=
d
> + * address (or leave it as its current location). If KASLR is enabled, t=
he
> + * kernel physical location is randomized using the seed in parameter.
> + *
> + * Return:     status code, EFI_SUCCESS if relocation is successful
> + */
> +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> +                                      unsigned long *reserve_addr,
> +                                      unsigned long *reserve_size,
> +                                      unsigned long kernel_size,
> +                                      unsigned long kernel_codesize,
> +                                      unsigned long kernel_memsize,
> +                                      u32 phys_seed)
> +{
> +       efi_status_t status;
> +       u64 min_kimg_align =3D efi_get_kimg_min_align();
> +
> +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> +               /*
> +                * If KASLR is enabled, and we have some randomness avail=
able,
> +                * locate the kernel at a randomized offset in physical m=
emory.
> +                */
> +               status =3D efi_random_alloc(*reserve_size, min_kimg_align=
,
> +                                         reserve_addr, phys_seed,
> +                                         EFI_LOADER_CODE);
> +               if (status !=3D EFI_SUCCESS)
> +                       efi_warn("efi_random_alloc() failed: 0x%lx\n", st=
atus);
> +       } else {
> +               status =3D EFI_OUT_OF_RESOURCES;
> +       }
> +
> +       if (status !=3D EFI_SUCCESS) {
> +               if (!check_image_region(*image_addr, kernel_memsize)) {
> +                       efi_err("FIRMWARE BUG: Image BSS overlaps adjacen=
t EFI memory region\n");
> +               } else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> +                          (u64)_end < EFI_ALLOC_LIMIT) {
> +                       /*
> +                        * Just execute from wherever we were loaded by t=
he
> +                        * UEFI PE/COFF loader if the placement is suitab=
le.
> +                        */
> +                       *reserve_size =3D 0;
> +                       return EFI_SUCCESS;
> +               }
> +
> +               status =3D efi_allocate_pages_aligned(*reserve_size, rese=
rve_addr,
> +                                                   ULONG_MAX, min_kimg_a=
lign,
> +                                                   EFI_LOADER_CODE);
> +
> +               if (status !=3D EFI_SUCCESS) {
> +                       efi_err("Failed to relocate kernel\n");
> +                       *reserve_size =3D 0;
> +                       return status;
> +               }
> +       }
> +
> +       memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
> +       *image_addr =3D *reserve_addr;
> +       efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
> +       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> +
> +       return status;
> +}
> --
> 2.39.2
>
