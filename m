Return-Path: <linux-kernel+bounces-71909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE9885AC60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F501C222BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E40755E47;
	Mon, 19 Feb 2024 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpGJkBn8"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0AD55782
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372071; cv=none; b=pZmW9lxUdm8YcBSYVT89JxfKMaK8ZqrhFJYI++7B9X8tR4O3TaceU26wVTuwjFTo1WGmFh0Kr2k7AAgo1006gB/Icb537xFEripJr/QiK2wl+g1d1px3k3x6Zsh5NTvdL9Jb7wS6/GvCu7UhcZL0SdjZynB1744aFUhoLwZ9ahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372071; c=relaxed/simple;
	bh=XkhfSruws1PK8Q+mtqnOkbEUh6zoMfTIYc9vj2VGfUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4IPKsb0un387bj64uMaehMrmQAeSMPxtgwDNahc+tKsUVTQ4+ajfDA2Fzku0uOLMLaUpimP7EXPE4z5fCusoW77xTddJwqemIZ0AeLFk8N6X7O+ebps0nu4aJVXyeWg+wdC5gc4R/9diBU0DIfIwhsNuI9r7iDQJjIFViCh8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpGJkBn8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783045e88a6so284478985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708372067; x=1708976867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p6ToLcKTB36FKha5pojw70mVfgbtf14p/teADHNjf7I=;
        b=QpGJkBn8BDlETAKBbdKn8q9zohxWcxAXYVUSz8S2FyqzLv4QXZzNqyVLg/sKyQddXp
         FX5/GwOevtvLZ4j979JFibRB+ieMv4OIn0O7p3JCLhb870Kwy6Sy1axnjiS9YeH2Vqce
         u5/FNTnzS8I8NlYdS9bFm387X6NRjgHuuDBBijEWw/NELbtRnyOuu+mfSxKec+OZ5oMj
         2X7ZTPf2vGijA7CaTFiF6rgfp3BWY//SO43fPShqIsHWrbHieIqZU+mLJPYUlbrRDgTH
         PNRZUyh4OtOWgg/NY0J8EF958zWSqUiEBNApVfWEVPgOgpo+/9Okf4rkexklMv7bycap
         jIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372067; x=1708976867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6ToLcKTB36FKha5pojw70mVfgbtf14p/teADHNjf7I=;
        b=Rj3+6F33dGcp6Ctu9DlVu9b+MSGIvhiKZCy01whgUjAFWXLBMZGCnjhaULnimVTGcZ
         sk8aUkQr4hJGWUhF5x1699DFDamjm2qNKnSPH2/ZqbXQWuKhjK3bQXjrYtv3C7T31gw7
         2gYghin5wweYl2/J0oPpKefJqrnwt/qpXckJSxScSlr6bTkUaFzkjoGM1r9RZcuK87L6
         VI1wprbKrdIrvSrvgKANqhVVC7ideAqDZ6VHmielpnAgQTCUw4bKoGYpsIOWij3cQsyJ
         IpYeXQv7yfTFdVsS4WZE8HMIDocS81YTsXTa0jyEaR0eBzktu0JNXvXKvaZu1FJqxMuF
         9NXw==
X-Forwarded-Encrypted: i=1; AJvYcCWvN5Wgl7gO29AEid+uMEp5Tid6uPC/my3IuN/SP7DNPd2VwuZ1JVfh3JEDe059SZjiZft61s5MOKcaPCFi58ESUyunCDCvv9X/60py
X-Gm-Message-State: AOJu0Yw+mQqyBdYPvWjveFqdsqs0IrxCJRMFwKq6P+q6DEIT1/BBThxD
	lEeChe2nY5XOXQ6RUNKcUiTuBwnzX5ne9dQTbSauFHxkmpSzh80Vq23/I5UN3Dsd+NmCCUaI3QQ
	EzdhNOVIJfY+dLZBMhmuRm7n3DMokrnhdsjbRVw==
X-Google-Smtp-Source: AGHT+IHAoi5mMFAbN6ZhMnHtGDlDZfE4RJiI7ovb0BwuOi0xkaIFKf0AXUBqGA3iRE7Go3SHn/BB2ZfOVbtFJHeyKQE=
X-Received: by 2002:a0c:e24b:0:b0:68c:a4a8:b134 with SMTP id
 x11-20020a0ce24b000000b0068ca4a8b134mr12125483qvl.45.1708372066684; Mon, 19
 Feb 2024 11:47:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208161700.268570-1-peter.griffin@linaro.org>
 <20240208161700.268570-2-peter.griffin@linaro.org> <ab1f9285-73ba-4b69-8882-0cf08c508e28@linaro.org>
