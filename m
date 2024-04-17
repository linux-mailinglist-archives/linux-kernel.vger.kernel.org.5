Return-Path: <linux-kernel+bounces-148401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F058A81FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE8F28157E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4A13C9B0;
	Wed, 17 Apr 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2RYA6ggw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A213C80E;
	Wed, 17 Apr 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353063; cv=none; b=eg5oGs/JbpGUAljUY2VdMlbCE8NasWTufD76i6wSLj3uZEh3AifirQHLFPsPLIK5U+Q5ezLk972szAQG/7w3I/PKVGiKybDbn1G3fDcrP35EllVJ/NmnfO2bjn+duLN8mrmA2d/jpG2ElAdazh/0Rwl+WYihqeeZL420WyVOyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353063; c=relaxed/simple;
	bh=q+Tz9RM3m0YG+sTpWqxzak/3QKoo5EvVpOxEUD96UCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLh61oKThvj6S8WYF9wdCKHGH8e/ERWzKZcKERVcvZbStjU6awryj8uX77c03MTL/bN3HTLndGXCwAcjbrLTqfg8JP1zLIMy2QE6SDkgpbRahG/DpOjbV4LFF65E7kNoBR2ydCkeMcn4fepwNMAD35bMIznzRyMePXji6RSZxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2RYA6ggw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3F8C072AA;
	Wed, 17 Apr 2024 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713353062;
	bh=q+Tz9RM3m0YG+sTpWqxzak/3QKoo5EvVpOxEUD96UCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2RYA6ggwi+PbhC2XnELFP4mFW0VxEwOrpyouZWC993fH4D3YBhnxeUBKwYdvlzl8r
	 dSXhgayxGf95oOivQsJBlCswzerFvIfr2vri9ogdn20pUXikTL5mMRTzIJRNqr9Fmi
	 46RXJxE4MIyuUVgrs6bUZ7cKAlflAxEzYGMSxUP4=
Date: Wed, 17 Apr 2024 13:24:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 7/8] serial: exar: add CTI specific setup code
Message-ID: <2024041726-fall-debunk-6cc5@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <354ff4aa9d8bdea1a21c503e685e81ac3df48eb8.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354ff4aa9d8bdea1a21c503e685e81ac3df48eb8.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:34AM -0400, Parker Newman wrote:
>  struct exar8250 {
>  	unsigned int		nr;
> +	unsigned int		osc_freq;
> +	struct pci_dev		*pcidev;
> +	struct device		*dev;

Why do you need both a pci_dev and a device?  Aren't they the same thing
here?

> +/**
> + * _cti_set_tristate() - Enable/Disable RS485 transciever tristate
> + * @priv: Device's private structure
> + * @port_num: Port number to set tristate on/off
> + * @enable: Enable tristate if true, disable if false
> + *
> + * Most RS485 capable cards have a power on tristate jumper/switch that ensures
> + * the RS422/RS485 transciever does not drive a multi-drop RS485 bus when it is
> + * not the master. When this jumper is installed the user must set the RS485
> + * mode to disable tristate prior to using the port.
> + *
> + * Some Exar UARTs have an auto-tristate feature while others require setting
> + * an MPIO to disable the tristate.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int _cti_set_tristate(struct exar8250 *priv,
> +			unsigned int port_num, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (port_num >= priv->nr)
> +		return -EINVAL;
> +
> +	// Only Exar based cards use MPIO, return 0 otherwise
> +	if (priv->pcidev->vendor != PCI_VENDOR_ID_EXAR)
> +		return 0;

How can this ever happen?  Only the exar devices will call this
function, or am I missing a path here?



> +
> +	dev_dbg(priv->dev, "%s tristate for port %u\n",
> +		str_enable_disable(enable), port_num);
> +
> +	if (enable)
> +		ret = exar_mpio_set_low(priv, port_num);
> +	else
> +		ret = exar_mpio_set_high(priv, port_num);
> +	if (ret)
> +		return ret;
> +
> +	// Ensure MPIO is an output
> +	ret = exar_mpio_config_output(priv, port_num);
> +
> +	return ret;
> +}
> +
> +static int cti_tristate_disable(struct exar8250 *priv, unsigned int port_num)
> +{
> +	return _cti_set_tristate(priv, port_num, false);
> +}

Do you ever call _cti_set_tristate() with "true"?

> +
> +/**
> + * _cti_set_plx_int_enable() - Enable/Disable PCI interrupts
> + * @priv: Device's private structure
> + * @enable: Enable interrupts if true, disable if false

But false is never used here, so why have this at all?

> + *
> + * Some older CTI cards require MPIO_0 to be set low to enable the PCI
> + * interupts from the UART to the PLX PCI->PCIe bridge.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int _cti_set_plx_int_enable(struct exar8250 *priv, bool enable)
> +{
> +	int ret = 0;
> +
> +	// Only Exar based cards use MPIO, return 0 otherwise
> +	if (priv->pcidev->vendor != PCI_VENDOR_ID_EXAR)
> +		return 0;

Same question here.

> +
> +	if (enable)
> +		ret = exar_mpio_set_low(priv, 0);
> +	else
> +		ret = exar_mpio_set_high(priv, 0);
> +	if (ret)
> +		return ret;
> +
> +	// Ensure MPIO is an output
> +	ret = exar_mpio_config_output(priv, 0);
> +
> +	return ret;
> +}
> +
> +static int cti_plx_int_enable(struct exar8250 *priv)
> +{
> +	return _cti_set_plx_int_enable(priv, true);

Again, no wrapper needed if you never actually call that function with
"false", right?  Or am I missing a path here?

thanks,

greg k-h

