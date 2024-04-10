Return-Path: <linux-kernel+bounces-138191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9329489EDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45AF1C214CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55D1156885;
	Wed, 10 Apr 2024 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="y9g4G46m"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E91553AC;
	Wed, 10 Apr 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738651; cv=none; b=OvnK4QVlmrgI3G4KCfIYZtnZQWBoNyxoSkJ3+AXSXvjO9ptTxMRMkbaligdVhgKSxxkqV7g+vwk5hOIZGGRY57Zl0GwvcInvUFObcnMOmyvB6JbizqDtY3FZNYA5pEAC5TaCFEHun14wqRbcT9wY1Hww2b/pAlVN81DS+xqhrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738651; c=relaxed/simple;
	bh=MClo/LdCJCeuzDJxjlhI62aOolIJ3BFr09Hb39twgwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFdofx8vt0K1TWVyU+TbvJpFnSnMkUsKosAh56Avfm4M/COiYjJCXH4KtANzBJikVQTEqZrvXDKHVCTKQsmhSg7WaY4CGARaUDvt9OMinBK7muHXLmEp3yb8bt9yQmDUnafnflcm+OYWEo2J4eebMPEj6aUCRDRGrfbSsqOTh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=y9g4G46m; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712738648;
	bh=MClo/LdCJCeuzDJxjlhI62aOolIJ3BFr09Hb39twgwo=;
	h=From:To:Cc:Subject:Date:From;
	b=y9g4G46mTs/zGx3EyUZZPgX3TZYtvYZBaPbDIQgb1F0KlHb9tZwXImJtUIsYErAXx
	 Emg42bXD24FrR/Ks2iX200XzRHNB7jIh+2oPEcyhJRWIyL5jGhebt+VE6BheblvUbJ
	 AU3X6Q9NCZYhxrQKJnypJwILngVyp+Cm2sps+rph0EDRXC75qVpVVM28oiDLpN740J
	 tz7Ij5R1GFd73NwJ/8L+WAdt5zWsr6+TUYcvgjVqoCIawe/3mkb74mSbsYHxWB36y8
	 TpNnix/RCO8YI9ZROCOT/yn8M8CD3+5rblsMATaioa2/yLQVmNotM4mJy4jRf/o/56
	 OmJIX6j42eepA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D8B973781453;
	Wed, 10 Apr 2024 08:44:07 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sre@kernel.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mazziesaccount@gmail.com,
	gene_chen@richtek.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulator
Date: Wed, 10 Apr 2024 10:44:05 +0200
Message-ID: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_match shall correspond to the name of the regulator subnode,
or the deprecated `regulator-compatible` property must be used:
failing to do so, the regulator won't probe (and the driver will
as well not probe).

Since the devicetree binding for this driver is actually correct
and wants DTs to use the "usb-otg-vbus-regulator" subnode name,
fix this driver by aligning the `of_match` string to what the DT
binding wants.

Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/power/supply/mt6360_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index 1305cba61edd..aca123783efc 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -588,7 +588,7 @@ static const struct regulator_ops mt6360_chg_otg_ops = {
 };
 
 static const struct regulator_desc mt6360_otg_rdesc = {
-	.of_match = "usb-otg-vbus",
+	.of_match = "usb-otg-vbus-regulator",
 	.name = "usb-otg-vbus",
 	.ops = &mt6360_chg_otg_ops,
 	.owner = THIS_MODULE,
-- 
2.44.0


