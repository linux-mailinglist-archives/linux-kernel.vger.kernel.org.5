Return-Path: <linux-kernel+bounces-69784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D6858E85
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A756A282C97
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DEC1E888;
	Sat, 17 Feb 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UIIUWUCS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900A1CAA5;
	Sat, 17 Feb 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708164141; cv=none; b=FiUetxSgwnh40kk5iPKrzaLHK1t0eR9m7b7eREoYqzFnqTwiE+eXsQ5f8tS+hqPr8/RCAp3OJxmSzIe18MkMFv2zoenKMuUxfXXZg2pxIXfL300B/VBcmLZW2CXgxnRQqeCD3ArnLIt2Oqc47es3+QLfiLuzFAiKKgedKm3URao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708164141; c=relaxed/simple;
	bh=c7c1Q3/20PbpOtZUY4apUCKgz6BG6WLPvFsA+YNlXP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl0Uysgbcbh6mJaLATJsqqSin5AqanPilkkA4GeEAwRIXMTTw8Ggprienc0DYSkG+QGMxRAU8o8DNPL04FYi4a6pXHTc8BfWdGAiMueavDPyMDFo1syqI0ZGjAyZ06HtgcRcO1UZe1vAQH+GoUivjfRhMguUYb3G0EydlwJ/eCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UIIUWUCS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso426924766b.2;
        Sat, 17 Feb 2024 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708164134; x=1708768934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqfx68Stq1v6Qf4tIPhse4R7f6lQzjIJhU0OnU94194=;
        b=UIIUWUCSQLDGpM2qU+d8pfLd7YjfRehKfr7N11eQc5S3EHfZNMejDfQqutXuGRr9Om
         WfOl/OFU6g4nS7cRT6ewI2a1qdF+FvTKuP56z8d+eyGFJ8hn99YIIkia2GL/Pgf468p3
         peijXMuXCLiLJ16E9P2j2uf/UQH7FPKeVgH5eRolokWUJMumE+hmzODJNvQzbHv9ARKy
         eRMftZ23e+TzWk8rOtRaFYK0zk5Z/blIb6BsFx0mgZnFC5lrjkmNQOK6ALPeKANQvbZM
         0oaRKkKW/hVSqfqvN4Vw3koOiOKi/VsC/O9N5XvLct6S8o/fTw+bop/lSIHDxv0b1kcz
         6INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708164134; x=1708768934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqfx68Stq1v6Qf4tIPhse4R7f6lQzjIJhU0OnU94194=;
        b=r60UKr7KBgDwbx5T/N38CeX+iI06uSJ1rd8sycb02b3JebPj46qvyWPPexSNa6EPQe
         HwjVXl+U/fpK+jZdF1KRCXkLj7QLpmAz1xWKR7lPHvrEpCnRE6maq/moqE7fgl8LsT3r
         oja205CW0jyn+b5QgzLkvI1yI1Ux8jQM7NdV+z7XYBkKHrab5btBjaZVqFzwnzXqM7HZ
         OW7xI6RFs5zBg81nd6G5PZ6M0W40Wi2aU5uIpua7ON0kUE6dVIvFREj8kB1cOAtO+Tpn
         MJYaaUDrQi1J/3W8MvvIT6+D84qe6kH7FOUt3yW2mukN7x05jEfwZBw64wvLIWcRCL2x
         DdkA==
X-Forwarded-Encrypted: i=1; AJvYcCV/+aTxZZfvppDlPpx8lgW2CYG44n1DMeWFMtw25rFvHhqOEYqxn7RmE1uaPtiOezU1Tzph2l75fNw3nB6o9AuypvJBrdTIrZcLMZspICyjtol3mPHB+kifiaBPxKKdfvJdzUm0Vy0v
X-Gm-Message-State: AOJu0YzxOjt4byl8W8Wpj/qQf4GwgEgwRfLSNf/7Extwdl0joz86oKGW
	u5D5/qLBbljMyrtgvSrtOLwPnbLueqAgDffN4kwLbC+gx32xVUKK
