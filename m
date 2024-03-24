Return-Path: <linux-kernel+bounces-113738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65988888659
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204372852C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490D1494B3;
	Sun, 24 Mar 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWJo7nTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F08627C;
	Sun, 24 Mar 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320741; cv=none; b=DcxNTAqlBG+dibdF+PClFa16ODEsZ7wLTXkJ/UShGDyMZXXThsWjxwB1eoLBDoG7yxxtNXHkDhb45vGUNasReaxiuiyXDdNAawXfPOR5HKE3MxCXqDuN7BPC49FL5oPUZ+eNl8RNyFCScYNkM87CeivTve75d/Hn7e3ogPhud20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320741; c=relaxed/simple;
	bh=UJVecGRcsJMrble1axSJMuG0b3FUpXz2QsuhpnXy+d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teHR3vLSbKvkDFanOyD/PsgDBWiKj9Q4AXnaR+qPG0T8j8Ao5iZ2By5/SPjOmkjSccxW7i9h+W4PnjNK/etJJJlPlzWB5mDuviWqBmm+T11zThSFsaOy/ozEG9DGZLKgeggWrVCfgIvx7bArmUAe5xTIVmhOn052vndjX3a++A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWJo7nTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A2FC43390;
	Sun, 24 Mar 2024 22:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320740;
	bh=UJVecGRcsJMrble1axSJMuG0b3FUpXz2QsuhpnXy+d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWJo7nTJypJaKmqafKPgXiP2ao6aIomtNbEVuYlWvVZZQns0pkuC9AZ6w0c7r/1FQ
	 JXJrYNXL5WTeKZgtK0th3Eh3pyIbiXBIjv92XlFiIS0+0AnZzo1iMbzZqGyj87+JFV
	 WkzXJrX+ZzX4xgrWX9WpihTGmYSlTqM1syJKcU9IFJNft8tXVVxrUZWtX85vg7zwod
	 nVqLBjCHYd2e5dg6c7XBW7EC7KnGTLlT/O/mHE9H/Vm4s2DDudMxEd+j2x2Im6Jc3/
	 4EJjyb8/fRJmNmqZr8Q7vNMTcMG+RyMFEj4YFiFswlXqi7O0gsRk3OxIfH57RpMRdk
	 L5S6cPTJWEtDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 303/713] wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz channel config from ACPI
Date: Sun, 24 Mar 2024 18:40:29 -0400
Message-ID: <20240324224720.1345309-304-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit 07ce1d46372489d90f9cccebb3277d1af801c4b9 ]

In some case, the MTCL table will exist, but MTDS table will not.
So the SAR will init fail. This patch make MTCL and MTDS can exist
with no dependence.

Fixes: f965333e491e ("mt76: mt7921: introduce ACPI SAR support")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/mediatek/mt76/mt792x_acpi_sar.c  | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index 303c0f5c9c662..c4e3bfcc519e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -66,13 +66,15 @@ mt792x_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 }
 
 /* MTCL : Country List Table for 6G band */
-static void
+static int
 mt792x_asar_acpi_read_mtcl(struct mt792x_dev *dev, u8 **table, u8 *version)
 {
-	if (mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, NULL) < 0)
-		*version = 1;
-	else
-		*version = 2;
+	int ret;
+
+	*version = ((ret = mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, NULL)) < 0)
+		   ? 1 : 2;
+
+	return ret;
 }
 
 /* MTDS : Dynamic SAR Power Table */
@@ -166,16 +168,16 @@ int mt792x_init_acpi_sar(struct mt792x_dev *dev)
 	if (!asar)
 		return -ENOMEM;
 
-	mt792x_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
+	ret = mt792x_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
+	if (ret) {
+		devm_kfree(dev->mt76.dev, asar->countrylist);
+		asar->countrylist = NULL;
+	}
 
-	/* MTDS is mandatory. Return error if table is invalid */
 	ret = mt792x_asar_acpi_read_mtds(dev, (u8 **)&asar->dyn, asar->ver);
 	if (ret) {
 		devm_kfree(dev->mt76.dev, asar->dyn);
-		devm_kfree(dev->mt76.dev, asar->countrylist);
-		devm_kfree(dev->mt76.dev, asar);
-
-		return ret;
+		asar->dyn = NULL;
 	}
 
 	/* MTGS is optional */
@@ -290,7 +292,7 @@ int mt792x_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
 	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
 	int i;
 
-	if (!phy->acpisar)
+	if (!phy->acpisar || !((struct mt792x_acpi_sar *)phy->acpisar)->dyn)
 		return 0;
 
 	/* When ACPI SAR enabled in HW, we should apply rules for .frp
-- 
2.43.0


