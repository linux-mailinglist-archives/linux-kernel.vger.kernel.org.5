Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B37C82B7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjJMKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjJMKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:06:23 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCAAAD;
        Fri, 13 Oct 2023 03:06:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DA5vQB089050;
        Fri, 13 Oct 2023 05:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697191558;
        bh=afm5I4zNUAuNxC8GzJdXHOSHi6pcLExp9ZdF1yWwCUQ=;
        h=From:To:CC:Subject:Date;
        b=CQ0eK1bXU7jTJa6ntX1Xpc7aWO/5mUpdmR+zkOVpl4p/fG/CSrsduxclIA1djicVV
         tJEgOFonTX5Ei/QUoSvGVpS4piUk8ETvX+BIqDRMo2Kl7gAZWCX9GzWR7CDIRVbOut
         S4qM3gcaNpb/yamM+dppZ1Ml4aI2zL0ASR3owiG8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DA5v47007810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 05:05:57 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 05:05:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 05:05:57 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DA5vJC124553;
        Fri, 13 Oct 2023 05:05:57 -0500
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 39DA5uUH007169;
        Fri, 13 Oct 2023 05:05:56 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net] net: ethernet: ti: Fix mixed module-builtin object
Date:   Fri, 13 Oct 2023 15:35:49 +0530
Message-ID: <20231013100549.3198564-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Kconfig             | 5 +++++
 drivers/net/ethernet/ti/Makefile            | 7 ++++---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 7 +++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0784a3d0bbff..e60b557d59b9 100644
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
@@ -180,6 +184,7 @@ config TI_ICSSG_PRUETH
 	tristate "TI Gigabit PRU Ethernet driver"
 	select PHYLIB
 	select TI_ICSS_IEP
+	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	help
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index e38ec9d6c99b..27de1d697134 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -23,14 +23,15 @@ keystone_netcp-y := netcp_core.o cpsw_ale.o
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
index 38cc12f9f133..1d9b456edff4 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -39,6 +39,7 @@ void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
 
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 }
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_destroy);
 
 struct k3_cppi_desc_pool *
 k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
@@ -98,29 +99,35 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
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

base-commit: e8c127b0576660da9195504fe8393fe9da3de9ce
-- 
2.34.1

