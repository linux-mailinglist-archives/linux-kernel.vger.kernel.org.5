Return-Path: <linux-kernel+bounces-55781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30984C1B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1EFB1C240D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C62EECC;
	Wed,  7 Feb 2024 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GDlJGkLJ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA659461;
	Wed,  7 Feb 2024 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268526; cv=none; b=C5YTZHv4fdJoRINFGUhehK7KwHQHD1LCc1bLlR453xZXeiWJLixXmPxv+6rKiV/WqqzbARrwCOk+MnD0FbNFgwhbLBKaWUk5pRadMVjMAa+EygwcRtOETFBMMv6wGB6s4Dnt9VpB8/N8nRpjRdeAgzp19Hy/SO1VGt3cU2B1AQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268526; c=relaxed/simple;
	bh=vEJuJnznevCtnn8/Yc+6t+V2214fJ7PhG7y9sRXDbKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptVgxMUg+ZoKErleUHIS9ODXSjrE6ohTEnelNFcqF/TYCzWDVbtKBtbQ02KmMlat1HpFH8CUHcGOxFoqcfgC0RZf7ZP6IVZGXYzQY6f5HnZHtUZi6YytnZtacvMt7mcgW9qjEFi4jXEQgzulSw2w9dyvTJvgIn5nLVXQ9k58jOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GDlJGkLJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKXC084642;
	Tue, 6 Feb 2024 19:15:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707268520;
	bh=GLzvA3x9NGKxoH4mJVT6OzvAetnAEQLqZDkQOYK8o5A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GDlJGkLJ2IuehhMERLivcXjGyFBS98kOV7l4z87UC7jdqEoFxTOvy9w96KTvbAFi1
	 1brOawg0D/u18HeSg0EnbrBXxT3A+N9HlzTHsrHsaN8V2v5Qok6mwUyY5ksNmCk5c1
	 ZqVoK3ylyZE2I2EC8cllB6L4zqsSVUn3HnwHh3ds=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4171FKkX005448
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 19:15:20 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 19:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 19:15:20 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKMp122103;
	Tue, 6 Feb 2024 19:15:20 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/7] mmc: sdhci_am654: Add tuning algorithm for delay chain
Date: Tue, 6 Feb 2024 19:15:14 -0600
Message-ID: <20240207011520.3128382-2-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011520.3128382-1-jm@ti.com>
References: <20240207011520.3128382-1-jm@ti.com>
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

Fixes: 13ebeae68ac9 ("mmc: sdhci_am654: Add support for software tuning")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v1->v2:
- Remove unnecessary indentations and if/else in
 sdhci_am654_calculate_itap()
- Optimize sdhci_am654_calculate_itap()
---
 drivers/mmc/host/sdhci_am654.c | 111 +++++++++++++++++++++++++++------
 1 file changed, 91 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d659c59422e1..2c66a965c225 100644
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
@@ -408,39 +418,100 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-#define ITAP_MAX	32
+#define ITAPDLY_LENGTH 32
+#define ITAPDLY_LAST_INDEX 31
+static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
+			  *fail_window, u8 num_fails, bool circular_buffer)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	struct window pass_window = {0, 0, 0};
+	u8 first_fail_start = 0, last_fail_end = 0;
+	int prev_fail_end = -1;
+	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
+	u8 i;
+
+	if (!num_fails)
+		return ITAPDLY_LAST_INDEX >> 1;
+
+	if (fail_window->length == ITAPDLY_LENGTH) {
+		dev_err(dev, "No passing ITAPDLY, return 0\n");
+		return 0;
+	}
+
+	first_fail_start = fail_window->start;
+	last_fail_end = fail_window[num_fails - 1].end;
+
+	for (i = 0; i < num_fails; i++) {
+		start_fail = fail_window[i].start;
+		end_fail = fail_window[i].end;
+		pass_length = start_fail - (prev_fail_end + 1);
+
+		if (pass_length > pass_window.length) {
+			pass_window.start = prev_fail_end + 1;
+			pass_window.length = pass_length;
+		}
+		prev_fail_end = end_fail;
+	}
+
+	if (!circular_buffer)
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
+	else
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
+
+	if (pass_length > pass_window.length) {
+		pass_window.start = last_fail_end + 1;
+		pass_window.length = pass_length;
+	}
+
+	if (!circular_buffer)
+		itap = pass_window.start + (pass_window.length >> 1);
+	else
+		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
+
+	return (itap < 0 || itap > ITAPDLY_LAST_INDEX ? 0 : itap);
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
+	u8 curr_pass, itap;
+
+	memset(fail_window, 0, sizeof(fail_window[0]) * ITAPDLY_LENGTH);
 
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
+		fail_index++;
+
+	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					  (sdhci_am654->dll_enable));
+
 	sdhci_am654_write_itapdly(sdhci_am654, itap);
 
 	return 0;
-- 
2.43.0


