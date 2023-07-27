Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF4576487F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjG0HYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjG0HXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9861B6;
        Thu, 27 Jul 2023 00:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A9E961D41;
        Thu, 27 Jul 2023 07:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7641C433C7;
        Thu, 27 Jul 2023 07:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442034;
        bh=XuiTwprtskMQMXNuTMgi22ot5tDb/nLzqexenb3tjbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIJkr7uyHoPryppY97ckny6wa5tHekiBie9mXHlA0Mk54b2pApq5mZs/Hjv47tXZl
         7yBDc0Farf5WeEG36SMK7cVZIdUYQgr/3pz2++fJVcTNpLtHzHUIylpROyU1aY6UHS
         XDW3mBjJz86SeW98esOY3HSXphJ2oiQljoObQ00s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.123
Date:   Thu, 27 Jul 2023 09:13:33 +0200
Message-ID: <2023072733-rupture-stood-d070@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072733-driving-bulldog-c9e6@gregkh>
References: <2023072733-driving-bulldog-c9e6@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index cd5ff40948a3..38ef4f11f530 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 122
+SUBLEVEL = 123
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 1e1247add1cf..908e96e3a311 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 980e5ce6a3a3..3ec611dc0c09 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -242,8 +242,8 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 static const struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 1,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 1,
 };
 
 static int regmap_i2c_smbus_i2c_write_reg16(void *context, const void *data,
@@ -299,8 +299,8 @@ static int regmap_i2c_smbus_i2c_read_reg16(void *context, const void *reg,
 static const struct regmap_bus regmap_i2c_smbus_i2c_block_reg16 = {
 	.write = regmap_i2c_smbus_i2c_write_reg16,
 	.read = regmap_i2c_smbus_i2c_read_reg16,
-	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-	.max_raw_write = I2C_SMBUS_BLOCK_MAX,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 2,
+	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 2,
 };
 
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index 67f89937219c..ad1da83e849f 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -666,7 +666,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 05410c69a3da..f7811641ed5a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2041,8 +2041,6 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	size_t val_count = val_len / val_bytes;
 	size_t chunk_count, chunk_bytes;
 	size_t chunk_regs = val_count;
-	size_t max_data = map->max_raw_write - map->format.reg_bytes -
-			map->format.pad_bytes;
 	int ret, i;
 
 	if (!val_count)
@@ -2050,8 +2048,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 
 	if (map->use_single_write)
 		chunk_regs = 1;
-	else if (map->max_raw_write && val_len > max_data)
-		chunk_regs = max_data / val_bytes;
+	else if (map->max_raw_write && val_len > map->max_raw_write)
+		chunk_regs = map->max_raw_write / val_bytes;
 
 	chunk_count = val_count / chunk_regs;
 	chunk_bytes = chunk_regs * val_bytes;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 79ac19948e7a..7bd38d927b18 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8209,13 +8209,7 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		/* most eDP supports only timings from its edid,
-		 * usually only detailed timings are available
-		 * from eDP edid. timings which are not from edid
-		 * may damage eDP
-		 */
-		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
-			amdgpu_dm_connector_add_common_modes(encoder, connector);
+		amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 8f6e6496ea78..5357620627af 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -81,6 +81,11 @@ int dcn31_get_active_display_cnt_wa(
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
 				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
 			tmds_present = true;
+
+		/* Checking stream / link detection ensuring that PHY is active*/
+		if (dc_is_dp_signal(stream->signal) && !stream->dpms_off)
+			display_count++;
+
 	}
 
 	for (i = 0; i < dc->link_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 67d83417ec33..9d9b0d343c6b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -193,7 +193,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index ced09c7c06f9..447ea279e691 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -309,6 +309,9 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 	can_clone = true;
 	dmt_mode = drm_mode_find_dmt(dev, 1024, 768, 60, false);
 
+	if (!dmt_mode)
+		goto fail;
+
 	for (i = 0; i < connector_count; i++) {
 		if (!enabled[i])
 			continue;
@@ -324,11 +327,13 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 		if (!modes[i])
 			can_clone = false;
 	}
+	kfree(dmt_mode);
 
 	if (can_clone) {
 		DRM_DEBUG_KMS("can clone using 1024x768\n");
 		return true;
 	}
+fail:
 	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
 	return false;
 }
@@ -860,6 +865,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 				break;
 			}
 
+			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 9ed2b2700e0a..e5fbe851ed93 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -270,7 +270,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *p, void *data)
 {
 	struct drm_radeon_cs *cs = data;
 	uint64_t *chunk_array_ptr;
-	unsigned size, i;
+	u64 size;
+	unsigned i;
 	u32 ring = RADEON_CS_RING_GFX;
 	s32 priority = 0;
 
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 920633161174..f4edc616388c 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -3863,7 +3863,7 @@ static int et131x_change_mtu(struct net_device *netdev, int new_mtu)
 
 	et131x_init_send(adapter);
 	et131x_hwaddr_init(adapter);
-	ether_addr_copy(netdev->dev_addr, adapter->addr);
+	eth_hw_addr_set(netdev, adapter->addr);
 
 	/* Init the device with the new settings */
 	et131x_adapter_setup(adapter);
@@ -3966,7 +3966,7 @@ static int et131x_pci_setup(struct pci_dev *pdev,
 
 	netif_napi_add(netdev, &adapter->napi, et131x_poll, 64);
 
-	ether_addr_copy(netdev->dev_addr, adapter->addr);
+	eth_hw_addr_set(netdev, adapter->addr);
 
 	rc = -ENOMEM;
 
diff --git a/drivers/net/ethernet/alacritech/slicoss.c b/drivers/net/ethernet/alacritech/slicoss.c
index 696517eae77f..82f4f2608102 100644
--- a/drivers/net/ethernet/alacritech/slicoss.c
+++ b/drivers/net/ethernet/alacritech/slicoss.c
@@ -1660,7 +1660,7 @@ static int slic_read_eeprom(struct slic_device *sdev)
 		goto free_eeprom;
 	}
 	/* set mac address */
-	ether_addr_copy(sdev->netdev->dev_addr, mac[devfn]);
+	eth_hw_addr_set(sdev->netdev, mac[devfn]);
 free_eeprom:
 	dma_free_coherent(&sdev->pdev->dev, SLIC_EEPROM_SIZE, eeprom, paddr);
 
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 037baea1c738..ef218a6d477c 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -852,7 +852,7 @@ static int emac_probe(struct platform_device *pdev)
 	}
 
 	/* Read MAC-address from DT */
-	ret = of_get_mac_address(np, ndev->dev_addr);
+	ret = of_get_ethdev_address(np, ndev);
 	if (ret) {
 		/* if the MAC address is invalid get a random one */
 		eth_hw_addr_random(ndev);
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index b51f5b9577e0..9e721436f06f 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1531,7 +1531,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 	priv->rx_dma_buf_sz = ALTERA_RXDMABUFFER_SIZE;
 
 	/* get default MAC address from device tree */
-	ret = of_get_mac_address(pdev->dev.of_node, ndev->dev_addr);
+	ret = of_get_ethdev_address(pdev->dev.of_node, ndev);
 	if (ret)
 		eth_hw_addr_random(ndev);
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 23c9750850e9..f3673be4fc08 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4119,7 +4119,7 @@ static void ena_set_conf_feat_params(struct ena_adapter *adapter,
 		ether_addr_copy(adapter->mac_addr, netdev->dev_addr);
 	} else {
 		ether_addr_copy(adapter->mac_addr, feat->dev_attr.mac_addr);
-		ether_addr_copy(netdev->dev_addr, adapter->mac_addr);
+		eth_hw_addr_set(netdev, adapter->mac_addr);
 	}
 
 	/* Set offload features */
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index ea2e7cd8946d..c52093589d7c 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -330,7 +330,7 @@ int aq_nic_ndev_register(struct aq_nic_s *self)
 	{
 		static u8 mac_addr_permanent[] = AQ_CFG_MAC_ADDR_PERMANENT;
 
-		ether_addr_copy(self->ndev->dev_addr, mac_addr_permanent);
+		eth_hw_addr_set(self->ndev, mac_addr_permanent);
 	}
 #endif
 
diff --git a/drivers/net/ethernet/arc/emac_main.c b/drivers/net/ethernet/arc/emac_main.c
index 38c288ec9059..333333692caa 100644
--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -941,7 +941,7 @@ int arc_emac_probe(struct net_device *ndev, int interface)
 	}
 
 	/* Get MAC address from device tree */
-	err = of_get_mac_address(dev->of_node, ndev->dev_addr);
+	err = of_get_ethdev_address(dev->of_node, ndev);
 	if (err)
 		eth_hw_addr_random(ndev);
 
diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 7295244b78d0..9d8b214c129d 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1964,7 +1964,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ag->stop_desc->ctrl = 0;
 	ag->stop_desc->next = (u32)ag->stop_desc_dma;
 
-	err = of_get_mac_address(np, ndev->dev_addr);
+	err = of_get_ethdev_address(np, ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "invalid MAC address, using random address\n");
 		eth_random_addr(ndev->dev_addr);
diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 7e89664943ce..ba48ddff5e7c 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -719,7 +719,7 @@ static int bcm4908_enet_probe(struct platform_device *pdev)
 		return err;
 
 	SET_NETDEV_DEV(netdev, &pdev->dev);
-	err = of_get_mac_address(dev->of_node, netdev->dev_addr);
+	err = of_get_ethdev_address(dev->of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);
 	netdev->netdev_ops = &bcm4908_enet_netdev_ops;
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4c7f828c69c6..25466d73b432 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2561,7 +2561,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize netdevice members */
-	ret = of_get_mac_address(dn, dev->dev_addr);
+	ret = of_get_ethdev_address(dn, dev);
 	if (ret) {
 		dev_warn(&pdev->dev, "using random Ethernet MAC\n");
 		eth_hw_addr_random(dev);
diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
index 92453e68d381..678cc6a3617c 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -128,7 +128,7 @@ static int bgmac_probe(struct bcma_device *core)
 
 	bcma_set_drvdata(core, bgmac);
 
-	err = of_get_mac_address(bgmac->dev->of_node, bgmac->net_dev->dev_addr);
+	err = of_get_ethdev_address(bgmac->dev->of_node, bgmac->net_dev);
 	if (err == -EPROBE_DEFER)
 		return err;
 
@@ -150,7 +150,7 @@ static int bgmac_probe(struct bcma_device *core)
 			err = -ENOTSUPP;
 			goto err;
 		}
-		ether_addr_copy(bgmac->net_dev->dev_addr, mac);
+		eth_hw_addr_set(bgmac->net_dev, mac);
 	}
 
 	/* On BCM4706 we need common core to access PHY */
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 94eb3a42158e..b4381cd41979 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -192,7 +192,7 @@ static int bgmac_probe(struct platform_device *pdev)
 	bgmac->dev = &pdev->dev;
 	bgmac->dma_dev = &pdev->dev;
 
-	ret = of_get_mac_address(np, bgmac->net_dev->dev_addr);
+	ret = of_get_ethdev_address(np, bgmac->net_dev);
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 54ff28c9b214..a9c99ac81730 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1241,7 +1241,7 @@ static int bgmac_set_mac_address(struct net_device *net_dev, void *addr)
 	if (ret < 0)
 		return ret;
 
-	ether_addr_copy(net_dev->dev_addr, sa->sa_data);
+	eth_hw_addr_set(net_dev, sa->sa_data);
 	bgmac_write_mac_address(bgmac, net_dev->dev_addr);
 
 	eth_commit_mac_addr_change(net_dev, addr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 9401936b74fa..8eb28e088582 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -475,7 +475,7 @@ static void bnxt_vf_rep_netdev_init(struct bnxt *bp, struct bnxt_vf_rep *vf_rep,
 	dev->features |= pf_dev->features;
 	bnxt_vf_rep_eth_addr_gen(bp->pf.mac_addr, vf_rep->vf_idx,
 				 dev->perm_addr);
-	ether_addr_copy(dev->dev_addr, dev->perm_addr);
+	eth_hw_addr_set(dev, dev->perm_addr);
 	/* Set VF-Rep's max-mtu to the corresponding VF's max-mtu */
 	if (!bnxt_hwrm_vfr_qcfg(bp, vf_rep, &max_mtu))
 		dev->max_mtu = max_mtu;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 9d4f406408c9..e036a244b78b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3610,7 +3610,7 @@ static int bcmgenet_set_mac_addr(struct net_device *dev, void *p)
 	if (netif_running(dev))
 		return -EBUSY;
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
@@ -4060,7 +4060,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
 
 	if (pd && !IS_ERR_OR_NULL(pd->mac_address))
-		ether_addr_copy(dev->dev_addr, pd->mac_address);
+		eth_hw_addr_set(dev, pd->mac_address);
 	else
 		if (!device_get_mac_address(&pdev->dev, dev->dev_addr, ETH_ALEN))
 			if (has_acpi_companion(&pdev->dev))
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ba47777d9cff..b1947fd9a07c 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -875,7 +875,7 @@ bnad_set_netdev_perm_addr(struct bnad *bnad)
 
 	ether_addr_copy(netdev->perm_addr, bnad->perm_addr);
 	if (is_zero_ether_addr(netdev->dev_addr))
-		ether_addr_copy(netdev->dev_addr, bnad->perm_addr);
+		eth_hw_addr_set(netdev, bnad->perm_addr);
 }
 
 /* Control Path Handlers */
@@ -3249,7 +3249,7 @@ bnad_set_mac_address(struct net_device *netdev, void *addr)
 
 	err = bnad_mac_addr_set_locked(bnad, sa->sa_data);
 	if (!err)
-		ether_addr_copy(netdev->dev_addr, sa->sa_data);
+		eth_hw_addr_set(netdev, sa->sa_data);
 
 	spin_unlock_irqrestore(&bnad->bna_lock, flags);
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ddadb1822d89..dac56169851a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4835,7 +4835,7 @@ static int macb_probe(struct platform_device *pdev)
 	if (bp->caps & MACB_CAPS_NEEDS_RSTONUBR)
 		bp->rx_intr_mask |= MACB_BIT(RXUBR);
 
-	err = of_get_mac_address(np, bp->dev->dev_addr);
+	err = of_get_ethdev_address(np, bp->dev);
 	if (err == -EPROBE_DEFER)
 		goto err_out_free_netdev;
 	else if (err)
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 2a0d64e5797c..ec7928b54e4a 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -411,7 +411,7 @@ void octeon_pf_changed_vf_macaddr(struct octeon_device *oct, u8 *mac)
 
 	if (!ether_addr_equal(netdev->dev_addr, mac)) {
 		macaddr_changed = true;
-		ether_addr_copy(netdev->dev_addr, mac);
+		eth_hw_addr_set(netdev, mac);
 		ether_addr_copy(((u8 *)&lio->linfo.hw_addr) + 2, mac);
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, netdev);
 	}
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index ae68821dd56d..443755729d79 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3650,7 +3650,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 
 		/* Copy MAC Address to OS network device structure */
 
