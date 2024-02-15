Return-Path: <linux-kernel+bounces-66345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E60855AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8379A1F28E55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0AD518;
	Thu, 15 Feb 2024 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S54J2VtP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB81078B;
	Thu, 15 Feb 2024 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980454; cv=none; b=eJD/KTUlmxayb/vXMJT7kc4PDyz+FkWz64IVEuaSZ37BRhMCpCWUgX6MQJ5nFfu38kd0gkwcwM5/WkDqXVoanVcXWjijhnMazAujAZQgPrfyqTbxNI0bmT/DrK5IP7EBHoYhNQxrC6c57cXf/9sGHmpoRnys1qVxXJxhOAPVkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980454; c=relaxed/simple;
	bh=Sv6TYk9A7yug+VNUx6Cx2DwkajIxr8aNySYn8ffdvJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=icXIxACMGps2pwfvICdi74Ieg79z7ml+ts5oNdiwxscYuKYSZYFx+7+tTWg44wcTcJV65F3u66AhALLTVKVIMilPcLeX25XRaCfSE44lD6e3KlBQKvGWHhObbGrYUGZMYa27EFwW6eOUuueuglyoOxR6ryj0+tV1C7QuZ72mmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S54J2VtP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6bFIvP+DXULNjZALZG/QIYQdP0Guue2+Sr22AwhwTHE=; b=S54J2VtPWYLCh+8UPA6yP9o3KC
	sglsBLmopfBfX/VDS1SDuAb5aLlDU/oryRgPoD3E5cUOec197dfYaJ4E3pNxspEg9N0UoBNA/1EQx
	uFlsXjkjyVIDlcIeU/qKeQRK2h7pVzm7xrRkOM3SwyhnCrqTsWcEIO+lqU/r6aLgD0TMHFAO2T/7e
	icomSvi4J/FfC/H9AsLzHuLPGgYnRjW8UzAFvyvhhDTWCSxo2ZBx5HuSChEs/ue7nRO2x2i02gfA9
	TgYmjqGn6YRTFye5xkyVayxRPMcaycUT9y9KG1/sTD/kTcmIj8SjmpmZU/U9L8ESswg3DRJP5DmB6
	qCdDcnEA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raVjn-0000000FA2A-2NnC;
	Thu, 15 Feb 2024 07:00:51 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Lennart Franzen <lennart@lfdomain.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH] net: ethernet: adi: requires PHYLIB support
Date: Wed, 14 Feb 2024 23:00:50 -0800
Message-ID: <20240215070050.2389-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver uses functions that are supplied by the Kconfig symbol
PHYLIB, so select it to ensure that they are built as needed.

When CONFIG_ADIN1110=y and CONFIG_PHYLIB=m, there are multiple build
(linker) errors that are resolved by this Kconfig change:

   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_open':
   drivers/net/ethernet/adi/adin1110.c:933: undefined reference to `phy_start'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_probe_netdevs':
   drivers/net/ethernet/adi/adin1110.c:1603: undefined reference to `get_phy_device'
   ld: drivers/net/ethernet/adi/adin1110.c:1609: undefined reference to `phy_connect'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
   drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `devm_mdiobus_alloc':
   include/linux/phy.h:455: undefined reference to `devm_mdiobus_alloc_size'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_register_mdiobus':
   drivers/net/ethernet/adi/adin1110.c:529: undefined reference to `__devm_mdiobus_register'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_net_stop':
   drivers/net/ethernet/adi/adin1110.c:958: undefined reference to `phy_stop'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_disconnect_phy':
   drivers/net/ethernet/adi/adin1110.c:1226: undefined reference to `phy_disconnect'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_adjust_link':
   drivers/net/ethernet/adi/adin1110.c:1077: undefined reference to `phy_print_status'
   ld: drivers/net/ethernet/adi/adin1110.o: in function `adin1110_ioctl':
   drivers/net/ethernet/adi/adin1110.c:790: undefined reference to `phy_do_ioctl'
   ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf60): undefined reference to `phy_ethtool_get_link_ksettings'
   ld: drivers/net/ethernet/adi/adin1110.o:(.rodata+0xf68): undefined reference to `phy_ethtool_set_link_ksettings'

Fixes: bc93e19d088b ("net: ethernet: adi: Add ADIN1110 support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402070626.eZsfVHG5-lkp@intel.com/
Cc: Lennart Franzen <lennart@lfdomain.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/adi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
--- a/drivers/net/ethernet/adi/Kconfig
+++ b/drivers/net/ethernet/adi/Kconfig
@@ -7,6 +7,7 @@ config NET_VENDOR_ADI
 	bool "Analog Devices devices"
 	default y
 	depends on SPI
+	select PHYLIB
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 

