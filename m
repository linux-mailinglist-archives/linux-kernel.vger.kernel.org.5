Return-Path: <linux-kernel+bounces-66501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E771C855DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B997EB2FA77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B558171B0;
	Thu, 15 Feb 2024 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jLp2V/qV"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389817585;
	Thu, 15 Feb 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988421; cv=none; b=Nlbs2/S0WKfUSld9GDjEvJl7sD3z0Z99m4gtHL3gYvOqEQ+yGU3ITBaSzT1n/6iYa9Wws+UBWXvnRUukLq8tSpxsLuA1WzQWa9VI6xDQEoNx2HW16IsaMHOjVonzJJjK6JJPO55iyL9BG5pvf4dcfJhhFozglhDm2ANaObTw0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988421; c=relaxed/simple;
	bh=nW9UnCQTNOoFfohP8hTXiKV7UvgAUgtPFbT08m9LL3Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcuZkAtb9T9zguf5/a4gbDbl+vS+cYtGqpvsu7rIvo13K5XQM5coXskPUwu+AwpSSiWYV5070YFWr7ql612w7fNBoDWvF2l69hnpFe2by6TmmSjNDlc/522AhHTGxS9tbxoE8cVWyDqOioxpiKAm4MrjMv4ww455zNfIc5loPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jLp2V/qV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9DWBV055880;
	Thu, 15 Feb 2024 03:13:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707988412;
	bh=HK2jGaqe1B73/CKo9oLFbqeMHRqjhANdj2JYm1spQ4g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jLp2V/qVP+59xdlbu99/3t853hK/nnfLyklukdV+adyQo7mFrYy1xDwUnN7Z8p4Ke
	 VH4DNnjCsokqs+NtWdso2oHlGc+Np7SEGauP+hdYodBRh8GmGSZhvrMLCsx48254s5
	 wsTbdGuOQH9x1qc6lZtmCAaOBsFEMme4wVPmT1Bs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9DWQG049150
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:13:32 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:13:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:13:32 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9DVMV039681;
	Thu, 15 Feb 2024 03:13:31 -0600
Date: Thu, 15 Feb 2024 14:43:30 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Andrew Davis
	<afd@ti.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] cpufreq: ti-cpufreq: Support nvmem for chip version
