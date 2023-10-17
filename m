Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C927CCE74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbjJQUpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344448AbjJQUph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:45:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54AC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578b4981526so3714164a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697575524; x=1698180324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/vQean35NZiX4Adx6WA7MvBPVGy6z3DmhFpuSBfQYo=;
        b=G1qZ2pWWd3qJvEnSb1CJUOO/WufZ95HCFy76p/1ZBDipeWPDwIxIyOLHS8xn+HcIlL
         7+hdas5ao+QwfhqRXSMSpMJ3Xe4iMo3kywDjouvHtbL7khVcPWJhoUgL2TZjYOqWH83q
         3x0qA5bqj50KBSYAFoF3Gn9WKxRR5WOONT19SfQ5uC7Rd+1UoUCzaNOU4eSgvoWcXrjG
         DbhorrLI7NHySiORljp0VlJoiNRElSXfqfk4j8sO5Mi8HeoYB68Crcsb2MMx7RJP+XXz
         jwlcb9Wty+LsaN0nIDmPzGJV0H1NNT7z9coWfJ3ypJ+OxoldahvwvXBO8SB+aLZ1F8Vo
         ScXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575524; x=1698180324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/vQean35NZiX4Adx6WA7MvBPVGy6z3DmhFpuSBfQYo=;
        b=kjVkA6a0NXt+tbuq0MUbDqwnWh/nR8Ltq7bbSFwyQdnIS7tiM5yNRC7ZK7VEi4gVWz
         4Wxb6BFI/gBYtTx86aB+ngFEbT5UfORk8CjPMkITetuUFlOAOQ+Biio1hx03pFrqf/oA
         yZjKARmGBsp3XKmBtLwASiX9dIQx9GNcFwFVp27MWozU66kpUp5tFyF1yuEIuLUyuynp
         BTxNqu24C8rC7RHPbB+oLRJIiKhdicjWz91ATXvX15f1FHRt/54IdCxqP/0hCNw5+aaT
         VuewENK9eUR6cSWSvy1sWUwXKeHA5rkY61OAheVr5egUGzEzWTyrndQMhtUsV/t3wEF6
         XxVw==
X-Gm-Message-State: AOJu0YyilBIY3OqAqSwSFqpo/FQfarPqhNQdYrFdMvlfhiwrOwRqwKvV
        /Ly0rgjcrtCTENESal3yplB+DA==
X-Google-Smtp-Source: AGHT+IE49JrXAPJSeUrQWilW4sYkwx/WgDUjDuhK1tPN9g86940DczhejL8uGUSdbjVGeT/81fbX9g==
X-Received: by 2002:a05:6a21:329a:b0:17a:eddb:ac65 with SMTP id yt26-20020a056a21329a00b0017aeddbac65mr2942717pzb.9.1697575524240;
        Tue, 17 Oct 2023 13:45:24 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:51d6:dcd6:63ef:52e9])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a6b8300b0027b168cb011sm1906553pjj.56.2023.10.17.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:45:24 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 17 Oct 2023 13:43:49 -0700
Subject: [PATCH v2 3/7] mmc: sdhci-of-dwcmshc: Add support for T-Head
 TH1520
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-th1520-mmc-v2-3-4678c8cc4048@baylibre.com>
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697575515; l=17079;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=vv/AIEuNFqLsZz9JcRtq2XC0MaJKKMJSyowi1Hzu1SE=;
 b=RLo9jDcqXN1sLkkUnNvydK2xg/jjS4hi2QxeKq8WT0X/E/x4ytK1M2GbDGZGyHe+cOvdm6a6+
 I2KbkIN3EMLDvKrvf3Fv8cd9ElZ8YwL2KO9svP/A3XwQiJSXcupk+El
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

Add support for the mmc controller in the T-Head TH1520 with the new
compatible "thead,th1520-dwcmshc". Implement custom sdhci_ops for
set_uhs_signaling, reset, voltage_switch, and platform_execute_tuning.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 358 ++++++++++++++++++++++++++++++++++++
 1 file changed, 358 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 3a3bae6948a8..88ed0937c4e9 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
