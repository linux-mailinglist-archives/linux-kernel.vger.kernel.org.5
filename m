Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A814D7DE0F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjKAMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjKAMgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:36:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B8102;
        Wed,  1 Nov 2023 05:36:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso91909961fa.2;
        Wed, 01 Nov 2023 05:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842177; x=1699446977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRX5uTFLbO4Wmit6kA5EoOhPJB2KsDU8T8igmGGFiYo=;
        b=eTyQNM4TbujW/4ofhdBY8MDrF3n/mI+90KkBndBj++0WJ4dQ1EiD6nStPxXkRR/rGP
         HADw8QVYgwxlQmPY5X7cAaML3o03CQH8THM+bGgiAikbixHknOWlcnggfhabdGFIOLso
         2SRuWWpFl0TDcCzkHDfWuqrPdBBCJKiIfDFXSffLDGioOBlq4xEQdH/xaiuQZbg5g0k3
         M8kq6p7NN5g+ffGbz/vG8jl2uHH4TQK9RL+Pox2ckORODs1VASetDe/3/VW+wl8r5Klu
         xZvwSMxsSUiHZ8vwQGLnL/nn7ahPaQuhQZLnjbUHSe/JbDnRB9TQ0ymWzMfSrKz/WhIi
         FHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842177; x=1699446977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRX5uTFLbO4Wmit6kA5EoOhPJB2KsDU8T8igmGGFiYo=;
        b=FgRMmRPlCWFOqiMzDPIHFCxcCM1R+YaAN/i2JJg2JLiEK7iYLrd7SxxNzMk7Lj9wYV
         QUEBvw6EvmX+LzrDiFf6REjq1suXrbvx8Gud7pBuSjHaejlbKlh5RlCMZWoRamReqDlI
         dZnP5QW2owtwZxAQCL622RAiPfJ945Dg7ilmnLL0TQGbdG/mFlEBk6a9P8KYAKcqVXGf
         e9BCPPcwBMgOV+Ec/MJUHsnDOv5jK4oFBGs68HIPufkfBYXB679zoqmUauxFvyLFkE7p
         frPLxxEugDNHcvRhLS3u1Jd+maDT5DX1GyhQQCE/EuobOiwP3uaRSAacxNlVDAW9oj7Z
         xZaQ==
X-Gm-Message-State: AOJu0YxmwQQshFxFRUj7kbWcfIbNB/Kk8oFKli2LAlIpHGQJgaUivjVC
        G+frGCcYVeX7IXa4oa3TlWI=
X-Google-Smtp-Source: AGHT+IHhbziGbgQM+X1IATbsZkrXAb17mPFbejeSsva77kvshY3ZjpdtHzYXt1zNW0imkNmjjrVopw==
X-Received: by 2002:a2e:8048:0:b0:2c5:b87:39bc with SMTP id p8-20020a2e8048000000b002c50b8739bcmr11843914ljg.1.1698842176891;
        Wed, 01 Nov 2023 05:36:16 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r6-20020a05600c458600b00405959bbf4fsm1449832wmo.19.2023.11.01.05.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:36:16 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load support
Date:   Wed,  1 Nov 2023 13:36:07 +0100
Message-Id: <20231101123608.11157-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Marko <robimarko@gmail.com>

Aquantia PHY-s require firmware to be loaded before they start operating.
It can be automatically loaded in case when there is a SPI-NOR connected
to Aquantia PHY-s or can be loaded from the host via MDIO.

This patch adds support for loading the firmware via MDIO as in most cases
there is no SPI-NOR being used to save on cost.
Firmware loading code itself is ported from mainline U-boot with cleanups.

The firmware has mixed values both in big and little endian.
PHY core itself is big-endian but it expects values to be in little-endian.
The firmware is little-endian but CRC-16 value for it is stored at the end
of firmware in big-endian.

