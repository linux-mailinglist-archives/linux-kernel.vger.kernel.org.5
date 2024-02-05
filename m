Return-Path: <linux-kernel+bounces-52483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5868498CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B341C21E70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4811AAC4;
	Mon,  5 Feb 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ClFpumgF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7E1AACE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132435; cv=none; b=lfsOiqyQBhxVthFZ9zOCxK1iaW9l1QNvyOvxyZcA2vHPHohS/H6KDfzdR04svU1otLMI0FrGYxlzFG6HV3I5GN+M9y+VWfSd2WMijhCHKN792ekusUfQKzeE1MCkKeRF/hm3EMwh9cUQDdOq6+yeu2D2TE26NnXXwnFSvoKJld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132435; c=relaxed/simple;
	bh=oIwZe9RU0D3Qpo3jI9l25eoxcPCLpwHLDJ53dfgtEp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iCg9TW0Wjbywz63Sekhs4NxDY4L7zhRRKFc1WwXxaowqt3Hp3hY0mNWw1jaIAxFwD4W9zDHsNKfahqjFGwcLo/xP0gU1Arxw/394SdMy9qxtB3Y3888vsn62eBueYqN3v/etWM8rX16xiwHRfm0FwVlb6lom9TfuiMR2L4L9rdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ClFpumgF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fd55c7f93so12124175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707132430; x=1707737230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AgLkeYSewJO91gFxycBIzZeXPSjAt47c7sE98GYG9gQ=;
        b=ClFpumgFDtNavkPrNU4C1phVd5VsodtDv+MjRq74GkF5DuKYun57waso7Rp974CSVs
         3xgYHNjIQxwrilaGmzKjMkx5aaluibYNaXWqiB0ubv+M/Jut2RCo7QB5wdgvwKHV6JD1
         27/NYnPEkmvKW8cb5hVBxq89wa63KmmPCi/taKQu/O4XZiFsy5bv6H6+jEGdxpaQij3x
         RCDLdcia2laWVDFgijqxCTOnfdqtD1N9Uadmr5b7QtAjkVEhWrQvTYyeZOjvt14NaLih
         f1n7L06axq+2G4KH4KJPZk+m295J1iV5ap6PiBka7mFr7dwFIuBwUsgLk8oFR+4hV1ty
         9PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707132430; x=1707737230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgLkeYSewJO91gFxycBIzZeXPSjAt47c7sE98GYG9gQ=;
        b=Z4EjDUga53dBlz4Hd4pa0lXvyh7qMWOyyVDn7JA30T9l/yw+EmxV+F96SmfNLZFpNA
         NwUrVIzk8DtR42dMCZsEdCPm4YQr6ZUM9KgbPEFReMnct2w96ipoBv2odmqKjZKnYjzl
         FxEB/GiBdF34kHlDJPK9RWtCNlARoiusxQch3pNH6TCy/9J92+4PT3svhxahE6eHAxHF
         X80ZtqZ+8JZvigtQWAGw0ctiLsJhjGtQCdSYExz2E0GsbWC9zc0k2u7JA3DZpkJ37h1n
         JCgYxeNEXgIXf5HSj0peo3xSaFDx4SDydKnB676YR5AWvLgX/A2mU6u6pSb0K5rFETaY
         T52g==
X-Gm-Message-State: AOJu0YwSp5uTfRk+7fxuPeuEKYfa4I0IJyyocVrADnT0wBf8KCOA8LpP
	9uYY6ZDl6vfm8VhfR/7nrFRmTk3AekqIF8rENFythNGK90fjkxjUVqNcv2C19XU=