@@ -35,6 +36,21 @@
 #define DWCMSHC_CARD_IS_EMMC		BIT(0)
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
+/* Tuning and auto-tuning fields in AT_CTRL_R control register */
+#define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
+#define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
+#define AT_CTRL_SWIN_TH_EN		BIT(2) /* sampling window threshold enable */
+#define AT_CTRL_RPT_TUNE_ERR		BIT(3) /* enable reporting framing errors */
+#define AT_CTRL_SW_TUNE_EN		BIT(4) /* enable software managed tuning */
+#define AT_CTRL_WIN_EDGE_SEL_MASK	GENMASK(11, 8) /* bits [11:8] */
+#define AT_CTRL_WIN_EDGE_SEL		0xf /* sampling window edge select */
+#define AT_CTRL_TUNE_CLK_STOP_EN	BIT(16) /* clocks stopped during phase code change */
+#define AT_CTRL_PRE_CHANGE_DLY_MASK	GENMASK(18, 17) /* bits [18:17] */
+#define AT_CTRL_PRE_CHANGE_DLY		0x1  /* 2-cycle latency */
+#define AT_CTRL_POST_CHANGE_DLY_MASK	GENMASK(20, 19) /* bits [20:19] */
+#define AT_CTRL_POST_CHANGE_DLY		0x3  /* 4-cycle latency */
+#define AT_CTRL_SWIN_TH_VAL_MASK	GENMASK(31, 24) /* bits [31:24] */
+#define AT_CTRL_SWIN_TH_VAL		0x9  /* sampling window threshold */
 
 /* Rockchip specific Registers */
 #define DWCMSHC_EMMC_DLL_CTRL		0x800
@@ -72,6 +88,82 @@
 	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
 #define RK35xx_MAX_CLKS 3
 
+/* PHY register area pointer */
+#define DWC_MSHC_PTR_PHY_R	0x300
+
+/* PHY general configuration */
+#define PHY_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x00)
+#define PHY_CNFG_RSTN_DEASSERT	0x1  /* Deassert PHY reset */
+#define PHY_CNFG_PAD_SP_MASK	GENMASK(19, 16) /* bits [19:16] */
+#define PHY_CNFG_PAD_SP		0x0c /* PMOS TX drive strength */
+#define PHY_CNFG_PAD_SN_MASK	GENMASK(23, 20) /* bits [23:20] */
+#define PHY_CNFG_PAD_SN		0x0c /* NMOS TX drive strength */
+
+/* PHY command/response pad settings */
+#define PHY_CMDPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x04)
+
+/* PHY data pad settings */
+#define PHY_DATAPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x06)
+
+/* PHY clock pad settings */
+#define PHY_CLKPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x08)
+
+/* PHY strobe pad settings */
+#define PHY_STBPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0a)
+
+/* PHY reset pad settings */
+#define PHY_RSTNPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0c)
+
+/* Bitfields are common for all pad settings */
+#define PHY_PAD_RXSEL_1V8		0x1 /* Receiver type select for 1.8V */
+#define PHY_PAD_RXSEL_3V3		0x2 /* Receiver type select for 3.3V */
+
+#define PHY_PAD_WEAKPULL_MASK		GENMASK(4, 3) /* bits [4:3] */
+#define PHY_PAD_WEAKPULL_PULLUP		0x1 /* Weak pull down enabled */
+#define PHY_PAD_WEAKPULL_PULLDOWN	0x2 /* Weak pull down enabled */
+
+#define PHY_PAD_TXSLEW_CTRL_P_MASK	GENMASK(8, 5) /* bits [8:5] */
+#define PHY_PAD_TXSLEW_CTRL_P		0x3 /* Slew control for P-Type pad TX */
+#define PHY_PAD_TXSLEW_CTRL_N_MASK	GENMASK(12, 9) /* bits [12:9] */
+#define PHY_PAD_TXSLEW_CTRL_N		0x3 /* Slew control for N-Type pad TX */
+
+/* PHY CLK delay line settings */
+#define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
+#define PHY_SDCLKDL_CNFG_UPDATE	BIT(4) /* set before writing to SDCLKDL_DC */
+
+/* PHY CLK delay line delay code */
+#define PHY_SDCLKDL_DC_R		(DWC_MSHC_PTR_PHY_R + 0x1e)
+#define PHY_SDCLKDL_DC_INITIAL		0x40 /* initial delay code */
+#define PHY_SDCLKDL_DC_DEFAULT		0x32 /* default delay code */
+#define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
+
+/* PHY drift_cclk_rx delay line configuration setting */
+#define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
+#define PHY_ATDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
+#define PHY_ATDL_CNFG_INPSEL		0x3 /* delay line input source */
+
+/* PHY DLL control settings */
+#define PHY_DLL_CTRL_R			(DWC_MSHC_PTR_PHY_R + 0x24)
+#define PHY_DLL_CTRL_DISABLE		0x0 /* PHY DLL is enabled */
+#define PHY_DLL_CTRL_ENABLE		0x1 /* PHY DLL is disabled */
+
+/* PHY DLL  configuration register 1 */
+#define PHY_DLL_CNFG1_R			(DWC_MSHC_PTR_PHY_R + 0x25)
+#define PHY_DLL_CNFG1_SLVDLY_MASK	GENMASK(5, 4) /* bits [5:4] */
+#define PHY_DLL_CNFG1_SLVDLY		0x2 /* DLL slave update delay input */
+#define PHY_DLL_CNFG1_WAITCYCLE		0x5 /* DLL wait cycle input */
+
+/* PHY DLL configuration register 2 */
+#define PHY_DLL_CNFG2_R			(DWC_MSHC_PTR_PHY_R + 0x26)
+#define PHY_DLL_CNFG2_JUMPSTEP		0xa /* DLL jump step input */
+
+/* PHY DLL master and slave delay line configuration settings */
+#define PHY_DLLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x28)
+#define PHY_DLLDL_CNFG_SLV_INPSEL_MASK	GENMASK(6, 5) /* bits [6:5] */
+#define PHY_DLLDL_CNFG_SLV_INPSEL	0x3 /* clock source select for slave DL */
+
+#define FLAG_IO_FIXED_1V8	BIT(0)
+
 #define BOUNDARY_OK(addr, len) \
 	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
 