Message-ID: <20240215091330.bzprmfsz2dw2j7xa@dhruva>
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206145721.2418893-3-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Feb 06, 2024 at 15:57:20 +0100, Markus Schneider-Pargmann wrote:
> Support using nvmem-cells 'chipvariant' and 'chipspeed' instead of
> syscon. This makes it more flexible and moves more configuration into
> the devicetree.
> 
> If nvmem-cells are present, probing will fail if the configuration of
> these cells is broken. If nvmem-cells is not present syscon will be
> used.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 105 ++++++++++++++++++++++-------------
>  1 file changed, 66 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 46c41e2ca727..3ee72b1309f0 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -10,6 +10,7 @@
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -65,6 +66,7 @@ struct ti_cpufreq_soc_data {
>  
>  struct ti_cpufreq_data {
>  	struct device *cpu_dev;
> +	struct device *dev;
>  	struct device_node *opp_node;
>  	struct regmap *syscon;
>  	const struct ti_cpufreq_soc_data *soc_data;
> @@ -244,31 +246,40 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
>  static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
>  				u32 *efuse_value)
>  {
> +	struct device_node *np = opp_data->opp_node;

Umm.. slightly confused, where is *np being used?

>  	struct device *dev = opp_data->cpu_dev;
>  	u32 efuse;
>  	int ret;
>  
> -	ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
> -			  &efuse);
> -	if (ret == -EIO) {
> -		/* not a syscon register! */
> -		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> -				opp_data->soc_data->efuse_offset, 4);
> -
> -		if (!regs)
> -			return -ENOMEM;
> -		efuse = readl(regs);
> -		iounmap(regs);
> +	ret = nvmem_cell_read_u32(opp_data->dev, "chipspeed", &efuse);
> +	if (ret && (ret != -ENOENT || !opp_data->syscon))
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read nvmem cell 'chipspeed': %pe",
> +				     ERR_PTR(ret));
> +
> +	if (ret) {
> +		ret = regmap_read(opp_data->syscon, opp_data->soc_data->efuse_offset,
> +				  &efuse);
> +		if (ret == -EIO) {
> +			/* not a syscon register! */
> +			void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> +					opp_data->soc_data->efuse_offset, 4);
> +
> +			if (!regs)
> +				return -ENOMEM;
> +			efuse = readl(regs);
> +			iounmap(regs);
> +			}
> +		else if (ret) {

else should be enough I guess, no need of elif?

> +			dev_err(dev,
> +				"Failed to read the efuse value from syscon: %d\n",
> +				ret);
> +			return ret;
>  		}
> -	else if (ret) {
> -		dev_err(dev,
> -			"Failed to read the efuse value from syscon: %d\n",
> -			ret);
> -		return ret;
> -	}
>  
> -	efuse = (efuse & opp_data->soc_data->efuse_mask);
> -	efuse >>= opp_data->soc_data->efuse_shift;
> +		efuse = (efuse & opp_data->soc_data->efuse_mask);
> +		efuse >>= opp_data->soc_data->efuse_shift;
> +	}
>  
>  	*efuse_value = opp_data->soc_data->efuse_xlate(opp_data, efuse);
>  
> @@ -285,30 +296,41 @@ static int ti_cpufreq_get_efuse(struct ti_cpufreq_data *opp_data,
>  static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>  			      u32 *revision_value)
>  {
> +	struct device_node *np = opp_data->opp_node;

where is this used? Atleast, in this patch I don't see it...

>  	struct device *dev = opp_data->cpu_dev;
>  	u32 revision;
>  	int ret;
>  
> -	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
> -			  &revision);
> -	if (ret == -EIO) {
> -		/* not a syscon register! */
> -		void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> -				opp_data->soc_data->rev_offset, 4);
> -
> -		if (!regs)
> -			return -ENOMEM;
> -		revision = readl(regs);
> -		iounmap(regs);
> +	ret = nvmem_cell_read_u32(opp_data->dev, "chipvariant", &revision);
> +	if (ret && (ret != -ENOENT || !opp_data->syscon))
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read nvmem cell 'chipvariant': %pe",
> +				     ERR_PTR(ret));
> +
> +	if (ret) {
> +		ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
> +				  &revision);
> +		if (ret == -EIO) {
> +			/* not a syscon register! */
> +			void __iomem *regs = ioremap(OMAP3_SYSCON_BASE +
> +					opp_data->soc_data->rev_offset, 4);
> +
> +			if (!regs)
> +				return -ENOMEM;
> +			revision = readl(regs);
> +			iounmap(regs);
> +			}
> +		else if (ret) {

Do you really have to? This code will reach only if(ret) is satisfied,
the elif feels redundant. Else should be fine

> +			dev_err(dev,
> +				"Failed to read the revision number from syscon: %d\n",
> +				ret);
> +			return ret;
>  		}
> -	else if (ret) {
> -		dev_err(dev,
> -			"Failed to read the revision number from syscon: %d\n",
> -			ret);
> -		return ret;
> +
> +		revision = (revision >> REVISION_SHIFT) & REVISION_MASK;
>  	}
>  
> -	*revision_value = BIT((revision >> REVISION_SHIFT) & REVISION_MASK);
> +	*revision_value = BIT(revision);
>  
>  	return 0;
>  }
> @@ -392,9 +414,14 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  		goto register_cpufreq_dt;
>  	}
>  
> -	ret = ti_cpufreq_setup_syscon_register(opp_data);
> -	if (ret)
> -		goto fail_put_node;
> +	opp_data->dev = &pdev->dev;
> +	opp_data->dev->of_node = opp_data->opp_node;
> +
> +	if (!of_property_read_bool(opp_data->opp_node, "nvmem-cells")) {
> +		ret = ti_cpufreq_setup_syscon_register(opp_data);
> +		if (ret)
> +			goto fail_put_node;
> +	}

Mostly looks okay, with above comments addressed:

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

