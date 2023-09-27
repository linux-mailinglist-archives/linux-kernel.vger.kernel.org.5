Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F8F7B0418
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjI0M2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0M2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:28:37 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8402139;
        Wed, 27 Sep 2023 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B53hY
        oLnIk6ygf7LWyIKjxm7/j4fwIl1INinLTwMaGM=; b=mO24yqwp8IV86MsiX9lAf
        WDzDnuUmwuDfz8v32xzZiLFeXAo9OBqhRZog86tqP77jiQJw5g6BU+fIwk441w9y
        D6ZuhSQ45BnDFo19kp7Ybe6kDPimLnfKl+t+/h2AJMFqScuF18JuPhRsnRpMg3l6
        tkTR/10liDGLm+I3Q8wIkk=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wAXY6HAHxRl78MKDQ--.24784S2;
        Wed, 27 Sep 2023 20:27:45 +0800 (CST)
From:   liuchang_125125@163.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        thomas.hu@bayhubtech.com, charl.liu@bayhubtech.com,
        Charl Liu <liuchang_125125@163.com>
Subject: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix Bayhub SD host hardware tuning compatibility issue for BanQ card
Date:   Wed, 27 Sep 2023 20:26:52 +0800
Message-Id: <20230927122652.4969-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXY6HAHxRl78MKDQ--.24784S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF13GFy7WF4kArykur48WFg_yoW8JF18Xo
        WfW3Z5tw18Gw1fXFykt3s7KFyUC34UKa1rJa15ur4DZa4xGa1rXr4SkF4fXFy3Wr1Fgryk
        uryxK34FyrW5Ar1kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RW5l8DUUUU
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/1tbiNwH3WVWBqdqKcAAAsF
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charl Liu <liuchang_125125@163.com>

1.Driver get the card's MID and OID by init_card callback
function to judge whether the card is BanQ card
2.Update tuning setting to make sure tuning done can be set
3.Stop transfer for CMD19 after tuning done is set to avoid data
line inhibit and then set input phase manually for BanQ card

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Update the tuning process to be compatibility with BanQ card.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 204 ++++++++++++++++++++++++---
 1 file changed, 182 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 7bfee28116af..ab898c583323 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -36,6 +36,7 @@
 #define O2_SD_MISC_CTRL2	0xF0
 #define O2_SD_INF_MOD		0xF1
 #define O2_SD_MISC_CTRL4	0xFC
+#define O2_SD_DLL_CTRL		0x1B0
 #define O2_SD_MISC_CTRL		0x1C0
 #define O2_SD_EXP_INT_REG	0x1E0
 #define O2_SD_PWR_FORCE_L0	0x0002
@@ -78,7 +79,8 @@ static const u32 dmdn_table[] = {0x2B1C0000,
 #define DMDN_SZ ARRAY_SIZE(dmdn_table)
 
 struct o2_host {
-	u8 dll_adjust_count;
+	u8 dll_adjust_count: 4;
+	u8 banq_card_setting: 4;
 };
 
 static void sdhci_o2_wait_card_detect_stable(struct sdhci_host *host)
@@ -311,14 +313,104 @@ static int sdhci_o2_dll_recovery(struct sdhci_host *host)
 	return ret;
 }
 
