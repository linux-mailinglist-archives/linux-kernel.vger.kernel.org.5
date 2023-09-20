Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D677A8D55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjITT6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjITT6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37301129;
        Wed, 20 Sep 2023 12:58:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50337b43ee6so428463e87.3;
        Wed, 20 Sep 2023 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695239894; x=1695844694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISTWIBRRgGQ6k7IaJyUXutua9+M2xYZb0hYe8x2rkfo=;
        b=Sra3LZEflWnG6/wcsb9voiAgHgTCcdvN4ZqLcqQTgiIXI7PEFK2s1dw34QWyjvK+Ca
         LflR2p80bSGjx8AfDHM2D+IoStOBDwF8lTJWVwkndqwGnisRXhZObwew68wdT8zYVcpw
         8wNiRBLG/TN/qG04YJL8zNCO2Q/vnSHpGzlKFWeati0inqhABeVK4lif7FLIg9A79Dwa
         irMlezjq7XOSSI4RQd5cOeLVLqQ8OP1BJr1fo2gxfwEgETIDcUGd9+a6NNmRj2NuEWrD
         94Nw4NFhK8S8OiQmXbgYhuzhOWaogh8z+8YE5QTE4hA1wOkpEGO3t5M8YFW0DRsXaOMu
         oZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695239894; x=1695844694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISTWIBRRgGQ6k7IaJyUXutua9+M2xYZb0hYe8x2rkfo=;
        b=anTss7DnIj2uHzW06aBo2w9MSWa3QBIf5j6MyGnEe2f10i0f2Xi+2+N93TeK4RxxVU
         NVSaLSqg6REZQl6bpmSVBQ1FSesPoK2HbJe+4GRePdulTDaSozEoQJdI7RA1wafAo01Q
         w/VqSP4PlzGkB5obH5Q5XHdaK/0wxrGmR1SG/Hmxkbc7/txwP3oPCW9XtDiWoQIp8/qA
         ySHxwSE+dSDVKoFH8kWmX6o69HZGZaD0pzvbfM5oQS3adGx+foJ7AngT2eAF71/bxmmG
         ppUmRnEYpyak9KbaDEyY8MCwmazVt7esEkGx79+hCV4FsmEvyUgr+1ddZ/xXVf24jSRH
         vEGQ==
X-Gm-Message-State: AOJu0YxUF2Pq8PdsW+xpI/uuPwMcLsYaRCcBTQ1N9gupS29BXfY/01lX
        CHnHzBn56x4Wl8pNq/ru1XY=
X-Google-Smtp-Source: AGHT+IF4nAvtsmuyhd6TMdEeySHXDZWhs0pkfRlku1HrRV19gVZn41tiL0zEJS6g0+RM9f4kwNV5zg==
X-Received: by 2002:a05:6512:a8b:b0:502:ff3b:7670 with SMTP id m11-20020a0565120a8b00b00502ff3b7670mr4184923lfu.4.1695239894325;
        Wed, 20 Sep 2023 12:58:14 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b00501c6d78f11sm378265lfo.298.2023.09.20.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:58:13 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/13] EDAC/synopsys: Add individual named ECC IRQs support
Date:   Wed, 20 Sep 2023 22:56:39 +0300
Message-ID: <20230920195720.32047-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920195720.32047-1-fancer.lancer@gmail.com>
References: <20230920195720.32047-1-fancer.lancer@gmail.com>
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

Currently the DW uMCTL2 DDRC EDAC driver supports a common unnamed IRQ
only. It isn't suitable for the platforms which have the individual IRQ
lines for each DDRC event (ECC UE, ECC CE, DFI parity error, Scrubber
done, etc). Moreover the DW uMCTL2 DDRC IP-core doesn't have an option to
be configured with a common interrupts output line. So in order to have
the generic DW uMCTL2 DDR controller supported by the driver add the
individual (per DDRC event) IRQs request support.

There is not much to do really since the common IRQs handler has already
been split up into the sub-handlers: first try to request the individual
IRQs; if failed fallback to using the common IRQ. The IRQ names are used
in accordance with the DW uMCTL2 DDRC DT-bindings.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 91 ++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 9dde43636199..19b7bce06e13 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1533,25 +1533,96 @@ static void snps_mc_free(struct mem_ctl_info *mci)
 	edac_mc_free(mci);
 }
 
-static int snps_setup_irq(struct mem_ctl_info *mci)
+/**
+ * snps_request_ind_irq - Request individual DDRC IRQs.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Return: 0 if the IRQs were successfully requested, 1 if the individual IRQs
+ * are unavailable, otherwise negative errno.
+ */
+static int snps_request_ind_irq(struct mem_ctl_info *mci)
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
-	int ret, irq;
+	struct device *dev = &priv->pdev->dev;
+	int rc, irq;
 
-	irq = platform_get_irq(priv->pdev, 0);
-	if (irq < 0) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "No IRQ %d in DT\n", irq);
+	irq = platform_get_irq_byname_optional(priv->pdev, "ecc_ce");
+	if (irq == -ENXIO)
+		return 1;
+	if (irq < 0)
+		return irq;
+
+	rc = devm_request_irq(dev, irq, snps_ce_irq_handler, 0, "ecc_ce", mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request ECC CE IRQ\n");
+		return rc;
+	}
+
+	irq = platform_get_irq_byname(priv->pdev, "ecc_ue");
+	if (irq < 0)
 		return irq;
+
+	rc = devm_request_irq(dev, irq, snps_ue_irq_handler, 0, "ecc_ue", mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to request ECC UE IRQ\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * snps_request_com_irq - Request common DDRC IRQ.
+ * @mci:	EDAC memory controller instance.
+ *
+ * It first attempts to get the named IRQ. If failed the method fallbacks
+ * to first available one.
+ *
+ * Return: 0 if the IRQ was successfully requested otherwise negative errno.
+ */
+static int snps_request_com_irq(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct device *dev = &priv->pdev->dev;
+	int rc, irq;
+
+	irq = platform_get_irq_byname_optional(priv->pdev, "ecc");
+	if (irq < 0) {
+		irq = platform_get_irq(priv->pdev, 0);
+		if (irq < 0)
+			return irq;
 	}
 
-	ret = devm_request_irq(&priv->pdev->dev, irq, snps_com_irq_handler,
-			       0, dev_name(&priv->pdev->dev), mci);
-	if (ret < 0) {
+	rc = devm_request_irq(dev, irq, snps_com_irq_handler, 0, "ecc", mci);
+	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
-		return ret;
+		return rc;
 	}
 
+	return 0;
+}
+
+/**
+ * snps_setup_irq - Request and enable DDRC IRQs.
+ * @mci:	EDAC memory controller instance.
+ *
+ * It first tries to get and request individual IRQs. If failed the method
+ * fallbacks to the common IRQ line case. The IRQs will be enabled only if
+ * some of these requests have been successful.
+ *
+ * Return: 0 if IRQs were successfully setup otherwise negative errno.
+ */
+static int snps_setup_irq(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	int rc;
+
+	rc = snps_request_ind_irq(mci);
+	if (rc > 0)
+		rc = snps_request_com_irq(mci);
+	if (rc)
+		return rc;
+
 	snps_enable_irq(priv);
 
 	return 0;
-- 
2.41.0

