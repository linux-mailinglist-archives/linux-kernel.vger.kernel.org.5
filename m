Return-Path: <linux-kernel+bounces-157784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDECC8B1629
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2E1F225BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771A16D4CA;
	Wed, 24 Apr 2024 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bMRhgFRe"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044019BDC;
	Wed, 24 Apr 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997632; cv=none; b=d/wvx9nwIGdxbuJLJEB5aNb2BL4IkWyv6fnjm7JVl9tHD8zIk+VAl9N+665VYFMz68b6H7eOpwM4KMrZqa4iMZbvTF5lO1JJV3zlTf/Y1iPLC/gJNAJuFCLQDLy/as55g39vae0IvWYC965r7Uf11ZU36sMf+iSM2HXiVo+tOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997632; c=relaxed/simple;
	bh=mr6dI/QUD1Ch9WACeqoktdbI/KcKANVRLuvCXSELSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFA5bkVhsVKvU5lA4wliFfAcpx3xIWniyipsr/rdwIHwSDCqZr470rOJqBGnC24IHsYhQj1nftnHvKVsvF2oPse65u1M3ns0yZ4nFajZQcNgXdTjZEXqLSYYMl1NxPxrJwkU2wG8iVTxoAQGKndWC/FsFMmmbKNjBUEZKs+nbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bMRhgFRe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/U67hF5HIifhfl+FZSrLc2zlLCGyQGz76KtbopmNEG0=; b=bMRhgFRemnmXu6ECTBiBWM1yL6
	3JiWbbvywJYzIAbK7mZT8RtiLyxgt3Mlb18/I2KoZzvcsdYoifF6gbmyU5VfY/zoGi6eYpZ6UXemb
	y0wpqGt0Rm0kSxuwQcdu6TsgtWdkY+Izlz3OfPGQ+vB9GVh35Ao25dqJ9B25ETCpliQs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzl4o-00DtQK-Mk; Thu, 25 Apr 2024 00:26:54 +0200
Date: Thu, 25 Apr 2024 00:26:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fabio Estevam <festevam@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH net v2 1/2] net: dsa: mv88e6xxx: Add support for
 model-specific pre- and post-reset handlers
Message-ID: <6a6959dd-3ab1-4a5c-963b-2146bcbf0b47@lunn.ch>
References: <addee2a493823b4a7e0ea966b1713f4ed6c04a2e.1713858017.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addee2a493823b4a7e0ea966b1713f4ed6c04a2e.1713858017.git.matthias.schiffer@ew.tq-group.com>

On Tue, Apr 23, 2024 at 09:47:48AM +0200, Matthias Schiffer wrote:
> Instead of calling mv88e6xxx_g2_eeprom_wait() directly from
> mv88e6xxx_hardware_reset(), add configurable pre- and post-reset hard
> reset handlers. Initially, the handlers are set to
> mv88e6xxx_g2_eeprom_wait() for all families that have get/set_eeprom()
> to match the existing behavior. No functional change intended (except
> for additional error messages on failure).
> 
> Fixes: 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