-		ether_addr_copy(netdev->dev_addr, mac);
+		eth_hw_addr_set(netdev, mac);
 
 		/* By default all interfaces on a single Octeon uses the same
 		 * tx and rx queues
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index f6396ac64006..8a969a9d4b63 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -2148,7 +2148,7 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 			mac[j] = *((u8 *)(((u8 *)&lio->linfo.hw_addr) + 2 + j));
 
 		/* Copy MAC Address to OS network device structure */
-		ether_addr_copy(netdev->dev_addr, mac);
+		eth_hw_addr_set(netdev, mac);
 
 		if (liquidio_setup_io_queues(octeon_dev, i,
 					     lio->linfo.num_txpciq,
diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index 30463a6d1f8c..4e39d712e121 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1501,7 +1501,7 @@ static int octeon_mgmt_probe(struct platform_device *pdev)
 	netdev->min_mtu = 64 - OCTEON_MGMT_RX_HEADROOM;
 	netdev->max_mtu = 16383 - OCTEON_MGMT_RX_HEADROOM - VLAN_HLEN;
 
-	result = of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
+	result = of_get_ethdev_address(pdev->dev.of_node, netdev);
 	if (result)
 		eth_hw_addr_random(netdev);
 
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index b43b97e15a6f..8418797be205 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -221,8 +221,7 @@ static void  nicvf_handle_mbx_intr(struct nicvf *nic)
 		nic->tns_mode = mbx.nic_cfg.tns_mode & 0x7F;
 		nic->node = mbx.nic_cfg.node_id;
 		if (!nic->set_mac_pending)
-			ether_addr_copy(nic->netdev->dev_addr,
-					mbx.nic_cfg.mac_addr);
+			eth_hw_addr_set(nic->netdev, mbx.nic_cfg.mac_addr);
 		nic->sqs_mode = mbx.nic_cfg.sqs_mode;
 		nic->loopback_supported = mbx.nic_cfg.loopback_supported;
 		nic->link_up = false;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index e874b907bfbd..3ccb955eb6f2 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -369,7 +369,7 @@ static int be_mac_addr_set(struct net_device *netdev, void *p)
 	/* Remember currently programmed MAC */
 	ether_addr_copy(adapter->dev_mac, addr->sa_data);
 done:
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->sa_data);
 	dev_info(dev, "MAC address changed to %pM\n", addr->sa_data);
 	return 0;
 err:
diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index ed1ed48e7483..7f456297fc45 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1148,10 +1148,10 @@ static int ethoc_probe(struct platform_device *pdev)
 
 	/* Allow the platform setup code to pass in a MAC address. */
 	if (pdata) {
-		ether_addr_copy(netdev->dev_addr, pdata->hwaddr);
+		eth_hw_addr_set(netdev, pdata->hwaddr);
 		priv->phy_id = pdata->phy_id;
 	} else {
-		of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
+		of_get_ethdev_address(pdev->dev.of_node, netdev);
 		priv->phy_id = -1;
 	}
 
diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index f9a288a6ec8c..323340826dab 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -421,7 +421,7 @@ static s32 nps_enet_set_mac_address(struct net_device *ndev, void *p)
 
 	res = eth_mac_addr(ndev, p);
 	if (!res) {
-		ether_addr_copy(ndev->dev_addr, addr->sa_data);
+		eth_hw_addr_set(ndev, addr->sa_data);
 		nps_enet_set_hw_mac_address(ndev);
 	}
 
@@ -601,7 +601,7 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Registers base address is 0x%p\n", priv->regs_base);
 
 	/* set kernel MAC address to dev */
-	err = of_get_mac_address(dev->of_node, ndev->dev_addr);
+	err = of_get_ethdev_address(dev->of_node, ndev);
 	if (err)
 		eth_hw_addr_random(ndev);
 
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 4a2dadb91f02..11f76e56d031 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -186,7 +186,7 @@ static void ftgmac100_initial_mac(struct ftgmac100 *priv)
 
 	addr = device_get_mac_address(priv->dev, mac, ETH_ALEN);
 	if (addr) {
-		ether_addr_copy(priv->netdev->dev_addr, mac);
+		eth_hw_addr_set(priv->netdev, mac);
 		dev_info(priv->dev, "Read MAC address %pM from device tree\n",
 			 mac);
 		return;
@@ -203,7 +203,7 @@ static void ftgmac100_initial_mac(struct ftgmac100 *priv)
 	mac[5] = l & 0xff;
 
 	if (is_valid_ether_addr(mac)) {
-		ether_addr_copy(priv->netdev->dev_addr, mac);
+		eth_hw_addr_set(priv->netdev, mac);
 		dev_info(priv->dev, "Read MAC address %pM from chip\n", mac);
 	} else {
 		eth_hw_addr_random(priv->netdev);
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index 73ff359a15f1..2777dd2b4dd7 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -890,7 +890,7 @@ static int mpc52xx_fec_probe(struct platform_device *op)
 	 *
 	 * First try to read MAC address from DT
 	 */
-	rv = of_get_mac_address(np, ndev->dev_addr);
+	rv = of_get_ethdev_address(np, ndev);
 	if (rv) {
 		struct mpc52xx_fec __iomem *fec = priv->fec;
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 2db6e38a772e..bacf25318f87 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1005,7 +1005,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
 	spin_lock_init(&fep->lock);
 	spin_lock_init(&fep->tx_lock);
 
-	of_get_mac_address(ofdev->dev.of_node, ndev->dev_addr);
+	of_get_ethdev_address(ofdev->dev.of_node, ndev);
 
 	ret = fep->ops->allocate_bd(ndev);
 	if (ret)
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index af6ad94bf24a..acab58fd3db3 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -753,7 +753,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 	if (stash_len || stash_idx)
 		priv->device_flags |= FSL_GIANFAR_DEV_HAS_BUF_STASHING;
 
-	err = of_get_mac_address(np, dev->dev_addr);
+	err = of_get_ethdev_address(np, dev);
 	if (err) {
 		eth_hw_addr_random(dev);
 		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 3eb288d10b0c..e0036fd2b56c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3731,7 +3731,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 		goto err_free_netdev;
 	}
 
-	of_get_mac_address(np, dev->dev_addr);
+	of_get_ethdev_address(np, dev);
 
 	ugeth->ug_info = ug_info;
 	ugeth->dev = device;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index ce507464f3d6..54d649e5ee65 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -733,7 +733,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	}
 	priv->dev->max_mtu = mtu;
 	priv->num_event_counters = be16_to_cpu(descriptor->counters);
-	ether_addr_copy(priv->dev->dev_addr, descriptor->mac);
+	eth_hw_addr_set(priv->dev, descriptor->mac);
 	mac = descriptor->mac;
 	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", mac);
 	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index ea3e67cf5ffa..05cb4582a58d 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -841,7 +841,7 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 			   (unsigned long)phy->phy_id,
 			   phy_modes(phy->interface));
 
-	ret = of_get_mac_address(node, ndev->dev_addr);
+	ret = of_get_ethdev_address(node, ndev);
 	if (ret) {
 		eth_hw_addr_random(ndev);
 		dev_warn(dev, "using random MAC address %pM\n",
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 0a70fb979f0c..923191b9a87d 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1219,7 +1219,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 		goto out_phy_node;
 	}
 
-	ret = of_get_mac_address(node, ndev->dev_addr);
+	ret = of_get_ethdev_address(node, ndev);
 	if (ret) {
 		eth_hw_addr_random(ndev);
 		netdev_warn(ndev, "using random MAC address %pM\n",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index dc835f316d47..2acf50ed6025 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2251,7 +2251,7 @@ static int hns3_nic_net_set_mac_address(struct net_device *netdev, void *p)
 		return ret;
 	}
 
-	ether_addr_copy(netdev->dev_addr, mac_addr->sa_data);
+	eth_hw_addr_set(netdev, mac_addr->sa_data);
 
 	return 0;
 }
@@ -4921,7 +4921,7 @@ static int hns3_init_mac_addr(struct net_device *netdev)
 		dev_warn(priv->dev, "using random MAC address %s\n",
 			 format_mac_addr);
 	} else if (!ether_addr_equal(netdev->dev_addr, mac_addr_temp)) {
-		ether_addr_copy(netdev->dev_addr, mac_addr_temp);
+		eth_hw_addr_set(netdev, mac_addr_temp);
 		ether_addr_copy(netdev->perm_addr, mac_addr_temp);
 	} else {
 		return 0;
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3d9b4f99d357..77d8db9b8a1d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1620,7 +1620,7 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
 		return rc;
 	}
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 765dee2e4882..450b4fd9aa7f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4689,8 +4689,7 @@ static int handle_change_mac_rsp(union ibmvnic_crq *crq,
 	/* crq->change_mac_addr.mac_addr is the requested one
 	 * crq->change_mac_addr_rsp.mac_addr is the returned valid one.
 	 */
-	ether_addr_copy(netdev->dev_addr,
-			&crq->change_mac_addr_rsp.mac_addr[0]);
+	eth_hw_addr_set(netdev, &crq->change_mac_addr_rsp.mac_addr[0]);
 	ether_addr_copy(adapter->mac_addr,
 			&crq->change_mac_addr_rsp.mac_addr[0]);
 out:
@@ -5658,7 +5657,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	adapter->login_pending = false;
 
 	ether_addr_copy(adapter->mac_addr, mac_addr_p);
-	ether_addr_copy(netdev->dev_addr, adapter->mac_addr);
+	eth_hw_addr_set(netdev, adapter->mac_addr);
 	netdev->irq = dev->irq;
 	netdev->netdev_ops = &ibmvnic_netdev_ops;
 	netdev->ethtool_ops = &ibmvnic_ethtool_ops;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2fb52bd6fc0e..2cca9e84e31e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -990,7 +990,7 @@ static int fm10k_set_mac(struct net_device *dev, void *p)
 	}
 
 	if (!err) {
-		ether_addr_copy(dev->dev_addr, addr->sa_data);
+		eth_hw_addr_set(dev, addr->sa_data);
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
 		dev->addr_assign_type &= ~NET_ADDR_RANDOM;
 	}
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index adfa2768f024..b473cb7d7c57 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -300,7 +300,7 @@ static int fm10k_handle_reset(struct fm10k_intfc *interface)
 		if (is_valid_ether_addr(hw->mac.perm_addr)) {
 			ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
 			ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
-			ether_addr_copy(netdev->dev_addr, hw->mac.perm_addr);
+			eth_hw_addr_set(netdev, hw->mac.perm_addr);
 			netdev->addr_assign_type &= ~NET_ADDR_RANDOM;
 		}
 
@@ -2045,7 +2045,7 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		netdev->addr_assign_type |= NET_ADDR_RANDOM;
 	}
 
-	ether_addr_copy(netdev->dev_addr, hw->mac.addr);
+	eth_hw_addr_set(netdev, hw->mac.addr);
 	ether_addr_copy(netdev->perm_addr, hw->mac.addr);
 
 	if (!is_valid_ether_addr(netdev->perm_addr)) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8411f277d135..d3f3874220a3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1686,7 +1686,7 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 	 */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	i40e_del_mac_filter(vsi, netdev->dev_addr);
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->sa_data);
 	i40e_add_mac_filter(vsi, netdev->dev_addr);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
@@ -13659,7 +13659,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	i40e_add_mac_filter(vsi, broadcast);
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-	ether_addr_copy(netdev->dev_addr, mac_addr);
+	eth_hw_addr_set(netdev, mac_addr);
 	ether_addr_copy(netdev->perm_addr, mac_addr);
 
 	/* i40iw_net_event() reads 16 bytes from neigh->primary_key */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 461f5237a2f8..5af3ae68b7a1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1855,7 +1855,7 @@ static int iavf_set_channels(struct net_device *netdev,
 	}
 	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
 		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_active_queues = num_req;
