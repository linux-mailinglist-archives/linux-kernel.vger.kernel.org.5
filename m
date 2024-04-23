Return-Path: <linux-kernel+bounces-155881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C4B8AF872
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8882896F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F714601D;
	Tue, 23 Apr 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwVujnsM"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DC14535C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905429; cv=none; b=MELI1U9HPE6Yrjcc3WbhIRNa0TTdP2W9XKD8TwjGhc7DOE3ReWHd/mRdCGd+W47mQ/9BXrwhIsM6/kFznLLG4sTGjvwMj+VToWgdfpqhkd3cIaGD3ZEIrfkNT0yYTlwF2Xm1GyvFtB8u3lkFzpX1ky+gKnHHYziPXgIkxQKCT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905429; c=relaxed/simple;
	bh=Uj1O3pQEN0x46UEA2PWfu8EoeW5SdIVCqFLPF2saoVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5k+NUWaWhh9AOPk6ZdnhmzleRMDpUCr4wqJvTEM8tdhTxurCqgi6YQ9BHv2d8KhpjL0lVkj2boUE1CjBFbP+D27nRjnYbgZeluVpnGS3sT6y4cugolyTiAwEkzN+/Wyv3sXwnpAoLKZQkl4aIr+gHxiNAXKeQYf7Z4bOCAk1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MwVujnsM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a523e2888so20528445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905426; x=1714510226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xrx7MPXOj3NqXusEBmUazechT1mcRszwnEutRYxamtU=;
        b=MwVujnsMWbGSN9UsbPtEBOAdSNFn5WhU1srr50TfrQX75EoZXxWGmoH4VwKFzH20rI
         ONdRKaSIWQqiKHgTk9GRVfVCGLGMJ7dpGUJRBZOPRWP5N+qGV9jhpo9ZyHKf1z6pCI9J
         BkEGR9gsCfxox2V8XR7guDJ1oeg7lNfTPEoIFSVPjiEGzKkfgakI7q8XnBa5yQax3HF1
         4EKpCVVOiJG7nObmPKDQgZ4riDAAp+uDGHOFnEeYT7D77Q9sGYe7IIHmbg/E5A/MBoWx
         ddTGAOQBnBH/3bhg93yNRD5EDMsh8TBVW6PH5+tt/TIXBVqhpHsK4YRiA9JKv4ZuCm0t
         XOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905426; x=1714510226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xrx7MPXOj3NqXusEBmUazechT1mcRszwnEutRYxamtU=;
        b=C8QuKN9dppXo8Z1XxSQ6UBSKzCm5lFLT2hOFUdYHpZM9VgueKbHfyhiB07WEx3stRI
         1X0ic3scjo5c18Z8ztQ/DB0nbMZDBCaf57kqafrV+uB6Tolrxl8L9yw9tsQ71TbVumVy
         cptArQkK5HTcdXatQQjkLWRTwo1/OQ5XteMhmsad1VtGkAobjPGYO67pDoptvuSJ1L21
         2wYGpOy87qY/uPkvkD/DSasZEPrNVTjoRgOk9VNItd3LicFWkMpjcuMuxLRtUSm1k5SR
         H6cXy78URJxkl+vGwPSYZtZgOQFVoXds8PHN7IlwwWI1iqMp5WbP/uas3niiToMmjxTx
         X4jA==
X-Forwarded-Encrypted: i=1; AJvYcCWZy5agJ8QaiO5M1y4503Wgz2A9tp0V9bIGOlu++jsIUd0P1Bd6Yaa034b0xZsHxwQawp/z3nWrX+volTm1juFsXaTGcgmMSYS77a/l
X-Gm-Message-State: AOJu0YxbiBRnKi0PV33PYXQAAtB3zsZHzh+2YFw10b7lzwW+dGhv4iR3
	hQu0t248AC+ljEfq6EBmPNVKl0uvgvaHCfxbyw7BY8hsXoF0ZwLsvbqw/jCiyZY=
