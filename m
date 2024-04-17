Return-Path: <linux-kernel+bounces-147839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414608A7A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFF32839C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA463AE;
	Wed, 17 Apr 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5wayfYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9A4430;
	Wed, 17 Apr 2024 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320120; cv=none; b=N+/XXfn8U2B/mRbH8pllcTfPs+UY1Q4MPUoj4L4CPL4Xi6jyEQS2dsv+WgL8Idt3DO56HhQOUKylgJg1A/7Dp2XO3DG9MIsHBEkTBQEWm86JULhIJODTMTWZmRjbd3Lo0ZtrOkyG2wX3501BxZpuYQLRjikBtF4U310qTZEe9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320120; c=relaxed/simple;
	bh=KcjW4v9LPhuP/rC4Hb0v6FD940Tv/do/SHcz+AsZO6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+n/tQb1DvmUCrR3hqwsYblNITcUiFSzpsZfK5NNapVRa2A8GnitZ4XH9MHnHsGPBLFsmReAASJySrBSH4OBvqymMQV1e/oLCnk1eo+cHbJPD3jG4Qsune+LXDRJO36XYjYXO/u1hqrJdxwtx+SoJFsnBcK8WLlkQjaDoJ+ctsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5wayfYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA29C113CE;
	Wed, 17 Apr 2024 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713320119;
	bh=KcjW4v9LPhuP/rC4Hb0v6FD940Tv/do/SHcz+AsZO6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5wayfYwbiuwQnVYrPQlpT72jghBvBMQC6rckXjnlBaNiTaRmHcoR8vmJ5oz8Nx9X
	 Js+6FebnrF9YaP+4rDpGNQVtDOiFvhHaS6ggMkuwFUwvUimaawBbhEvqZyiFzq2S8l
	 CWzB483BmU7R+fWbigPbXvlqLeJONF3zfS3O9BCsB5EgUHJfVG0/NTgkmh+I2sfsyv
	 W/dN7gw9gF11ciLXU5fthI/js3PrMcdqFP17WYrV3kL1qJ1sEWa8vM4C65lwgPAi57
	 VVyJ28M/BuTt2H7t44+/BLabCrxQkbVd68hw/q5oLMQUyr5wXqrCA4uDKomH/uTHMV
	 sePX1d+1W0ZyQ==
Date: Tue, 16 Apr 2024 19:15:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240416191517.65c63e21@kernel.org>
In-Reply-To: <20240414-feature_poe-v8-10-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-10-e4bf1e860da5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 16:21:59 +0200 Kory Maincent wrote:
> +/**
> + * of_pse_match_pi - Return the PSE PI id of the device node phandle
> + * @pcdev: a pointer to the PSE controller device
> + * @np: a pointer to the device node
> + */
> +static int of_pse_match_pi(struct pse_controller_dev *pcdev,

There's new nitpick from kernel-doc - if the function returns something
the kdoc needs to document Return:  ..

Sorry I missed this check failing because the fact that the series is
17 patches lights it up as red in patchwork :( I'll apply the first
3 patches to make v9 smaller.

> +			   struct device_node *np)
> +{
> +	int i;
> +
> +	for (i = 0; i <= pcdev->nr_lines; i++) {
> +		if (pcdev->pi[i].np == np)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * psec_id_xlate - translate pse_spec to the PSE line number according
> + *		   to the number of pse-cells in case of no pse_pi node
> + * @pcdev: a pointer to the PSE controller device
> + * @pse_spec: PSE line specifier as found in the device tree
> + *
> + * Return 0 if #pse-cells = <0>. Return PSE line number otherwise.

here missing ":"

> + */
> +static int psec_id_xlate(struct pse_controller_dev *pcdev,
> +			 const struct of_phandle_args *pse_spec)

