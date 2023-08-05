Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E19770D7B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjHEDPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEDPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:15:23 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C714EFA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:15:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58653c9bed3so31216567b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 20:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691205318; x=1691810118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEssXYylfcRLmvvX1PZG2lu6ghbesKpJSC9p5adyHlA=;
        b=m9TtZJ1YmohVrBqx1ywbr5GBxv0KyDKRkVTU5LjuOxCDvyGTtIRPk8eDBsCnXpaTv6
         bDOVdW47NOTUB/o+ONbX1F3pk31OVZ4mpauAPhPjw3sdXoMx8A94F3T0eqjaZrl6fvOu
         XzQh37oi/b1Ax7rxktrIIhr8xf0B4vTDsmo95LxxLXBbO8194iIEvzUhZAlSYCGaD0o1
         QBPdht05rks7sguZNvMQkvL8ryiE2tZiwntkqXPCTHgR6/z08sUYmMjEgotsIcDIDlOK
         7uAGUgx66thNik6NJeSg+5xkOyW2xGBijCedZXlkn59t5W2jZ0a2+56EMVBO1be6x/9I
         fEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205318; x=1691810118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEssXYylfcRLmvvX1PZG2lu6ghbesKpJSC9p5adyHlA=;
        b=UPT3GttU0zSGzVfELrzWOEJn2EZPt0WlVtozYyxhYqjzy872Jpw5DQ1m/H3odIcE9O
         feLF0QQYRDAUgSwFZfN2M5xfWPwCICf+hQXCvkM1DyKLZrP9KoMTwO2HFnCGH7IYQJmi
         leNaQLD43CDBvlLZUzTpTvZEHrE1JndB9tLStWw/RvGpEIEA/hrgbSyEEzuMffRMmKjK
         2sIy6Cih/oc6BY7Iu6a3GlQgF6PsExO9rHkA7WmjuqFzFz+bfURif80f5LJQTc14kCcR
         Mc9JlnU1sPPceweRnH0PqLGzbDjEMrtwFQviHaf2sj1Bp8Nvp9shOlru/YDTKD19m/Vt
         N2Dg==
X-Gm-Message-State: AOJu0Ywqg7dnC089G9QQU1ppEAUbpJrqCLKWeHvZuEGOtrl8KkvtEp/R
        7qiev3WdDJ2VAYjtPwUn7QxH5w==
X-Google-Smtp-Source: AGHT+IFAXu64bzecYiS+zN/VXMBk3AC5ZlmcVnM+1xblHJbWf+j87Akk84lYhrAdjvR++C3mLJEyiw==
X-Received: by 2002:a81:73c1:0:b0:584:3140:fcae with SMTP id o184-20020a8173c1000000b005843140fcaemr3730178ywc.26.1691205317838;
        Fri, 04 Aug 2023 20:15:17 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:e1a0:2f9c:e6f9:e66c])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm2412145plf.154.2023.08.04.20.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:15:17 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Fri, 04 Aug 2023 20:14:48 -0700
Subject: [PATCH RFC v2 4/4] mmc: sdhci-of-dwcmshc: Add support for T-Head
 TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-th1520-emmc-v2-4-132ed2e2171e@baylibre.com>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
In-Reply-To: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691205312; l=13837;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=2qncJ7KYiC6cdlh9U1u79nbaJbz5Do2OWKzGmquv4Hg=;
 b=x18Ag9S9tpvglqxWeMu1+55X8RMK2dlAxP4Wck4uOyOeduvak2HIHLu/kPuICDq1QsaM5FjJU
 SmigiE0+XY+AvLIODqc73iGWveWL60ijMzNMO6Iq58nJRmiHI0Jxn/K
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the T-Head TH1520 SoC mmc controller with the new
compatible "thead,th1520-dwcmshc".

However, quirks are currently set to disable DMA and use PIO. The proper
settings for DMA support still need to be determined.

Another issue is th1520-specific code for MMC_TIMING_MMC_HS400 in
dwcmshc_set_uhs_signaling() will run on all platforms which is not
correct. One solution could be to add a th1520 flag to dwcmshc_priv but
that is hacky. Another solution could be to set the set_uhs_signaling op
in sdhci_dwcmshc_th1520_ops to a th1520-specific function. However, that
new function would have to duplicate all the code in the current
dwcmshc_set_uhs_signaling().

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 336 ++++++++++++++++++++++++++++++++++++
 1 file changed, 336 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..d35e204cdb16 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -71,6 +71,63 @@
 	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
 #define RK35xx_MAX_CLKS 3
 
