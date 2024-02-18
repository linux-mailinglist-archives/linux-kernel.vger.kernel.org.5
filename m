Return-Path: <linux-kernel+bounces-70567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7E385993A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA071C20F70
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A871B59;
	Sun, 18 Feb 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xbyrq3Io"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76426F50A;
	Sun, 18 Feb 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708287049; cv=none; b=uc/Ne8VuAiW3TOUkrnYyGlNV7ZZKs+JFPIIPmIyZEYJ+cmA6CbscBdufUH7cBTG6rDlvowDYAQNmqfctljfON7OIAKy67T0e5kiVPhk29gHyqzUA46FZdXarSKFCLDEdyBGHd1i+YUtQhHLg36PrXXllX3enoTaJM7ojZmBMhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708287049; c=relaxed/simple;
	bh=i+xWDdqTYFZ/AR5kqHImC82hQFi4jBPr+icERKIWjEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBnmmrz6hcnTkelkMNCyoEdiNp5y2ECjaws2JKP1bRmMVgFTvpgnTCpuEVvfQgRsTeDOTFgFQTfDSHrIP9+nzVbMYe9osduXl6+Y4GYu3uf5y61FXCyg6RC703iwio2SSoMiRYZCgAFWc7Yd/K41gpX3Rigg7BB2wi889Npamkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xbyrq3Io; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cBNrlmPxjYQsSSYlAltbdkKldOD3v/VTfy5t8AAGGBI=; b=xbyrq3IoXdzl0gD7S8ZtWI42Dd
	p/o2vtqtuCPgaugkWk0FRnimA81EuPcVN4Jwne5MU1xdbYr8IMbeAMFB7B3rqA1naDFN1kIXHDul/
	Tf/QgbuDUP8qn+3nQgkais56rRwAeNVLK/Vjr0EfvgHz8YsgWd3+jmIU4e1EEq/UV3WA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbnUd-0088nn-0A; Sun, 18 Feb 2024 21:10:31 +0100
Date: Sun, 18 Feb 2024 21:10:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] net: phy: add support for defining
 multiple PHY IDs in PHY driver
Message-ID: <829f8c7d-c09b-4264-818a-3f7b047ec44f@lunn.ch>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
 <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
 <65d2613d.170a0220.2eb48.a510@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d2613d.170a0220.2eb48.a510@mx.google.com>

> > > +	phy_dev_id = (struct mdio_device_id *)&phydev->dev_id;
> > 
> > Why this cast? Try to write code that doesn't need casts.
> > 
> 
> This cast is needed to keep the dev_id const in the phy_device struct so
> that other are warned to not modify it and should only be handled by
> phy_probe since it's the one that fills it.
> 
> Alternative is to drop const and drop the warning.

Can you propagate the const. Make phy_dev_id point to a const?

    Andrew

