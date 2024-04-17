Return-Path: <linux-kernel+bounces-148244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3D8A7FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5180EB210BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C813C3F9;
	Wed, 17 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j8raFnvh"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16413AA42;
	Wed, 17 Apr 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346465; cv=none; b=iNqZWpAJl0dkjdZv69GXDD2s3ebd67wLMFkSwYKtEoKvKCs2nA7c6krsNJBDtdDSS4/TEFCMiL+hxw6WOW7xFW+0qsCi9HYA77wVnr1kHJcOq+d0snw0IrxWiwkSR6tPiKpQPPlriIYj0cYP02yGYWbnPAcFwccFJ6JnlOhpjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346465; c=relaxed/simple;
	bh=vDcS7OqaSkB8X5k8evOk6TuXCAOLc5Z3dHf2xO8wI9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gE8TMLvGFAGMUmnQVMPtNqDwniO0+Rb5C8e3TiJYnAnKkI8f2KrHPsbjyzbyzVr0aRDDsOoO5YgxiK9GZs8xuGYyBM06D4UJy/TG3qL0qOFGyV/KTNzGoZmSfcyryOpAi1mA6sEFmmhkHYU3gs5WFdN3bcbRbb9xnPTDuRzwT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j8raFnvh; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D40D8FF811;
	Wed, 17 Apr 2024 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDEc2OhxMdTOFtjtdmGV0c4cEspJvjbT3S+va6o3Jkk=;
	b=j8raFnvhd4OoWw0L55AQOCcjl+0phJUEq+amrR9RhhrR+eqvBK2iTgWIc4S/NoJLB1ZKx6
	ylbjay0LMmQcGwFtKFtwvkNogYB4O1OqMGAWNvBFVyRCQ1neWpycJZuLdrqCEoEuLLwhbs
	h1mduJ5rh1ujD00P5e4GWCkb/xWCoSq/A0MfSQkrW7q8hGLJijJLUsyD6yXSkqLdVatwf0
	1Sfdgcuty3VsGwofyHXa3WnE60HvzdO1IgYnC9QrvMmxTH7QfdQmoSRCDCrC0f+EGqlP9p
	/yYzi+cMkMv+7BoKLjub0+uofq4T0cyfGnTnwGOR4opAma/w9OuaIDChr25WaQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 17 Apr 2024 11:34:11 +0200
Subject: [PATCH 4/6] wifi: wilc1000: add function to read mac address from
 eFuse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240417-mac_addr_at_probe-v1-4-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

wilc driver currently reads and sets mac address by firmware calls. It
means that we can not access mac address if no interface has been brought
up (so firmware is up and running). Another way to get mac address is to
read it directly from eFUSE.

Add a function helper to read the mac address written in eFuse, without
firmware assistance

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/fw.h     | 13 +++++++
 drivers/net/wireless/microchip/wilc1000/netdev.h |  2 +
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 48 ++++++++++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.h   |  1 +
 4 files changed, 64 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/fw.h b/drivers/net/wireless/microchip/wilc1000/fw.h
index 5c5cac4aab02..7a930e89614c 100644
--- a/drivers/net/wireless/microchip/wilc1000/fw.h
+++ b/drivers/net/wireless/microchip/wilc1000/fw.h
@@ -13,6 +13,12 @@
 #define WILC_MAX_RATES_SUPPORTED		12
 #define WILC_MAX_NUM_PMKIDS			16
 #define WILC_MAX_NUM_SCANNED_CH			14
