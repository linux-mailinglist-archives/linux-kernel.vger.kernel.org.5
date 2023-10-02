Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C147B5B6E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbjJBTfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbjJBTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:35:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5BDC;
        Mon,  2 Oct 2023 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WBSG551xTpINGiPaoSlT0YJNNZU7wlH+dq+VeSa6y8s=; b=4WWmj/xvGXz42YVSOaxsoIbPti
        jLqMTFH2Xr05KWwT0WUmaw6aExnzj3aVTbnuDhi9s9PXQRjCx1oCeDl9F2I3SMjJGDHSiTfnxP3Fw
        Ap5HmbgMUS3mVaBgiXC9AEmnAjIkspsJqAzxlv/jQIyvh8doje9fvksZ9IHfQgmTJ6Cx9xFm7YPrP
        kwqSDUx3f7dbQssuP97ZrCn5K0YW3ZlSLhwovJLB/jikgQxA9Fw7BTycsfL8eVJKZnDHm7Pybn81G
        Plij3HFAI7MJgnewCpwsezzc/IYswh9yK9espoI2bj39o0kcxQ7gnEqLSaq1LmfIBakeiwgqeu9pk
        c574okOQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnOhn-00DIVR-1z;
        Mon, 02 Oct 2023 19:35:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2] net: lan743x: also select PHYLIB
Date:   Mon,  2 Oct 2023 12:35:44 -0700
Message-ID: <20231002193544.14529-1-rdunlap@infradead.org>
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
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
v2: Also Cc: netdev and Microchip people;

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
