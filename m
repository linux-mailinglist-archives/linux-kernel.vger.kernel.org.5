Return-Path: <linux-kernel+bounces-68445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABE857A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A5B2442F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F902C1AF;
	Fri, 16 Feb 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaGwzZrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A6328E2E;
	Fri, 16 Feb 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079402; cv=none; b=lBMucYwmM+VREd6sRNmb/J67/K1HieMOQy8Le3kxuF14g6BuNLQqQkoKyMsHBnjmn63X4ClN0eKs0ysSVwlGm2tdi5ftvjX3Ms3h3wAskUk7vOaqfgwIvAesr71Hps5+UWsSIPsiX9knoRfPGFAaViOapLv780tBQVQIQQqJhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079402; c=relaxed/simple;
	bh=nRq2taqq+XVslMrJ3ND/dEzSlU7hSfFj1FuNCS5WZD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkewVaGKqhZ0T5O4ABCOALGg3rCBv4lXNK6xJJsx/SZowZiqOaFgojMIHE7WSBF7OX58kQWLQEBJMVfYLRt3eic2Ruvm+uNBsfAaOIjMG8yyoYWlx+FdU7CV9i7w5eynfdVdP4uqHuOkRxuMITnR7FPzRtjSwykQfOshVJfSPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaGwzZrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDCC433C7;
	Fri, 16 Feb 2024 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708079401;
	bh=nRq2taqq+XVslMrJ3ND/dEzSlU7hSfFj1FuNCS5WZD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaGwzZrq4Qr94CfqggpesJXcHiJ5oZKuWrI0VWeMiVTNOOBL/wfZVO6FsP2A6m8x/
	 MfgCQ6yPBhhPErqgJGTnIHxo5/A02RoDmnr2jrbwfmxv42Xmm75xYaCjdcqAJaPJbo
	 7FO21loEEjIl+ErrnJNGy8HNaUiLukLCyK/rW8CE/k8/Oh2VBqQRkXdCITG0prZooM
	 uVS/2Aq8W1bXAXQA/cRUxXssRfOC9UYsDfUtogCr0lj0j41qDX+dck32jxwdfRKnMv
	 8RmG5U7t6mcu1msWt4g7PXpUAZMzEN0v7bd90j84GL5F9NyFUCrPAj3HtbjRpJU4VL
	 AEe4tMVm5WEbA==
Date: Fri, 16 Feb 2024 11:29:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, p.zabel@pengutronix.de, axboe@kernel.dk,
	michal.simek@amd.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Message-ID: <Zc85I1u5x9vh1IJI@x1-carbon>
References: <1708020060-1439879-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708020060-1439879-1-git-send-email-radhey.shyam.pandey@amd.com>

Hello Radhey,

