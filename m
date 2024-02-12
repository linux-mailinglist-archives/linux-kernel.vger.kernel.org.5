Return-Path: <linux-kernel+bounces-62290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFA851E20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CE51F23809
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430247A7D;
	Mon, 12 Feb 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UsWPT/Zm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586247773;
	Mon, 12 Feb 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767304; cv=none; b=lP6llfSYBOYnQotVZOifgChRZOrUwQZojoC1Gg2T0Gb02j/D+8XjOpBtlve90Tkzik2eGoigZBOQAyn2vm6c+5Z3zeQnFw2zAkEEiNAjcDja91cVwBFBYF43nAG7IVyF+fu0pSp64aKUusl/ZnUhzBkNS5/S8NfX6gccU1Nldok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767304; c=relaxed/simple;
	bh=0ft2MpYjrV64jvQOY3huDzIg33+d3RYVhImM7BX3V5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyV3tsD4SCI3byCNqQEBb/yhX/vfL2awTxxJT/ZfM61V6iRoezzoWH+2lTUdLP0FAMTxxDXV6DvIn2ExRftT4l0w4zyARfOox1ZY5V62+dHbrM8+vaTeoKlXk4zosrdB7q9rC770g73yBYv/4Aot0+ljJhJLC0eWOFovVVAYEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UsWPT/Zm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fVTHkRWd/tAUl4w7Ho74/SJnoO1GvKi18/DDs+kPOJQ=; b=UsWPT/Zmyw6Uk9UYdkA4FQJsi0
	CP4i0Pi2t44a3Xy+SjFAbhLzA7w68xNircdiTCODBXYvNC7obCnDevGXTSCztIeVLgpK2Y1+mhw2H
	mcSIPYPZhKPhExmAHpNH3Ic7AY+lADuGyzO/VcosFlx2CsZWb/g7SwG19liGTW2tgl9I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZcHo-007bYQ-Ma; Mon, 12 Feb 2024 20:48:16 +0100
Date: Mon, 12 Feb 2024 20:48:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ansuelsmth@gmail.com,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: qca807x: move interface mode check to
 .config_init_once
Message-ID: <7c5dd47c-26b9-4a12-af93-6139ae85e864@lunn.ch>
References: <20240212115043.1725918-1-robimarko@gmail.com>
 <c97d10fa-39c5-4e5e-93ce-1610635cb4d4@lunn.ch>
 <CAOX2RU6OwiymM_O_62VETgkBNUQP1TuOKJmm0D1ZUXBA7ZPJNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU6OwiymM_O_62VETgkBNUQP1TuOKJmm0D1ZUXBA7ZPJNA@mail.gmail.com>

On Mon, Feb 12, 2024 at 07:09:04PM +0100, Robert Marko wrote:
> On Mon, 12 Feb 2024 at 15:51, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Feb 12, 2024 at 12:49:34PM +0100, Robert Marko wrote:
> > > Currently, we are checking whether the PHY package mode matches the
> > > individual PHY interface modes at PHY package probe time, but at that time
> > > we only know the PHY package mode and not the individual PHY interface
> > > modes as of_get_phy_mode() that populates it will only get called once the
> > > netdev to which PHY-s are attached to is being probed and thus this check
> > > will always fail and return -EINVAL.
> > >
> > > So, lets move this check to .config_init_once as at that point individual
> > > PHY interface modes should be populated.
> >
> > Just for my own understanding, not directly about this patch...
> >
> > priv->package_mode is about PSGMII vs QSGMII for one of the SERDES
> > interfaces? We expect the individual PHYs sharing that interface to
> > also indicate PSGMII or QSGMII?
> 
> Yes, that is the idea, all of the individual PHY-s in the package
> should be indicating
> the same PHY interface mode.
> 
> >
> > But what about the other SERDES, which can be connected to an SFP
> > cage. You would normally set that to SGMII, or 1000BaseX. When an SFP
> > module is inserted, the correct interface mode is then determined from
> > the contests of the EEPROM and the PCS needs to be reconfigured. So
> > i'm just wondering how this check works in this situation?
> 
> I just went to retest SFP support and it works as intended, as soon as the SFP
> is inserted, PHY will get reconfigured to "combo" mode so that fifth PHY can
> support both fiber (100Base-FX or 1000Base-X) or regular copper connections.
> 
> So, the check will not interfere with SFP support.

So for the port with the SFP you also have phy-mode of PSGMII or
QSGMII? That then gets changed when the SFP is hot plugged?

	Andrew

