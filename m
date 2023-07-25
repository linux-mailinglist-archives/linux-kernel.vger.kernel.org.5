Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92776048A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 03:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGYBBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 21:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjGYBAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 21:00:55 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40B2171E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:50 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-569fdf846edso443618eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690246850; x=1690851650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opvEmLJsr/QQbcAlYd7WXi8TiNCEs7ncHrT0RHmS9/8=;
        b=QGoe5U/cP6/JbKqJ2W5R5HXMdXWcI91myJmhZF1IcmmVVSMcPgkKaeSWv5OJfkEccC
         yp/s4zDNIarGcJiUYx5+ZTwZ5UIX4G3IcMzxlJs4feySRwTBUTjqTYA27/yaDEy3V8CY
         abf2t/PC6WmZY90evepLw57upZ9kjMa3Jg5S1Ff9GpkANmpR5hoJiBHAbanMqK3mmr6O
         5NxG83iWzYRgIzALFAGGsLa+gMzAbKY2MkB3OGhyZMD0UZfQMXhv3Pm+YmCIAIVbDcbE
         BPMqRONQbROtaXI3POURwQI+4nj0zo3tX/P3mS967ApjQYEjlNoRkIpTgT7WTm+kWLez
         xaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690246850; x=1690851650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opvEmLJsr/QQbcAlYd7WXi8TiNCEs7ncHrT0RHmS9/8=;
        b=dVxrj55fvqHrquVx/MxmXl5oOLfpzZ4JIfmgiXDxliwp7XIFnlvelWvxIfmJNFZ/g0
         SKZPqjN3U1RpszxGYfn7rNmGnUoCuY1g1cJ28/vSZIXcphksc4FKc+zxCVOYPgLT4Dny
         J7UQ+gyAAstZFYdlDHXxfA45CWvXkXSEGXE2ULPbhTkzZhEwMxAJftGR58ZPUNu6tBaL
         3q2Rt6MKub1f9cf5fY5vc8tT7QVFJiy21rWcFTnB+lzA51vOWKWaoq+4xSEyjx5JYDzS
         T5slmlvfmXacTGpBCMYvYaFwXYxl+Sd6SocHjq796sQ+jLajdfVw++PUW7kXdY1FDItQ
         ovFA==
X-Gm-Message-State: ABy/qLZ/YC+tb9qKmuZVkxuYVNzYlVABfvp7IDSXB9PemUFLdUKEgupa
        U97PBzNwzNmpcpMeIqxwpItqeHzoT9tH6UObOXCzJg==
X-Google-Smtp-Source: APBJJlFDeeobTYnzUvjxmtkYRP6WYbZgY+v3A6Ooy7WVq5IX/yf+RwYi1xQ5rYaKoTw+cyA52VX00Q==
X-Received: by 2002:a05:6358:921c:b0:133:84c:183b with SMTP id d28-20020a056358921c00b00133084c183bmr6561984rwb.3.1690246850219;
        Mon, 24 Jul 2023 18:00:50 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2cbf:9196:a906:e222])
        by smtp.gmail.com with ESMTPSA id h18-20020a62b412000000b00682a75a50e3sm8576900pfn.17.2023.07.24.18.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:00:49 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Mon, 24 Jul 2023 17:59:18 -0700
Subject: [PATCH RFC 4/4] mmc: sdhci-of-dwcmshc: Add support for T-Head
 TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v1-4-cca1b2533da2@baylibre.com>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690246840; l=3367;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=WInr0KFI/7RNGf1vlxj94FbnpVdO/HALVPPXj1tclFA=;
 b=CBoelk9cIZQkR6tFrZ3ZtNCai9EU670gQqx42gBZSNRwfdFkWvgCd5AOai2jGe9yXUz2Wgg+S
 2UO2u/9flbcAZY3uJy/ldFwYzG2mR59LbFDFIOO1M0zIiBQxWyaI9oW
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the T-Head TH1520 SoC mmc controller. The new
compatible "thead,th1520-dwcmshc" enables basic support by:

 - Enabling v4 mode to properly communicate with the mmc device
 - Setting quirk to disable ADMA
 - Setting flag to disable SDMA and force PIO mode
 - Turing .reset op into a no-op as the driver does not yet know how to
   configure the phy. Rely on the vendor u-boot to have configured the
   phy and do not reset the controller in Linux.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..8573aff25a81 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -337,6 +337,14 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	/*
+	 * MMC controller and phy is configured by vendor u-boot so
+	 * take the simplistic approach of not doing reset in Linux.
+	 */
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -355,6 +363,15 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= th1520_sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+};
+
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
@@ -378,6 +395,13 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
+	.ops = &sdhci_dwcmshc_th1520_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_BROKEN_DMA |
+		  SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
@@ -434,6 +458,10 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 }
 
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{
+		.compatible = "thead,th1520-dwcmshc",
+		.data = &sdhci_dwcmshc_th1520_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
@@ -546,6 +574,20 @@ static int dwcmshc_probe(struct platform_device *pdev)
 		sdhci_enable_v4_mode(host);
 #endif
 
+	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
+		/*
+		 * The controller needs v4 mode enabled to properly
+		 * communicate with the mmc device.
+		 */
+		sdhci_enable_v4_mode(host);
+
+		/*
+		 * Set flag so the SDHCI host core will disable DMA
+		 * and use PIO mode.
+		 */
+		host->flags &= ~SDHCI_USE_SDMA;
+	}
+
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
 	err = sdhci_setup_host(host);

-- 
2.34.1

