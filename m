Return-Path: <linux-kernel+bounces-20503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7B3827FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB452880B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F125742;
	Tue,  9 Jan 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYDd13yT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D825224FC;
	Tue,  9 Jan 2024 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61DBC43390;
	Tue,  9 Jan 2024 07:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704787024;
	bh=osEjPHFSBRRETsdDQv26/OIMeyS5BBWg439/b7Ob4A8=;
	h=From:To:Cc:Subject:Date:From;
	b=pYDd13yTLCtkfqQoESXCMcWnOzWulKNk0gNlddCa0aVZUdp73YdTPb6zOa+NDYu1U
	 wk2QrfUSBUKYmJwDUkE4hZqOPiU4drhPMeWxRInBVCN3gGpEw3ciEFBE4eZPyhuz+t
	 5WPB7o7I+QxEc8szDmNMOYcylAEOHfuPQ10YKp2Kj0a1znltyenmmV10G5PDlnlTsh
	 /By3rMemiSg4sqV1FMX8O68Q1wbv0HZUCQ5TV3GuTTzTGncFjtQCKyQ+ibFpU9LMPg
	 S6XzseCo2sbnJU0JJFJVEAbT3dHoVSXz602LCHPpGksRYIx7bbxbZQXHT2th40jGKN
	 b5f99I1NdcA3w==
From: Arnd Bergmann <arnd@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wangxunx: select CONFIG_PHYLINK where needed
Date: Tue,  9 Jan 2024 08:56:21 +0100
Message-Id: <20240109075656.2656359-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The ngbe driver needs phylink:

arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_nway_reset':
wx_ethtool.c:(.text+0x458): undefined reference to `phylink_ethtool_nway_reset'
arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_remove':
ngbe_main.c:(.text+0x7c): undefined reference to `phylink_destroy'
arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_main.o: in function `ngbe_open':
ngbe_main.c:(.text+0xf90): undefined reference to `phylink_connect_phy'
arm-linux-gnueabi-ld: drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.o: in function `ngbe_mdio_init':
ngbe_mdio.c:(.text+0x314): undefined reference to `phylink_create'

Add the missing Kconfig description for this.

Fixes: bc2426d74aa3 ("net: ngbe: convert phylib to phylink")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/wangxun/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 23cd610bd376..46630f05d8dd 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -26,6 +26,7 @@ config NGBE
 	tristate "Wangxun(R) GbE PCI Express adapters support"
 	depends on PCI
 	select LIBWX
+	select PHYLINK
 	select PHYLIB
 	help
 	  This driver supports Wangxun(R) GbE PCI Express family of
-- 
2.39.2


