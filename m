Return-Path: <linux-kernel+bounces-86891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1706786CC56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B171F23757
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80801384A4;
	Thu, 29 Feb 2024 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HmkNoC/0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC4137750;
	Thu, 29 Feb 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219169; cv=none; b=qzeYeQKRvCxoptgB6GvHfIDjDfa+l34QJqAzw2wN0VtP/MdrLJTPyyuff6xF5W2rg5sp4eOf5Talr+fD0YqaC64B8yNVlIWS+0N9tYMSPx3bhei0fvlwYRsRFQ+8zBQpedd1BlmYoPT4u+vW+zaq1ZcnJAIi7wyq1vTQ7rkKBB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219169; c=relaxed/simple;
	bh=6h4hJKdMJ/mUzFPTHkW+CQwyfVnMV3EorukJNOsAz3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgtmirgkLBOAFCXjEHQbvPM/+cyC+revkQ29Dh6lYM4r2hjksVhXOudURHrF3qIB663X7tarJSOtMHQ+OMEq/FV+NfoaKNp3TqDpI/B7EpWHJwwc/BQVPehxtRDiCWZsI6HYrZUnTabXmvwEJzqBp8SZqNbHKPN9+wHUtZduNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HmkNoC/0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vkq1cSPFx4ixNxWnCzVtyGnhzokMMdq2KSDQeGVzjh4=; b=Hm
	kNoC/0tf2wu5Kum9eNsJqARb6GTT3hVSccJw2ov4WPtd/sPqx53htebi6yrbp4xHVTco/26xuE8CL
	Fdpn1jMc8Kg3r9irWKZdBMKXXbg2oDJcxpnKHsdPP5W5W+dMRGLnMjZkEBs35zNmDaK6wLm0UBqaQ
	ptHuFuxaLD0LyD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfhzL-009397-J9; Thu, 29 Feb 2024 16:06:23 +0100
Date: Thu, 29 Feb 2024 16:06:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, Bryan.Whitehead@microchip.com,
	richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Message-ID: <e038ec4e-c54d-4628-8997-90510c0d96ab@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <b83b74b7-3221-4747-8b71-17738c18c042@lunn.ch>
 <LV8PR11MB8700C2F9461F4200431446D49F5F2@LV8PR11MB8700.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV8PR11MB8700C2F9461F4200431446D49F5F2@LV8PR11MB8700.namprd11.prod.outlook.com>

On Thu, Feb 29, 2024 at 08:59:20AM +0000, Raju.Lakkaraju@microchip.com wrote:
> Hi Andrew,
> 
> Thank you for review comments.
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Tuesday, February 27, 2024 7:28 AM
> > To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> > Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org; linux-
> > kernel@vger.kernel.org; Bryan Whitehead - C21958
> > <Bryan.Whitehead@microchip.com>; richardcochran@gmail.com;
> > UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> > Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
> > flags configuration sequences
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > On Mon, Feb 26, 2024 at 01:39:34PM +0530, Raju Lakkaraju wrote:
> > > Wake options handling has been reworked as follows:
> > > a. We only enable secure on magic packet when both secure and magic wol
> > >    options are requested together.
> > > b. If secure-on magic packet had been previously enabled, and a
> > subsequent
> > >    command does not include it, we add it. This was done to workaround a
> > >    problem with the 'pm-suspend' application which is unaware of secure-on
> > >    magic packet being enabled and can unintentionally disable it prior to
> > >    putting the system into suspend.
> > 
> > This seems to be in a bit of a grey area. But ethtool says:
> > 
> >            wol p|u|m|b|a|g|s|f|d...
> >                   Sets  Wake-on-LAN  options.   Not  all devices support this.
> >                   The argument to this option is a string of characters speci‐
> >                   fying which options to enable.
> >                   p   Wake on PHY activity
> >                   u   Wake on unicast messages
> >                   m   Wake on multicast messages
> >                   b   Wake on broadcast messages
> >                   a   Wake on ARP
> >                   g   Wake on MagicPacket™
> >                   s   Enable SecureOn™ password for MagicPacket™
> >                   f   Wake on filter(s)
> >                   d   Disable (wake on  nothing).   This  option
> >                       clears all previous options.
> > 
> > d clears everything. All other things enable one option. There does not
> > appear to be a way to disable a single option, and i would say, adding options
> > is incremental.
> > 
> 
> Yes. "d" clears everything.
> But, if we enable "g" then enable "a", "g" option overwritten by "a"

This is where i say it is a bit of a grey area. For me, they are
incremental. You can enable a and then later enable g, and you should
have both enabled.

> Please find the attached log information 
> > So:
> > 
> > > a. We only enable secure on magic packet when both secure and magic wol
> > >    options are requested together.
> > 
> > I don't think they need to be requested together. I think you can first enable
> > Wake on MagicPacket and then in a second call to ethtool Enable SecureOn
> > password for MagicPacket. I also don't think it would unreasonable to accept
> > Enable SecureOn password for MagicPacket and have that imply Wake on
> > MagicPacket.
> > 
> 
> If we need to enable any 2 options, we have to provide both options together.
> i.e.
> sudo ethtool -s enp9s0 wol ga

which i think is wrong. A driver should allow incremental adding WoL
options.

> 
> > And:
> > 
> > > b. If secure-on magic packet had been previously enabled, and a
> > subsequent
> > >    command does not include it, we add it.
> > 
> > If there has not been a d, secure-on magic packet should remain enabled until
> > there is a d.
> > 
> 
> This is not happened with existing "Ethtool".
> Please find the log information in an attachment file.

That could just be a driver bug.

Take a step back. Is there any clear documentation about how ethtool
-s wol should really work? Any comments in the code? Any man page
documentation.

Lets first understand how it is expected to work. Then we can decided
if the driver is implementing it correctly.

   Andrew

