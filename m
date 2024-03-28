Return-Path: <linux-kernel+bounces-123228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A38904D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834861C2B122
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD3131E2C;
	Thu, 28 Mar 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J7yL1gUo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628512FB3B;
	Thu, 28 Mar 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642681; cv=none; b=MjIfBF3FbZGVXWU5jmBvS0r4kvSyOJ+R1IyYhWVWdWhkTKJxOli+2fmD9sMTWoOCdSri5DZOIoWu98OaM/ciM/qEOxiGEffHyeWzprWbXin5LQA51o6rnW58CNElGGJkcqT1KgzYvDqueonT56bij+nOc07rBS+sZKprFYTAmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642681; c=relaxed/simple;
	bh=CUt5KfeP+l5yUe9HnF3DHAzsNYXwbmVH7ufJpBD+/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4qRlAZj/Zr3FM8/D6PUIoM/1Vepce1d9YHU8W98v+WKlDjnSwzq2FVfMeSQJJdxbWsFWltcKe502tsfJzQE6O5TAV0G7CoAdCeHHPtaxShnSv+ksdcOap3/3IA0D7rYaOLZOnkDCs3WnktI1AY8hWb6nSGga8rdaPsSUedhzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J7yL1gUo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7mAyGOzTn2Y/okweEUHaGbm55gJwqANfs4q2cLyLvHU=; b=J7yL1gUohhm9vn127Rxrx6UJFQ
	RdbnX4GBzGg8Ios3r1ooX3nLAV15QTHr3PDOr8NFkYRR4NkyXcUNKHI9rMRFhfQ1YrfKggoSqEO4y
	aqPlMuKnbCOonQOiztV/DZUOTr6yCrldw6Kii8wBujpWu2b2QqnjPdhYNLUdTbHxSqG0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpsRj-00BWOM-N0; Thu, 28 Mar 2024 17:17:43 +0100
Date: Thu, 28 Mar 2024 17:17:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <0cc9923f-2907-471e-81b0-2ca01a6e8c79@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>

> +static int
> +tps23881_get_unused_chan(struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS],
> +			 int port_cnt)
> +{
> +	bool used;
> +	int i, j;
> +
> +	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +		used = false;
> +
> +		for (j = 0; j < port_cnt; j++) {
> +			if (port_matrix[j].hw_chan[0] == i) {
> +				used = true;
> +				break;
> +			}
> +
> +			if (port_matrix[j].is_4p &&
> +			    port_matrix[j].hw_chan[1] == i) {
> +				used = true;
> +				break;
> +			}
> +		}
> +
> +		if (!used)
> +			return i;
> +	}
> +
> +	return -1;

nitpick: Return -ENODEV.

> +	while (cnt_4ch_grp1 < 4) {
> +		ret = tps23881_get_unused_chan(tmp_port_matrix, port_cnt);
> +		if (ret < 0) {
> +			pr_err("tps23881: port matrix issue, no chan available\n");
> +			return -ENODEV;

and then just returns ret.

> +static int
> +tps23881_set_ports_conf(struct tps23881_priv *priv,
> +			struct tps23881_port_matrix port_matrix[TPS23881_MAX_CHANS])
> +{
> +	struct i2c_client *client = priv->client;
> +	int i, ret;
> +	u16 val;
> +
> +	/* Set operating mode */
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_OP_MODE, 0xaaaa);

Could you add some #defines here? This is semiauto i think?

> +	if (ret)
> +		return ret;
> +
> +	/* Disable DC disconnect */
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DIS_EN, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set port power allocation */
> +	val = 0;
> +	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +		if (!port_matrix[i].exist)
> +			continue;
> +
> +		if (port_matrix[i].is_4p)
> +			val |= 0xf << ((port_matrix[i].lgcl_chan[0] / 2) * 4);
> +		else
> +			val |= 0x3 << ((port_matrix[i].lgcl_chan[0] / 2) * 4);
> +	}
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_PORT_POWER, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable detection and classification */
> +	val = 0;
> +	for (i = 0; i < TPS23881_MAX_CHANS; i++) {
> +		if (!port_matrix[i].exist)
> +			continue;
> +
> +		val |= BIT(port_matrix[i].lgcl_chan[0]) |
> +		       BIT(port_matrix[i].lgcl_chan[0] + 4);
> +		if (port_matrix[i].is_4p)
> +			val |= BIT(port_matrix[i].lgcl_chan[1]) |
> +			       BIT(port_matrix[i].lgcl_chan[1] + 4);
> +	}
> +	ret = i2c_smbus_write_word_data(client, TPS23881_REG_DET_CLA_EN, 0xffff);

This looks odd. You calculate val, and then don't use it?

     Andrew

