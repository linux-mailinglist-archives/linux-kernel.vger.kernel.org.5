Return-Path: <linux-kernel+bounces-138905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F989FBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4780B3046E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0916EC19;
	Wed, 10 Apr 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADeYPqI8"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274516F0C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763586; cv=none; b=TxW1JK4ZNTKa83JvstI3jle3mx1kBgqM3sA4apoN9meUgUO4iOqQdGTrtDTrMq6dYq6C60bObagKpAzhYZ+xatxkX5QHp0lYrj2naCgj2I8oeS9DcmCAhLcFZzaijFjOVFgBsSEAEHgzMBNGdVlKocZ8SoduuXF6nrnX4hXLfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763586; c=relaxed/simple;
	bh=f3GHd6QNvPmRJrTFu3PXrrq17seSZz+8VF3s+UCv4Xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mb21/Nz/ziElUtWsKwyMSVbcrGuV9SESNRGAC/BGey4/j9wXAk4om1eJtCKbCg0Iy2fXqfKta0oFonze8xjnJudqG+k63tTmxWi97ZT7ripFBZqlMDOlqECMM3vHFIdGWfko77n2i8V9dBKyWdQKC0dt85YDTAGNlP1lx7+6/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ADeYPqI8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343b92e54f5so5057799f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712763583; x=1713368383; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d53vYczkCVTwIJoyWEVHYrjviB2cJtuYV4baa1qAm7s=;
        b=ADeYPqI8p6ulXLxybgtj0GPU5QtVEOnzGjrlsmJNHl1GNJNVj8W34ckPl2Cnd4T7EH
         kOGJ9c6USmTkiIxc9lfqBSK0WM9RRB0GMhq7A1Mj77bb2NVfmptsRwjqUqetVcjDPkYA
         dvCsEBLQnXmkeD/KQnvfG7IcLIv3D3ueKRyFDFbFR8CQQ87gtv1Z6okFX5c1zo7s82qR
         sESc6KjOjsUgiYqHxIBshk2xSUKj1kmazmxgBDVCG/NKPCh3yha7C2Y77wicyCkD0IUG
         PvN7YnZhDqMvsRAuDE8KrgeR/SVH85nbQLr0PaK6DwOchpZ/9mpoK4gk3X4Wsmdq57VV
         9gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763583; x=1713368383;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d53vYczkCVTwIJoyWEVHYrjviB2cJtuYV4baa1qAm7s=;
        b=MZyU3BZoTHERkv/z2hIRsmStp32ERYVPLu/jTxSl6kA4c1wFAiJniagY7YnVIdOC6V
         XhIlXFlW51x1iLh7IW6FlxGuiGUoJrxu6T1NxNyTnozl0rEfhLkTFC9drgQJxuE00pEe
         EzMWvMWSuZ7xjTz7K62T25UOiDcaquIvTvV8ipR/ozLQiiyS/u06nw7Irs/QSuy30W7J
         4tFwCGvvT+CQRi2+8uv4NULdcpeuZZGlN9Ubq6cgr/xFphtdiZP8e8NF73N5tnsHiUWM
         wf0WEJVWF7CHRneftQ77zph1hiq3DOZJyIR7uH4RmsbarSTwENps6/I45RvazAiwlkSI
         jx8A==
X-Forwarded-Encrypted: i=1; AJvYcCVIJc2ofFVw6NZGwwvSAzcDJGxFJ6K2Eiqr1qQostCHqeoveYlEFjKr2/T0ZY6UaALjru781bNLdXd9MNx/mlUpvYqj9B+nCK2hS4gb
X-Gm-Message-State: AOJu0YzvwE6HjfIQrAJSY5SCn9AxgTWcRVczhblBJkK3IcbUlQPAWYDK
	/pv/Lnh4LUrMgpy44IkAsWOxj1wd4M0iMmm2DwN805W/sZzb4YTW1Q5u+FjpuCs=
X-Google-Smtp-Source: AGHT+IHyfSVJpENtYwkcw5XEx41O5hbrKOhJxBfU+FCySBe7Hl7lIlIJ09wsi+hxLDs0K1PUsib3zg==
X-Received: by 2002:a05:6000:1ac8:b0:343:c58f:7af4 with SMTP id i8-20020a0560001ac800b00343c58f7af4mr2121310wry.59.1712763582629;
        Wed, 10 Apr 2024 08:39:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o14-20020adfe80e000000b003436a3cae6dsm13970910wrm.98.2024.04.10.08.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:39:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 10 Apr 2024 17:39:40 +0200
