Return-Path: <linux-kernel+bounces-62862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD178526F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013ED1C25822
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E814F7A;
	Tue, 13 Feb 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z9J6jH36"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CC1401E;
	Tue, 13 Feb 2024 01:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707787785; cv=none; b=Xx7++KULtmC3bmyTOpH23tTaSlcuUEC5IoQ3tiUEnsXvPo9wDChlyP3F6304InKk/OeXVsT9HNu9EYQd75u+OO75ZP6nkpxnA3bOasW19AKek1Kr/oWfu0jSBRC9h05i89GqD28V01I/LKUFEJF0zzJyVzX9JOyXdAwEjsc4GN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707787785; c=relaxed/simple;
	bh=Tjnv2F2tmKHGGqszFFh0HeqfWo6dF/PQLZDD/lIfgyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naPf2HpuxyWL5Nqc0MZ10m99Waj+G3lgYLwOxHh/dNYfy+jzslVoNEYu/yPEsi4u4jk+jngQedjxZ6zOpFQJjAA1uijy27ktR0o7KprgsSa36U3D2PPMZkHssIkW9xS1T06UNE1I4om9oucpbeGMYdNcbYS0pfH7u0roz0bNgCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z9J6jH36; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a+l3RwTWnNWwFciVajfFmBts8p6VEX7T1aYyB4l98oQ=; b=Z9J6jH36sazu2t3A33oiG2sf1y
	4Qd/z/v3eHtykVIirj7/iH9C+asjP2ipFLPPBOhzJ5JtyTvsPOEDpPPCC9LgBhC59TV+7W4I3Z3MY
	5RnOvvrGMCGovdjDmb7hL2T3N35S9lmMMI89BtpiguADOOG4v/zFpNBwIwGKTStm5KA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZhc9-007ccG-3B; Tue, 13 Feb 2024 02:29:37 +0100
Date: Tue, 13 Feb 2024 02:29:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, afd@ti.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH v4 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <e1eaefe0-6a22-48b5-9429-13f71cc0e6fb@lunn.ch>
References: <20240212074649.806812-1-catalin.popescu@leica-geosystems.com>
 <20240212074649.806812-2-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212074649.806812-2-catalin.popescu@leica-geosystems.com>

On Mon, Feb 12, 2024 at 08:46:49AM +0100, Catalin Popescu wrote:
> DP83826 offers the possibility to tune the voltage of logical
> levels of the MLT-3 encoded TX data. This is useful when there
> is a voltage drop in between the PHY and the connector and we
> want to increase the voltage levels to compensate for that drop.
> 
> Prior to PHY configuration, the driver SW resets the PHY which has
> the same effect as the HW reset pin according to the datasheet.
> Hence, there's no need to force update the VOD_CFG registers to make
> sure they hold their reset values. VOD_CFG registers need to be
> updated only if the DT has been configured with values other than
> the reset ones.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

FYI: The WoL discussion should not prevent this from being merged.

    Andrew