@@ -92,6 +184,8 @@ struct dwcmshc_priv {
 	struct clk	*bus_clk;
 	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
 	void *priv; /* pointer to SoC private stuff */
+	u16 delay_line;
+	u16 flags;
 };
 
 /*
@@ -157,6 +251,129 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static void th1520_phy_1_8v_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+
+	if (!priv)
+		return;
+
+	/* deassert phy reset & set tx drive strength */
+	val = PHY_CNFG_RSTN_DEASSERT;
+	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
+	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
+	sdhci_writel(host, val, PHY_CNFG_R);
+
+	/* disable delay line */
+	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
+
+	/* set delay line */
+	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
+	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
+
+	/* enable delay lane */
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+	/* configure phy pads */
+	val = PHY_PAD_RXSEL_1V8;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = PHY_PAD_RXSEL_1V8;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	/* enable data strobe mode */
+	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
+		     PHY_DLLDL_CNFG_R);
+
+	/* enable phy dll */
+	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
+}
+
+static void th1520_phy_3_3v_init(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val;
+
+	/* deassert phy reset & set tx drive strength */
+	val = PHY_CNFG_RSTN_DEASSERT;
+	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
+	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
+	sdhci_writel(host, val, PHY_CNFG_R);
+
+	/* disable delay line */
+	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
+
+	/* set delay line */
+	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
+	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
+
+	/* enable delay lane */
+	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
+	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
+	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
+
+	/* configure phy pads */
+	val = PHY_PAD_RXSEL_3V3;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
+	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
+
+	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
+
+	val = PHY_PAD_RXSEL_3V3;
+	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
+	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
+	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
+
+	/* enable phy dll */
+	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
+}
+
+static void th1520_sdhci_set_phy(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u16 emmc_ctrl;
+
+	/* Before power on, set PHY configs */
+	if (priv->flags & FLAG_IO_FIXED_1V8)
+		th1520_phy_1_8v_init(host);
+	else
+		th1520_phy_3_3v_init(host);
+
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
+		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+		emmc_ctrl |= DWCMSHC_CARD_IS_EMMC;
+		sdhci_writew(host, emmc_ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	}
+
+	sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
+		     PHY_DLL_CNFG1_WAITCYCLE, PHY_DLL_CNFG1_R);
+}
+
 static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 				      unsigned int timing)
 {
@@ -189,9 +406,26 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 		ctrl_2 |= DWCMSHC_CTRL_HS400;
 	}
 
+	if (priv->flags & FLAG_IO_FIXED_1V8)
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 }
 
