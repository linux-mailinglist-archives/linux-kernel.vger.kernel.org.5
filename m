Return-Path: <linux-kernel+bounces-167141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9D8BA4E1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F4E1C21ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7FE556;
	Fri,  3 May 2024 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="G3iSQ0lF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D88C05;
	Fri,  3 May 2024 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699536; cv=none; b=oGPzLPDTZdlBdp6xJsEBJhF4+3lCrSrSCTPDevqS4yqzPSGXlWKHaXDVrFtK5UBh+iK06Gxi9GOHpdoy5aOsPGEoQfJu2nLhpzVG0GlFk3Skg/7JS8aztkFDVAIjvTzACybXurKBBwSZaUlvOgiHay5/SJ5YTFWuOOp0/JrhRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699536; c=relaxed/simple;
	bh=S+1vg85RtNFRN/JDYIDaIn7QFx/jLQ9h75TpWJA8Dmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/rwt5hfObvWkMZ+K5/Lk21RerIAN28VLy3QYEwAVBZN97o4UJU9JOPlTbjO57pNsOztEg5b8XeqQyvgL3VWpL77VFX9Je4/Adx1qbaKbQoG5MZVnuPlP4e38SKAtPxBezjvzguonQpai5ZHpspIslvpqnI1qt8yXgBH2ZbHdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=G3iSQ0lF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rPaJqqgEDySEy7m0HaNo8dsnzSm/N9I0/G6a8VXE0NA=; b=G3iSQ0lFTzjf7q24aBd4DutcCh
	T7kJxoiU3WKIB80JHJI3irt9WQKmxOhjdzoDfpb1kplsX6x8CRVvBdYVCm7rKGNsWTztVazbf9QXv
	nmKnOScH08h+7b7DiICyFQ1R01l/AP5sNmk3VxIrMRkUptPWYJUWcnACbcQErotrnPxM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2hfr-00EXRq-Rh; Fri, 03 May 2024 03:25:19 +0200
Date: Fri, 3 May 2024 03:25:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, hkallweit1@gmail.com
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <25d1164e-0ac2-4311-ad27-aa536dca3882@lunn.ch>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
 <ZjFl4rql0UgsHp97@shell.armlinux.org.uk>
 <ykdqxnky7shebbhtucoiokbews2be5bml6raqafsfn4x6bp6h3@nqsn6akpajvp>
 <7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew>

> AFAICS the problem is in the race between the end0 and end1 device
> probes. Right?
> If so then can't the order be fixed by adding the links between the
> OF-devices?  As it's already done for various phandle-based references
> like "clocks", "gpios", "phys", etc?

It gets tricky because an MDIO bus master device is often a sub device
of an Ethernet MAC driver. Typically how it works is that a MAC driver
probes. Part way through the probe it creates an MDIO bus driver,
which enumerates the MDIO bus and creates the PHYs. Later in the MAC
driver probe, or maybe when the MAC driver is opened, it follows the
phy-handle to a PHY on its own MDIO bus.

If you were to say it cannot probe the MAC driver until the MDIO bus
driver is created and the PHYs created, you never get anywhere,
because it is the act of probing the MAC driver which creates the PHYs
which fulfils the phandle.

You would need to differentiate between a phandle pointing deeper into
the same branch of a DT tree, or pointing to a different branch of a
DT tree. If it is deeper within the same branch, you need to probe in
order to make progress. If it points to a different branch you need to
defer until that sub-branch has successfully probed. And if you get
two branches which are mutually dependent on each other, probe and
hope EPROBE_DEFER solves it.

	Andrew

