Return-Path: <linux-kernel+bounces-50933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF1E8483EF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6371C224CE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183C10A31;
	Sat,  3 Feb 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe/IftEM"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335610A09;
	Sat,  3 Feb 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937316; cv=none; b=I66CjnDOyyLNmWso+onOosceBwJSDJoZq3Dvsw1XW2T0bdMXDFiUkYMQRLtyku3Tp/D8fpCFuiGG/KRzD3VDw+AyxxvFHvqtXYm4a96uQQb0hxcAIzO+2f/aDDCKkErFxT29xai0LiJPqLiuaUpPYaAxyEmteuO4KItQOIX0JW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937316; c=relaxed/simple;
	bh=fPbOGXg77mkW7kyUJXKhTzJ1xw3ULkg9SC3yMUThOdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G3S2qKyz9bxFkcZGFjCsrh73MoNOsPGI1fgTzOAb//Oeic1pCMXksXRMfC+qR8oFM+x9UDaL1uTPNzZnjA8XI1OUpqOkYDaKvoxFUOugUYFyd3Z+aR1PFD+kodrpc9cdzj/qHgt5nw5KEnvcy2d+6pbuNO6I3tm9xpl+EvUvqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe/IftEM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2749572a12.1;
        Fri, 02 Feb 2024 21:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706937314; x=1707542114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3LoOjm98tL5WXwbrdlM6AeAwrTcH5b9oPsvdNs4GLQ=;
        b=Qe/IftEMxSrdWNakb3xH42Jim9U3PsEOnUUxXvb1Ow4GiMzGpsxMcKc1vQM+eeINpo
         LW1hUxcFcSy2VJaoSnbv9t7bVEMFUjmDkiMm30l+y6wmHioiVuFJvxWBbGTcJmifjUqa
         ZO9/glvG8ohgUDFLDml2EfFshGjSsxSnhrW7n1rS4sHMCfRauHCaTsDB41BBQBqEcFiM
         WKlaFopOxYIVQZbeQhUMc5Izzi9X4w436z0DrI5JnkgdBZUFMw9kcgdyjDrYhy0N9F4H
         N3RfudHEsdHFHB1kn3rezTXFqCRZtdsFoOwm1+/yRao47bDeJ93goUyxIVQQc1bGBXsE
         vSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706937314; x=1707542114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3LoOjm98tL5WXwbrdlM6AeAwrTcH5b9oPsvdNs4GLQ=;
        b=d5FHxa48VoXib4my7127x8zgHukOIJfytZQtM7sL48WXLx7OTrB5pZA1Fwnr6tMld4
         3PJWe9BA5sm1FzC9U0TJPAQaWGccyO33Xnll4G+RLG/F8l0aMRsk1WBieO4kgaOcVG6G
         2b1qpbtriyoMnQGQiQ4n8wjsL76R5G4OI5zCHhb0dzzGIXZZfbqLMuefvXId+N9DyCpM
         wbUOPTaaJVg5AwfuUAXrDkulDVzxlQnJGml4QDPq0fm+usu4PhzVTlkljbSc1DCVEQxh
         cDB6zc9xIfk51rGszu1/oj/d6pMH+/RU2hrHKKKgGSUXOeP3pIVB7czbNCrDK/9vgvv8
         /5iQ==
X-Gm-Message-State: AOJu0Yx3qURVkERN3x5pkDlR+OejjXmgMPbWJvzgP2TtGvWuFylJux+7
	ZLGkBBuNlCSyt9K9yu/vWe+gp4lDiL4ETytZhXTrDYcnsrzPyC9J
X-Google-Smtp-Source: AGHT+IFsy7NC+LwbxSXX8nF+xBy8EuKZb6n7QVzT5gmpWcym33b+5C9mcmKhQ6iXSb0+ZhywsQW+9g==
X-Received: by 2002:a05:6a20:d045:b0:19c:6ce1:d62b with SMTP id hv5-20020a056a20d04500b0019c6ce1d62bmr5425326pzb.9.1706937313814;
        Fri, 02 Feb 2024 21:15:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW9ZlMmLRvZqAZIKfYVt8wIf1hWyHEwVksGBn/sJCDsSEwkn3duMXTCzXzUsjCr5zXg3lg5jIJd3pgJN3vZT6Kv24gSwXt6Ir5t9DBDrPNNzl9ds/uhd8bsLWcG/jv6ei1omk9dtluYcvtCRhuDxl1TmSqR/e9yl/3duLEBW/4zFqeQR2vHzmDRDyV2jRDxYmYbIjnvc6/SKXnplPDjyeMRnWZGm7KwLYKqoc1pyJa8vnlT6ed+54PHfnnUGpdl7vOizBiNoZLuMGwOTW/rwrFmjAxip23k0bbzRa6XFX02AWi2IB1gRzUdaK6fL+nCnC3pCwwmg/bMXfo6EOroI2pO5lh7n9SktGAcYCfbhSl6yLeJgAxtPpdpMwUhhoXBwQSLkK+DTfCbsNC8vQ6LZb0ftPRPdIXetETbDTRbaLvEh7Yd51RIgQnChOuR0Ix61cbLc5JGryvmILGqXeYCanyE2mtgfUzcrEfSx9EF85rktPtSuf5sh427WKmu6rDrN7cr8DXXciBiSUy1q3bQFhILMbwe+1UprEU=
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id lw10-20020a056a00750a00b006d9aa6592d0sm2549206pfb.82.2024.02.02.21.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 21:15:13 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v4] net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
Date: Sat,  3 Feb 2024 13:14:39 +0800
Message-Id: <20240203051439.1127090-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
XGMAC core") checks and reports safety errors, but leaves the
Data Path Parity Errors for each channel in DMA unhandled at all, lead to
a storm of interrupt.
Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.

Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
Changes in v4:
 - fix a typo name of DDPP bit, thanks Serge Semin