X-Google-Smtp-Source: AGHT+IHTvi8V9VnXzxQ8Vs/Qp/xDG/eKWh50cg0z4PPahvQB9Vq7rXdxS5n6PdcA87kx4VgK9OqjWA==
X-Received: by 2002:a05:600c:22c7:b0:418:ee2:5911 with SMTP id 7-20020a05600c22c700b004180ee25911mr282036wmg.28.1713905425835;
        Tue, 23 Apr 2024 13:50:25 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:4269:2542:5a09:9ca1])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm13065443wmb.41.2024.04.23.13.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:50:25 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 07/14] clk: samsung: gs101: add support for cmu_hsi2
Date: Tue, 23 Apr 2024 21:49:59 +0100
Message-ID: <20240423205006.1785138-8-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240423205006.1785138-1-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CMU_HSI2 is the clock management unit used for the hsi2 block.
HSI stands for High Speed Interface and as such it generates
clocks for PCIe, UFS and MMC card.

This patch adds support for the muxes, dividers, and gates in
cmu_hsi2.

The following clocks are marked CLK_IS_CRITICAL as disabling
them results in an immediate system hang.
CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK
CLK_GOUT_HSI2_LHM_AXI_P_HSI2_I_CLK

The following clocks are marked CLK_IGNORE_UNUSED as they are
needed for UFS to be functional.
CLK_GOUT_HSI2_SSMT_HSI2_ACLK
CLK_GOUT_HSI2_SSMT_HSI2_PCLK
CLK_GOUT_HSI2_LHS_ACEL_D_HSI2_I_CLK
CLK_GOUT_HSI2_SYSMMU_HSI2_CLK_S2
CLK_GOUT_HSI2_XIU_D_HSI2_ACLK
CLK_GOUT_HSI2_XIU_P_HSI2_ACLK

CLK_GOUT_HSI2_GPIO_HSI2_PCLK is marked CLK_IGNORE_UNUSED until
the exynos pinctrl clock patches land then it can be removed.

Some clocks in this unit have very long names. To help with this
the clock name mangling strategy was updated to include removing
the following sub-strings.
- G4X2_DWC_PCIE_CTL_
- G4X1_DWC_PCIE_CTL_
- PCIE_SUB_CTRL_
- INST_0_
- LN05LPE_
- TM_WRAPPER_
- SF_

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

---
Updated regex for clock name mangling
    sed \
        -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|fout_\L\1_pll|' \
        \
        -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_\(.*\)|mout_\L\1_\2|' \
        -e 's|^PLL_CON0_PLL_\(.*\)|mout_pll_\L\1|' \
        -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|mout_\L\1|' \
        -e '/^PLL_CON[1-4]_[^_]\+_/d' \
        -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
        -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
        \
        -e 's|_IPCLKPORT||' \
        -e 's|_RSTNSYNC||' \
        -e 's|_G4X2_DWC_PCIE_CTL||' \
        -e 's|_G4X1_DWC_PCIE_CTL||' \
        -e 's|_PCIE_SUB_CTRL||' \
        -e 's|_INST_0||g' \
        -e 's|_LN05LPE||' \
        -e 's|_TM_WRAPPER||' \
        -e 's|_SF||' \
        \
        -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_\(.*\)|dout_\L\1_\2|' \
        \
        -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_\(.*\)|gout_\L\1_\2|' \
        -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
        -e 's|^gout_[^_]\+_[^_]\+_cmu_\([^_]\+\)_pclk$|gout_\1_\1_pclk|' \
        -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_\(.*\)|gout_\L\1_\2|' \
        -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|gout_\L\1_clk_\L\1_\2|' \
        \
        -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
---
 drivers/clk/samsung/clk-gs101.c | 508 +++++++++++++++++++++++++++++++-
 1 file changed, 507 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index d065e343a85d..983bf52c7165 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -22,6 +22,7 @@
 #define CLKS_NR_MISC	(CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
 #define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
 #define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
