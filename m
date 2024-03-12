Return-Path: <linux-kernel+bounces-99762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00603878CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0CEB20F42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C7679CF;
	Tue, 12 Mar 2024 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuGmrAb4"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF217F7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209952; cv=none; b=hGzuU1BGoHysuJ3iKE1nOuHHpeBd74ZthEiAGdEHrIvXI321ijOnQUanJ0GuDbiicWjHCX4HxVEWgLJfvfYVWZ1t3Az/6vVGhDPyOszsZT2jbqJO7CnPUtgDfGCcFj2MYh2EQm4IpHcGYN8HLPredCjO3qKeWQIT1lTGq6kb3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209952; c=relaxed/simple;
	bh=e4g2bJh7NxPEGH23eOe78ek1Z3f0i3LOLgAMBYqbcH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kltvKU8Xqw8y0CzpWsX0l51AoClrk3+E4ojooOWFZLm5I5V/G8xcBPUO3zbDEl+LAMNV6sG2wKeaH/XAPC3QQA0x8YKwU30RApvaJm3c+WLR2jPlTkL0bTKzHO7kmZcYNY0UaR1qetWsNnV6PLbaSp/knMxbVbJnuVqJ7qNCILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuGmrAb4; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42ee0c326e8so129921cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710209949; x=1710814749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v77WWzFMcnosNbAEHSeRCbxu3xI8ALr6nOdZX/Uz5mA=;
        b=CuGmrAb4eJslY7Dwxc77tRB47869L6uhSj9IMhbk5Z81G64sgfGLqhO4wZ9NIyGEaV
         1CdJD7iRPZ8GYs30JojAOz7TPFrQPpB5KtCo+nm596DOM/fD1M238LZ+zRVIDJpd+mLh
         JDVXXcLBsjediOiF+RVG95mSp2y5oi0UesT3HkOiBBDUzfX3Gbx4fwM53NUisfEZoo6l
         Q/hnikZa3wxrm5tBUdkhGgN7Lxkdbi7o4yF1jx5mvRP/GBOe8AhyBG6XkswHhT0Zt/T5
         mgMZL47SzvFlTF6zahMKPAyvYQS1qSv4TGwk6FjROsvDOT+5OnSjhFB5zmNfTC6jPTSE
         lj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710209949; x=1710814749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v77WWzFMcnosNbAEHSeRCbxu3xI8ALr6nOdZX/Uz5mA=;
        b=ndPz2LlnDcW+/bN2z9fhfrGgIRSM+UJIDP38H32NivJ7Ow0FlItr7nyTLmIIYv7C6c
         /dQoMPF72v3Jm3uGUZrOrpr7waGJCSz92eyx3fy+xGwjA48bEimrhiMJ2X17t5fIkWev
         TkLtejNVyGWul9YsFWrNYX/NDcQ9INo6E3RTAZ/QQTva8HBLb2DWoJZg+cHUimTGFEtz
         n375UIIH140PvlujO8w64SFPhsIQ/Hlll3tcuxCjZI6paB9ewwtXLmIAP+Doj3bI/9Te
         s4T0iZNRDL438VayRb2LSpC751MZgc9mGWAxqzDFu//R5gJhoU0vPDrBKiQMQnXy1yRi
         Hrhg==
X-Forwarded-Encrypted: i=1; AJvYcCVNzrf5BjSiE9XZn5RgoUigndR1JjBy30ivLesJpzPk+ojLwgaR7Lt9LX2EnftsEu1sT932K2Hzbw2dnU/Rk4jJaM8Umc11vkdDbYwQ
X-Gm-Message-State: AOJu0YyVLYno1ZOMWYoJqW00vHpw+xZ9A/mz8PfuXDCSo132eYN3gFEG
	to38D4vy9O45oaWHM9bxtb2iwdl4OwC520DhIAgIe9/vwAVp8VrMg3iie+d008pelOfOIJS5G59
	Jgw4xAQ9ttj1lt8vxwcpVI392CToGMIOW2OqM
X-Google-Smtp-Source: AGHT+IGWuCZqKoHoOSvPzMltWG+kP10IbpDe0puHVcoZ+3hcUgwKjQe6ptuH2644hqZMhFBfbtBbOVe6LtirzVqd+GQ=
X-Received: by 2002:ac8:7a91:0:b0:42f:a3c:2d44 with SMTP id
 x17-20020ac87a91000000b0042f0a3c2d44mr76537qtr.5.1710209948923; Mon, 11 Mar
 2024 19:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311181303.1516514-2-robh@kernel.org>
