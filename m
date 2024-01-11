Return-Path: <linux-kernel+bounces-23892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB29E82B34E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8FAB25313
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98B50279;
	Thu, 11 Jan 2024 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GNueH/jD"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417729423;
	Thu, 11 Jan 2024 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3whPCu9T/Xx4lp3PbnviQeKrWYOvHEvUnRUF2/ZVJe8=; b=GNueH/jDQxY7E0hVBtBkZvMDNe
	QHEcr5GY06S1/x9WTP44SAIM+p5+OwpXT4ulanTRQoHVZ6ZIHlFmSGTtwnZ9I3bIUGlacwcjGlNkj
	fsJmZhB89a7BOHa8jKYinZf5I35G+OkDMNHCdgYOCs5EVztVYn2vIew/poHInP+y0Y0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNyEV-00510l-F5; Thu, 11 Jan 2024 17:48:43 +0100
Date: Thu, 11 Jan 2024 17:48:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Russell King <linux@armlinux.org.uk>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next v2] wangxunx: select CONFIG_PHYLINK where
 needed
Message-ID: <a0cc1f98-e8ec-408d-a39b-d0506be3fb88@lunn.ch>
References: <20240111162828.68564-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111162828.68564-1-arnd@kernel.org>

On Thu, Jan 11, 2024 at 05:27:53PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ngbe driver needs phylink:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
> wx_ethtool.c:(.text+0x458): undefined reference to `phylink_ethtool_nway_reset'
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_remove':
> ngbe_main.c:(.text+0x7c): undefined reference to `phylink_destroy'
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_open':
> ngbe_main.c:(.text+0xf90): undefined reference to `phylink_connect_phy'
> arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.o: in function `ngbe_mdio_init':
> ngbe_mdio.c:(.text+0x314): undefined reference to `phylink_create'
> 
> Add the missing Kconfig description for this.
> 
> Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

