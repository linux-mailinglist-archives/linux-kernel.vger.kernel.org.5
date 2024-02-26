Return-Path: <linux-kernel+bounces-81947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00DA867CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922BD1F257F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358FC12CD8F;
	Mon, 26 Feb 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O8RMkpuQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ACA12C7FC;
	Mon, 26 Feb 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966407; cv=none; b=h8HEUjDyuGMZbKjuWzw8/miCVSo0RAbC4zw/CXyGx4WmxbT+nJsUZ5cWB5KcGFRD9wNA+42JMqKOuDGzCoGaf5VBAWlxFvoiD3te7sBgVSlqus+6nZdzle+C+Pio8g/C8qyJ90GD8/7sghKSxqyBb8q86L9jajAbnoX+3jv8XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966407; c=relaxed/simple;
	bh=KiMCRLVbukxEd51VY4SmxiqAWQeh8Z/9xcRcx2E0GJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArWvTSpIaGKA9p8k0Aa8wuJUy992opduedtgh9vg7y/HV8meN4BviITSxD0xA+N4VX+YUf7eVuFrPzOgP/Uobn/QMZmsxv3iF+uL4a4SgRbywY02sjESv/4aKNgAGINaMNGzgoqIgRw1JSUSfGhdNLGWKBU1BMc+rI6HqZ4Q2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O8RMkpuQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e5LzI+fYwzqDfr49BonbGexI34AFnEafybLaYyE7TzE=; b=O8RMkpuQvWfdaWYT9H+x798kxN
	3OjtAKfdXSLzuH/3DhZVZ0N2S7PEqUyi+ZmvSt97RQ9fu+wOij778f2eIiYt+2Pia4fkuRzN6edx0
	sj/Ta2LGh6x+2xCJVvg/jHX9QLaw+ZyWh3o9c8zgSuQhee+h1MvF+eCoKWlAfJmYJwgM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1reeEP-008kFI-KP; Mon, 26 Feb 2024 17:53:33 +0100
Date: Mon, 26 Feb 2024 17:53:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH net-next v2] net: phy: dp83826: disable WOL at init
Message-ID: <13a68356-235e-4945-8cf7-5b7a42b0bf46@lunn.ch>
References: <20240226162339.696461-1-catalin.popescu@leica-geosystems.com>
 <Zdy+Y8Mqs22yRrre@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdy+Y8Mqs22yRrre@shell.armlinux.org.uk>

On Mon, Feb 26, 2024 at 04:37:55PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 26, 2024 at 05:23:39PM +0100, Catalin Popescu wrote:
> > Commit d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> > introduced a regression in that WOL is not disabled by default for DP83826.
> > WOL should normally be enabled through ethtool.
> > 
> > Fixes: d1d77120bc28 ("net: phy: dp83826: support TX data voltage tuning")
> > Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> 
> It seems rather interesting that WoL is disabled in the config_init()
> method - because this will be called when the PHY is attached to its
> network driver (reasonable I guess) but also at resume time - which
> means one can't just set the WoL mode once and that status will be
> preserved.
> 
> Maybe Andrew can clarify, but I thought once WoL was configured, that
> configuration should remain until the system is rebooted.

Yes, i noticed this as well.

d1d77120bc28 does change the behaviour, clearing WoL was dropped. As
you say, WoL was probably broken before d1d77120bc28 and it will still
be broken after this patch, so no real change there :-)

Catalin as a followup, could you please look at suspend/resume via
WoL. As Russell pointed out, if the machine is woken from suspend, we
expect the WoL settings to be kept. So WoL should be cleared on boot,
but not resume.

    Andrew

