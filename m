Return-Path: <linux-kernel+bounces-153214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644898ACAFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17F8B23A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77D81509BA;
	Mon, 22 Apr 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObNaCSiE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE01509A6;
	Mon, 22 Apr 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782330; cv=none; b=hP64yeSvlEJQHRTJWWgX0cqUiTqQoJ38FZlDTdms+Q7zbjeSTQVAhg8/bcp7lqIK0cW+LnrWEoEOUFgkBCcgCloPvHi4f5MvyEx6M4YC60N5exjAM1yfLIgy6RFKiMQs2l7TKF3GSSsUfI3I/abQPq5/DY3eXS5y+VOC05ItiAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782330; c=relaxed/simple;
	bh=Ys9VTKwJKD0yhr59GPocT6+WHUDojhYItiElQ/fTbaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPtTjjRlZ5/9Vr//Mgq9iKN3qaa61uXiUvLSshWoTEkYwg9KdSvCqB6obk0cw3Fb2orI7s85NXmrSSB6PwJDC7Un+JHTVU2IMBiIPYE5827PgmxIm7TWMB7/+jo+rXLRJpuM7inVId2+iDnuAopPZYLFOHWs/zRlowRfAXQvSv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObNaCSiE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so29295525ad.0;
        Mon, 22 Apr 2024 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782328; x=1714387128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o74Spy0FGodrVRF//1K09Oex1mKbF1B5eEpPIcLzu6I=;
        b=ObNaCSiE4wXdDxhyZchhwUNB0JEXNqW9gQT0wcbplgDShFTqdASM6LsKGkgzX3cbPu
         2PIoN3baP/DCn26QXeQ6PTTBk5Px+8UVP+9SctNyvzgTEuCm7JrLBfpnxSSnSTS6jgaL
         tHWDRIbf8wOS1z5reOvS78i9Gh2uRZzhQmh583ZQK7vmjXYmSsIreWzYVNBLQDWg/Nxm
         nH5vHI41OKQ1nvd4ObrdyrGLECNrV5bsqbh4Cu+F+B/DDlB7X5HGAsmIGWs+B2oGAMW/
         OvFKaFWn5Iq4DrxPv76N0yXACpPbRHUgj6NpPB4EaxOeiuo2hEt8+KavqlvDIIZdh2AS
         G6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782328; x=1714387128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o74Spy0FGodrVRF//1K09Oex1mKbF1B5eEpPIcLzu6I=;
        b=xR3rSjhnWzyJyKQfS/XJOvEfcLwC1pn8BVgTp2YjpPJe0Qiro3a+wR6+3leRYWlj4e
         dKMtLR4INHcwBnPIhl8rSm0gCFyjpuM5ktvIJkVgN/SGTUSDLgVKocQsJE26gO4Vkj6x
         4u5IwczzAaBFNB84ZzHbHSMwY4Y5U9CKhg6vJQ7EA7Ki5MMIca3yiJd7aVorkYGkh31/
         Qw5joUpBeZiYl7ofpt9l3cA1AM2Lf/p7wArbyDSGstVYK370sg7T8jy3Bxgj+NAvuVuP
         zRSdbeToGHwACEdHIXEFY9fC8rGeHsF6jvhPFEfDJoBuo/OMSVhagev9GzymnZKFAKlc
         6VsA==
X-Forwarded-Encrypted: i=1; AJvYcCWe8Nks0doOuJyRoYSmhUuy7HV89AUTsv2bkStPa8nVT1If8FN38cd4kvCIpo2fz9TXHDlEwPH+GKBkppURSQpKYVzUEBHj6itadPII
X-Gm-Message-State: AOJu0Yzhwivd0aIbZacsJFgUux8TEPC6gRivv5nhdIRQDQ8SO2OgpE9G
	TkeNsa2w/kttPG0nK2ksSDNtU+5rTzBZqxmpNW0lnh8giL6uQXiT
X-Google-Smtp-Source: AGHT+IG4ZiurDxiBGSw+4Io+MaJn5qrt+WtbfIYLobY+deUAfXMXiMfiuJTQBfiaEfIr7+mnIk5LqQ==
X-Received: by 2002:a17:902:da83:b0:1e4:55d8:e5f1 with SMTP id j3-20020a170902da8300b001e455d8e5f1mr15119111plx.5.1713782328284;
        Mon, 22 Apr 2024 03:38:48 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:47 -0700 (PDT)
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
Subject: [PATCH V15 14/22] mmc: sdhci-uhs2: add set_ios()
Date: Mon, 22 Apr 2024 18:37:37 +0800
Message-Id: <20240422103745.14725-15-victorshihgli@gmail.com>
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

This is a sdhci version of mmc's set_ios operation.
THis is used to handle basic IO bus setting.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_set_ios().

