Return-Path: <linux-kernel+bounces-155883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A58958AF879
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5FBB290BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046091474B5;
	Tue, 23 Apr 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svpKY1/D"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E184146003
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905434; cv=none; b=JkHd9umwFGUshdnQQZcK5wBOt6JIZU5aemTdFS2QxJ90kWf81AyjMuf2OAHzkwA5P2fDSglW3Qq2rCQ7DMAQazC5MhGYYLw2umqgjon6c13azltWpxlkyRd5+D8VUkqSxf8hCrn2dKxGgUf5OCSPBUTv1CiXkNvbAkM2gg55Eyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905434; c=relaxed/simple;
	bh=R7zQTIZdvG02VCBq8bLB7RM5nOeAXTmdLzXWGj0scFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZi3wLpCcBuzBozciqinJwrbsocXPhWXuBHnx64fcFkxGxTTh2zA4b4EhQl5dzcKSDtrvYUEVPedqt+ak8BGoqA/KYbeqR+335a3Ohv4LyagL3D0bDAfrnBg17HIHPZqZws8TObzxqPOIEvf6fvvk5mE7Gv+Is/k+OlQZ5dN1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=svpKY1/D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso20031675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905430; x=1714510230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCHTamsKWOa2PSWA2iiAOyEQMuVi7F/H9xo5LBfeSLo=;
        b=svpKY1/Dnn1YhNX5lAj/YA6It9ibkNInyrymKQxHdaqa1Hod7gojvXOfON69h9Tqfd
         RXF/SRySnQgxxXTdP8D4eWPHBEfierfvw7rbCJcQpF/EtVQEd4Go3K2rElhfxJ2qeKcE
         I9TBv5hmZKvkscgBSjG9o1uB8c5cDxeYtVPuqfZS6SkLv9A2AIAoAUeS0LfM0DulHjrb
         rbKJ89gFPp/dsiQgW31+nKpYQRqMKcU9Xrr+H7c15HjRkvcZ/7+jt0at+UJ9VdLppBvF
         /I5k+jnl/PqDGgQeSxSCUYsaAvkJ1mCuoCbkKAhCTmspGBHAn7D0QPNrtmuMXsu0av5E
         90iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905430; x=1714510230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCHTamsKWOa2PSWA2iiAOyEQMuVi7F/H9xo5LBfeSLo=;
        b=nYPDu7C3PP4SshH7+iHmjBiEzzRai2iED+LrpnM5fwixBGCOsdwnYQTW70gstXTKgC
         pFcJxKBxlypZhYnQvGkd08f1yA9Gw++7Z2rJ0wPZtSXY+hkc+zlKnCkGkHsmhIA9ZUNd
         f8znNx2m8WWg2YlQeF4qU6w911FPa1KYE5ltVHgpzHux2c6t7rB+e8qXw2UTQyfF43Zp
         7kfmuwR4zlNmZ/8Bl+x76QC0AHofUwyl26lSWm+WX1fqZcdZ5gUI6AqsPLb1LWQZwycP
         YbgNB12+1opTYMdPpQRKQcfmww+/utFHUPUS5l/h4n2X/y1IwzPcw8ljJgc/B4TPstqZ
         DySA==
X-Forwarded-Encrypted: i=1; AJvYcCW895CifDq1zzGOsNrUNF3kf6QLT5Z6yLrv+3FJSHaYxQv6HVczeMyyN9unYGGXd5qSDKkIJyg/feghAj9W2eUe5VSfVxb4ezqb3q4O
X-Gm-Message-State: AOJu0Ywc2J/6qENLywT4066awJDfhvThkDvhRvLLRn4v7+xOSaLmcCLe
	MyMbSQH8M0MGf1PELPeCVPgN82AVLseuk1e5BeBCAWcnpVftbXUkVbukVDXtLb0=
X-Google-Smtp-Source: AGHT+IGaC6Vi359eexueF4iWi9nmGX5wxuCM1Fm/OruWavgWB268ofzG0ipJO8D32PKK0SvENR0WUA==
X-Received: by 2002:a05:600c:2991:b0:418:9d5a:f680 with SMTP id r17-20020a05600c299100b004189d5af680mr254261wmd.25.1713905429971;
        Tue, 23 Apr 2024 13:50:29 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:4269:2542:5a09:9ca1])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm13065443wmb.41.2024.04.23.13.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:50:29 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 09/14] scsi: ufs: host: ufs-exynos: add EXYNOS_UFS_OPT_TIMER_TICK_SELECT option
Date: Tue, 23 Apr 2024 21:50:01 +0100
Message-ID: <20240423205006.1785138-10-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240423205006.1785138-1-peter.griffin@linaro.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option is intended to be set for SoCs that have HCI_V2P1_CTRL
register and can select their tick source via IA_TICK_SEL bit.

Source clock selection for timer tick
0x0 = Bus clock (aclk)
0x1 = Function clock (mclk)

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Will McVicker <willmcvicker@google.com>
---
 drivers/ufs/host/ufs-exynos.c | 9 +++++++++
 drivers/ufs/host/ufs-exynos.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 66e52c3607e2..66093a905986 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -50,6 +50,8 @@
 #define HCI_ERR_EN_N_LAYER	0x80
 #define HCI_ERR_EN_T_LAYER	0x84
 #define HCI_ERR_EN_DME_LAYER	0x88
+#define HCI_V2P1_CTRL		0x8C
+#define IA_TICK_SEL		BIT(16)
 #define HCI_CLKSTOP_CTRL	0xB0
 #define REFCLKOUT_STOP		BIT(4)
 #define MPHY_APBCLK_STOP	BIT(3)
@@ -1005,6 +1007,13 @@ static void exynos_ufs_fit_aggr_timeout(struct exynos_ufs *ufs)
 {
 	u32 val;
 
+	/* Select function clock (mclk) for timer tick */
+	if (ufs->opts & EXYNOS_UFS_OPT_TIMER_TICK_SELECT) {
+		val = hci_readl(ufs, HCI_V2P1_CTRL);
+		val |= IA_TICK_SEL;
+		hci_writel(ufs, val, HCI_V2P1_CTRL);
+	}
+
 	val = exynos_ufs_calc_time_cntr(ufs, IATOVAL_NSEC / CNTR_DIV_VAL);
 	hci_writel(ufs, val & CNT_VAL_1US_MASK, HCI_1US_TO_CNT_VAL);
 }
diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index 0fc21b6bbfcd..acf07cc54684 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -222,6 +222,7 @@ struct exynos_ufs {
 #define EXYNOS_UFS_OPT_USE_SW_HIBERN8_TIMER	BIT(4)
 #define EXYNOS_UFS_OPT_SKIP_CONFIG_PHY_ATTR	BIT(5)
 #define EXYNOS_UFS_OPT_UFSPR_SECURE		BIT(6)
+#define EXYNOS_UFS_OPT_TIMER_TICK_SELECT	BIT(7)
 };
 
 #define for_each_ufs_rx_lane(ufs, i) \
-- 
2.44.0.769.g3c40516874-goog


