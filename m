Return-Path: <linux-kernel+bounces-20600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF59828236
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B79283DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F42FE09;
	Tue,  9 Jan 2024 08:40:41 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EF35883
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas12t1704789534t600t43976
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.99.45])
X-QQ-SSF:00400000000000F0FTF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12816306648169653437
To: "'Arnd Bergmann'" <arnd@kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>
Cc: "'Arnd Bergmann'" <arnd@arndb.de>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Andrew Lunn'" <andrew@lunn.ch>,
	"'Maciej Fijalkowski'" <maciej.fijalkowski@intel.com>,
	"'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
	"'Russell King \(Oracle\)'" <rmk+kernel@armlinux.org.uk>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240109075656.2656359-1-arnd@kernel.org>
In-Reply-To: <20240109075656.2656359-1-arnd@kernel.org>
Subject: RE: [PATCH] wangxunx: select CONFIG_PHYLINK where needed
Date: Tue, 9 Jan 2024 16:38:53 +0800
Message-ID: <02d101da42d7$471ee5a0$d55cb0e0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGnjceTU78UgugiVxFOlyNGoTOZtrE2kqPQ
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Tuesday, January 9, 2024 3:56 PM
> To: Jiawen Wu <jiawenwu@trustnetic.com>; Mengyuan Lou <mengyuanlou@net-swift.com>; Jakub Kicinski <kuba@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>; Russell King <linux@armlinux.org.uk>; Andrew Lunn <andrew@lunn.ch>; Maciej Fijalkowski
> <maciej.fijalkowski@intel.com>; Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Russell King (Oracle)
> <rmk+kernel@armlinux.org.uk>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] wangxunx: select CONFIG_PHYLINK where needed
> 
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
> ---
>  drivers/net/ethernet/wangxun/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
> index 23cd610bd376..46630f05d8dd 100644
> --- a/drivers/net/ethernet/wangxun/Kconfig
> +++ b/drivers/net/ethernet/wangxun/Kconfig
> @@ -26,6 +26,7 @@ config NGBE
>  	tristate "Wangxun(R) GbE PCI Express adapters support"
>  	depends on PCI
>  	select LIBWX
> +	select PHYLINK
>  	select PHYLIB
>  	help
>  	  This driver supports Wangxun(R) GbE PCI Express family of
> --
> 2.39.2

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>


