Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85967CD4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJRGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjJRGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:50:04 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4271B6;
        Tue, 17 Oct 2023 23:50:01 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39I6njFD060234;
        Wed, 18 Oct 2023 01:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697611785;
        bh=XuwC0PcFL5WiYUVyyXex9a7PjC/9hKzhaIgiubdIon8=;
        h=From:To:CC:Subject:Date;
        b=I136FDnmXgszgW4qB1y5kMIPokeRxKNg9xGBuS1pNjf9NLVG9QyRZj+X+w/GQNz3l
         u2zYZPgINcCaLSa0QtLhMuT8xHba9YA3Lnp71/zYh3ZTGl8Q73ic9qBzdICSqUpJWu
         WPzSlDZyI1ppHje28lqgHWNJmPEWR7d+2oEvkXEA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39I6njTX026176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 01:49:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 01:49:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 01:49:45 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39I6njDP003969;
        Wed, 18 Oct 2023 01:49:45 -0500
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39I6nib5016047;
        Wed, 18 Oct 2023 01:49:44 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH net v2] net: ethernet: ti: Fix mixed module-builtin object
Date:   Wed, 18 Oct 2023 12:19:36 +0530
Message-ID: <20231018064936.3146846-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
the expected CFLAGS are different between builtins and modules.

The build system is complaining about the following:

k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
ti-am65-cpsw-nuss

Introduce the new module, k3-cppi-desc-pool, to provide the common
functions to ti-am65-cpsw-nuss and icssg-prueth.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>

Changes from v1 to v2:
*) Rebased on latest net/main
*) Added Fixes tag in commit message.
*) Added MODULE_LICENSE and MODULE_DESCRIPTION in k3-cppi-desc-pool.c

v1: https://lore.kernel.org/all/20231013100549.3198564-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/Kconfig             |  5 +++++
 drivers/net/ethernet/ti/Makefile            |  7 ++++---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 10 ++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0a3346650e03..cac61f5d3fd4 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -90,12 +90,16 @@ config TI_CPTS
 	  The unit can time stamp PTP UDP/IPv4 and Layer 2 packets, and the
 	  driver offers a PTP Hardware Clock.
 
+config TI_K3_CPPI_DESC_POOL
+	tristate
+
 config TI_K3_AM65_CPSW_NUSS
 	tristate "TI K3 AM654x/J721E CPSW Ethernet driver"
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	select NET_DEVLINK
 	select TI_DAVINCI_MDIO
 	select PHYLINK
+	select TI_K3_CPPI_DESC_POOL
 	imply PHY_TI_GMII_SEL
 	depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS
 	help
@@ -187,6 +191,7 @@ config TI_ICSSG_PRUETH
 	tristate "TI Gigabit PRU Ethernet driver"
 	select PHYLIB
 	select TI_ICSS_IEP
+	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	help
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 34fd7a716ba6..67bed861f31d 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -24,14 +24,15 @@ keystone_netcp-y := netcp_core.o cpsw_ale.o
 obj-$(CONFIG_TI_KEYSTONE_NETCP_ETHSS) += keystone_netcp_ethss.o
 keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o cpsw_ale.o
 
+obj-$(CONFIG_TI_K3_CPPI_DESC_POOL) += k3-cppi-desc-pool.o
+
 obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o
-ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o k3-cppi-desc-pool.o am65-cpsw-qos.o
+ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o am65-cpsw-qos.o
 ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o
-icssg-prueth-y := k3-cppi-desc-pool.o \
-		  icssg/icssg_prueth.o \
+icssg-prueth-y := icssg/icssg_prueth.o \
 		  icssg/icssg_classifier.o \
 		  icssg/icssg_queues.o \
 		  icssg/icssg_config.o \
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 38cc12f9f133..05cc7aab1ec8 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -39,6 +39,7 @@ void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
 
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_destroy);
 
 struct k3_cppi_desc_pool *
 k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
@@ -98,29 +99,38 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	devm_kfree(pool->dev, pool);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_create_name);
 
 dma_addr_t k3_cppi_desc_pool_virt2dma(struct k3_cppi_desc_pool *pool,
 				      void *addr)
 {
 	return addr ? pool->dma_addr + (addr - pool->cpumem) : 0;
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_virt2dma);
 
 void *k3_cppi_desc_pool_dma2virt(struct k3_cppi_desc_pool *pool, dma_addr_t dma)
 {
 	return dma ? pool->cpumem + (dma - pool->dma_addr) : NULL;
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_dma2virt);
 
 void *k3_cppi_desc_pool_alloc(struct k3_cppi_desc_pool *pool)
 {
 	return (void *)gen_pool_alloc(pool->gen_pool, pool->desc_size);
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_alloc);
 
 void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr)
 {
 	gen_pool_free(pool->gen_pool, (unsigned long)addr, pool->desc_size);
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_free);
 
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool)
 {
 	return gen_pool_avail(pool->gen_pool) / pool->desc_size;
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_avail);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");

base-commit: f6c7b42243565a4ed8bc9d6f681b6d0cae026abc
-- 
2.34.1

