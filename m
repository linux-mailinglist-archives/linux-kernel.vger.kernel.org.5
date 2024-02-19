Return-Path: <linux-kernel+bounces-71619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C785A7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BD31C22C69
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549B3BB4F;
	Mon, 19 Feb 2024 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFGY22TG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708463A8F4;
	Mon, 19 Feb 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358032; cv=none; b=OL0d1sp357XfPeHnfvLY+r/wAUGUaLSUdzhcJMs4DjqdTN2cEmhErM9uuP+MqOhHsxxheuXa9KR5Qp9spMCdhEnwygly8dsn7ZXDuZTQTkCdtLdJgS22eVTqCjkwxXMHNtodxPz77WJnG1UICtkJgqAh3ljxB/CszQ2CsO0QQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358032; c=relaxed/simple;
	bh=6G3GU8dr597vPaA7pZYko5goQ5rMTkG18ePAdSOWOM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kooeG/gh67FN6Uis6mN0q2eBARLNtjEN8EuC3wbctHIhOw9quI4KsHifPW3nmq6/UXaO55L7stJm9u3tfFwcypgt45d3cecPSlVjktrO3DPnf2KjWqyWqzhSTwPLKoMKFktWKQoTaYFecI+Z2YPr+cjWIsmKf+HIBz1o1dn94gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFGY22TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86ABC433C7;
	Mon, 19 Feb 2024 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708358032;
	bh=6G3GU8dr597vPaA7pZYko5goQ5rMTkG18ePAdSOWOM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFGY22TGcEBqLLImEFZ6ZwvPm2dUA6C3NhX9GH4dldBXTAiFz9DpLPFz9SMdhPDAc
	 ihE9R2khzR2nXdAOFYSQbRrw48C3EjgwjG2ynEzBElVzf33sD1/ei9Y+I9O53PPMyL
	 4ElLvBhN2IQAWHRo3hooBJ8hhpCphb4kn3f33hiRJ58MTn9GHv2xl6r6l+ftA7dzFZ
	 6cqd0sbh6HjjfPGip77JfB7Ijae0CXK+NHxwIbr2qyAkt5mHGtpCOSN3Of96s82KTs
	 HZGaBdBBE2kv1yJ5rBIhY1Lk0HBRqoOi4zLXLXVW98HJs2S/arpop5FzwJueRv3T7v
	 DvyWcAAFGlmCQ==
Date: Mon, 19 Feb 2024 15:53:46 +0000
From: Simon Horman <horms@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] net: hisilicon: add support for hisi_femac core
 on Hi3798MV200
Message-ID: <20240219155346.GE40273@kernel.org>
References: <20240216-net-v2-0-89bd4b7065c2@outlook.com>
 <20240216-net-v2-1-89bd4b7065c2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-net-v2-1-89bd4b7065c2@outlook.com>

On Fri, Feb 16, 2024 at 06:02:00PM +0800, Yang Xiwen via B4 Relay wrote:

..

> @@ -826,15 +847,32 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>  						 priv->phy_reset_delays,
>  						 DELAYS_NUM);
>  		if (ret)
> -			goto out_disable_clk;
> +			goto out_free_netdev;
>  		hisi_femac_phy_reset(priv);
>  	}
>  
> +	// Register the optional MDIO bus
> +	for_each_available_child_of_node(node, mdio_np) {
> +		if (of_node_name_prefix(mdio_np, "mdio")) {
> +			priv->mdio_pdev = of_platform_device_create(mdio_np, NULL, dev);
> +			of_node_put(mdio_np);
> +			if (!priv->mdio_pdev) {
> +				dev_err(dev, "failed to register MDIO bus device\n");
> +				goto out_free_netdev;

Hi Yang Xiwen,

out_free_netdev will return ret.
However, it seems that ret is uninitialised here.
Perhaps it should be set to a negative error value?

Flagged by Smatch.

> +			}
> +			mdio_registered = true;
> +			break;
> +		}
> +	}
> +
> +	if (!mdio_registered)
> +		dev_warn(dev, "MDIO subnode notfound. This is usually a bug.\n");
> +
>  	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>  	if (!phy) {
>  		dev_err(dev, "connect to PHY failed!\n");
>  		ret = -ENODEV;
> -		goto out_disable_clk;
> +		goto out_unregister_mdio_bus;
>  	}
>  
>  	phy_attached_print(phy, "phy_id=0x%.8lx, phy_mode=%s\n",

..

