Return-Path: <linux-kernel+bounces-8393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC4181B68A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8551F260D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C27CCE5;
	Thu, 21 Dec 2023 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vL4wvS9+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC627BEEF;
	Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162928;
	bh=V38Z9HnmY0IrWbFobu25Eju6bXU79J2Cvnfm9VP0Vr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vL4wvS9+XJ9f1gis+v3R4vYAWlxDG1u1X1posyjFEsH17a1fbM/gQGhhM+csylOBs
	 Sj6ll2vdiO1ZbaSZudEq4krn9PY5Yj549Z1BOkKaUdO58reXlzi1SjCqCN/p2CgMYq
	 DSe72DNXaPrBvTQAwU+Ae/jsJMA0grnJ1wwjkZ8uxChZHWhAfnnLnzwVmrL+HL9dAY
	 oVpjU+SpwDodKvcBVW6mHGr9F1C7EUCszMC3ydQAxw9jy5yk3VHM8xakUZTNBgINmO
	 csofa+MMn7z044sf8P7uQGqhVOKbh0dHJ41JpnHpYofYfWOrVwRqPt5+t5RY8m7CGF
	 d5cbLIkJElycQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EBF35378200E;
	Thu, 21 Dec 2023 12:48:47 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 21/26] wifi: iwlwifi: mvm: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:20 +0100
Message-ID: <20231221124825.149141-22-angelogioacchino.delregno@collabora.com>
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
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 27 ++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index dee9c367dcd3..268ff6ca3cac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -674,8 +674,14 @@ static  struct thermal_zone_device_ops tzone_ops = {
 static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 {
 	int i, ret;
-	char name[16];
 	static atomic_t counter = ATOMIC_INIT(0);
+	struct thermal_zone_device_params tzdp = {
+		.ops = &tzone_ops,
+		.devdata = mvm,
+		.trips = mvm->tz_device.trips,
+		.num_trips = IWL_MAX_DTS_TRIPS,
+		.mask = IWL_WRITABLE_TRIPS_MSK,
+	};
 
 	if (!iwl_mvm_is_tt_in_fw(mvm)) {
 		mvm->tz_device.tzone = NULL;
@@ -683,28 +689,25 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 		return;
 	}
 
-	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
+	tzdp.type = kasprintf("iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
+	if (!tzdp.type)
+		return -ENOMEM;
 
-	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
-	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
-							mvm->tz_device.trips,
-							IWL_MAX_DTS_TRIPS,
-							IWL_WRITABLE_TRIPS_MSK,
-							mvm, &tzone_ops,
-							NULL, 0, 0);
+	mvm->tz_device.tzone = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.type);
 	if (IS_ERR(mvm->tz_device.tzone)) {
 		IWL_DEBUG_TEMP(mvm,
 			       "Failed to register to thermal zone (err = %ld)\n",
 			       PTR_ERR(mvm->tz_device.tzone));
 		mvm->tz_device.tzone = NULL;
-		return;
+		goto err_free;
 	}
 
 	ret = thermal_zone_device_enable(mvm->tz_device.tzone);
 	if (ret) {
 		IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone\n");
 		thermal_zone_device_unregister(mvm->tz_device.tzone);
-		return;
+		goto err_free;
 	}
 
 	/* 0 is a valid temperature,
@@ -714,6 +717,8 @@ static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 		mvm->tz_device.trips[i].temperature = INT_MIN;
 		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
 	}
+
+	return;
 }
 
 static int iwl_mvm_tcool_get_max_state(struct thermal_cooling_device *cdev,
-- 
2.43.0