+#define CLKS_NR_HSI2	(CLK_GOUT_HSI2_XIU_P_HSI2_ACLK + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
@@ -1919,6 +1920,509 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.nr_clk_regs		= ARRAY_SIZE(apm_clk_regs),
 };
 
+/* ---- CMU_HSI2 ------------------------------------------------------------ */
+
+/* Register Offset definitions for CMU_HSI2 (0x14400000) */
+#define PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER												0x0600
+#define PLL_CON1_MUX_CLKCMU_HSI2_BUS_USER												0x0604
+#define PLL_CON0_MUX_CLKCMU_HSI2_MMC_CARD_USER												0x0610
+#define PLL_CON1_MUX_CLKCMU_HSI2_MMC_CARD_USER												0x0614
+#define PLL_CON0_MUX_CLKCMU_HSI2_PCIE_USER												0x0620
+#define PLL_CON1_MUX_CLKCMU_HSI2_PCIE_USER												0x0624
+#define PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER												0x0630
+#define PLL_CON1_MUX_CLKCMU_HSI2_UFS_EMBD_USER												0x0634
+#define HSI2_CMU_HSI2_CONTROLLER_OPTION													0x0800
+#define CLKOUT_CON_BLK_HSI2_CMU_HSI2_CLKOUT0												0x0810
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN					0x2000
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN					0x2004
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_ACLK								0x2008
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_PCLK								0x200c
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_ACLK								0x2010
+#define CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_PCLK								0x2014
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_D_TZPC_HSI2_IPCLKPORT_PCLK									0x201c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPC_HSI2_IPCLKPORT_PCLK										0x2020
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPIO_HSI2_IPCLKPORT_PCLK										0x2024
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IPCLKPORT_PCLK									0x2028
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHM_AXI_P_HSI2_IPCLKPORT_I_CLK									0x202c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHS_ACEL_D_HSI2_IPCLKPORT_I_CLK									0x2030
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_I_ACLK										0x2034
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_SDCLKIN									0x2038
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG				0x203c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG				0x2040
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG				0x2044
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK				0x2048
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG				0x204c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG				0x2050
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG				0x2054
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK				0x2058
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PHY_UDBG_I_APB_PCLK						0x205c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PIPE_PAL_PCIE_INST_0_I_APB_PCLK				0x2060
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_SF_PCIEPHY210X2_LN05LPE_QCH_TM_WRAPPER_INST_0_I_APB_PCLK	0x2064
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4A_1_IPCLKPORT_I_CLK									0x2068
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4B_1_IPCLKPORT_I_CLK									0x206c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_ACLK										0x2070
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_PCLK										0x2074
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_ACLK									0x2078
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_PCLK									0x207c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_ACLK									0x2080
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_PCLK									0x2084
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_ACLK									0x2088
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_PCLK									0x208c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK									0x2090
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK									0x2094
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK								0x2098
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_OSCCLK_IPCLKPORT_CLK								0x209c
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_ACLK										0x20a0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_PCLK										0x20a4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSMMU_HSI2_IPCLKPORT_CLK_S2									0x20a8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK									0x20ac
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK								0x20b0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_PCLK								0x20b4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_ACLK								0x20b8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_PCLK								0x20bc
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_ACLK								0x20c0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_PCLK								0x20c4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_ACLK								0x20c8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_PCLK								0x20cc
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK										0x20d0
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO									0x20d4
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK									0x20d8
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_D_HSI2_IPCLKPORT_ACLK										0x20dc
+#define CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_P_HSI2_IPCLKPORT_ACLK										0x20e0
+#define DMYQCH_CON_PCIE_GEN4_1_QCH_SCLK_1												0x3000
+#define PCH_CON_LHM_AXI_P_HSI2_PCH													0x3008
+#define PCH_CON_LHS_ACEL_D_HSI2_PCH													0x300c
+#define QCH_CON_D_TZPC_HSI2_QCH														0x3010
+#define QCH_CON_GPC_HSI2_QCH														0x3014
+#define QCH_CON_GPIO_HSI2_QCH														0x3018
+#define QCH_CON_HSI2_CMU_HSI2_QCH													0x301c
+#define QCH_CON_LHM_AXI_P_HSI2_QCH													0x3020
+#define QCH_CON_LHS_ACEL_D_HSI2_QCH													0x3024
+#define QCH_CON_MMC_CARD_QCH														0x3028
+#define QCH_CON_PCIE_GEN4_1_QCH_APB_1													0x302c
+#define QCH_CON_PCIE_GEN4_1_QCH_APB_2													0x3030
+#define QCH_CON_PCIE_GEN4_1_QCH_AXI_1													0x3034
+#define QCH_CON_PCIE_GEN4_1_QCH_AXI_2													0x3038
+#define QCH_CON_PCIE_GEN4_1_QCH_DBG_1													0x303c
+#define QCH_CON_PCIE_GEN4_1_QCH_DBG_2													0x3040
+#define QCH_CON_PCIE_GEN4_1_QCH_PCS_APB													0x3044
+#define QCH_CON_PCIE_GEN4_1_QCH_PMA_APB													0x3048
+#define QCH_CON_PCIE_GEN4_1_QCH_UDBG													0x304c
+#define QCH_CON_PCIE_IA_GEN4A_1_QCH													0x3050
+#define QCH_CON_PCIE_IA_GEN4B_1_QCH													0x3054
+#define QCH_CON_PPMU_HSI2_QCH														0x3058
+#define QCH_CON_QE_MMC_CARD_HSI2_QCH													0x305c
+#define QCH_CON_QE_PCIE_GEN4A_HSI2_QCH													0x3060
+#define QCH_CON_QE_PCIE_GEN4B_HSI2_QCH													0x3064
+#define QCH_CON_QE_UFS_EMBD_HSI2_QCH													0x3068
+#define QCH_CON_SSMT_HSI2_QCH														0x306c
+#define QCH_CON_SSMT_PCIE_IA_GEN4A_1_QCH												0x3070
+#define QCH_CON_SSMT_PCIE_IA_GEN4B_1_QCH												0x3074
+#define QCH_CON_SYSMMU_HSI2_QCH														0x3078
+#define QCH_CON_SYSREG_HSI2_QCH														0x307c
+#define QCH_CON_UASC_PCIE_GEN4A_DBI_1_QCH												0x3080
+#define QCH_CON_UASC_PCIE_GEN4A_SLV_1_QCH												0x3084
+#define QCH_CON_UASC_PCIE_GEN4B_DBI_1_QCH												0x3088
+#define QCH_CON_UASC_PCIE_GEN4B_SLV_1_QCH												0x308c
+#define QCH_CON_UFS_EMBD_QCH														0x3090
+#define QCH_CON_UFS_EMBD_QCH_FMP													0x3094
+#define QUEUE_CTRL_REG_BLK_HSI2_CMU_HSI2												0x3c00
+
+static const unsigned long cmu_hsi2_clk_regs[] __initconst = {
+	PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_BUS_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_MMC_CARD_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_MMC_CARD_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_PCIE_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_PCIE_USER,
+	PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	PLL_CON1_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	HSI2_CMU_HSI2_CONTROLLER_OPTION,
+	CLKOUT_CON_BLK_HSI2_CMU_HSI2_CLKOUT0,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_D_TZPC_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPC_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPIO_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHM_AXI_P_HSI2_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHS_ACEL_D_HSI2_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_I_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_SDCLKIN,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PHY_UDBG_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PIPE_PAL_PCIE_INST_0_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_SF_PCIEPHY210X2_LN05LPE_QCH_TM_WRAPPER_INST_0_I_APB_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4A_1_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4B_1_IPCLKPORT_I_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_OSCCLK_IPCLKPORT_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSMMU_HSI2_IPCLKPORT_CLK_S2,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_PCLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_D_HSI2_IPCLKPORT_ACLK,
+	CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_P_HSI2_IPCLKPORT_ACLK,
+	DMYQCH_CON_PCIE_GEN4_1_QCH_SCLK_1,
+	PCH_CON_LHM_AXI_P_HSI2_PCH,
+	PCH_CON_LHS_ACEL_D_HSI2_PCH,
+	QCH_CON_D_TZPC_HSI2_QCH,
+	QCH_CON_GPC_HSI2_QCH,
+	QCH_CON_GPIO_HSI2_QCH,
+	QCH_CON_HSI2_CMU_HSI2_QCH,
+	QCH_CON_LHM_AXI_P_HSI2_QCH,
+	QCH_CON_LHS_ACEL_D_HSI2_QCH,
+	QCH_CON_MMC_CARD_QCH,
+	QCH_CON_PCIE_GEN4_1_QCH_APB_1,
+	QCH_CON_PCIE_GEN4_1_QCH_APB_2,
+	QCH_CON_PCIE_GEN4_1_QCH_AXI_1,
+	QCH_CON_PCIE_GEN4_1_QCH_AXI_2,
+	QCH_CON_PCIE_GEN4_1_QCH_DBG_1,
+	QCH_CON_PCIE_GEN4_1_QCH_DBG_2,
+	QCH_CON_PCIE_GEN4_1_QCH_PCS_APB,
+	QCH_CON_PCIE_GEN4_1_QCH_PMA_APB,
+	QCH_CON_PCIE_GEN4_1_QCH_UDBG,
+	QCH_CON_PCIE_IA_GEN4A_1_QCH,
+	QCH_CON_PCIE_IA_GEN4B_1_QCH,
+	QCH_CON_PPMU_HSI2_QCH,
+	QCH_CON_QE_MMC_CARD_HSI2_QCH,
+	QCH_CON_QE_PCIE_GEN4A_HSI2_QCH,
+	QCH_CON_QE_PCIE_GEN4B_HSI2_QCH,
+	QCH_CON_QE_UFS_EMBD_HSI2_QCH,
+	QCH_CON_SSMT_HSI2_QCH,
+	QCH_CON_SSMT_PCIE_IA_GEN4A_1_QCH,
+	QCH_CON_SSMT_PCIE_IA_GEN4B_1_QCH,
+	QCH_CON_SYSMMU_HSI2_QCH,
+	QCH_CON_SYSREG_HSI2_QCH,
+	QCH_CON_UASC_PCIE_GEN4A_DBI_1_QCH,
+	QCH_CON_UASC_PCIE_GEN4A_SLV_1_QCH,
+	QCH_CON_UASC_PCIE_GEN4B_DBI_1_QCH,
+	QCH_CON_UASC_PCIE_GEN4B_SLV_1_QCH,
+	QCH_CON_UFS_EMBD_QCH,
+	QCH_CON_UFS_EMBD_QCH_FMP,
+	QUEUE_CTRL_REG_BLK_HSI2_CMU_HSI2,
+};
+
+PNAME(mout_hsi2_ufs_embd_p)	= { "oscclk", "dout_cmu_shared0_div4",
+				    "dout_cmu_shared2_div2", "fout_spare_pll" };
+
+PNAME(mout_hsi2_pcie_p)		= { "oscclk", "dout_cmu_shared2_div2" };
+
+PNAME(mout_hsi2_bus_p)		= { "dout_cmu_shared0_div4",
+				    "dout_cmu_shared1_div4",
+				    "dout_cmu_shared2_div2",
+				    "dout_cmu_shared3_div2",
+				    "fout_spare_pll", "oscclk", "oscclk",
+				    "oscclk" };
+
+PNAME(mout_hsi2_mmc_card_p)	= { "fout_shared2_pll", "fout_shared3_pll",
+				    "dout_cmu_shared0_div4", "fout_spare_pll" };
+
+PNAME(mout_hsi2_bus_user_p)	= { "oscclk", "dout_cmu_hsi2_bus" };
+PNAME(mout_hsi2_mmc_card_user_p) = { "oscclk", "dout_cmu_hsi2_mmc_card" };
+PNAME(mout_hsi2_pcie_user_p)	= { "oscclk", "dout_cmu_hsi2_pcie" };
+PNAME(mout_hsi2_ufs_embd_user_p) = { "oscclk", "dout_cmu_hsi2_ufs_embd" };
+
+static const struct samsung_mux_clock hsi2_mux_clks[] __initconst = {
+	MUX(CLK_MOUT_HSI2_BUS_USER, "mout_hsi2_bus_user", mout_hsi2_bus_user_p,
+	    PLL_CON0_MUX_CLKCMU_HSI2_BUS_USER, 4, 1),
+	MUX(CLK_MOUT_HSI2_MMC_CARD_USER, "mout_hsi2_mmc_card_user",
+	    mout_hsi2_mmc_card_user_p, PLL_CON0_MUX_CLKCMU_HSI2_MMC_CARD_USER,
+	    4, 1),
+	MUX(CLK_MOUT_HSI2_PCIE_USER, "mout_hsi2_pcie_user",
+	    mout_hsi2_pcie_user_p, PLL_CON0_MUX_CLKCMU_HSI2_PCIE_USER,
+	    4, 1),
+	MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_hsi2_ufs_embd_user",
+	    mout_hsi2_ufs_embd_user_p, PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER,
+	    4, 1),
+};
+
+static const struct samsung_gate_clock hsi2_gate_clks[] __initconst = {
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_PHY_REFCLK_IN,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_phy_refclk_in",
+	     "mout_hsi2_pcie_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_PHY_REFCLK_IN,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_phy_refclk_in",
+	     "mout_hsi2_pcie_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_PHY_REFCLK_IN,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_ACLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4a_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4A_1_PCLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4a_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4A_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4B_1_ACLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4b_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_SSMT_PCIE_IA_GEN4B_1_PCLK,
+	     "gout_hsi2_ssmt_pcie_ia_gen4b_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_CLK_BLK_HSI2_UID_SSMT_PCIE_IA_GEN4B_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_D_TZPC_HSI2_PCLK,
+	     "gout_hsi2_d_tzpc_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_D_TZPC_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_GPC_HSI2_PCLK,
+	     "gout_hsi2_gpc_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPC_HSI2_IPCLKPORT_PCLK, 21, 0, 0),
+	GATE(CLK_GOUT_HSI2_GPIO_HSI2_PCLK,
+	     "gout_hsi2_gpio_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_GPIO_HSI2_IPCLKPORT_PCLK, 21,
+	     CLK_IGNORE_UNUSED, 0),
+	/* Disabling this clock makes the system hang. Mark the clock as critical. */
+	GATE(CLK_GOUT_HSI2_HSI2_CMU_HSI2_PCLK,
+	     "gout_hsi2_hsi2_cmu_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_HSI2_CMU_HSI2_IPCLKPORT_PCLK,
+	     21, CLK_IS_CRITICAL, 0),
+	/* Disabling this clock makes the system hang. Mark the clock as critical. */
+	GATE(CLK_GOUT_HSI2_LHM_AXI_P_HSI2_I_CLK,
+	     "gout_hsi2_lhm_axi_p_hsi2_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHM_AXI_P_HSI2_IPCLKPORT_I_CLK,
+	     21, CLK_IS_CRITICAL, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_LHS_ACEL_D_HSI2_I_CLK,
+	     "gout_hsi2_lhs_acel_d_hsi2_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_LHS_ACEL_D_HSI2_IPCLKPORT_I_CLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI2_MMC_CARD_I_ACLK,
+	     "gout_hsi2_mmc_card_i_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_I_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_MMC_CARD_SDCLKIN,
+	     "gout_hsi2_mmc_card_sdclkin", "mout_hsi2_mmc_card_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_MMC_CARD_IPCLKPORT_SDCLKIN,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_DBI_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_dbi_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_MSTR_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_mstr_aclk_ug",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_SLV_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_slv_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_G4X2_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_003_I_DRIVER_APB_CLK,
+	     "gout_hsi2_pcie_gen4_1_pcie_003_i_driver_apb_clk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_003_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_DBI_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_dbi_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_DBI_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_MSTR_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_mstr_aclk_ug",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_MSTR_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_SLV_ACLK_UG,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_slv_aclk_ug", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_G4X1_DWC_PCIE_CTL_INST_0_SLV_ACLK_UG,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCIE_004_I_DRIVER_APB_CLK,
+	     "gout_hsi2_pcie_gen4_1_pcie_004_i_driver_apb_clk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCIE_004_PCIE_SUB_CTRL_INST_0_I_DRIVER_APB_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PHY_UDBG_I_APB_PCLK,
+	     "gout_hsi2_pcie_gen4_1_pcs_pma_phy_udbg_i_apb_pclk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PHY_UDBG_I_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PIPE_PAL_PCIE_I_APB_PCLK,
+	     "gout_hsi2_pcie_gen4_1_pcs_pma_pipe_pal_pcie_i_apb_pclk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_PIPE_PAL_PCIE_INST_0_I_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_GEN4_1_PCS_PMA_PCIEPHY210X2_QCH_I_APB_PCLK,
+	     "gout_hsi2_pcie_gen4_1_pcs_pma_pciephy210x2_qch_i_apb_pclk",
+	     "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_GEN4_1_IPCLKPORT_PCS_PMA_INST_0_SF_PCIEPHY210X2_LN05LPE_QCH_TM_WRAPPER_INST_0_I_APB_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_IA_GEN4A_1_I_CLK,
+	     "gout_hsi2_pcie_ia_gen4a_1_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4A_1_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PCIE_IA_GEN4B_1_I_CLK,
+	     "gout_hsi2_pcie_ia_gen4b_1_i_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PCIE_IA_GEN4B_1_IPCLKPORT_I_CLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PPMU_HSI2_ACLK,
+	     "gout_hsi2_ppmu_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_PPMU_HSI2_PCLK,
+	     "gout_hsi2_ppmu_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_PPMU_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_MMC_CARD_HSI2_ACLK,
+	     "gout_hsi2_qe_mmc_card_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_MMC_CARD_HSI2_PCLK,
+	     "gout_hsi2_qe_mmc_card_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_MMC_CARD_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4A_HSI2_ACLK,
+	     "gout_hsi2_qe_pcie_gen4a_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4A_HSI2_PCLK,
+	     "gout_hsi2_qe_pcie_gen4a_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4A_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4B_HSI2_ACLK,
+	     "gout_hsi2_qe_pcie_gen4b_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_PCIE_GEN4B_HSI2_PCLK,
+	     "gout_hsi2_qe_pcie_gen4b_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_PCIE_GEN4B_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_ACLK,
+	     "gout_hsi2_qe_ufs_embd_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_QE_UFS_EMBD_HSI2_PCLK,
+	     "gout_hsi2_qe_ufs_embd_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_QE_UFS_EMBD_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_CLK_HSI2_BUS_CLK,
+	     "gout_hsi2_clk_hsi2_bus_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_BUS_IPCLKPORT_CLK,
+	     21, CLK_IS_CRITICAL, 0),
+	GATE(CLK_GOUT_HSI2_CLK_HSI2_OSCCLK_CLK,
+	     "gout_hsi2_clk_hsi2_oscclk_clk", "oscclk",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_RSTNSYNC_CLK_HSI2_OSCCLK_IPCLKPORT_CLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_SSMT_HSI2_ACLK,
+	     "gout_hsi2_ssmt_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_SSMT_HSI2_PCLK,
+	     "gout_hsi2_ssmt_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SSMT_HSI2_IPCLKPORT_PCLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_SYSMMU_HSI2_CLK_S2,
+	     "gout_hsi2_sysmmu_hsi2_clk_s2", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSMMU_HSI2_IPCLKPORT_CLK_S2,
+	     21, CLK_IGNORE_UNUSED, 0),
+	GATE(CLK_GOUT_HSI2_SYSREG_HSI2_PCLK,
+	     "gout_hsi2_sysreg_hsi2_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_SYSREG_HSI2_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4a_dbi_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_DBI_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4a_dbi_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_DBI_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_SLV_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4a_slv_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4A_SLV_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4a_slv_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4A_SLV_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_DBI_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4b_dbi_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_DBI_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4b_dbi_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_DBI_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_SLV_1_ACLK,
+	     "gout_hsi2_uasc_pcie_gen4b_slv_1_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UASC_PCIE_GEN4B_SLV_1_PCLK,
+	     "gout_hsi2_uasc_pcie_gen4b_slv_1_pclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UASC_PCIE_GEN4B_SLV_1_IPCLKPORT_PCLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_ACLK,
+	     "gout_hsi2_ufs_embd_i_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_ACLK,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_CLK_UNIPRO,
+	     "gout_hsi2_ufs_embd_i_clk_unipro", "mout_hsi2_ufs_embd_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_CLK_UNIPRO,
+	     21, 0, 0),
+	GATE(CLK_GOUT_HSI2_UFS_EMBD_I_FMP_CLK,
+	     "gout_hsi2_ufs_embd_i_fmp_clk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_UFS_EMBD_IPCLKPORT_I_FMP_CLK,
+	     21, 0, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_XIU_D_HSI2_ACLK,
+	     "gout_hsi2_xiu_d_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_D_HSI2_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+	/* TODO: should have a driver for this */
+	GATE(CLK_GOUT_HSI2_XIU_P_HSI2_ACLK,
+	     "gout_hsi2_xiu_p_hsi2_aclk", "mout_hsi2_bus_user",
+	     CLK_CON_GAT_GOUT_BLK_HSI2_UID_XIU_P_HSI2_IPCLKPORT_ACLK,
+	     21, CLK_IGNORE_UNUSED, 0),
+};
+
+static const struct samsung_cmu_info hsi2_cmu_info __initconst = {
+	.mux_clks		= hsi2_mux_clks,
+	.nr_mux_clks		= ARRAY_SIZE(hsi2_mux_clks),
+	.gate_clks		= hsi2_gate_clks,
+	.nr_gate_clks		= ARRAY_SIZE(hsi2_gate_clks),
+	.nr_clk_ids		= CLKS_NR_HSI2,
+	.clk_regs		= cmu_hsi2_clk_regs,
+	.nr_clk_regs		= ARRAY_SIZE(cmu_hsi2_clk_regs),
+	.clk_name		= "bus",
+};
+
 /* ---- CMU_MISC ------------------------------------------------------------ */
 
 /* Register Offset definitions for CMU_MISC (0x10010000) */
@@ -3426,13 +3930,15 @@ static const struct of_device_id gs101_cmu_of_match[] = {
 	{
 		.compatible = "google,gs101-cmu-apm",
 		.data = &apm_cmu_info,
+	}, {
+		.compatible = "google,gs101-cmu-hsi2",
+		.data = &hsi2_cmu_info,
 	}, {
 		.compatible = "google,gs101-cmu-peric0",
 		.data = &peric0_cmu_info,
 	}, {
 		.compatible = "google,gs101-cmu-peric1",
 		.data = &peric1_cmu_info,
-	}, {
 	},
 };
 
-- 
2.44.0.769.g3c40516874-goog


