Return-Path: <linux-kernel+bounces-151645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC288AB184
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB811F230A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96012F599;
	Fri, 19 Apr 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWTI1MdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3212F386
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539786; cv=none; b=O5HXzt35XsLEyZdBdgmk/UpH0blTTaqm5m492726CpxgLcs+QXEtH3BR+w5EXrmtxqNkmJHevgJdXtI99ndUyNETvrc4nf31jLyCKh3Yf47zIrDrbEegEf7/6QHg3v0kKHwAhANivkv9jpIH5/71sZMCTw1fy5WUD8SVfe9OGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539786; c=relaxed/simple;
	bh=olmthu9QDF/98u0NRt1qNZexQ6+zfHKFZJ+SBz/ph/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHTzbm1jHivRvfB3cR4zNqXJw7Z43VYG3J/FWR3E6r8XDOoou0OHMW9yOPgAy5TR+mkfffPtJsrQKQqNpxhh4QjBlGMGtSH70/z4/+ljzOILfIysmczNH/ur3XEG1PKICjMjtzfzhfCkJoisEW3KxBNpLYf42Z3UYDfknKABE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWTI1MdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41505C32782
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713539786;
	bh=olmthu9QDF/98u0NRt1qNZexQ6+zfHKFZJ+SBz/ph/c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EWTI1MdRKOdPnqZBCZgAaqNUniVgPVMAOtSYaw/G62XIDHbrlU8N/+Ci/IsdSglKC
	 o+oNtzy7yP/f1B7QPObvCuPEmb5RCh7yF784qG5tT9Z3T6cY9XCa6oAlvdKVehaSNh
	 YIMNL1vcvFujZHLTHICokbWwndIleyuTSF2iTfQvyMORDMRp2qIiDkSamTzAheLVgZ
	 g+WxhvDdwB27H6/dFsHBuLD4njFypvqw0Huwuz4PPza5naHiXdo3UVNeNrs0Z5PNdx
	 eyFLYxTRLu4z9ANtDfWoreUQETrZfp5ZSwpbqT/EPJeKbHxHLrQDbWqUl72NNjO4HK
	 djwZDEh7GENCw==
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e05b1ef941so604424241.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:16:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo+JytnITBFHkDllJMfcMriDRpK5zaIwAJZmJFpbHjwwnYcJC/k2LtFKwV9fOI4orADfnHpiQH2yh90X8YlUhQOiKpV76Bnv1nz/5S
X-Gm-Message-State: AOJu0Yw/ui0pKQE2jGMI4UcLzr12M/6+DOaBXKJrdiJ4Pir0XwOMpPjk
	Eayajceh8D+vrLwkAHfFzrIoNMiQQQ1kl+PxRLSz8m+pPcZHmmzAvTVjecFFPcyhvGED7LyEK/1
	ViD3cGQKu+hG2f2OwV9+9T7MhyDs=
X-Google-Smtp-Source: AGHT+IFDOUFRn/cMqAo0RLViPVEq1HsrIu4M5Uck0HrRpHc7kpgiUqlVaJ6VHp6RVgv8xON91g6pShcj9odCgHyvwag=
X-Received: by 2002:a05:6122:918:b0:4d8:7970:28e6 with SMTP id
 j24-20020a056122091800b004d8797028e6mr2398145vka.0.1713539785319; Fri, 19 Apr
 2024 08:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419141249.609534-1-mwalle@kernel.org> <20240419141249.609534-2-mwalle@kernel.org>
In-Reply-To: <20240419141249.609534-2-mwalle@kernel.org>
From: Ricardo Ribalda Delgado <ribalda@kernel.org>
Date: Fri, 19 Apr 2024 17:16:05 +0200
X-Gmail-Original-Message-ID: <CAPybu_0j-b7v0C-9-1D2Uzb5oo+2MR+KcqOn8uWBE0RQyaGbYg@mail.gmail.com>
Message-ID: <CAPybu_0j-b7v0C-9-1D2Uzb5oo+2MR+KcqOn8uWBE0RQyaGbYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mtd: spi-nor: Remove support for Xilinx S3AN flashes
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, Marek Vasut <marex@denx.de>, 
	Alexandre Desnoyers <alex@qtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael

Thanks for the cleanup. I have pinged my previous employer and they do
not have any product in production using S3AN.
So no blockers from my side.

[ccing Marek In case he knows about other users]

Regards

