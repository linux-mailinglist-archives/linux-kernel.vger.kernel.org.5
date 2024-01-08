Return-Path: <linux-kernel+bounces-19176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFF826951
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA42812CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AFA9473;
	Mon,  8 Jan 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FndB4o7Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7BB661
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d4df66529bso2674505ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704701920; x=1705306720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNB8eseBc6is+G1DowRroY47UdkWdAr6xj971vFYoJE=;
        b=FndB4o7ZuxG/C0uqLE3o6CFfYSHJd3myJpCrSCU1PxzFB0CLR7UauvbOsjZ1fKusEw
         4lbZXn5nGRjNT5x0/P2sOfOlERYYg7yik6PHV+3W51QUS4nUNOUiX5LiH8rud1noDK61
         I4iZZHhcW5UkB7wONwtHUwF+5HJ6hfWTFyMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704701920; x=1705306720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNB8eseBc6is+G1DowRroY47UdkWdAr6xj971vFYoJE=;
        b=WFuwKsTqDenafzvI19Za+iPR4tg3wncUZWCYWyyHAfHmt3mnCu8U+zvbA+yyL/VMdb
         UCNnzJUv/+ZsRRl9AA3fVjNdc24ubwRHmekO3F7vqS/Y3DAq0Af8NCy/CuD5+46r0FK1
         SVOVmVwP/68UqDJKZ+9XwYUyZoq/Qv8DVYyzfP4XwCwIDu3Yp3wV3lTWPhohYoWeNzoV
         xT6byQsquqIqT/ANTgCKcwYP0rYhcGfZg+nTruZjJNBqFrLOZqqTImz03OS7r7Ap61vo
         7dGLNoQnHKO9QNn2xO2EiZfoqnV6Lw1U+tvkfK2gtpkjNw6ywi4qbCU+9XdVU2KDnXwu
         KGdA==
X-Gm-Message-State: AOJu0YwejYiNkb9RvElB8CfsjV8rc30WxyebBTmsod2dlIv6KunFKMYr
	cbecwHUl0T263W5ri18ITOWxUvesVE22
X-Google-Smtp-Source: AGHT+IE0thN83ywdJrPNf/EGvsxE+uqGedDoJv4f+6m5lRBkmlTLbuqE5qHl18jLTcqMCayCTdhYxQ==
X-Received: by 2002:a17:902:8a88:b0:1d4:be64:263f with SMTP id p8-20020a1709028a8800b001d4be64263fmr1076115plo.120.1704701920600;
        Mon, 08 Jan 2024 00:18:40 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:6859:f8da:3370:7a74])
        by smtp.gmail.com with ESMTPSA id jj4-20020a170903048400b001d078445059sm5672513plb.143.2024.01.08.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:18:40 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
Date: Mon,  8 Jan 2024 16:18:15 +0800
Message-ID: <20240108081834.408403-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
this clock controller needs runtime PM for its operations.
Also do a runtime PM get on the clock controller during the
probing stage to workaround a possible deadlock.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v3:
- Update the commit message and the comments before runtime PM call

Changes in v2:
- Fix the order of error handling
- Update the commit message and add a comment before the runtime PM call

 drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 2e55368dc4d8..ba1d1c495bc2 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
@@ -494,6 +495,18 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
 	}
 
+
+	if (mcd->need_runtime_pm) {
+		devm_pm_runtime_enable(&pdev->dev);
+		/*
+		 * Do a pm_runtime_resume_and_get() to workaround a possible
+		 * deadlock between clk_register() and the genpd framework.
+		 */
+		r = pm_runtime_resume_and_get(&pdev->dev);
+		if (r)
+			return r;
+	}
+
 	/* Calculate how many clk_hw_onecell_data entries to allocate */
 	num_clks = mcd->num_clks + mcd->num_composite_clks;
 	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
@@ -574,6 +587,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			goto unregister_clks;
 	}
 
+	if (mcd->need_runtime_pm)
+		pm_runtime_put(&pdev->dev);
+
 	return r;
 
 unregister_clks:
@@ -604,6 +620,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 free_base:
 	if (mcd->shared_io && base)
 		iounmap(base);
+
+	if (mcd->need_runtime_pm)
+		pm_runtime_put(&pdev->dev);
 	return r;
 }
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 22096501a60a..c17fe1c2d732 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -237,6 +237,8 @@ struct mtk_clk_desc {
 
 	int (*clk_notifier_func)(struct device *dev, struct clk *clk);
 	unsigned int mfg_clk_idx;
+
+	bool need_runtime_pm;
 };
 
 int mtk_clk_pdev_probe(struct platform_device *pdev);
-- 
2.43.0.472.g3155946c3a-goog


