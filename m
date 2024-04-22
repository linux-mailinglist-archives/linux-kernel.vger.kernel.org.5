Return-Path: <linux-kernel+bounces-153212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A978ACAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB5B2393F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273A150986;
	Mon, 22 Apr 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXvL00d5"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0314F9F8;
	Mon, 22 Apr 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782322; cv=none; b=KZgikRLhi7xVksQX1JdIfDSYz1UIaHgBW1pbPR8CZjHTtomrxQCLfAE4yzgv01CzDOlaHmJSKBPS76r0WT1VGIijMW7fO0bxNliBYzVp1OedaXLJ4Wi40avSMHpN6u8j1gP7s9Jm/PPiMjeNmaoMYpeLow6Hd/LS4VKHkunE39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782322; c=relaxed/simple;
	bh=TGNFRl0bEsm5a/DANJ2n0yF4bsLRDTKEFhYpT2sZUMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lql0bA6bilb8TwESAE1R8mOuTHgh2vb8a4VQinyC5fFpJ7X/FGr8gQx90ZEOzuDHwmo4mOb4hzTB9rNHF+rtC89RlU09r/FD1bttBdT41lm4mcT1byWVgEhd/0oWMbSJ74TpoezXLSq3KeeFqvzGdqIzryMHPe0r4BPSz5d2NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXvL00d5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e9451d8b71so12395895ad.0;
        Mon, 22 Apr 2024 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782320; x=1714387120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NiHYN/mYnCyBXlnKwSy1+9k/fPyQAhWpoDXXAEwvdM=;
        b=iXvL00d5SuHYSWRiduyb0IlhJmLLLH8/zhX6kj3T+Pd5vxFKtQ1F05BuYToNSDMjqM
         I1Va0YiElTw4yzD6MSo1BvUlexhelCFs6KsT45uQ7rZtbb9KmGtLbH0uz3bMF6l2ywAN
         mqJm/uI0NfZ7EwXxHwV15xS1hIv3C558YvNotPcSMlG85HPWnr7m5TayRi/ijx5wN3eI
         2+Cz+yGRcEglkQpoNEviItndEAh3oxqqlVu9lBO99xaruSentJvfTJP36dpDHSiCENcn
         Kc9l/zaYiNBFFon7jO5MeXFhUfIv0aM/CxAucBLpcFUp9htmvt6IR349+Nmg/dz73S45
         rffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782320; x=1714387120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NiHYN/mYnCyBXlnKwSy1+9k/fPyQAhWpoDXXAEwvdM=;
        b=JYJ60MoKzCKewrGFcJXrFPTFpa8mFj0Cl7/tGCTS9zq7tRaJ+hK2KRZndnDJByPlHJ
         wOuTD2udSuVp2Z8qOqfJyphHOotfrHBIIe/QQ2/Gmo561MdmOwENfDA9x6mB6uMtKSAF
         BGTspQKXT7RUG43qzeuT1ebTPfkIUtU4WCZWYKBjSHZvCYNYQLFNiP/NpyDmImLB8Y8n
         JKRrr9cT9Ofm2TMPpfD9pSCtv40D32NG1J2yJte6Bh3HP5IUi9molzsTHNJCU/L2Blqo
         uCQwU3+HlFhukEVzPsxY1ViNxOwNefdpoZ8oP1ZpNMbk3QpdpXUMKJkMVrWtTFvAPqLA
         tZgw==
X-Forwarded-Encrypted: i=1; AJvYcCUS8uVIkroE012dGkOqwTcln+sfH2HIMB9lQIJ0JlhiRJBynzestzr7Fql8dUJCxgg8k0Z6HMSmN+8k1pUmy3Oz3qDUeH2+P8G3LxRI
X-Gm-Message-State: AOJu0Yz40Se1eSwAHXDhBLzOPA1uQoJjNq/cIs68fY8MxhZ9Hhv6T16g
	YtJsehX1k8op0PYKWmKrqohJLoCPKFxB4xgADS+rvFMtVNzvEFfK
X-Google-Smtp-Source: AGHT+IF5e50VpDAw8AJjjgcngeM038m+G8ofPhKYM3dXUsZ3rv2HWzmltVZjzdArBp2K62eczPNJhw==
X-Received: by 2002:a17:902:c40c:b0:1e4:2b90:7282 with SMTP id k12-20020a170902c40c00b001e42b907282mr13642341plk.14.1713782320373;
        Mon, 22 Apr 2024 03:38:40 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:40 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V15 12/22] mmc: sdhci-uhs2: add set_power() to support vdd2