+		adapter->num_req_queues = 0;
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a3caab0b6fa2..bcceb2ddfea6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1507,19 +1507,16 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 {
 	int q_idx, num_q_vectors;
-	int napi_vectors;
 
 	if (!adapter->q_vectors)
 		return;
 
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
-	napi_vectors = adapter->num_active_queues;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		struct iavf_q_vector *q_vector = &adapter->q_vectors[q_idx];
 
-		if (q_idx < napi_vectors)
-			netif_napi_del(&q_vector->napi);
+		netif_napi_del(&q_vector->napi);
 	}
 	kfree(adapter->q_vectors);
 	adapter->q_vectors = NULL;
@@ -1963,7 +1960,7 @@ static void iavf_init_get_resources(struct iavf_adapter *adapter)
 		eth_hw_addr_random(netdev);
 		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 	} else {
-		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+		eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index c6eb0d0748ea..262482c69458 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1726,7 +1726,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		if (!v_retval)
 			iavf_mac_add_ok(adapter);
 		if (!ether_addr_equal(netdev->dev_addr, adapter->hw.mac.addr))
-			ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 		break;
 	case VIRTCHNL_OP_GET_STATS: {
 		struct iavf_eth_stats *stats =
@@ -1757,7 +1757,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 		} else {
 			/* refresh current mac address if changed */
-			ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+			eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 			ether_addr_copy(netdev->perm_addr,
 					adapter->hw.mac.addr);
 		}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index bf9fe385274e..a18fa054b4fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3183,7 +3183,7 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	if (vsi->type == ICE_VSI_PF) {
 		SET_NETDEV_DEV(netdev, ice_pf_to_dev(vsi->back));
 		ether_addr_copy(mac_addr, vsi->port_info->mac.perm_addr);
-		ether_addr_copy(netdev->dev_addr, mac_addr);
+		eth_hw_addr_set(netdev, mac_addr);
 		ether_addr_copy(netdev->perm_addr, mac_addr);
 	}
 
@@ -5225,7 +5225,7 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
 		netdev_err(netdev, "can't set MAC %pM. filter update failed\n",
 			   mac);
 		netif_addr_lock_bh(netdev);
-		ether_addr_copy(netdev->dev_addr, old_mac);
+		eth_hw_addr_set(netdev, old_mac);
 		netif_addr_unlock_bh(netdev);
 		return err;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index db48979cdecb..bcc1c428b4cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2748,15 +2748,15 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
 
 	__netif_tx_lock(nq, cpu);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 0e7ff15af968..3a05e458ded2 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -2541,7 +2541,7 @@ void ixgbevf_reset(struct ixgbevf_adapter *adapter)
 	}
 
 	if (is_valid_ether_addr(adapter->hw.mac.addr)) {
-		ether_addr_copy(netdev->dev_addr, adapter->hw.mac.addr);
+		eth_hw_addr_set(netdev, adapter->hw.mac.addr);
 		ether_addr_copy(netdev->perm_addr, adapter->hw.mac.addr);
 	}
 
@@ -3055,7 +3055,7 @@ static int ixgbevf_sw_init(struct ixgbevf_adapter *adapter)
 		else if (is_zero_ether_addr(adapter->hw.mac.addr))
 			dev_info(&pdev->dev,
 				 "MAC address not assigned by administrator.\n");
