Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750FE798568
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbjIHKDx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbjIHKDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:03:52 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A521FFE;
        Fri,  8 Sep 2023 03:03:12 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qeYK4-000dUM-Dd; Fri, 08 Sep 2023 12:02:44 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qeYK4-001oTt-5n; Fri, 08 Sep 2023 12:02:44 +0200
Message-ID: <ccc6ffe19179f2a368b86997313270f529e472aa.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sh: remove superhyway bus support
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 08 Sep 2023 12:02:43 +0200
In-Reply-To: <20230802184849.1019466-3-arnd@kernel.org>
References: <20230802184849.1019466-1-arnd@kernel.org>
         <20230802184849.1019466-3-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 20:48 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> superhyway was only referenced on sh4-202, which is now gone, so remove
> it all as well.
> 
> I could find no trace of anything ever calling
> superhyway_register_driver(), not in the git history but also not on the
> web, so I assume this has never served any purpose on mainline kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/arch/sh/index.rst          |   6 -
>  arch/sh/Kconfig                          |   4 -
>  arch/sh/drivers/Makefile                 |   1 -
>  arch/sh/drivers/superhyway/Makefile      |   7 -
>  arch/sh/drivers/superhyway/ops-sh4-202.c | 168 ----------------
>  drivers/sh/Makefile                      |   1 -
>  drivers/sh/superhyway/Makefile           |   8 -
>  drivers/sh/superhyway/superhyway-sysfs.c |  54 ------
>  drivers/sh/superhyway/superhyway.c       | 234 -----------------------
>  include/linux/superhyway.h               | 107 -----------
>  10 files changed, 590 deletions(-)
>  delete mode 100644 arch/sh/drivers/superhyway/Makefile
>  delete mode 100644 arch/sh/drivers/superhyway/ops-sh4-202.c
>  delete mode 100644 drivers/sh/superhyway/Makefile
>  delete mode 100644 drivers/sh/superhyway/superhyway-sysfs.c
>  delete mode 100644 drivers/sh/superhyway/superhyway.c
>  delete mode 100644 include/linux/superhyway.h
> 
> diff --git a/Documentation/arch/sh/index.rst b/Documentation/arch/sh/index.rst
> index c64776738cf6b..01fce7c131f13 100644
> --- a/Documentation/arch/sh/index.rst
> +++ b/Documentation/arch/sh/index.rst
> @@ -43,12 +43,6 @@ mach-x3proto
>  Busses
>  ======
>  
> -SuperHyway
> -----------
> -
> -.. kernel-doc:: drivers/sh/superhyway/superhyway.c
> -   :export:
> -
>  Maple
>  -----
>  
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d785329e57151..7500521b2b984 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -737,10 +737,6 @@ endmenu
>  
>  menu "Bus options"
>  
> -config SUPERHYWAY
> -	tristate "SuperHyway Bus support"
> -	depends on CPU_SUBTYPE_SH4_202
> -
>  config MAPLE
>  	bool "Maple Bus support"
>  	depends on SH_DREAMCAST
> diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
> index 56b0acace6e7c..8bd10b904bf93 100644
> --- a/arch/sh/drivers/Makefile
> +++ b/arch/sh/drivers/Makefile
> @@ -6,6 +6,5 @@
>  obj-y		+= dma/ platform_early.o
>  
>  obj-$(CONFIG_PCI)		+= pci/
> -obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
>  obj-$(CONFIG_PUSH_SWITCH)	+= push-switch.o
>  obj-$(CONFIG_HEARTBEAT)		+= heartbeat.o
> diff --git a/arch/sh/drivers/superhyway/Makefile b/arch/sh/drivers/superhyway/Makefile
> deleted file mode 100644
> index aa6e3267c055d..0000000000000
> --- a/arch/sh/drivers/superhyway/Makefile
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for the SuperHyway specific kernel interface routines under Linux.
> -#
> -
> -obj-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= ops-sh4-202.o
> -
> diff --git a/arch/sh/drivers/superhyway/ops-sh4-202.c b/arch/sh/drivers/superhyway/ops-sh4-202.c
> deleted file mode 100644
> index 490142274e3b0..0000000000000
> --- a/arch/sh/drivers/superhyway/ops-sh4-202.c
> +++ /dev/null
> @@ -1,168 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * arch/sh/drivers/superhyway/ops-sh4-202.c
> - *
> - * SuperHyway bus support for SH4-202
> - *
> - * Copyright (C) 2005  Paul Mundt
> - */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/superhyway.h>
> -#include <linux/string.h>
> -#include <asm/addrspace.h>
> -#include <asm/io.h>
> -
> -#define PHYS_EMI_CBLOCK		P4SEGADDR(0x1ec00000)
> -#define PHYS_EMI_DBLOCK		P4SEGADDR(0x08000000)
> -#define PHYS_FEMI_CBLOCK	P4SEGADDR(0x1f800000)
> -#define PHYS_FEMI_DBLOCK	P4SEGADDR(0x00000000)
> -
> -#define PHYS_EPBR_BLOCK		P4SEGADDR(0x1de00000)
> -#define PHYS_DMAC_BLOCK		P4SEGADDR(0x1fa00000)
> -#define PHYS_PBR_BLOCK		P4SEGADDR(0x1fc00000)
> -
> -static struct resource emi_resources[] = {
> -	[0] = {
> -		.start	= PHYS_EMI_CBLOCK,
> -		.end	= PHYS_EMI_CBLOCK + 0x00300000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_EMI_DBLOCK,
> -		.end	= PHYS_EMI_DBLOCK + 0x08000000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device emi_device = {
> -	.name		= "emi",
> -	.num_resources	= ARRAY_SIZE(emi_resources),
> -	.resource	= emi_resources,
> -};
> -
> -static struct resource femi_resources[] = {
> -	[0] = {
> -		.start	= PHYS_FEMI_CBLOCK,
> -		.end	= PHYS_FEMI_CBLOCK + 0x00100000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_FEMI_DBLOCK,
> -		.end	= PHYS_FEMI_DBLOCK + 0x08000000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device femi_device = {
> -	.name		= "femi",
> -	.num_resources	= ARRAY_SIZE(femi_resources),
> -	.resource	= femi_resources,
> -};
> -
> -static struct resource epbr_resources[] = {
> -	[0] = {
> -		.start	= P4SEGADDR(0x1e7ffff8),
> -		.end	= P4SEGADDR(0x1e7ffff8 + (sizeof(u32) * 2) - 1),
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_EPBR_BLOCK,
> -		.end	= PHYS_EPBR_BLOCK + 0x00a00000 - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device epbr_device = {
> -	.name		= "epbr",
> -	.num_resources	= ARRAY_SIZE(epbr_resources),
> -	.resource	= epbr_resources,
> -};
> -
> -static struct resource dmac_resource = {
> -	.start	= PHYS_DMAC_BLOCK,
> -	.end	= PHYS_DMAC_BLOCK + 0x00100000 - 1,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -static struct superhyway_device dmac_device = {
> -	.name		= "dmac",
> -	.num_resources	= 1,
> -	.resource	= &dmac_resource,
> -};
> -
> -static struct resource pbr_resources[] = {
> -	[0] = {
> -		.start	= P4SEGADDR(0x1ffffff8),
> -		.end	= P4SEGADDR(0x1ffffff8 + (sizeof(u32) * 2) - 1),
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	[1] = {
> -		.start	= PHYS_PBR_BLOCK,
> -		.end	= PHYS_PBR_BLOCK + 0x00400000 - (sizeof(u32) * 2) - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -};
> -
> -static struct superhyway_device pbr_device = {
> -	.name		= "pbr",
> -	.num_resources	= ARRAY_SIZE(pbr_resources),
> -	.resource	= pbr_resources,
> -};
> -
> -static struct superhyway_device *sh4202_devices[] __initdata = {
> -	&emi_device, &femi_device, &epbr_device, &dmac_device, &pbr_device,
> -};
> -
> -static int sh4202_read_vcr(unsigned long base, struct superhyway_vcr_info *vcr)
> -{
> -	u32 vcrh, vcrl;
> -	u64 tmp;
> -
> -	/*
> -	 * XXX: Even though the SH4-202 Evaluation Device documentation
> -	 * indicates that VCRL is mapped first with VCRH at a + 0x04
> -	 * offset, the opposite seems to be true.
> -	 *
> -	 * Some modules (PBR and ePBR for instance) also appear to have
> -	 * VCRL/VCRH flipped in the documentation, but on the SH4-202
> -	 * itself it appears that these are all consistently mapped with
> -	 * VCRH preceding VCRL.
> -	 *
> -	 * Do not trust the documentation, for it is evil.
> -	 */
> -	vcrh = __raw_readl(base);
> -	vcrl = __raw_readl(base + sizeof(u32));
> -
> -	tmp = ((u64)vcrh << 32) | vcrl;
> -	memcpy(vcr, &tmp, sizeof(u64));
> -
> -	return 0;
> -}
> -
> -static int sh4202_write_vcr(unsigned long base, struct superhyway_vcr_info vcr)
> -{
> -	u64 tmp = *(u64 *)&vcr;
> -
> -	__raw_writel((tmp >> 32) & 0xffffffff, base);
> -	__raw_writel(tmp & 0xffffffff, base + sizeof(u32));
> -
> -	return 0;
> -}
> -
> -static struct superhyway_ops sh4202_superhyway_ops = {
> -	.read_vcr	= sh4202_read_vcr,
> -	.write_vcr	= sh4202_write_vcr,
> -};
> -
> -struct superhyway_bus superhyway_channels[] = {
> -	{ &sh4202_superhyway_ops, },
> -	{ 0, },
> -};
> -
> -int __init superhyway_scan_bus(struct superhyway_bus *bus)
> -{
> -	return superhyway_add_devices(bus, sh4202_devices,
> -				      ARRAY_SIZE(sh4202_devices));
> -}
> -
> diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
> index c53262835e85e..0aa152b1587ad 100644
> --- a/drivers/sh/Makefile
> +++ b/drivers/sh/Makefile
> @@ -7,6 +7,5 @@ ifneq ($(CONFIG_COMMON_CLK),y)
>  obj-$(CONFIG_HAVE_CLK)			+= clk/
>  endif
>  obj-$(CONFIG_MAPLE)			+= maple/
> -obj-$(CONFIG_SUPERHYWAY)		+= superhyway/
>  
>  obj-y					+= pm_runtime.o
> diff --git a/drivers/sh/superhyway/Makefile b/drivers/sh/superhyway/Makefile
> deleted file mode 100644
> index 6dfa41f160af6..0000000000000
> --- a/drivers/sh/superhyway/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile for the SuperHyway bus drivers.
> -#
> -
> -obj-$(CONFIG_SUPERHYWAY)	+= superhyway.o
> -obj-$(CONFIG_SYSFS)		+= superhyway-sysfs.o
> -
> diff --git a/drivers/sh/superhyway/superhyway-sysfs.c b/drivers/sh/superhyway/superhyway-sysfs.c
> deleted file mode 100644
> index 774f31b564f8f..0000000000000
> --- a/drivers/sh/superhyway/superhyway-sysfs.c
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - * drivers/sh/superhyway/superhyway-sysfs.c
> - *
> - * SuperHyway Bus sysfs interface
> - *
> - * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/types.h>
> -#include <linux/superhyway.h>
> -
> -#define superhyway_ro_attr(name, fmt, field)				\
> -static ssize_t name##_show(struct device *dev, struct device_attribute *attr, char *buf)		\
> -{									\
> -	struct superhyway_device *s = to_superhyway_device(dev);	\
> -	return sprintf(buf, fmt, s->field);				\
> -}									\
> -static DEVICE_ATTR_RO(name);
> -
> -/* VCR flags */
> -superhyway_ro_attr(perr_flags, "0x%02x\n", vcr.perr_flags);
> -superhyway_ro_attr(merr_flags, "0x%02x\n", vcr.merr_flags);
> -superhyway_ro_attr(mod_vers, "0x%04x\n", vcr.mod_vers);
> -superhyway_ro_attr(mod_id, "0x%04x\n", vcr.mod_id);
> -superhyway_ro_attr(bot_mb, "0x%02x\n", vcr.bot_mb);
> -superhyway_ro_attr(top_mb, "0x%02x\n", vcr.top_mb);
> -
> -/* Misc */
> -superhyway_ro_attr(resource, "0x%08lx\n", resource[0].start);
> -
> -static struct attribute *superhyway_dev_attrs[] = {
> -	&dev_attr_perr_flags.attr,
> -	&dev_attr_merr_flags.attr,
> -	&dev_attr_mod_vers.attr,
> -	&dev_attr_mod_id.attr,
> -	&dev_attr_bot_mb.attr,
> -	&dev_attr_top_mb.attr,
> -	&dev_attr_resource.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group superhyway_dev_group = {
> -	.attrs = superhyway_dev_attrs,
> -};
> -
> -const struct attribute_group *superhyway_dev_groups[] = {
> -	&superhyway_dev_group,
> -	NULL,
> -};
> diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
> deleted file mode 100644
> index 44324abe21dad..0000000000000
> --- a/drivers/sh/superhyway/superhyway.c
> +++ /dev/null
> @@ -1,234 +0,0 @@
> -/*
> - * drivers/sh/superhyway/superhyway.c
> - *
> - * SuperHyway Bus Driver
> - *
> - * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#include <linux/kernel.h>
> -#include <linux/device.h>
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/list.h>
> -#include <linux/superhyway.h>
> -#include <linux/string.h>
> -#include <linux/slab.h>
> -
> -static int superhyway_devices;
> -
> -static struct device superhyway_bus_device = {
> -	.init_name = "superhyway",
> -};
> -
> -static void superhyway_device_release(struct device *dev)
> -{
> -	struct superhyway_device *sdev = to_superhyway_device(dev);
> -
> -	kfree(sdev->resource);
> -	kfree(sdev);
> -}
> -
> -/**
> - * superhyway_add_device - Add a SuperHyway module
> - * @base: Physical address where module is mapped.
> - * @sdev: SuperHyway device to add, or NULL to allocate a new one.
> - * @bus: Bus where SuperHyway module resides.
> - *
> - * This is responsible for adding a new SuperHyway module. This sets up a new
> - * struct superhyway_device for the module being added if @sdev == NULL.
> - *
> - * Devices are initially added in the order that they are scanned (from the
> - * top-down of the memory map), and are assigned an ID based on the order that
> - * they are added. Any manual addition of a module will thus get the ID after
> - * the devices already discovered regardless of where it resides in memory.
> - *
> - * Further work can and should be done in superhyway_scan_bus(), to be sure
> - * that any new modules are properly discovered and subsequently registered.
> - */
> -int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
> -			  struct superhyway_bus *bus)
> -{
> -	struct superhyway_device *dev = sdev;
> -
> -	if (!dev) {
> -		dev = kzalloc(sizeof(struct superhyway_device), GFP_KERNEL);
> -		if (!dev)
> -			return -ENOMEM;
> -
> -	}
> -
> -	dev->bus = bus;
> -	superhyway_read_vcr(dev, base, &dev->vcr);
> -
> -	if (!dev->resource) {
> -		dev->resource = kzalloc(sizeof(struct resource), GFP_KERNEL);
> -		if (!dev->resource) {
> -			kfree(dev);
> -			return -ENOMEM;
> -		}
> -
> -		dev->resource->name	= dev->name;
> -		dev->resource->start	= base;
> -		dev->resource->end	= dev->resource->start + 0x01000000;
> -	}
> -
> -	dev->dev.parent		= &superhyway_bus_device;
> -	dev->dev.bus		= &superhyway_bus_type;
> -	dev->dev.release	= superhyway_device_release;
> -	dev->id.id		= dev->vcr.mod_id;
> -
> -	sprintf(dev->name, "SuperHyway device %04x", dev->id.id);
> -	dev_set_name(&dev->dev, "%02x", superhyway_devices);
> -
> -	superhyway_devices++;
> -
> -	return device_register(&dev->dev);
> -}
> -
> -int superhyway_add_devices(struct superhyway_bus *bus,
> -			   struct superhyway_device **devices,
> -			   int nr_devices)
> -{
> -	int i, ret = 0;
> -
> -	for (i = 0; i < nr_devices; i++) {
> -		struct superhyway_device *dev = devices[i];
> -		ret |= superhyway_add_device(dev->resource[0].start, dev, bus);
> -	}
> -
> -	return ret;
> -}
> -
> -static int __init superhyway_init(void)
> -{
> -	struct superhyway_bus *bus;
> -	int ret;
> -
> -	ret = device_register(&superhyway_bus_device);
> -	if (unlikely(ret))
> -		return ret;
> -
> -	for (bus = superhyway_channels; bus->ops; bus++)
> -		ret |= superhyway_scan_bus(bus);
> -
> -	return ret;
> -}
> -postcore_initcall(superhyway_init);
> -
> -static const struct superhyway_device_id *
> -superhyway_match_id(const struct superhyway_device_id *ids,
> -		    struct superhyway_device *dev)
> -{
> -	while (ids->id) {
> -		if (ids->id == dev->id.id)
> -			return ids;
> -
> -		ids++;
> -	}
> -
> -	return NULL;
> -}
> -
> -static int superhyway_device_probe(struct device *dev)
> -{
> -	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
> -	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
> -
> -	if (shyway_drv && shyway_drv->probe) {
> -		const struct superhyway_device_id *id;
> -
> -		id = superhyway_match_id(shyway_drv->id_table, shyway_dev);
> -		if (id)
> -			return shyway_drv->probe(shyway_dev, id);
> -	}
> -
> -	return -ENODEV;
> -}
> -
> -static void superhyway_device_remove(struct device *dev)
> -{
> -	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
> -	struct superhyway_driver *shyway_drv = to_superhyway_driver(dev->driver);
> -
> -	if (shyway_drv->remove)
> -		shyway_drv->remove(shyway_dev);
> -}
> -
> -/**
> - * superhyway_register_driver - Register a new SuperHyway driver
> - * @drv: SuperHyway driver to register.
> - *
> - * This registers the passed in @drv. Any devices matching the id table will
> - * automatically be populated and handed off to the driver's specified probe
> - * routine.
> - */
> -int superhyway_register_driver(struct superhyway_driver *drv)
> -{
> -	drv->drv.name	= drv->name;
> -	drv->drv.bus	= &superhyway_bus_type;
> -
> -	return driver_register(&drv->drv);
> -}
> -
> -/**
> - * superhyway_unregister_driver - Unregister a SuperHyway driver
> - * @drv: SuperHyway driver to unregister.
> - *
> - * This cleans up after superhyway_register_driver(), and should be invoked in
> - * the exit path of any module drivers.
> - */
> -void superhyway_unregister_driver(struct superhyway_driver *drv)
> -{
> -	driver_unregister(&drv->drv);
> -}
> -
> -static int superhyway_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -	struct superhyway_device *shyway_dev = to_superhyway_device(dev);
> -	struct superhyway_driver *shyway_drv = to_superhyway_driver(drv);
> -	const struct superhyway_device_id *ids = shyway_drv->id_table;
> -
> -	if (!ids)
> -		return -EINVAL;
> -	if (superhyway_match_id(ids, shyway_dev))
> -		return 1;
> -
> -	return -ENODEV;
> -}
> -
> -struct bus_type superhyway_bus_type = {
> -	.name		= "superhyway",
> -	.match		= superhyway_bus_match,
> -#ifdef CONFIG_SYSFS
> -	.dev_groups	= superhyway_dev_groups,
> -#endif
> -	.probe		= superhyway_device_probe,
> -	.remove		= superhyway_device_remove,
> -};
> -
> -static int __init superhyway_bus_init(void)
> -{
> -	return bus_register(&superhyway_bus_type);
> -}
> -
> -static void __exit superhyway_bus_exit(void)
> -{
> -	device_unregister(&superhyway_bus_device);
> -	bus_unregister(&superhyway_bus_type);
> -}
> -
> -core_initcall(superhyway_bus_init);
> -module_exit(superhyway_bus_exit);
> -
> -EXPORT_SYMBOL(superhyway_bus_type);
> -EXPORT_SYMBOL(superhyway_add_device);
> -EXPORT_SYMBOL(superhyway_add_devices);
> -EXPORT_SYMBOL(superhyway_register_driver);
> -EXPORT_SYMBOL(superhyway_unregister_driver);
> -
> -MODULE_LICENSE("GPL");
> diff --git a/include/linux/superhyway.h b/include/linux/superhyway.h
> deleted file mode 100644
> index 8d3376775813d..0000000000000
> --- a/include/linux/superhyway.h
> +++ /dev/null
> @@ -1,107 +0,0 @@
> -/*
> - * include/linux/superhyway.h
> - *
> - * SuperHyway Bus definitions
> - *
> - * Copyright (C) 2004, 2005  Paul Mundt <lethal@linux-sh.org>
> - *
> - * This file is subject to the terms and conditions of the GNU General Public
> - * License.  See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -#ifndef __LINUX_SUPERHYWAY_H
> -#define __LINUX_SUPERHYWAY_H
> -
> -#include <linux/device.h>
> -
> -/*
> - * SuperHyway IDs
> - */
> -#define SUPERHYWAY_DEVICE_ID_SH5_DMAC	0x0183
> -
> -struct superhyway_vcr_info {
> -	u8	perr_flags;	/* P-port Error flags */
> -	u8	merr_flags;	/* Module Error flags */
> -	u16	mod_vers;	/* Module Version */
> -	u16	mod_id;		/* Module ID */
> -	u8	bot_mb;		/* Bottom Memory block */
> -	u8	top_mb;		/* Top Memory block */
> -};
> -
> -struct superhyway_ops {
> -	int (*read_vcr)(unsigned long base, struct superhyway_vcr_info *vcr);
> -	int (*write_vcr)(unsigned long base, struct superhyway_vcr_info vcr);
> -};
> -
> -struct superhyway_bus {
> -	struct superhyway_ops *ops;
> -};
> -
> -extern struct superhyway_bus superhyway_channels[];
> -
> -struct superhyway_device_id {
> -	unsigned int id;
> -	unsigned long driver_data;
> -};
> -
> -struct superhyway_device;
> -extern struct bus_type superhyway_bus_type;
> -
> -struct superhyway_driver {
> -	char *name;
> -
> -	const struct superhyway_device_id *id_table;
> -	struct device_driver drv;
> -
> -	int (*probe)(struct superhyway_device *dev, const struct superhyway_device_id *id);
> -	void (*remove)(struct superhyway_device *dev);
> -};
> -
> -#define to_superhyway_driver(d)	container_of((d), struct superhyway_driver, drv)
> -
> -struct superhyway_device {
> -	char name[32];
> -
> -	struct device dev;
> -
> -	struct superhyway_device_id id;
> -	struct superhyway_driver *drv;
> -	struct superhyway_bus *bus;
> -
> -	int num_resources;
> -	struct resource *resource;
> -	struct superhyway_vcr_info vcr;
> -};
> -
> -#define to_superhyway_device(d)	container_of((d), struct superhyway_device, dev)
> -
> -#define superhyway_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
> -#define superhyway_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, (p))
> -
> -static inline int
> -superhyway_read_vcr(struct superhyway_device *dev, unsigned long base,
> -		    struct superhyway_vcr_info *vcr)
> -{
> -	return dev->bus->ops->read_vcr(base, vcr);
> -}
> -
> -static inline int
> -superhyway_write_vcr(struct superhyway_device *dev, unsigned long base,
> -		     struct superhyway_vcr_info vcr)
> -{
> -	return dev->bus->ops->write_vcr(base, vcr);
> -}
> -
> -extern int superhyway_scan_bus(struct superhyway_bus *);
> -
> -/* drivers/sh/superhyway/superhyway.c */
> -int superhyway_register_driver(struct superhyway_driver *);
> -void superhyway_unregister_driver(struct superhyway_driver *);
> -int superhyway_add_device(unsigned long base, struct superhyway_device *, struct superhyway_bus *);
> -int superhyway_add_devices(struct superhyway_bus *bus, struct superhyway_device **devices, int nr_devices);
> -
> -/* drivers/sh/superhyway/superhyway-sysfs.c */
> -extern const struct attribute_group *superhyway_dev_groups[];
> -
> -#endif /* __LINUX_SUPERHYWAY_H */
> -

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
