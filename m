Return-Path: <linux-kernel+bounces-45527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2952843219
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624281F26694
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120F1EAD5;
	Wed, 31 Jan 2024 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JJSX43b5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69417F8;
	Wed, 31 Jan 2024 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661445; cv=none; b=GRgmAsEDp/3msDXY3bvjF5u6jskYmn4qfcREXBxik/7bp9JJyUBRPPludpbr6mxj0haA+1mX7S6aFo0kvKc/kyPtrxf5ZEmzoAdaABvJqkQsGVLa67Z5Fe5XovSE3ywjVj7qQkTqKSgVH9Khu/renRF40VoHsmchpooY6G5vot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661445; c=relaxed/simple;
	bh=EnOc0EzSAzYuA0nYU+KTduJT+7wxBgmYtycNXpZ9rVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgD/7e/dZ9/Wsy92cOY4IFXtrL8VWkyUXLe0gyg8y2klPclsjVBYCIp6fHJrlyOJMmT1ubONcIAv/xIBJbQq6De9n8kAA86RnqkF+JGf8ciykdz3bMGcuOnj4eFjWx/i9hjjPiy6d4walI5afWMJ5WG6A4n5DS9NZ3s6nFSREU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JJSX43b5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bF3I121335;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=Kb1YRhHFElMz/np+okVMEjKtBNYvxamj0d8EUV8sUyk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JJSX43b5zabhLTokflNZYxifWRyKrvbuK1ZxkbVYh1arSapC/1WagZfg92ZkNvdH8
	 l+GszLIx+ZTS0he8mjrp81VtMrMdc7GGPKwEDaWuRIUHNGsa4XPp8Kh/mQjf4dzwt3
	 Pl7fzlKN2X5xcrweDhwtb02hNU1DE/GtAJO7jDvw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFeQ007816
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:15 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEw8026520;
	Tue, 30 Jan 2024 18:37:14 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, Randolph Sapp <rs@ti.com>
Subject: [RFC PATCH 01/13] drivers: mmc: host: sdhci_am654: Add tuning algorithm for delay chain
Date: Tue, 30 Jan 2024 18:37:02 -0600
Message-ID: <20240131003714.2779593-2-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131003714.2779593-1-jm@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently the sdhci_am654 driver only supports one tuning
algorithm which should be used only when DLL is enabled. The
ITAPDLY is selected from the largest passing window and the
buffer is viewed as a circular buffer.

The new algorithm should be used when the delay chain
is enabled. The ITAPDLY is selected from the largest passing
window and the buffer is not viewed as a circular buffer.

This implementation is based off of the following paper: [1].

Also add support for multiple failing windows.

[1] https://www.ti.com/lit/an/spract9/spract9.pdf

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 128 +++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d659c59422e1..59d205511312 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -149,10 +149,17 @@ struct sdhci_am654_data {
 	int strb_sel;
 	u32 flags;
 	u32 quirks;
+	bool dll_enable;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
 
+struct window {
+	u8 start;
+	u8 end;
+	u8 length;
+};
+
 struct sdhci_am654_driver_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 flags;
@@ -290,10 +297,13 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
+	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
-	else
+		sdhci_am654->dll_enable = true;
+	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
+		sdhci_am654->dll_enable = false;
+	}
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
@@ -408,39 +418,117 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-#define ITAP_MAX	32
+#define ITAPDLY_LENGTH 32
+#define ITAPDLY_LAST_INDEX 31
+static u32 calculate_itap(struct sdhci_host *host, struct window *fail_window,
+			  u8 num_fails, bool circular_buffer)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	struct window pass_window, first_fail, last_fail;
+	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
+	int prev_end_fail = -1;
+
+	memset(&pass_window, 0, sizeof(pass_window));
+	memset(&first_fail, 0, sizeof(first_fail));
+	memset(&last_fail, 0, sizeof(last_fail));
+
+	if (!num_fails) {
+		return ITAPDLY_LAST_INDEX >> 1;
+	} else if (fail_window->length == ITAPDLY_LENGTH) {
+		dev_warn(dev, "No passing ITAPDLY, return 0\n");
+		return 0;
+	} else {
+		for (int i = 0; i < num_fails; i++) {
+			start_fail = fail_window[i].start;
+			end_fail = fail_window[i].end;
+
+			if (i == 0) {
+				first_fail.start = start_fail;
+				first_fail.end = end_fail;
+				first_fail.length = fail_window[0].length;
+			}
+
+			if (i == num_fails - 1) {
+				last_fail.start = start_fail;
+				last_fail.end = end_fail;
+				last_fail.length = fail_window[i].length;
+			}
+
+			pass_length = start_fail - (prev_end_fail + 1);
+			if (pass_length > pass_window.length) {
+				pass_window.start = prev_end_fail + 1;
+				pass_window.length = pass_length;
+			}
+			prev_end_fail = end_fail;
+		}
+
+		if (!circular_buffer) {
+			if (ITAPDLY_LAST_INDEX - end_fail > pass_window.length) {
+				pass_window.start = end_fail + 1;
+				pass_window.length = ITAPDLY_LAST_INDEX - end_fail;
+			}
+		} else {
+			pass_length = ITAPDLY_LAST_INDEX - end_fail + first_fail.start;
+			if (pass_length > pass_window.length) {
+				pass_window.start = last_fail.end + 1;
+				pass_window.length = pass_length;
+			}
+		}
+	}
+
+	if (!circular_buffer)
+		itap = pass_window.start + (pass_window.length >> 1);
+	else
+		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
+
+	if (itap < 0 || itap > ITAPDLY_LAST_INDEX)
+		itap = 0;
+
+	return itap;
+}
+
 static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 					       u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
-	u32 itap;
+	struct window fail_window[ITAPDLY_LENGTH];
+	u8 prev_pass = 1;
+	u8 fail_index = 0;
+	u8 curr_pass, itap, i;
+
+	for (i = 0; i < ITAPDLY_LENGTH; i++)
+		memset(&fail_window[i], 0, sizeof(fail_window[0]));
 
 	/* Enable ITAPDLY */
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
 			   1 << ITAPDLYENA_SHIFT);
 
-	for (itap = 0; itap < ITAP_MAX; itap++) {
+	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
 		sdhci_am654_write_itapdly(sdhci_am654, itap);
 
-		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
-		if (cur_val && !prev_val)
-			pass_window = itap;
+		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
-		if (!cur_val)
-			fail_len++;
+		if (!curr_pass && prev_pass)
+			fail_window[fail_index].start = itap;
 
-		prev_val = cur_val;
+		if (!curr_pass) {
+			fail_window[fail_index].end = itap;
+			fail_window[fail_index].length++;
+		}
+
+		if (curr_pass && !prev_pass)
+			fail_index++;
+
+		prev_pass = curr_pass;
 	}
-	/*
-	 * Having determined the length of the failing window and start of
-	 * the passing window calculate the length of the passing window and
-	 * set the final value halfway through it considering the range as a
-	 * circular buffer
-	 */
-	pass_len = ITAP_MAX - fail_len;
-	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
+
+	if (fail_window[fail_index].length != 0)
+        fail_index++;
+
+	itap = calculate_itap(host, &fail_window[0], fail_index,
+			      (sdhci_am654->dll_enable ? true : false));
+
 	sdhci_am654_write_itapdly(sdhci_am654, itap);
 
 	return 0;
-- 
2.34.1


