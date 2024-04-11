Return-Path: <linux-kernel+bounces-140358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B08A134E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C391C20DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2FB14AD1E;
	Thu, 11 Apr 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s1EdeL4B"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0C149C7C;
	Thu, 11 Apr 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835790; cv=none; b=LB9aDWrEPFElmVs+21UnQKkQgq8SA7IXbv/U8RKyJH8Sd7u2oEyDq/Dq/mCnfS6LXcFHvRpCuPNgmC0ujzWgC5UPwlhwCmWuyIcR3i5gEgE8WI2ioQFMTAOA5eohmXjqRO+sXSaSmQZeWe+vzDvQBJykOuSU+yjdQF+3cPvDNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835790; c=relaxed/simple;
	bh=GYrCUPwSvlfdLE3J9cAWMICwrZAfevrC39qq1M3MwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JISMd4Gx16zNtYFFZ6rDuAa1NeHqokgiVnl3yBp9nvP+9vjYVkOOdOTig+8cYUK4GvI8vduTwhTpYMbtKvrMiREmKN5c2IfqATj1qiGeK8MS6lMLWS2QVl8DvzRfSJj7/QQjSYJ3GgrrFucGhq8xoSAhCEbuqsEg6HiIPv9cNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s1EdeL4B; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712835786;
	bh=GYrCUPwSvlfdLE3J9cAWMICwrZAfevrC39qq1M3MwBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1EdeL4B5cOSHif/ZFFdTpG9TouVl498pjChgSA0FUVlM2B3gN0TMHvZ4wrQEu91o
	 zLPVI5dibN2mRzaR5RQyl7IstTiTcwsOkmmhawK3fFlsmw/NRsosn3n40Gi7J64soA
	 AMtVorjiFPd2gL6fqrAMgsxakW+/+V+Cbtq3xpENBn083MlJ+aIHtaRawZzUT8gtPI
	 WMXAEhc10dwe9wh+bFIQ3yXMaAemh9yY8FCwlyjIdYQ4eKNI+A+mmG3t19Ktap6Ue7
	 0weB6tQW3bWIzEnVVbGkslSqqUIlTHhrWzmLduYeCw0tZsyBkHt5glMeb73nSdycr4
	 gafZx8zrVHIMg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A169237820A1;
	Thu, 11 Apr 2024 11:43:05 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-scsi@vger.kernel.org
Cc: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	peter.wang@mediatek.com,
	chu.stanley@gmail.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	stanley.chu@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/8] scsi: ufs: ufs-mediatek: Remove useless mediatek,ufs-support-va09 property
Date: Thu, 11 Apr 2024 13:42:53 +0200
Message-ID: <20240411114300.169055-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove checking the mediatek,ufs-support-va09 property to decide
whether to try to support the VA09 regulator handling and change
the ufs_mtk_init_va09_pwr_ctrl() function to make it call
devm_regulator_get_optional(): if the regulator is present, then
we set the UFS_MTK_CAP_VA09_PWR_CTRL, effectively enabling the
handling of the VA09 regulator based on that.

Also, make sure to pass the return value of the call to
devm_regulator_get_optional() to the probe function, so that
if it returns a probe deferral, the appropriate action will be
taken.

While at it, remove the error print (disguised as info...) when
the va09 regulator was not found.

Fixes: ac8c2459091c ("scsi: ufs-mediatek: Decouple features from platform bindings")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/ufs/host/ufs-mediatek.c | 34 +++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 0b0c923b1d7b..e4643ac49033 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -622,27 +622,38 @@ static void ufs_mtk_init_boost_crypt(struct ufs_hba *hba)
 	return;
 }
 
-static void ufs_mtk_init_va09_pwr_ctrl(struct ufs_hba *hba)
+static int ufs_mtk_init_va09_pwr_ctrl(struct ufs_hba *hba)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+	int ret;
 
-	host->reg_va09 = regulator_get(hba->dev, "va09");
-	if (IS_ERR(host->reg_va09))
-		dev_info(hba->dev, "failed to get va09");
-	else
-		host->caps |= UFS_MTK_CAP_VA09_PWR_CTRL;
+	host->reg_va09 = devm_regulator_get_optional(hba->dev, "va09");
+	if (IS_ERR(host->reg_va09)) {
+		ret = PTR_ERR(host->reg_va09);
+
+		/* Return an error only if this is a deferral */
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		return 0;
+	}
+
+	host->caps |= UFS_MTK_CAP_VA09_PWR_CTRL;
+	return 0;
 }
 
-static void ufs_mtk_init_host_caps(struct ufs_hba *hba)
+static int ufs_mtk_init_host_caps(struct ufs_hba *hba)
 {
 	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
 	struct device_node *np = hba->dev->of_node;
+	int ret;
 
 	if (of_property_read_bool(np, "mediatek,ufs-boost-crypt"))
 		ufs_mtk_init_boost_crypt(hba);
 
-	if (of_property_read_bool(np, "mediatek,ufs-support-va09"))
-		ufs_mtk_init_va09_pwr_ctrl(hba);
+	ret = ufs_mtk_init_va09_pwr_ctrl(hba);
+	if (ret)
+		return ret;
 
 	if (of_property_read_bool(np, "mediatek,ufs-disable-ah8"))
 		host->caps |= UFS_MTK_CAP_DISABLE_AH8;
@@ -663,6 +674,7 @@ static void ufs_mtk_init_host_caps(struct ufs_hba *hba)
 		host->caps |= UFS_MTK_CAP_RTFF_MTCMOS;
 
 	dev_info(hba->dev, "caps: 0x%x", host->caps);
+	return 0;
 }
 
 static void ufs_mtk_scale_perf(struct ufs_hba *hba, bool scale_up)
@@ -985,7 +997,9 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 	}
 
 	/* Initialize host capability */
-	ufs_mtk_init_host_caps(hba);
+	err = ufs_mtk_init_host_caps(hba);
+	if (err)
+		goto out;
 
 	ufs_mtk_init_mcq_irq(hba);
 
-- 
2.44.0