In-Reply-To: <ab1f9285-73ba-4b69-8882-0cf08c508e28@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 19 Feb 2024 19:47:35 +0000
Message-ID: <CADrjBPqw9E5foNvZ-ETFZR3mb8=x8CYHz3UUhfJUbBpOi3iKYw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: arnd@arndb.de, linux@roeck-us.net, wim@linux-watchdog.org, 
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com, semen.protsenko@linaro.org, 
	alexey.klimov@linaro.org, kernel-team@android.com, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the review. I was OoO last week so just getting to this now.

On Thu, 15 Feb 2024 at 18:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/02/2024 17:16, Peter Griffin wrote:
> > Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> > security hardening reasons so that they are only write accessible in el3
> > via an SMC call.
> >
> > As most Exynos drivers that need to write PMU registers currently obtain a
> > regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> > is implemented in this driver using a custom regmap similar to syscon to
> > handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> > regmap like before. As regmaps abstract out the underlying register access
> > changes to the leaf drivers are minimal.
> >
> > A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> > that currently use syscon_regmap_lookup_by_phandle(). This also handles
> > deferred probing.
>
> I found an issue, which needs new version, so I also found few more nits.
>
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> > Changes since v3:
> >  - Fix PMUALIVE_MASK
> >  - Add TENSOR_ prefix
> >  - clear SET_BITS bits on each loop iteration
> >  - change set_bit to set_bits in func name
> >  - Fix some alignment
> >  - Add missing return on dev_err_probe
> >  - Reduce indentation in loop
> >
> > Changes since v2
> >  - Add select REGMAP to Kconfig
> >  - Add constant for SET/CLEAR bits
> >  - Replace kerneldoc with one line comment
> >  - Fix kerneldoc for EXPORT_SYMBOL_GPL funcs
> >  - remove superfluous extern keyword
> >  - dev_err_probe() on probe error
> >  - shorten regmcfg name
> >  - no compatibles inside probe, use match data
> >  - don't mix declarations with/without initializations
> >  - tensor_sec_reg_read() use mmio to avoid access restrictions
> >  - Collect up Reviewed-by
> >  - const for regmap_config structs
> > ---
> >  drivers/soc/samsung/Kconfig            |   1 +
> >  drivers/soc/samsung/exynos-pmu.c       | 235 ++++++++++++++++++++++++-
> >  drivers/soc/samsung/exynos-pmu.h       |   1 +
> >  include/linux/soc/samsung/exynos-pmu.h |  11 +-
> >  4 files changed, 243 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> > index 27ec99af77e3..1a5dfdc978dc 100644
> > --- a/drivers/soc/samsung/Kconfig
> > +++ b/drivers/soc/samsung/Kconfig
> > @@ -42,6 +42,7 @@ config EXYNOS_PMU
> >       depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> >       select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
> >       select MFD_CORE
> > +     select REGMAP_MMIO
> >
> >  # There is no need to enable these drivers for ARMv8
> >  config EXYNOS_PMU_ARM_DRIVERS
> > diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> > index 250537d7cfd6..b846e343fcdd 100644
> > --- a/drivers/soc/samsung/exynos-pmu.c
> > +++ b/drivers/soc/samsung/exynos-pmu.c
> > @@ -5,6 +5,7 @@
> >  //
> >  // Exynos - CPU PMU(Power Management Unit) support
> >
> > +#include <linux/arm-smccc.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/mfd/core.h>
> > @@ -12,19 +13,132 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/delay.h>
> > +#include <linux/regmap.h>
> >
> >  #include <linux/soc/samsung/exynos-regs-pmu.h>
> >  #include <linux/soc/samsung/exynos-pmu.h>
> >
> >  #include "exynos-pmu.h"
> >
> > +#define PMUALIVE_MASK                        GENMASK(13, 0)
> > +#define TENSOR_SET_BITS                      (BIT(15) | BIT(14))
> > +#define TENSOR_CLR_BITS                      BIT(15)
> > +#define TENSOR_SMC_PMU_SEC_REG               0x82000504
> > +#define TENSOR_PMUREG_READ           0
> > +#define TENSOR_PMUREG_WRITE          1
> > +#define TENSOR_PMUREG_RMW            2
> > +
> >  struct exynos_pmu_context {
> >       struct device *dev;
> >       const struct exynos_pmu_data *pmu_data;
> > +     struct regmap *pmureg;
> >  };
> >
> >  void __iomem *pmu_base_addr;
> >  static struct exynos_pmu_context *pmu_context;
> > +/* forward declaration */
> > +static struct platform_driver exynos_pmu_driver;
> > +
> > +/*
> > + * Tensor SoCs are configured so that PMU_ALIVE registers can only be written
> > + * from EL3, but are still read accessible. As Linux needs to write some of
> > + * these registers, the following functions are provided and exposed via
> > + * regmap.
> > + *
> > + * Note: This SMC interface is known to be implemented on gs101 and derivative
> > + * SoCs.
> > + */
> > +
> > +/* Write to a protected PMU register. */
> > +static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned int val)
>
> Please use the same argument names in all these regmap functions as in
> struct regmap_config, so base->context