It seems the PHY does the conversion internally from firmware that is
little-endian to the PHY that is big-endian on using the mailbox
but mailbox returns a big-endian CRC-16 to verify the written data
integrity.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Move out of RFC
- Address sanity check for offsets
- Add additional comments on firmware load check
- Fix some typo
- Capitalize CRC in comments
- Rename load_sysfs to load_fs

 drivers/net/phy/Kconfig         |   1 +
 drivers/net/phy/aquantia_main.c | 304 ++++++++++++++++++++++++++++++++
 2 files changed, 305 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 421d2b62918f..46c7194efcea 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -98,6 +98,7 @@ config ADIN1100_PHY
 
 config AQUANTIA_PHY
 	tristate "Aquantia PHYs"
+	select CRC_CCITT
 	help
 	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
 
diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 334a6904ca5a..0f1b8d75cca0 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -12,6 +12,10 @@
 #include <linux/delay.h>
 #include <linux/bitfield.h>
 #include <linux/phy.h>
+#include <linux/of.h>
+#include <linux/firmware.h>
+#include <linux/crc-ccitt.h>
+#include <linux/nvmem-consumer.h>
 
 #include "aquantia.h"
 
@@ -92,10 +96,40 @@
 #define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
 
 /* Vendor specific 1, MDIO_MMD_VEND1 */
+#define VEND1_GLOBAL_SC				0x0
+#define VEND1_GLOBAL_SC_SOFT_RESET		BIT(15)
+#define VEND1_GLOBAL_SC_LOW_POWER		BIT(11)
+
 #define VEND1_GLOBAL_FW_ID			0x0020
 #define VEND1_GLOBAL_FW_ID_MAJOR		GENMASK(15, 8)
 #define VEND1_GLOBAL_FW_ID_MINOR		GENMASK(7, 0)
 
+#define VEND1_GLOBAL_MAILBOX_INTERFACE1			0x0200
+#define VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE		BIT(15)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE		BIT(14)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET	BIT(12)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE1_BUSY		BIT(8)
+
+#define VEND1_GLOBAL_MAILBOX_INTERFACE2			0x0201
+#define VEND1_GLOBAL_MAILBOX_INTERFACE3			0x0202
+#define VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR_MASK	GENMASK(15, 0)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR_MASK, (u16)((x) >> 16))
+#define VEND1_GLOBAL_MAILBOX_INTERFACE4			0x0203
+#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK	GENMASK(15, 2)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR_MASK, (u16)(x))
+
+#define VEND1_GLOBAL_MAILBOX_INTERFACE5			0x0204
+#define VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA_MASK	GENMASK(15, 0)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA_MASK, (u16)((x) >> 16))
+#define VEND1_GLOBAL_MAILBOX_INTERFACE6			0x0205
+#define VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA_MASK	GENMASK(15, 0)
+#define VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(x)	FIELD_PREP(VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA_MASK, (u16)(x))
+
+#define VEND1_GLOBAL_CONTROL2			0xc001
+#define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_RST	BIT(15)
+#define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD	BIT(6)
+#define VEND1_GLOBAL_CONTROL2_UP_RUN_STALL	BIT(0)
+
 #define VEND1_GLOBAL_GEN_STAT2			0xc831
 #define VEND1_GLOBAL_GEN_STAT2_OP_IN_PROG	BIT(15)
 
@@ -152,6 +186,30 @@
 #define AQR107_OP_IN_PROG_SLEEP		1000
 #define AQR107_OP_IN_PROG_TIMEOUT	100000
 
+#define UP_RESET_SLEEP		100
+
+/* addresses of memory segments in the phy */
+#define DRAM_BASE_ADDR		0x3FFE0000
+#define IRAM_BASE_ADDR		0x40000000
+
+/* firmware image format constants */
+#define VERSION_STRING_SIZE		0x40
+#define VERSION_STRING_OFFSET		0x0200
+/* primary offset is written at an offset from the start of the fw blob */
+#define PRIMARY_OFFSET_OFFSET		0x8
+/* primary offset needs to be then added to a base offset */
+#define PRIMARY_OFFSET_SHIFT		12
+#define PRIMARY_OFFSET(x)		((x) << PRIMARY_OFFSET_SHIFT)
+#define HEADER_OFFSET			0x300
+
+struct aqr_fw_header {
+	u32 padding;
+	u8 iram_offset[3];
+	u8 iram_size[3];
+	u8 dram_offset[3];
+	u8 dram_size[3];
+} __packed;
+
 struct aqr107_hw_stat {
 	const char *name;
 	int reg;
@@ -677,6 +735,166 @@ static int aqr107_wait_processor_intensive_op(struct phy_device *phydev)
 	return 0;
 }
 