+static void th1520_set_uhs_signaling(struct sdhci_host *host,
+				     unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	dwcmshc_set_uhs_signaling(host, timing);
+	if (timing == MMC_TIMING_MMC_HS400) {
+		priv->delay_line = PHY_SDCLKDL_DC_HS400;
+		th1520_sdhci_set_phy(host);
+	} else {
+		sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
+	}
+}
+
 static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
 					  struct mmc_ios *ios)
 {
@@ -338,6 +572,85 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u32 val = 0;
+
+	if (host->flags & SDHCI_HS400_TUNING)
+		return 0;
+
+	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL),
+		     PHY_ATDL_CNFG_R);
+	val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+
+	/*
+	 * configure tuning settings:
+	 *  - center phase select code driven in block gap interval
+	 *  - disable reporting of framing errors
+	 *  - disable software managed tuning
+	 *  - disable user selection of sampling window edges,
+	 *    instead tuning calculated edges are used
+	 */
+	val &= ~(AT_CTRL_CI_SEL | AT_CTRL_RPT_TUNE_ERR | AT_CTRL_SW_TUNE_EN |
+		 FIELD_PREP(AT_CTRL_WIN_EDGE_SEL_MASK, AT_CTRL_WIN_EDGE_SEL));
+
+	/*
+	 * configure tuning settings:
+	 *  - enable auto-tuning
+	 *  - enable sampling window threshold
+	 *  - stop clocks during phase code change
+	 *  - set max latency in cycles between tx and rx clocks
+	 *  - set max latency in cycles to switch output phase
+	 *  - set max sampling window threshold value
+	 */
+	val |= AT_CTRL_AT_EN | AT_CTRL_SWIN_TH_EN | AT_CTRL_TUNE_CLK_STOP_EN;
+	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, AT_CTRL_PRE_CHANGE_DLY);
+	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY);
+	val |= FIELD_PREP(AT_CTRL_SWIN_TH_VAL_MASK, AT_CTRL_SWIN_TH_VAL);
+
+	sdhci_writel(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+	val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+
+	/* check if is possible to enable auto-tuning */
+	if (!(val & AT_CTRL_AT_EN)) {
+		dev_err(mmc_dev(host->mmc), "failed to enable auto tuning\n");
+		return -EIO;
+	}
+
+	/* perform tuning */
+	sdhci_start_tuning(host);
+	host->tuning_err = __sdhci_execute_tuning(host, opcode);
+	if (host->tuning_err) {
+		/* disable auto-tuning upon tuning error */
+		val &= ~AT_CTRL_AT_EN;
+		sdhci_writel(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+		dev_err(mmc_dev(host->mmc), "tuning failed: %d\n", host->tuning_err);
+		return -EIO;
+	}
+	sdhci_end_tuning(host);
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
+	if (priv->flags & FLAG_IO_FIXED_1V8) {
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl_2 & SDHCI_CTRL_VDD_180)) {
+			ctrl_2 |= SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		}
+	}
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
@@ -356,6 +669,17 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
 	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= th1520_set_uhs_signaling,
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
@@ -379,6 +703,12 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
 		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
+static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
+	.ops = &sdhci_dwcmshc_th1520_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
 static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	int err;
@@ -447,6 +777,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "snps,dwcmshc-sdhci",
 		.data = &sdhci_dwcmshc_pdata,
 	},
+	{
+		.compatible = "thead,th1520-dwcmshc",
+		.data = &sdhci_dwcmshc_th1520_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
@@ -542,6 +876,30 @@ static int dwcmshc_probe(struct platform_device *pdev)
 			goto err_clk;
 	}
 
+	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
+		priv->delay_line = PHY_SDCLKDL_DC_DEFAULT;
+
+		if ((device_property_read_bool(dev, "mmc-ddr-1_8v")) |
+		    (device_property_read_bool(dev, "mmc-hs200-1_8v")) |
+		    (device_property_read_bool(dev, "mmc-hs400-1_8v")))
+			priv->flags |= FLAG_IO_FIXED_1V8;
+		else
+			priv->flags &= ~FLAG_IO_FIXED_1V8;
+
+		/*
+		 * start_signal_voltage_switch() will try 3.3V first
+		 * then 1.8V. Use SDHCI_SIGNALING_180 ranther than
+		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
+		 * in sdhci_start_signal_voltage_switch().
+		 */
+		if (priv->flags & FLAG_IO_FIXED_1V8) {
+			host->flags &= ~SDHCI_SIGNALING_330;
+			host->flags |=  SDHCI_SIGNALING_180;
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

