Return-Path: <linux-kernel+bounces-86919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BB86CCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F86288694
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFF31468E0;
	Thu, 29 Feb 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="criRIg0d"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F913774E;
	Thu, 29 Feb 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220232; cv=none; b=uLsKZqZDOfR2v0S45dzfp+71xFdjMozAfjjc3xbRELm1vTXPiIoTg/mgNkZGlUYYiZuzzduq6AGblY2OOtLGiHq3kfxVir7QsCv9/yZuV5FYot7CZ55af+nlcvFsjPjdda24g68az5p6pWmbRA8cKlXrGGlX/+x7/Lma6+SymoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220232; c=relaxed/simple;
	bh=VR3w9qMQENCkQog/l/A9YqEp7V7m/a1O1eceAfQHDV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiJ3bl9KmuLAFCrjt7CDlv28tr/ZwofocIpiaqmKYnhCGmaGJYemGLhYF6zTV6lC/pQT//w+XQMQpHT/QgZIkw8gaNPYGNOiuQz64uQhcHUrgC+3C6CGPZhNH/4OHRfiCiBjV94z3x3DyeO6XGo3vZKWW8mlgKa+dGhvW3M883w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=criRIg0d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fpeGkSY3A7dXRsptcNnoUKHKhLiXr1DwW0RmJgm1X0Y=; b=criRIg0dtEXQf6tdodfSJg5wWp
	sxJ7KokXv5tBurmJM4/okCh+eo2kWmM+bwf9A3ePMS5J9SiRALkz1FPVjGWDqnfRePCVEiXUZjjSs
	24wfIEdBNh+OtS4QQXnEm32Sf2MykHIKqwoVHy7y0EsvIHMk9KzMwSUmx6zXc/YSTtLg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rfiGN-0093GS-LT; Thu, 29 Feb 2024 16:23:59 +0100
Date: Thu, 29 Feb 2024 16:23:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH v2 6/6] net: phy: DP83640: Add fiber mode
 enabling/disabling from device tree
Message-ID: <c6840f8f-7d9c-49e8-b689-2af04605b99c@lunn.ch>
References: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
 <20240227093945.21525-7-bastien.curutchet@bootlin.com>
 <a9c2144a-f26b-4a71-b808-ce3a94f1264d@lunn.ch>
 <c1b17410-b403-4c3a-9c00-de8f2b2b2fa7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b17410-b403-4c3a-9c00-de8f2b2b2fa7@bootlin.com>

On Thu, Feb 29, 2024 at 08:31:55AM +0100, Bastien Curutchet wrote:
> Hi Andrew,
> 
> On 2/27/24 17:18, Andrew Lunn wrote:
> > On Tue, Feb 27, 2024 at 10:39:45AM +0100, Bastien Curutchet wrote:
> > > The PHY is able to use copper or fiber. The fiber mode can be enabled or
> > > disabled by hardware strap. If hardware strap is incorrect, PHY can't
> > > establish link.
> > > 
> > > Add a DT attribute 'ti,fiber-mode' that can be use to override the
> > > hardware strap configuration. If the property is not present, hardware
> > > strap configuration is left as is.
> > How have you tested this? Do you have a RDK with it connected to an
> > SFP cage?
> 
> I did not test fiber mode as my board uses copper.
> 
> My use case is that I need to explicitly disable the fiber mode because the
> strap hardware is
> misconfigured and could possibly enable fiber mode from time to time.

O.K. So lets refocus this is little. Rather than support fibre mode,
just support disabling fibre mode. But leave a clear path for somebody
to add fibre support sometime in the future.

Looking at the current code, do you think fibre mode actually works
today? If you think it cannot actually work today in fibre mode, one
option would be to hard code it to copper mode. Leave the
configuration between fibre and copper mode to the future when
somebody actually implements fibre mode.

   Andrew