-		ether_addr_copy(netdev->dev_addr, hw->mac.addr);
+		eth_hw_addr_set(netdev, hw->mac.addr);
 	}
 
 	if (!is_valid_ether_addr(netdev->dev_addr)) {
@@ -4232,7 +4232,7 @@ static int ixgbevf_set_mac(struct net_device *netdev, void *p)
 
 	ether_addr_copy(hw->mac.addr, addr->sa_data);
 	ether_addr_copy(hw->mac.perm_addr, addr->sa_data);
-	ether_addr_copy(netdev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(netdev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 3e9f324f1061..df9a8eefa007 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1297,8 +1297,8 @@ static int korina_probe(struct platform_device *pdev)
 	lp = netdev_priv(dev);
 
 	if (mac_addr)
-		ether_addr_copy(dev->dev_addr, mac_addr);
-	else if (of_get_mac_address(pdev->dev.of_node, dev->dev_addr) < 0)
+		eth_hw_addr_set(dev, mac_addr);
+	else if (of_get_ethdev_address(pdev->dev.of_node, dev) < 0)
 		eth_hw_addr_random(dev);
 
 	clk = devm_clk_get_optional(&pdev->dev, "mdioclk");
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index b02f796b5422..fa0ef1852fb7 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -474,7 +474,7 @@ static int xrx200_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
-	err = of_get_mac_address(np, net_dev->dev_addr);
+	err = of_get_ethdev_address(np, net_dev);
 	if (err)
 		eth_hw_addr_random(net_dev);
 
diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 5bb1cc8a2ce1..24ed6e180c75 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -266,7 +266,7 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->tx_base = buf_base + priv->num_rx_slots * priv->slot_size;
 	priv->tx_slot = 0;
 
-	err = of_get_mac_address(pdev->dev.of_node, netdev->dev_addr);
+	err = of_get_ethdev_address(pdev->dev.of_node, netdev);
 	if (err)
 		eth_hw_addr_random(netdev);
 
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f5b5ae58c269..5fa81322a44b 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5242,7 +5242,7 @@ static int mvneta_probe(struct platform_device *pdev)
 		goto err_free_ports;
 	}
 
-	err = of_get_mac_address(dn, dev->dev_addr);
+	err = of_get_ethdev_address(dn, dev);
 	if (!err) {
 		mac_from = "device tree";
 	} else {
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 524913c28f3b..ddd4ed34b0f2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6087,7 +6087,7 @@ static void mvpp2_port_copy_mac_addr(struct net_device *dev, struct mvpp2 *priv,
 
 	if (fwnode_get_mac_address(fwnode, fw_mac_addr, ETH_ALEN)) {
 		*mac_from = "firmware node";
-		ether_addr_copy(dev->dev_addr, fw_mac_addr);
+		eth_hw_addr_set(dev, fw_mac_addr);
 		return;
 	}
 
@@ -6095,7 +6095,7 @@ static void mvpp2_port_copy_mac_addr(struct net_device *dev, struct mvpp2 *priv,
 		mvpp21_get_mac_address(port, hw_mac_addr);
 		if (is_valid_ether_addr(hw_mac_addr)) {
 			*mac_from = "hardware";
-			ether_addr_copy(dev->dev_addr, hw_mac_addr);
+			eth_hw_addr_set(dev, hw_mac_addr);
 			return;
 		}
 	}
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index a8188b972ccb..9af22f497a40 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -2333,7 +2333,7 @@ int mvpp2_prs_update_mac_da(struct net_device *dev, const u8 *da)
 		return err;
 
 	/* Set addr in the device */
-	ether_addr_copy(dev->dev_addr, da);
+	eth_hw_addr_set(dev, da);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2e225309de9c..b743646993ca 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -188,7 +188,7 @@ static int otx2_hw_get_mac_addr(struct otx2_nic *pfvf,
 		return PTR_ERR(msghdr);
 	}
 	rsp = (struct nix_get_mac_addr_rsp *)msghdr;
-	ether_addr_copy(netdev->dev_addr, rsp->mac_addr);
+	eth_hw_addr_set(netdev, rsp->mac_addr);
 	mutex_unlock(&pfvf->mbox.lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a987ae9d6a28..8fc4ecc4f714 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1430,8 +1430,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (err)
 		goto err_free_npa_lf;
 
-	/* Enable backpressure */
-	otx2_nix_config_bp(pf, true);
+	/* Enable backpressure for CGX mapped PF/VFs */
+	if (!is_otx2_lbkvf(pf->pdev))
+		otx2_nix_config_bp(pf, true);
 
 	/* Init Auras and pools used by NIX RQ, for free buffer ptrs */
 	err = otx2_rq_aura_pool_init(pf);
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 656c68cfd7ec..912759ea6ec5 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -141,7 +141,7 @@ static int prestera_port_set_mac_address(struct net_device *dev, void *p)
 	if (err)
 		return err;
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index fab53c9b8380..8ebd13f089db 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1434,7 +1434,7 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 
 	INIT_WORK(&pep->tx_timeout_task, pxa168_eth_tx_timeout_task);
 
-	err = of_get_mac_address(pdev->dev.of_node, dev->dev_addr);
+	err = of_get_ethdev_address(pdev->dev.of_node, dev);
 	if (err) {
 		/* try reading the mac address, if set by the bootloader */
 		pxa168_eth_get_mac_address(dev, dev->dev_addr);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index e9fc74e54b22..ac0dbf1b9743 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4802,7 +4802,7 @@ static struct net_device *sky2_init_netdev(struct sky2_hw *hw, unsigned port,
 	 * 1) from device tree data
 	 * 2) from internal registers set by bootloader
 	 */
-	ret = of_get_mac_address(hw->pdev->dev.of_node, dev->dev_addr);
+	ret = of_get_ethdev_address(hw->pdev->dev.of_node, dev);
 	if (ret)
 		memcpy_fromio(dev->dev_addr, hw->regs + B2_MAC_1 + port * 8,
 			      ETH_ALEN);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index bb1acdb0c62b..50ee9d3d4c84 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2612,23 +2612,6 @@ static int mtk_hw_deinit(struct mtk_eth *eth)
 	return 0;
 }
 
-static int __init mtk_init(struct net_device *dev)
-{
-	struct mtk_mac *mac = netdev_priv(dev);
-	struct mtk_eth *eth = mac->hw;
-	int ret;
-
-	ret = of_get_mac_address(mac->of_node, dev->dev_addr);
-	if (ret) {
-		/* If the mac address is invalid, use random mac address */
-		eth_hw_addr_random(dev);
-		dev_err(eth->dev, "generated random MAC address %pM\n",
-			dev->dev_addr);
-	}
-
-	return 0;
-}
-
 static void mtk_uninit(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -2956,7 +2939,6 @@ static const struct ethtool_ops mtk_ethtool_ops = {
 };
 
 static const struct net_device_ops mtk_netdev_ops = {
-	.ndo_init		= mtk_init,
 	.ndo_uninit		= mtk_uninit,
 	.ndo_open		= mtk_open,
 	.ndo_stop		= mtk_stop,
@@ -3010,6 +2992,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	mac->hw = eth;
 	mac->of_node = np;
 
+	err = of_get_ethdev_address(mac->of_node, eth->netdev[id]);
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	if (err) {
+		/* If the mac address is invalid, use random mac address */
+		eth_hw_addr_random(eth->netdev[id]);
+		dev_err(eth->dev, "generated random MAC address %pM\n",
+			eth->netdev[id]->dev_addr);
+	}
+
 	memset(mac->hwlro_ip, 0, sizeof(mac->hwlro_ip));
 	mac->hwlro_ip_cnt = 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 82849bed27f4..fdc4a5a80da4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3224,7 +3224,7 @@ static int mlx5e_set_mac(struct net_device *netdev, void *addr)
 		return -EADDRNOTAVAIL;
 
 	netif_addr_lock_bh(netdev);
-	ether_addr_copy(netdev->dev_addr, saddr->sa_data);
+	eth_hw_addr_set(netdev, saddr->sa_data);
 	netif_addr_unlock_bh(netdev);
 
 	mlx5e_nic_set_rx_mode(priv);
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 6704f5c1aa32..b990782c1eb1 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -75,7 +75,7 @@ static void mlxbf_gige_initial_mac(struct mlxbf_gige *priv)
 	u64_to_ether_addr(local_mac, mac);
 
 	if (is_valid_ether_addr(mac)) {
-		ether_addr_copy(priv->netdev->dev_addr, mac);
+		eth_hw_addr_set(priv->netdev, mac);
 	} else {
 		/* Provide a random MAC if for some reason the device has
 		 * not been configured with a valid MAC address already.
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index a6db1a8156e1..2c80dba2606c 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -195,7 +195,7 @@ static void ks8851_init_mac(struct ks8851_net *ks, struct device_node *np)
 	struct net_device *dev = ks->netdev;
 	int ret;
 
-	ret = of_get_mac_address(np, dev->dev_addr);
+	ret = of_get_ethdev_address(np, dev);
 	if (!ret) {
 		ks8851_write_mac_addr(dev);
 		return;
diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index 09cdc2f2e7ff..bf77e8adffbf 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -517,7 +517,7 @@ static int enc28j60_set_mac_address(struct net_device *dev, void *addr)
 	if (!is_valid_ether_addr(address->sa_data))
 		return -EADDRNOTAVAIL;
 
-	ether_addr_copy(dev->dev_addr, address->sa_data);
+	eth_hw_addr_set(dev, address->sa_data);
 	return enc28j60_set_hw_macaddr(dev);
 }
 
@@ -1573,7 +1573,7 @@ static int enc28j60_probe(struct spi_device *spi)
 	}
 
 	if (device_get_mac_address(&spi->dev, macaddr, sizeof(macaddr)))
-		ether_addr_copy(dev->dev_addr, macaddr);
+		eth_hw_addr_set(dev, macaddr);
 	else
 		eth_hw_addr_random(dev);
 	enc28j60_set_hw_macaddr(dev);
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index d66ee9bf5558..a3392c74372a 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -829,7 +829,7 @@ static int lan743x_mac_init(struct lan743x_adapter *adapter)
 			eth_random_addr(adapter->mac_address);
 	}
 	lan743x_mac_set_address(adapter, adapter->mac_address);
-	ether_addr_copy(netdev->dev_addr, adapter->mac_address);
+	eth_hw_addr_set(netdev, adapter->mac_address);
 
 	return 0;
 }
@@ -2677,7 +2677,7 @@ static int lan743x_netdev_set_mac_address(struct net_device *netdev,
 	ret = eth_prepare_mac_addr_change(netdev, sock_addr);
 	if (ret)
 		return ret;
-	ether_addr_copy(netdev->dev_addr, sock_addr->sa_data);
+	eth_hw_addr_set(netdev, sock_addr->sa_data);
 	lan743x_mac_set_address(adapter, sock_addr->sa_data);
 	lan743x_rfe_update_mac_address(adapter);
 	return 0;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index 5c7b21ce64ed..a84038db8e1a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -172,7 +172,7 @@ static int sparx5_set_mac_address(struct net_device *dev, void *p)
 	sparx5_mact_learn(sparx5, PGID_CPU, addr->sa_data, port->pvid);
 
 	/* Record the address */
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4b8c23993217..6224b7c21e0a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1619,7 +1619,7 @@ static int mana_init_port(struct net_device *ndev)
 	if (apc->num_queues > apc->max_queues)
 		apc->num_queues = apc->max_queues;
 
-	ether_addr_copy(ndev->dev_addr, apc->mac_addr);
+	eth_hw_addr_set(ndev, apc->mac_addr);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index c08c56e07b1d..da8a4e01d4be 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -606,7 +606,7 @@ static int ocelot_port_set_mac_address(struct net_device *dev, void *p)
 	/* Then forget the previous one. */
 	ocelot_mact_forget(ocelot, dev->dev_addr, ocelot_port->pvid_vlan.vid);
 
-	ether_addr_copy(dev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(dev, addr->sa_data);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/abm/main.c b/drivers/net/ethernet/netronome/nfp/abm/main.c
index 605a1617b195..5d3df28c648f 100644
--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -305,7 +305,7 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf, struct nfp_abm *abm, struct nfp_net *nn,
 		return;
 	}
 
-	ether_addr_copy(nn->dp.netdev->dev_addr, mac_addr);
+	eth_hw_addr_set(nn->dp.netdev, mac_addr);
 	ether_addr_copy(nn->dp.netdev->perm_addr, mac_addr);
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
index d10a93801344..74c4bf4d397d 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
@@ -55,7 +55,7 @@ nfp_net_get_mac_addr(struct nfp_pf *pf, struct net_device *netdev,
 		return;
 	}
 
-	ether_addr_copy(netdev->dev_addr, eth_port->mac_addr);
+	eth_hw_addr_set(netdev, eth_port->mac_addr);
 	ether_addr_copy(netdev->perm_addr, eth_port->mac_addr);
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index c0e2f4394aef..87f2268b16d6 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -58,7 +58,7 @@ static void nfp_netvf_get_mac_addr(struct nfp_net *nn)
 		return;
 	}
 
-	ether_addr_copy(nn->dp.netdev->dev_addr, mac_addr);
+	eth_hw_addr_set(nn->dp.netdev, mac_addr);
 	ether_addr_copy(nn->dp.netdev->perm_addr, mac_addr);
 }
 
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 5d0cecf80b38..cb63c037753d 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1211,7 +1211,7 @@ static void *nixge_get_nvmem_address(struct device *dev)
 
 	cell = nvmem_cell_get(dev, "address");
 	if (IS_ERR(cell))
-		return NULL;
+		return cell;
 
 	mac = nvmem_cell_read(cell, &cell_size);
 	nvmem_cell_put(cell);
@@ -1284,8 +1284,8 @@ static int nixge_probe(struct platform_device *pdev)
 	ndev->max_mtu = NIXGE_JUMBO_MTU;
 
 	mac_addr = nixge_get_nvmem_address(&pdev->dev);
-	if (mac_addr && is_valid_ether_addr(mac_addr)) {
-		ether_addr_copy(ndev->dev_addr, mac_addr);
+	if (!IS_ERR(mac_addr) && is_valid_ether_addr(mac_addr)) {
+		eth_hw_addr_set(ndev, mac_addr);
 		kfree(mac_addr);
 	} else {
 		eth_hw_addr_random(ndev);
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 919140522885..b42b65fb034e 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1349,7 +1349,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	__lpc_get_mac(pldat, ndev->dev_addr);
 
 	if (!is_valid_ether_addr(ndev->dev_addr)) {
-		of_get_mac_address(np, ndev->dev_addr);
+		of_get_ethdev_address(np, ndev);
 	}
 	if (!is_valid_ether_addr(ndev->dev_addr))
 		eth_hw_addr_random(ndev);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index f99b085b56a5..03c51dd37e1f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -557,7 +557,7 @@ void qede_force_mac(void *dev, u8 *mac, bool forced)
 		return;
 	}
 
-	ether_addr_copy(edev->ndev->dev_addr, mac);
+	eth_hw_addr_set(edev->ndev, mac);
 	__qede_unlock(edev);
 }
 
@@ -1101,7 +1101,7 @@ int qede_set_mac_addr(struct net_device *ndev, void *p)
 			goto out;
 	}
 
-	ether_addr_copy(ndev->dev_addr, addr->sa_data);
+	eth_hw_addr_set(ndev, addr->sa_data);
 	DP_INFO(edev, "Setting device MAC to %pM\n", addr->sa_data);
 
 	if (edev->state != QEDE_STATE_OPEN) {
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 41f0a3433c3a..6c22bfc16ee6 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -843,7 +843,7 @@ static void qede_init_ndev(struct qede_dev *edev)
 	ndev->max_mtu = QEDE_MAX_JUMBO_PACKET_SIZE;
 
 	/* Set network device HW mac */
-	ether_addr_copy(edev->ndev->dev_addr, edev->dev_info.common.hw_mac);
+	eth_hw_addr_set(edev->ndev, edev->dev_info.common.hw_mac);
 
 	ndev->mtu = edev->dev_info.common.mtu;
 }
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index bb7f3286824f..94090856cf3a 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -550,7 +550,7 @@ static int emac_probe_resources(struct platform_device *pdev,
 
 	/* get mac address */
 	if (device_get_mac_address(&pdev->dev, maddr, ETH_ALEN))
-		ether_addr_copy(netdev->dev_addr, maddr);
+		eth_hw_addr_set(netdev, maddr);
 	else
 		eth_hw_addr_random(netdev);
 
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 2205bb437e68..a047bab1d7c7 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -967,7 +967,7 @@ qca_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, qcaspi_devs);
 
-	ret = of_get_mac_address(spi->dev.of_node, qca->net_dev->dev_addr);
+	ret = of_get_ethdev_address(spi->dev.of_node, qca->net_dev);
 	if (ret) {
 		eth_hw_addr_random(qca->net_dev);
 		dev_info(&spi->dev, "Using random MAC address: %pM\n",
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index ce3f7ce31adc..27c4f43176aa 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -347,7 +347,7 @@ static int qca_uart_probe(struct serdev_device *serdev)
 
 	of_property_read_u32(serdev->dev.of_node, "current-speed", &speed);
 
-	ret = of_get_mac_address(serdev->dev.of_node, qca->net_dev->dev_addr);
+	ret = of_get_ethdev_address(serdev->dev.of_node, qca->net_dev);
 	if (ret) {
 		eth_hw_addr_random(qca->net_dev);
 		dev_info(&serdev->dev, "Using random MAC address: %pM\n",
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 12548eeef4f8..4ee72d33e9cb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -114,7 +114,7 @@ static void ravb_read_mac_address(struct device_node *np,
 {
 	int ret;
 
-	ret = of_get_mac_address(np, ndev->dev_addr);
+	ret = of_get_ethdev_address(np, ndev);
 	if (ret) {
 		u32 mahr = ravb_read(ndev, MAHR);
 		u32 malr = ravb_read(ndev, MALR);
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
index 4639ed9438a3..926532466691 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -118,7 +118,7 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get MAC address if available (DT) */
-	of_get_mac_address(node, priv->dev->dev_addr);
+	of_get_ethdev_address(node, priv->dev);
 
 	/* Get the TX/RX IRQ numbers */
 	for (i = 0, chan = 1; i < SXGBE_TX_QUEUES; i++) {
diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index f488461a23d1..eeaecea77cb8 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -527,7 +527,7 @@ int efx_ef10_sriov_set_vf_mac(struct efx_nic *efx, int vf_i, u8 *mac)
 			goto fail;
 
 		if (vf->efx)
-			ether_addr_copy(vf->efx->net_dev->dev_addr, mac);
+			eth_hw_addr_set(vf->efx->net_dev, mac);
 	}
 
 	ether_addr_copy(vf->mac, mac);
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 41eb6f9f5596..bc1f4350360b 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -128,7 +128,7 @@ static int efx_probe_port(struct efx_nic *efx)
 		return rc;
 
 	/* Initialise MAC address to permanent address */
-	ether_addr_copy(efx->net_dev->dev_addr, efx->net_dev->perm_addr);
+	eth_hw_addr_set(efx->net_dev, efx->net_dev->perm_addr);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 6038b7e3e823..7249ea594b31 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -181,11 +181,11 @@ int efx_set_mac_address(struct net_device *net_dev, void *data)
 
 	/* save old address */
 	ether_addr_copy(old_addr, net_dev->dev_addr);
-	ether_addr_copy(net_dev->dev_addr, new_addr);
+	eth_hw_addr_set(net_dev, new_addr);
 	if (efx->type->set_mac_address) {
 		rc = efx->type->set_mac_address(efx);
 		if (rc) {
-			ether_addr_copy(net_dev->dev_addr, old_addr);
+			eth_hw_addr_set(net_dev, old_addr);
 			return rc;
 		}
 	}
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index 423bdf81200f..c68837a951f4 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -1044,7 +1044,7 @@ static int ef4_probe_port(struct ef4_nic *efx)
 		return rc;
 
 	/* Initialise MAC address to permanent address */
-	ether_addr_copy(efx->net_dev->dev_addr, efx->net_dev->perm_addr);
+	eth_hw_addr_set(efx->net_dev, efx->net_dev->perm_addr);
 
 	return 0;
 }
@@ -2162,11 +2162,11 @@ static int ef4_set_mac_address(struct net_device *net_dev, void *data)
 
 	/* save old address */
 	ether_addr_copy(old_addr, net_dev->dev_addr);
-	ether_addr_copy(net_dev->dev_addr, new_addr);
+	eth_hw_addr_set(net_dev, new_addr);
 	if (efx->type->set_mac_address) {
 		rc = efx->type->set_mac_address(efx);
 		if (rc) {
-			ether_addr_copy(net_dev->dev_addr, old_addr);
+			eth_hw_addr_set(net_dev, old_addr);
 			return rc;
 		}
 	}
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index f0451911ab8f..6b8013fb17c3 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2041,7 +2041,7 @@ static int netsec_probe(struct platform_device *pdev)
 
 	mac = device_get_mac_address(&pdev->dev, macbuf, sizeof(macbuf));
 	if (mac)
-		ether_addr_copy(ndev->dev_addr, mac);
+		eth_hw_addr_set(ndev, mac);
 
 	if (priv->eeprom_base &&
 	    (!mac || !is_valid_ether_addr(ndev->dev_addr))) {
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 57dc9680ad50..8ff56e2c8774 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1601,7 +1601,7 @@ static int ave_probe(struct platform_device *pdev)
 
 	ndev->max_mtu = AVE_MAX_ETHFRAME - (ETH_HLEN + ETH_FCS_LEN);
 
-	ret = of_get_mac_address(np, ndev->dev_addr);
+	ret = of_get_ethdev_address(np, ndev);
 	if (ret) {
 		/* if the mac address is invalid, use random mac address */
 		eth_hw_addr_random(ndev);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 692c291d9a01..daf0779261f3 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1981,7 +1981,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
 	SET_NETDEV_DEV(port->ndev, dev);
 
-	ether_addr_copy(port->ndev->dev_addr, port->slave.mac_addr);
+	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
 
 	port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
 	port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE;
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 1ef0aaef5c61..8c59e34d8bca 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -104,23 +104,37 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 277c91d13570..0d921f6542d6 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1000,7 +1000,7 @@ static int cpsw_ndo_set_mac_address(struct net_device *ndev, void *p)
 			   flags, vid);
 
 	ether_addr_copy(priv->mac_addr, addr->sa_data);
-	ether_addr_copy(ndev->dev_addr, priv->mac_addr);
+	eth_hw_addr_set(ndev, priv->mac_addr);
 	cpsw_set_slave_mac(&cpsw->slaves[slave_no], priv);
 
 	pm_runtime_put(cpsw->dev);
@@ -1404,7 +1404,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 			dev_info(cpsw->dev, "Random MACID = %pM\n",
 				 priv->mac_addr);
 		}
-		ether_addr_copy(ndev->dev_addr, slave_data->mac_addr);
+		eth_hw_addr_set(ndev, slave_data->mac_addr);
 		ether_addr_copy(priv->mac_addr, slave_data->mac_addr);
 
 		cpsw->slaves[i].ndev = ndev;
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index d243ca5dfde0..fbd6bd80f51f 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1911,7 +1911,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1, priv->mac_addr);
 	if (!rc)
-		ether_addr_copy(ndev->dev_addr, priv->mac_addr);
+		eth_hw_addr_set(ndev, priv->mac_addr);
 
 	if (!is_valid_ether_addr(priv->mac_addr)) {
 		/* Use random MAC if still none obtained. */
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 07bdeece1723..a6450055908d 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2028,14 +2028,14 @@ static int netcp_create_interface(struct netcp_device *netcp_device,
 
 		emac_arch_get_mac_addr(efuse_mac_addr, efuse, efuse_mac);
 		if (is_valid_ether_addr(efuse_mac_addr))
-			ether_addr_copy(ndev->dev_addr, efuse_mac_addr);
+			eth_hw_addr_set(ndev, efuse_mac_addr);
 		else
 			eth_random_addr(ndev->dev_addr);
 
 		devm_iounmap(dev, efuse);
 		devm_release_mem_region(dev, res.start, size);
 	} else {
-		ret = of_get_mac_address(node_interface, ndev->dev_addr);
+		ret = of_get_ethdev_address(node_interface, ndev);
 		if (ret)
 			eth_random_addr(ndev->dev_addr);
 	}
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index b1971c4d5313..093c75da38c4 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1151,7 +1151,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	lp->tx_ping_pong = get_bool(ofdev, "xlnx,tx-ping-pong");
 	lp->rx_ping_pong = get_bool(ofdev, "xlnx,rx-ping-pong");
 
-	rc = of_get_mac_address(ofdev->dev.of_node, ndev->dev_addr);
+	rc = of_get_ethdev_address(ofdev->dev.of_node, ndev);
 	if (rc) {
 		dev_warn(dev, "No MAC address found, using random\n");
 		eth_hw_addr_random(ndev);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73485383db4e..6085a28cae3d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3253,23 +3253,30 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
+
 	rc = mdio_bus_init();
 	if (rc)
-		return rc;
+		goto err_ethtool_phy_ops;
 
-	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
 	if (rc)
-		goto err_c45;
+		goto err_mdio_bus;
 
 	rc = phy_driver_register(&genphy_driver, THIS_MODULE);
-	if (rc) {
-		phy_driver_unregister(&genphy_c45_driver);
+	if (rc)
+		goto err_c45;
+
+	return 0;
+
 err_c45:
-		mdio_bus_exit();
-	}
+	phy_driver_unregister(&genphy_c45_driver);
+err_mdio_bus:
+	mdio_bus_exit();
+err_ethtool_phy_ops:
+	ethtool_set_ethtool_phy_ops(NULL);
 
 	return rc;
 }
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9dff866614d4..384d93146e1f 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -189,18 +189,6 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	return ret;
 }
 
-static int amd_gpio_set_config(struct gpio_chip *gc, unsigned offset,
-			       unsigned long config)
-{
-	u32 debounce;
-
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	return amd_gpio_set_debounce(gc, offset, debounce);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 {
@@ -775,7 +763,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-				unsigned long *configs, unsigned num_configs)
+			   unsigned long *configs, unsigned int num_configs)
 {
 	int i;
 	u32 arg;
@@ -865,6 +853,20 @@ static int amd_pinconf_group_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int amd_gpio_set_config(struct gpio_chip *gc, unsigned int pin,
+			       unsigned long config)
+{
+	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
+
+	if (pinconf_to_config_param(config) == PIN_CONFIG_INPUT_DEBOUNCE) {
+		u32 debounce = pinconf_to_config_argument(config);
+
+		return amd_gpio_set_debounce(gc, pin, debounce);
+	}
+
+	return amd_pinconf_set(gpio_dev->pctrl, pin, &config, 1);
+}
+
 static const struct pinconf_ops amd_pinconf_ops = {
 	.pin_config_get		= amd_pinconf_get,
 	.pin_config_set		= amd_pinconf_set,
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 80fa0ef8909c..147199002df1 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -126,7 +126,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index a8a0a448cdb5..80f54111baec 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1732,6 +1732,9 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 
 	/* Now hook interrupt too */
 	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return irq;
+
 	ret = request_irq(irq, au1200fb_handle_irq,
 			  IRQF_SHARED, "lcd", (void *)dev);
 	if (ret) {
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index ad598257ab38..cd376a9bfe1b 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -602,10 +602,10 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	if (var->hsync_len < 1    || var->hsync_len > 64)
 		printk(KERN_ERR "%s: invalid hsync_len %d\n",
 			info->fix.id, var->hsync_len);
-	if (var->left_margin > 255)
+	if (var->left_margin < 3  || var->left_margin > 255)
 		printk(KERN_ERR "%s: invalid left_margin %d\n",
 			info->fix.id, var->left_margin);
-	if (var->right_margin > 255)
+	if (var->right_margin < 1 || var->right_margin > 255)
 		printk(KERN_ERR "%s: invalid right_margin %d\n",
 			info->fix.id, var->right_margin);
 	if (var->yres < 1 || var->yres > ymax_mask)
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d426a2a5823e..d24cef671c1a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1855,6 +1855,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 
 		/* Shouldn't have super stripes in sequential zones */
 		if (zoned && nr) {
+			kfree(logical);
 			btrfs_err(fs_info,
 			"zoned: block group %llu must not contain super block",
 				  cache->start);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 42dd6316c62f..d408d1dfde7c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4342,4 +4342,5 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 		ulist_free(entry->old_roots);
 		kfree(entry);
 	}
+	*root = RB_ROOT;
 }
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6c982869f101..f79705af3aca 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1732,6 +1732,20 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		memmove(here, (void *)here + size,
 			(void *)last - (void *)here + sizeof(__u32));
 		memset(last, 0, size);
+
+		/*
+		 * Update i_inline_off - moved ibody region might contain
+		 * system.data attribute.  Handling a failure here won't
+		 * cause other complications for setting an xattr.
+		 */
+		if (!is_block && ext4_has_inline_data(inode)) {
+			ret = ext4_find_inline_data_nolock(inode);
+			if (ret) {
+				ext4_warning_inode(inode,
+					"unable to update i_inline_off");
+				goto out;
+			}
+		}
 	} else if (s->not_found) {
 		/* Insert new name. */
 		size_t size = EXT4_XATTR_LEN(name_len);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1abbdd78389a..4ea52906ae15 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -249,7 +249,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 			spin_unlock(&fi->lock);
 		}
 		kfree(forget);
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM || ret == -EINTR)
 			goto out;
 		if (ret || fuse_invalid_attr(&outarg.attr) ||
 		    fuse_stale_inode(inode, outarg.generation, &outarg.attr))
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index dbff26f7f9cd..2f26b5c8e955 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -9,14 +9,23 @@
 #include <linux/compat.h>
 #include <linux/fileattr.h>
 
-static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args)
+static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
+			       struct fuse_ioctl_out *outarg)
 {
-	ssize_t ret = fuse_simple_request(fm, args);
+	ssize_t ret;
+
+	args->out_args[0].size = sizeof(*outarg);
+	args->out_args[0].value = outarg;
+
+	ret = fuse_simple_request(fm, args);
 
 	/* Translate ENOSYS, which shouldn't be returned from fs */
 	if (ret == -ENOSYS)
 		ret = -ENOTTY;
 
+	if (ret >= 0 && outarg->result == -ENOSYS)
+		outarg->result = -ENOTTY;
+
 	return ret;
 }
 
@@ -264,13 +273,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
 	}
 
 	ap.args.out_numargs = 2;
-	ap.args.out_args[0].size = sizeof(outarg);
-	ap.args.out_args[0].value = &outarg;
 	ap.args.out_args[1].size = out_size;
 	ap.args.out_pages = true;
 	ap.args.out_argvar = true;
 
-	transferred = fuse_send_ioctl(fm, &ap.args);
+	transferred = fuse_send_ioctl(fm, &ap.args, &outarg);
 	err = transferred;
 	if (transferred < 0)
 		goto out;
@@ -399,12 +406,10 @@ static int fuse_priv_ioctl(struct inode *inode, struct fuse_file *ff,
 	args.in_args[1].size = inarg.in_size;
 	args.in_args[1].value = ptr;
 	args.out_numargs = 2;
-	args.out_args[0].size = sizeof(outarg);
-	args.out_args[0].value = &outarg;
 	args.out_args[1].size = inarg.out_size;
 	args.out_args[1].value = ptr;
 
-	err = fuse_send_ioctl(fm, &args);
+	err = fuse_send_ioctl(fm, &args, &outarg);
 	if (!err) {
 		if (outarg.result < 0)
 			err = outarg.result;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 746132998c57..fe8bb031b7d7 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -57,28 +57,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
 	}
 }
 
-/*
- * Move a buffer from the checkpoint list to the checkpoint io list
- *
- * Called with j_list_lock held
- */
-static inline void __buffer_relink_io(struct journal_head *jh)
-{
-	transaction_t *transaction = jh->b_cp_transaction;
-
-	__buffer_unlink_first(jh);
-
-	if (!transaction->t_checkpoint_io_list) {
-		jh->b_cpnext = jh->b_cpprev = jh;
-	} else {
-		jh->b_cpnext = transaction->t_checkpoint_io_list;
-		jh->b_cpprev = transaction->t_checkpoint_io_list->b_cpprev;
-		jh->b_cpprev->b_cpnext = jh;
-		jh->b_cpnext->b_cpprev = jh;
-	}
-	transaction->t_checkpoint_io_list = jh;
-}
-
 /*
  * Check a checkpoint buffer could be release or not.
  *
@@ -183,6 +161,7 @@ __flush_batch(journal_t *journal, int *batch_count)
 		struct buffer_head *bh = journal->j_chkpt_bhs[i];
 		BUFFER_TRACE(bh, "brelse");
 		__brelse(bh);
+		journal->j_chkpt_bhs[i] = NULL;
 	}
 	*batch_count = 0;
 }
@@ -242,6 +221,11 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		jh = transaction->t_checkpoint_list;
 		bh = jh2bh(jh);
 
+		/*
+		 * The buffer may be writing back, or flushing out in the
+		 * last couple of cycles, or re-adding into a new transaction,
+		 * need to check it again until it's unlocked.
+		 */
 		if (buffer_locked(bh)) {
 			get_bh(bh);
 			spin_unlock(&journal->j_list_lock);
@@ -287,28 +271,32 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		}
 		if (!buffer_dirty(bh)) {
 			BUFFER_TRACE(bh, "remove from checkpoint");
-			if (__jbd2_journal_remove_checkpoint(jh))
-				/* The transaction was released; we're done */
+			/*
+			 * If the transaction was released or the checkpoint
+			 * list was empty, we're done.
+			 */
+			if (__jbd2_journal_remove_checkpoint(jh) ||
+			    !transaction->t_checkpoint_list)
 				goto out;
-			continue;
+		} else {
+			/*
+			 * We are about to write the buffer, it could be
+			 * raced by some other transaction shrink or buffer
+			 * re-log logic once we release the j_list_lock,
+			 * leave it on the checkpoint list and check status
+			 * again to make sure it's clean.
+			 */
+			BUFFER_TRACE(bh, "queue");
+			get_bh(bh);
+			J_ASSERT_BH(bh, !buffer_jwrite(bh));
+			journal->j_chkpt_bhs[batch_count++] = bh;
+			transaction->t_chp_stats.cs_written++;
+			transaction->t_checkpoint_list = jh->b_cpnext;
 		}
-		/*
-		 * Important: we are about to write the buffer, and
-		 * possibly block, while still holding the journal
-		 * lock.  We cannot afford to let the transaction
-		 * logic start messing around with this buffer before
-		 * we write it to disk, as that would break
-		 * recoverability.
-		 */
-		BUFFER_TRACE(bh, "queue");
-		get_bh(bh);
-		J_ASSERT_BH(bh, !buffer_jwrite(bh));
-		journal->j_chkpt_bhs[batch_count++] = bh;
-		__buffer_relink_io(jh);
-		transaction->t_chp_stats.cs_written++;
+
 		if ((batch_count == JBD2_NR_BATCH) ||
-		    need_resched() ||
-		    spin_needbreak(&journal->j_list_lock))
+		    need_resched() || spin_needbreak(&journal->j_list_lock) ||
+		    jh2bh(transaction->t_checkpoint_list) == journal->j_chkpt_bhs[0])
 			goto unlock_and_flush;
 	}
 
@@ -322,38 +310,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 	}
 
-	/*
-	 * Now we issued all of the transaction's buffers, let's deal
-	 * with the buffers that are out for I/O.
-	 */
-restart2:
-	/* Did somebody clean up the transaction in the meanwhile? */
-	if (journal->j_checkpoint_transactions != transaction ||
-	    transaction->t_tid != this_tid)
-		goto out;
-
-	while (transaction->t_checkpoint_io_list) {
-		jh = transaction->t_checkpoint_io_list;
-		bh = jh2bh(jh);
-		if (buffer_locked(bh)) {
-			get_bh(bh);
-			spin_unlock(&journal->j_list_lock);
-			wait_on_buffer(bh);
-			/* the journal_head may have gone by now */
-			BUFFER_TRACE(bh, "brelse");
-			__brelse(bh);
-			spin_lock(&journal->j_list_lock);
-			goto restart2;
-		}
-
-		/*
-		 * Now in whatever state the buffer currently is, we
-		 * know that it has been written out and so we can
-		 * drop it from the list
-		 */
-		if (__jbd2_journal_remove_checkpoint(jh))
-			break;
-	}
 out:
 	spin_unlock(&journal->j_list_lock);
 	result = jbd2_cleanup_journal_tail(journal);
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index d6e02ce44b97..f235a3d270a0 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2027,6 +2027,9 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
 		return -ENOSPC;
 
+	if (leafidx < 0)
+		return -EIO;
+
 	/* determine the block number within the file system corresponding
 	 * to the leaf at which free space was found.
 	 */
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 042bbe6d8ac2..6c8680d3907a 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -354,6 +354,11 @@ tid_t txBegin(struct super_block *sb, int flag)
 	jfs_info("txBegin: flag = 0x%x", flag);
 	log = JFS_SBI(sb)->log;
 
+	if (!log) {
+		jfs_error(sb, "read-only filesystem\n");
+		return 0;
+	}
+
 	TXN_LOCK();
 
 	INCREMENT(TxStat.txBegin);
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 4fbbf88435e6..b3a0fe0649c4 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -799,6 +799,11 @@ static int jfs_link(struct dentry *old_dentry,
 	if (rc)
 		goto out;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EROFS;
+	}
+
 	tid = txBegin(ip->i_sb, 0);
 
 	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index cddd07b7d132..b88f5a2f6032 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -555,7 +555,7 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
-			dqgrab(dquot);
+			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
 			 * Once dqput() wakes us up, we know it's time to free
@@ -2413,7 +2413,8 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	error = add_dquot_ref(sb, type);
 	if (error)
-		dquot_disable(sb, type, flags);
+		dquot_disable(sb, type,
+			      DQUOT_USAGE_ENABLED | DQUOT_LIMITS_ENABLED);
 
 	return error;
 out_fmt:
diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 622569007b53..2142cbd1dde2 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -247,7 +247,7 @@ static int udf_name_from_CS0(struct super_block *sb,
 	}
 
 	if (translate) {
-		if (str_o_len <= 2 && str_o[0] == '.' &&
+		if (str_o_len > 0 && str_o_len <= 2 && str_o[0] == '.' &&
 		    (str_o_len == 1 || str_o[1] == '.'))
 			needsCRC = 1;
 		if (needsCRC) {
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 7f28fa702bb7..ca0e26a858be 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -323,7 +323,7 @@ static inline void eth_hw_addr_inherit(struct net_device *dst,
 				       struct net_device *src)
 {
 	dst->addr_assign_type = src->addr_assign_type;
-	ether_addr_copy(dst->dev_addr, src->dev_addr);
+	eth_hw_addr_set(dst, src->dev_addr);
 }
 
 /**
diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 55460ecfa50a..0484b613ca64 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -14,6 +14,7 @@
 struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
+int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np,
@@ -27,6 +28,11 @@ static inline int of_get_mac_address(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
+{
+	return -ENODEV;
+}
+
 static inline struct net_device *of_find_net_device_by_node(struct device_node *np)
 {
 	return NULL;
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a7ebadf83c68..07a84ae6bf81 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -473,7 +473,7 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index fdac6913b6c8..d8920f84f0a8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1473,25 +1473,38 @@ void tcp_leave_memory_pressure(struct sock *sk);
 static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_intvl ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepintvl()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_intvl);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
 }
 
 static inline int keepalive_time_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_time ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepidle_locked() */
+	val = READ_ONCE(tp->keepalive_time);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
 }
 
 static inline int keepalive_probes(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
 
-	return tp->keepalive_probes ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepcnt()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_probes);
+
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_probes);
 }
 
 static inline u32 keepalive_time_elapsed(const struct tcp_sock *tp)
@@ -1999,7 +2012,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 bool tcp_stream_memory_free(const struct sock *sk, int wake);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bd31aa6407a7..e1848a2a7230 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3744,7 +3744,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 continue_func:
 	subprog_end = subprog[idx + 1].start;
 	for (; i < subprog_end; i++) {
-		int next_insn;
+		int next_insn, sidx;
 
 		if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
 			continue;
@@ -3754,14 +3754,14 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
-		idx = find_subprog(env, next_insn);
-		if (idx < 0) {
+		sidx = find_subprog(env, next_insn);
+		if (sidx < 0) {
 			WARN_ONCE(1, "verifier bug. No program starts at insn %d\n",
 				  next_insn);
 			return -EFAULT;
 		}
-		if (subprog[idx].is_async_cb) {
-			if (subprog[idx].has_tail_call) {
+		if (subprog[sidx].is_async_cb) {
+			if (subprog[sidx].has_tail_call) {
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
@@ -3770,6 +3770,7 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				continue;
 		}
 		i = next_insn;
+		idx = sidx;
 
 		if (subprog[idx].has_tail_call)
 			tail_call_reachable = true;
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0bb34467e4f2..1b70fc4c703f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5949,7 +5949,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		goto out_unreg;
 
 	if (has_hist_vars(hist_data) || hist_data->n_var_refs) {
-		if (save_hist_vars(hist_data))
+		ret = save_hist_vars(hist_data);
+		if (ret)
 			goto out_unreg;
 	}
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index ba55851fe132..3326dfced68a 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,6 +201,9 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
+	if (!net_eq(dev_net(br->dev), &init_net))
+		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
+
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 5727a073189b..a2fd68d1149b 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1521,6 +1521,12 @@ static int bcm_release(struct socket *sock)
 
 	lock_sock(sk);
 
+#if IS_ENABLED(CONFIG_PROC_FS)
+	/* remove procfs entry */
+	if (net->can.bcmproc_dir && bo->bcm_proc_read)
+		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
+#endif /* CONFIG_PROC_FS */
+
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
 		bcm_remove_op(op);
 
@@ -1556,12 +1562,6 @@ static int bcm_release(struct socket *sock)
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
 		bcm_remove_op(op);
 
-#if IS_ENABLED(CONFIG_PROC_FS)
-	/* remove procfs entry */
-	if (net->can.bcmproc_dir && bo->bcm_proc_read)
-		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
-#endif /* CONFIG_PROC_FS */
-
 	/* remove device reference */
 	if (bo->bound) {
 		bo->bound   = 0;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index dbac3a172a11..f1a9bf7578e7 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -143,3 +143,28 @@ int of_get_mac_address(struct device_node *np, u8 *addr)
 	return of_get_mac_addr_nvmem(np, addr);
 }
 EXPORT_SYMBOL(of_get_mac_address);
+
+/**
+ * of_get_ethdev_address()
+ * @np:		Caller's Device Node
+ * @dev:	Pointer to netdevice which address will be updated
+ *
+ * Search the device tree for the best MAC address to use.
+ * If found set @dev->dev_addr to that address.
+ *
+ * See documentation of of_get_mac_address() for more information on how
+ * the best address is determined.
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
+{
+	u8 addr[ETH_ALEN];
+	int ret;
+
+	ret = of_get_mac_address(np, addr);
+	if (!ret)
+		eth_hw_addr_set(dev, addr);
+	return ret;
+}
+EXPORT_SYMBOL(of_get_ethdev_address);
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d747166bb291..386e9875e5b8 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -1133,7 +1133,7 @@ static int esp_init_authenc(struct xfrm_state *x)
 	err = crypto_aead_setkey(aead, key, keylen);
 
 free_key:
-	kfree(key);
+	kfree_sensitive(key);
 
 error:
 	return err;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4fb050643077..c770719797e1 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -833,7 +833,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 	icsk = inet_csk(sk_listener);
 	net = sock_net(sk_listener);
-	max_syn_ack_retries = icsk->icsk_syn_retries ? :
+	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 39b3db5b6119..2936676f86eb 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -571,20 +571,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_hashed(osk);
-		if (ret) {
-			/* Before deleting the node, we insert a new one to make
-			 * sure that the look-up-sk process would not miss either
-			 * of them and that at least one node would exist in ehash
-			 * table all the time. Otherwise there's a tiny chance
-			 * that lookup process could find nothing in ehash table.
-			 */
-			__sk_nulls_add_node_tail_rcu(sk, list);
-			sk_nulls_del_node_init_rcu(osk);
-		}
-		goto unlock;
-	}
-	if (found_dup_sk) {
+		ret = sk_nulls_del_node_init_rcu(osk);
+	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -593,7 +581,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index fe6340c363b4..437afe392e66 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -81,10 +81,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_tail_rcu(struct inet_timewait_sock *tw,
-					struct hlist_nulls_head *list)
+static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
+				   struct hlist_nulls_head *list)
 {
-	hlist_nulls_add_tail_rcu(&tw->tw_node, list);
+	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
 static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
@@ -120,7 +120,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fc0fa1f2ca9b..a91cf000bb61 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3296,7 +3296,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	inet_csk(sk)->icsk_syn_retries = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3305,7 +3305,7 @@ EXPORT_SYMBOL(tcp_sock_set_syncnt);
 void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
 {
 	lock_sock(sk);
-	inet_csk(sk)->icsk_user_timeout = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(tcp_sock_set_user_timeout);
@@ -3317,7 +3317,8 @@ int tcp_sock_set_keepidle_locked(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPIDLE)
 		return -EINVAL;
 
-	tp->keepalive_time = val * HZ;
+	/* Paired with WRITE_ONCE() in keepalive_time_when() */
+	WRITE_ONCE(tp->keepalive_time, val * HZ);
 	if (sock_flag(sk, SOCK_KEEPOPEN) &&
 	    !((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
 		u32 elapsed = keepalive_time_elapsed(tp);
@@ -3349,7 +3350,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
 	release_sock(sk);
 	return 0;
 }
@@ -3361,7 +3362,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_probes = val;
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3563,19 +3565,19 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPINTVL)
 			err = -EINVAL;
 		else
-			tp->keepalive_intvl = val * HZ;
+			WRITE_ONCE(tp->keepalive_intvl, val * HZ);
 		break;
 	case TCP_KEEPCNT:
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
 			err = -EINVAL;
 		else
-			tp->keepalive_probes = val;
+			WRITE_ONCE(tp->keepalive_probes, val);
 		break;
 	case TCP_SYNCNT:
 		if (val < 1 || val > MAX_TCP_SYNCNT)
 			err = -EINVAL;
 		else
-			icsk->icsk_syn_retries = val;
+			WRITE_ONCE(icsk->icsk_syn_retries, val);
 		break;
 
 	case TCP_SAVE_SYN:
@@ -3588,18 +3590,18 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 
 	case TCP_LINGER2:
 		if (val < 0)
-			tp->linger2 = -1;
+			WRITE_ONCE(tp->linger2, -1);
 		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			tp->linger2 = TCP_FIN_TIMEOUT_MAX;
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
 		else
-			tp->linger2 = val * HZ;
+			WRITE_ONCE(tp->linger2, val * HZ);
 		break;
 
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
-		icsk->icsk_accept_queue.rskq_defer_accept =
-			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					TCP_RTO_MAX / HZ);
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
 		break;
 
 	case TCP_WINDOW_CLAMP:
@@ -3623,7 +3625,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = val;
+			WRITE_ONCE(icsk->icsk_user_timeout, val);
 		break;
 
 	case TCP_FASTOPEN:
@@ -3667,7 +3669,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -3679,7 +3681,7 @@ static int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_TX_DELAY:
 		if (val)
 			tcp_enable_tx_delay();
-		tp->tcp_tx_delay = val;
+		WRITE_ONCE(tp->tcp_tx_delay, val);
 		break;
 	default:
 		err = -ENOPROTOOPT;
@@ -3989,17 +3991,18 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		val = keepalive_probes(tp);
 		break;
 	case TCP_SYNCNT:
-		val = icsk->icsk_syn_retries ? :
+		val = READ_ONCE(icsk->icsk_syn_retries) ? :
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-		val = tp->linger2;
+		val = READ_ONCE(tp->linger2);
 		if (val >= 0)
 			val = (val ? : READ_ONCE(net->ipv4.sysctl_tcp_fin_timeout)) / HZ;
 		break;
 	case TCP_DEFER_ACCEPT:
-		val = retrans_to_secs(icsk->icsk_accept_queue.rskq_defer_accept,
-				      TCP_TIMEOUT_INIT / HZ, TCP_RTO_MAX / HZ);
+		val = READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept);
+		val = retrans_to_secs(val, TCP_TIMEOUT_INIT / HZ,
+				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
 		val = tp->window_clamp;
@@ -4135,11 +4138,11 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = icsk->icsk_user_timeout;
+		val = READ_ONCE(icsk->icsk_user_timeout);
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
@@ -4151,14 +4154,14 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TX_DELAY:
-		val = tp->tcp_tx_delay;
+		val = READ_ONCE(tp->tcp_tx_delay);
 		break;
 
 	case TCP_TIMESTAMP:
 		val = tcp_time_stamp_raw() + tp->tsoffset;
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 6e0a8ef5e816..e9b5d6f10c56 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -301,6 +301,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -313,10 +314,11 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index db05ab4287e3..b5cb674eca1c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -975,7 +975,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent,
+			READ_ONCE(req->ts_recent),
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index aa67d5adcbca..2606a5571116 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -523,7 +523,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->max_window = newtp->snd_wnd;
 
 	if (newtp->rx_opt.tstamp_ok) {
-		newtp->rx_opt.ts_recent = req->ts_recent;
+		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
 		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
@@ -586,7 +586,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
-			tmp_opt.ts_recent = req->ts_recent;
+			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
 			/* We do not store true stamp, but it is not required,
@@ -726,8 +726,11 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	/* In sequence, PAWS is OK. */
 
+	/* TODO: We probably should defer ts_recent change once
+	 * we take ownership of @req.
+	 */
 	if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
-		req->ts_recent = tmp_opt.rcv_tsval;
+		WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
 
 	if (TCP_SKB_CB(skb)->seq == tcp_rsk(req)->rcv_isn) {
 		/* Truncate SYN, it is out of window starting
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1f39b56bbab3..d46fb6d7057b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -875,7 +875,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	if (likely(ireq->tstamp_ok)) {
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
-		opts->tsecr = req->ts_recent;
+		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
 	if (likely(ireq->sack_ok)) {
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 0b041ab79ad9..0efd5b4346b0 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -955,7 +955,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		goto tx_err;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		pskb_trim(skb, dev->mtu + dev->hard_header_len);
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+			goto tx_err;
 		truncate = true;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b6f5a4474d8b..c18fdddbfa09 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1171,7 +1171,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
 			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
-			req->ts_recent, sk->sk_bound_dev_if,
+			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0, sk->sk_priority);
 }
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index c309b72a5877..7cac441862e2 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -163,9 +163,6 @@ int llc_rcv(struct sk_buff *skb, struct net_device *dev,
 	void (*sta_handler)(struct sk_buff *skb);
 	void (*sap_handler)(struct llc_sap *sap, struct sk_buff *skb);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		goto drop;
-
 	/*
 	 * When the interface is in promisc. mode, drop all the crap that it
 	 * receives, do not try to analyse it.
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 04b7c4e59520..e0e675313d8e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3795,6 +3795,8 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
+			if (nft_chain_is_bound(chain))
+				continue;
 
 			ctx.chain = chain;
 			err = nft_delrule_by_chain(&ctx);
@@ -9908,6 +9910,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 	if (!tb[NFTA_VERDICT_CODE])
 		return -EINVAL;
+
+	/* zero padding hole for memcmp */
+	memset(data, 0, sizeof(*data));
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
@@ -10189,6 +10194,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
+		if (nft_chain_is_bound(chain))
+			continue;
+
 		ctx.chain = chain;
 		list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 			list_del(&rule->list);
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 0452ee586c1c..a81829c10fea 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1930,7 +1930,11 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		int i, start, rules_fx;
 
 		match_start = data;
-		match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+
+		if (nft_set_ext_exists(&e->ext, NFT_SET_EXT_KEY_END))
+			match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+		else
+			match_end = data;
 
 		start = first_rule;
 		rules_fx = rules_f0;
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index df19a847829e..b7c46a93a412 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -402,56 +402,6 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	return 0;
 }
 
-static int cls_bpf_set_parms(struct net *net, struct tcf_proto *tp,
-			     struct cls_bpf_prog *prog, unsigned long base,
-			     struct nlattr **tb, struct nlattr *est, u32 flags,
-			     struct netlink_ext_ack *extack)
-{
-	bool is_bpf, is_ebpf, have_exts = false;
-	u32 gen_flags = 0;
-	int ret;
-
-	is_bpf = tb[TCA_BPF_OPS_LEN] && tb[TCA_BPF_OPS];
-	is_ebpf = tb[TCA_BPF_FD];
-	if ((!is_bpf && !is_ebpf) || (is_bpf && is_ebpf))
-		return -EINVAL;
-
-	ret = tcf_exts_validate(net, tp, tb, est, &prog->exts, flags,
-				extack);
-	if (ret < 0)
-		return ret;
-
-	if (tb[TCA_BPF_FLAGS]) {
-		u32 bpf_flags = nla_get_u32(tb[TCA_BPF_FLAGS]);
-
-		if (bpf_flags & ~TCA_BPF_FLAG_ACT_DIRECT)
-			return -EINVAL;
-
-		have_exts = bpf_flags & TCA_BPF_FLAG_ACT_DIRECT;
-	}
-	if (tb[TCA_BPF_FLAGS_GEN]) {
-		gen_flags = nla_get_u32(tb[TCA_BPF_FLAGS_GEN]);
-		if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS ||
-		    !tc_flags_valid(gen_flags))
-			return -EINVAL;
-	}
-
-	prog->exts_integrated = have_exts;
-	prog->gen_flags = gen_flags;
-
-	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
-		       cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
-	if (ret < 0)
-		return ret;
-
-	if (tb[TCA_BPF_CLASSID]) {
-		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
-		tcf_bind_filter(tp, &prog->res, base);
-	}
-
-	return 0;
-}
-
 static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 			  struct tcf_proto *tp, unsigned long base,
 			  u32 handle, struct nlattr **tca,
@@ -459,9 +409,12 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 			  struct netlink_ext_ack *extack)
 {
 	struct cls_bpf_head *head = rtnl_dereference(tp->root);
+	bool is_bpf, is_ebpf, have_exts = false;
 	struct cls_bpf_prog *oldprog = *arg;
 	struct nlattr *tb[TCA_BPF_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_bpf_prog *prog;
+	u32 gen_flags = 0;
 	int ret;
 
 	if (tca[TCA_OPTIONS] == NULL)
@@ -500,11 +453,51 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 		goto errout;
 	prog->handle = handle;
 
-	ret = cls_bpf_set_parms(net, tp, prog, base, tb, tca[TCA_RATE], flags,
-				extack);
+	is_bpf = tb[TCA_BPF_OPS_LEN] && tb[TCA_BPF_OPS];
+	is_ebpf = tb[TCA_BPF_FD];
+	if ((!is_bpf && !is_ebpf) || (is_bpf && is_ebpf)) {
+		ret = -EINVAL;
+		goto errout_idr;
+	}
+
+	ret = tcf_exts_validate(net, tp, tb, tca[TCA_RATE], &prog->exts,
+				flags, extack);
+	if (ret < 0)
+		goto errout_idr;
+
+	if (tb[TCA_BPF_FLAGS]) {
+		u32 bpf_flags = nla_get_u32(tb[TCA_BPF_FLAGS]);
+
+		if (bpf_flags & ~TCA_BPF_FLAG_ACT_DIRECT) {
+			ret = -EINVAL;
+			goto errout_idr;
+		}
+
+		have_exts = bpf_flags & TCA_BPF_FLAG_ACT_DIRECT;
+	}
+	if (tb[TCA_BPF_FLAGS_GEN]) {
+		gen_flags = nla_get_u32(tb[TCA_BPF_FLAGS_GEN]);
+		if (gen_flags & ~CLS_BPF_SUPPORTED_GEN_FLAGS ||
+		    !tc_flags_valid(gen_flags)) {
+			ret = -EINVAL;
+			goto errout_idr;
+		}
+	}
+
+	prog->exts_integrated = have_exts;
+	prog->gen_flags = gen_flags;
+
+	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
+		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
 	if (ret < 0)
 		goto errout_idr;
 
+	if (tb[TCA_BPF_CLASSID]) {
+		prog->res.classid = nla_get_u32(tb[TCA_BPF_CLASSID]);
+		tcf_bind_filter(tp, &prog->res, base);
+		bound_to_filter = true;
+	}
+
 	ret = cls_bpf_offload(tp, prog, oldprog, extack);
 	if (ret)
 		goto errout_parms;
@@ -526,6 +519,8 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 errout_parms:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &prog->res);
 	cls_bpf_free_parms(prog);
 errout_idr:
 	if (!oldprog)
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 07a0ef2baacd..a7673ad86d18 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -401,17 +401,21 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	set_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags);
 
 	if (dest_keyring) {
-		ret = __key_link_lock(dest_keyring, &ctx->index_key);
+		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
-		ret = __key_link_begin(dest_keyring, &ctx->index_key, &edit);
-		if (ret < 0)
-			goto link_prealloc_failed;
 	}
 
-	/* attach the key to the destination keyring under lock, but we do need
+	/*
+	 * Attach the key to the destination keyring under lock, but we do need
 	 * to do another check just in case someone beat us to it whilst we
-	 * waited for locks */
+	 * waited for locks.
+	 *
+	 * The caller might specify a comparison function which looks for keys
+	 * that do not exactly match but are still equivalent from the caller's
+	 * perspective. The __key_link_begin() operation must be done only after
+	 * an actual key is determined.
+	 */
 	mutex_lock(&key_construction_mutex);
 
 	rcu_read_lock();
@@ -420,12 +424,16 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	if (!IS_ERR(key_ref))
 		goto key_already_present;
 
-	if (dest_keyring)
+	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed;
 		__key_link(dest_keyring, key, &edit);
+	}
 
 	mutex_unlock(&key_construction_mutex);
 	if (dest_keyring)
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 	mutex_unlock(&user->cons_lock);
 	*_key = key;
 	kleave(" = 0 [%d]", key_serial(key));
@@ -438,10 +446,13 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	mutex_unlock(&key_construction_mutex);
 	key = key_ref_to_ptr(key_ref);
 	if (dest_keyring) {
+		ret = __key_link_begin(dest_keyring, &key->index_key, &edit);
+		if (ret < 0)
+			goto link_alloc_failed_unlocked;
 		ret = __key_link_check_live_key(dest_keyring, key);
 		if (ret == 0)
 			__key_link(dest_keyring, key, &edit);
-		__key_link_end(dest_keyring, &ctx->index_key, edit);
+		__key_link_end(dest_keyring, &key->index_key, edit);
 		if (ret < 0)
 			goto link_check_failed;
 	}
@@ -456,8 +467,10 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	kleave(" = %d [linkcheck]", ret);
 	return ret;
 
-link_prealloc_failed:
-	__key_link_end(dest_keyring, &ctx->index_key, edit);
+link_alloc_failed:
+	mutex_unlock(&key_construction_mutex);
+link_alloc_failed_unlocked:
+	__key_link_end(dest_keyring, &key->index_key, edit);
 link_lock_failed:
 	mutex_unlock(&user->cons_lock);
 	key_put(key);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 2b2c8eb258d5..bc700f85f80b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -186,7 +186,7 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 }
 
 /**
- * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
+ * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
  *
  * @buf: an allocated tpm_buf instance
  * @session_handle: session handle
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 6cf7c8b1de47..4ca65f425f39 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -1563,14 +1563,8 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 	gpr += 2;
 
 	/* Master volume (will be renamed later) */
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+0+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+1+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+2+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+3+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+4+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+5+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+6+SND_EMU10K1_PLAYBACK_CHANNELS));
-	A_OP(icode, &ptr, iMAC0, A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+7+SND_EMU10K1_PLAYBACK_CHANNELS));
+	for (z = 0; z < 8; z++)
+		A_OP(icode, &ptr, iMAC0, A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS), A_C_00000000, A_GPR(gpr), A_GPR(playback+z+SND_EMU10K1_PLAYBACK_CHANNELS));
 	snd_emu10k1_init_mono_control(&controls[nctl++], "Wave Master Playback Volume", gpr, 0);
 	gpr += 2;
 
@@ -1654,102 +1648,14 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GPR(var), A_GPR(vol), A_EXTIN(input))
 			dev_dbg(emu->card->dev, "emufx.c: gpr=0x%x, tmp=0x%x\n",
 			       gpr, tmp);
 			*/
