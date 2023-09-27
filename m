Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51D7AF9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjI0E7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjI0E6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:58:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F1935BE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7Y1qKBOuWg5Urwtt4BBusjg4Vo4nFC9PDpW8fuhezGU=; b=mjtDKKDS4uzP228lMPWRAtWwVi
        aZYKtHf0QGZzKlIL7DaQLlNB4MXZlHtWA2hFsyAEj51GAC3OrA8k5zqDUFxKV7GtLzGEGIpWBjoWR
        QfbAU9veCUOc1r0FrLjaPvbab+uCB7LoLZXv+uhqzSvyfHXUf0vuAkxyrFvuYHYJO9IhcvX5u4d5K
        NTju+wwg4TbUssVzAojivZfQLvy7hBVAz3Y6W0uBETe8OdQUnFgG+ZFvlQOegX9IF0MWyE5nSGDF4
        6AHEC3QZXN5oOB8TrgvLUCLw08esNAxRlFV1MHf5sNs9dQCDXkNVTFbJlzjmFrXKdbKPAJ/JRTxaT
        bGjNdwWA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qlM72-00HWP7-12;
        Wed, 27 Sep 2023 04:25:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: lan743x: also select PHYLIB
Date:   Tue, 26 Sep 2023 21:25:23 -0700
Message-ID: <20230927042523.7707-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
a kconfig warning:

WARNING: unmet direct dependencies detected for FIXED_PHY
  Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
  Selected by [y]:
  - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

Fixes: 73c4d1b307ae ("net: lan743x: select FIXED_PHY")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309261802.JPbRHwti-lkp@intel.com
M: Bryan Whitehead <bryan.whitehead@microchip.com>
M: UNGLinuxDriver@microchip.com
M: Simon Horman <horms@kernel.org>
L: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/microchip/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,6 +46,7 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select PHYLIB
 	select FIXED_PHY
 	select CRC16
 	select CRC32
