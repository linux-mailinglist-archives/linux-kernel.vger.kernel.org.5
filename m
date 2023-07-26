Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4D7635F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjGZMN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjGZMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:13:55 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9DA19BF;
        Wed, 26 Jul 2023 05:13:53 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qOdO1-0005Hq-5C; Wed, 26 Jul 2023 14:13:01 +0200
Date:   Wed, 26 Jul 2023 14:13:01 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     olivia@selenic.com, herbert@gondor.apana.org.au,
        jiajie.ho@starfivetech.com, conor.dooley@microchip.com,
        mmyangfl@gmail.com, jenny.zhang@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        leoliu@zhaoxin.com, CobeChen@zhaoxin.com, YunShen@zhaoxin.com,
        TonyWWang@zhaoxin.com
Subject: Re: [PATCH] hwrng: add Zhaoxin HW RNG driver
Message-ID: <20230726121301.kbkskd23mwoptvvx@viti.kaiser.cx>
References: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some quick remarks. Feel free to correct me if I misunderstood
something.

LeoLiu-oc (LeoLiu-oc@zhaoxin.com) wrote:

> From: leoliu-oc <leoliu-oc@zhaoxin.com>

> Add support for Zhaoxin HW RNG.

> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
> ---
>  drivers/char/hw_random/Kconfig       |  13 +++
>  drivers/char/hw_random/Makefile      |   1 +
>  drivers/char/hw_random/via-rng.c     |  17 ++--
>  drivers/char/hw_random/zhaoxin-rng.c | 116 +++++++++++++++++++++++++++
>  4 files changed, 139 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/char/hw_random/zhaoxin-rng.c

> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index e0b3786ca51b..3b3c00e87b7b 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -150,6 +150,19 @@ config HW_RANDOM_VIA

>  	  If unsure, say Y.

> +config HW_RANDOM_ZHAOXIN
> +	tristate "Zhaoxin HW Random Number Generator support"
> +	depends on X86

depends on X86 || COMPILE_TEST

> +	default HW_RANDOM
> +	help
> +	  This driver provides kernel-side support for the Random Number
> +	  Generator hardware found on Zhaoxin based motherboards.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called zhaoxin-rng.
> +
> +	  If unsure, say Y.
> +
>  config HW_RANDOM_IXP4XX
>  	tristate "Intel IXP4xx NPU HW Pseudo-Random Number Generator support"
>  	depends on ARCH_IXP4XX || COMPILE_TEST
> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
> index 32549a1186dc..ef5b3ae0794d 100644
> --- a/drivers/char/hw_random/Makefile
> +++ b/drivers/char/hw_random/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
>  obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
>  n2-rng-y := n2-drv.o n2-asm.o
>  obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
> +obj-$(CONFIG_HW_RANDOM_ZHAOXIN) += zhaoxin-rng.o
>  obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-trng.o
>  obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
>  obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
> diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
> index a9a0a3b09c8b..33a6e2fdacd1 100644
> --- a/drivers/char/hw_random/via-rng.c
> +++ b/drivers/char/hw_random/via-rng.c
> @@ -135,7 +135,7 @@ static int via_rng_init(struct hwrng *rng)
>  	 * is always enabled if CPUID rng_en is set.  There is no
>  	 * RNG configuration like it used to be the case in this
>  	 * register */
> -	if (((c->x86 == 6) && (c->x86_model >= 0x0f))  || (c->x86 > 6)){
> +	if ((c->x86 == 6) && (c->x86_model >= 0x0f)) {
>  		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
>  			pr_err(PFX "can't enable hardware RNG "
>  				"if XSTORE is not enabled\n");
> @@ -191,13 +191,20 @@ static struct hwrng via_rng = {
>  	.data_read	= via_rng_data_read,
>  };

> +static const struct x86_cpu_id via_rng_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);

>  static int __init via_rng_mod_init(void)
>  {
>  	int err;

> -	if (!boot_cpu_has(X86_FEATURE_XSTORE))
> +	if (!x86_match_cpu(via_rng_cpu_ids)) {
> +		pr_err(PFX "The CPU isn't support XSTORE.\n");

doesn't support

Generally: Should we print an error message if our driver doesn't
support this cpu? It seems that most other callers of x86_match_cpu
simply return without an error message.

>  		return -ENODEV;
> +	}

>  	pr_info("VIA RNG detected\n");
>  	err = hwrng_register(&via_rng);
> @@ -217,11 +224,5 @@ static void __exit via_rng_mod_exit(void)
>  }
>  module_exit(via_rng_mod_exit);

> -static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
> -	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
> -	{}
> -};
> -MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
> -
>  MODULE_DESCRIPTION("H/W RNG driver for VIA CPU with PadLock");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/char/hw_random/zhaoxin-rng.c b/drivers/char/hw_random/zhaoxin-rng.c
> new file mode 100644
> index 000000000000..2e657b227c5b
> --- /dev/null
> +++ b/drivers/char/hw_random/zhaoxin-rng.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RNG driver for Zhaoxin RNGs
> + *
> + * Copyright 2005 (c) MontaVista Software, Inc.