-			/* For the EMU1010: How to get 32bit values from the DSP. High 16bits into L, low 16bits into R. */
-			/* A_P16VIN(0) is delayed by one sample,
-			 * so all other A_P16VIN channels will need to also be delayed
-			 */
-			/* Left ADC in. 1 of 2 */
 			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_P16VIN(0x0), A_FXBUS2(0) );
-			/* Right ADC in 1 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			/* Delaying by one sample: instead of copying the input
-			 * value A_P16VIN to output A_FXBUS2 as in the first channel,
-			 * we use an auxiliary register, delaying the value by one
-			 * sample
-			 */
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(2) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x1), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(4) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x2), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(6) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x3), A_C_00000000, A_C_00000000);
-			/* For 96kHz mode */
-			/* Left ADC in. 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0x8) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x4), A_C_00000000, A_C_00000000);
-			/* Right ADC in 2 of 2 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xa) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x5), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xc) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x6), A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr - 1), A_FXBUS2(0xe) );
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x7), A_C_00000000, A_C_00000000);
-			/* Pavel Hofman - we still have voices, A_FXBUS2s, and
-			 * A_P16VINs available -
-			 * let's add 8 more capture channels - total of 16
-			 */
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x10));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x8),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x12));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0x9),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x14));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xa),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x16));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xb),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x18));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xc),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1a));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xd),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1c));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xe),
-			     A_C_00000000, A_C_00000000);
-			gpr_map[gpr++] = 0x00000000;
-			snd_emu10k1_audigy_dsp_convert_32_to_2x16(icode, &ptr, tmp,
-								  bit_shifter16,
-								  A_GPR(gpr - 1),
-								  A_FXBUS2(0x1e));
-			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 1), A_P16VIN(0xf),
-			     A_C_00000000, A_C_00000000);
+			/* A_P16VIN(0) is delayed by one sample, so all other A_P16VIN channels
+			 * will need to also be delayed; we use an auxiliary register for that. */
+			for (z = 1; z < 0x10; z++) {
+				snd_emu10k1_audigy_dsp_convert_32_to_2x16( icode, &ptr, tmp, bit_shifter16, A_GPR(gpr), A_FXBUS2(z * 2) );
+				A_OP(icode, &ptr, iACC3, A_GPR(gpr), A_P16VIN(z), A_C_00000000, A_C_00000000);
+				gpr_map[gpr++] = 0x00000000;
+			}
 		}
 
 #if 0
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f22c6387adbd..0bc3f3f1b8a7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -120,6 +120,7 @@ struct alc_spec {
 	unsigned int ultra_low_power:1;
 	unsigned int has_hs_key:1;
 	unsigned int no_internal_mic_pin:1;
+	unsigned int en_3kpull_low:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -3616,6 +3617,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	if (!hp_pin)
 		hp_pin = 0x21;
 
+	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x1); /* Low power */
 	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
 
 	if (hp_pin_sense)