Changes in v3:
 - code style fix, thanks Paolo Abeni

Changes in v2:
  - explicit enable Data Path Parity Protection
  - add new counters to stmmac_safety_stats
  - add detailed log
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 57 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..b4f60ab078d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -216,6 +216,7 @@ struct stmmac_safety_stats {
 	unsigned long mac_errors[32];
 	unsigned long mtl_errors[32];
 	unsigned long dma_errors[32];
+	unsigned long dma_dpp_errors[32];
 };
 
 /* Number of fields in Safety Stats */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 207ff1799f2c..5c67a3f89f08 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -303,6 +303,8 @@
 #define XGMAC_RXCEIE			BIT(4)
 #define XGMAC_TXCEIE			BIT(0)
 #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
+#define XGMAC_MTL_DPP_CONTROL		0x000010e0
+#define XGMAC_DPP_DISABLE		BIT(0)
 #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
 #define XGMAC_TQS			GENMASK(25, 16)
 #define XGMAC_TQS_SHIFT			16
@@ -385,6 +387,7 @@
 #define XGMAC_DCEIE			BIT(1)
 #define XGMAC_TCEIE			BIT(0)
 #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
+#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
 #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
 #define XGMAC_SPH			BIT(24)
 #define XGMAC_PBLx8			BIT(16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index eb48211d9b0e..04d7c4dc2e35 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -830,6 +830,43 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
+static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
+static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
+static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
+	{ true, "TDPES0", dpp_tx_err },
+	{ true, "TDPES1", dpp_tx_err },
+	{ true, "TDPES2", dpp_tx_err },
+	{ true, "TDPES3", dpp_tx_err },
+	{ true, "TDPES4", dpp_tx_err },
+	{ true, "TDPES5", dpp_tx_err },
+	{ true, "TDPES6", dpp_tx_err },
+	{ true, "TDPES7", dpp_tx_err },
+	{ true, "TDPES8", dpp_tx_err },
+	{ true, "TDPES9", dpp_tx_err },
+	{ true, "TDPES10", dpp_tx_err },
+	{ true, "TDPES11", dpp_tx_err },
+	{ true, "TDPES12", dpp_tx_err },
+	{ true, "TDPES13", dpp_tx_err },
+	{ true, "TDPES14", dpp_tx_err },
+	{ true, "TDPES15", dpp_tx_err },
+	{ true, "RDPES0", dpp_rx_err },
+	{ true, "RDPES1", dpp_rx_err },
+	{ true, "RDPES2", dpp_rx_err },
+	{ true, "RDPES3", dpp_rx_err },
+	{ true, "RDPES4", dpp_rx_err },
+	{ true, "RDPES5", dpp_rx_err },
+	{ true, "RDPES6", dpp_rx_err },
+	{ true, "RDPES7", dpp_rx_err },
+	{ true, "RDPES8", dpp_rx_err },
+	{ true, "RDPES9", dpp_rx_err },
+	{ true, "RDPES10", dpp_rx_err },
+	{ true, "RDPES11", dpp_rx_err },
+	{ true, "RDPES12", dpp_rx_err },
+	{ true, "RDPES13", dpp_rx_err },
+	{ true, "RDPES14", dpp_rx_err },
+	{ true, "RDPES15", dpp_rx_err },
+};
+
 static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 				    void __iomem *ioaddr, bool correctable,
 				    struct stmmac_safety_stats *stats)
@@ -841,6 +878,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 
 	dwxgmac3_log_error(ndev, value, correctable, "DMA",
 			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
+
+	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+
+	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
+			   dwxgmac3_dma_dpp_errors,
+			   STAT_OFF(dma_dpp_errors), stats);
 }
 
 static int
@@ -881,6 +925,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
 	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
 
+	/* 5. Enable Data Path Parity Protection */
+	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
+	/* already enabled by default, explicit enable it again */
+	value &= ~XGMAC_DPP_DISABLE;
+	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
+
 	return 0;
 }
 
@@ -914,7 +964,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
 		ret |= !corr;
 	}
 
-	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
+	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
+	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
+	 * Parity Errors here
+	 */
+	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
 	corr = dma & XGMAC_DECIS;
 	if (err) {
 		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
@@ -930,6 +984,7 @@ static const struct dwxgmac3_error {
 	{ dwxgmac3_mac_errors },
 	{ dwxgmac3_mtl_errors },
 	{ dwxgmac3_dma_errors },
+	{ dwxgmac3_dma_dpp_errors },
 };
 
 static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
-- 
2.34.1


