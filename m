Return-Path: <linux-kernel+bounces-85043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EFB86AF88
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5417A1F26D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73E3149DEC;
	Wed, 28 Feb 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqiWmt8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C9145B27;
	Wed, 28 Feb 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124832; cv=none; b=ZX3G2ORGXoDD/jJtuqWCLWrRLEi5R3OkjVCOAqr+byHskql9rIfwCCJbF+18WHt3my9WyYxlDpow68H1D36lkwxgaVSLnkFnHc7BW8WM+cb8GsKdGa1eI4Fowbj++FioiE2978rIr/V+VjamFqS6aOCRCjPx8kN9ggdUXCi5Phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124832; c=relaxed/simple;
	bh=hnckyr9CzJCyvSre06+L3PLt3fvc2S88cMfyIGRjMdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie3P8IFq/RJvOJ57pPSon9M0+Ou4WRMJfTlU7lsMqfD+Je6Eu16tNMfbUaCWfLTjv0bhStWjdm1yeAS8sSL4RfkyiK/+9N5TyaTD87+Y5Lhp92zVd3GvA2IIQ7/ZS2a9vdCgfP3ZLVTuFDZ4HnIK4zVtMq/KATYhb+/ZVfjunDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqiWmt8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E50C433F1;
	Wed, 28 Feb 2024 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709124831;
	bh=hnckyr9CzJCyvSre06+L3PLt3fvc2S88cMfyIGRjMdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqiWmt8afGNGKTglMVNXTBYEU7fUZPKVfOCmzRyjEB9rnkGIawsMCpGR7XBaoKNWS
	 nMdiNr4SpNF+zJCiJhC8aPZTkLgvuaaq9ILWgWP8Nm70Dge+L5auiBcsWE5L2kVTA0
	 gsFDVaCiYqhD34Wpmgxoaw6SsgRnEr2LnMNa3n8xa0wufr8tcRhH2V7oKzmnRM5nwB
	 /SkeH92K8kgx9zWFc+pDSSZzaQSy8ZJ2gX3UXQaj8tCr3/lIq02M5V2FRQdlAfhgdm
	 re7dNUuCXvg9ilq3OVX2kQM26FhoWykZomTSV0BMSo0JpkuHeqFGg29FFuasgBrjRy
	 303cbhKn19B+Q==
Date: Wed, 28 Feb 2024 12:53:44 +0000
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
Subject: Re: [PATCH net-next v5 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <20240228125344.GD292522@kernel.org>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
 <20240227-feature_poe-v5-17-28f0aa48246d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227-feature_poe-v5-17-28f0aa48246d@bootlin.com>

On Tue, Feb 27, 2024 at 03:42:59PM +0100, Kory Maincent wrote:
> Add a new driver for the TI TPS23881 I2C Power Sourcing Equipment
> controller.
> 
> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

..

> +static int tps23881_flash_fw_part(struct i2c_client *client,
> +				  const char *fw_name,
> +				  const struct tps23881_fw_conf *fw_conf)
> +{
> +	const struct firmware *fw = NULL;
> +	int i, ret;
> +
> +	ret = request_firmware(&fw, fw_name, &client->dev);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(&client->dev, "Flashing %s\n", fw_name);
> +
> +	/* Prepare device for RAM download */
> +	while (fw_conf->reg) {
> +		ret = i2c_smbus_write_byte_data(client, fw_conf->reg,
> +						fw_conf->val);
> +		if (ret < 0)

Hi Kory,

Should fw be released here.

> +			return ret;
> +
> +		fw_conf++;
> +	}
> +
> +	/* Flash the firmware file */
> +	for (i = 0; i < fw->size; i++) {
> +		ret = i2c_smbus_write_byte_data(client,
> +						TPS23881_REG_SRAM_DATA,
> +						fw->data[i]);
> +		if (ret < 0)

And here?

Flagged by Smatch.

> +			return ret;
> +	}
> +
> +	release_firmware(fw);
> +
> +	return 0;
> +}

..


