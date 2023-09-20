Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F767A8CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjITT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjITT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7524A1A4;
        Wed, 20 Sep 2023 12:29:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c007d6159aso2387061fa.3;
        Wed, 20 Sep 2023 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238141; x=1695842941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyWc+rqkVGRwEwvNukmSeBhnWN0IDxv9BejmAkmAVHI=;
        b=NSY71lbc6z0w8Du1Rgi2hiG3+N11VLPiYHAiAz5YJlRGUaXAm/Q3ADL3HK7X1xEtYA
         PFJXsIBHzJfDYmOYaty831K/aIsIJsSzdIugyACS2QwYgrP9e+/uKoCZZgLYpJEsyStA
         IWnT/bypVbCBfVM6GYcgMNsZuxsaXWaI4NEhCXU8V5a7Hc8XZQQuSl/hWPud6dTYLd3X
         MFfr4RlU0tnFscmuOSDDqWOfeALLqYQ7GcO9683HEV5Khz574O9ApsXJCkQUaIGR9s0M
         P7Gy7LBaY+0HPbzvBj5UCCaE2cIeJHoO4f7Fz3yy9Ubi+kSXFS7ffY9E3TxOgOp7Qp8P
         0OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238141; x=1695842941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyWc+rqkVGRwEwvNukmSeBhnWN0IDxv9BejmAkmAVHI=;
        b=gwDK5z9mnaEWhmyOh0m4g7AC+4PUuiKddgwCA9xDv90Lejj5l7hl8q2iAmV87RQn1Q
         IjGdchv5B+26YRDALvZSYLjbKV01+AkoE0TtFeRyi/o3Mv5YChT1q8ui2Lwi1msHJ4g6
         +yeRXxP0lxlBdKhmcudekyvhyZs8HlbmejiarGpFd92Z74R115lH9BWY6D8awIjF2jil
         KBrpbT3/sn0sLFfWpkuEchpDlpRUGgck0R3ONfoq0uJmfn3EcIq0fmdRlvdr4njnU4bK
         ygzd8CKn6EZHWOCebiBFwnlmEAfZB8HB7SoVrxdc86SXVMbBmwxr/HHW5zpTeNrvnyrZ
         J54g==
X-Gm-Message-State: AOJu0YwmrkJEsNsxg45M3fEW5v1nsdS0G4MZw0icGEjiIJ6qSD9WMLXW
        0Aa8MC2PP2ORIuqDnxwgYp8=
X-Google-Smtp-Source: AGHT+IEpTykgcLIH+idrJB48K2nb7IZC4Rc3s6pqC54gb+zNS9FJz8ftJFzd+shjXK6WP/7b6om5tg==
X-Received: by 2002:a2e:7410:0:b0:2bf:b133:dd65 with SMTP id p16-20020a2e7410000000b002bfb133dd65mr3011859ljc.38.1695238141089;
        Wed, 20 Sep 2023 12:29:01 -0700 (PDT)
Received: from localhost ([85.140.0.70])
        by smtp.gmail.com with ESMTPSA id c3-20020a2e9483000000b002bcdbfe36a1sm3211616ljh.84.2023.09.20.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:29:00 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/18] EDAC/synopsys: Introduce System/SDRAM address translation interface
Date:   Wed, 20 Sep 2023 22:26:58 +0300
Message-ID: <20230920192806.29960-14-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the address translation is performed only in the framework of
the ECC poison procedures. The available infrastructure is utilized for
the device and driver debugging. Meanwhile it would be very useful to know
not only the SDRAM address of the runtime ECC errors, but the originating
system address accepted on the AXI/AHB ports of the DW uMCTL2 DDR
controller. In order to be able to do so the currently available
infrastructure needs to be properly updated.

First of all move it away from under the EDAC_DEBUG config, since it will
be always utilized by the driver. Secondly for the sake of the code
simplification split up the translation procedure into the next three
stages:
1. System<->Application address translation (just type cast for now).
2. Application<->HIF address translation (DQ-bus width based address
shift).
3. HIF<->SDRAM address translation (ADDRMAPx-based mapping).

