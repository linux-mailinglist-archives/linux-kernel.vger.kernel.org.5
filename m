Return-Path: <linux-kernel+bounces-116594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC55889EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744AD2A509F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB8156C76;
	Mon, 25 Mar 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYuvxDRJ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDE15F32E;
	Mon, 25 Mar 2024 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348888; cv=none; b=KBpK2zAMAuqvcaQREXRCCl69dBV2giHEvdhF0sU/thtHjbZg/wisBvjCYb55N5M1iUvEj8H1juiatoH4OYZJAUk++RVIKN5HHW7tnzyrE6KuRNj3TMmVYJUxyozseNt4oz3NzlvFDo77Y/JDMEPbO+94OJ/0z94npKTbh/CAJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348888; c=relaxed/simple;
	bh=CNyZv7F7MM6DJREsMjJWxzU9kMvkiJmWI7Qjwel8lhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc6WPZbao5E29GOxAu4rJ0Jwr8bGF5zl1onCZ+k/qlRNUo5f6/3JjCuLLCPcf+3b/qVj0A7/uBZnoHr/Mvt8XwF02A59ZA/G6T8lrF9kXVwURfrzCqMUztlO/BHMM8jLA0Oap9ytq+pbfeDQ1bK5P5y7sn2Z5PgSNMgC2p2Xtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYuvxDRJ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512e4f4e463so4185781e87.1;
        Sun, 24 Mar 2024 23:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711348883; x=1711953683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oushmNgLEoSiFSU+fvxV91NyvXwpQw1n1UeXr157a84=;
        b=SYuvxDRJG2GMwDVgtxkq2u17Tl5oVvcbnHSoV1Ako0bw1uQr2Hn8qAqisAhZ6etkWw
         FQBAmcGYGc7ryHqWRqq2kcYzDWut95X8LrpIOcvT9o5G8HR9oTTamgAqgD7tXV62+Ipa
         HKRVTd0NAf1QOPy8KfjX+zSl3pDPeik1SPNftLaCYuH368sdwhlHGM7eq4XET4lGpQ2f
         Hf/J++FMeO+VyFXfT5NNfEmccPE4l6a3UzfCJAlmO2AekeTTnEzqLvey537sm9IdH7zX
         Rg4KMp8ZCqFYrcsVApm9MlWQFVrEl6sjTERPPc1SXbrXvQq/YXO/F8I9XN17zQbSYSS/
         OY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348883; x=1711953683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oushmNgLEoSiFSU+fvxV91NyvXwpQw1n1UeXr157a84=;
        b=SmCgiqhIGOplPos9rgtI9qX5DMLepZVupdVY0uiRduLDir442/tK3P+NDfOILkunb6
         p9GGTSrxZkHY/h2I7LYoJURhFMsppPFmAc8IeKVf1maLbsR4DIqzIOtZESo8VP34z6NN
         n5bmJvnsVZd4s+NlUI62zADMgzq8V7psc3HlDg9njt7FRq5PL06nirSHFV5UIYAn3zuG
         B2dgSollYDiv7Wk9fy4zhcgOXvvl01zd02jxUHRM1t7swzgtfH3Cu72Cc4xFSxqadCeF
         2vtXGLv8WHMcUL7dsd3QIvHtm1BivJoSMiE0S1tEEdMVe8MSjRe18ENu419gPLmkEkF8
         j+dw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3/+GJXygmCFPDnyEsnbgzOLmI036qgg3JAuR08OIz3Na3xy0ZDPNy6n4Vt7MBckPrbUa32J2aWuJmwxcrszNqIZe4jl+tgIqtDPcWvrRRH6METpRTvhwWcdz5xkQ6R7LQ0q4LdB+wT4=
X-Gm-Message-State: AOJu0YysYhmeSVvkezHUXdivyCSd5L8GEKzZXes4gE7qQzQrEpk3WVBf
	QluGhoqs4TzQ6sSxyGveVinDthTGEWQdp+cWa8suS9oJ4Zqvh8li
X-Google-Smtp-Source: AGHT+IEHz8wglR5bVMyA+cP5TCwFZTUL3ntj2kxAM1vtL9dUsR1o9AoXt44qB7zzSAqCBI64BzoyOw==
X-Received: by 2002:a19:ca05:0:b0:513:ed0f:36c9 with SMTP id a5-20020a19ca05000000b00513ed0f36c9mr3620740lfg.45.1711348882734;
        Sun, 24 Mar 2024 23:41:22 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a0565123c8c00b00515a411fd20sm828229lfv.105.2024.03.24.23.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 23:41:22 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] media: chips-media: wave5: support reset lines
Date: Mon, 25 Mar 2024 09:40:57 +0300
Message-ID: <20240325064102.9278-3-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325064102.9278-1-brnkv.i1@gmail.com>
References: <20240325064102.9278-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for optional reset lines. For now, simply deassert
resets on driver probe and assert them back on driver remove.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu.c | 16 +++++++++++++++-
 .../platform/chips-media/wave5/wave5-vpuapi.h    |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 1b3df5b04249..1e631da58e15 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
+#include <linux/reset.h>
 #include "wave5-vpu.h"
 #include "wave5-regdefine.h"
 #include "wave5-vpuconfig.h"
@@ -151,6 +152,16 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, dev);
 	dev->dev = &pdev->dev;
 
+	dev->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(dev->resets)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(dev->resets),
+				     "Failed to get reset control\n");
+	}
+
+	ret = reset_control_deassert(dev->resets);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to deassert resets\n");
+
 	ret = devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
 
 	/* continue without clock, assume externally managed */
@@ -163,7 +174,7 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
 	if (ret) {
 		dev_err(&pdev->dev, "Enabling clocks, fail: %d\n", ret);
-		return ret;
+		goto err_reset_assert;
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "sram-size",
@@ -246,6 +257,8 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 	wave5_vdi_release(&pdev->dev);
 err_clk_dis:
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
+err_reset_assert:
+	reset_control_assert(dev->resets);
 
 	return ret;
 }
@@ -256,6 +269,7 @@ static void wave5_vpu_remove(struct platform_device *pdev)
 
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
+	reset_control_assert(dev->resets);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 	wave5_vpu_enc_unregister_device(dev);
 	wave5_vpu_dec_unregister_device(dev);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 465ff9dfe8b1..da530fd98964 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -758,6 +758,7 @@ struct vpu_device {
 	struct ida inst_ida;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	struct reset_control *resets;
 };
 
 struct vpu_instance;
-- 
2.44.0