@@ -3632,8 +3634,7 @@ static void alc256_shutup(struct hda_codec *codec)
 	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
 	 * when booting with headset plugged. So skip setting it for the codec alc257
 	 */
-	if (codec->core.vendor_id != 0x10ec0236 &&
-	    codec->core.vendor_id != 0x10ec0257)
+	if (spec->en_3kpull_low)
 		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (!spec->no_shutup_pins)
@@ -4616,6 +4617,21 @@ static void alc236_fixup_hp_mute_led_coefbit(struct hda_codec *codec,
 	}
 }
 
+static void alc236_fixup_hp_mute_led_coefbit2(struct hda_codec *codec,
+					  const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x07;
+		spec->mute_led_coef.mask = 1;
+		spec->mute_led_coef.on = 1;
+		spec->mute_led_coef.off = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -6934,6 +6950,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
+	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
@@ -8307,6 +8324,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_mute_led,
 	},
+	[ALC236_FIXUP_HP_MUTE_LED_COEFBIT2] = {
+	    .type = HDA_FIXUP_FUNC,
+	    .v.func = alc236_fixup_hp_mute_led_coefbit2,
+	},
 	[ALC236_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_gpio_led,
@@ -9067,6 +9088,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x886d, "HP ZBook Fury 17.3 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
+	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
@@ -9206,6 +9228,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x5157, "Clevo W517GU1", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51a1, "Clevo NS50MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x51b1, "Clevo NS50AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x51b3, "Clevo NS70AU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x5630, "Clevo NP50RNJS", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70a1, "Clevo NB70T[HJK]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x70b3, "Clevo NK70SB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
@@ -10146,6 +10169,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
+		if (codec->bus->pci->vendor == PCI_VENDOR_ID_AMD)
+			spec->en_3kpull_low = true;
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;
diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 405128ccb4b0..26f26f442d7c 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1370,7 +1370,7 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 		return ERR_PTR(-EINVAL);
 	}
 
