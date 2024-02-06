Return-Path: <linux-kernel+bounces-55549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3984BE03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87CB1F26CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C21429A;
	Tue,  6 Feb 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="522Rf+io"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D211426E;
	Tue,  6 Feb 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247200; cv=none; b=Wkgrzh9lC7bkBqo7XE0Pg6pPTmhG7WlrRr/8TeoT8oiGRCUIChAjpcsm76bg4KHi+QgYrs9GaHBL7pdt1nP0oj5Epcwi9nMhh1X182stFHVPv8nFQKWb59UhDnsC8259Ez4MximPSwdbb8X40JNJbnppzlQUhB9Q1GVfpicufCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247200; c=relaxed/simple;
	bh=dig3P5DqUNE0YcDq2EwPlQEKMHYJc1HfxIrOjf2+Npg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDIMJkVuLbi70vl/QCtiHxvfHjqBAYAG4FJmkdhbTyzNqakvix0VXis/5nptch888U6H2s2b2mqNhYjIVAfzQG1wZhLemCC+soSUkCWsBt7qOfqcqDifxaDrPLFLtcYegFq5+NTDCo2oHDhWH2Isogdbpw34c6M2Y8V04guWKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=522Rf+io; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LgtwqaM0q60IIOQMHiC8DeTlCEjVoxSbX6OM+ulu9VA=; b=522Rf+iosw91PvNlnfG004MR7j
	wT6eUkjMB6RMdzdgkkH5HHpSBX0kvkCE0n6JkKO6eJahWmwNyiA69hbCs8IF48rfd3qDpc05TgoQ9
	s0lAzpPiRWzyDs7V70bAnZMOtzdpnkrC8hiZ0TQ390OooJsDVkd/nn4DK8TrKt0N0UPI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXQyw-007AQi-M0; Tue, 06 Feb 2024 20:19:46 +0100
Date: Tue, 6 Feb 2024 20:19:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <6cf761ad-91a8-4fcf-a9f9-0c18b7fb0b29@lunn.ch>
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
 <20240109232838.GA3626@francesco-nb>
 <ZafXQS1_4fHpEzL0@ninjato>
 <20240206172645.GA24848@francesco-nb>
 <dbae1fca-9313-40e3-9b5c-0de1a8e177df@lunn.ch>
 <ZcKD69vLxYkbvAL-@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKD69vLxYkbvAL-@gaggiata.pivistrello.it>

> What if the configuration was done using ethtool?

The MAC driver when handling ethtool requests should call
phy_ethtool_ksettings_set(). That manipulates phydev->advertising,
phydev->autoneg etc. These are the values passed by phy_config_aneg()
to the PHY driver.

   Andrew