On Thu, Feb 15, 2024 at 11:31:00PM +0530, Radhey Shyam Pandey wrote:
> Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
> error path.
> 
> To fix it create a wrapper ceva_ahci_platform_enable_resources() API which
> is a customized version of ahci_platform_enable_resources() and inline with
> SATA IP programming sequence it does:
> 
> - Assert SATA reset
> - Program PS GTR phy
> - Bring SATA by de-asserting the reset
> - Wait for GT lane PLL to be locked
> 
> It switches to ceva_ahci_platform_enable_resources() in resume path
> as same SATA programming sequence (as in probe) should be followed.
> 
> It also cleanup mix usage of ahci_platform_enable_resources() and custom
> implementation in probe function as both are not required.
> 
> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> Changes for v2:
> 
> - Create wrapper ceva_ahci_platform_enable_resources()
> - Remove legacy ahci_platform_enable_resources() and its related code.
> - Modified commit description and merge 1/2 and 2/2 fix as it is
>   automatically done when reusing ahci_platform_enable_resources()
>   logic.
> - Drop Reviewed-by: Damien Le Moal <dlemoal@kernel.org> tag.
> ---
>  drivers/ata/ahci_ceva.c | 125 +++++++++++++++++++++++++---------------
>  1 file changed, 79 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index 64f7f7d6ba84..c04f5033f981 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -88,7 +88,6 @@ struct ceva_ahci_priv {
>  	u32 axicc;
>  	bool is_cci_enabled;
>  	int flags;
> -	struct reset_control *rst;
>  };
>  
>  static unsigned int ceva_ahci_read_id(struct ata_device *dev,
> @@ -189,6 +188,60 @@ static const struct scsi_host_template ahci_platform_sht = {
>  	AHCI_SHT(DRV_NAME),
>  };
>  
> +static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
> +{
> +	int rc, i;
> +
> +	rc = ahci_platform_enable_regulators(hpriv);
> +	if (rc)
> +		return rc;
> +
> +	rc = ahci_platform_enable_clks(hpriv);
> +	if (rc)
> +		goto disable_regulator;
> +
> +	/* Assert the controller reset */
> +	rc = ahci_platform_assert_rsts(hpriv);
> +	if (rc)
> +		goto disable_clks;
> +
> +	for (i = 0; i < hpriv->nports; i++) {
> +		rc = phy_init(hpriv->phys[i]);
> +		if (rc)
> +			goto disable_rsts;
> +	}
> +
> +	/* De-assert the controller reset */
> +	ahci_platform_deassert_rsts(hpriv);
> +
> +	for (i = 0; i < hpriv->nports; i++) {
> +		rc = phy_power_on(hpriv->phys[i]);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}
> +	}
> +
> +	return 0;
> +
> +disable_rsts:
> +	ahci_platform_deassert_rsts(hpriv);
> +
> +disable_phys:
> +	while (--i >= 0) {
> +		phy_power_off(hpriv->phys[i]);
> +		phy_exit(hpriv->phys[i]);
> +	}
> +
> +disable_clks:
> +	ahci_platform_disable_clks(hpriv);
> +
> +disable_regulator:
> +	ahci_platform_disable_regulators(hpriv);
> +
> +	return rc;
> +}
> +
>  static int ceva_ahci_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -203,47 +256,19 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	cevapriv->ahci_pdev = pdev;
> -
> -	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
> -								  NULL);
> -	if (IS_ERR(cevapriv->rst))
> -		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
> -			      "failed to get reset\n");
> -
>  	hpriv = ahci_platform_get_resources(pdev, 0);
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>  
> -	if (!cevapriv->rst) {
> -		rc = ahci_platform_enable_resources(hpriv);
> -		if (rc)
> -			return rc;
> -	} else {
> -		int i;
> -
> -		rc = ahci_platform_enable_clks(hpriv);
> -		if (rc)
> -			return rc;
> -		/* Assert the controller reset */
> -		reset_control_assert(cevapriv->rst);
> -
> -		for (i = 0; i < hpriv->nports; i++) {
> -			rc = phy_init(hpriv->phys[i]);
> -			if (rc)
> -				return rc;
> -		}
> -
> -		/* De-assert the controller reset */
> -		reset_control_deassert(cevapriv->rst);
> +	hpriv->rsts = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								NULL);
> +	if (IS_ERR(hpriv->rsts))
> +		dev_err_probe(&pdev->dev, PTR_ERR(hpriv->rsts),
> +			      "failed to get reset\n");
>  

Here you just continue on even though there was an error.
You should return the error here.

It can be done in one statement:
return dev_err_probe(&pdev->dev, PTR_ERR(hpriv->rsts),
		     "failed to get reset\n");

Otherwise, this looks good.


Kind regards,
Niklas

> -		for (i = 0; i < hpriv->nports; i++) {
> -			rc = phy_power_on(hpriv->phys[i]);
> -			if (rc) {
> -				phy_exit(hpriv->phys[i]);
> -				return rc;
> -			}
> -		}
> -	}
> +	rc = ceva_ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		return rc;
>  
>  	if (of_property_read_bool(np, "ceva,broken-gen2"))
>  		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
> @@ -252,52 +277,60 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
>  					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
>  		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
>  					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
>  		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	/* Read OOB timing value for COMWAKE from device-tree*/
>  	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
>  					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
>  		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
>  					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
>  		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	/* Read phy BURST timing value from device-tree */
>  	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
>  					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
>  		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
>  					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
>  		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	/* Read phy RETRY interval timing value from device-tree */
>  	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
>  					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
>  		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
>  					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
>  		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_resources;
>  	}
>  
>  	/*
> @@ -335,7 +368,7 @@ static int __maybe_unused ceva_ahci_resume(struct device *dev)
>  	struct ahci_host_priv *hpriv = host->private_data;
>  	int rc;
>  
> -	rc = ahci_platform_enable_resources(hpriv);
> +	rc = ceva_ahci_platform_enable_resources(hpriv);
>  	if (rc)
>  		return rc;
>  
> -- 
> 2.34.1
> 

