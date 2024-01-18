Return-Path: <linux-kernel+bounces-30176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87310831B04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2821C224DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F462576A;
	Thu, 18 Jan 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Brv+xSJA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FE25579;
	Thu, 18 Jan 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586532; cv=none; b=kzhtHgo2iagSxgGQUqmbF67wPYEDtvBt9Iec3JU9+i9YPyqWjB0jmQvyGrNPHwAi2/LViZDZghlY9tdlKTz3Hr9SXHbie3iQGH47E2C4vm7JHs06zqOjTbDLB/FCYrXPajOa892SVSytU+L9pOPBl1VMfIzJ/H7vPhsjWGBUcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586532; c=relaxed/simple;
	bh=0ZpTOxtF+JNwHEzDyAK3SuignG468h3k05SLchlkRsI=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ffgV1UJHBGPedQ0etsiv37lX3F1hVIopE0r23ncQ0E19d2AHxuot86lOHcKNwMUv9cD6M7DH5LdLjv/ti9jiGBxWpE0v1TJQGUs13kOmHvlpDXgIyws4PdeZmfUt8jK3TSeyelIUVRJ4aPTqdk0G0kGp6ehPnEHCXyp/dIKMSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Brv+xSJA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5xUMVOdWXR28LTjgi8INzdf5V0YNKbloTOUqIvRdyT4=; b=Brv+xSJAJkRLFEaaPkeJ5MarNg
	irsTXhPRhnZr/cBDlI30GAeY2ZC9pTgFOeh9gEpT1kTPzY4PwUvm9H62TLCvt98PKxD9spEU3Ni97
	HmgQCKiwclfVd2cKoq646LVS2y/He6n9bntFgEuW3RWaod8cVCQrV6mQ9mIqUYI3+dEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQSxv-005Txr-Jh; Thu, 18 Jan 2024 15:01:55 +0100
Date: Thu, 18 Jan 2024 15:01:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v2 0/3] Introduce switch mode support for ICSSG driver
Message-ID: <f3d75103-c1ca-448d-b5aa-736496d00342@lunn.ch>
References: <20240118071005.1514498-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118071005.1514498-1-danishanwar@ti.com>

On Thu, Jan 18, 2024 at 12:40:02PM +0530, MD Danish Anwar wrote:
> This series adds support for switch-mode for ICSSG driver. This series
> also introduces helper APIs to configure firmware maintained FDB
> (Forwarding Database) and VLAN tables. These APIs are later used by ICSSG
> driver in switch mode.
> 
> Now the driver will boot by default in dual EMAC mode. When first ICSSG
> interface is added to bridge driver will still be in EMAC mode. As soon as
> second ICSSG interface is added to same bridge, switch-mode will be
> enabled and switch firmwares will be loaded to PRU cores. The driver will
> remain in dual EMAC mode if ICSSG interfaces are added to two different
> bridges or if two differnet interfaces (One ICSSG, one other) is added to
> the same bridge. We'll only enable is_switch_mode flag when two ICSSG
> interfaces are added to same bridge.
> 
> We start in dual MAC mode. Let's say lan0 and lan1 are ICSSG interfaces
> 
> ip link add name br0 type bridge
> ip link set lan0 master br0
> 
> At this point, we get a CHANGEUPPER event. Only one port is a member of
> the bridge, so we will still be in dual MAC mode.
> 
> ip link set lan1 master br0
> 
> We get a second CHANGEUPPER event, the secind interface lan1 is also ICSSG
> interface so we will set the is_switch_mode flag and when interfaces are
> brought up again, ICSSG switch firmwares will be loaded to PRU Cores.
> 
> There are some other cases to consider as well. 
> 
> ip link add name br0 type bridge
> ip link add name br1 type bridge
> 
> ip link set lan0 master br0
> ip link set ppp0 master br0
> 
> Here we are adding lan0 (ICSSG) and ppp0 (non ICSSG) to same bridge, as
> they both are not ICSSG, we will still be running in dual EMAC mode.
> 
> ip link set lan1 master br1
> ip link set vpn0 master br1
> 
> Here we are adding lan1 (ICSSG) and vpn0 (non ICSSG) to same bridge, as
> they both are not ICSSG, we will still be running in dual EMAC mode.

This is going in the right direction, thanks for the changes.

What features does the dual EMAC firmware support which the switch
firmware does not?

If such features are in use, you should not reload firmware to the
switch firmware, since it will break whatever has been
configured. Keep with bridging in software.

Similarly, what features are supported by both firmwares? Does feature
configuration survive a firmware reload? Or is it necessary to pass
all the configuration to the firmware again?

    Andrew

