Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9C577863D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHKDwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHKDv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:51:58 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBCA52710;
        Thu, 10 Aug 2023 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=rRsY8wF+12LLSbrp6p
        l15k6ZSOl72SbfGUbKTXeWh+0=; b=fGPdXk6ooIJKYWfeRKDxjbRNK2IawG75bi
        kldDGCHwuGEdS6rc5mZaZCiDbWRczzIiSNVIUUGUF+AIxkaUfBVp4tgLuNJOEs9k
        6cf7CNDthYIRmg7ZavAgZzss6AGvCN95xATz5yzWIQoPsO6uW4JWZQNGfhNhxAYJ
        23zeWdlBM=
Received: from wh-chevronli-w10.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wB3j5eVrNVknHE8Bw--.10021S3;
        Fri, 11 Aug 2023 11:35:51 +0800 (CST)
From:   Chevron Li <chevron_li@126.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shaper.liu@bayhubtech.com, Chevron Li <chevron.li@bayhubtech.com>
Subject: [PATCH V3 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for express card
Date:   Fri, 11 Aug 2023 11:35:17 +0800
Message-Id: <20230811033517.11532-2-chevron_li@126.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20230811033517.11532-1-chevron_li@126.com>
References: <20230811033517.11532-1-chevron_li@126.com>
X-CM-TRANSID: _____wB3j5eVrNVknHE8Bw--.10021S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw4xAw45Cw1kCw1DAw4fKrg_yoWrWrWxpF
        4Fvas8Cr4rtFW3Z39xJw4kZr1Y9r1vk3yDKFsxJrW0v3W0kF95Wr97CFy5XryUXrZaqw1f
        Xa1vqFyUGryUAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joFALUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: hfkh42xrqbzxa6rslhhfrp/1tbi1w3IAV53b4ALKwACs3
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

Add Bayhub new chip GG8 support for SD express card.
This patch depends on patch 1/2.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Change in V1:
1.Implement the SD express card callback routine.
2.Add SD express card support for Bayhub GG8 chip.

Change in V2:
1.updated some typo in patch and modified title.
2.updated patch format according to reviewer's comments.
3.updated the logical to try UHSI when express card initializatio failed.

Change in V3:
Fix the redefine issue.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 65 +++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index ae2707fbd119..7bfee28116af 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -21,6 +21,7 @@
  * O2Micro device registers
  */
 
+#define O2_SD_PCIE_SWITCH	0x54
 #define O2_SD_MISC_REG5		0x64
 #define O2_SD_LD0_CTRL		0x68
 #define O2_SD_DEV_CTRL		0x88
@@ -631,6 +632,67 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_o2_enable_clk(host, clk);
 }
 
+static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
+	u8 scratch8;
+	u16 scratch16;
+	int ret;
+
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+	/* Set VDD2 voltage*/
+	scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	scratch8 &= 0x0F;
+	if (host->mmc->ios.timing == MMC_TIMING_SD_EXP_1_2V &&
+	    host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V) {
+		scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_120;
+	} else {
+		scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_180;
+	}
+
+	sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
+	scratch8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	/* Wait for express card clkreqn assert */
+	ret = read_poll_timeout(sdhci_readb, scratch8, !(scratch8 & BIT(0)),
+				1, 30000, false, host, O2_SD_EXP_INT_REG);
+
+	if (!ret) {
+		/* Switch to PCIe mode */
+		scratch16 = sdhci_readw(host, O2_SD_PCIE_SWITCH);
+		scratch16 |= BIT(8);
+		sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
+	} else {
+		/* Power off VDD2 voltage*/
+		scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		scratch8 &= 0x0F;
+		sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
+
+		/* Keep mode as UHSI */
+		pci_read_config_word(chip->pdev, O2_SD_PARA_SET_REG1, &scratch16);
+		scratch16 &= ~BIT(11);
+		pci_write_config_word(chip->pdev, O2_SD_PARA_SET_REG1, scratch16);
+
+		host->mmc->ios.timing = MMC_TIMING_LEGACY;
+		pr_info("%s: Express card initialization failed, falling back to Legacy\n",
+			mmc_hostname(host->mmc));
+	}
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
+	scratch8 |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	return 0;
+}
+
 static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -703,10 +765,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	case PCI_DEVICE_ID_O2_GG8_9861:
 	case PCI_DEVICE_ID_O2_GG8_9862:
 	case PCI_DEVICE_ID_O2_GG8_9863:
-		host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+		host->mmc->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 		host->mmc->caps |= MMC_CAP_HW_RESET;
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
+		host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
 		break;
 	default:
 		break;
-- 
2.25.1