X-Google-Smtp-Source: AGHT+IEb82KoWpU5FoV1SEo4/+fKxZ4+uJYz6Hsw8ouQNl0/LXhPOmil04C+qDwX+A36tj5/j83VzA==
X-Received: by 2002:a17:906:694b:b0:a3d:590:195e with SMTP id c11-20020a170906694b00b00a3d0590195emr6136810ejs.4.1708164134317;
        Sat, 17 Feb 2024 02:02:14 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c18b-3d00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c18b:3d00::e63])
        by smtp.googlemail.com with ESMTPSA id vu2-20020a170907a64200b00a3d2e690abfsm832444ejc.122.2024.02.17.02.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 02:02:13 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	ulf.hansson@linaro.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/2] mmc: meson-mx-sdhc: Remove .card_hw_reset callback
Date: Sat, 17 Feb 2024 11:02:00 +0100
Message-ID: <20240217100200.1494980-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
References: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 32f18e596141 ("mmc: improve API to make clear hw_reset callback
is for cards") made it clear that the hw_reset callback is intended for
resetting the card. Remove the .card_hw_reset callback from the
meson-mx-sdhc-mmc driver because it's purpose is to reset the SDHC
controller (FIFOs, PHY, DMA interface, ...).

While here also rename and change the argument of meson_mx_sdhc_hw_reset
so it cannot be called by accident as a replacement for card_hw_reset in
the future.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 1ed9731e77ef..31f750301dc1 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -65,10 +65,8 @@ static const struct regmap_config meson_mx_sdhc_regmap_config = {
 	.max_register = MESON_SDHC_CLK2,
 };
 
-static void meson_mx_sdhc_hw_reset(struct mmc_host *mmc)
+static void meson_mx_sdhc_reset(struct meson_mx_sdhc_host *host)
 {
-	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
-
 	regmap_write(host->regmap, MESON_SDHC_SRST, MESON_SDHC_SRST_MAIN_CTRL |
 		     MESON_SDHC_SRST_RXFIFO | MESON_SDHC_SRST_TXFIFO |
 		     MESON_SDHC_SRST_DPHY_RX | MESON_SDHC_SRST_DPHY_TX |
@@ -116,7 +114,7 @@ static void meson_mx_sdhc_wait_cmd_ready(struct mmc_host *mmc)
 		dev_warn(mmc_dev(mmc),
 			 "Failed to poll for CMD_BUSY while processing CMD%d\n",
 			 host->cmd->opcode);
-		meson_mx_sdhc_hw_reset(mmc);
+		meson_mx_sdhc_reset(host);
 	}
 
 	ret = regmap_read_poll_timeout(host->regmap, MESON_SDHC_ESTA, esta,
@@ -127,7 +125,7 @@ static void meson_mx_sdhc_wait_cmd_ready(struct mmc_host *mmc)
 		dev_warn(mmc_dev(mmc),
 			 "Failed to poll for ESTA[13:11] while processing CMD%d\n",
 			 host->cmd->opcode);
-		meson_mx_sdhc_hw_reset(mmc);
+		meson_mx_sdhc_reset(host);
 	}
 }
 
@@ -495,7 +493,6 @@ static int meson_mx_sdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 
 static const struct mmc_host_ops meson_mx_sdhc_ops = {
-	.card_hw_reset			= meson_mx_sdhc_hw_reset,
 	.request			= meson_mx_sdhc_request,
 	.set_ios			= meson_mx_sdhc_set_ios,
 	.card_busy			= meson_mx_sdhc_card_busy,
@@ -618,7 +615,7 @@ static irqreturn_t meson_mx_sdhc_irq_thread(int irq, void *irq_data)
 	}
 
 	if (cmd->error == -EIO || cmd->error == -ETIMEDOUT)
-		meson_mx_sdhc_hw_reset(host->mmc);
+		meson_mx_sdhc_reset(host);
 	else if (cmd->data)
 		/*
 		 * Clear the FIFOs after completing data transfers to prevent
@@ -728,7 +725,7 @@ static void meson_mx_sdhc_init_hw(struct mmc_host *mmc)
 {
 	struct meson_mx_sdhc_host *host = mmc_priv(mmc);
 
-	meson_mx_sdhc_hw_reset(mmc);
+	meson_mx_sdhc_reset(host);
 
 	regmap_write(host->regmap, MESON_SDHC_CTRL,
 		     FIELD_PREP(MESON_SDHC_CTRL_RX_PERIOD, 0xf) |
-- 
2.43.2