In-Reply-To: <20240311181303.1516514-2-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 11 Mar 2024 19:18:30 -0700
Message-ID: <CAGETcx_fSWv-CeOTnWTq4yGPg8BgHsRZQfPa_fcbMZnaTEJBtQ@mail.gmail.com>
Subject: Re: [PATCH] of: Move all FDT reserved-memory handling into of_reserved_mem.c
To: Rob Herring <robh@kernel.org>
Cc: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:14=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> The split of /reserved-memory handling between fdt.c and
> of_reserved_mem.c makes for reading and restructuring the code
> difficult. As of_reserved_mem.c is only built for
> CONFIG_OF_EARLY_FLATTREE already, move all the code to one spot.

I'm assuming this is a clean copy-paste with maybe some
addition/removal of static keywords.

With that,
Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Oreoluwa, Please rebase your series on top of this.
>
>  drivers/of/fdt.c             | 123 +---------------------------------
>  drivers/of/of_private.h      |   5 +-
>  drivers/of/of_reserved_mem.c | 125 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 127 insertions(+), 126 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index e5a385285149..a8a04f27915b 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -17,7 +17,6 @@
>  #include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> -#include <linux/of_reserved_mem.h>
>  #include <linux/sizes.h>
>  #include <linux/string.h>
>  #include <linux/errno.h>
> @@ -88,7 +87,7 @@ void __init of_fdt_limit_memory(int limit)
>         }
>  }
>
> -static bool of_fdt_device_is_available(const void *blob, unsigned long n=
ode)
> +bool of_fdt_device_is_available(const void *blob, unsigned long node)
>  {
>         const char *status =3D fdt_getprop(blob, node, "status", NULL);
>
> @@ -484,126 +483,6 @@ void *initial_boot_params __ro_after_init;
>
>  static u32 of_fdt_crc32;
>
> -static int __init early_init_dt_reserve_memory(phys_addr_t base,
> -                                              phys_addr_t size, bool nom=
ap)
> -{
> -       if (nomap) {
> -               /*
> -                * If the memory is already reserved (by another region),=
 we
> -                * should not allow it to be marked nomap, but don't worr=
y
> -                * if the region isn't memory as it won't be mapped.
> -                */
> -               if (memblock_overlaps_region(&memblock.memory, base, size=
) &&
> -                   memblock_is_region_reserved(base, size))
> -                       return -EBUSY;
> -
> -               return memblock_mark_nomap(base, size);
> -       }
> -       return memblock_reserve(base, size);
> -}
> -
> -/*
> - * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' =
property
> - */
> -static int __init __reserved_mem_reserve_reg(unsigned long node,
> -                                            const char *uname)
> -{
> -       int t_len =3D (dt_root_addr_cells + dt_root_size_cells) * sizeof(=
__be32);
> -       phys_addr_t base, size;
> -       int len;
> -       const __be32 *prop;
> -       int first =3D 1;
> -       bool nomap;
> -
> -       prop =3D of_get_flat_dt_prop(node, "reg", &len);
> -       if (!prop)
> -               return -ENOENT;
> -
> -       if (len && len % t_len !=3D 0) {
> -               pr_err("Reserved memory: invalid reg property in '%s', sk=
ipping node.\n",
> -                      uname);
> -               return -EINVAL;
> -       }
> -
> -       nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D NULL;
> -
> -       while (len >=3D t_len) {
> -               base =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
> -               size =3D dt_mem_next_cell(dt_root_size_cells, &prop);
> -
> -               if (size &&
> -                   early_init_dt_reserve_memory(base, size, nomap) =3D=
=3D 0)
> -                       pr_debug("Reserved memory: reserved region for no=
de '%s': base %pa, size %lu MiB\n",
> -                               uname, &base, (unsigned long)(size / SZ_1=
M));
> -               else
> -                       pr_err("Reserved memory: failed to reserve memory=
 for node '%s': base %pa, size %lu MiB\n",
> -                              uname, &base, (unsigned long)(size / SZ_1M=
));
> -
> -               len -=3D t_len;
> -               if (first) {
> -                       fdt_reserved_mem_save_node(node, uname, base, siz=
e);
> -                       first =3D 0;
> -               }
> -       }
> -       return 0;
> -}
> -
> -/*
> - * __reserved_mem_check_root() - check if #size-cells, #address-cells pr=
ovided
> - * in /reserved-memory matches the values supported by the current imple=
mentation,
> - * also check if ranges property has been provided
> - */
> -static int __init __reserved_mem_check_root(unsigned long node)
> -{
> -       const __be32 *prop;
> -
> -       prop =3D of_get_flat_dt_prop(node, "#size-cells", NULL);
> -       if (!prop || be32_to_cpup(prop) !=3D dt_root_size_cells)
> -               return -EINVAL;
> -
> -       prop =3D of_get_flat_dt_prop(node, "#address-cells", NULL);
> -       if (!prop || be32_to_cpup(prop) !=3D dt_root_addr_cells)
> -               return -EINVAL;
> -
> -       prop =3D of_get_flat_dt_prop(node, "ranges", NULL);
> -       if (!prop)
> -               return -EINVAL;
> -       return 0;
> -}
> -
> -/*
> - * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
> - */
> -static int __init fdt_scan_reserved_mem(void)
> -{
> -       int node, child;
> -       const void *fdt =3D initial_boot_params;
> -
> -       node =3D fdt_path_offset(fdt, "/reserved-memory");
> -       if (node < 0)
> -               return -ENODEV;
> -
> -       if (__reserved_mem_check_root(node) !=3D 0) {
> -               pr_err("Reserved memory: unsupported node format, ignorin=
g\n");
> -               return -EINVAL;
> -       }
> -
> -       fdt_for_each_subnode(child, fdt, node) {
> -               const char *uname;
> -               int err;
> -
> -               if (!of_fdt_device_is_available(fdt, child))
> -                       continue;
> -
> -               uname =3D fdt_get_name(fdt, child, NULL);
> -
> -               err =3D __reserved_mem_reserve_reg(child, uname);
> -               if (err =3D=3D -ENOENT && of_get_flat_dt_prop(child, "siz=
e", NULL))
> -                       fdt_reserved_mem_save_node(child, uname, 0, 0);
> -       }
> -       return 0;
> -}
> -
>  /*
>   * fdt_reserve_elfcorehdr() - reserves memory for elf core header
>   *
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f38397c7b582..485483524b7f 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -175,8 +175,9 @@ static inline struct device_node *__of_get_dma_parent=
(const struct device_node *
>  }
>  #endif
>
> +int fdt_scan_reserved_mem(void);
>  void fdt_init_reserved_mem(void);
> -void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
> -                              phys_addr_t base, phys_addr_t size);
> +
> +bool of_fdt_device_is_available(const void *blob, unsigned long node);
>
>  #endif /* _LINUX_OF_PRIVATE_H */
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 7ec94cfcbddb..8236ecae2953 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -12,6 +12,7 @@
>  #define pr_fmt(fmt)    "OF: reserved mem: " fmt
>
>  #include <linux/err.h>
> +#include <linux/libfdt.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> @@ -58,8 +59,8 @@ static int __init early_init_dt_alloc_reserved_memory_a=
rch(phys_addr_t size,
>  /*
>   * fdt_reserved_mem_save_node() - save fdt node for second pass initiali=
zation
>   */
> -void __init fdt_reserved_mem_save_node(unsigned long node, const char *u=
name,
> -                                     phys_addr_t base, phys_addr_t size)
> +static void __init fdt_reserved_mem_save_node(unsigned long node, const =
char *uname,
> +                                             phys_addr_t base, phys_addr=
_t size)
>  {
>         struct reserved_mem *rmem =3D &reserved_mem[reserved_mem_count];
>
> @@ -77,6 +78,126 @@ void __init fdt_reserved_mem_save_node(unsigned long =
node, const char *uname,
>         return;
>  }
>
> +static int __init early_init_dt_reserve_memory(phys_addr_t base,
> +                                              phys_addr_t size, bool nom=
ap)
> +{
> +       if (nomap) {
> +               /*
> +                * If the memory is already reserved (by another region),=
 we
> +                * should not allow it to be marked nomap, but don't worr=
y
> +                * if the region isn't memory as it won't be mapped.
> +                */
> +               if (memblock_overlaps_region(&memblock.memory, base, size=
) &&
> +                   memblock_is_region_reserved(base, size))
> +                       return -EBUSY;
> +
> +               return memblock_mark_nomap(base, size);
> +       }
> +       return memblock_reserve(base, size);
> +}
> +
> +/*
> + * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' =
property
> + */
> +static int __init __reserved_mem_reserve_reg(unsigned long node,
> +                                            const char *uname)
> +{
> +       int t_len =3D (dt_root_addr_cells + dt_root_size_cells) * sizeof(=
__be32);
> +       phys_addr_t base, size;
> +       int len;
> +       const __be32 *prop;
> +       int first =3D 1;
> +       bool nomap;
> +
> +       prop =3D of_get_flat_dt_prop(node, "reg", &len);
> +       if (!prop)
> +               return -ENOENT;
> +
> +       if (len && len % t_len !=3D 0) {
> +               pr_err("Reserved memory: invalid reg property in '%s', sk=
ipping node.\n",
> +                      uname);
> +               return -EINVAL;
> +       }
> +
> +       nomap =3D of_get_flat_dt_prop(node, "no-map", NULL) !=3D NULL;
> +
> +       while (len >=3D t_len) {
> +               base =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
> +               size =3D dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +               if (size &&
> +                   early_init_dt_reserve_memory(base, size, nomap) =3D=
=3D 0)
> +                       pr_debug("Reserved memory: reserved region for no=
de '%s': base %pa, size %lu MiB\n",
> +                               uname, &base, (unsigned long)(size / SZ_1=
M));
> +               else
> +                       pr_err("Reserved memory: failed to reserve memory=
 for node '%s': base %pa, size %lu MiB\n",
> +                              uname, &base, (unsigned long)(size / SZ_1M=
));
> +
> +               len -=3D t_len;
> +               if (first) {
> +                       fdt_reserved_mem_save_node(node, uname, base, siz=
e);
> +                       first =3D 0;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/*
> + * __reserved_mem_check_root() - check if #size-cells, #address-cells pr=
ovided
> + * in /reserved-memory matches the values supported by the current imple=
mentation,
> + * also check if ranges property has been provided
> + */
> +static int __init __reserved_mem_check_root(unsigned long node)
> +{
> +       const __be32 *prop;
> +
> +       prop =3D of_get_flat_dt_prop(node, "#size-cells", NULL);
> +       if (!prop || be32_to_cpup(prop) !=3D dt_root_size_cells)
> +               return -EINVAL;
> +
> +       prop =3D of_get_flat_dt_prop(node, "#address-cells", NULL);
> +       if (!prop || be32_to_cpup(prop) !=3D dt_root_addr_cells)
> +               return -EINVAL;
> +
> +       prop =3D of_get_flat_dt_prop(node, "ranges", NULL);
> +       if (!prop)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +/*
> + * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
> + */
> +int __init fdt_scan_reserved_mem(void)
> +{
> +       int node, child;
> +       const void *fdt =3D initial_boot_params;
> +
> +       node =3D fdt_path_offset(fdt, "/reserved-memory");
> +       if (node < 0)
> +               return -ENODEV;
> +
> +       if (__reserved_mem_check_root(node) !=3D 0) {
> +               pr_err("Reserved memory: unsupported node format, ignorin=
g\n");
> +               return -EINVAL;
> +       }
> +
> +       fdt_for_each_subnode(child, fdt, node) {
> +               const char *uname;
> +               int err;
> +
> +               if (!of_fdt_device_is_available(fdt, child))
> +                       continue;
> +
> +               uname =3D fdt_get_name(fdt, child, NULL);
> +
> +               err =3D __reserved_mem_reserve_reg(child, uname);
> +               if (err =3D=3D -ENOENT && of_get_flat_dt_prop(child, "siz=
e", NULL))
> +                       fdt_reserved_mem_save_node(child, uname, 0, 0);
> +       }
> +       return 0;
> +}
> +
>  /*
>   * __reserved_mem_alloc_in_range() - allocate reserved memory described =
with
>   *     'alloc-ranges'. Choose bottom-up/top-down depending on nearby exi=
sting
> --
> 2.43.0
>