+/* T-Head specific registers */
+#define DWC_MSHC_PTR_PHY_R	0x300
+#define PHY_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x00)
+#define PHY_RSTN		0x0
+#define PAD_SP			0x10
+#define PAD_SN			0x14
+
+#define PHY_CMDPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x04)
+#define PHY_DATAPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x06)
+#define PHY_CLKPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x08)
+#define PHY_STBPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0a)
+#define PHY_RSTNPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0c)
+#define RXSEL			0x0
+#define WEAKPULL_EN		0x3
+#define TXSLEW_CTRL_P		0x5
+#define TXSLEW_CTRL_N		0x9
+
+#define PHY_PADTEST_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0e)
+#define PHY_PADTEST_OUT_R	(DWC_MSHC_PTR_PHY_R + 0x10)
+#define PHY_PADTEST_IN_R	(DWC_MSHC_PTR_PHY_R + 0x12)
+#define PHY_PRBS_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x18)
+#define PHY_PHYLBK_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x1a)
+#define PHY_COMMDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x1c)
+
+#define PHY_SDCLKDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x1d)
+#define UPDATE_DC		0x4
+
+#define PHY_SDCLKDL_DC_R	(DWC_MSHC_PTR_PHY_R + 0x1e)
+#define PHY_SMPLDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x20)
+#define PHY_ATDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x21)
+#define INPSEL_CNFG		2
+
+#define PHY_DLL_CTRL_R		(DWC_MSHC_PTR_PHY_R + 0x24)
+#define DLL_EN			0x0
+
+#define PHY_DLL_CNFG1_R		(DWC_MSHC_PTR_PHY_R + 0x25)
+#define PHY_DLL_CNFG2_R		(DWC_MSHC_PTR_PHY_R + 0x26)
+#define PHY_DLLDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x28)
+#define SLV_INPSEL		0x5
+
+#define P_VENDOR_SPECIFIC_AREA	0x500
+#define EMMC_CTRL_R		(P_VENDOR_SPECIFIC_AREA + 0x2c)
+#define AT_CTRL_R		(P_VENDOR_SPECIFIC_AREA + 0x40)
+#define AT_EN			0x0
+#define CI_SEL			0x1
+#define SWIN_TH_EN		0x2
+#define RPT_TUNE_ERR		0x3
+#define SW_TUNE_EN		0x4
+#define WIN_EDGE_SEL		0x8
+#define TUNE_CLK_STOP_EN	0x10
+#define PRE_CHANGE_DLY		0x11
+#define POST_CHANGE_DLY		0x13
+#define SWIN_TH_VAL		0x18
+
+#define DELAY_LINE_HS400	24
+#define DELAY_LINE_DEFAULT	50
+
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
 
