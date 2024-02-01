Return-Path: <linux-kernel+bounces-48548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490A845DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2BA1F270D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F265399;
	Thu,  1 Feb 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XfPMOc1V"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A2D281;
	Thu,  1 Feb 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706806063; cv=none; b=rueT7QtDwOgs6QIHbTMj1W1XaEDc6jHAzNxjw1CD0cloUfbWB+GRArIsni3OY25kT1RSLFvdiFtcM0ZQy0cVRqtrLk6stjYU2OFWS/qE8WfrGWauxVzmbOG7nzHWdwcn96q3wZ4iRwjqPA4h1BkrkIix7sn2H0R7dpJdyWqU8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706806063; c=relaxed/simple;
	bh=+K0T97CVgMNpfRwZlO4eKu8a/DzZVeS+5rFivyPss+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+kq0HwV8lWIJKmjErXyL2mnFFlIsbhPkf/MsdobuFzdP510Q3JGaQ1MLn+JnZt/er7Szm5DG2aFcYkqHtvX75N0FBzY1Qg7UajfpQYWe5q2qpu2CmuMIAmEd+LjBsXwr+7zkgo0WonrVyuZYIjuJoAn1nZ7VC/oHCd6E3kkJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XfPMOc1V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bUN7yMh6xy2hWhvAEG7t+zJP6Ap6R4V2I56VA8W+GD8=; b=XfPMOc1Vq3U3HOb18Bz8QczK3k
	g+LxL9dyOB95t/oGQzYWYyETjRxfv+GLcPmPfUfCFqCmGzlIEgl5v8EMON+nLJH+kRh9CMc2LknpE
	M4fDU8lpc+Chg/33DQ935/cp4zaBrwvfIfoFPOsEDSTPmULjLXy99RDT4X2KWxL7ASpY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVaDh-006hIq-0x; Thu, 01 Feb 2024 17:47:21 +0100
Date: Thu, 1 Feb 2024 17:47:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <b4fc0bc4-1585-4ae0-a980-10814e6d9ff6@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
 <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
 <a02c7451-8515-45d4-ae7b-9e64b03b5b38@roeck-us.net>
 <20240201162349.GC48964@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201162349.GC48964@debian>

On Thu, Feb 01, 2024 at 05:23:49PM +0100, Dimitri Fedrau wrote:
> Am Thu, Feb 01, 2024 at 05:39:25AM -0800 schrieb Guenter Roeck:
> > On 2/1/24 05:27, Andrew Lunn wrote:
> > > > > +#ifdef CONFIG_HWMON
> > > > 
> > > > HWMON is tristate, so this may be problematic if the driver is built
> > > > into the kernel and hwmon is built as module.
> > > 
> > > There should be Kconfig in addition to this, e.g.
> > > 
> > > config MAXLINEAR_GPHY
> > >          tristate "Maxlinear Ethernet PHYs"
> > >          select POLYNOMIAL if HWMON
> > >          depends on HWMON || HWMON=n
> > >          help
> > >            Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
> > >            GPY241, GPY245 PHYs.
> > > 
> > > So its forced to being built in, or not built at all.
> > > 
> > 
> > Even then it should be "#if IS_ENABLED(HWMON)" in the code.
> > 
> >
> If using "#if IS_ENABLED(HWMON)" do I have to add the dependency in
> the KConfig file ? When looking at other PHY drivers, they do.

Please follow what other drivers do. Its easy to break the build,
resulting is undefined symbols. What we have now works.

	Andrew	  

