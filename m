Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9B7E6974
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjKILUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjKILUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:20:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C18272C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:20:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso4901315e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699528820; x=1700133620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cavHVFQJ8PuwkxFyTFM+8LZM+EGSpdqZcaFZ4JxFv24=;
        b=VqXCCZpdpLUggHfPfSJ3lpJeiMUPXeDq52DMwPPO6JZL2diU5xdEzJey1pxB8CqV8e
         Vt504GkPy3OPP1NyO0ccINbWgCA4gzMRm5OQjmc74zshpAIObvRxrRL+MbPBx2xmrGYT
         BXEUHsm6XperJBlmBH8XfRR4FiIHnjdl8sHyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699528820; x=1700133620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cavHVFQJ8PuwkxFyTFM+8LZM+EGSpdqZcaFZ4JxFv24=;
        b=py7Ovx6h3z/2CWIG0aHbDNss8U7PkdK0BkKcJVVdk7TgUUjGh2L/cTS+6BF/roM2Km
         imV8HC70BwpK+Y5EDu+ub3SuY6cVm6R4s2w3uA8f/GJdMOtixfMUGiLfjfeO8J8uMkr9
         jKFo1rj73avx0t9XfCe7Mn9YktVMv3F4nuR8AM/xkd5wNYVg14sRDEOWuWnM8VL9NL23
         tb4p+J6tcnnPj2DiPBW/adSPL+c28txiVgMnwsLajxjoTz/UohR+ginPLPVDc8t/7jgy
         Kd7QNXMDh9un77Mbn7Gcle34IJ8qisUQM67gf+XfSzjNpvtnxuPptUJ0YU8Qgql2gnEC
         r1KQ==
X-Gm-Message-State: AOJu0YwMGz0HsSDcrMYROLu8D2z3K2j3dBIo+UAAs7/KjNwgZF5KKPaK
        rnJfMBo3DIi+MYPvXV9ZCePLlA==
X-Google-Smtp-Source: AGHT+IFIoKr4jf0DscVS8+8kKDG9HyfDOFkGaLnalGFWGoyHWVF/fIEqh8WekzQytB0dT3wDRD3ArA==
X-Received: by 2002:a05:600c:4181:b0:408:39d3:a26b with SMTP id p1-20020a05600c418100b0040839d3a26bmr4133544wmh.40.1699528820536;
        Thu, 09 Nov 2023 03:20:20 -0800 (PST)
Received: from orzel1.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c44c600b00401d8181f8bsm1755732wmo.25.2023.11.09.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 03:20:20 -0800 (PST)
From:   =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sven van Ashbrook <svenva@google.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>
Subject: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
Date:   Thu,  9 Nov 2023 11:19:34 +0000
Message-ID: <20231109111934.4172565-1-korneld@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To address IO performance commit f9e5b33934ce
("mmc: host: Improve I/O read/write performance for GL9763E")
limited LPM negotiation to runtime suspend state.
The problem is that it only flips the switch in the runtime PM
resume/suspend logic.

Disable LPM negotiation in gl9763e_add_host.
This helps in two ways:
1. It was found that the LPM switch stays in the same position after
   warm reboot. Having it set in init helps with consistency.
2. Disabling LPM during the first runtime resume leaves us susceptible
   to the performance issue in the time window between boot and the
   first runtime suspend.

Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
Cc: stable@vger.kernel.org
Signed-off-by: Kornel Dulęba <korneld@chromium.org>
---
 drivers/mmc/host/sdhci-pci-gli.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index d83261e857a5..ce91d1e63a8e 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -220,6 +220,9 @@
 
 #define GLI_MAX_TUNING_LOOP 40
 
+static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
+					      bool enable);
+
 /* Genesys Logic chipset */
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
@@ -1281,6 +1284,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	if (ret)
 		goto cleanup;
 
+	/* Disable LPM negotiation to avoid entering L1 state. */
+	gl9763e_set_low_power_negotiation(slot, false);
+
 	return 0;
 
 cleanup:
@@ -1323,7 +1329,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
-#ifdef CONFIG_PM
 static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
@@ -1349,6 +1354,7 @@ static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
 }
 
+#ifdef CONFIG_PM
 static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
-- 
2.42.0.869.gea05f2083d-goog

