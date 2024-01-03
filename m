Return-Path: <linux-kernel+bounces-15606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D0822EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C16282689
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F871A72B;
	Wed,  3 Jan 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="USeuP+6k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D085199D2;
	Wed,  3 Jan 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wftCAkDxtuNgREe2HZPa3UL9Ps/2/U2R6GRFaMlVY1k=; b=US
	euP+6kNtuAmnCHC5R82wsZ6MBoz1Rl+VJXsBp9EyebDf9hqY/etB3vrWp5JFVKvRR5Cgv49Uy5nYX
	grXMxco3T0Ss2j8U6bHNfqIQrwAZOhFU+TNQ/y8C0MnviLEq9UUb8AItIMRoQW7NRiulBBzLmTP+s
	iRVuFX5cS1Plwag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rL1Sa-004G2B-2H; Wed, 03 Jan 2024 14:39:04 +0100
Date: Wed, 3 Jan 2024 14:39:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge <Jorge.SanjuanGarcia@duagon.com>
Cc: "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Message-ID: <644421dd-0d03-4a6f-98ae-93d2c2bd1b80@lunn.ch>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
 <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
 <285f6402-db06-462b-9ca5-8363027283e1@lunn.ch>
 <2e09402c8cdd1109e730df58df3e59fdb3e5ab53.camel@duagon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e09402c8cdd1109e730df58df3e59fdb3e5ab53.camel@duagon.com>

> There are a few drivers that set the max_mtu based on "max_frame_size"
> parsed from device tree. Here is a list:
> 
> driver/net/ethernet/
>   stmicro/stmmac/stmmac_platform.c
>   altera/altera_tse_main.c
>   socionext/netsec.c
>   ibm/emac/core.c

So not many.

> I also considered hardcoding this to the maximum capabilities of the HW
> but I ended making this a configurable frame size. I beleive this way
> it is more stable as I don't know whether there may be any performance
> issues if we default the max frame size on the swith registers to be
> something different than the standard 1522 bytes. I need it for my use
> case where there is a DSA switch connected to one port and I need some
> extra room for the DSA headers.

Generally, you just set max_mtu should not have any performance
impacts, since the MTU will still default to 1500. The user has to
take an action to change the MTU and only then could it have any
impact, if implemented correctly.

DT should describe hardware, not configuration of the hardware, and
this is clearly configuration of hardware.

	Andrew

