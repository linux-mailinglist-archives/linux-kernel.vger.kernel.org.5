Return-Path: <linux-kernel+bounces-39275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC8983CDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8780B26460
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9750C13A240;
	Thu, 25 Jan 2024 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oQ47RzA6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA781386BB;
	Thu, 25 Jan 2024 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216636; cv=none; b=X9Cltc+bfKSQAtbafo37/tgvEu6KVUtsg4JEEZWD0Pu4KbKs5SffTimT5vbb/tcOxGj/7ljQPcgQ/+/H9brIxa1GScXzEFMFs+nh6ivn5xjkBYPTlFlblV8Rk+VUipERu1ppuEd8DWYBCeD8uRYKXXmkI1zLqSpzs1MtZf/yoo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216636; c=relaxed/simple;
	bh=XvQKZeltXenXh3RZWvWZ+AtK3njPDgPT8/8uVcOeufg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDOisMhQkrEBxxXOw83J6+zumu/X5N+U7P4RnSI54YEndmH40BZV90c8HUHzZZoxcEjuCvqSxKjGO92cWW1P8jwAgg6HdFzzk8pbfOI8kkOfndSb7315yDv9CHLEyxbC+yg5IaefZuwfQLOlvYQlt6I5WPrNNb8xuBJeVzVIDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oQ47RzA6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bu/MVp9rSX8C5VovP+Gle5TXdDW/jXtcb4d6OYgbRKE=; b=oQ47RzA6/NF69XT8vHhdbvU5Q4
	EV2nhyPaB0Bp56zCEaEGXAAiU+B0bbnRKvt1rMvM8CqIm6aW+++ImL2feh/wNvpa5qwsxqvfpCOqo
	h2OneHD/QgB2z/wUxyOvj6TnbM+uWWM9BRzRZ2+AWlf5y+JUEnZmfFsFKTlOgyg93CQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT6sr-0067iF-FU; Thu, 25 Jan 2024 22:03:37 +0100
Date: Thu, 25 Jan 2024 22:03:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <5bf6b526-02c4-4940-b8ec-bf858f9d4a58@lunn.ch>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-10-danieller@nvidia.com>

> +static int
> +module_flash_fw_schedule(struct net_device *dev,
> +			 struct ethtool_module_fw_flash_params *params,
> +			 struct netlink_ext_ack *extack)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_module_fw_flash *module_fw;
> +	int err;
> +
> +	if (!ops->set_module_eeprom_by_page ||
> +	    !ops->get_module_eeprom_by_page) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Flashing module firmware is not supported by this device");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (dev->module_fw_flash_in_progress) {
> +		NL_SET_ERR_MSG(extack, "Module firmware flashing already in progress");
> +		return -EBUSY;
> +	}
> +
> +	module_fw = kzalloc(sizeof(*module_fw), GFP_KERNEL);
> +	if (!module_fw)
> +		return -ENOMEM;
> +
> +	module_fw->params = *params;
> +	err = request_firmware(&module_fw->fw, module_fw->params.file_name,
> +			       &dev->dev);

How big are these firmware blobs?

Ideally we want to be able to use the same API to upgrade things like
GPON modules, which often run an openwrt image, and they are plugged
into a cable modem which does not have too much RAM.

Given that the interface to the EEPROM is using 128 byte 1/2 pages,
would it be possible to use request_partial_firmware_into_buf() to
read it on demand, rather than all at once?

     Andrew

