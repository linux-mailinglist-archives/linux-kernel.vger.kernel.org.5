Return-Path: <linux-kernel+bounces-65714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219148550C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B901C29063
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC673127B48;
	Wed, 14 Feb 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uMJSRQ6I"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F022071;
	Wed, 14 Feb 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933013; cv=none; b=jmSWUCBUkWxX+k30m2FcDmiydU+TPNZG2St6aqJLzT1TSI3EDuPX7LpPQZZVa86EH0y9gPq0egjooxxTZQyGFlhosAWnn3tVgvGADbVM+MgGGCW3t5O+6mvRhKeaC8Jj5TSF6ZGNlB1Pl73XK32tl2h/uB+bZk/W/ObH5ofXWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933013; c=relaxed/simple;
	bh=ZeAjhz2SHZ7qVY+YITXk+ILH2yqzuQc9Jpvkue+5hpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qStPwfLG2VoF0PfoRBsWtpst4m3IC7q+nBHfo3BfdOMUfofz0Vys+Q4eYWPIlyx9lHhri3re8/kgjwbdHMKpg5LUqdnJYeQQIWgV8dXv+PgFl76Y2i9b7SjvzZZaHtrC616u6RdcPblS3ehppvpwYG+PNKipXm3TKeyjeh+w9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uMJSRQ6I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LscDPLZ+ohMWAjRIWzZ8eZizMWZKhn6yplli/9BNMCw=; b=uMJSRQ6INcdTlrMNOJGqYqFrv3
	2EIJ0woTdfL3Jo2LS3aygZipk1KIuuLMROTyHWOiSMyLG7ZtklHviIfm53POqko4pAjV3cHh76TwN
	d6DpMU5lmLfGrCan6QTRHw7STOUzaNqVQP9tpEaJ19DVFahKRFjsTLgNwCxzcRUyhrF0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1raJOd-007oPB-37; Wed, 14 Feb 2024 18:50:11 +0100
Date: Wed, 14 Feb 2024 18:50:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v6 net-next 08/14] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <84e591c9-18db-4edf-8e3e-deed0cc8e131@lunn.ch>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-9-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213213955.178762-9-dima.fedrau@gmail.com>

On Tue, Feb 13, 2024 at 10:39:47PM +0100, Dimitri Fedrau wrote:
> Marvell 88q2xxx devices have an inbuilt temperature sensor. Add hwmon
> support for this sensor.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