Should this be Copyright 2023 by you?

> + *
> + * with the majority of the code coming from:
> + *
> + * Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
> + * (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
> + *
> + * derived from
> + *
> + * Hardware driver for the AMD 768 Random Number Generator (RNG)
> + * (c) Copyright 2001 Red Hat Inc
> + *
> + * derived from
> + *
> + * Hardware driver for Intel i810 Random Number Generator (RNG)
> + * Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
> + * Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <crypto/padlock.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/hw_random.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/cpufeature.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/fpu/api.h>
> +
> +enum {
> +	ZHAOXIN_RNG_CHUNK_8		= 0x00, /* 64 rand bits, 64 stored bits*/
> +	ZHAOXIN_RNG_CHUNK_4		= 0x01, /* 32 rand bits, 32 stored bits */
> +	ZHAOXIN_RNG_CHUNK_2		= 0x02, /* 16 rand bits, 32 stored bits */
> +	ZHAOXIN_RNG_CHUNK_1		= 0x03, /* 8 rand bits, 32 stored bits */
> +	ZHAOXIN_RNG_MAX_SIZE		= (128*1024),
> +};
> +
> +static int zhaoxin_rng_init(struct hwrng *rng)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
> +		pr_err(PFX "can't enable hardware RNG if XSTORE is not enabled\n");
> +		return -ENODEV;
> +	}

Can't we check this when the driver is loaded? (This init function here
is called when the rng becomes active.)

> +	return 0;
> +}
> +
> +static inline int rep_xstore(size_t size, size_t factor, void *result)
> +{
> +	__asm__ __volatile__ (
> +	"movq %0, %%rcx\n"
> +	"movq %1, %%rdx\n"
> +	"movq %2, %%rdi\n"
> +	".byte 0xf3, 0x0f, 0xa7, 0xc0"
> +	:
> +	: "r"(size), "r"(factor), "r"(result)
> +	: "%rcx", "%rdx", "%rdi", "memory");
> +
> +	return 0;
> +}
> +
> +static int zhaoxin_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
> +{
> +	if (max > ZHAOXIN_RNG_MAX_SIZE)
> +		max = ZHAOXIN_RNG_MAX_SIZE;
> +	rep_xstore(max, ZHAOXIN_RNG_CHUNK_1, data);
> +	return max;
> +}
> +
> +static struct hwrng zhaoxin_rng = {
> +	.name   = "zhaoxin",
> +	.init   = zhaoxin_rng_init,
> +	.read   = zhaoxin_rng_read,
> +};
> +
> +static const struct x86_cpu_id zhaoxin_rng_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 6, X86_FEATURE_XSTORE, NULL),
> +	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 7, X86_FEATURE_XSTORE, NULL),
> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 7, X86_FEATURE_XSTORE, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, zhaoxin_rng_cpu_ids);
> +
> +static int __init zhaoxin_rng_mod_init(void)
> +{
> +	int err;
> +
> +	if (!x86_match_cpu(zhaoxin_rng_cpu_ids)) {
> +		pr_err(PFX "The CPU isn't support XSTORE.\n");

Yet again, is this really an error?

> +		return -ENODEV;
> +	}
> +
> +	pr_info("Zhaoxin RNG detected\n");
> +	err = hwrng_register(&zhaoxin_rng);
> +	if (err)
> +		pr_err(PFX "RNG registering failed (%d)\n", err);
> +
> +	return err;
> +}
> +module_init(zhaoxin_rng_mod_init);
> +
> +static void __exit zhaoxin_rng_mod_exit(void)
> +{
> +	hwrng_unregister(&zhaoxin_rng);
> +}
> +module_exit(zhaoxin_rng_mod_exit);
> +MODULE_DESCRIPTION("H/W RNG driver for Zhaoxin CPU");
> +MODULE_AUTHOR("YunShen@zhaoxin.com");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1

Best regards,
Martin