+static void sdhci_o2_send_stop_transmission(struct sdhci_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct mmc_command cmd = {};
+	struct mmc_request mrq = {};
+
+	cmd.opcode = MMC_STOP_TRANSMISSION;
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	cmd.busy_timeout = 150;
+
+	mrq.cmd = &cmd;
+
+	mmc_wait_for_req(mmc, &mrq);
+
+	/*
+	 * Command CRC error may occur due to compatibility issue.
+	 * It is normal and ignore it here.
+	 */
+	if ((cmd.error != 0) && (cmd.error != -EILSEQ))
+		pr_err("%s: CMD12 error: %d\n", mmc_hostname(mmc), cmd.error);
+}
+
+static void sdhci_o2_tuning_setting(struct mmc_host *mmc, bool isbanq, u8 phase_num)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
+	struct o2_host *o2_host = sdhci_pci_priv(slot);
+	u32 reg_val;
+
+	if (isbanq) {
+		/* update tuning command times for BanQ card */
+		pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL, &reg_val);
+		reg_val &= 0x00FFFFFF;
+		reg_val |= 0x02000000;
+		pci_write_config_dword(chip->pdev, O2_SD_TUNING_CTRL, reg_val);
+	} else {
+		reg_val = sdhci_readl(host, O2_SD_DLL_CTRL);
+		reg_val &= ~BIT(28);
+		sdhci_writel(host, reg_val, O2_SD_DLL_CTRL);
+
+		/* Update tuning command times for normal card */
+		pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL, &reg_val);
+		reg_val &= 0x00FFFFFF;
+		reg_val |= (phase_num * 3) << 24;
+		pci_write_config_dword(chip->pdev, O2_SD_TUNING_CTRL, reg_val);
+	}
+}
+
+static void sdhci_o2_configure_banq_best_input_phase(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
+
+	u32 response = 0;
+	u16 dll_phase_configure = 0;
+	u16 best_input_phase = 0;
+
+	switch (chip->pdev->device) {
+	case PCI_DEVICE_ID_O2_FUJIN2:
+		best_input_phase = 0x0;
+		break;
+
+	case PCI_DEVICE_ID_O2_SEABIRD0:
+	case PCI_DEVICE_ID_O2_SEABIRD1:
+		best_input_phase = 0x0;
+		break;
+
+	case PCI_DEVICE_ID_O2_GG8_9860:
+	case PCI_DEVICE_ID_O2_GG8_9861:
+	case PCI_DEVICE_ID_O2_GG8_9862:
+	case PCI_DEVICE_ID_O2_GG8_9863:
+		best_input_phase = 0xB;
+		break;
+
+	default:
+		break;
+	}
+
+	/* configure the best input phase (0xB) for BanQ card */
+	dll_phase_configure = sdhci_readw(host, 0x1B2);
+	dll_phase_configure = (dll_phase_configure & (u16)0xF0FF) |
+		(best_input_phase << 8) | BIT(12);
+	sdhci_writew(host, dll_phase_configure, 0x1B2);
+}
+
 static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct sdhci_pci_chip *chip = slot->chip;
+	struct mmc_card *card = mmc->card;
+	struct o2_host *o2_host = sdhci_pci_priv(slot);
 	int current_bus_width = 0;
 	u32 scratch32 = 0;
+	u16 data_timeout_counter_value = 0;
 	u16 scratch = 0;
+	u8 phase_num = 0;
 	u8  scratch_8 = 0;
 	u32 reg_val;
 
@@ -334,6 +426,31 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	if (WARN_ON(!mmc_op_tuning(opcode)))
 		return -EINVAL;
 
+	if ((chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860) ||
+		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861) ||
+		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862) ||
+		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863)) {
+		phase_num = 14;
+	} else {
+		phase_num = 11;
+	}
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+	sdhci_o2_tuning_setting(mmc, (bool)o2_host->banq_card_setting, phase_num);
+
+	if (o2_host->banq_card_setting) {
+		/*
+		 * set data timeout counter value to 0 to ensure that
+		 * the tuning process can be completed
+		 */
+		data_timeout_counter_value = sdhci_readw(host, SDHCI_TIMEOUT_CONTROL);
+		sdhci_writew(host, data_timeout_counter_value & (u16)0xFFF0, SDHCI_TIMEOUT_CONTROL);
+	}
+
 	/* Force power mode enter L0 */
 	scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
 	scratch |= O2_SD_PWR_FORCE_L0;
@@ -351,23 +468,13 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		reg_val &= ~SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
 
-		if (host->timing == MMC_TIMING_MMC_HS200 ||
-		    host->timing == MMC_TIMING_UHS_SDR104) {
-			/* UnLock WP */
-			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-			scratch_8 &= 0x7f;
-			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
-
+		if ((host->timing == MMC_TIMING_MMC_HS200) ||
+			(host->timing == MMC_TIMING_UHS_SDR104)) {
 			/* Set pcr 0x354[16] to choose dll clock, and set the default phase */
 			pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
 			reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
 			reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
 			pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
-
-			/* Lock WP */
-			pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
-			scratch_8 |= 0x80;
-			pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
 		}
 
 		/* Start clk */
@@ -375,10 +482,19 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		reg_val |= SDHCI_CLOCK_CARD_EN;
 		sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
 		break;
+	case PCI_DEVICE_ID_O2_GG8_9860:
+	case PCI_DEVICE_ID_O2_GG8_9861:
+	case PCI_DEVICE_ID_O2_GG8_9862:
+	case PCI_DEVICE_ID_O2_GG8_9863:
 	default:
 		break;
 	}
 
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+	scratch_8 |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
 	/* wait DLL lock, timeout value 5ms */
 	if (readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
 		scratch32, (scratch32 & O2_DLL_LOCK_STATUS), 1, 5000))
