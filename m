Return-Path: <linux-kernel+bounces-34716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1EF838683
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B0A1F267A0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE412119;
	Tue, 23 Jan 2024 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7ZVuCqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752B1FBF;
	Tue, 23 Jan 2024 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986337; cv=none; b=X6/jwShGcm6sTHxHyurheRSYhq+cAHc/+7z45LZ8V0V2Ph1z2OkBBdi9fCF/iwE2CzJ2PkQQ+mQzQYvGn9fjCrhWsGR+MRR7B6lmUBRTelZzRV0kEPXrDD5F1FeWpwkJk5SBZhaOKcX1OA1YmKzuv5YWD5b7i3qcPkrd5upm9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986337; c=relaxed/simple;
	bh=//WOM0oQR5MlLwRUy+ZM05+864HU5PzrMPj0MibHAsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K47eRArN5WaJNpmDJzi0HJqfUO1/p6V6xblKDTg5r4yI+81qaMdk6rS1gXmT00qtntBHtRvj/Ceo/Ucsl0SkqWN6vTnbiMx8BRq6Dg3opQepbxOfI5l0cl9F8VK8asg/dnveXIcWoJYYxc2WL2a1aNPVH1UnVa4zPqryKh/+9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7ZVuCqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAEAC433F1;
	Tue, 23 Jan 2024 05:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705986337;
	bh=//WOM0oQR5MlLwRUy+ZM05+864HU5PzrMPj0MibHAsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N7ZVuCqcgB1Y7LeCxTjnJKx2V7GCJrIDuFuICLYPSpTD8BRPfhARXe1e9q6DahI4R
	 L5/qMIkl+bAbGcfCxZEuflaVazBzK7yv4hA5PSjBb+mRAO1TUd0z0zPuZ5dytPN3Za
	 SDeoaZUjYtQdT7D37f5z8KxBzKHG97r8zJTw1KFQKZav0X1N5M26XyFP3lNh7Uy7+v
	 kzHr0RzZ/bqB8EtM1xc7wlwI3oMc8s4M4nHkRtfoEhIEbSkzI6te1QDmdcQ7rJhRhx
	 zep7yHCJoDdYF9wHwIn3lsD/nV0IqRKheq9swUXje2m68/zgEMiSmEXYyXz2W37yzR
	 8KOz78uPyzsmw==
Date: Mon, 22 Jan 2024 21:05:34 -0800
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
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <20240122210534.5054b202@kernel.org>
In-Reply-To: <20240122084530.32451-10-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-10-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:45:30 +0200 Danielle Ratson wrote:
>  #include <linux/ethtool.h>
> +#include <linux/sfp.h>
> +#include <linux/firmware.h>

alphabetical order, please

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

request_firmware_direct() ? I think udev timeout is 30 sec and we're
holding rtnl_lock.. I don't remember why we didn't use that in devlink

> +			       &dev->dev);
> +	if (err) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Failed to request module firmware image");
> +		goto err_request_firmware;
> +	}
> +
> +	err = module_flash_fw_work_init(module_fw, dev, extack);
> +	if (err < 0) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Flashing module firmware is not supported by this device");
> +		goto err_work_init;
> +	}
> +
> +	dev->module_fw_flash_in_progress = true;

What does this protect us from? 

> +static int module_flash_fw(struct net_device *dev, struct nlattr **tb,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct ethtool_module_fw_flash_params params = {};
> +	struct nlattr *attr;
> +
> +	if (!tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]) {
> +		NL_SET_ERR_MSG_ATTR(extack,

GENL_REQ_ATTR_CHECK, and you can check it in the caller,
before taking rtnl_lock.

> +				    tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME],
> +				    "File name attribute is missing");
> +		return -EINVAL;
> +	}
> +
> +	params.file_name =
> +		nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);

Hm. I think you copy the param struct by value to the work container.
nla_data() is in the skb which is going to get freed after _ACT returns.
So if anyone tries to access the name from the work it's going to UAF?

> +
> +	attr = tb[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD];
> +	if (attr) {
> +		params.password = cpu_to_be32(nla_get_u32(attr));
> +		params.password_valid = true;
> +	}
> +
> +	return module_flash_fw_schedule(dev, &params, extack);
> +}