The suggested implementation supports the 1->3 translation only in the
same way as it was before this modification (the backward address
translation will be added later). Semantically it's the same except the
next four aspects: ff-value is used as a marker of the unmapped HIF/SDRAM
bits instead of zero-value which in some cases is a valid mapping bit id;
DQ-width is used to perform the Application<->HIF address translation
instead of the fixed 64-bit DQ-bus width assumption; the HIF/SDRAM address
translation procedure searches through the whole dimensions width instead
of stopping at the first unmapped bit since in general some of the
row/column/bank/etc bits (especially the column bits, like b10) can be
left unmapped; the number of supported ranks is extended to four - maximum
possible value.

Note while at it the code is simplified a bit: encapsulate the mapping
table into a dedicated structure (snps_hif_sdram_map); use the FIELD_GET()
helper to get ADDRMAP CSR fields; define more descriptive max-value
macros.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 750 +++++++++++++++++++++--------------
 1 file changed, 453 insertions(+), 297 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 7376a0fc6394..204d7f1fc7e2 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -153,17 +153,28 @@
 #define ECC_CEPOISON_MASK		GENMASK(1, 0)
 #define ECC_UEPOISON_MASK		BIT(0)
 
-/* DDRC Device config shifts/masks */
-#define DDR_MAX_ROW_SHIFT		18
-#define DDR_MAX_COL_SHIFT		14
-#define DDR_MAX_BANK_SHIFT		3
-#define DDR_MAX_BANKGRP_SHIFT		2
-
-#define ROW_MAX_VAL_MASK		0xF
-#define COL_MAX_VAL_MASK		0xF
-#define BANK_MAX_VAL_MASK		0x1F
-#define BANKGRP_MAX_VAL_MASK		0x1F
-#define RANK_MAX_VAL_MASK		0x1F
+/* DDRC address mapping parameters */
+#define DDR_ADDRMAP_NREGS		12
+
+#define DDR_MAX_ROW_WIDTH		18
+#define DDR_MAX_COL_WIDTH		14
+#define DDR_MAX_BANK_WIDTH		3
+#define DDR_MAX_BANKGRP_WIDTH		2
+#define DDR_MAX_RANK_WIDTH		2
+
+#define DDR_ADDRMAP_B0_M15		GENMASK(3, 0)
+#define DDR_ADDRMAP_B8_M15		GENMASK(11, 8)
+#define DDR_ADDRMAP_B16_M15		GENMASK(19, 16)
+#define DDR_ADDRMAP_B24_M15		GENMASK(27, 24)
+
+#define DDR_ADDRMAP_B0_M31		GENMASK(4, 0)
+#define DDR_ADDRMAP_B8_M31		GENMASK(12, 8)
+#define DDR_ADDRMAP_B16_M31		GENMASK(20, 16)
+#define DDR_ADDRMAP_B24_M31		GENMASK(28, 24)
+
+#define DDR_ADDRMAP_UNUSED		((u8)-1)
+#define DDR_ADDRMAP_MAX_15		DDR_ADDRMAP_B0_M15
+#define DDR_ADDRMAP_MAX_31		DDR_ADDRMAP_B0_M31
 
 #define ROW_B0_BASE			6
 #define ROW_B1_BASE			7
@@ -205,6 +216,7 @@
 #define BANKGRP_B1_BASE			3
 
 #define RANK_B0_BASE			6
+#define RANK_B1_BASE			7
 
 /* ZynqMP DDR QOS Interrupt register definitions */
 #define ZYNQMP_DDR_QOS_UE_MASK		BIT(2)
@@ -296,6 +308,41 @@ struct snps_ddrc_info {
 	unsigned int ranks;
 };
 
