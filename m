Return-Path: <linux-kernel+bounces-163282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFCA8B682E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1788828218A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742AFC02;
	Tue, 30 Apr 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDqXwkYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27444DDA6;
	Tue, 30 Apr 2024 03:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446693; cv=none; b=iefF/QNSae5LIE2q1W18MaJE/Zeamd3YAkI8l+/FhFvYMekgD0J2GO+sXCB+s60hP/N0GrMjcJD3myFDj/1uS7sl0YpMBGgESffdEoGYPxfSryC1JpZ7GPTEfkZWRKANdKCTLXtOwZz6Wt28fiOWLUnBE907QjA7Mhd0w07lt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446693; c=relaxed/simple;
	bh=F38alO0+pqAFw+N4jjta2j7kT+Zse5cYwkzjPS2r5AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHLlE+HNlntbM4yil2c3BT+V4Lc/3Vm9PpOuZFX6xxZ/MGr8XcrdI2MuzNqHPXN50a/uo4Ro8ILHC61Uw3X9+cw/NMdtMGPHhLREvuM1tGsCrpJWNYJPbdnbTZUOb5iKa25z2/OYDrI6uPGDRihhqnHCd1MSXJ0u/D7S7vOWF9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDqXwkYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6692C116B1;
	Tue, 30 Apr 2024 03:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714446692;
	bh=F38alO0+pqAFw+N4jjta2j7kT+Zse5cYwkzjPS2r5AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDqXwkYzHfm8sTFGf4/2hVAeUC5mZRfvJS/A7IKkOK8TBiv+kGfdNa0ZctD3O45Yg
	 dbJVF/2XgKbqhYvJtcby5pYo+t4ClH1E9cUydBNUp6RQlSyyUtLEpsHoZXbj18HuOO
	 bw5xlx5D0Ei0ZqPWhr681rhN+zQdcl54YWpJwJNxJAM7T7Y9aPRpMPzZe2LJUCX1lW
	 0gEDdMPaCu/y7Ti0NMAvApbzHCniLuomnYPxqBkk2yjDRV+4/GteSzNFeLqyCgvD/0
	 eMupoBttXsj2kfxwFyAFXvuKKcbMR8D3jlTupIaODC1Sl9SOpza9tV2No5RMxRzQs1
	 eXOzNEFhowlHg==
Date: Mon, 29 Apr 2024 20:11:30 -0700
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
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240429201130.5fad6d05@kernel.org>
In-Reply-To: <20240424133023.4150624-5-danieller@nvidia.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 16:30:17 +0300 Danielle Ratson wrote:
> +	hdr = ethnl_bcastmsg_put(skb, ETHTOOL_MSG_MODULE_FW_FLASH_NTF);
> +	if (!hdr)
> +		goto err_skb;

Do we want to blast it to all listeners or treat it as an async reply?
We can save the seq and portid of the original requester and use reply,
I think.

> +	ret = ethnl_fill_reply_header(skb, dev,
> +				      ETHTOOL_A_MODULE_FW_FLASH_HEADER);
> +	if (ret < 0)
> +		goto err_skb;
> +
> +	if (nla_put_u32(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS, status))
> +		goto err_skb;
> +
> +	if (status_msg &&
> +	    nla_put_string(skb, ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,
> +			   status_msg))
> +		goto err_skb;
> +
> +	if (nla_put_u64_64bit(skb, ETHTOOL_A_MODULE_FW_FLASH_DONE, done,
> +			      ETHTOOL_A_MODULE_FW_FLASH_PAD))

nla_put_uint()

> +		goto err_skb;
> +
> +	if (nla_put_u64_64bit(skb, ETHTOOL_A_MODULE_FW_FLASH_TOTAL, total,
> +			      ETHTOOL_A_MODULE_FW_FLASH_PAD))

nla_put_uint()

> +		goto err_skb;
> +
> +	genlmsg_end(skb, hdr);
> +	ethnl_multicast(skb, dev);
> +	return;
> +
> +err_skb:
> +	nlmsg_free(skb);
> +}
> +
> +void ethnl_module_fw_flash_ntf_err(struct net_device *dev,
> +				   char *err_msg, char *sub_err_msg)
> +{
> +	char status_msg[120];
> +
> +	if (sub_err_msg)
> +		sprintf(status_msg, "%s, %s.", err_msg, sub_err_msg);
> +	else
> +		sprintf(status_msg, "%s.", err_msg);

Hm, printing in the dot, and assuming sizeof err_msg + sub_err < 116
is a bit surprising. But I guess you have a reason...

Maybe pass them separately to ethnl_module_fw_flash_ntf() then you can
nla_reserve() the right amount of space and sprintf() directly into the
skb?

> +	ethnl_module_fw_flash_ntf(dev, ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
> +				  status_msg, 0, 0);