-	mbhc = devm_kzalloc(dev, sizeof(*mbhc), GFP_KERNEL);
+	mbhc = kzalloc(sizeof(*mbhc), GFP_KERNEL);
 	if (!mbhc)
 		return ERR_PTR(-ENOMEM);
 
@@ -1390,61 +1390,76 @@ struct wcd_mbhc *wcd_mbhc_init(struct snd_soc_component *component,
 
 	INIT_WORK(&mbhc->correct_plug_swch, wcd_correct_swch_plug);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_sw_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_sw_intr, NULL,
 					wcd_mbhc_mech_plug_detect_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"mbhc sw intr", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_mbhc;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_press_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_press_intr, NULL,
 					wcd_mbhc_btn_press_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Press detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_sw_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_btn_release_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_btn_release_intr, NULL,
 					wcd_mbhc_btn_release_handler,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Button Release detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_press_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_ins_intr, NULL,
 					wcd_mbhc_adc_hs_ins_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Insert", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_btn_release_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_ins_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->mbhc_hs_rem_intr, NULL,
 					wcd_mbhc_adc_hs_rem_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"Elect Remove", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_ins_intr;
 
 	disable_irq_nosync(mbhc->intr_ids->mbhc_hs_rem_intr);
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_left_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_left_ocp, NULL,
 					wcd_mbhc_hphl_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_L OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hs_rem_intr;
 
-	ret = devm_request_threaded_irq(dev, mbhc->intr_ids->hph_right_ocp, NULL,
+	ret = request_threaded_irq(mbhc->intr_ids->hph_right_ocp, NULL,
 					wcd_mbhc_hphr_ocp_irq,
 					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 					"HPH_R OCP detect", mbhc);
 	if (ret)
-		goto err;
+		goto err_free_hph_left_ocp;
 
 	return mbhc;
-err:
+
+err_free_hph_left_ocp:
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+err_free_hs_rem_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+err_free_hs_ins_intr:
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+err_free_btn_release_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+err_free_btn_press_intr:
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+err_free_sw_intr:
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+err_free_mbhc:
+	kfree(mbhc);
+
 	dev_err(dev, "Failed to request mbhc interrupts %d\n", ret);
 
 	return ERR_PTR(ret);
@@ -1453,9 +1468,19 @@ EXPORT_SYMBOL(wcd_mbhc_init);
 
 void wcd_mbhc_deinit(struct wcd_mbhc *mbhc)
 {
+	free_irq(mbhc->intr_ids->hph_right_ocp, mbhc);
+	free_irq(mbhc->intr_ids->hph_left_ocp, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_rem_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_hs_ins_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_release_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_btn_press_intr, mbhc);
+	free_irq(mbhc->intr_ids->mbhc_sw_intr, mbhc);
+
 	mutex_lock(&mbhc->lock);
 	wcd_cancel_hs_detect_plug(mbhc,	&mbhc->correct_plug_swch);
 	mutex_unlock(&mbhc->lock);
+
+	kfree(mbhc);
 }
 EXPORT_SYMBOL(wcd_mbhc_deinit);
 
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 4ca52d9db23a..94ffd2ba29ae 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3044,6 +3044,17 @@ static int wcd934x_mbhc_init(struct snd_soc_component *component)
 
 	return 0;
 }
+
+static void wcd934x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd934x_codec *wcd = snd_soc_component_get_drvdata(component);
+
+	if (!wcd->mbhc)
+		return;
+
+	wcd_mbhc_deinit(wcd->mbhc);
+}
+
 static int wcd934x_comp_probe(struct snd_soc_component *component)
 {
 	struct wcd934x_codec *wcd = dev_get_drvdata(component->dev);
@@ -3077,6 +3088,7 @@ static void wcd934x_comp_remove(struct snd_soc_component *comp)
 {
 	struct wcd934x_codec *wcd = dev_get_drvdata(comp->dev);
 
+	wcd934x_mbhc_deinit(comp);
 	wcd_clsh_ctrl_free(wcd->clsh_ctrl);
 }
 
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index b95cbae58641..8a7c8e81cba5 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3621,6 +3621,8 @@ static int wcd938x_mbhc_init(struct snd_soc_component *component)
 						     WCD938X_IRQ_HPHR_OCP_INT);
 
 	wcd938x->wcd_mbhc = wcd_mbhc_init(component, &mbhc_cb, intr_ids, wcd_mbhc_fields, true);
