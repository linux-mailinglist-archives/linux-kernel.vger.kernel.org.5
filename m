Return-Path: <linux-kernel+bounces-122883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B47388FEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C71C2241B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90D97F496;
	Thu, 28 Mar 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cgii5U/Z"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2F7F485;
	Thu, 28 Mar 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628659; cv=none; b=HMinkxwEPBcXU1gVL0bi9eo6o64hrA51Fc2WOT3easX0c+Gd3l60t9oGPufXcB3fa5swCy2bao7fjF1sGGsmx3u9Xru1N7MNH0L+BETiXYPfTXlcpE15QKtaPpMzpnEJSXZR0BgZVVdTaXyBO8nfWVcTAGAu+6wEcRWrl18U3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628659; c=relaxed/simple;
	bh=+KCpP6QH6INCKmhY3rhkXinCYArDLnJgU17pzm7N1sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNpbRZhDoQ6LcwddvRm++hGPNBTDwn0Ct9l91p75f6K1SaRN34V844ato4/h+BpagLPd2JxBeuKlwo6p+bTnFTTyiSOc3svdZEXgINMo0U6vs0T99IAOjZfVtQtSr7LC/TSrrBRHgpSdhEHWb4qeu/ycVvxBLglJ8/nkq9GkSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cgii5U/Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8unRPUJ/5NLXOy2GV/8QQoMtBxlZYcDA0JkZRYJPSXM=; b=cgii5U/Zdj30Vfz4+zeTdE+LAO
	Wceqxp0Y0bklH/H+HFEbAhSOhK2yWdOTmvX32t8UmGpSJt1/nccyQcBHCZ5/PtoRNu2W0zBDiFgBS
	uZ6w8TsaVbd2TYRFQVJeVLfxqWZ9cohtpMU1DECoc1qdqcn2V7Lkq74uvf9RJ7ltp+f4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rponY-00BUi7-46; Thu, 28 Mar 2024 13:24:00 +0100
Date: Thu, 28 Mar 2024 13:24:00 +0100
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
Subject: Re: [PATCH net-next v6 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <f3bafb50-406b-444a-8411-5ddae8d84c31@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-10-c1011b6ea1cb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-feature_poe-v6-10-c1011b6ea1cb@bootlin.com>

> +.. code-block::
> +
> +         +-------------+
> +         |    PSE PI   |
> + 8  -----+                             +-------------+
> + 7  -----+                    Rail 1   |
> + 6  -----+------+----------------------+
> + 5  -----+      |                      |
> + 4  -----+     /              Rail 2   |  PSE 1
> + 3  -----+----?          +-------------+
> + 2  -----+----+---------?              |
> + 1  -----+---?                         +-------------+
> +         |
> +         +-------------+

Is ? a standard markup character? I don't remember seeing it used like
this before.

Maybe offset the connection for pins 1 and 2 from that of 3. I mean:

> + 4  -----+     /              Rail 2   |  PSE 1
> + 3  -----+----?          +-------------+
> + 2  -----+--------+-----?              |
> + 1  -----+-------?                     +-------------+

You version is a little ambiguous, pins 1, 2 & 3 could be
interconnected at the +.  The text does however make it clear they are
not, but i don't see any harm in making the diagram clearer.

> +static int of_load_single_pse_pi_pairset(struct device_node *node,
> +					 struct pse_pi *pi,
> +					 int pairset_num)
> +{
> +	struct device_node *pairset_np;
> +	const char *name;
> +	int ret;
> +
> +	ret = of_property_read_string_index(node, "pairset-names",
> +					    pairset_num, &name);
> +	if (ret)
> +		return ret;
> +
> +	if (!strcmp(name, "alternative-a")) {
> +		pi->pairset[pairset_num].pinout = ALTERNATIVE_A;
> +	} else if (!strcmp(name, "alternative-b")) {
> +		pi->pairset[pairset_num].pinout = ALTERNATIVE_B;
> +	} else {
> +		pr_err("pse: wrong pairset-names value %s\n", name);
> +		return -EINVAL;

Maybe include the node path in the error message? For a 24 port
switch, it will help find a typo in one of the ports. I would do this
for all error messages in this code.

Please add my Reviewed-by on the next version.

       Andrew

