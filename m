Return-Path: <linux-kernel+bounces-94753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F98744C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74701C20E08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C21CD21;
	Wed,  6 Mar 2024 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ca4LJIyU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CBD1C290;
	Wed,  6 Mar 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769178; cv=none; b=rDfucHyHLlNCjCCgof4eoo5s8I4L4xY/r9ikVVj+jAKfmW3QR3GF8r5hhwiPGbcwlN+mUn7SZaQOpbMeBR7MpU2+EjV1vbRlz59ObJk++/3+KXQkz38dsA/nWoxJBEJkUMb8tccKR797iyEXXE60Dk2juohZmS0F19MnXH7qGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769178; c=relaxed/simple;
	bh=1SvvByfg6c6eVlB8Y01vsD59/Z24m4ZoYgGxbnyuHcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErEniBwLARN0qoF9yHf/htPdlgogkL2GrVzyvFYunm+/WjzVi+/Vn8eT1SC2KjpKZ9zCWX1VKU1At9WpUxBYaMKsK1jEdxwyrNfuiZp6KM+CWU/k60UorVwI/rMNEDGyjG+sd0zwjGqZ4Dy0trFI1sJTpuTwUHJ0OrsT1H5YBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ca4LJIyU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gZEDHlbALjwDllMhSvFGjPdmGN7A0cnrj2b74eWzH0Y=; b=Ca4LJIyU8rwcuNlFo3LnpbP7sS
	+GOeTLwQwV8yixop6/S8l2HF+vUtF8udkY6Tz/+bB9Zo5nFo8n0y4bfh8RQWCU602uEZEtjQcNbCs
	AECk1WWd0bNJSJOPrzfkUrnYdh+hUa334wlAt9t7MMY01u6CNu9bY+FiP9bKDya95SAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri14b-009Xa9-PP; Thu, 07 Mar 2024 00:53:21 +0100
Date: Thu, 7 Mar 2024 00:53:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	richardcochran@gmail.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Message-ID: <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>

On Mon, Feb 26, 2024 at 01:39:34PM +0530, Raju Lakkaraju wrote:
> Wake options handling has been reworked as follows:
> a. We only enable secure on magic packet when both secure and magic wol
>    options are requested together.

So it appears unclear what should happen here.

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/bcm-phy-lib.c#L909

WAKE_MAGICSECURE is a standalone option. You do not need
WAKE_MAGIC. And even i you did request both WAKE_MAGIC and
WAKE_MAGICSECURE, the WAKE_MAGIC would be ignored.

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/dp83822.c#L153

WAKE_MAGICSECURE is a standalone option. You do not need
WAKE_MAGIC. However, unlike the broadcom device, you can have both
WAKE_MAGIC and WAKE_MAGICSECURE at the same time. They are not
mutually exclusive.

This also looks to be true for other dp8**** devices.

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/mscc/mscc_main.c#L318

WAKE_MAGICSECURE is a standalone option. You do not need
WAKE_MAGIC. Also, you can have both WAKE_MAGIC and WAKE_MAGICSECURE at
the same time. They are not mutually exclusive.

So i think your point a. above is questionable. Can the hardware
support both magic and secure magic at the same time? If so, follow
the TI way of doing it. If you cannot do both at the same time, and
that is requested, you should probably return -EOPNOTSUPP. That is
probably better than what the broadcom driver does, silently ignore
WAKE_MAGIC.

> b. If secure-on magic packet had been previously enabled, and a subsequent
>    command does not include it, we add it. This was done to workaround a
>    problem with the 'pm-suspend' application which is unaware of secure-on
>    magic packet being enabled and can unintentionally disable it prior to
>    putting the system into suspend.

The kernel should not be working around broken userspace. But i also
suspect this is to do with it being unclear if WOL options are
incremental or not. Since it seems that they are not incremental, it
does not matter if "If secure-on magic packet had been previously
enable". pm-suspend is setting Wol how it wants it, which you say is
plain magic. So magic is what the PHY driver should do. Feel free to
submit patches to pm-suspend to make it understand secure magic, or
not touch WoL at all with the assumption it has already been setup by
something else.

	  Andrew