+	if (IS_ERR(wcd938x->wcd_mbhc))
+		return PTR_ERR(wcd938x->wcd_mbhc);
 
 	snd_soc_add_component_controls(component, impedance_detect_controls,
 				       ARRAY_SIZE(impedance_detect_controls));
@@ -3629,6 +3631,14 @@ static int wcd938x_mbhc_init(struct snd_soc_component *component)
 
 	return 0;
 }
+
+static void wcd938x_mbhc_deinit(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd_mbhc_deinit(wcd938x->wcd_mbhc);
+}
+
 /* END MBHC */
 
 static const struct snd_kcontrol_new wcd938x_snd_controls[] = {
@@ -4076,16 +4086,33 @@ static int wcd938x_irq_init(struct wcd938x_priv *wcd, struct device *dev)
 static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 {
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+	struct sdw_slave *tx_sdw_dev = wcd938x->tx_sdw_dev;
 	struct device *dev = component->dev;
+	unsigned long time_left;
 	int ret, i;
 
+	time_left = wait_for_completion_timeout(&tx_sdw_dev->initialization_complete,
+						msecs_to_jiffies(2000));
+	if (!time_left) {
+		dev_err(dev, "soundwire device init timeout\n");
+		return -ETIMEDOUT;
+	}
+
 	snd_soc_component_init_regmap(component, wcd938x->regmap);
 
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
 	wcd938x->variant = snd_soc_component_read_field(component,
 						 WCD938X_DIGITAL_EFUSE_REG_0,
 						 WCD938X_ID_MASK);
 
 	wcd938x->clsh_info = wcd_clsh_ctrl_alloc(component, WCD938X);
+	if (IS_ERR(wcd938x->clsh_info)) {
+		pm_runtime_put(dev);
+		return PTR_ERR(wcd938x->clsh_info);
+	}
 
 	wcd938x_io_init(wcd938x);
 	/* Set all interrupts as edge triggered */
@@ -4094,6 +4121,8 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			     (WCD938X_DIGITAL_INTR_LEVEL_0 + i), 0);
 	}
 
+	pm_runtime_put(dev);
+
 	wcd938x->hphr_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
 						       WCD938X_IRQ_HPHR_PDM_WD_INT);
 	wcd938x->hphl_pdm_wd_int = regmap_irq_get_virq(wcd938x->irq_chip,
@@ -4105,20 +4134,26 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	ret = request_threaded_irq(wcd938x->hphr_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHR PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHR WD interrupt (%d)\n", ret);
+		goto err_free_clsh_ctrl;
+	}
 
 	ret = request_threaded_irq(wcd938x->hphl_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "HPHL PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request HPHL WD interrupt (%d)\n", ret);
+		goto err_free_hphr_pdm_wd_int;
+	}
 
 	ret = request_threaded_irq(wcd938x->aux_pdm_wd_int, NULL, wcd938x_wd_handle_irq,
 				   IRQF_ONESHOT | IRQF_TRIGGER_RISING,
 				   "AUX PDM WD INT", wcd938x);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "Failed to request Aux WD interrupt (%d)\n", ret);
+		goto err_free_hphl_pdm_wd_int;
+	}
 
 	/* Disable watchdog interrupt for HPH and AUX */
 	disable_irq_nosync(wcd938x->hphr_pdm_wd_int);
@@ -4133,7 +4168,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	case WCD9385:
@@ -4143,7 +4178,7 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 			dev_err(component->dev,
 				"%s: Failed to add snd ctrls for variant: %d\n",
 				__func__, wcd938x->variant);
-			goto err;
+			goto err_free_aux_pdm_wd_int;
 		}
 		break;
 	default:
@@ -4151,12 +4186,38 @@ static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
 	}
 
 	ret = wcd938x_mbhc_init(component);
-	if (ret)
+	if (ret) {
 		dev_err(component->dev,  "mbhc initialization failed\n");
-err:
+		goto err_free_aux_pdm_wd_int;
+	}
+
+	return 0;
+
+err_free_aux_pdm_wd_int:
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+err_free_hphl_pdm_wd_int:
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+err_free_hphr_pdm_wd_int:
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+err_free_clsh_ctrl:
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+
 	return ret;
 }
 
+static void wcd938x_soc_codec_remove(struct snd_soc_component *component)
+{
+	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
+
+	wcd938x_mbhc_deinit(component);
+
+	free_irq(wcd938x->aux_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphl_pdm_wd_int, wcd938x);
+	free_irq(wcd938x->hphr_pdm_wd_int, wcd938x);
+
+	wcd_clsh_ctrl_free(wcd938x->clsh_info);
+}
+
 static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 				  struct snd_soc_jack *jack, void *data)
 {
@@ -4173,6 +4234,7 @@ static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
 static const struct snd_soc_component_driver soc_codec_dev_wcd938x = {
 	.name = "wcd938x_codec",
 	.probe = wcd938x_soc_codec_probe,
+	.remove = wcd938x_soc_codec_remove,
 	.controls = wcd938x_snd_controls,
 	.num_controls = ARRAY_SIZE(wcd938x_snd_controls),
 	.dapm_widgets = wcd938x_dapm_widgets,
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 6a12cbd43084..59dffa5ff34f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -560,7 +560,7 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	u32 xcsr, count = 100;
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
-			   FSL_SAI_CSR_TERE, 0);
+			   FSL_SAI_CSR_TERE | FSL_SAI_CSR_BCE, 0);
 
 	/* TERE will remain set till the end of current frame */
 	do {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 93da86009c75..f8c9a8fb7898 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -87,6 +87,7 @@
 /* SAI Transmit/Receive Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
 #define FSL_SAI_CSR_SE		BIT(30)
+#define FSL_SAI_CSR_BCE		BIT(28)
 #define FSL_SAI_CSR_FR		BIT(25)
 #define FSL_SAI_CSR_SR		BIT(24)
 #define FSL_SAI_CSR_xF_SHIFT	16
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 2c30a2b577d3..973c0d5ed8d8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -143,9 +143,9 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  OPENCSDLIBS += -lopencsd -lstdc++
+  OPENCSDLIBS += -lstdc++
 endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
new file mode 100644
index 000000000000..00d2e0e2e0c2
--- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res = 0;
+  for (j = 0; j < i && j < t->c; j++)
+    res += t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c = argc;
+  g.p = j;
+  for (i = 0; i < argc; i++)
+    j[i] = (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup
diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index b71828df5a6d..db1dcc139d34 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -5,6 +5,8 @@ CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
 CONFIG_NF_CONNTRACK_ZONES=y
 CONFIG_NF_CONNTRACK_LABELS=y
+CONFIG_NF_CONNTRACK_PROCFS=y
+CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_NAT=m
 
 CONFIG_NET_SCHED=y
diff --git a/tools/testing/selftests/tc-testing/settings b/tools/testing/selftests/tc-testing/settings
new file mode 100644
index 000000000000..e2206265f67c
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/settings
@@ -0,0 +1 @@
+timeout=900
