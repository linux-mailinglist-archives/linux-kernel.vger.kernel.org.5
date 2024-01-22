Return-Path: <linux-kernel+bounces-32765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04455835FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EEB1F21332
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05FE3A1BC;
	Mon, 22 Jan 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIJmqCK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC633CD5;
	Mon, 22 Jan 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919888; cv=none; b=BKd+v/8bPyvo0azJa/ADvgvqUBjRkxb0uRSiZ+dsAL+Oryc+7G/u85PArhsmG3N6cGLVPn+/eKV0xNzFzy/vG6zuy26R/7xn0au73kR6s99SNFfUeyAYn1GBLmrGU/77Gyqs5Ab5CXbo5zhL/zf9XHjn00VK74rTtDVpYi4F5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919888; c=relaxed/simple;
	bh=cMiKN8C3enDGNxZRDLUTztPGp7aogmXFEdPXW4gw4dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtXNY51tWTzsaLnBorcxPuwMrMdluy2SeEzm3qx5n+kaj8pgY581r7b+w/E0JerVT6YFlXqZib3EDv/Rs1rr7Pk/5sfOB1thhfwPURdG2xBce4XO8HxOmx1h52uwlpE2YZkzNinSjNwoZp9TRm66xspsQ63lqDztR1tHKS+oEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIJmqCK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99906C43390;
	Mon, 22 Jan 2024 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705919887;
	bh=cMiKN8C3enDGNxZRDLUTztPGp7aogmXFEdPXW4gw4dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIJmqCK+Tk8D6zX/d5/TMHOtAOfpd8TVEJaXeJGB5jf2QmRfAFrLw4KsmELP2nDju
	 V58nHExfSmXwxf9RO9fS7dtYSeaNHfgNeQwprVCHjBK+HgE/jaQIGkQ8R3w+Gdz+/v
	 LAEA6w1Ag1D84XbwXFSlmlw5XE9WJ0X9/TPa2lUHHwbkR6HsxbGKBvxcM+ueruf5C+
	 zB3QwOtdwmv1+hLPcLFqLOvQ8IFlcGH3QTfpKm4ZNmvVPiOO2/9LL47RMOZQvz1Y9o
	 QY6AmgSShjGNQI2PDB3v9c0Cgd9ldtSenrOO/KzR2NsK60EKrTVxHTEIi08JjfJL83
	 Px2neHk5cOsIg==
Date: Mon, 22 Jan 2024 10:37:59 +0000
From: Simon Horman <horms@kernel.org>
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
Message-ID: <20240122103759.GB126470@kernel.org>
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

On Mon, Jan 22, 2024 at 10:45:30AM +0200, Danielle Ratson wrote:

..

> +static int module_flash_fw(struct net_device *dev, struct nlattr **tb,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct ethtool_module_fw_flash_params params = {};
> +	struct nlattr *attr;
> +
> +	if (!tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]) {
> +		NL_SET_ERR_MSG_ATTR(extack,
> +				    tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME],
> +				    "File name attribute is missing");
> +		return -EINVAL;
> +	}
> +
> +	params.file_name =
> +		nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);
> +
> +	attr = tb[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD];
> +	if (attr) {
> +		params.password = cpu_to_be32(nla_get_u32(attr));

Hi Danielle,

The type of password is u32, so perhaps cpu_to_be32() isn't needed here?

Flagged by Sparse.

> +		params.password_valid = true;
> +	}
> +
> +	return module_flash_fw_schedule(dev, &params, extack);
> +}

..

