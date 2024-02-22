Return-Path: <linux-kernel+bounces-76417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A685F712
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3161C211FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1603381A1;
	Thu, 22 Feb 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lvGKYUpE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28627482CA;
	Thu, 22 Feb 2024 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601616; cv=none; b=lIMjL3hXVYmAQCSzjlF/0ufgyIDHPqxdI7Kwhz5lPoKzdWCJjhbm1Txkg9mUKNPsIGevdb5I2IcCopFKp3E4fXy9E29AeCl9mvorRZ/qZXN6Lm3ENIvqUyIc9I2xLMa5QOKC2kX/n+qIVecOiT2RdDUTMlX+5nl9A5IPiBc1Ax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601616; c=relaxed/simple;
	bh=im2b3XkRWHVDjENKTL39XO+OkPYZPgPa/EbqRfvqcr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PpwVN5MzlCXdiWnwADMWD/m42kCOKTD0nt355blESfANp+GAJTATsDv2/ex+0NiEx9L2i+ZDaHLOyLyCNfwYMkVCJAA4YRp65VdEMEZ+R4q/UcX3hvpgrCd/VjIeNeq7rvDZFxWZWXsWeLqQVEISLSA0EiAOJpT0qpCX82Gl2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lvGKYUpE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX9F7027774;
	Thu, 22 Feb 2024 05:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708601589;
	bh=2cNr2W9c0uUvSVuROSL/j2Uzf+2G2fP0MYHF6MQhS7M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=lvGKYUpEXvpx56rZAYJarKRBpUBbwsk1qJxq1DIN8Ff3429hAGiH/yLakW7P42Qyz
	 lmmilnJFYmGLsGxME6UtDoim/rt5023qnMToheBTu2ur8Ugt30fSQX53jBGVsK/X3G
	 JDZkKp+ZE+NxU1rpSDMVCdRqNx9V7ZaIo7IfWnNc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MBX9he056994
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 05:33:09 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 05:33:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 05:33:08 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MBX7Zi090935;
	Thu, 22 Feb 2024 05:33:07 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 22 Feb 2024 17:01:18 +0530
Subject: [PATCH RFC 02/21] media: cadence: csi2rx: configure DPHY before
 starting source stream
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-multistream-v1-2-1837ed916eeb@ti.com>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans
 Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Aradhya
 Bhatia <a-bhatia1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
        Changhuang
 Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Julien Massot <julien.massot@collabora.com>,
        Jayshri Pawar <jpawar@cadence.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2426; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=PdPEqazmXTfXDrKucBNAcGZRh84r972NesVdYj6Urnc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1zDb6Btyd3l4s3XpQ/yhAgO7WB8o/94UBxhg+
 XZYNViZIxWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdcw2wAKCRBD3pH5JJpx
 RVpsD/wIaFvgYeOJgz5+wO05LNXrzihOfqTYOxNbgEkhoLL6v3JEki/UwYlZeSMoOf69WgModFv
 hcb5p3UWzSb7LAMOpYW2Bu2xl3i6xYuDW8SKgMuIqHNoI2J3whJcCbLyjkiVGTZFh/ZcgZkio8M
 jCuNGH+FkFvBRwKhFYx70Hzbdj6rP8B8o5cOR3C3PtLAGUBNoNnB6mKF6cAhnYdQJJGRCYQPeLm
 8x6RfzUwiTyD1spj7gD89t6Omp4MtX5hnoEubWqzyBFpM5Sc88CjtoOF+mSyxL9wlXZ+KkKlesj
 g/Nq50PR9i9GKE1Pr/LVBcsFrYdrS+pjQzK1HL1MNmu/WDFHYSNembITaVxlS57amJXjzAoBF5G
 h8p2swwvmerLrnfoETDGP5huLmknB8KuA1ZbXyrd09NTgEcsWG9MQ6DOTWh1Sfxj4Fe40x3zezf
 Pqslw41+wN7dcd98yCOzlE309H3eZXPTwPlBDotOnDsHZGTV/F4w3vjtW9smURa/krS9p8UVKof
 frq1G4NfQlmFaPCCFcHrHb3kZQnwMUeIlQJ9ExL/ejJi02kqmHbFTLIVdKf3IxT0aaDTOocsg7N
 61To7EuKBHPpaI3JPySWycPeejbzLZ7SnOxvx7wKj8QBdb4SYzd9wl0E3jxqJdXT0pfoXDFFIh1
 YKIMsDs2rR+HTVA==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Pratyush Yadav <p.yadav@ti.com>

When the source device is operating above 1.5 Gbps per lane, it needs to
send the Skew Calibration Sequence before sending any HS data. If the
DPHY is initialized after the source stream is started, then it might
miss the sequence and not be able to receive data properly. Move the
start of source subdev to the end of the sequence to make sure
everything is ready to receive data before the source starts streaming.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 70b7f8a9e4f2..75e602c1d762 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -243,10 +243,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
 
-	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
-	if (ret)
-		goto err_disable_pclk;
-
 	/* Enable DPHY clk and data lanes. */
 	if (csi2rx->dphy) {
 		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
@@ -256,6 +252,13 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		}
 
 		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+
+		ret = csi2rx_configure_ext_dphy(csi2rx);
+		if (ret) {
+			dev_err(csi2rx->dev,
+				"Failed to configure external DPHY: %d\n", ret);
+			goto err_disable_pclk;
+		}
 	}
 
 	/*
@@ -295,14 +298,9 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	reset_control_deassert(csi2rx->sys_rst);
 
-	if (csi2rx->dphy) {
-		ret = csi2rx_configure_ext_dphy(csi2rx);
-		if (ret) {
-			dev_err(csi2rx->dev,
-				"Failed to configure external DPHY: %d\n", ret);
-			goto err_disable_sysclk;
-		}
-	}
+	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
+	if (ret)
+		goto err_disable_sysclk;
 
 	clk_disable_unprepare(csi2rx->p_clk);
 
@@ -316,6 +314,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
 	}
 
+	if (csi2rx->dphy) {
+		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+		phy_power_off(csi2rx->dphy);
+	}
 err_disable_pclk:
 	clk_disable_unprepare(csi2rx->p_clk);
 

-- 
2.43.0


