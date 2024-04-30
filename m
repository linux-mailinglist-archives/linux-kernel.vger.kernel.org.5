Return-Path: <linux-kernel+bounces-163286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 652598B6867
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D881C219CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483210A35;
	Tue, 30 Apr 2024 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSkKNiCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A81094E;
	Tue, 30 Apr 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447359; cv=none; b=f9gkeK4rmFwQqX0QniidS/dfoxj7zYziF9dCjiGswBYjTAX8gXZV7xB2/x+8N0/6vvPqwfIbCYXPxRP7h68zrsTCGON8xMOIfSZJPv/HCodB5IjZzvn30lyxCSmIzGKIUL48Jn1epK4I75aDvZL/5qekcwfuJ6Gdg9G04RzQMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447359; c=relaxed/simple;
	bh=/KpxBWy5mcEbkG7pQG0EPzcysWGUzPXDj0gBvqYdums=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFaH6jjxIGKmFb2SeoIxsnJoJ2sWcAIKH/wbv77MtLukM64jllim8rWP/Fr3X7FsTkRLH9VJ4JDrHBxnab8iVEdn60K1zzgRWTcV/bywr3cy9WdRJb2oWIsGPpttJcgQf9Yr+hbOwwwB9DMvXrbTeRmxgJOg6DkAyvs5eSEWGo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSkKNiCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD91C116B1;
	Tue, 30 Apr 2024 03:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447359;
	bh=/KpxBWy5mcEbkG7pQG0EPzcysWGUzPXDj0gBvqYdums=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sSkKNiCXpCcc/7pJ8gWMm5YCd3auiyTbpRyptUCMgG9FzN5zkVbZipqaxbdF3hPpx
	 Geb61osFpYAPFdZvAxNGqTo5mLEMYXsyGz9fJGTOQKB4dNXfiAX3WjwYmz8tnaFfdD
	 PbLFmVrwVAth+rr/5SZExtgs9UjWdtgAEGGxBbbeqdyHbLTA6xT2G6T1WL21orpZnE
	 KzuJ9S8IryK8WpoCwKQH39ME1RvEXSwUt+981BiNi0hf4zixOLWsbwp9cB7tNZ7PJM
	 XZLyDW94V+cfABtIkA1burVDaEciei33GzNeWzjSShKkOHpSXM8fzG7k/IDuKX3glu
	 uTZzRAVgqnlFw==
Date: Mon, 29 Apr 2024 20:22:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [PATCH net-next v5 09/10] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <20240429202237.6bbd2cb3@kernel.org>
In-Reply-To: <20240424133023.4150624-10-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-10-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 16:30:22 +0300 Danielle Ratson wrote:
> +static int
> +module_flash_fw_schedule(struct net_device *dev, const char *file_name,
> +			 struct ethtool_module_fw_flash_params *params,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct ethtool_module_fw_flash *module_fw;
> +	int err;
> +
> +	err = __module_flash_fw_schedule(dev, extack);
> +	if (err < 0)
> +		return err;

Basic dev validation should probably be called directly from
ethnl_act_module_fw_flash() rather than two functions down.

> +	module_fw = kzalloc(sizeof(*module_fw), GFP_KERNEL);
> +	if (!module_fw)
> +		return -ENOMEM;
> +
> +	module_fw->params = *params;
> +	err = request_firmware_direct(&module_fw->fw, file_name, &dev->dev);
> +	if (err) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Failed to request module firmware image");
> +		goto err_request_firmware;

Please name the labels after the actions they perform.

> +	}
> +
> +	err = module_flash_fw_work_init(module_fw, dev, extack);
> +	if (err < 0) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Flashing module firmware is not supported by this device");

This overwrites the more accurate extack msg already set by
module_flash_fw_work_init()

> +		goto err_work_init;
> +	}