+/* load data into the phy's memory */
+static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
+				const u8 *data, size_t len)
+{
+	u16 crc = 0, up_crc;
+	size_t pos;
+
+	/* PHY expect addr in LE */
+	addr = cpu_to_le32(addr);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1,
+		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
+		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1,
+		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
+		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
+	phy_write_mmd(phydev, MDIO_MMD_VEND1,
+		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
+		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));
+
+	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
+		u32 word = 0;
+
+		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
+			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE6,
+			      VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(word));
+
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE1,
+			      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
+			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
+
+		/* calculate CRC as we load data to the mailbox.
+		 * We convert word to big-endiang as PHY is BE and mailbox will
+		 * return a BE CRC.
+		 */
+		word = cpu_to_be32(word);
+		crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
+	}
+
+	up_crc = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE2);
+	if (crc != up_crc) {
+		phydev_err(phydev, "CRC mismatch: calculated 0x%04x PHY 0x%04x\n",
+			   crc, up_crc);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size)
+{
+	const struct aqr_fw_header *header;
+	u32 iram_offset = 0, iram_size = 0;
+	u32 dram_offset = 0, dram_size = 0;
+	char version[VERSION_STRING_SIZE];
+	u16 calculated_crc, read_crc;
+	u32 primary_offset = 0;
+	int ret;
+
+	/* extract saved CRC at the end of the fw */
+	memcpy(&read_crc, data + size - 2, sizeof(read_crc));
+	/* CRC is saved in big-endian as PHY is BE */
+	read_crc = be16_to_cpu(read_crc);
+	calculated_crc = crc_ccitt_false(0, data, size - 2);
+	if (read_crc != calculated_crc) {
+		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
+			   read_crc, calculated_crc);
+		return -EINVAL;
+	}
+
+	/* Get the primary offset to extract DRAM and IRAM sections. */
+	memcpy(&primary_offset, data + PRIMARY_OFFSET_OFFSET, sizeof(u16));
+	if (!primary_offset) {
+		phydev_err(phydev, "bad primary offset in firmware\n");
+		return -EINVAL;
+	}
+	primary_offset = PRIMARY_OFFSET(le32_to_cpu(primary_offset));
+
+	/* Find the DRAM and IRAM sections within the firmware file. */
+	header = (struct aqr_fw_header *)(data + primary_offset + HEADER_OFFSET);
+	memcpy(&iram_offset, &header->iram_offset, sizeof(u8) * 3);
+	if (!iram_offset) {
+		phydev_err(phydev, "bad iram offset in firmware\n");
+		return -EINVAL;
+	}
+	memcpy(&iram_size, &header->iram_size, sizeof(u8) * 3);
+	if (!iram_size) {
+		phydev_err(phydev, "invalid iram size in firmware\n");
+		return -EINVAL;
+	}
+	memcpy(&dram_offset, &header->dram_offset, sizeof(u8) * 3);
+	if (!dram_offset) {
+		phydev_err(phydev, "bad dram offset in firmware\n");
+		return -EINVAL;
+	}
+	memcpy(&dram_size, &header->dram_size, sizeof(u8) * 3);
+	if (!dram_size) {
+		phydev_err(phydev, "invalid dram size in firmware\n");
+		return -EINVAL;
+	}
+
+	/* offset are in LE and values needs to be converted to cpu endian */
+	iram_offset = le32_to_cpu(iram_offset);
+	iram_size = le32_to_cpu(iram_size);
+	dram_offset = le32_to_cpu(dram_offset);
+	dram_size = le32_to_cpu(dram_size);
+
+	/* Increment the offset with the primary offset. */
+	iram_offset += primary_offset;
+	dram_offset += primary_offset;
+
+	phydev_dbg(phydev, "primary %d IRAM offset=%d size=%d DRAM offset=%d size=%d\n",
+		   primary_offset, iram_offset, iram_size, dram_offset, dram_size);
+
+	strscpy(version, (char *)data + dram_offset + VERSION_STRING_OFFSET,
+		VERSION_STRING_SIZE);
+	if (!version) {
+		phydev_err(phydev, "invalid version in firmware\n");
+		return -EINVAL;
+	}
+	phydev_info(phydev, "loading firmware version '%s'\n", version);
+
+	/* stall the microcprocessor */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
+		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL | VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD);
+
+	phydev_dbg(phydev, "loading DRAM 0x%08x from offset=%d size=%d\n",
+		   DRAM_BASE_ADDR, dram_offset, dram_size);
+	ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR, data + dram_offset,
+				   dram_size);
+	if (ret)
+		return ret;
+
+	phydev_dbg(phydev, "loading IRAM 0x%08x from offset=%d size=%d\n",
+		   IRAM_BASE_ADDR, iram_offset, iram_size);
+	ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR, data + iram_offset,
+				   iram_size);
+	if (ret)
+		return ret;
+
+	/* make sure soft reset and low power mode are clear */
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_SC,
+			   VEND1_GLOBAL_SC_SOFT_RESET | VEND1_GLOBAL_SC_LOW_POWER);
+
+	/* Release the microprocessor. UP_RESET must be held for 100 usec. */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
+		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL |
+		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD |
+		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_RST);
+	usleep_range(UP_RESET_SLEEP, UP_RESET_SLEEP * 2);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
+		      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD);
+
+	return 0;
+}
+
 static int aqr107_get_rate_matching(struct phy_device *phydev,
 				    phy_interface_t iface)
 {
@@ -711,13 +929,99 @@ static int aqr107_resume(struct phy_device *phydev)
 	return aqr107_wait_processor_intensive_op(phydev);
 }
 