Subject: [PATCH] phy: qcom: qmp-ufs: update SM8650 tables for Gear 4 & 5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-topic-sm8650-upstream-ufs-g5-v1-1-5527c44b37e6@linaro.org>
X-B4-Tracking: v=1; b=H4sIALuyFmYC/x3MQQqEMAwAwK9IzgbSotL1K+KhW1M3B7U0KoL49
 y0e5zI3KGdhhb66IfMpKttaYOoKws+vM6NMxWDJNtQYwn1LElAX17WER9I9s1/wiIpzi1/zsez
 Id8FFKEXKHOV6+2F8nj8D/+qUbgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=9822;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=f3GHd6QNvPmRJrTFu3PXrrq17seSZz+8VF3s+UCv4Xw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrK9aBTyXRcKLmIAW28QRwwXeXvz6SXD6sD27iUI
 A6zFoYKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZhayvQAKCRB33NvayMhJ0bTHD/
 41ZTP/9yjEQXAuO8ob1sjTxSLTgMFEH0IVXWsMK5eNirPhHdqDAH4gynZ851we2G31KcuopSKQLvLE
 FF33KluyzUp2NprhXITfqLFFkYgEFAohzEohwmBsJMu87I/nX299BxwNYe7DTht6ApPPgmBe60Bnik
 BbVE30n+U65BZ8BzolCZDo4Dtn8n+uBVPgvfWGmbpC9rEuVxN8bmB72Jo785yspa/hHja4GXGQtpiK
 cxV2vFmPACvOZJC8O662QgKkNfliCjo2TCr8sKMGvMUG7p5Hdidqhj2bXl5zzOWAzFpLzp88a0Hnew
 MJWT1VLMPmAe/vVVl8TaFRw394gF9+CYzcBi+2ecGXrbMty2qUCdJIZQRVUbq9ifuVT2ugN47AzuhS
 RoJRWvbYRutlLYgnsIAaJTCFpJ3yLY1SM89j/Ji2nZglEiJMyKa7GIDrqlg8V/e8YJscVCoql36+g4
 r1Gzp30G5IwIsxMeHoIEH6AS/B2pDehvIiX438T8SQaeganJhr09dfFKmYUikFtYcAU4gjn46tdpCe
 bsQHiQpVQnaxt+5n7m8RshRLO+JZQcPwswHKjH5rEKFt9hZ3ybcnA26kyCT0DczxxddLNx62dZSyXy
 /q6GaZDjnFjFvtZYe1mCrr8Hv2vm1Pa3e7+gg2zd+X1gjSaxheD0mVondjTA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Update the SM8650 UFS PHY init tables to support Gear 4 and Gear 5
using the overlays setup (only supported Gear 5 before), and sync
back with the latest Qualcomm recommended values.

The new recommended values allow a solid 50% bump in sequential
read/write benchmarks on the SM8650 QRD & HDK reference boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h     |  4 ++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  6 ++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 73 +++++++++++++++++-----
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
index 970cc0667809..f19f9892ed7b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v6.h
@@ -30,5 +30,9 @@
 #define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
 #define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
 #define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME		0x220
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4		0x240
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S5		0x244
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S6		0x248
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S7		0x24c
 
 #endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
index d9a87bd95590..d17a52357965 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
@@ -25,12 +25,15 @@
 #define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4			0xf0
 #define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS			0xf4
 #define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
+#define QSERDES_UFS_V6_RX_RX_EQU_ADAPTOR_CNTRL4			0x1ac
 #define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1bc
 #define QSERDES_UFS_V6_RX_INTERFACE_MODE			0x1e0
 #define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3			0x1c4
 #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
 #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B2			0x210
 #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B4			0x218
 #define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6			0x220
 #define QSERDES_UFS_V6_RX_MODE_RATE2_B3				0x238
 #define QSERDES_UFS_V6_RX_MODE_RATE2_B6				0x244
@@ -38,6 +41,9 @@
 #define QSERDES_UFS_V6_RX_MODE_RATE3_B4				0x260
 #define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
 #define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B0				0x274
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B1				0x278
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B2				0x27c
 #define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
 #define QSERDES_UFS_V6_RX_MODE_RATE4_B4				0x284
 #define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 590432d581f9..1b78c1330a12 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -830,17 +830,20 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
-	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO_MODE1, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
-	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
-	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x06),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
@@ -848,17 +851,28 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_serdes[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8650_ufsphy_tx[] = {
-	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
 };
 
 static const struct qmp_phy_init_tbl sm8650_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
-	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0f),
-	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
-	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
-	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x3e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B2, 0x18),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B4, 0x0f),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
@@ -866,23 +880,41 @@ static const struct qmp_phy_init_tbl sm8650_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B1, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B2, 0x20),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
-	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B6, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_SATURATION, 0x1f),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CTRL1, 0x94),
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_RX_TERM_BW_CTRL0, 0xfa),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
 };
 
 static const struct qmp_phy_init_tbl sm8650_ufsphy_pcs[] = {
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PCS_CTRL1, 0xc1),
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x68),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4, 0x0e),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S5, 0x12),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S6, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S7, 0x19),
+};
+
+static const struct qmp_phy_init_tbl sm8650_ufsphy_g4_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x13),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
-	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
+static const struct qmp_phy_init_tbl sm8650_ufsphy_g5_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4d),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
 };
 
 struct qmp_ufs_offsets {
@@ -1407,6 +1439,17 @@ static const struct qmp_phy_cfg sm8650_ufsphy_cfg = {
 		.pcs		= sm8650_ufsphy_pcs,
 		.pcs_num	= ARRAY_SIZE(sm8650_ufsphy_pcs),
 	},
+	.tbls_hs_overlay[0] = {
+		.pcs		= sm8650_ufsphy_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8650_ufsphy_g4_pcs),
+		.max_gear	= UFS_HS_G4,
+	},
+	.tbls_hs_overlay[1] = {
+		.pcs		= sm8650_ufsphy_g5_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8650_ufsphy_g5_pcs),
+		.max_gear	= UFS_HS_G5,
+	},
+
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= ufsphy_v6_regs_layout,

---
base-commit: 0112ca4447c2969b8106377a614f010ba85e4c9b
change-id: 20240410-topic-sm8650-upstream-ufs-g5-b192e80a6c8f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


