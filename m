Return-Path: <linux-kernel+bounces-100190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79158879359
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FD41C22224
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0079DCA;
	Tue, 12 Mar 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M2W8Q4vl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229979B9D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244378; cv=none; b=r/YU3cX3BiWP3WFQGGGtbB3DWavhBnNCMSvPyadScOvaTvp7Ai73HncpwwvWC8xGa6t3MMiCNVVVgRUoQ0PrbGt8QHdl2WlwBjSmRFqKt+0qhfG58KtQLCcG2ipY6kvwI/D5vK6eljbE/rUoboYMi0943F6xPYTvUDI2JvYK/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244378; c=relaxed/simple;
	bh=mTUm9ym/RSqft+KABMxetZ2udu3o3Kzzw4feTXppzQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOeB2l9PIsCa+oUTq3pWBqgwzGqVMKAgjfEU4QSIOZH2QvtRZ5czwZQs7iZ5QhEPCKuaoM71KTVWAYfMtKZZceB3v39XpKff1sY3HebeWPCaCQzZoJ5SFJ0TQiqBK4oM+e8NB+MZ8c0iWDiR3oFCzScibkHAfBSL4a9+F7sxdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M2W8Q4vl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd611d5645so32398055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710244376; x=1710849176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32L7EdHAuQ4WnOqivRSfbIvHEBBAYz+hzKyLr7KyYy4=;
        b=M2W8Q4vlRPDFeM3hAAfZjbtUFJ1eHEkL7aEgnCmW0nH1voi1hbKB7nJ4aEWU6e+HeC
         CU28L/Hx5xO38hQiL4yYHz1ENTkO2A8cxV2t58IINQa5kudPEK0nm7d/8dRugaYiKvjq
         VXQ5rurA4PbrnLw8KxzSj0eGfQcDB4n7WtKDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710244376; x=1710849176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32L7EdHAuQ4WnOqivRSfbIvHEBBAYz+hzKyLr7KyYy4=;
        b=tlmiZ1pB98Lr02NRh10dlLek2PGgo2Te8wKa3w2BYqePS/LJSHedkBCQ5maS86zepa
         s2qZwiYOsjmGbEPlVF5BvT8IGvg0zSjJI7KoxsIX4YNY88jBEpcBIG7fiFhDmEKEBFX4
         oNX7scAZIpBCFl5kKnTY+/wTZ1qV6CVNPYCFyEm+IBo+EhzpTyZpRa+hryENDmVMD27M
         RqeO5rfmOljd+ARSJ0sYmAQkmiCctZ+CTZ6L0PDcHUBOB4pvBidwPB+4mx8JOPwiqOfx
         D/WZ1IVuo8O0bDQ92csgb7xcsz9QXfDTLZDwkOsMOb3djiSlUzmjLCwcmLXkOEPjr+/e
         zfag==
X-Forwarded-Encrypted: i=1; AJvYcCUocZebdaoy1oOKLHgvWGWZOd/14VCRqEosXLIUDOm+3z9MPc8CKj0aPhm1BbkiAtVZ34cFTbaRWh5sMq2BkygQscF2L4prCeyibCI9
X-Gm-Message-State: AOJu0Yx5wsJ0ZoAe0UHctscqGBPl7D4WxdTW1weQvDsuzTJoj1Sb4j98
	PpSoFBe2d12i1BTLvWZ+8r/cutAL3Z2/E75hlv0K4B+GGS1tkuQ+vRB2YX7wSw==
X-Google-Smtp-Source: AGHT+IFHW7gNc8FGsMt9K1fDNHiUJ5TT/QPfRrLz4t4aGJMOagv8xqOkZuJYIn0TiohOgI7RjlfCgg==
X-Received: by 2002:a17:902:d2d2:b0:1dd:c227:4175 with SMTP id n18-20020a170902d2d200b001ddc2274175mr813268plc.8.1710244375852;
        Tue, 12 Mar 2024 04:52:55 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:bae3:7b5f:7434:812e])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001dd1bdee6d9sm6500179plh.31.2024.03.12.04.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 04:52:55 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Bosi Zhang <u201911157@hust.edu.cn>,
	Nicolas Boichat <drinkcat@chromium.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4] clk: mediatek: Do a runtime PM get on controllers during probe
Date: Tue, 12 Mar 2024 19:51:55 +0800
Message-ID: <20240312115249.3341654-1-treapking@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt8183-mfgcfg has a mutual dependency with genpd during the probing
stage, which leads to a deadlock in the following call stack:

CPU0:  genpd_lock --> clk_prepare_lock
genpd_power_off_work_fn()
 genpd_lock()
 generic_pm_domain::power_off()
    clk_unprepare()
      clk_prepare_lock()

CPU1: clk_prepare_lock --> genpd_lock
clk_register()
  __clk_core_init()
    clk_prepare_lock()
    clk_pm_runtime_get()
      genpd_lock()

Do a runtime PM get at the probe function to make sure clk_register()
won't acquire the genpd lock. Instead of only modifying mt8183-mfgcfg,
do this on all mediatek clock controller probings because we don't
believe this would cause any regression.

Verified on MT8183 and MT8192 Chromebooks.

Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---
v3: https://lore.kernel.org/all/20240108081834.408403-1-treapking@chromium.org/

Changes in v4:
- Remove the need_runtime_pm flag and apply this to all mtk controllers

Changes in v3:
- Update the commit message and the comments before runtime PM call

Changes in v2:
- Fix the order of error handling
- Update the commit message and add a comment before the runtime PM call

 drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 2e55368dc4d8..bd37ab4d1a9b 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
@@ -494,6 +495,16 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
 	}
 
+
+	devm_pm_runtime_enable(&pdev->dev);
+	/*
+	 * Do a pm_runtime_resume_and_get() to workaround a possible
+	 * deadlock between clk_register() and the genpd framework.
+	 */
+	r = pm_runtime_resume_and_get(&pdev->dev);
+	if (r)
+		return r;
+
 	/* Calculate how many clk_hw_onecell_data entries to allocate */
 	num_clks = mcd->num_clks + mcd->num_composite_clks;
 	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
@@ -574,6 +585,8 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 			goto unregister_clks;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
 	return r;
 
 unregister_clks:
@@ -604,6 +617,8 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
 free_base:
 	if (mcd->shared_io && base)
 		iounmap(base);
+
+	pm_runtime_put(&pdev->dev);
 	return r;
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog


