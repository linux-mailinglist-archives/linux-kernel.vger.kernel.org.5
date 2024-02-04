Return-Path: <linux-kernel+bounces-51746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED5848ED4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A9B21778
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D93225A9;
	Sun,  4 Feb 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zTL4Va8w"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A822301;
	Sun,  4 Feb 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059723; cv=none; b=tXlSsvy4n1+SWN42Pmez0bowKg9YWScbBk1ZCxLmkpKXaNgX7+Pd08raGNw95tWNkDVAekzdXnH98tieLVnXftSRLqA0a4jeT4l3Oxe4fFDd3XbKOuEs/A/K4OEIKdVLYAPBeODGAKojgPNc7CUFt3Pp7t4l0OBbJTAeRV5Q7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059723; c=relaxed/simple;
	bh=IeZfAJeIueCJI7tdAJKSyC4Jwez+pyH758ixVanQ578=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfMhqeuHnn9G2ooXiO88JOITLGwkCe+dF++peMQT8Jt4+5vVLfu5Z8775LTUkw0sRA2XNEMH19OtOfS1mfS5hqU24PeMzP+I/IXd2B8WwGLKtD9oT9Ubkdiqw7V2rclw0lADJOHyi+ZuJK3yKlFMVW3bNzXEEnp50qA8Jdd93Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zTL4Va8w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=edYHnRAqz8+dv8WEmyxXjWpoGAiVxFe3ltzCGSM68NQ=; b=zTL4Va8wcoV/6G2DFrtpoPED7k
	1Gd4ADSJt7S5piBmZKIaGfIT7mgq8co+nbQvDjwI68Uzn8hY/Z6tVt+IivT570WzbI5kQUQ/25aM3
	6aBv0Gp3WzyByyqEl0ANbN+vbUh7Q+6r9Zgw1YKfr9r/bOVfuXVC51z5VZ5y9/2zC4kI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWeD0-006xuU-Qj; Sun, 04 Feb 2024 16:15:02 +0100
Date: Sun, 4 Feb 2024 16:15:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
Message-ID: <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203235413.1146-1-ansuelsmth@gmail.com>

On Sun, Feb 04, 2024 at 12:54:01AM +0100, Christian Marangi wrote:
> Commit d5e01266e7f5 ("leds: trigger: netdev: add additional specific link
> speed mode") in the various changes, reworked the way to set the LINKUP
> mode in commit cee4bd16c319 ("leds: trigger: netdev: Recheck
> NETDEV_LED_MODE_LINKUP on dev rename") and moved it to a generic function.
> 
> This changed the logic where, in the previous implementation the dev
> from the trigger event was used to check if the carrier was ok, but in
> the new implementation with the generic function, the dev in
> trigger_data is used instead.
> 
> This is problematic and cause a possible kernel panic due to the fact
> that the dev in the trigger_data still reference the old one as the
> new one (passed from the trigger event) still has to be hold and saved
> in the trigger_data struct (done in the NETDEV_REGISTER case).
> 
> On calling of get_device_state(), an invalid net_dev is used and this
> cause a kernel panic.
> 
> To handle this correctly, move the call to get_device_state() after the
> new net_dev is correctly set in trigger_data (in the NETDEV_REGISTER
> case) and correctly parse the new dev.
> 
> Fixes: d5e01266e7f5 ("leds: trigger: netdev: add additional specific link speed mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

This should have 'net' in the subject line, to indicate which tree its
for.

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