@@ -91,6 +148,10 @@ struct dwcmshc_priv {
 	struct clk	*bus_clk;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
 	void *priv; /* pointer to SoC private stuff */
+	uint32_t delay_line;
+	bool non_removable;
+	bool pull_up_en;
+	bool io_fixed_1v8;
 };
 
 /*
@@ -156,11 +217,171 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static void sdhci_phy_1_8v_init_no_pull(struct sdhci_host *host)
+{
+	uint32_t val;
+	sdhci_writel(host, 1, DWC_MSHC_PTR_PHY_R);
+	sdhci_writeb(host, 1 << 4, PHY_SDCLKDL_CNFG_R);
+	sdhci_writeb(host, 0x40, PHY_SDCLKDL_DC_R);
+
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(1 << 4);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+
+	val = sdhci_readw(host, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val | 1, PHY_CMDPAD_CNFG_R);
+
+	val = sdhci_readw(host, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val | 1, PHY_DATAPAD_CNFG_R);
+
+	val = sdhci_readw(host, PHY_RSTNPAD_CNFG_R);
+	sdhci_writew(host, val | 1, PHY_RSTNPAD_CNFG_R);
+
+	val = sdhci_readw(host, PHY_STBPAD_CNFG_R);
+	sdhci_writew(host, val | 1, PHY_STBPAD_CNFG_R);
+
+	val = sdhci_readb(host, PHY_DLL_CTRL_R);
+	sdhci_writeb(host, val | 1, PHY_DLL_CTRL_R);
+}
+
+static void sdhci_phy_3_3v_init_no_pull(struct sdhci_host *host)
+{
+	uint32_t val;
+
+	sdhci_writel(host, 1, DWC_MSHC_PTR_PHY_R);
+	sdhci_writeb(host, 1 << 4, PHY_SDCLKDL_CNFG_R);
+	sdhci_writeb(host, 0x40, PHY_SDCLKDL_DC_R);
+
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(1 << 4);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+	val = sdhci_readw(host, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val | 2, PHY_CMDPAD_CNFG_R);
+
+	val = sdhci_readw(host, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val | 2, PHY_DATAPAD_CNFG_R);
+
+	val = sdhci_readw(host, PHY_RSTNPAD_CNFG_R);
+	sdhci_writew(host, val | 2, PHY_RSTNPAD_CNFG_R);
+
+	val = sdhci_readw(host, PHY_STBPAD_CNFG_R);
+	sdhci_writew(host, val | 2, PHY_STBPAD_CNFG_R);
+
+	val = sdhci_readb(host, PHY_DLL_CTRL_R);
+	sdhci_writeb(host, val | 1, PHY_DLL_CTRL_R);
+}
+
+static void th1520_phy_1_8v_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+
+	if (!priv)
+		return;
+
+	if (priv->pull_up_en == 0) {
+		sdhci_phy_1_8v_init_no_pull(host);
+		return;
+	}
+
+	/* set driving force */
+	sdhci_writel(host, (1 << PHY_RSTN) | (0xc << PAD_SP) | (0xc << PAD_SN), PHY_CNFG_R);
+
+	/* disable delay lane */
+	sdhci_writeb(host, 1 << UPDATE_DC, PHY_SDCLKDL_CNFG_R);
+
+	/* set delay lane */
+	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
+	sdhci_writeb(host, 0xa, PHY_DLL_CNFG2_R);
+
+	/* enable delay lane */
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(1 << UPDATE_DC);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+	val = (1 << RXSEL) | (1 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = (1 << RXSEL) | (2 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	/* enable data strobe mode */
+	sdhci_writeb(host, 3 << SLV_INPSEL, PHY_DLLDL_CNFG_R);
+	sdhci_writeb(host, (1 << DLL_EN),  PHY_DLL_CTRL_R);
+}
+
+static void th1520_phy_3_3v_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+
+	if (priv->pull_up_en == 0) {
+		sdhci_phy_3_3v_init_no_pull(host);
+		return;
+	}
+
+	/* set driving force */
+	sdhci_writel(host, (1 << PHY_RSTN) | (0xc << PAD_SP) | (0xc << PAD_SN), PHY_CNFG_R);
+
+	/* disable delay lane */
+	sdhci_writeb(host, 1 << UPDATE_DC, PHY_SDCLKDL_CNFG_R);
+
+	/* set delay lane */
+	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
+	sdhci_writeb(host, 0xa, PHY_DLL_CNFG2_R);
+
+	/* enable delay lane */
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(1 << UPDATE_DC);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+	val = (2 << RXSEL) | (1 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = (2 << RXSEL) | (2 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+}
+
+
+static void th1520_sdhci_set_phy(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u8 emmc_ctl;
+
+	/* Before power on, set PHY configs */
+	emmc_ctl = sdhci_readw(host, EMMC_CTRL_R);
+	if (priv->non_removable) {
+		th1520_phy_1_8v_init(host);
+		emmc_ctl |= (1 << DWCMSHC_CARD_IS_EMMC);
+	} else {
+		th1520_phy_3_3v_init(host);
+		emmc_ctl &=~(1 << DWCMSHC_CARD_IS_EMMC);
+	}
+	sdhci_writeb(host, emmc_ctl, EMMC_CTRL_R);
+	sdhci_writeb(host, 0x25, PHY_DLL_CNFG1_R);
+}
+
 static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 				      unsigned int timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
 	u16 ctrl, ctrl_2;
 
 	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -188,7 +409,22 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 		ctrl_2 |= DWCMSHC_CTRL_HS400;
 	}
 
+	if (priv->io_fixed_1v8)
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	/* TODO: add check so that this only runs on th1520  */
+	if (timing == MMC_TIMING_MMC_HS400) {
+		/* disable auto tuning */
+		u32 reg = sdhci_readl(host, AT_CTRL_R);
+		reg &= ~1;
+		sdhci_writel(host, reg, AT_CTRL_R);
+		priv->delay_line = DELAY_LINE_HS400;
+		th1520_sdhci_set_phy(host);
+	} else {
+		sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
+	}
 }
 
 static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -337,6 +573,49 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	u32 val = 0;
