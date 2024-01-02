Return-Path: <linux-kernel+bounces-14133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8B821838
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED9828256F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3473469F;
	Tue,  2 Jan 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UWfqcvH2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4462441F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28c7c422ad9so4097925a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 00:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704183252; x=1704788052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewhpw6ZAnNzCIn1VG/yRZaJv/xa5pFyIuSfBXvMExEo=;
        b=UWfqcvH2rXPgDdlsxakoo+g8+UPCMBhJqtK4bcTHu/HiM7wpnyy5dvgaaehQYQyRVB
         jKWcv4Nz5O3yn+YrsxXBKe3g5GC5IrfWbyBwluJClCxHa6F1iEvm+klSG0zBCtBRFX4a
         9xrBUESVc3ukYP1afY1/LuEcdfpc7QRKU90Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704183252; x=1704788052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ewhpw6ZAnNzCIn1VG/yRZaJv/xa5pFyIuSfBXvMExEo=;
        b=EcGFwEl/Ah0KICPiWHIyyp82gPfeSC/bU7GZcVksubqB2pCD3SKtFuFREReMm7ph1+
         EOYENfdLjoRfWhxHZSfZctQmxnUnJyNMED+pe10miD4duOpYIFG5oYJJbygJ0Z8xXrJC
         C9MOHKUGnrBbYvMYbG6FVDurotacky3bMy+gP3hgFfQAQMdPld6/LQYDuQmauoXVmM7J
         dExNyor7+x2lwk6krzCkGy+CwcCUYOi8k0+X4sr1qEeYiuTXVvz1eV6yzoYYNUTYzQCS
         85/qBA6t0VuGTKiSeD5jupe3Pd9nhuNI79y4bzzf7l7vBE3hG5TzRCrTILjE0i7o6wgB
         nNRw==
X-Gm-Message-State: AOJu0Ywtwcr/7wAVagQ2tFgOhhBpbxSgmEMWabd5G7PYwRYP5AvaEAuy
	4uLbhrQOnfJ4xnBYyf5ht+wa7Fs1bk31
X-Google-Smtp-Source: AGHT+IEZy7xdt3Zuu7m2G7MMoLHQEboW6KOxEkZD0l5bHyMFOempt/8HuzkEt7JOM2A6v2c4UhVBmQ==
X-Received: by 2002:a17:90a:7023:b0:28b:96ba:806a with SMTP id f32-20020a17090a702300b0028b96ba806amr7610238pjk.88.1704183252177;
        Tue, 02 Jan 2024 00:14:12 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:232c:f04:85bb:a34c])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a638300b0028c8149ac6esm12640074pjj.42.2024.01.02.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 00:14:11 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
Date: Tue,  2 Jan 2024 16:12:52 +0800
Message-ID: <20240102081402.1226795-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
this clock needs a runtime PM get on the clock controller during the
probing stage.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v2:
- Fix the order of error handling
- Update the commit message and add a comment before the runtime PM call

 drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 2e55368dc4d8..c31e535909c8 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
@@ -494,6 +495,14 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
 	}
 
+
+	if (mcd->need_runtime_pm) {
+		devm_pm_runtime_enable(&pdev->dev);
+		r = pm_runtime_resume_and_get(&pdev->dev);
+		if (r)
+			return r;
+	}
+
 	/* Calculate how many clk_hw_onecell_data entries to allocate */
 	num_clks = mcd->num_clks + mcd->num_composite_clks;
 	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
@@ -574,6 +583,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			goto unregister_clks;
 	}
 
+	if (mcd->need_runtime_pm)
+		pm_runtime_put(&pdev->dev);
+
 	return r;
 
 unregister_clks:
@@ -604,6 +616,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
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


