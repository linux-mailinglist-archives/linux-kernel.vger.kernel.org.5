Return-Path: <linux-kernel+bounces-8092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3981B212
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6ED1F25119
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387DA48CC2;
	Thu, 21 Dec 2023 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HQsCbD6e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120142057;
	Thu, 21 Dec 2023 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ChggBcLmx6xwxdONtamQnLuhemi42z+fo6lA2pWbhwU=; b=HQsCbD6eY5xpXuXZGUXu93WyEe
	nOyyL37w1Bep+gwZr3pQn4nY6yLqcGcVt2/ot24rvwDI0W1nyIuWB8OQjXvQ9j0fjr6eGQ/apIKk9
	0SpolhYokHIzP8K8Nh8QqsbPAmZV2GV4Q9o1SZjW7Hz4OiSyf+UYz55x6+AlH6w08F4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rGF10-003UXK-3p; Thu, 21 Dec 2023 10:06:50 +0100
Date: Thu, 21 Dec 2023 10:06:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, wens@csie.org, samuel@sholland.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v5 1/3] phy: handle optional regulator for PHY
Message-ID: <f729baa5-7986-4841-8cd6-fc4bdc652f75@lunn.ch>
References: <20231220203537.83479-1-jernej.skrabec@gmail.com>
 <20231220203537.83479-2-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220203537.83479-2-jernej.skrabec@gmail.com>

> +static int
> +fwnode_regulator_get_bulk_enabled(struct device *dev,
> +				  struct fwnode_handle *fwnode,
> +				  struct regulator_bulk_data **consumers)
> +{
> +	struct device_node *np;
> +	int ret, reg_cnt;
> +
> +	np = to_of_node(fwnode);
> +	if (!np)
> +		return 0;
> +
> +	reg_cnt = of_regulator_bulk_get_all(dev, np, consumers);
> +	if (reg_cnt < 0) {
> +		ret = reg_cnt;
> +		goto clean_consumers;
> +	}
> +
> +	if (reg_cnt == 0)
> +		return 0;

I've not used regulators much, but i think you can combine these two
into one. Its guaranteed *consumer is NULL if reg_cnt == 0. And
kfree() is happy with a NULL pointer.

> +
> +	ret = regulator_bulk_enable(reg_cnt, *consumers);
> +	if (ret)
> +		goto clean_consumers;

I would expect this to be part of mdio_device_reset(), same as the
GPIO, and reset controller, but first obviously. And parsing DT should
happen in a similar place to parsing the reset GPIO and reset
controller.

	Andrew

