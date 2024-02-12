Return-Path: <linux-kernel+bounces-61845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDED685175B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0991C2166B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CE3BB47;
	Mon, 12 Feb 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HhoKQms/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0AB3BB34;
	Mon, 12 Feb 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749522; cv=none; b=Ha+TiAyJeRDnb8aNrc1nSaJewFkqgxumKbSp6yujTu68fvgg4fgWRDXdhZmOHKOxsbxrycfpfpTPI3KIH3Sf9apeC2cqpB0tYo1zzAi0Q2sPHDh0DhC5guahpY+16EaYD/Wa4YmqT4LP9hGHD0ERwJyNlAQRcms84GWjzFB2QlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749522; c=relaxed/simple;
	bh=CvO5h22bIICO9OVAqHSfrziFGOjtF4BmJIiYlm8gKqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix4wViamBw69YY+MbFyZMsNxD8rNArWxueM2Q1gM7+Veb6FMYGnKxXskZ07ufJXkWptDHJailcOs3iP9etSQBWXhIKbLOnHRMGxxUC4PeaL9sAJgp+XKpWPanZ0wpSB2GHJserMiccK9GQ+0lGANsgw+ACQOfcj2i3/NWimtIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HhoKQms/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8V/n6mYnmYAVnrBX94RlW3GjICZYM1XfZBGebC4iOsg=; b=HhoKQms/prSYZqTTcb2AcWxa8q
	PExcu4ZShC/u3ut6nS1RttBsqvdv34EBXZ0FXqlQ5R4GmhpAgZXlRIO7nGWijaM59K/7cghvtcT+o
	2KVPJO+4zqCLhXhBl0nUmcMAmNFiIo3wcxg164WHrTey7BzQoK6QcvKYzJWcwnigk0d4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZXf4-007aEq-Tx; Mon, 12 Feb 2024 15:51:58 +0100
Date: Mon, 12 Feb 2024 15:51:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to
 .config_init_once
Message-ID: <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
References: <20240212115043.1725918-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212115043.1725918-1-robimarko@gmail.com>

On Mon, Feb 12, 2024 at 12:49:34PM +0100, Robert Marko wrote:
> Currently, we are checking whether the PHY package mode matches the
> individual PHY interface modes at PHY package probe time, but at that time
> we only know the PHY package mode and not the individual PHY interface
> modes as of_get_phy_mode() that populates it will only get called once the
> netdev to which PHY-s are attached to is being probed and thus this check
> will always fail and return -EINVAL.
> 
> So, lets move this check to .config_init_once as at that point individual
> PHY interface modes should be populated.

Just for my own understanding, not directly about this patch...

priv->package_mode is about PSGMII vs QSGMII for one of the SERDES
interfaces? We expect the individual PHYs sharing that interface to
also indicate PSGMII or QSGMII?

But what about the other SERDES, which can be connected to an SFP
cage. You would normally set that to SGMII, or 1000BaseX. When an SFP
module is inserted, the correct interface mode is then determined from
the contests of the EEPROM and the PCS needs to be reconfigured. So
i'm just wondering how this check works in this situation?

    Andrew