Date: Mon, 22 Apr 2024 18:37:35 +0800
Message-Id: <20240422103745.14725-13-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's set_power operation.
Use sdhci_uhs2_set_power() to set VDD2 for support UHS2 interface.
VDD2, as well as VDD, is handled here.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V13:
 - Drop use vmmc2.
 - Modify comment message.

Updates in V10:
 - Move some definitions of PatchV9[05/23] to PatchV10[11/23].

Updates in V9:
 - Modify annotations in sdhci_get_vdd_value().

Updates in V8:
 - Adjust the position of matching brackets.
 - Add the initial value of the pwr in sdhci_uhs2_set_power().

Updates in V7:
 - Add clear the power reg before setting a new value
   in sdhci_uhs2_set_power().
 - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value().
 - Drop pwr variable in sdhci_get_vdd_value().

Updates in V6:
 - Add mmc_opt_regulator_set_ocr().
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
 drivers/mmc/host/sdhci.h      |  1 +
 3 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 7652158ea151..8ad9a25484fa 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -59,6 +59,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
  *                                                                           *
 \*****************************************************************************/
 
+static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
+					    struct regulator *supply,
+					    unsigned short vdd_bit)
+{
+	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
+}
+
 /**
  * sdhci_uhs2_reset - invoke SW reset
  * @host: SDHCI host
@@ -104,6 +111,47 @@ static void sdhci_uhs2_reset_cmd_data(struct mmc_host *mmc)
 	}
 }
 
+static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr = 0;
+
+	if (mode != MMC_POWER_OFF) {
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr)
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
+	} else {
+		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		/* support 1.8v only for now */
+		mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
+
+		/* Clear the power reg before setting a new value */
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		/* vdd first */
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		mdelay(5);
+
+		pwr |= SDHCI_VDD2_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		mdelay(5);
+	}
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f9db861853b4..153137dd8e34 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -23,7 +23,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-
+#include <linux/bug.h>
 #include <linux/leds.h>
 
 #include <linux/mmc/mmc.h>
@@ -2062,41 +2062,46 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 }
 
+unsigned short sdhci_get_vdd_value(unsigned short vdd)
+{
+	switch (1 << vdd) {
+	case MMC_VDD_165_195:
+	/*
+	 * Without a regulator, SDHCI does not support 2.0v
+	 * so we only get here if the driver deliberately
+	 * added the 2.0v range to ocr_avail. Map it to 1.8v
+	 * for the purpose of turning on the power.
+	 */
+	case MMC_VDD_20_21:
+		return SDHCI_POWER_180;
+	case MMC_VDD_29_30:
+	case MMC_VDD_30_31:
+		return SDHCI_POWER_300;
+	case MMC_VDD_32_33:
+	case MMC_VDD_33_34:
+	/*
+	 * 3.4V ~ 3.6V are valid only for those platforms where it's
+	 * known that the voltage range is supported by hardware.
+	 */
+	case MMC_VDD_34_35:
+	case MMC_VDD_35_36:
+		return SDHCI_POWER_330;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
+
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd)
 {
 	u8 pwr = 0;
 
 	if (mode != MMC_POWER_OFF) {
-		switch (1 << vdd) {
-		case MMC_VDD_165_195:
-		/*
-		 * Without a regulator, SDHCI does not support 2.0v
-		 * so we only get here if the driver deliberately
-		 * added the 2.0v range to ocr_avail. Map it to 1.8v
-		 * for the purpose of turning on the power.
-		 */
-		case MMC_VDD_20_21:
-			pwr = SDHCI_POWER_180;
-			break;
-		case MMC_VDD_29_30:
-		case MMC_VDD_30_31:
-			pwr = SDHCI_POWER_300;
-			break;
-		case MMC_VDD_32_33:
-		case MMC_VDD_33_34:
-		/*
-		 * 3.4 ~ 3.6V are valid only for those platforms where it's
-		 * known that the voltage range is supported by hardware.
-		 */
-		case MMC_VDD_34_35:
-		case MMC_VDD_35_36:
-			pwr = SDHCI_POWER_330;
-			break;
-		default:
+		pwr = sdhci_get_vdd_value(vdd);
+		if (!pwr) {
 			WARN(1, "%s: Invalid vdd %#x\n",
 			     mmc_hostname(host->mmc), vdd);
-			break;
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 47962cebee22..0cb74e0410ad 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
 				     unsigned char mode,
 				     unsigned short vdd);
+unsigned short sdhci_get_vdd_value(unsigned short vdd);
 void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 			   unsigned short vdd);
 int sdhci_get_cd_nogpio(struct mmc_host *mmc);
-- 
2.25.1