+static int aqr_firmware_load_nvmem(struct phy_device *phydev)
+{
+	struct nvmem_cell *cell;
+	size_t size;
+	u8 *buf;
+	int ret;
+
+	cell = nvmem_cell_get(&phydev->mdio.dev, "firmware");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &size);
+	if (IS_ERR(buf)) {
+		ret = PTR_ERR(buf);
+		goto exit;
+	}
+
+	ret = aqr_fw_boot(phydev, buf, size);
+	if (ret)
+		phydev_err(phydev, "firmware loading failed: %d\n", ret);
+
+exit:
+	nvmem_cell_put(cell);
+
+	return ret;
+}
+
+static int aqr_firmware_load_fs(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	const struct firmware *fw;
+	const char *fw_name;
+	int ret;
+
+	ret = of_property_read_string(dev->of_node, "firmware-name",
+				      &fw_name);
+	if (ret)
+		return ret;
+
+	ret = request_firmware(&fw, fw_name, dev);
+	if (ret) {
+		phydev_err(phydev, "failed to find FW file %s (%d)\n",
+			   fw_name, ret);
+		goto exit;
+	}
+
+	ret = aqr_fw_boot(phydev, fw->data, fw->size);
+	if (ret)
+		phydev_err(phydev, "firmware loading failed: %d\n", ret);
+
+exit:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int aqr_firmware_load(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Check if the firmware is not already loaded by pooling
+	 * the current version returned by the PHY. If 0 is returned,
+	 * no firmware is loaded.
+	 */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
+	if (ret > 0)
+		goto exit;
+
+	ret = aqr_firmware_load_nvmem(phydev);
+	if (!ret)
+		goto exit;
+
+	ret = aqr_firmware_load_fs(phydev);
+	if (ret)
+		return ret;
+
+exit:
+	return 0;
+}
+
 static int aqr107_probe(struct phy_device *phydev)
 {
+	int ret;
+
 	phydev->priv = devm_kzalloc(&phydev->mdio.dev,
 				    sizeof(struct aqr107_priv), GFP_KERNEL);
 	if (!phydev->priv)
 		return -ENOMEM;
 
+	ret = aqr_firmware_load(phydev);
+	if (ret)
+		return ret;
+
 	return aqr_hwmon_probe(phydev);
 }
 
-- 
2.40.1

