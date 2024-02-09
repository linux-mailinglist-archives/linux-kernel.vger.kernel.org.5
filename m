Return-Path: <linux-kernel+bounces-59412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E984F687
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC6B1F24D28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2765BC6;
	Fri,  9 Feb 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2M86y8nA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08075A11D;
	Fri,  9 Feb 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487650; cv=none; b=PUGyYem6ElmsSkEIrihZRUz71Ct259vVAU7d25pDqo95zZ57fHxL/eED3ew2TvNwE8npZ8dCEYxCbXbpSdGTE6lBbcjRYNjZiBoWGSrl+7T/av/zeI/I7yQvYgBf+WcCMS2JFkpiYy7Gr1BAzklhpw55f6DJnhkjk7dNqOhJd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487650; c=relaxed/simple;
	bh=THGZeA2cURz+kUfLbIdxHc71uWdwiQg2aIRuESQaCUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk/zqPR6CjiCEgEjpHXplG5luNM3khArybRvQHe/aafW7xagsDHUDWuMinBXcAV7zlgunR+l/lw+xHCnK7Uug7O2DB/5a69X6Z3Ai+Xj9+69wFltBY299Ic0zPd5ILjaP1mcSOTm30HhWQMjoPlXRGwvgmN4zLol0Z1JtfzWkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2M86y8nA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tdosNxThGv2416wmdrJFMsCGK//KPgRIuMFHO9IZ7+k=; b=2M86y8nAqZ5mKueNq4M6Be7gSF
	ymAWRGbYmZsT3+SAHNuQKumsZDhOKlv+2fxHNtYNwZk788pbvxoo+veywFM7kyljm97RNLEXk8PHk
	i/b1a2dO0i8nPSvNnzMc0oQe0nt7KhV09w7Ryi3CQA/vYL+jOpqGxniegsf3GszyRSLM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rYRXE-007OAp-Ic; Fri, 09 Feb 2024 15:07:20 +0100
Date: Fri, 9 Feb 2024 15:07:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, afd@ti.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
Subject: Re: [PATCH v3 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <00691961-d516-4338-b7e8-203625e561ee@lunn.ch>
References: <20240209123628.2113971-1-catalin.popescu@leica-geosystems.com>
 <20240209123628.2113971-2-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209123628.2113971-2-catalin.popescu@leica-geosystems.com>

On Fri, Feb 09, 2024 at 01:36:28PM +0100, Catalin Popescu wrote:
> DP83826 offers the possibility to tune the voltage of logical
> levels of the MLT-3 encoded TX data. This is especially interesting
> when the TX data path is lossy and we want to increase the voltage
> levels to compensate the loss.

Maybe i'm being nit-picky....

"TX data path is lossy" should probably be "TX data path as far as the
RJ46 socket is lossy". 802.3 probably defines the voltage at that
point. If you tune it so the voltage is too high at that point, you
are breaking the standard. So you can use this to adjust for losses in
your coupling and cable run to the front panel. You should not be
using this for range extension by cranking up the voltages. Yes, you
might be able to, but we should not be encouraging it.

      Andrew