+/**
+ * struct snps_hif_sdram_map - HIF/SDRAM mapping table.
+ * @row:	HIF bit offsets used as row address bits.
+ * @col:	HIF bit offsets used as column address bits.
+ * @bank:	HIF bit offsets used as bank address bits.
+ * @bankgrp:	HIF bit offsets used as bank group address bits.
+ * @rank:	HIF bit offsets used as rank address bits.
+ *
+ * For example, row[0] = 6 means row bit #0 is encoded by the HIF
+ * address bit #6 and vice-versa.
+ */
+struct snps_hif_sdram_map {
+	u8 row[DDR_MAX_ROW_WIDTH];
+	u8 col[DDR_MAX_COL_WIDTH];
+	u8 bank[DDR_MAX_BANK_WIDTH];
+	u8 bankgrp[DDR_MAX_BANKGRP_WIDTH];
+	u8 rank[DDR_MAX_RANK_WIDTH];
+};
+
+/**
+ * struct snps_sdram_addr - SDRAM address.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bankgrp:	Bank group number.
+ * @rank:	Rank number.
+ */
+struct snps_sdram_addr {
+	u16 row;
+	u16 col;
+	u8 bank;
+	u8 bankgrp;
+	u8 rank;
+};
+
 /**
  * struct snps_ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -335,20 +382,17 @@ struct snps_ecc_status {
 /**
  * struct snps_edac_priv - DDR memory controller private data.
  * @info:		DDR controller config info.
+ * @hif_sdram_map:	HIF/SDRAM mapping table.
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @poison_addr:	Data poison address.
- * @row_shift:		Bit shifts for row bit.
- * @col_shift:		Bit shifts for column bit.
- * @bank_shift:		Bit shifts for bank bit.
- * @bankgrp_shift:	Bit shifts for bank group bit.
- * @rank_shift:		Bit shifts for rank bit.
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
+	struct snps_hif_sdram_map hif_sdram_map;
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t reglock;
@@ -356,14 +400,97 @@ struct snps_edac_priv {
 	struct snps_ecc_status stat;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
-	u32 row_shift[18];
-	u32 col_shift[14];
-	u32 bank_shift[3];
-	u32 bankgrp_shift[2];
-	u32 rank_shift[1];
 #endif
 };
 
+/**
+ * snps_map_app_to_hif - Map Application address to HIF address.
+ * @priv:	DDR memory controller private instance data.
+ * @app:	Application address (source).
+ * @hif:	HIF address (destination).
+ *
+ * HIF address is used to perform the DQ bus width aligned burst transactions.
+ * So in order to perform the Application-to-HIF address translation we just
+ * need to discard the SDRAM-word bits of the Application address.
+ */
+static void snps_map_app_to_hif(struct snps_edac_priv *priv,
+				u64 app, u64 *hif)
+{
+	*hif = app >> priv->info.dq_width;
+}
+
+/**
+ * snps_map_hif_to_sdram - Map HIF address to SDRAM address.
+ * @priv:	DDR memory controller private instance data.
+ * @hif:	HIF address (source).
+ * @sdram:	SDRAM address (destination).
+ *
+ * HIF-SDRAM address mapping is configured with the ADDRMAPx registers, Based
+ * on the CSRs value the HIF address bits are mapped to the corresponding bits
+ * in the SDRAM rank/bank/column/row. If an SDRAM address bit is unused (there
+ * is no any HIF address bit corresponding to it) it will be set to zero. Using
+ * this fact we can freely set the output SDRAM address with zeros and walk
+ * over the set HIF address bits only. Similarly the unmapped HIF address bits
+ * are just ignored.
+ */
+static void snps_map_hif_to_sdram(struct snps_edac_priv *priv,
+				  u64 hif, struct snps_sdram_addr *sdram)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	sdram->row = 0;
+	for (i = 0; i < DDR_MAX_ROW_WIDTH; i++) {
+		if (map->row[i] != DDR_ADDRMAP_UNUSED && hif & BIT(map->row[i]))
+			sdram->row |= BIT(i);
+	}
+
+	sdram->col = 0;
+	for (i = 0; i < DDR_MAX_COL_WIDTH; i++) {
+		if (map->col[i] != DDR_ADDRMAP_UNUSED && hif & BIT(map->col[i]))
+			sdram->col |= BIT(i);
+	}
+
+	sdram->bank = 0;
+	for (i = 0; i < DDR_MAX_BANK_WIDTH; i++) {
+		if (map->bank[i] != DDR_ADDRMAP_UNUSED && hif & BIT(map->bank[i]))
+			sdram->bank |= BIT(i);
+	}
+
+	sdram->bankgrp = 0;
+	for (i = 0; i < DDR_MAX_BANKGRP_WIDTH; i++) {
+		if (map->bankgrp[i] != DDR_ADDRMAP_UNUSED && hif & BIT(map->bankgrp[i]))
+			sdram->bankgrp |= BIT(i);
+	}
+
+	sdram->rank = 0;
+	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
+		if (map->rank[i] != DDR_ADDRMAP_UNUSED && hif & BIT(map->rank[i]))
+			sdram->rank |= BIT(i);
+	}
+}
+
+/**
+ * snps_map_sys_to_sdram - Map System address to SDRAM address.
+ * @priv:	DDR memory controller private instance data.
+ * @sys:	System address (source).
+ * @sdram:	SDRAM address (destination).
+ *
+ * Perform a full mapping of the system address (detected on the controller
+ * ports) to the SDRAM address tuple row/column/bank/etc.
+ */
+static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
+				  dma_addr_t sys, struct snps_sdram_addr *sdram)
+{
+	u64 app, hif;
+
+	app = sys;
+
+	snps_map_app_to_hif(priv, app, &hif);
+
+	snps_map_hif_to_sdram(priv, hif, sdram);
+}
+
 /**
  * snps_get_bitpos - Get DQ-bus corrected bit position.
  * @syndrome:	Error syndrome.
@@ -755,6 +882,301 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 	return init_plat ? init_plat(priv) : 0;
 }
 
+/**
+ * snps_get_hif_row_map - Get HIF/SDRAM-row address map.
+ * @priv:	DDR memory controller private instance data.
+ * @addrmap:	Array with ADDRMAP registers value.
+ *
+ * SDRAM-row address is defined by the fields in the ADDRMAP[5-7,9-11]
+ * registers. Those fields value indicate the HIF address bits used to encode
+ * the DDR row address.
+ */
+static void snps_get_hif_row_map(struct snps_edac_priv *priv, u32 *addrmap)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	u8 map_row_b2_10;
+	int i;
+
+	for (i = 0; i < DDR_MAX_ROW_WIDTH; i++)
+		map->row[i] = DDR_ADDRMAP_UNUSED;
+
+	map->row[0] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[5]) + ROW_B0_BASE;
+	map->row[1] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[5]) + ROW_B1_BASE;
+
+	map_row_b2_10 = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[5]);
+	if (map_row_b2_10 != DDR_ADDRMAP_MAX_15) {
+		for (i = 2; i < 11; i++)
+			map->row[i] = map_row_b2_10 + i + ROW_B0_BASE;
+	} else {
+		map->row[2] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[9]) + ROW_B2_BASE;
+		map->row[3] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[9]) + ROW_B3_BASE;
+		map->row[4] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[9]) + ROW_B4_BASE;
+		map->row[5] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[9]) + ROW_B5_BASE;
+		map->row[6] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[10]) + ROW_B6_BASE;
+		map->row[7] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[10]) + ROW_B7_BASE;
+		map->row[8] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[10]) + ROW_B8_BASE;
+		map->row[9] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[10]) + ROW_B9_BASE;
+		map->row[10] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[11]) + ROW_B10_BASE;
+	}
+
+	map->row[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[5]);
+	map->row[11] = map->row[11] == DDR_ADDRMAP_MAX_15 ?
+		       DDR_ADDRMAP_UNUSED : map->row[11] + ROW_B11_BASE;
+
+	map->row[12] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[6]);
+	map->row[12] = map->row[12] == DDR_ADDRMAP_MAX_15 ?
+		       DDR_ADDRMAP_UNUSED : map->row[12] + ROW_B12_BASE;
+
+	map->row[13] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[6]);
+	map->row[13] = map->row[13] == DDR_ADDRMAP_MAX_15 ?
+		       DDR_ADDRMAP_UNUSED : map->row[13] + ROW_B13_BASE;
+
+	map->row[14] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[6]);
+	map->row[14] = map->row[14] == DDR_ADDRMAP_MAX_15 ?
+		       DDR_ADDRMAP_UNUSED : map->row[14] + ROW_B14_BASE;
+
+	map->row[15] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[6]);
+	map->row[15] = map->row[15] == DDR_ADDRMAP_MAX_15 ?
+		       DDR_ADDRMAP_UNUSED : map->row[15] + ROW_B15_BASE;
+
+	if (priv->info.sdram_mode == MEM_DDR4 || priv->info.sdram_mode == MEM_LPDDR4) {
+		map->row[16] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[7]);
+		map->row[16] = map->row[16] == DDR_ADDRMAP_MAX_15 ?
+			       DDR_ADDRMAP_UNUSED : map->row[16] + ROW_B16_BASE;
+
+		map->row[17] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[7]);
+		map->row[17] = map->row[17] == DDR_ADDRMAP_MAX_15 ?
+			       DDR_ADDRMAP_UNUSED : map->row[17] + ROW_B17_BASE;
+	}
+}
+
+/**
+ * snps_get_hif_col_map - Get HIF/SDRAM-column address map.
+ * @priv:	DDR memory controller private instance data.
+ * @addrmap:	Array with ADDRMAP registers value.
+ *
+ * SDRAM-column address is defined by the fields in the ADDRMAP[2-4]
+ * registers. Those fields value indicate the HIF address bits used to encode
+ * the DDR row address.
+ */
+static void snps_get_hif_col_map(struct snps_edac_priv *priv, u32 *addrmap)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	for (i = 0; i < DDR_MAX_COL_WIDTH; i++)
+		map->col[i] = DDR_ADDRMAP_UNUSED;
+
+	map->col[0] = 0;
+	map->col[1] = 1;
+	map->col[2] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[2]) + COL_B2_BASE;
+	map->col[3] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[2]) + COL_B3_BASE;
+
+	map->col[4] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[2]);
+	map->col[4] = map->col[4] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[4] + COL_B4_BASE;
+
+	map->col[5] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[2]);
+	map->col[5] = map->col[5] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[5] + COL_B5_BASE;
+
+	map->col[6] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[3]);
+	map->col[6] = map->col[6] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[6] + COL_B6_BASE;
+
+	map->col[7] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[3]);
+	map->col[7] = map->col[7] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[7] + COL_B7_BASE;
+
+	map->col[8] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
+	map->col[8] = map->col[8] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[8] + COL_B8_BASE;
+
+	map->col[9] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
+	map->col[9] = map->col[9] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[9] + COL_B9_BASE;
+
+	if (priv->info.dq_mode) {
+		for (i = 9; i > priv->info.dq_mode; i--) {
+			map->col[i] = map->col[i - priv->info.dq_mode];
+			map->col[i - priv->info.dq_mode] = DDR_ADDRMAP_UNUSED;
+		}
+	}
+
+	/*
+	 * Per JEDEC DDR2/3/4/mDDR specification, column address bit 10 is
+	 * reserved for indicating auto-precharge, and hence no source
+	 * address bit can be mapped to col[10].
+	 * Per JEDEC specification, column address bit 12 is reserved
+	 * for the Burst-chop status, so no source address bit mapping
+	 * for col[12] either.
+	 */
+	if (priv->info.dq_mode == SNPS_DQ_FULL) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
+			map->col[10] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
+			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B10_BASE;
+
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
+			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B11_BASE;
+		} else {
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
+			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B10_BASE;
+
+			map->col[13] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
+			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B11_BASE;
+		}
+	} else if (priv->info.dq_mode == SNPS_DQ_HALF) {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
+			map->col[10] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
+			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B9_BASE;
+
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
+			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B10_BASE;
+		} else {
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
+			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B9_BASE;
+
+			map->col[13] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
+			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B10_BASE;
+		}
+	} else {
+		if (priv->info.sdram_mode == MEM_LPDDR3) {
+			map->col[10] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
+			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B8_BASE;
+
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
+			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B9_BASE;
+		} else {
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
+			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B8_BASE;
+
+			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
+			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
+				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B9_BASE;
+		}
+	}
+}
+
+/**
+ * snps_get_hif_bank_map - Get HIF/SDRAM-bank address map.
+ * @priv:	DDR memory controller private instance data.
+ * @addrmap:	Array with ADDRMAP registers value.
+ *
+ * SDRAM-bank address is defined by the fields in the ADDRMAP[1]
+ * register. Those fields value indicate the HIF address bits used to encode
+ * the DDR bank address.
+ */
+static void snps_get_hif_bank_map(struct snps_edac_priv *priv, u32 *addrmap)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	for (i = 0; i < DDR_MAX_BANK_WIDTH; i++)
+		map->bank[i] = DDR_ADDRMAP_UNUSED;
+
+	map->bank[0] = FIELD_GET(DDR_ADDRMAP_B0_M31, addrmap[1]) + BANK_B0_BASE;
+	map->bank[1] = FIELD_GET(DDR_ADDRMAP_B8_M31, addrmap[1]) + BANK_B1_BASE;
+
+	map->bank[2] = FIELD_GET(DDR_ADDRMAP_B16_M31, addrmap[1]);
+	map->bank[2] = map->bank[2] == DDR_ADDRMAP_MAX_31 ?
+		       DDR_ADDRMAP_UNUSED : map->bank[2] + BANK_B2_BASE;
+}
+
+/**
+ * snps_get_hif_bankgrp_map - Get HIF/SDRAM-bank group address map.
+ * @priv:	DDR memory controller private instance data.
+ * @addrmap:	Array with ADDRMAP registers value.
+ *
+ * SDRAM-bank group address is defined by the fields in the ADDRMAP[8]
+ * register. Those fields value indicate the HIF address bits used to encode
+ * the DDR bank group address.
+ */
+static void snps_get_hif_bankgrp_map(struct snps_edac_priv *priv, u32 *addrmap)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	for (i = 0; i < DDR_MAX_BANKGRP_WIDTH; i++)
+		map->bankgrp[i] = DDR_ADDRMAP_UNUSED;
+
+	/* Bank group signals are available on the DDR4 memory only */
+	if (priv->info.sdram_mode != MEM_DDR4)
+		return;
+
+	map->bankgrp[0] = FIELD_GET(DDR_ADDRMAP_B0_M31, addrmap[8]) + BANKGRP_B0_BASE;
+
+	map->bankgrp[1] = FIELD_GET(DDR_ADDRMAP_B8_M31, addrmap[8]);
+	map->bankgrp[1] = map->bankgrp[1] == DDR_ADDRMAP_MAX_31 ?
+			  DDR_ADDRMAP_UNUSED : map->bankgrp[1] + BANKGRP_B1_BASE;
+}
+
+/**
+ * snps_get_hif_rank_map - Get HIF/SDRAM-rank address map.
+ * @priv:	DDR memory controller private instance data.
+ * @addrmap:	Array with ADDRMAP registers value.
+ *
+ * SDRAM-rank address is defined by the fields in the ADDRMAP[0]
+ * register. Those fields value indicate the HIF address bits used to encode
+ * the DDR rank address.
+ */
+static void snps_get_hif_rank_map(struct snps_edac_priv *priv, u32 *addrmap)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++)
+		map->rank[i] = DDR_ADDRMAP_UNUSED;
+
+	if (priv->info.ranks > 1) {
+		map->rank[0] = FIELD_GET(DDR_ADDRMAP_B0_M31, addrmap[0]);
+		map->rank[0] = map->rank[0] == DDR_ADDRMAP_MAX_31 ?
+			       DDR_ADDRMAP_UNUSED : map->rank[0] + RANK_B0_BASE;
+	}
+
+	if (priv->info.ranks > 2) {
+		map->rank[1] = FIELD_GET(DDR_ADDRMAP_B8_M31, addrmap[0]);
+		map->rank[1] = map->rank[1] == DDR_ADDRMAP_MAX_31 ?
+			       DDR_ADDRMAP_UNUSED : map->rank[1] + RANK_B1_BASE;
+	}
+}
+
+/**
+ * snps_get_addr_map - Get HIF/SDRAM/etc address map from CSRs.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Parse the controller registers content creating the addresses mapping tables.
+ * They will be used for the erroneous and poison addresses encode/decode.
+ */
+static void snps_get_addr_map(struct snps_edac_priv *priv)
+{
+	u32 regval[DDR_ADDRMAP_NREGS];
+	int i;
+
+	for (i = 0; i < DDR_ADDRMAP_NREGS; i++)
+		regval[i] = readl(priv->baseaddr + DDR_ADDRMAP0_OFST + i * 4);
+
+	snps_get_hif_row_map(priv, regval);
+
+	snps_get_hif_col_map(priv, regval);
+
+	snps_get_hif_bank_map(priv, regval);
+
+	snps_get_hif_bankgrp_map(priv, regval);
+
+	snps_get_hif_rank_map(priv, regval);
+}
+
 /**
  * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
@@ -940,285 +1362,21 @@ DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
  */
 static void snps_data_poison_setup(struct snps_edac_priv *priv)
 {
-	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
-	int index;
-	ulong hif_addr = 0;
-
-	hif_addr = priv->poison_addr >> 3;
-
-	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
-		if (priv->row_shift[index])
-			row |= (((hif_addr >> priv->row_shift[index]) &
-						BIT(0)) << index);
-		else
-			break;
-	}
-
-	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
-		if (priv->col_shift[index] || index < 3)
-			col |= (((hif_addr >> priv->col_shift[index]) &
-						BIT(0)) << index);
-		else
-			break;
-	}
-
-	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
-		if (priv->bank_shift[index])
-			bank |= (((hif_addr >> priv->bank_shift[index]) &
-						BIT(0)) << index);
-		else
-			break;
-	}
-
-	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
-		if (priv->bankgrp_shift[index])
-			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
-						& BIT(0)) << index);
-		else
-			break;
-	}
+	struct snps_sdram_addr sdram;
+	u32 regval;
 