@@ -416,6 +532,20 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		sdhci_set_bus_width(host, current_bus_width);
 	}
 
+	/* update input phase for BanQ card */
+	if (o2_host->banq_card_setting) {
+		/* recover the data timeout counter value */
+		sdhci_writew(host, data_timeout_counter_value, SDHCI_TIMEOUT_CONTROL);
+
+		/*
+		 * Stop transfer for CMD19 after tuning done is set to
+		 * avoid data line inhibit
+		 */
+		sdhci_o2_send_stop_transmission(host);
+
+		sdhci_o2_configure_banq_best_input_phase(host);
+	}
+
 	/* Cancel force power mode enter L0 */
 	scratch = sdhci_readw(host, O2_SD_MISC_CTRL);
 	scratch &= ~(O2_SD_PWR_FORCE_L0);
@@ -428,6 +558,24 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return 0;
 }
 
+static void sdhci_o2_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct o2_host *o2_host = sdhci_pci_priv(slot);
+	unsigned int manfid;
+	unsigned short oemid;
+
+	manfid = card->raw_cid[0] >> 24;
+	oemid = (card->raw_cid[0] >> 8) & 0xFFFF;
+
+	/* judge whether the card is BanQ card */
+	if (manfid == 0x89 && oemid == 0x303)
+		o2_host->banq_card_setting = 1;
+	else
+		o2_host->banq_card_setting = 0;
+}
+
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 {
 	int ret;
@@ -596,15 +744,20 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	scratch &= 0x7f;
 	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 
-	if (chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860 ||
-	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861 ||
-	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862 ||
-	    chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863) {
+	if ((chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9860) ||
+		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9861) ||
+		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9862) ||
+		(chip->pdev->device == PCI_DEVICE_ID_O2_GG8_9863)) {
 		dmdn_208m = 0x2c500000;
 		dmdn_200m = 0x25200000;
 	} else {
 		dmdn_208m = 0x2c280000;
 		dmdn_200m = 0x25100000;
+
+		/* open-clock for old project */
+		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
+		scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
+		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
 	}
 
 	if ((host->timing == MMC_TIMING_UHS_SDR104) && (clock == 200000000)) {
@@ -619,10 +772,6 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 			o2_pci_set_baseclk(chip, dmdn_200m);
 	}
 
-	pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
-	scratch_32 &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
-	pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
-
 	/* Lock WP */
 	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 	scratch |= 0x80;
@@ -632,6 +781,11 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_o2_enable_clk(host, clk);
 }
 
+static void sdhci_o2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	sdhci_writeb(host, 0x0E, SDHCI_TIMEOUT_CONTROL);
+}
+
 static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -705,6 +859,7 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	host = slot->host;
 
 	o2_host->dll_adjust_count = 0;
+	o2_host->banq_card_setting = 0;
 	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
 
 	/*
@@ -718,7 +873,9 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 
 	sdhci_pci_o2_enable_msi(chip, host);
 
+	host->mmc_host_ops.init_card = sdhci_o2_init_card;
 	host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
+
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
@@ -770,6 +927,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
 		host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
+
+		sdhci_writel(host, 0xFFFFFFFF, SDHCI_INT_STATUS);
 		break;
 	default:
 		break;
@@ -1022,7 +1181,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		/* Set output delay*/
 		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
 		scratch_32 &= 0xFF0FFF00;
-		scratch_32 |= 0x00B0003B;
+		scratch_32 |= 0x00B000CB;
 		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
 
 		/* Lock WP */
@@ -1051,6 +1210,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_timeout = sdhci_o2_set_timeout,
 };
 
 const struct sdhci_pci_fixes sdhci_o2 = {

base-commit: 0e945134b680040b8613e962f586d91b6d40292d
-- 
2.34.1

