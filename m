Return-Path: <linux-kernel+bounces-8376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A181B6C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A7F1C23BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC36077646;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4+r83MQy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410776DAA;
	Thu, 21 Dec 2023 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162919;
	bh=wnC+dcrhV0iVIaIyTNFPvehYMUi62DJkXerciRSKVSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4+r83MQyzpu6fAk2k1xACe732mKnUBZgWFfeM/NfE/jiCilqyNRPfMJo5DU7CYTC9
	 AjgqIEBnhLWPVtDIgOv0UqPIcPLGdjG7S/Ekt15wOndD2uH65/sSlBKxM6QrT01cPd
	 VRSugMaow5/dqhviYdrBF6jJIje4O/RTyqufwuhgMh8qRL7Z4BfXkJHdU9rwOz92tY
	 LpCqJjFXfDSwQQ87T/JJVVnzDCtnPeIPzAdWVIpoKFjO6oORsxOwHEHjFKagFyGpBu
	 k3fp9OZjzMoSIc/90BhPl4G1Kn/ZzYrIOk+oXO7P+tccTQJZ8WIk+dDnAia/7IaEgx
	 dNRmZAv7Cfhfg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B92A4378200E;
	Thu, 21 Dec 2023 12:48:38 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 09/26] thermal: intel: pch_thermal: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:08 +0100
Message-ID: <20231221124825.149141-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal API has a new thermal_zone_device_register() function which
is deprecating the older thermal_zone_device_register_with_trips() and
thermal_tripless_zone_device_register().

Migrate to the new thermal zone device registration function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/intel/intel_pch_thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index b3905e34c507..dfc4b206633e 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -159,6 +159,7 @@ static const char *board_names[] = {
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
+	struct thermal_zone_device_params tzdp = { .ops = &tzd_ops };
 	enum pch_board_ids board_id = id->driver_data;
 	struct pch_thermal_device *ptd;
 	int nr_trips = 0;
@@ -233,10 +234,12 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 
 	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
 
-	ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
-							   ptd->trips, nr_trips,
-							   0, ptd, &tzd_ops,
-							   NULL, 0, 0);
+	tzdp.type = board_names[board_id];
+	tzdp.devdata = ptd;
+	tzdp.trips = ptd->trips;
+	tzdp.num_trips = nr_trips;
+
+	ptd->tzd = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
 			board_names[board_id]);
-- 
2.43.0