+#define WILC_NVMEM_MAX_NUM_BANK			6
+#define WILC_NVMEM_BANK_BASE			0x30000000
+#define WILC_NVMEM_LOW_BANK_OFFSET		0x102c
+#define WILC_NVMEM_HIGH_BANK_OFFSET		0x1380
+#define WILC_NVMEM_IS_BANK_USED			BIT(31)
+#define WILC_NVMEM_IS_BANK_INVALID		BIT(30)
 
 struct wilc_assoc_resp {
 	__le16 capab_info;
@@ -127,4 +133,11 @@ struct wilc_external_auth_param {
 	__le32 key_mgmt_suites;
 	__le16 status;
 } __packed;
+
+static inline u32 get_bank_offset_from_bank_index(unsigned int i)
+{
+	return (((i) < 2) ? WILC_NVMEM_LOW_BANK_OFFSET + ((i) * 32) :
+		WILC_NVMEM_HIGH_BANK_OFFSET + ((i) - 2) * 16);
+}
+
 #endif
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index eecee3973d6a..20ba030022a1 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -14,6 +14,7 @@
 #include <linux/if_arp.h>
 #include <linux/gpio/consumer.h>
 #include <linux/rculist.h>
+#include <uapi/linux/if_ether.h>
 
 #include "hif.h"
 #include "wlan.h"
@@ -278,6 +279,7 @@ struct wilc {
 	struct ieee80211_rate bitrates[ARRAY_SIZE(wilc_bitrates)];
 	struct ieee80211_supported_band band;
 	u32 cipher_suites[ARRAY_SIZE(wilc_cipher_suites)];
+	u8 nv_mac_address[ETH_ALEN];
 };
 
 struct wilc_wfi_mon_priv {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 37c32d17856e..a7a213e161f3 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -26,6 +26,54 @@ static inline void release_bus(struct wilc *wilc, enum bus_release release)
 	mutex_unlock(&wilc->hif_cs);
 }
 
+int wilc_load_mac_from_nv(struct wilc *wl)
+{
+	int ret = -EINVAL;
+	unsigned int i;
+
+	acquire_bus(wl, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	for (i = 0; i < WILC_NVMEM_MAX_NUM_BANK; i++) {
+		int bank_offset = get_bank_offset_from_bank_index(i);
+		u32 reg1, reg2;
+		u8 invalid;
+		u8 used;
+
+		ret = wl->hif_func->hif_read_reg(wl,
+						 WILC_NVMEM_BANK_BASE + bank_offset,
+						 &reg1);
+		if (ret) {
+			pr_err("Can not read address %d lower part", i);
+			break;
+		}
+		ret = wl->hif_func->hif_read_reg(wl,
+						 WILC_NVMEM_BANK_BASE + bank_offset + 4,
+						 &reg2);
+		if (ret) {
+			pr_err("Can not read address %d upper part", i);
+			break;
+		}
+
+		used = FIELD_GET(WILC_NVMEM_IS_BANK_USED, reg1);
+		invalid = FIELD_GET(WILC_NVMEM_IS_BANK_INVALID, reg1);
+		if (!used || invalid)
+			continue;
+
+		wl->nv_mac_address[0] = FIELD_GET(GENMASK(23, 16), reg1);
+		wl->nv_mac_address[1] = FIELD_GET(GENMASK(15, 8), reg1);
+		wl->nv_mac_address[2] = FIELD_GET(GENMASK(7, 0), reg1);
+		wl->nv_mac_address[3] = FIELD_GET(GENMASK(31, 24), reg2);
+		wl->nv_mac_address[4] = FIELD_GET(GENMASK(23, 16), reg2);
+		wl->nv_mac_address[5] = FIELD_GET(GENMASK(15, 8), reg2);
+
+		ret = 0;
+		break;
+	}
+
+	release_bus(wl, WILC_BUS_RELEASE_ALLOW_SLEEP);
+	return ret;
+}
+
 static void wilc_wlan_txq_remove(struct wilc *wilc, u8 q_num,
 				 struct txq_entry_t *tqe)
 {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index 54643d8fef04..d72a0a81bbda 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -445,4 +445,5 @@ int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
 			 u32 count);
 int wilc_wlan_init(struct net_device *dev);
 u32 wilc_get_chipid(struct wilc *wilc, bool update);
+int wilc_load_mac_from_nv(struct wilc *wilc);
 #endif

-- 
2.44.0