On Fri, Apr 19, 2024 at 4:14=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
>
> These flashes are kind of an oddball for the very old Xilinx Spartan 3
> FPGAs to store their bitstream. More importantly, they reuse the Atmel
> JEDEC manufacturer ID and in fact the at45db081d already blocks the use
> of the 3S700AN flash chip. It's time to sunset support for these
> flashes.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Cc: Ricardo Ribalda <ribalda@kernel.org>
Acked-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/mtd/spi-nor/Makefile |   1 -
>  drivers/mtd/spi-nor/core.c   |   1 -
>  drivers/mtd/spi-nor/core.h   |   1 -
>  drivers/mtd/spi-nor/xilinx.c | 169 -----------------------------------
>  4 files changed, 172 deletions(-)
>  delete mode 100644 drivers/mtd/spi-nor/xilinx.c
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 5e68468b72fc..5dd9c35f6b6f 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -13,7 +13,6 @@ spi-nor-objs                  +=3D micron-st.o
>  spi-nor-objs                   +=3D spansion.o
>  spi-nor-objs                   +=3D sst.o
>  spi-nor-objs                   +=3D winbond.o
> -spi-nor-objs                   +=3D xilinx.o
>  spi-nor-objs                   +=3D xmc.o
>  spi-nor-$(CONFIG_DEBUG_FS)     +=3D debugfs.o
>  obj-$(CONFIG_MTD_SPI_NOR)      +=3D spi-nor.o
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 3e1f1913536b..cbe5f92eb0af 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1986,7 +1986,6 @@ static const struct spi_nor_manufacturer *manufactu=
rers[] =3D {
>         &spi_nor_spansion,
>         &spi_nor_sst,
>         &spi_nor_winbond,
> -       &spi_nor_xilinx,
>         &spi_nor_xmc,
>  };
>
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 442786685515..072c69b0d06c 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -603,7 +603,6 @@ extern const struct spi_nor_manufacturer spi_nor_st;
>  extern const struct spi_nor_manufacturer spi_nor_spansion;
>  extern const struct spi_nor_manufacturer spi_nor_sst;
>  extern const struct spi_nor_manufacturer spi_nor_winbond;
> -extern const struct spi_nor_manufacturer spi_nor_xilinx;
>  extern const struct spi_nor_manufacturer spi_nor_xmc;
>
>  extern const struct attribute_group *spi_nor_sysfs_groups[];
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> deleted file mode 100644
> index f99118c691b0..000000000000
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ /dev/null
> @@ -1,169 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2005, Intec Automation Inc.
> - * Copyright (C) 2014, Freescale Semiconductor, Inc.
> - */
> -
> -#include <linux/mtd/spi-nor.h>
> -
> -#include "core.h"
> -
> -#define XILINX_OP_SE           0x50    /* Sector erase */
> -#define XILINX_OP_PP           0x82    /* Page program */
> -#define XILINX_OP_RDSR         0xd7    /* Read status register */
> -
> -#define XSR_PAGESIZE           BIT(0)  /* Page size in Po2 or Linear */
> -#define XSR_RDY                        BIT(7)  /* Ready */
> -
> -#define XILINX_RDSR_OP(buf)                                            \
> -       SPI_MEM_OP(SPI_MEM_OP_CMD(XILINX_OP_RDSR, 0),                   \
> -                  SPI_MEM_OP_NO_ADDR,                                  \
> -                  SPI_MEM_OP_NO_DUMMY,                                 \
> -                  SPI_MEM_OP_DATA_IN(1, buf, 0))
> -
> -#define S3AN_FLASH(_id, _name, _n_sectors, _page_size)         \
> -       .id =3D _id,                                              \
> -       .name =3D _name,                                          \
> -       .size =3D 8 * (_page_size) * (_n_sectors),                \
> -       .sector_size =3D (8 * (_page_size)),                      \
> -       .page_size =3D (_page_size),                              \
> -       .flags =3D SPI_NOR_NO_FR
> -
> -/* Xilinx S3AN share MFR with Atmel SPI NOR */
> -static const struct flash_info xilinx_nor_parts[] =3D {
> -       /* Xilinx S3AN Internal Flash */
> -       { S3AN_FLASH(SNOR_ID(0x1f, 0x22, 0x00), "3S50AN", 64, 264) },
> -       { S3AN_FLASH(SNOR_ID(0x1f, 0x24, 0x00), "3S200AN", 256, 264) },
> -       { S3AN_FLASH(SNOR_ID(0x1f, 0x24, 0x00), "3S400AN", 256, 264) },
> -       { S3AN_FLASH(SNOR_ID(0x1f, 0x25, 0x00), "3S700AN", 512, 264) },
> -       { S3AN_FLASH(SNOR_ID(0x1f, 0x26, 0x00), "3S1400AN", 512, 528) },
> -};
> -
> -/*
> - * This code converts an address to the Default Address Mode, that has n=
on
> - * power of two page sizes. We must support this mode because it is the =
default
> - * mode supported by Xilinx tools, it can access the whole flash area an=
d
> - * changing over to the Power-of-two mode is irreversible and corrupts t=
he
> - * original data.
> - * Addr can safely be unsigned int, the biggest S3AN device is smaller t=
han
> - * 4 MiB.
> - */
> -static u32 s3an_nor_convert_addr(struct spi_nor *nor, u32 addr)
> -{
> -       u32 page_size =3D nor->params->page_size;
> -       u32 offset, page;
> -
> -       offset =3D addr % page_size;
> -       page =3D addr / page_size;
> -       page <<=3D (page_size > 512) ? 10 : 9;
> -
> -       return page | offset;
> -}
> -
> -/**
> - * xilinx_nor_read_sr() - Read the Status Register on S3AN flashes.
> - * @nor:       pointer to 'struct spi_nor'.
> - * @sr:                pointer to a DMA-able buffer where the value of t=
he
> - *              Status Register will be written.
> - *
> - * Return: 0 on success, -errno otherwise.
> - */
> -static int xilinx_nor_read_sr(struct spi_nor *nor, u8 *sr)
> -{
> -       int ret;
> -
> -       if (nor->spimem) {
> -               struct spi_mem_op op =3D XILINX_RDSR_OP(sr);
> -
> -               spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
> -
> -               ret =3D spi_mem_exec_op(nor->spimem, &op);
> -       } else {
> -               ret =3D spi_nor_controller_ops_read_reg(nor, XILINX_OP_RD=
SR, sr,
> -                                                     1);
> -       }
> -
> -       if (ret)
> -               dev_dbg(nor->dev, "error %d reading SR\n", ret);
> -
> -       return ret;
> -}
> -
> -/**
> - * xilinx_nor_sr_ready() - Query the Status Register of the S3AN flash t=
o see
> - * if the flash is ready for new commands.
> - * @nor:       pointer to 'struct spi_nor'.
> - *
> - * Return: 1 if ready, 0 if not ready, -errno on errors.
> - */
> -static int xilinx_nor_sr_ready(struct spi_nor *nor)
> -{
> -       int ret;
> -
> -       ret =3D xilinx_nor_read_sr(nor, nor->bouncebuf);
> -       if (ret)
> -               return ret;
> -
> -       return !!(nor->bouncebuf[0] & XSR_RDY);
> -}
> -
> -static int xilinx_nor_setup(struct spi_nor *nor,
> -                           const struct spi_nor_hwcaps *hwcaps)
> -{
> -       u32 page_size;
> -       int ret;
> -
> -       ret =3D xilinx_nor_read_sr(nor, nor->bouncebuf);
> -       if (ret)
> -               return ret;
> -
> -       nor->erase_opcode =3D XILINX_OP_SE;
> -       nor->program_opcode =3D XILINX_OP_PP;
> -       nor->read_opcode =3D SPINOR_OP_READ;
> -       nor->flags |=3D SNOR_F_NO_OP_CHIP_ERASE;
> -
> -       /*
> -        * This flashes have a page size of 264 or 528 bytes (known as
> -        * Default addressing mode). It can be changed to a more standard
> -        * Power of two mode where the page size is 256/512. This comes
> -        * with a price: there is 3% less of space, the data is corrupted
> -        * and the page size cannot be changed back to default addressing
> -        * mode.
> -        *
> -        * The current addressing mode can be read from the XRDSR registe=
r
> -        * and should not be changed, because is a destructive operation.
> -        */
> -       if (nor->bouncebuf[0] & XSR_PAGESIZE) {
> -               /* Flash in Power of 2 mode */
> -               page_size =3D (nor->params->page_size =3D=3D 264) ? 256 :=
 512;
> -               nor->params->page_size =3D page_size;
> -               nor->mtd.writebufsize =3D page_size;
> -               nor->params->size =3D nor->info->size;
> -               nor->mtd.erasesize =3D 8 * page_size;
> -       } else {
> -               /* Flash in Default addressing mode */
> -               nor->params->convert_addr =3D s3an_nor_convert_addr;
> -               nor->mtd.erasesize =3D nor->info->sector_size;
> -       }
> -
> -       return 0;
> -}
> -
> -static int xilinx_nor_late_init(struct spi_nor *nor)
> -{
> -       nor->params->setup =3D xilinx_nor_setup;
> -       nor->params->ready =3D xilinx_nor_sr_ready;
> -
> -       return 0;
> -}
> -
> -static const struct spi_nor_fixups xilinx_nor_fixups =3D {
> -       .late_init =3D xilinx_nor_late_init,
> -};
> -
> -const struct spi_nor_manufacturer spi_nor_xilinx =3D {
> -       .name =3D "xilinx",
> -       .parts =3D xilinx_nor_parts,
> -       .nparts =3D ARRAY_SIZE(xilinx_nor_parts),
> -       .fixups =3D &xilinx_nor_fixups,
> -};
> --
> 2.39.2
>