Will fix.

>
> > +{
> > +     struct arm_smccc_res res;
> > +     unsigned long pmu_base = (unsigned long)base;
> > +
> > +     arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> > +                   TENSOR_PMUREG_WRITE, val, 0, 0, 0, 0, &res);
> > +
> > +     /* returns -EINVAL if access isn't allowed or 0 */
> > +     if (res.a0)
> > +             pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
> > +
> > +     return (int)res.a0;
> > +}
> > +
> > +/* Read/Modify/Write a protected PMU register. */
> > +static int tensor_sec_reg_rmw(void *base, unsigned int reg,
> > +                           unsigned int mask, unsigned int val)
> > +{
> > +     struct arm_smccc_res res;
> > +     unsigned long pmu_base = (unsigned long)base;
> > +
> > +     arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
> > +                   TENSOR_PMUREG_RMW, mask, val, 0, 0, 0, &res);
> > +
> > +     /* returns -EINVAL if access isn't allowed or 0 */
> > +     if (res.a0)
> > +             pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
> > +
> > +     return (int)res.a0;
> > +}
> > +
> > +/*
> > + * Read a protected PMU register. All PMU registers can be read by Linux.
> > + * Note: The SMC read register is not used, as only registers that can be
> > + * written are readable via SMC.
> > + */
> > +static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned int *val)
> > +{
> > +     *val = pmu_raw_readl(reg);
> > +     return 0;
> > +}
> > +
> > +/*
> > + * For SoCs that have set/clear bit hardware this function can be used when
> > + * the PMU register will be accessed by multiple masters.
> > + *
> > + * For example, to set bits 13:8 in PMU reg offset 0x3e80
> > + * tensor_set_bits_atomic(ctx, 0x3e80, 0x3f00, 0x3f00);
> > + *
> > + * Set bit 8, and clear bits 13:9 PMU reg offset 0x3e80
> > + * tensor_set_bits_atomic(0x3e80, 0x100, 0x3f00);
> > + */
> > +static inline int tensor_set_bits_atomic(void *ctx, unsigned int offset,
>
> Usual practice is to rely on compiler to inline, so let's drop the
> keyword here.

Will fix

>
> > +                                      u32 val, u32 mask)
> > +{
> > +     int ret;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < 32; i++) {
> > +             if (!(mask & BIT(i)))
> > +                     continue;
> > +
> > +             offset &= ~TENSOR_SET_BITS;
> > +
> > +             if (val & BIT(i))
> > +                     offset |= TENSOR_SET_BITS;
> > +             else
> > +                     offset |= TENSOR_CLR_BITS;
> > +
> > +             ret = tensor_sec_reg_write(ctx, offset, i);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int tensor_sec_update_bits(void *ctx, unsigned int reg,
> > +                               unsigned int mask, unsigned int val)
> > +{
> > +     /*
> > +      * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
> > +      * as the target registers can be accessed by multiple masters.
> > +      */
> > +     if (reg > PMUALIVE_MASK)
> > +             return tensor_sec_reg_rmw(ctx, reg, mask, val);
> > +
> > +     return tensor_set_bits_atomic(ctx, reg, val, mask);
> > +}
> >
> >  void pmu_raw_writel(u32 val, u32 offset)
> >  {
> > @@ -75,11 +189,41 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
> >  #define exynos_pmu_data_arm_ptr(data)        NULL
> >  #endif
> >
> > +static const struct regmap_config regmap_smccfg = {
> > +     .name = "pmu_regs",
> > +     .reg_bits = 32,
> > +     .reg_stride = 4,
> > +     .val_bits = 32,
> > +     .fast_io = true,
> > +     .use_single_read = true,
> > +     .use_single_write = true,
> > +     .reg_read = tensor_sec_reg_read,
> > +     .reg_write = tensor_sec_reg_write,
> > +     .reg_update_bits = tensor_sec_update_bits,
>
> > +};
> > +
> > +static const struct regmap_config regmap_mmiocfg = {
> > +     .name = "pmu_regs",
> > +     .reg_bits = 32,
> > +     .reg_stride = 4,
> > +     .val_bits = 32,
> > +     .fast_io = true,
> > +     .use_single_read = true,
> > +     .use_single_write = true,
> > +};
> > +
> > +static const struct exynos_pmu_data gs101_pmu_data = {
> > +     .pmu_secure = true
> > +};
> > +
> >  /*
> >   * PMU platform driver and devicetree bindings.
> >   */
> >  static const struct of_device_id exynos_pmu_of_device_ids[] = {
> >       {
> > +             .compatible = "google,gs101-pmu",
> > +             .data = &gs101_pmu_data,
> > +     }, {
> >               .compatible = "samsung,exynos3250-pmu",
> >               .data = exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
> >       }, {
> > @@ -113,19 +257,73 @@ static const struct mfd_cell exynos_pmu_devs[] = {
> >       { .name = "exynos-clkout", },
> >  };
> >
> > +/**
> > + * exynos_get_pmu_regmap() - Obtain pmureg regmap
> > + *
> > + * Find the pmureg regmap previously configured in probe() and return regmap
> > + * pointer.
> > + *
> > + * Return: A pointer to regmap if found or ERR_PTR error value.
> > + */
> >  struct regmap *exynos_get_pmu_regmap(void)
> >  {
> >       struct device_node *np = of_find_matching_node(NULL,
> >                                                     exynos_pmu_of_device_ids);
> >       if (np)
> > -             return syscon_node_to_regmap(np);
> > +             return exynos_get_pmu_regmap_by_phandle(np, NULL);
> >       return ERR_PTR(-ENODEV);
> >  }
> >  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
> >
> > +/**
> > + * exynos_get_pmu_regmap_by_phandle() - Obtain pmureg regmap via phandle
> > + * @np: Pointer to device's Device Tree node
>
> A bit unusual naming... drop "Device Tree" anywhere here. This is:
> "device node holding PMU phandle property"

Will fix

>
>
> > + * @property: Device Tree property name which references the pmu
>
> Name of property holding a phandle value

Will fix

>
> > + *
> > + * Find the pmureg regmap previously configured in probe() and return regmap
> > + * pointer.
> > + *
> > + * Return: A pointer to regmap if found or ERR_PTR error value.
> > + */
> > +struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> > +                                             const char *property)
>
> property -> propname

Will fix

>
> > +{
> > +     struct device *dev;
> > +     struct exynos_pmu_context *ctx;
> > +     struct device_node *pmu_np;
>
> Reversed christmass tree.

Will fix

>
> > +
> > +     if (property)
> > +             pmu_np = of_parse_phandle(np, property, 0);
> > +     else
> > +             pmu_np = np;
> > +
> > +     if (!pmu_np)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     /*
> > +      * Determine if exynos-pmu device has probed and therefore regmap
> > +      * has been created and can be returned to the caller. Otherwise we
> > +      * return -EPROBE_DEFER.
> > +      */
> > +     dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
> > +                                         (void *)pmu_np);
> > +
> > +     of_node_put(pmu_np);
>
> You are dropping now referencen from np when property==NULL. This does
> no look right.

Good spot, will fix. It seems syscon.c and altera-sysmgr also have the
same issue.

>
> > +     if (!dev)
> > +             return ERR_PTR(-EPROBE_DEFER);
> > +
> > +     ctx = dev_get_drvdata(dev);
> > +
> > +     return ctx->pmureg;
> > +}
> > +EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> > +
> >  static int exynos_pmu_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev = &pdev->dev;
> > +     struct regmap_config pmu_regmcfg;
> > +     struct regmap *regmap;
> > +     struct resource *res;
> >       int ret;
> >
> >       pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
> > @@ -133,13 +331,42 @@ static int exynos_pmu_probe(struct platform_device *pdev)
> >               return PTR_ERR(pmu_base_addr);
> >
> >       pmu_context = devm_kzalloc(&pdev->dev,
> > -                     sizeof(struct exynos_pmu_context),
> > -                     GFP_KERNEL);
> > +                                sizeof(struct exynos_pmu_context),
> > +                                GFP_KERNEL);
>
> Not related here. You could have separate patch for cleanups or just
> skip such change.

Will remove.

kind regards,

Peter.