+
+	sdhci_writeb(host, 3 << INPSEL_CNFG, PHY_ATDL_CNFG_R);
+
+	val = sdhci_readl(host, AT_CTRL_R);
+	val &= ~((1 << CI_SEL) | (1 << RPT_TUNE_ERR) \
+	    | (1 << SW_TUNE_EN) |(0xf << WIN_EDGE_SEL));
+	val |= (1 << AT_EN) | (1 << SWIN_TH_EN) | (1 << TUNE_CLK_STOP_EN)\
+	    | (1 << PRE_CHANGE_DLY) | (3 << POST_CHANGE_DLY) | (9 << SWIN_TH_VAL);
+
+	sdhci_writel(host, val, AT_CTRL_R);
+
+	val = sdhci_readl(host, AT_CTRL_R);
+	if(!(val & (1 << AT_EN))) {
+		pr_warn("%s(): auto tuning is not enabled", __func__);
+		return -1;
+	}
+
+	val &= ~(1 << AT_EN);
+	sdhci_writel(host, val, AT_CTRL_R);
+
+	return 0;
+}
+
+static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl_2;
+
+	sdhci_reset(host, mask);
+
+	if(priv->io_fixed_1v8){
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if(! (ctrl_2 & SDHCI_CTRL_VDD_180)){
+			ctrl_2 |= SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		}
+	}
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -355,6 +634,17 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= th1520_sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.voltage_switch		= th1520_phy_1_8v_init,
+	.platform_execute_tuning = &th1520_execute_tuning,
+};
+
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
 	.ops = &sdhci_dwcmshc_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
@@ -378,6 +668,15 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
+	.ops = &sdhci_dwcmshc_th1520_ops,
+
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_BROKEN_DMA |
+		  SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
@@ -434,6 +733,10 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
 }
 
 static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{
+		.compatible = "thead,th1520-dwcmshc",
+		.data = &sdhci_dwcmshc_th1520_pdata,
+	},
 	{
 		.compatible = "rockchip,rk3588-dwcmshc",
 		.data = &sdhci_dwcmshc_rk35xx_pdata,
@@ -541,6 +844,39 @@ static int dwcmshc_probe(struct platform_device *pdev)
 			goto err_clk;
 	}
 
+	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
+
+		priv->delay_line = DELAY_LINE_DEFAULT;
+
+		if (device_property_present(&pdev->dev, "non-removable"))
+			priv->non_removable = 1;
+		else
+			priv->non_removable = 0;
+
+		if (device_property_present(&pdev->dev, "thead,pull-up"))
+			priv->pull_up_en = 1;
+		else
+			priv->pull_up_en = 0;
+
+		if (device_property_present(&pdev->dev, "thead,io-fixed-1v8"))
+			priv->io_fixed_1v8 = true;
+		else
+			priv->io_fixed_1v8 = false;
+
+		/*
+		 * start_signal_voltage_switch() will try 3.3V first
+		 * then 1.8V. Use SDHCI_SIGNALING_180 ranther than
+		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+		 * in sdhci_start_signal_voltage_switch().
+		 */
+		if(priv->io_fixed_1v8){
+			host->flags &=~SDHCI_SIGNALING_330;
+			host->flags |= SDHCI_SIGNALING_180;
+		}
+
+		sdhci_enable_v4_mode(host);
+	}
+
 #ifdef CONFIG_ACPI
 	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
 		sdhci_enable_v4_mode(host);

-- 
2.34.1

