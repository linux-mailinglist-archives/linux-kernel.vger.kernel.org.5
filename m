Return-Path: <linux-kernel+bounces-128838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A398D89604A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE322868A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60186243;
	Tue,  2 Apr 2024 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z9xxhe6k"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013712E63;
	Tue,  2 Apr 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101163; cv=none; b=mNKP4964p/1K5WnXb1IVhm+Rt0Ro9g0idmTd+yIwKG81t2tHk8DVvDAlqu7BH9L2bH0AsxKoP9cZJIY/HwHgFw8Z+ktg3raqgIUjPENO2gFMgHB4wWspSjr+rG+21jej6FVkkcr3HaLsV79T9z9IKFPbemW0W6F5s5txejRgFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101163; c=relaxed/simple;
	bh=MwPg8jFKKSVNMET8vKI+YTdrLPlMRCa7YFqGoLSay4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3epr4VNMGEItHILpxShDrIe/FRHwoLzfnqXKva/WrfhWR5n2fSb6EDv5tjANtGTMdAbRytIzl6g9/1ahL0JPy8oxhn8aNXUQjewHwkkowFUl/o7ro8UkttiveVCJ/klrHddDpY0LJwGEBxTvmEIo0ebrgw71deCohz6d4CGKWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z9xxhe6k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zz4MecEkwcgM0VDSf806VYtUluoqVIxsc7Y+pFB+7Y0=; b=Z9xxhe6kYy2n9rlKpomGYtLFyF
	mtGmGGF4o4gQ8qmL6kxagUy9kq14AQSJHgDDwytFaFLZYc5iIpE7vhchRTFuXNVA94Xp60ngPxigq
	pYwKim+jgf3vbUnIunvDZoCwq72V6TIL7/PBkb3387X8NUYhTWjazKfyIkPAGPJFEw1o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrnii-00BzvM-LP; Wed, 03 Apr 2024 01:39:12 +0200
Date: Wed, 3 Apr 2024 01:39:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: phy: marvell: implement cable-test
 for 88E308X/88E609X family
Message-ID: <aae21b7c-c321-4e82-a89d-2fbcebf97b20@lunn.ch>
References: <20240402201123.2961909-1-paweldembicki@gmail.com>
 <20240402201123.2961909-3-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402201123.2961909-3-paweldembicki@gmail.com>

On Tue, Apr 02, 2024 at 10:11:20PM +0200, Pawel Dembicki wrote:
> This commit implements VCT in 88E308X/88E609X Family.
> 
> It require two workarounds with some magic configuration.
> Regular use require only one register configuration. But Open Circuit
> require second workaround.
> It cause implementation two phases for fault length measuring.
> 
> Fast Ethernet PHY have implemented very simple version of VCT. It's
> complitley different than vct5 or vct7.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

