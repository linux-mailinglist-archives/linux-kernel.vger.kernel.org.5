Return-Path: <linux-kernel+bounces-35593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA06E8393C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A61D1F21D21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655E61664;
	Tue, 23 Jan 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVgUQiXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2B604C9;
	Tue, 23 Jan 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024997; cv=none; b=Tr5KWbJjF6FY5C65nVphGTceo2VUD+ecBjmR7w0i9zhXO9DaNKRbUG8JhiYbcyzH526NQ8rlN4W2i6MfRY2Cwfmc8BlB7Tzp5d9CHhjnFaVy+h/9c0EQTXc/v5KiRxhUgOYft/c2MePSqODye/5RSbZR60S2jySzulpgB9zRh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024997; c=relaxed/simple;
	bh=YGqdwsVo1pQFlb0ZPxGipZtucxc5DypYwXmKxIYZeMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiA4B1u4Tnlq50XgORNicWrB1tZht0XPT1HiynyPsq5UQyaCRkmaaTLby7g3xp1vjXQNrZkViPhpXF/nlPPC9nLI5J1gloZGYGtN+s7U2rZlYi5GK3vP3CJBMENnyNGMs4botcrxyMcPImqXJp5dT7jxH1wOrLUkIwfTG5cnzlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVgUQiXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FC7C433F1;
	Tue, 23 Jan 2024 15:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024997;
	bh=YGqdwsVo1pQFlb0ZPxGipZtucxc5DypYwXmKxIYZeMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QVgUQiXFYasn3lV9zA1cS7eGqeZQ3yTcrIySknFWLAt8AhM5kZ6IrOjev4lwiPu17
	 z74Ps/y1HF0wy9bjCCPt4fOTwnXydIdLqwHqS5CEc5eeBwjFmW5szAE7e0hxVmvV4n
	 Iddub4yJi1fggTzgQR8NoLIFy1I72gvxuLdeQid0H2HUNMFLHX9DCISrsRor2qGNAC
	 mtq7OO8srtbn2R42EKyjcbzCgP4ZVpzfUGZrHRQZK7cnkAI5SzAJKw2bsbpmy0oauY
	 hrwiKBj/wV7OVMuNHtWsk4gQd4aWS4NMHfMiujYSpi2PQ59fp+3mBw7Gou7u4bDJmX
	 mTAXVDbgu/KUQ==
Date: Tue, 23 Jan 2024 07:49:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <20240123074955.72c27eb0@kernel.org>
In-Reply-To: <DM6PR12MB45168E425B2C1832F6D26453D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-10-danieller@nvidia.com>
	<20240122210534.5054b202@kernel.org>
	<DM6PR12MB45168E425B2C1832F6D26453D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 13:05:16 +0000 Danielle Ratson wrote:
> > GENL_REQ_ATTR_CHECK, and you can check it in the caller, before taking
> > rtnl_lock.
> >   
> 
> OK, np. The idea was to have module_flash_fw() that checks the attrs
> and extract them into params and ethnl_act_module_fw_flash() should
> be free from those checks. But if so, maybe this separation is
> redundant and should combine the two?

No strong preference, whatever looks better :)
To use GENL_REQ_ATTR_CHECK() I think you'll need to pass genl_info here.
You can either to that or move the validation.

> > > +  
> > tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME],  
> > > +				    "File name attribute is missing");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	params.file_name =
> > > +		nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);  
> > 
> > Hm. I think you copy the param struct by value to the work container.
> > nla_data() is in the skb which is going to get freed after _ACT returns.
> > So if anyone tries to access the name from the work it's going to UAF?  
> 
> The file_name parameter is not really needed inside the work. Once we
> called request_firmware_direct(), we have all that we need in
> module_fw->fw. Do we still need to avoid that situation? If so, can
> you please suggest how?

I'd pass it to module_flash_fw_schedule() as a separate argument, if it
doesn't have to be saved.

