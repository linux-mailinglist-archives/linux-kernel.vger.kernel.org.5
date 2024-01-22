Return-Path: <linux-kernel+bounces-33066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1A836416
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FFB2B2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2996C3C6B3;
	Mon, 22 Jan 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZxcRMHt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8E3C693;
	Mon, 22 Jan 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928578; cv=none; b=d4YxRHdTmmBYv7d+BNZun9B1HeznnyFZNxyYaiFCPCetuxAZmOyNeg/c/6I6eYrAzwfbzRjsn6jfPXxUvPbEZ9+IGXQqRdCQBC5ua0TNsZYZdX1RfonbuUnnvprX+MiWbhcmP7IOM6rfuG+rDg0i7hStbU1L808valnIfJzsBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928578; c=relaxed/simple;
	bh=HyHjYdHa+L59MRE2OXPZJnIepLxyNNeoKImVqWz4UOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKx/wI/pb0yKLujb+17srcxZ+ZusKjhT+zCrqz7AeX1iX1CsII8dzEn2+iJJAR+O89LG+Pa9fkaP4ok47N0iyEYJT6WcnnHCXeFWQ/CYTyI2+xvAOfULbRBuoFfePBxLUSuswuyqlMvxW1K63OeNxOk+aJc+c7htuuZMMyVQzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZxcRMHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6313EC43394;
	Mon, 22 Jan 2024 13:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705928577;
	bh=HyHjYdHa+L59MRE2OXPZJnIepLxyNNeoKImVqWz4UOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZxcRMHtb0FwHVxpUFkqUmkIFmkxdncVqtzpfyOPF6x1irzegi2AhaiocRE4emT+S
	 DghN1LP9G0ctAKEX60ln2k8dFAjAkhsANBOt1TNnA6M15Z+yDtFmWV4kNOVwXEpDll
	 20kR7PWBmirzynSbndcCTQLbGxq1avq+6b7o87e7ZlQxfQ8vEtW8/xjD+eBVGRS3S3
	 xf4SvifTr62lmmXsDolcQZg5YEU94BuXPsT7YB1/0aZ6VNmvJE00/MJvw3H7IRL76J
	 ZJY8Y48xrBjNfw+19qgXLeXLWVik4llhztCcpD6DJgZWelfETSvvHuY+BM3n57sq3q
	 dcEKEu+vMEuxw==
Date: Mon, 22 Jan 2024 14:02:48 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: dlemoal@kernel.org, richardcochran@gmail.com, piyush.mehta@xilinx.com,
	axboe@kernel.dk, michal.simek@amd.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com,
	Piyush Mehta <piyush.mehta@amd.com>
Subject: Re: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Message-ID: <Za5neDYN9Dh+GwRG@x1-carbon>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>

Hello Radhey,

On Fri, Jan 19, 2024 at 12:38:23AM +0530, Radhey Shyam Pandey wrote:
> From: Piyush Mehta <piyush.mehta@amd.com>
> 
> Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
> error path. To fix introduce error label for ahci_platform_disable_clks and
> phy_power_off/exit and call them in error path. No functional change.
> 
> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> ---
>  drivers/ata/ahci_ceva.c | 47 +++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index 64f7f7d6ba84..bfc513f1d0b3 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -196,7 +196,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  	struct ahci_host_priv *hpriv;
>  	struct ceva_ahci_priv *cevapriv;
>  	enum dev_dma_attr attr;
> -	int rc;
> +	int rc, i;
>  
>  	cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
>  	if (!cevapriv)
> @@ -219,8 +219,6 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  		if (rc)
>  			return rc;
>  	} else {
> -		int i;
> -
>  		rc = ahci_platform_enable_clks(hpriv);
>  		if (rc)
>  			return rc;
> @@ -229,8 +227,11 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  
>  		for (i = 0; i < hpriv->nports; i++) {
>  			rc = phy_init(hpriv->phys[i]);
> -			if (rc)
> -				return rc;
> +			if (rc) {
> +				while (--i >= 0)
> +					phy_exit(hpriv->phys[i]);

It is ugly to have a loop both here and at the end of the function.
Why don't you just goto disable_phys here?

Just like how it is done in ahci_platform_enable_phys():
https://github.com/torvalds/linux/blob/v6.7/drivers/ata/libahci_platform.c#L52-L54


> +				goto disable_clks;
> +			}
>  		}
>  
>  		/* De-assert the controller reset */
> @@ -240,7 +241,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  			rc = phy_power_on(hpriv->phys[i]);
>  			if (rc) {
>  				phy_exit(hpriv->phys[i]);
> -				return rc;
> +				goto disable_phys;
>  			}
>  		}
>  	}
> @@ -252,52 +253,60 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
>  					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
>  		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
>  					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
>  		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	/* Read OOB timing value for COMWAKE from device-tree*/
>  	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
>  					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
>  		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
>  					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
>  		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	/* Read phy BURST timing value from device-tree */
>  	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
>  					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
>  		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
>  					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
>  		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	/* Read phy RETRY interval timing value from device-tree */
>  	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
>  					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
>  		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
>  					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
>  		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
> -		return -EINVAL;
> +		rc = -EINVAL;
> +		goto disable_phys;
>  	}
>  
>  	/*
> @@ -321,6 +330,16 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  
>  disable_resources:
>  	ahci_platform_disable_resources(hpriv);

Looking at ahci_platform_disable_resources(),
it calls ahci_platform_disable_phys(), which calls
phy_power_off() and phy_exit().

This means that if you jump to disable_resources,
you will call phy_power_off() and phy_exit() twice.
Looking at the phy code, it does not handle these functions being called
twice.


You already call ahci_platform_get_resources(), so why don't you just set
AHCI_PLATFORM_GET_RESETS, that way you should be able to remove a bunch of
duplicated code from this driver.

One major difference seems to be that ahci_platform_enable_resources() does
not assert reset before deasserting it.
Can't we just add a reset_control_assert() + some small usleep
(e.g. usleep_range(1000, 1500)) before the reset_control_deassert()?
Have you tried doing that?


Kind regards,
Niklas

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
>  	return rc;
>  }
>  
> -- 
> 2.34.1
> 

