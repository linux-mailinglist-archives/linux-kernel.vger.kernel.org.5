Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291DD77863B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjHKDv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHKDvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:51:25 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 20:51:23 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C452271B;
        Thu, 10 Aug 2023 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=B69RKsGKrBIibzbVBb
        Ta8Nd78WFpDwbWL2nnXaRIzIo=; b=DI5T/K6vkB9vnios5lgQ86A58CN6Cky3F9
        cfDvSM6AHV/BF5Q4wPJy00/7LL17n6GmWtLrUD7HcZdAAtYCDsKm8AOYaF7BrRi9
        bZ7Qxiy4gLTbBbIVAUkvumZQGZ4TlLStTSmdT9KxaLEXJuEBHd1qEk7yp4tYaT0r
        g6zaq48a4=
Received: from wh-chevronli-w10.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wB3j5eVrNVknHE8Bw--.10021S2;
        Fri, 11 Aug 2023 11:35:50 +0800 (CST)
From:   Chevron Li <chevron_li@126.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shaper.liu@bayhubtech.com, Chevron Li <chevron.li@bayhubtech.com>
Subject: [PATCH V3 1/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for UHS-I
Date:   Fri, 11 Aug 2023 11:35:16 +0800
Message-Id: <20230811033517.11532-1-chevron_li@126.com>
X-Mailer: git-send-email 2.18.0.windows.1
X-CM-TRANSID: _____wB3j5eVrNVknHE8Bw--.10021S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3CF1DWr1xGF4kKFyUKw4rXwb_yoWkJr1xpF
        ZYyayktr4UtFWrZ3s7tw1kZr17GF4qkrW0kFW3GayIqF18C3y5Wr97CFZ8Xry8XrZaqw4f
        XF4ktrWxWryUJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uxl1PUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: hfkh42xrqbzxa6rslhhfrp/1tbiFxvIAVpEG90W5gAAst
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chevron Li <chevron.li@bayhubtech.com>

Add Bayhub new chip GG8 support for UHS-I function

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Change in V1:
1.Add GG8 chip IDs in sdhci-pci-core.c and sdhci-pci.h
2.Add GG8 chip initialization flow at sdhci-pci-o2micro.c

Change in V2:
1.updated typo description for the patch title.
2.updated patch format according to reviewer's comments.

Change in V3:
Updated patch format according to reviewer's comments.
---
 drivers/mmc/host/sdhci-pci-core.c    |   4 +
 drivers/mmc/host/sdhci-pci-o2micro.c | 148 ++++++++++++++++++++-------
 drivers/mmc/host/sdhci-pci.h         |   4 +
 3 files changed, 120 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1c2572c0f012..7c14feb5db77 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1898,6 +1898,10 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(O2, SDS1,     o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9860, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9861, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9862, o2),
+	SDHCI_PCI_DEVICE(O2, GG8_9863, o2),
 	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
 	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
 	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 620f52ad9667..ae2707fbd119 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -36,6 +36,7 @@
 #define O2_SD_INF_MOD		0xF1
 #define O2_SD_MISC_CTRL4	0xFC
 #define O2_SD_MISC_CTRL		0x1C0
+#define O2_SD_EXP_INT_REG	0x1E0
 #define O2_SD_PWR_FORCE_L0	0x0002
 #define O2_SD_TUNING_CTRL	0x300
 #define O2_SD_PLL_SETTING	0x304
@@ -49,6 +50,9 @@
 #define O2_SD_UHS2_L1_CTRL	0x35C
 #define O2_SD_FUNC_REG3		0x3E0
 #define O2_SD_FUNC_REG4		0x3E4
+#define O2_SD_PARA_SET_REG1	0x444
+#define O2_SD_VDDX_CTRL_REG	0x508
+#define O2_SD_GPIO_CTRL_REG1	0x510
 #define O2_SD_LED_ENABLE	BIT(6)
 #define O2_SD_FREG0_LEDOFF	BIT(13)
 #define O2_SD_SEL_DLL		BIT(16)
@@ -334,33 +338,45 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	scratch |= O2_SD_PWR_FORCE_L0;
 	sdhci_writew(host, scratch, O2_SD_MISC_CTRL);
 
-	/* Stop clk */
-	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	reg_val &= ~SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
-
-	if ((host->timing == MMC_TIMING_MMC_HS200) ||
-		(host->timing == MMC_TIMING_UHS_SDR104)) {
-		/* UnLock WP */
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-		scratch_8 &= 0x7f;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
-
-		/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
-		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
-		reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
-		reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
-		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
+	/* Update output phase */
+	switch (chip->pdev->device) {
+	case PCI_DEVICE_ID_O2_SDS0:
+	case PCI_DEVICE_ID_O2_SEABIRD0:
+	case PCI_DEVICE_ID_O2_SEABIRD1:
+	case PCI_DEVICE_ID_O2_SDS1:
+	case PCI_DEVICE_ID_O2_FUJIN2:
+		/* Stop clk */
+		reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		reg_val &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+
+		if (host->timing == MMC_TIMING_MMC_HS200 ||
+		    host->timing == MMC_TIMING_UHS_SDR104) {
+			/* UnLock WP */
+			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+			scratch_8 &= 0x7f;
+			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+			/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
+			pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
+			reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
+			reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
+			pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
+
+			/* Lock WP */
+			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+			scratch_8 |= 0x80;
+			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+		}
 
-		/* Lock WP */
-		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-		scratch_8 |= 0x80;
-		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+		/* Start clk */
+		reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		reg_val |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
+		break;
+	default:
+		break;
 	}
-	/* Start clk */
-	reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	reg_val |= SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
 
 	/* wait DLL lock, timeout value 5ms */
 	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
@@ -563,6 +579,7 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	u16 clk;
 	u8 scratch;
 	u32 scratch_32;
+	u32 dmdn_208m, dmdn_200m;
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct sdhci_pci_chip *chip = slot->chip;
 
@@ -578,16 +595,27 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	scratch &= 0x7f;
 	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
+	if (chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860 ||
+	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861 ||
+	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862 ||
+	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863) {
+		dmdn_208m = 0x2c500000;
+		dmdn_200m = 0x25200000;
+	} else {
+		dmdn_208m = 0x2c280000;
+		dmdn_200m = 0x25100000;
+	}
+
 	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
 
-		if ((scratch_32 & 0xFFFF0000) != 0x2c280000)
-			o2_pci_set_baseclk(chip, 0x2c280000);
+		if ((scratch_32 & 0xFFFF0000) != dmdn_208m)
+			o2_pci_set_baseclk(chip, dmdn_208m);
 	} else {
 		pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
 
-		if ((scratch_32 & 0xFFFF0000) != 0x25100000)
-			o2_pci_set_baseclk(chip, 0x25100000);
+		if ((scratch_32 & 0xFFFF0000) != dmdn_200m)
+			o2_pci_set_baseclk(chip, dmdn_200m);
 	}
 
 	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
@@ -624,6 +652,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	if (caps & SDHCI_CAN_DO_8BIT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 
+	host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
+
+	sdhci_pci_o2_enable_msi(chip, host);
+
+	host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
@@ -634,10 +667,6 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
-
-		sdhci_pci_o2_enable_msi(chip, host);
-
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {
 			ret = pci_read_config_dword(chip->pdev,
 						    O2_SD_MISC_SETTING, &reg);
@@ -663,15 +692,21 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		}
 
-		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
-
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
 		reg = sdhci_readl(host, O2_SD_VENDOR_SETTING2);
 		reg |= (1 << 12);
 		sdhci_writel(host, reg, O2_SD_VENDOR_SETTING2);
-
+		break;
+	case PCI_DEVICE_ID_O2_GG8_9860:
+	case PCI_DEVICE_ID_O2_GG8_9861:
+	case PCI_DEVICE_ID_O2_GG8_9862:
+	case PCI_DEVICE_ID_O2_GG8_9863:
+		host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+		host->mmc->caps |= MMC_CAP_HW_RESET;
+		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
 		break;
 	default:
 		break;
@@ -684,6 +719,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 {
 	int ret;
 	u8 scratch;
+	u16 scratch16;
 	u32 scratch_32;
 
 	switch (chip->pdev->device) {
@@ -893,6 +929,46 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		scratch |= 0x80;
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
+	case PCI_DEVICE_ID_O2_GG8_9860:
+	case PCI_DEVICE_ID_O2_GG8_9861:
+	case PCI_DEVICE_ID_O2_GG8_9862:
+	case PCI_DEVICE_ID_O2_GG8_9863:
+		/* UnLock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+
+		/* Select mode switch source as software control */
+		pci_read_config_word(chip->pdev, O2_SD_PARA_SET_REG1, &scratch16);
+		scratch16 &= 0xF8FF;
+		scratch16 |= BIT(9);
+		pci_write_config_word(chip->pdev, O2_SD_PARA_SET_REG1, scratch16);
+
+		/* set VDD1 supply source */
+		pci_read_config_word(chip->pdev, O2_SD_VDDX_CTRL_REG, &scratch16);
+		scratch16 &= 0xFFE3;
+		scratch16 |= BIT(3);
+		pci_write_config_word(chip->pdev, O2_SD_VDDX_CTRL_REG, scratch16);
+
+		/* Set host drive strength*/
+		scratch16 = 0x0025;
+		pci_write_config_word(chip->pdev, O2_SD_PLL_SETTING, scratch16);
+
+		/* Set output delay*/
+		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
+		scratch_32 &= 0xFF0FFF00;
+		scratch_32 |= 0x00B0003B;
+		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
+
+		/* Lock WP */
+		ret = pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
+		if (ret)
+			return ret;
+		scratch |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
+		break;
 	}
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 9c8863956381..153704f812ed 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -11,6 +11,10 @@
 #define PCI_DEVICE_ID_O2_FUJIN2		0x8520
 #define PCI_DEVICE_ID_O2_SEABIRD0	0x8620
 #define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
+#define PCI_DEVICE_ID_O2_GG8_9860	0x9860
+#define PCI_DEVICE_ID_O2_GG8_9861	0x9861
+#define PCI_DEVICE_ID_O2_GG8_9862	0x9862
+#define PCI_DEVICE_ID_O2_GG8_9863	0x9863
 
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a

base-commit: 25aa0bebba72b318e71fe205bfd1236550cc9534
-- 
2.25.1