Updates in V13:
 - Add judgment condition for power mode in the __sdhci_uhs2_set_ios().
 - Modify comment message.

Updates in V9:
 - Simplity the turning_on_clk in sdhci_set_ios().

Updates in V8:
 - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
   and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
 - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
   and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
 - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
   in sdhci_uhs2_set_ios().

Updates in V7:
 - Remove unnecessary functions.

Updates in V6:
 - Modify return value in some functions.
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 95 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
 drivers/mmc/host/sdhci.h      |  2 +
 4 files changed, 132 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 8c802142e875..b663efc1c238 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -224,6 +224,101 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
 
+/**
+ * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
+ * @host:	SDHCI host
+ * @clear:	bit-wise clear mask
+ * @set:	bit-wise set mask
+ *
+ * Set/unset bits in UHS-II Error Interrupt Status Enable register
+ */
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
+{
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
+	ier &= ~clear;
+	ier |= set;
+	sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
+	sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
+
+static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u8 cmd_res, dead_lock;
+	u16 ctrl_2;
+
+	/* UHS2 Timeout Control */
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+
+	/* change to use calculate value */
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+
+	sdhci_uhs2_clear_set_irqs(host,
+				  SDHCI_UHS2_INT_CMD_TIMEOUT |
+				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
+				  0);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+	sdhci_uhs2_clear_set_irqs(host, 0,
+				  SDHCI_UHS2_INT_CMD_TIMEOUT |
+				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
+
+	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->power_mode != MMC_POWER_OFF &&
+	    (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
+	     ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
+	     ios->timing == MMC_TIMING_UHS2_SPEED_B ||
+	     ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
+		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
+	else
+		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+	host->timing = ios->timing;
+
+	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
+		sdhci_enable_preset_value(host, true);
+
+	if (host->ops->set_power)
+		host->ops->set_power(host, ios->power_mode, ios->vdd);
+	else
+		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
+
+	sdhci_set_clock(host, host->clock);
+}
+
+static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
+		 mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd, ios->timing);
+
+	if (!mmc_card_uhs2(mmc)) {
+		sdhci_set_ios(mmc, ios);
+		return 0;
+	}
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return 0;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (ios->power_mode == MMC_POWER_OFF) {
+			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+			mmc_regulator_set_vqmmc2(mmc, ios);
+		}
+		return -1;
+	}
+
+	sdhci_set_ios_common(mmc, ios);
+
+	__sdhci_uhs2_set_ios(mmc, ios);
+
+	return 0;
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 089a6c0cabda..e08aa60bf06b 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -180,5 +180,6 @@ struct mmc_command;
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
+void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 153137dd8e34..368aa33d881e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -47,8 +47,6 @@
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
@@ -1878,6 +1876,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	case MMC_TIMING_MMC_HS400:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
 		break;
+	case MMC_TIMING_UHS2_SPEED_A:
+	case MMC_TIMING_UHS2_SPEED_A_HD:
+	case MMC_TIMING_UHS2_SPEED_B:
+	case MMC_TIMING_UHS2_SPEED_B_HD:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
+		break;
 	default:
 		pr_warn("%s: Invalid UHS-I mode selected\n",
 			mmc_hostname(host->mmc));
@@ -2324,24 +2328,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
 	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
 }
 
-void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	bool reinit_uhs = host->reinit_uhs;
-	bool turning_on_clk = false;
-	u8 ctrl;
-
-	host->reinit_uhs = false;
-
-	if (ios->power_mode == MMC_POWER_UNDEFINED)
-		return;
-
-	if (host->flags & SDHCI_DEVICE_DEAD) {
-		if (!IS_ERR(mmc->supply.vmmc) &&
-		    ios->power_mode == MMC_POWER_OFF)
-			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-		return;
-	}
 
 	/*
 	 * Reset the chip on each power off.
@@ -2358,8 +2347,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2375,6 +2362,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			mmc->max_busy_timeout /= host->timeout_clk;
 		}
 	}
+}
+EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
+
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	bool reinit_uhs = host->reinit_uhs;
+	bool turning_on_clk;
+	u8 ctrl;
+
+	host->reinit_uhs = false;
+
+	if (ios->power_mode == MMC_POWER_UNDEFINED)
+		return;
+
+	if (host->flags & SDHCI_DEVICE_DEAD) {
+		if (!IS_ERR(mmc->supply.vmmc) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		return;
+	}
+
+	turning_on_clk = ios->clock != host->clock && ios->clock && !host->clock;
+
+	sdhci_set_ios_common(mmc, ios);
 
 	if (host->ops->set_power)
 		host->ops->set_power(host, ios->power_mode, ios->vdd);
@@ -2959,7 +2971,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -2987,6 +2999,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0cb74e0410ad..c65ae51c9738 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -849,6 +849,8 @@ bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
-- 
2.25.1


