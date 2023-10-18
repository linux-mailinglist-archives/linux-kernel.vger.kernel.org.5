Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1B7CD251
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJRCfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJRCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:35:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8AAB;
        Tue, 17 Oct 2023 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697596520; x=1729132520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eW1nR+Vnq/ijVBW0+IDk2j8V33dp2IbrFLegJCuCDx4=;
  b=T9v+pSmawNy3CLXb/+KDSALHRW3hPHCyvUVVDHAb5IiLP9jCdQTy2umf
   WgHotEsVCK3riTu4ZXzI/uMkoOTrIHcvnsYL4Bu26jgURsppb3RuXp8L0
   p/rfK7Tidzebzepi+UaLybo4kagjJ7hfyUsBbZZbX+Dc0q43TgP9LdE9C
   VhP4YXPynvsge2bbkk1gxCX6VYNBDT+tzMTI+Sa2Da545LwF/R91COOCT
   /z7g0xSYyeQhZVfYug2gaa4hdDzRu0WFJp0nX04ejGS5U1k/3Fmlbxoy4
   v+ZyjzhvTFeDOCOnrqBJ3mB4PadlSPZivEXzwhJ40XxeUD5G7cLtK1+w+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450144128"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="450144128"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:35:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4333750"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2023 19:35:17 -0700
From:   "Gan, Yi Fang" <yi.fang.gan@intel.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Gan Yi Fang <yi.fang.gan@intel.com>
Subject: [PATCH net 1/1] net: stmmac: update MAC capabilities when tx queues are updated
Date:   Wed, 18 Oct 2023 10:31:36 +0800
Message-Id: <20231018023137.652132-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>

Upon boot up, the driver will configure the MAC capabilities based on
the maximum number of tx and rx queues. When the user changes the
tx queues to single queue, the MAC should be capable of supporting Half
Duplex, but the driver does not update the MAC capabilities when it is
configured so.

Using the stmmac_reinit_queues() to check the number of tx queues
and set the MAC capabilities accordingly.

Fixes: 0366f7e06a6b ("net: stmmac: add ethtool support for get/set channels")
Cc: <stable@vger.kernel.org> # 5.17+
Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ed1a5a31a491..7ddc33fa0cb5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7172,6 +7172,14 @@ int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
 									rx_cnt);
 
+	/* Half-Duplex can only work with single tx queue */
+	if (priv->plat->tx_queues_to_use > 1)
+		priv->phylink_config.mac_capabilities &=
+			~(MAC_10HD | MAC_100HD | MAC_1000HD);
+	else
+		priv->phylink_config.mac_capabilities |=
+			(MAC_10HD | MAC_100HD | MAC_1000HD);
+
 	stmmac_napi_add(dev);
 
 	if (netif_running(dev))
-- 
2.34.1

