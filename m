Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19778F0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbjHaQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245191AbjHaQBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:01:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A11BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:01:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-410994a240aso5649731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693497668; x=1694102468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywbjjPYDKSIcMWT4W9/zKJmf3mZhZR/bZUrrhLCLlMc=;
        b=Ge2coOXKyAzxvG7MThzIBM8AWQ7KLzl1AjsmvP9tOMD5ie58aAHViVbtdHTfm1fFS3
         YSUhPzBVC35QwnvrhbrICo+tWzp4V0dbo9qxtWKK/h013RBlpjL5qOMfdsWSUSTudE7A
         jbhu2v11NErNIEQZ8dIohmVcFTVg28Twg8AUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693497668; x=1694102468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywbjjPYDKSIcMWT4W9/zKJmf3mZhZR/bZUrrhLCLlMc=;
        b=Oyu2KKBrqmZvPJ6udXOt2utUG9255tX9Qy91mPcci3OUrMyuIXCRfdHFwfJ/HadKeX
         gZrBF13w6QnkNNfPMPFS8Xb2jp437LxpWG8GinakLBTF2jRZzLFwT6gpoKHmNTFFv1Ge
         WtyqMzqgxayXWmhC3kyfuUDI9MbKZUwkYCW6nzQG2sW1/f/fIhcmTOOdCkbOZRHLqRgP
         gokjqlAFVqLaZyjC1hybiyvUM9HJV2z2bLCsg93jRH0S36clXGKzmD5Wk9sLBIRxKRk6
         WzO4RIXq8++EZusftiSwE/9yoY/gRn+Lla33xUIBnprNFbA/57N/zcJArxxkeVmdzIcK
         2oJw==
X-Gm-Message-State: AOJu0YzKnzcIrydohaCnFhdd5khRU3Z5sGX6+84/UXcibWR+yOuBSIkB
        O7btwirCLsL5jx40KOoZ8NgNwc+aaYbDY2VJsHM=
X-Google-Smtp-Source: AGHT+IHWa5IgHUcPvKhzPQQK3jJU/s3h7auI68jfwhjC6S6ym1d1T8s54BWEEgrMZMkT17uQhucslw==
X-Received: by 2002:a05:622a:11d0:b0:3f9:b8a9:6494 with SMTP id n16-20020a05622a11d000b003f9b8a96494mr3440099qtk.48.1693497668213;
        Thu, 31 Aug 2023 09:01:08 -0700 (PDT)
Received: from trappist.c.googlers.com.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id i21-20020ac860d5000000b00401217aa51dsm704696qtm.76.2023.08.31.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:01:07 -0700 (PDT)
From:   Sven van Ashbrook <svenva@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     ben.chuang@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Sven van Ashbrook <svenva@chromium.org>
Subject: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend
Date:   Thu, 31 Aug 2023 16:00:56 +0000
Message-ID: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the r/w performance of GL9763E, the current driver inhibits LPM
negotiation while the device is active.

This prevents a large number of SoCs from suspending, notably x86 systems
which commonly use S0ix as the suspend mechanism - for example, Intel
Alder Lake and Raptor Lake processors.

Failure description:
1. Userspace initiates s2idle suspend (e.g. via writing to
   /sys/power/state)
2. This switches the runtime_pm device state to active, which disables
   LPM negotiation, then calls the "regular" suspend callback
3. With LPM negotiation disabled, the bus cannot enter low-power state
4. On a large number of SoCs, if the bus not in a low-power state, S0ix
   cannot be entered, which in turn prevents the SoC from entering
   suspend.

Fix by re-enabling LPM negotiation in the device's suspend callback.

Suggested-by: Stanislaw Kardach <skardach@google.com>
Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Sven van Ashbrook <svenva@chromium.org>
---

Changes in v3:
- applied maintainer feedback from https://lore.kernel.org/lkml/CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com/T/#m7cea7b6b987d1ab1ca95feedf2c6f9da5783da5c

Changes in v2:
- improved symmetry and error path in s2idle suspend callback (internal review)

 drivers/mmc/host/sdhci-pci-gli.c | 104 ++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 1792665c9494a..a4ccb6c3e27a6 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
 	return value;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-
-	pci_free_irq_vectors(slot->chip->pdev);
-	gli_pcie_enable_msi(slot);
-
-	return sdhci_pci_resume_host(chip);
-}
-
-static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = sdhci_pci_gli_resume(chip);
-	if (ret)
-		return ret;
-
-	return cqhci_resume(slot->host->mmc);
-}
-
-static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
-{
-	struct sdhci_pci_slot *slot = chip->slots[0];
-	int ret;
-
-	ret = cqhci_suspend(slot->host->mmc);
-	if (ret)
-		return ret;
-
-	return sdhci_suspend_host(slot->host);
-}
-#endif
-
 static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
 					  struct mmc_ios *ios)
 {
@@ -1029,6 +993,70 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
 }
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+
+	pci_free_irq_vectors(slot->chip->pdev);
+	gli_pcie_enable_msi(slot);
+
+	return sdhci_pci_resume_host(chip);
+}
+
+static int gl9763e_resume(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+	if (ret)
+		return ret;
+
+	ret = cqhci_resume(slot->host->mmc);
+	if (ret)
+		return ret;
+
+	/*
+	 * Disable LPM negotiation to bring device back in sync
+	 * with its runtime_pm state.
+	 */
+	gl9763e_set_low_power_negotiation(slot, false);
+
+	return 0;
+}
+
+static int gl9763e_suspend(struct sdhci_pci_chip *chip)
+{
+	struct sdhci_pci_slot *slot = chip->slots[0];
+	int ret;
+
+	/*
+	 * Certain SoCs can suspend only with the bus in low-
+	 * power state, notably x86 SoCs when using S0ix.
+	 * Re-enable LPM negotiation to allow entering L1 state
+	 * and entering system suspend.
+	 */
+	gl9763e_set_low_power_negotiation(slot, true);
+
+	ret = cqhci_suspend(slot->host->mmc);
+	if (ret)
+		goto err_suspend;
+
+	ret = sdhci_suspend_host(slot->host);
+	if (ret)
+		goto err_suspend_host;
+
+	return 0;
+
+err_suspend_host:
+	cqhci_resume(slot->host->mmc);
+err_suspend:
+	gl9763e_set_low_power_negotiation(slot, false);
+	return ret;
+}
+#endif
+
 static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1113,8 +1141,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 	.probe_slot	= gli_probe_slot_gl9763e,
 	.ops            = &sdhci_gl9763e_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume		= sdhci_cqhci_gli_resume,
-	.suspend	= sdhci_cqhci_gli_suspend,
+	.resume		= gl9763e_resume,
+	.suspend	= gl9763e_suspend,
 #endif
 #ifdef CONFIG_PM
 	.runtime_suspend = gl9763e_runtime_suspend,
-- 
2.42.0.283.g2d96d420d3-goog

