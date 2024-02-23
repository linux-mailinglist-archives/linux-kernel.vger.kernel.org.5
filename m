Return-Path: <linux-kernel+bounces-77919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C91D860C25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440732870C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7517BAC;
	Fri, 23 Feb 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d0Jc0MDP"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7631428D;
	Fri, 23 Feb 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676607; cv=none; b=GA8WZmHH2WeHKYqBbmlaWIaGN/R6axnwg1rIUwAOlA3sKfFu7F7o1EsBHMGy3Gm7GTz2S7wUAgHtpllDKy/K6YbGtg6UbVMvizf1dCFk65ZLrXM4jF2b6ba8c01FHm+dxjt0YwWxxIamHtwRC/hS6LRw+pehoEfE3wMG2p8WvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676607; c=relaxed/simple;
	bh=O1p/ihc80OTN1etNosnbVNwAJ1k+u8XfupdgBWBERbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mwmZ4wFqlgS/JypFBeyQX3th0Mg6+XQkTib9CoboRoUMjgHQ5BDqMdtDZSaxxEaFt8UVBnlG2bBjruKRh8MhLdxC5B7F9wuSxiDaN/AElYhR4bGVttfXjgFAmMKOB97CH+PnaguhBSFzAgDz2i33AB8yq8s20LPz5dlxz/+A52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d0Jc0MDP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N8NC2U068026;
	Fri, 23 Feb 2024 02:23:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708676592;
	bh=kJycDDyOq9c0iT1E6f3/R8ps3DbUqo2/9E80vM/2dQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=d0Jc0MDPhiPTbXKOulJ00NNYtTz45Lxauj19uh+mF8BPO4vKRv+eQ2zVIcFMRTVca
	 +WNiuAHyOI7UZOjCjB9dFFP7YIHbfihv9xjmN1pBLeTPdqV+Pd36lKPoxA7ROal/mQ
	 4iStEftWpGHKzaaPNfkGdC6WktpV2PCGRoJcS5O4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N8NCwH031510
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 02:23:12 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 02:23:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 02:23:12 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N8NBr3096445;
	Fri, 23 Feb 2024 02:23:12 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Fri, 23 Feb 2024 13:53:01 +0530
Subject: [PATCH 1/2] media: cadence: csi2rx: configure DPHY before starting
 source stream
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-csi_fixes-v1-1-c7eda7a4a852@ti.com>
References: <20240223-csi_fixes-v1-0-c7eda7a4a852@ti.com>
In-Reply-To: <20240223-csi_fixes-v1-0-c7eda7a4a852@ti.com>
To: Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jack Zhu
	<jack.zhu@starfivetech.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Julien
 Massot" <julien.massot@collabora.com>,
        Changhuang Liang
	<Changhuang.liang@starfivetech.com>,
        Jai Luthra <j-luthra@ti.com>, "Pratyush
 Yadav" <p.yadav@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=e/qTKAUkjBVGEZIs5sw5gSkaXQc7oCrDWBs5rh/a97Q=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl2FXsEGk3DAb+T8L2Odt3U8ugOdjLy55Qmakvg
 r0iDMasQl+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdhV7AAKCRBD3pH5JJpx
 ReK5D/43SGJOQ6U9o2o0cIewCuiCnLpyCO20aBAM8rxdsnh4JU8GSDP2vbX5wDoGnWUR9J1ZLIq
 eY+c63YLAV4aHln4rIiDfHDRwClnB+lsP4zRbcl3DyhZjTkwg87CwhAQUvn8oSZ/VEZCl9A29xZ
 /HEdxMTw3TvUCSCxRAMUIF+zT9/Jp7MO5dfaAUm6IPb2d1+25zJZLThVp8PGIl0dfN9zIAzAg8A
 weBEz5FTzTubXfN87eB5lNtfvg9KbVVhzF5DfC7O2ko6yDXoecmX8BRK9r90Df7AO+NRhuUiD3f
 KoHF9ujoED42+T2e5Uymmv+kJusx/9SUzsIOXX/QjgLLdGSgCX5sBB1FBeh2+HV8fdxsGcCSZlh
 2HcOHpGuGIrfrbj3d7M1UhWvhDlQHrGzQleylz41eKUxShXthchL67A5J6XPxBffA5sfnjIrrip
 TXAI6uatxZTmitjPm8ZmDoU1GZS4sxjw5Lt6vWcKkTgvxwT+Dt35phRdTH899/ky3A6Jg2poMxu
 xpPUgxgFCwckVWWj0eA9z4zTu1iO9CMlJQZRv1oCFFj+h5tflppATfavPc+0SqQj/j4rbJJ95ks
 AQ0FJXGua/xSU5ArZUjffutXRYFv9HDJGI1g2AIcANVp3IEWT7bneKynvqRwHrbSibfQ1phAyuL
 vEa1SPL/Y2ekXLQ==
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
Fixes: 3295cf1241d3 ("media: cadence: Add support for external dphy")
Tested-by: Julien Massot <julien.massot@collabora.com>
Tested-by: Changhuang Liang <Changhuang.liang@starfivetech.com>
Reviewed-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Changhuang Liang <Changhuang.liang@starfivetech.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 2d7b0508cc9a..6f7d27a48eff 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -239,10 +239,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
 	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
 
-	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
-	if (ret)
-		goto err_disable_pclk;
-
 	/* Enable DPHY clk and data lanes. */
 	if (csi2rx->dphy) {
 		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
@@ -252,6 +248,13 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
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
@@ -291,14 +294,9 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 
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
 
@@ -312,6 +310,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
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