-	if (priv->rank_shift[0])
-		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+	snps_map_sys_to_sdram(priv, priv->poison_addr, &sdram);
 
-	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, rank) |
-		 FIELD_PREP(ECC_POISON0_COL_MASK, col);
+	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, sdram.rank) |
+		 FIELD_PREP(ECC_POISON0_COL_MASK, sdram.col);
 	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
 
-	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, bankgrp) |
-		 FIELD_PREP(ECC_POISON1_BANK_MASK, bank) |
-		 FIELD_PREP(ECC_POISON1_ROW_MASK, row);
+	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, sdram.bankgrp) |
+		 FIELD_PREP(ECC_POISON1_BANK_MASK, sdram.bank) |
+		 FIELD_PREP(ECC_POISON1_ROW_MASK, sdram.row);
 	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 }
 
-static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap)
-{
-	u32 addrmap_row_b2_10;
-	int index;
-
-	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
-	priv->row_shift[1] = ((addrmap[5] >> 8) &
-			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
-
-	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
-	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
-		for (index = 2; index < 11; index++)
-			priv->row_shift[index] = addrmap_row_b2_10 +
-				index + ROW_B0_BASE;
-
-	} else {
-		priv->row_shift[2] = (addrmap[9] &
-				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
-		priv->row_shift[3] = ((addrmap[9] >> 8) &
-				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
-		priv->row_shift[4] = ((addrmap[9] >> 16) &
-				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
-		priv->row_shift[5] = ((addrmap[9] >> 24) &
-				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
-		priv->row_shift[6] = (addrmap[10] &
-				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
-		priv->row_shift[7] = ((addrmap[10] >> 8) &
-				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
-		priv->row_shift[8] = ((addrmap[10] >> 16) &
-				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
-		priv->row_shift[9] = ((addrmap[10] >> 24) &
-				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
-		priv->row_shift[10] = (addrmap[11] &
-				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
-	}
-
-	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
-				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
-	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
-				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
-	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
-				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
-	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
-				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
-	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
-				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
-
-	if (priv->info.sdram_mode == MEM_DDR4 || priv->info.sdram_mode == MEM_LPDDR4) {
-		priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
-					ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
-					ROW_MAX_VAL_MASK) + ROW_B16_BASE);
-		priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
-					ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
-					ROW_MAX_VAL_MASK) + ROW_B17_BASE);
-	}
-}
-
-static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
-{
-	int index;
-
-	priv->col_shift[0] = 0;
-	priv->col_shift[1] = 1;
-	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
-	priv->col_shift[3] = ((addrmap[2] >> 8) &
-			COL_MAX_VAL_MASK) + COL_B3_BASE;
-	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
-			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
-					COL_MAX_VAL_MASK) + COL_B4_BASE);
-	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
-			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
-					COL_MAX_VAL_MASK) + COL_B5_BASE);
-	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
-			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
-					COL_MAX_VAL_MASK) + COL_B6_BASE);
-	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
-			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
-					COL_MAX_VAL_MASK) + COL_B7_BASE);
-	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
-			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
-					COL_MAX_VAL_MASK) + COL_B8_BASE);
-	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
-			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
-					COL_MAX_VAL_MASK) + COL_B9_BASE);
-	if (priv->info.dq_mode == SNPS_DQ_FULL) {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			priv->col_shift[10] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
-			priv->col_shift[11] = (((addrmap[4] >> 8) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
-				 COL_B11_BASE);
-		} else {
-			priv->col_shift[11] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
-			priv->col_shift[13] = (((addrmap[4] >> 8) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
-				 COL_B11_BASE);
-		}
-	} else if (priv->info.dq_mode == SNPS_DQ_HALF) {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			priv->col_shift[10] = (((addrmap[3] >> 24) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
-				 COL_B9_BASE);
-			priv->col_shift[11] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
-		} else {
-			priv->col_shift[11] = (((addrmap[3] >> 24) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
-				 COL_B9_BASE);
-			priv->col_shift[13] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
-		}
-	} else {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			priv->col_shift[10] = (((addrmap[3] >> 16) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
-				 COL_B8_BASE);
-			priv->col_shift[11] = (((addrmap[3] >> 24) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
-				 COL_B9_BASE);
-		} else {
-			priv->col_shift[11] = (((addrmap[3] >> 16) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
-				 COL_B8_BASE);
-			priv->col_shift[13] = (((addrmap[3] >> 24) &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
-				 COL_B9_BASE);
-		}
-	}
-
-	if (priv->info.dq_mode) {
-		for (index = 9; index > priv->info.dq_mode; index--) {
-			priv->col_shift[index] =
-				priv->col_shift[index - priv->info.dq_mode];
-			priv->col_shift[index - priv->info.dq_mode] = 0;
-		}
-	}
-
-}
-
-static void snps_setup_bank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
-{
-	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
-	priv->bank_shift[1] = ((addrmap[1] >> 8) &
-				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
-	priv->bank_shift[2] = (((addrmap[1] >> 16) &
-				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
-				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
-				 BANK_B2_BASE);
-
-}
-
-static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
-{
-	/* Bank group signals are available on the DDR4 memory only */
-	if (priv->info.sdram_mode != MEM_DDR4)
-		return;
-
-	priv->bankgrp_shift[0] = (addrmap[8] &
-				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
-	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
-				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
-				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
-
-}
-
-static void snps_setup_rank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
-{
-	/* Ranks mapping is unavailable for the single-ranked memory */
-	if (priv->info.ranks > 1) {
-		priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
-					RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
-					RANK_MAX_VAL_MASK) + RANK_B0_BASE);
-	}
-}
-
-/**
- * snps_setup_address_map -	Set Address Map by querying ADDRMAP registers.
- * @priv:		DDR memory controller private instance data.
- *
- * Set Address Map by querying ADDRMAP registers.
- *
- * Return: none.
- */
-static void snps_setup_address_map(struct snps_edac_priv *priv)
-{
-	u32 addrmap[12];
-	int index;
-
-	for (index = 0; index < 12; index++) {
-		u32 addrmap_offset;
-
-		addrmap_offset = DDR_ADDRMAP0_OFST + (index * 4);
-		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
-	}
-
-	snps_setup_row_address_map(priv, addrmap);
-
-	snps_setup_column_address_map(priv, addrmap);
-
-	snps_setup_bank_address_map(priv, addrmap);
-
-	snps_setup_bg_address_map(priv, addrmap);
-
-	snps_setup_rank_address_map(priv, addrmap);
-}
-
 static ssize_t snps_inject_data_error_read(struct file *filep, char __user *ubuf,
 					   size_t size, loff_t *offp)
 {
@@ -1311,10 +1469,6 @@ SNPS_DEBUGFS_FOPS(snps_inject_data_poison, snps_inject_data_poison_read,
  */
 static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 {
-	struct snps_edac_priv *priv = mci->pvt_info;
-
-	snps_setup_address_map(priv);
-
 	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
 				 &snps_ddrc_info_fops);
 
@@ -1354,6 +1508,8 @@ static int snps_mc_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	snps_get_addr_map(priv);
+
 	mci = snps_mc_create(priv);
 	if (IS_ERR(mci))
 		return PTR_ERR(mci);
-- 
2.41.0

