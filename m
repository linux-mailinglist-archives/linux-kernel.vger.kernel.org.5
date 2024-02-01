Return-Path: <linux-kernel+bounces-48231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AA8458DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA71C233C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E75338F;
	Thu,  1 Feb 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GOBvCrf6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8AC5336E;
	Thu,  1 Feb 2024 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794064; cv=none; b=sWdvML+B6GoGEMBCd8Yv7xLoKeGptzvy9RRPmCJbcUQgSv/Cxv29CMjYW0Y/ZTlFzgXR+ne/GoMNaCFO+Tg8633WKMhFigmcnHTPJxV/gvzxMPbzHB2fPttLtzOs9DIEJLQzdWb0vHL3BMPfNP6Z0jDGzFBxPB8LigxhPYY00rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794064; c=relaxed/simple;
	bh=Eg9W3NSA9s6osL6RP2fEHXmCU98GnHHKlYaGBUQfKk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzMxLtY4XEITosXCcDNHiyndsVfd2v6JAlGHgzHHHG7D1bdsJvpa4aEIFq0IlV+FljzXqLIYPEiav16BZrsIEV6MuKPWmyJxZxyJmf5mDHarecE1SAVKMF1x9r0RCXwY79EL/8n2dXX+XhzxitEdsNUDXp6NNdCnMl7rn++H8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GOBvCrf6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zjpeycqnVI85EQN7sDqSOxS/I+t8ZWH69ZG5XBfe+hM=; b=GOBvCrf6MlGPgkU0qKHXY8Xic1
	UtjA5kdkn775QjBvCaGI5WkgYsh2FLU7yS5RyllVeSR/rTXtNFx/9pbtg+hFEWsfWhlWI/7l0zOOb
	5L3LLrlXxK3+yuoysWEaRayqd+OxlQ65p3Sdtleq4W0Xpw7/2bOM/DSQKhXeUvnfiRW0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVX6G-006g11-27; Thu, 01 Feb 2024 14:27:28 +0100
Date: Thu, 1 Feb 2024 14:27:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
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
Message-ID: <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>

> > +#ifdef CONFIG_HWMON
> 
> HWMON is tristate, so this may be problematic if the driver is built
> into the kernel and hwmon is built as module.

There should be Kconfig in addition to this, e.g.

config MAXLINEAR_GPHY
        tristate "Maxlinear Ethernet PHYs"
        select POLYNOMIAL if HWMON
        depends on HWMON || HWMON=n
        help
          Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
          GPY241, GPY245 PHYs.

So its forced to being built in, or not built at all.

	Andrew

