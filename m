Return-Path: <linux-kernel+bounces-69416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320E8588BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A397B29A90
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C214A4FF;
	Fri, 16 Feb 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtWjq/nI"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA01487FA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122778; cv=none; b=RhwqbD0BsJrQ7hXklM/G3aCsC3csVRUZidDTzuz2udGNEoD9b01d/LTmUYX8XZ6owMtWnBg32lkwDjh/Ajnpq9IFN75fUARzaJ9gM0XSuhqUDq/RYZcMiCPvcCI38bZQ51D/SWSLHNOiD7eJP+SFDmdffJv1Qut0p6FKDwAedhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122778; c=relaxed/simple;
	bh=eqZGJoOdifIJ/nx09+Uj4OtPl8hVswxwsmltU49Eusg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJ76IAsq4GojilXqubMLf9u0OIiy7t2YAWjrXLTpSmEPSwRgPjxEeiv5gpYEllgLTA+bl1iESQtlrdY7XV9XA9NInEyqLAGR3CVIrJbDww6P8i7LeP2N2AwpuqfhbqV1J+n75PH8kcV7Lk+aOHOMevWTXGkmuIMwgMYrMf6CUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtWjq/nI; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2e44aad03so1529946a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708122774; x=1708727574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSXQtp/xYos/De5K15KnT8HtuCXV3FX1KoFk0gl8ZIY=;
        b=vtWjq/nIy+z7OvNKFwUITs5Vsx4DROu581jb8UvPcrZTQgRr7+L89yiOX98aBaCZwF
         Yx9KhuBZt8iK3UYF3LhoWxlDc3YnnlUBwnv/QdNoiYNl03KmtsvehQvZJ4Oaiup/Ujez
         JqCnt5RDPKOqBgUpVT5sOl0TIFnYZwxEp+Ir11aAXtHfL2V6Y5FDDr8fxcKDaFwcFvHu
         bRqidlYnTZ1EdqqXv27f8pk3nWPk1Ak+Tc1huMTKMioimzqSpSdgNVGreCz883AbHluq
         95MG0nNPc87YI6KNywevXhlJBqTp73GBIS5njaYGXHs+ooOvp1C/wOcHqAUeKApc6md4
         U/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122774; x=1708727574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSXQtp/xYos/De5K15KnT8HtuCXV3FX1KoFk0gl8ZIY=;
        b=cpmD46Q1Thd49wqNHJ3GfnqHp6JSOXRlVM3G/7UGyG5mORMGtvaAlicmb87yka1J+i
         anekaSmseNsh9Wnb1amyXOIDjUODYDqB5/IAIQM1HvNxnO0rZCwZmXy7OiT8SEOaaXus
         VSPGw8SXmfCh1zqzRhgEG99ZdkkBLCV9+SDfecP/hO/CWgHNNCVf+W3aVPTBSjdHbcEj
         Hq0J+lJIYiUdYq3YkoFIjw7/dDCGihCq7HfZQWkT7WFvtC4aw7+uXdYHOCUGntNxGyqS
         0FNAJn9Vf4/v1N5A7cbTC9+txi9OeXlD1yVGkhNTopRoX5VuKkZgsePtZiJAwj6Fovn3
         CdvA==
X-Forwarded-Encrypted: i=1; AJvYcCUltiRxOEP15fT+ZD1OBG0zYMDZIcsgoSLXDTZG5bLsEYbGVbc6RrjNo+gv8HGIjIOh0Zdz30g3Z6MpzbV3kSnZWdusa9RxF1We8RBT
X-Gm-Message-State: AOJu0Yzkw2dHP1A6w+20Xrg9KQVsyF90xeyxqzzja5pO5zlgx/alRLcr
	5kFoq0bR3vcQgSJvJrouHfOIJVxygx1y1d2BBADJPimSzHMBABm4RKjLGtbu8eg=
X-Google-Smtp-Source: AGHT+IF80c+KUyEOcpIptb5o8+krEJ6RGLdrgifsX5usLDGRORjlnGWJbpx/niTC9m5iauYccvVvKQ==
X-Received: by 2002:a9d:6b83:0:b0:6e2:f9fa:9e5c with SMTP id b3-20020a9d6b83000000b006e2f9fa9e5cmr6533177otq.3.1708122774331;
        Fri, 16 Feb 2024 14:32:54 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id j2-20020a9d7682000000b006e2ea96949csm141544otl.29.2024.02.16.14.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 14:32:53 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] clk: samsung: Keep CPU clock chip specific data in a dedicated struct
