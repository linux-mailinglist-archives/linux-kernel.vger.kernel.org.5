Return-Path: <linux-kernel+bounces-23866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF33082B2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A491F26A11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD464F8B7;
	Thu, 11 Jan 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvYf1RF6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AF4F89C;
	Thu, 11 Jan 2024 16:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BD9C433F1;
	Thu, 11 Jan 2024 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704990519;
	bh=wOlw6k8oeC5WKfVf/WyGf04YxAUDhKpIuRBaG8SWzXg=;
	h=From:To:Cc:Subject:Date:From;
	b=hvYf1RF6DuM/eVkHhjtTnrm4XHlLDo7AH1VNzHShDw1mFxJhgPvSmSoODMm2I3D75
	 Dxh0yBW7wvX9tr5/wPuDviqS9VfriM8H+JjVDIVsoq4J0ypKM+KgzhSCS4KTfZh972
	 WeFKbC8kWdlzezOM4M3gAgvP/KtoCKDhUlijhfmientVwgiBHTDKuKtLyBP1LdXKr8
	 KtGRgGaGIkOrYch0RL7PC3sWIVrdkAIbs/6++VdxZtixlW8G9WIHB5zdSQHVnieGyE
	 iBRNA/w8hR2ZGny1QGQCsF8KYUsisgjyrMqkkO0vdkG1KMOP5857vaZVKGKo0Uv2Ot
	 DcE/6Heg1ZCVg==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [net-next v2] wangxunx: select CONFIG_PHYLINK where needed
Date: Thu, 11 Jan 2024 17:27:53 +0100
Message-Id: <20240111162828.68564-1-arnd@kernel.org>
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
This addresses a build regression in net-next at the moment, it would be good to
have the fix merged into net-next before it makes it into mainline.

v2: As suggested by rmk, remove the PHYLIB reference in the process, since PHYLINK
    requires that already
---
 drivers/net/ethernet/wangxun/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 23cd610bd376..85cdbdd44fec 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -26,7 +26,7 @@ config NGBE
 	tristate "Wangxun(R) GbE PCI Express adapters support"
 	depends on PCI
 	select LIBWX
-	select PHYLIB
+	select PHYLINK
 	help
 	  This driver supports Wangxun(R) GbE PCI Express family of
 	  adapters.
-- 
2.39.2


