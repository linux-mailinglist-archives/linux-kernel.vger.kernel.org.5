Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9275C844
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGUNua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGUNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:50:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9D2D45
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fd190065a7so16496975e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947416; x=1690552216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzaljnOO1Gw4qS38ZHWvBAE06zq5Umr4CoJZWfxvzDg=;
        b=mrlDKR0TvYN/dZTrWxIqkMI9FU4brRH4Vd71KsjUmafFWEE9Twd7y2B2aNWBz1o0Ib
         IMfK+5XtbtEFobIfcVMXGSExJroOalKnMZHuHfz1ut2Wv1HeRuSrmTSO4fuJ6s6G9Ofu
         NxoFGTRHn1zD7q8DhHZxDYN06LQTBti2XripCNHhi4sNCX24Qupr3mLoMy3e/AhG6VI7
         FmLm6AzxqLHGrFR4KRyZanF+vay/3ALShsdrQEp9eKCg+F8ir63as67xpeQpEycZ9g7X
         fgleWAr0fXFXePD+vtS8+cqIz3Ix69bta3utJzCu67JGKZU0VkHP1eQVDvLOmRo5EY2i
         2H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947416; x=1690552216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzaljnOO1Gw4qS38ZHWvBAE06zq5Umr4CoJZWfxvzDg=;
        b=i2AUlVnSfGHThIamKVtLMERIUb909AtXxXxjEsbrOThMhokhe2DtUR94OxwGAzNIUb
         Kzpoby0jag9n6NPHqkavt3Sb5Q+VJ1slrwPwEoIT9siXMb8G10dMCMOYl6lG0kEckxGV
         p4dNcjUw9Ju5HO0fFvkhYHnmaWTSq/XU5wp8kGVLhhXcRj7VnxBB04vJSqU6qeBV/9pH
         3E8Nc0q2acKlNb9bV/MvysTL3ZjEEyZU2qiObU24SH4CC98P8Jz4ef3JE2cxlMToMldf
         DEp8g8Idac2tIK/KqwGH8oaju/FkUCTUOYXOqoEm1SJzz2N2cnBPbGNUY9x+4ZEPyFMD
         AwxA==
X-Gm-Message-State: ABy/qLZq6eaSZDiAtBawtgTRI5MjvxD/wYDbsL4+MXNtEVM41kWhALxl
        tWw2v19w+FtBUKu6r2t+bH9+LQ==
X-Google-Smtp-Source: APBJJlEn7ZgPtrHBxi2+sc7/MBuJ9AS9a+wSvdcjzGDi0MrlNsMDtsw7huomVmX53L3WygmEGOV5Ug==
X-Received: by 2002:a05:600c:2259:b0:3fb:adc0:609b with SMTP id a25-20020a05600c225900b003fbadc0609bmr1534653wmm.13.1689947416232;
        Fri, 21 Jul 2023 06:50:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:15 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 3/6] can: tcan4x5x: Check size of mram configuration
Date:   Fri, 21 Jul 2023 15:50:06 +0200
Message-Id: <20230721135009.1120562-4-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce debugging effort in case the mram is misconfigured, add this
size check of the DT configuration. Currently if the mram configuration
doesn't fit into the available MRAM it just overwrites other areas of
the MRAM.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/m_can.c         | 16 ++++++++++++++++
 drivers/net/can/m_can/m_can.h         |  1 +
 drivers/net/can/m_can/tcan4x5x-core.c |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c5af92bcc9c9..9210cf0705a1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1887,6 +1887,22 @@ static int register_m_can_dev(struct net_device *dev)
 	return register_candev(dev);
 }
 
+int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size)
+{
+	u32 total_size;
+
+	total_size = cdev->mcfg[MRAM_TXB].off - cdev->mcfg[MRAM_SIDF].off +
+			cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
+	if (total_size > mram_max_size) {
+		dev_err(cdev->dev, "Total size of mram config(%u) exceeds mram(%u)\n",
+			total_size, mram_max_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(m_can_check_mram_cfg);
+
 static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 				const u32 *mram_config_vals)
 {
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..d8150d8128e7 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -101,6 +101,7 @@ int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
 int m_can_init_ram(struct m_can_classdev *priv);
+int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
 int m_can_class_suspend(struct device *dev);
 int m_can_class_resume(struct device *dev);
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2342aa011647..e706518176e4 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -80,6 +80,7 @@
 	 TCAN4X5X_MCAN_IR_RF1F)
 
 #define TCAN4X5X_MRAM_START 0x8000
+#define TCAN4X5X_MRAM_SIZE 0x800
 #define TCAN4X5X_MCAN_OFFSET 0x1000
 
 #define TCAN4X5X_CLEAR_ALL_INT 0xffffffff
@@ -307,6 +308,10 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (!mcan_class)
 		return -ENOMEM;
 
+	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
+	if (ret)
+		goto out_m_can_class_free_dev;
+
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-- 
2.40.1