Date: Fri, 16 Feb 2024 16:32:39 -0600
Message-Id: <20240216223245.12273-11-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216223245.12273-1-semen.protsenko@linaro.org>
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep chip specific data in the data structure, don't mix it with code.
It makes it easier to add more chip specific data further.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-cpu.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index 21998c89b96d..04394d2166c9 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -42,6 +42,16 @@ struct exynos_cpuclk;
 typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
 				       struct exynos_cpuclk *cpuclk);
 
+/**
+ * struct exynos_cpuclk_chip - Chip specific data for CPU clock
+ * @pre_rate_cb: callback to run before CPU clock rate change
+ * @post_rate_cb: callback to run after CPU clock rate change
+ */
+struct exynos_cpuclk_chip {
+	exynos_rate_change_fn_t	pre_rate_cb;
+	exynos_rate_change_fn_t	post_rate_cb;
+};
+
 /**
  * struct exynos_cpuclk - information about clock supplied to a CPU core
  * @hw:		handle between CCF and CPU clock
@@ -54,8 +64,7 @@ typedef int (*exynos_rate_change_fn_t)(struct clk_notifier_data *ndata,
  * @clk_nb:	clock notifier registered for changes in clock speed of the
  *		primary parent clock
  * @flags:	configuration flags for the CPU clock
- * @pre_rate_cb: callback to run before CPU clock rate change
- * @post_rate_cb: callback to run after CPU clock rate change
+ * @chip:	chip-specific data for the CPU clock
  *
  * This structure holds information required for programming the CPU clock for
  * various clock speeds.
@@ -69,9 +78,7 @@ struct exynos_cpuclk {
 	const unsigned long			num_cfgs;
 	struct notifier_block			clk_nb;
 	unsigned long				flags;
-
-	exynos_rate_change_fn_t			pre_rate_cb;
-	exynos_rate_change_fn_t			post_rate_cb;
+	const struct exynos_cpuclk_chip		*chip;
 };
 
 /* ---- Common code --------------------------------------------------------- */
@@ -419,13 +426,24 @@ static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
 	cpuclk = container_of(nb, struct exynos_cpuclk, clk_nb);
 
 	if (event == PRE_RATE_CHANGE)
-		err = cpuclk->pre_rate_cb(ndata, cpuclk);
+		err = cpuclk->chip->pre_rate_cb(ndata, cpuclk);
 	else if (event == POST_RATE_CHANGE)
-		err = cpuclk->post_rate_cb(ndata, cpuclk);
+		err = cpuclk->chip->post_rate_cb(ndata, cpuclk);
 
 	return notifier_from_errno(err);
 }
 
+static const struct exynos_cpuclk_chip exynos_clkcpu_chips[] = {
+	[CPUCLK_LAYOUT_E4210] = {
+		.pre_rate_cb	= exynos_cpuclk_pre_rate_change,
+		.post_rate_cb	= exynos_cpuclk_post_rate_change,
+	},
+	[CPUCLK_LAYOUT_E5433] = {
+		.pre_rate_cb	= exynos5433_cpuclk_pre_rate_change,
+		.post_rate_cb	= exynos5433_cpuclk_post_rate_change,
+	},
+};
+
 /* helper function to register a CPU clock */
 static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 				const struct samsung_cpu_clock *clk_data)
@@ -464,13 +482,7 @@ static int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
 	cpuclk->lock = &ctx->lock;
 	cpuclk->flags = clk_data->flags;
 	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
-	if (clk_data->reg_layout == CPUCLK_LAYOUT_E5433) {
-		cpuclk->pre_rate_cb = exynos5433_cpuclk_pre_rate_change;
-		cpuclk->post_rate_cb = exynos5433_cpuclk_post_rate_change;
-	} else {
-		cpuclk->pre_rate_cb = exynos_cpuclk_pre_rate_change;
-		cpuclk->post_rate_cb = exynos_cpuclk_post_rate_change;
-	}
+	cpuclk->chip = &exynos_clkcpu_chips[clk_data->reg_layout];
 
 	ret = clk_notifier_register(parent->clk, &cpuclk->clk_nb);
 	if (ret) {
-- 
2.39.2


