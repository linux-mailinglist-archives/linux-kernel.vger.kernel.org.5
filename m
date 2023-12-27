Return-Path: <linux-kernel+bounces-11921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A981ED95
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6866A280E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E91A29D;
	Wed, 27 Dec 2023 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfAID2nW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE511CA0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb968c02baso2090557b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703667902; x=1704272702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh+MDHeylaYTMq4wSIWSzHh+ySX+XFDhtKTfmG0mb0s=;
        b=KfAID2nWp+FAo6dxzCwLnz/w2gW8KRKjCIr5eMjma6da9w9VCc/laWdEbB7FuwAuI2
         2SgsjHjgc05nLLFraxCutTIFz/CC7kQ3Qt8enL2t575/hUF3E/h7AV2khjoBn2LNQ47m
         S/qjbG/+sHDZs5K5FTbHlGuI0oiWI7qoGN6Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667902; x=1704272702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh+MDHeylaYTMq4wSIWSzHh+ySX+XFDhtKTfmG0mb0s=;
        b=ArC4S6UTZVVPRx1SCpM6uiHHgITiav/L4Ty2JRI4hVVcs1wMXkkhQz7NNmFSqsoKHl
         /BIDSzLzOaRAsjFw2jHyMik1goZVishHcGysKuQ9n+No1EKUbj8S41kPj/NR7EAqlVnj
         vkb8VJoEdrcW3FdMWOL+Mb+XFthLGneKnGZibJQPb+RT3MHAzxDrSNhnaMrHArkq79tS
         t4qlPL+ext5s4MMsqx2hJYXAWLsUT9EBzi82S6MQEggVkA2qEGFFvWsH5YQvPpBt5PVG
         bQADL9iXExwoWJmqtn/ttrstIKi7L1GAx1Jc3AtmjmwlMq1omOxHS4b7V5YVo1JZTJW4
         XXeQ==
X-Gm-Message-State: AOJu0YxjPbHHHmTCO4lDB92uK8A+NxvvrnbDO3zbeUCngH/0I5I8zMrN
	Wd2NOgVGAc4JcY+8LO5bvdDYPFqYZDzc
X-Google-Smtp-Source: AGHT+IEvFbvN8XZ+7Xuic2F6Oo0sX73+MllnmuNUGzdCdDkF8mQnilbwHK5GFTMLGOBSORX4KEJC3w==
X-Received: by 2002:a05:6358:4309:b0:173:24:b26b with SMTP id r9-20020a056358430900b001730024b26bmr4007487rwc.25.1703667902493;
        Wed, 27 Dec 2023 01:05:02 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:18d2:7869:e8b9:f4e4])
        by smtp.gmail.com with ESMTPSA id v22-20020a056a00149600b006d9b65d1a8esm5347701pfu.28.2023.12.27.01.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:05:02 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pin-yen Lin <treapking@chromium.org>,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
Date: Wed, 27 Dec 2023 17:04:42 +0800
Message-ID: <20231227090448.2216295-1-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate this
clock needs a runtime PM get during the probing stage.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

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