X-Google-Smtp-Source: AGHT+IEaCy3xpOfjqYuRM0Ero89Ry6d64pSEQYJhbx0beqvovllfdu9Gk+ZJATBBThLPPsUR92E54g==
X-Received: by 2002:a05:6000:1ac7:b0:33b:3d6f:6839 with SMTP id i7-20020a0560001ac700b0033b3d6f6839mr1496481wry.35.1707132430509;
        Mon, 05 Feb 2024 03:27:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUp0DSTbsMFgriJH4ZSWO+wwq6TtWgltTIeRPsXln0Bctn1hMfYfB1tMABUhU2tehUwqpaqjbt1lbVs8kaxAvrEKU29HnxvnPdlDRFvFOFRnMxZeRPuDGMbYDqTb2T4M/wpRRQFsiF3+B3pntw5I8k92cOfbxF9Z4dIT3GtPzb0AgmXHO3FUor/V6nCkBmsdrU//CddTRSUXy/1DpkSWxietwhcy5DARIOcdI6MJY7VEEpR9eZGV+kvpD967gVQ4s9y4/xIi80H2BW99U6isRlZwP5w0zallqxjQ6iO3kPTnxS3scTEl7TBeayz/P1Hp6SBbn+s9c4avdHW8Id8QwH16a71SMkEBmvp/aEKq69trPZQH9iNk/Yr9H0o/PqpDvi/B0XOoA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b0040e541ddcb1sm8307234wms.33.2024.02.05.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:27:10 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	yoshihiro.shimoda.uh@renesas.com,
	masaharu.hayakawa.ry@renesas.com,
	takeshi.saito.xv@renesas.com
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3] mmc: renesas_sdhi: Fix change point of data handling
Date: Mon,  5 Feb 2024 13:27:02 +0200
Message-Id: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On latest kernel revisions it has been noticed (on a RZ/G3S system) that
when booting Linux and root file system is on eMMC, at some point in
the booting process, when the systemd applications are started, the
"mmc0: tuning execution failed: -5" message is displayed on console.
On kernel v6.7-rc5 this is reproducible in 90% of the boots. This was
missing on the same system with kernel v6.5.0-rc1. It was also noticed on
kernel revisions v6.6-rcX on a RZ/G2UL based system but not on the kernel
this fix is based on (v6.7-rc5).

Investigating it on RZ/G3S lead to the conclusion that every time the issue
is reproduced all the probed TAPs are OK. According to datasheet, when this
happens the change point of data need to be considered for tuning.

Previous code considered the change point of data happens when the content
of the SMPCMP register is zero. According to RZ/V2M hardware manual,
chapter "Change Point of the Input Data" (as this is the most clear
description that I've found about change point of the input data and all
RZ hardware manual are similar on this chapter), at the time of tuning,
data is captured by the previous and next TAPs and the result is stored in
the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
If there is a mismatch b/w the previous and the next TAPs, it indicates
that there is a change point of the input data.

To comply with this, the patch checks if this mismatch is present and
updates the priv->smpcmp mask only if it is not. Previous code checked if
the value of SMPCMP register was zero. However, on RZ/G3S, this leads to
failues as it may happen, e.g., the following:
CMPNGU=0x0e, CMPNGD=0x0e, SMPCMP=0x000e000e.

Along with it, as mmc_send_tuning() may return with error even before the
MMC command reach the controller (and because at that point cmd_error = 0),
the update of priv->smpcmp mask has been done only if the return value of
mmc_send_tuning(mmc, opcode, &cmd_error) is 0 (success).

This change has been checked on the devices with the following DTSes by
doing 100 consecutive boots and checking for the tuning failure message:
- r9a08g045s33-smarc.dts
- r8a7742-iwg21d-q7.dts
- r8a7743-iwg20d-q7.dts
- r8a7744-iwg20d-q7.dts
- r8a7745-iwg22d-sodimm.dts
- r8a77470-iwg23s-sbc.dts
- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774c0-ek874.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc-rzg2ul.dts
- r9a07g044c2-smarc-rzg2lc.dts
- r9a07g044l2-smarc-rzg2l.dts
- r9a07g054l2-smarc-rzv2l.dts

Fixes: 5fb6bf51f6d1 ("mmc: renesas_sdhi: improve TAP selection if all TAPs are good")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- set priv->smpcmp if cmpngu_data == cmpngd_data and return code of
  mmc_send_tuning() is zero
- removed workaround introduced previously in
  renesas_sdhi_select_tuning() as it is not needed with the code from v3
- update patch description

Changes in v2:
- read the SH_MOBILE_SDHI_SCC_SMPCMP register only on success path of
  mmc_send_tuning()

 drivers/mmc/host/renesas_sdhi_core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c675dec587ef..8871521e1274 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
@@ -312,6 +313,8 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN	BIT(8)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA	GENMASK(23, 16)
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA	GENMASK(7, 0)
 
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
@@ -703,11 +706,18 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		/* Set sampling clock position */
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, i % priv->tap_num);
 
-		if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
-			set_bit(i, priv->taps);
+		if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0) {
+			u32 val, cmpngu_data, cmpngd_data;
+
+			val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP);
+			cmpngu_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA, val);
+			cmpngd_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA, val);
+
+			if (cmpngu_data == cmpngd_data)
+				set_bit(i, priv->smpcmp);
 
-		if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
-			set_bit(i, priv->smpcmp);
+			set_bit(i, priv->taps);
+		}
 
 		if (cmd_error)
 			mmc_send_abort_tuning(mmc, opcode);
-- 
2.39.2


