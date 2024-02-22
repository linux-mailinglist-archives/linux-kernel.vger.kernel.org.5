Return-Path: <linux-kernel+bounces-77265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447818602BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6681F25A88
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8747C6AF82;
	Thu, 22 Feb 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EDnlZS/F"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE1548E3;
	Thu, 22 Feb 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630393; cv=none; b=mHHlzivr5Rcum+NLpLBDcK2edSfceJAAkQcSkpAAQK0HB3r9moW4exaFUPuMqdmla2HGqTYHQjrxQUON6hMdqkprfBbB/XCPIQCKooQg6MdNyD860lw8AgcjL7soBmhB+HuF2T9qZG8JedVxdqWpq8PXwcLS7I7d3Q8Epicaz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630393; c=relaxed/simple;
	bh=SsMEPEzS+J84TF7BO8eIlxKQtrTsNOrjRtjClfS0r4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs/rgHjkRLIGdl42hO8P2+qWSpC8U/4z2RxATepLYsrJcleVBfSmzUE7dzpphwl7DE6/6e9x+DvBGJAUc7FZRkIKeimlmnp8dVWzvIaxEjc4+zOAlaeYaMlWmMMreXR/djVKHbS0LY2mJ5QpzAuDrJdeHmvmyKkvOvFk6NTlZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EDnlZS/F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=drWQzvlnEBcW5dvKDzDFY4gU6bq3wS1gAprIHRuoXXI=; b=EDnlZS/FAjWflt8kA9898R4PYL
	771HsUlpM+Y9uY2yMk7qJB+HK4DOn+WxBr2+NWofsV6ps1P3/g/j/KPXBJDoZ405RH7lv1GGMLO9v
	7cTPfGif9J0hQAfYysBjXxwSetG4YfFzlB80ox4Lwl3xa25KATIRZ+bJH9WNDBhnpbH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdEoV-008TX4-W5; Thu, 22 Feb 2024 20:32:59 +0100
Date: Thu, 22 Feb 2024 20:32:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v2 2/4] net: macb: Add ARP support to WOL
Message-ID: <8e4a779a-22e7-4db2-b65e-69cca5e6fac5@lunn.ch>
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-3-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222153848.2374782-3-vineeth.karumanchi@amd.com>

>  	u32			wol;
> +	u32			wolopts;

> +	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
> +	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;

> +	if (bp->caps & MACB_CAPS_WOL)
> +		bp->wol |= (MACB_WOL_HAS_ARP_PACKET | MACB_WOL_HAS_MAGIC_PACKET);

So bp->wol is the capabilities of the hardware? 

And bp->wolopts is what has been enabled via ethtool?

I just wounder if it would be easier to understand is bp->wol was
renamed wol_caps, similar to bp->caps?

	Andrew

