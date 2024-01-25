Return-Path: <linux-kernel+bounces-39309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE783CE92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D462991EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEA13AA46;
	Thu, 25 Jan 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UYTOesEX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CF13AA2E;
	Thu, 25 Jan 2024 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218032; cv=none; b=m1DjwsVWI+3p8hj7ZZj0I4slqhXu30R6NGtidM0Gb3nLtG4TJAylxTEj1GXddTuK9auP1tLZaWsGXpvHLM39phsimS88YTLdKgpVVwQLA1Rq3otqQs6Z2jF0h+Arc8mDTnVdm73yN+rJ+WYeGypq/DYXb+LS9+AZ3ili8dXchlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218032; c=relaxed/simple;
	bh=VFN2tC12iVVL07jEvxOH7/JjhfKXchwSdbKgnUoeMyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/s7K94NtnQ7lYET0tK4dlBr8M45sNTPc2/ipNUeReSEbzMHDfsbjZiPe3NrQIF1xIEzUgKlMs8v80pqM9V02dzFLzLyVTRf2NG8j4nRDKvBL0ek1CLXMENdSOaODQ0PoiL/mu9bDuTDjecUp74/Jx0x+suc3sQWNfVFZtCeGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UYTOesEX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jeSyT0KRwyOVIHE7b/FMS14no4aggtAsbaKosXzt7rI=; b=UYTOesEXnMh/Akcuh6TNOlqxno
	baBsC3gLyBnTjcCkLAH6p1sgfla8IV5mVCpEGjDsWBuV4QoAhh8nMDdpEbdGnwmRC8l0tlgp2xLyM
	Vy9t26KYxislMpLI9ZX3C7QHE969PGOTjdXS7nIMxvOOg0hYUV4VvNDf05O1IKrwF7T4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT7FE-0067qy-5e; Thu, 25 Jan 2024 22:26:44 +0100
Date: Thu, 25 Jan 2024 22:26:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>, dsahern@kernel.org,
	weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net 08/10] net: fill in MODULE_DESCRIPTION()s for PCS
 drivers
Message-ID: <1e9528f7-d9b1-463e-bfd2-b7ae14a92ae7@lunn.ch>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-9-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-9-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:18AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Lynx, XPCS and LynxI PCS drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

