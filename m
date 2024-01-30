Return-Path: <linux-kernel+bounces-44333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2941842061
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317691C26B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6F66B3E;
	Tue, 30 Jan 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j0zXpjZv"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D168664CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608624; cv=none; b=cDBJMjTqbk4WQ62kyWnB4/Pm9FAdBf3Z2/HHjqntJvTBWUVk+TtcRmeJw8LXjzNFlGbPVeLSD1Jpp9SwJhT6jQGdIwXOw94s+RuzpGa5ASiZ9tSnEbH/x3uyB+vTwsnk9R5edyfEzPHJHadM5C7GK+C2+cDx0lQ4GPuRqxL/o5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608624; c=relaxed/simple;
	bh=T0JtsjOKE5HCH9JwYSPgNeRdUS2v7ajLCNvW4doHSaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zyf0Gh60U8bwBCQjVxTekbnEisR1JFnTLI69qo8puR31iQXK4qKsPR/YwN2YoB2dAwVVMRS6pUPjPXw8n8goOKzZt4KXVyM3mcHYbsY6Rg/fd/kB/cenzcssTX8YcbGIa4G/+8X5MmSfoYyQ1lwf+WomiZEECaG6NP7QRyUs5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j0zXpjZv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1707752a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706608622; x=1707213422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMxRirpa263d6PmLZyC9XRaAp28SbobvUK5ST0uEzHo=;
        b=j0zXpjZvcSjmhpN2odRPSr8w1meoWgS4+CpHBaSbrN3VAbrKVVbVJwL9UAHrf4YEy6
         1VuxkQJj4umUnFFuVpsj8LUCDJjUXrUplTEV33XWvyaHDk05wX2SbxChUk3AN4qg2P7+
         QNnTtkrmBOunq0NET/2Ooj4ZOC348X21NZWh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608622; x=1707213422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMxRirpa263d6PmLZyC9XRaAp28SbobvUK5ST0uEzHo=;
        b=hF6rLGzaP4XFlIWuaLhQzszTAc9XGnlvSyqlIUFfzLldCiqR2gs0z0wG3Gfh5+61z4
         wGGus5hEsbXDSN5GEXOTnHl7hGZqfzat5wA4QnVvY1yeEzAtxGTCXQnP24Ww4lcQUzbg
         j/MIVpmq6Zqk4Eb/QtNgSuEQ2FPzF82Or1lHHpxrl9Y4y9WJhY7OmZAKqQ59d2QdIxgk
         auaWC+PZT7U/casE/BvDtnRNfF7cvHzJ0e9qwIGBsqCyRwkYq5oY3ZMVXpkAc7nIFd+L
         jVhGfx1cKVZDbE7c7rtOy3U5aRsxD0o8rV3lI36xHeKrebz54V4M115Dj+OlbSVIF8kU
         hNhQ==
X-Gm-Message-State: AOJu0YwvSKN83CifQGCXyYiFfgQZWeRvb6HtqJexLCRMT/2NJmJpxtZG
	nClpk975WbcCGHnhjKi4KQSlRwU6NZzDBh38HA3ZPCrF4Rn3kW0GjmVD1dL22w==
X-Google-Smtp-Source: AGHT+IHjRn3nfznyOhQX8l8ftcqqS1VpyZkxitaxKAKHRGb39QcMRCBeDFEsnLCSu5ZRIaRQd6A10w==
X-Received: by 2002:a05:6a20:3f95:b0:199:c8f1:58 with SMTP id ay21-20020a056a203f9500b00199c8f10058mr4049745pzb.41.1706608622688;
        Tue, 30 Jan 2024 01:57:02 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:469:110f:d748:6896])
        by smtp.gmail.com with ESMTPSA id sm5-20020a17090b2e4500b0028ffea988a2sm8069810pjb.37.2024.01.30.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:57:02 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	William-tw Lin <william-tw.lin@mediatek.com>
Subject: [PATCH 1/3] soc: mediatek: mtk-socinfo: Clean up NVMEM cell read
Date: Tue, 30 Jan 2024 17:56:51 +0800
Message-ID: <20240130095656.3712469-2-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130095656.3712469-1-wenst@chromium.org>
References: <20240130095656.3712469-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mtk-socinfo grabs the NVMEM device devm_nvmem_device_get(), but then
proceeds to put the device directly with nvmem_device_put() if the read
is successful. If the device fails to probe and goes through the devres
release path, the device would be put a second time, triggering a
use-after-free error from KASAN.

Fix this by dropping the devres part. Since the NVMEM cell data is read
only once, there is no need to keep the reference around.

While at it, clean up the function to directly reference the NVMEM
device node and use that to find the NVMEM device, instead of finding it
by name, which is more fragile. The cell node is always a direct child
of the NVMEM device node, courtesy of the legacy NVMEM cell layout. Thus
of_get_child_by_name() is a better way of finding the cell. Last,
correctly put the device node once its use is over.

Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getting chip information")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/soc/mediatek/mtk-socinfo.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mtk-socinfo.c
index 0094f43e1e08..3909d22062ce 100644
--- a/drivers/soc/mediatek/mtk-socinfo.c
+++ b/drivers/soc/mediatek/mtk-socinfo.c
@@ -9,6 +9,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
@@ -82,25 +83,28 @@ static int mtk_socinfo_create_socinfo_node(struct mtk_socinfo *mtk_socinfop)
 static u32 mtk_socinfo_read_cell(struct device *dev, const char *name)
 {
 	struct nvmem_device *nvmemp;
-	struct device_node *np = dev->of_node;
+	struct device_node *np, *nvmem_node = dev->parent->of_node;
 	u32 offset;
 	u32 cell_val = CELL_NOT_USED;
 
-	nvmemp = devm_nvmem_device_get(dev, "mtk-efuse0");
+	/* should never fail since the nvmem driver registers this child */
+	nvmemp = nvmem_device_find(nvmem_node, device_match_of_node);
 	if (IS_ERR(nvmemp))
 		goto out;
 
-	np = of_find_node_by_name(NULL, name);
+	np = of_get_child_by_name(nvmem_node, name);
 	if (!np)
-		goto out;
+		goto put_device;
 
 	if (of_property_read_u32_index(np, "reg", 0, &offset))
-		goto out;
+		goto put_node;
 
 	nvmem_device_read(nvmemp, offset, sizeof(cell_val), &cell_val);
 
+put_node:
+	of_node_put(np);
+put_device:
 	nvmem_device_put(nvmemp);
-
 out:
 	return cell_val;
 }
-- 
2.43.0.429.g432eaa2c6b-goog


