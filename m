Return-Path: <linux-kernel+bounces-156056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35A8AFD56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C351F23146
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316BA256D;
	Wed, 24 Apr 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BsXN047C"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59421C14;
	Wed, 24 Apr 2024 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918465; cv=none; b=Wu+foObWQzYJEES+EBaWaYS8b4JtfhouJsPrprMHQ7HyBdm71kF54QRxtBsb2pgogICEDHVfcAW8WdXS62ayIO+FeuOloOpqiYNiJdV126igfJuKWgMGdMg2TqtkLuUYNPTpBjJGOWTWs/JwKvWpPqMPp3TJSqdnHjw70x8ydQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918465; c=relaxed/simple;
	bh=hMVdeOjzCcWM0sHJB6+XBEyYprE9EQmvrZy15OVVkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8Z3Aci5WUdnhbHnAMqX9z9QwZLDKmkFQd5+H8E57GtpKqwp2FMd25B4GU47Z/askXc4OechMcABU65a05Rz9Y2hpVGScib9KYoWXJrLuOfhrsId+kLwtcP96RSKmBIJz63m0WnJgQh1qhr+4MYfkwZUs8qW/j6LMMPARxZNyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BsXN047C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/uUK99t9+7kF0ZmVH8V0LL/FNsMRpVs2GHtXWBhvpMU=; b=BsXN047C+kTFlWgmsKTX/+VHq+
	IhpIQrBWh/QeHa2JZKz2QmefcwNxQJImlGrUv59ObYyrG06CMu+euwca+hJmkx+/Z8X74ur0tqs7I
	rX4wzjOVFmaxNEfgh0EwTMEMNK19JYMRXv1gCatn1nOA/TFDUajEbdA6vlhnIAcBTmMs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzQTu-00DlRL-L9; Wed, 24 Apr 2024 02:27:26 +0200
Date: Wed, 24 Apr 2024 02:27:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <231ce196-6a68-4f09-8f9a-976c5ce1495d@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>

> +/* OPEN Alliance Configuration Register #0 */
> +#define OA_TC6_REG_CONFIG0		0x0004
> +#define CONFIG0_ZARFE_ENABLE		BIT(12)

If this is a standard register, you should put these defined where
other drivers can use them.

> +static int lan865x_set_mac_address(struct net_device *netdev, void *addr)
> +{
> +	struct lan865x_priv *priv = netdev_priv(netdev);
> +	struct sockaddr *address = addr;
> +	int ret;
> +
> +	ret = eth_prepare_mac_addr_change(netdev, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ether_addr_equal(address->sa_data, netdev->dev_addr))
> +		return 0;
> +
> +	ret = lan865x_set_hw_macaddr(priv, address->sa_data);
> +	if (ret)
> +		return ret;
> +
> +	eth_hw_addr_set(netdev, address->sa_data);

It seems more normal to call eth_commit_mac_addr_change(), which
better pairs with eth_prepare_mac_addr_change().

> +static int lan865x_set_zarfe(struct lan865x_priv *priv)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(priv->tc6, OA_TC6_REG_CONFIG0, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Set Zero-Align Receive Frame Enable */
> +	regval |= CONFIG0_ZARFE_ENABLE;
> +
> +	return oa_tc6_write_register(priv->tc6, OA_TC6_REG_CONFIG0, regval);
> +}

There does not appear to be anything specific to your device here. So
please make this a helper in the shared code, so any driver can use
it.

	Andrew

