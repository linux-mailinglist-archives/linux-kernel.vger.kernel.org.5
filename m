Return-Path: <linux-kernel+bounces-122779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E688FD23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D53E1F28F40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A77CF18;
	Thu, 28 Mar 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD/g23Ny"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4072561D;
	Thu, 28 Mar 2024 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622010; cv=none; b=RFMFQ5c9A6m1TdCAufv8wbnluR8IjZfchL0kDWQaoGb6U86vcGAnpjxzQ+zyWoiUgSLdbjPCYeoJjAx4t3tYqglHQwXrRQVHbIdcJ92gypCYWNYnHxmQFH8nUCj/rHZRTts3GuPgSihFZIHBLoMh8BFAxhX89OweblwFCfFBcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622010; c=relaxed/simple;
	bh=iU1tUXhCDwyIc1WbR0eWG2uv/PUO2eklfA03DFfPGIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKoNzmXcRY6LFDJHN8Q3TBaYl1WFqmy+OH9Wx5EJLmqxnrngDtB7+aGwoSuA2gBEafmi4NPuIvMqFTYAz9dMhYnk/cXOWHx+l/XmpqjiWv46p6h9G5atgbPmFBQIS+RlYpqHAD0eKkJevJDf+wjd3PLAbbE/xFzPrvG+YuJpB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD/g23Ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFA3C433F1;
	Thu, 28 Mar 2024 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711622009;
	bh=iU1tUXhCDwyIc1WbR0eWG2uv/PUO2eklfA03DFfPGIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZD/g23NyMfnrDXqG9nJ1YMij3C0sSLv35lOLM6I9BSJqsUT1hiiQARxtBH9p4W0Y8
	 lZDNdqc3LZiWPsO0cjNC7pnKr+Xqrl3k1Iz8COAOHsXzy3CSDuPpVcUVvPxwJRf6TK
	 1utgva25c83ZOhTWXEmEhXUcKIFKR3i1RdNQRSLnq9eew7CAwx/eXKSSSTNZVLGZIC
	 cPYP+5y/+gLNIVN+mAfHD6OoVfPo2SZVcNeWPNC02XTBC9UAVMxjVh63OnAXqOJqkA
	 0D9ooBcZ7VJHzgYyQK7yLksLvjfR96ZtgUyPElsmjRNdRYA6g6jb4DNgUqixVSN762
	 QkJoOvn5zIdKg==
Date: Thu, 28 Mar 2024 10:33:22 +0000
From: Simon Horman <horms@kernel.org>
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
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240328103322.GX403975@kernel.org>
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

On Tue, Mar 26, 2024 at 03:04:47PM +0100, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> The Power Sourcing Equipment Power Interface (PSE PI) plays a pivotal role
> in the architecture of Power over Ethernet (PoE) systems. It is essentially
> a blueprint that outlines how one or multiple power sources are connected
> to the eight-pin modular jack, commonly known as the Ethernet RJ45 port.
> This connection scheme is crucial for enabling the delivery of power
> alongside data over Ethernet cables.
> 
> This patch adds support for getting the PSE controller node through PSE PI
> device subnode.
> 
> This supports adds a way to get the PSE PI id from the pse_pi devicetree
> subnode of a PSE controller node simply by reading the reg property.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Hi Kory,

Some minor documentation nits from my side.

> diff --git a/Documentation/networking/pse-pd/pse-pi.rst b/Documentation/networking/pse-pd/pse-pi.rst

..

> +Table 145\u20133\u2014PSE Pinout Alternatives
> +-----------------------------------

When running make htmldocs I see the following warning:

Table 145\u20133\u2014PSE Pinout Alternatives

And the header is rendered as:

Table 145u20133u2014PSE Pinout Alternatives

I'm assuming my version of Sphinx doesn't understand the use
of escape sequences for unicode characters here.

I have observed this with (I assume this is the relevant command):

$ sphinx-build --version
sphinx-build 7.2.6

$ sphinx-build --version
sphinx-build 6.2.1

..

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c

..

>  /**
> - * of_pse_zero_xlate - dummy function for controllers with one only control
> - * @pcdev: a pointer to the PSE controller device
> - * @pse_spec: PSE line specifier as found in the device tree
> - *
> - * This static translation function is used by default if of_xlate in
> - * :c:type:`pse_controller_dev` is not set. It is useful for all PSE
> - * controllers with #pse-cells = <0>.
> + * of_load_pse_pi_pairset - load PSE PI pairsets pinout and polarity

nit: of_load_pse_pi_pairsets

> + * @node: a pointer of the device node
> + * @pi: a pointer of the PSE PI to fill
> + * @npairsets: the number of pairsets (1 or 2) used by the PI
>   */
> -static int of_pse_zero_xlate(struct pse_controller_dev *pcdev,
> -			     const struct of_phandle_args *pse_spec)
> +static int of_load_pse_pi_pairsets(struct device_node *node,
> +				   struct pse_pi *pi,
> +				   int npairsets)

..

> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h

..

> @@ -73,11 +103,11 @@ struct pse_control;
>   * @pse_control_head: head of internal list of requested PSE controls
>   * @dev: corresponding driver model device struct
>   * @of_pse_n_cells: number of cells in PSE line specifiers
> - * @of_xlate: translation function to translate from specifier as found in the
> - *            device tree to id as given to the PSE control ops
>   * @nr_lines: number of PSE controls in this controller device
>   * @lock: Mutex for serialization access to the PSE controller
>   * @types: types of the PSE controller
> + * @pi: table of PSE PIs described in this controller device
> + * @of_legacy: flag set if the pse_pis devicetree node is not used

nit: it looks line the documentation didn't keep up with the
     structure during development: @no_of_pse_pi should be
     documented instead of @of_legacy.

>   */
>  struct pse_controller_dev {
>  	const struct pse_controller_ops *ops;
> @@ -86,11 +116,11 @@ struct pse_controller_dev {
>  	struct list_head pse_control_head;
>  	struct device *dev;
>  	int of_pse_n_cells;
> -	int (*of_xlate)(struct pse_controller_dev *pcdev,
> -			const struct of_phandle_args *pse_spec);
>  	unsigned int nr_lines;
>  	struct mutex lock;
>  	enum ethtool_pse_types types;
> +	struct pse_pi *pi;
> +	bool no_of_pse_pi;
>  };

..

