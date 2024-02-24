Return-Path: <linux-kernel+bounces-79605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352098624AA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ACC1C219C7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02F3D549;
	Sat, 24 Feb 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qVdG11WZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFD31A60
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708775147; cv=none; b=MTgBfSJsoDSX3e7qAvyedAP9geAdw8J1qPBmzO5+OPdK7KeoAWXKJTXEtNlo19hGbvChS4j+8iEODJozwKEZlYTIzYNBLwqUwwLq/5g/WnCVGHbBTbSab1r2iebIOQpRN0JWOWuqRLr3a3shclYNAAGY+kCQ6W4Z+XJpkiiN0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708775147; c=relaxed/simple;
	bh=6wfl0TuMkpxBuqdM0cE3yXIiTFs3ob8LWNxFXfhudpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiQwD/Sg3+yU0iXUrJ7cBxeYgm63zV1sadN0v8NWJlomTI2DMDGhnamAcIswDxu+Vmjjub8xiZ4obqUMWBgAMk7mdxckVgWeEj37JGJST25aR/FG776pSv3CZQGSjIXQej8hJ3zO+ie3fFD4hiujXuCVl5CStwOaz60MzYES6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qVdG11WZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565a2c4cc1aso552654a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708775143; x=1709379943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5kcNjCxGNrVdzgJ/HQjMCheDz6E3QdP/jU7AXEAj0s=;
        b=qVdG11WZ2lxk3vTfdeZJewjLZ9HdNsnoTxtHgJd8DmAeQl2ihPe2A7aSebaBCjzAHe
         3CuIPrxkFwrLtzRw3GoBaSULan6Yve3ELOSpKQQiTRr81bRDB6Y/7NYLYEZPkRgaIXUL
         uWwZwssfG2DIgRi1DdYkQ6RsCHTq+GFEVoLQCoaFInYCJJIh0/vJZzwrj+lATK1P7TYm
         Ba9q1lP7ew0BSZYMaZk7HFJyDi9nP6G5wRnT/D5ph++GGpFSS0V+wyMLj6gQc4RVKUiR
         XVF0cq+ZeFZD7yemmbQ05DL21MwWzSWvYdCUQluAaIWEP51/SkV5z9eItXcre6JxzXwn
         sE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708775143; x=1709379943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5kcNjCxGNrVdzgJ/HQjMCheDz6E3QdP/jU7AXEAj0s=;
        b=c2Sn1xlwVyMb6083K+UnuWxevQxms9+NBvU/RApS2+lhV5zBgqQE/0WFlBPOdJMtch
         T2a8f1kHTfv1VUh1PLALwwMu0HmffMB5uEpXl6QduOvT57D7dc9Km2Oa3CKpH4h5MGJc
         joi3YTMZQwWzxyYpfesgzlXpu/OuXzz9lBkdASG6eZi/a8sDuuTemdc+FJuheiepjS5Q
         AcP0EGltsZ7UOqE0LPZE5SDnNkiuBh0C4Fwpuf4dpg8bW+z6SLyNmGO2fOQz0P10eu02
         hZ9TOTbcgbMfE/pP5nThkmvev6dgFWpdyORkVWyvDR3AcvgTS8C0KC3nH7xIi1JR87gx
         j3TQ==
X-Gm-Message-State: AOJu0Yy5bwGrz9OBFWm1AaVn8e+gP23eO/hKzTssDIrHnTLtDyq9vbZ2
	IdXhqfTqUqd5sUQXG6SRzcY5IEmc75uLPzZqtn6FyU6i3CIvrCjVYtPQYEOD0uI=
X-Google-Smtp-Source: AGHT+IHJ5+wAip/i94V+xG+D9km5AD0FQSfhFC/uh8jg5uNVl+41z5VQEOxYj9dDYLeAv3tcgz/76w==
X-Received: by 2002:a17:906:b349:b0:a3e:fce7:9393 with SMTP id cd9-20020a170906b34900b00a3efce79393mr1371848ejb.10.1708775143241;
        Sat, 24 Feb 2024 03:45:43 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a3e209b225asm517826ejb.43.2024.02.24.03.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:45:42 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	William-tw Lin <william-tw.lin@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/11] nvmem: mtk-efuse: Register MediaTek socinfo driver from efuse
Date: Sat, 24 Feb 2024 11:45:07 +0000
Message-Id: <20240224114516.86365-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
References: <20240224114516.86365-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=0uQx/zVOu7lJjRsFUrqs5vdvlqNChuBmzKOHBVqwmHw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dbLCPgH0z3n6Nwl7UGuUwlXLwwHF2jW7zaWR nJx1N7na/yJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWywAKCRB6of1ZxzRV Nz+iB/wLQma5Z4fdz3xVK6d3GaDGSS1AbIMORJFNFYcJFdiU3q63Ovqg8OiL9QtUtAvkcb2fpmE CaH1TPF5yTmT9PGGyiov/j2LXQtLAX3AayQbnNprpS1Hwgz5KbO5b3Urgzr+svsjYH03mK4SOo0 ck12eVJMGZkthzha5DoYU+Qt48/u3x4mQQfzaeWzUnYE9sbVtiBBqMB+swQdOvgaX+iZe/pZeUY VZmjH2GniXQqFOYtbzMwoIaiInSCyrlrdbCaOJOsf22GeMsEFy7XSh/zX72N4ra4IPdp8oGn8Wf EdUYtqdd1oTdcC5Ssa5iBdFAHyGVeEx+wGr+gY55Ocp0564w
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: William-tw Lin <william-tw.lin@mediatek.com>

The socinfo driver reads chip information from eFuses and does not need
any devicetree node. Register it from mtk-efuse.

While at it, also add the name for this driver's nvmem_config.

Signed-off-by: William-tw Lin <william-tw.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 84f05b40a411..f5bebcecf9bd 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -68,6 +68,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config econfig = {};
 	struct mtk_efuse_priv *priv;
 	const struct mtk_efuse_pdata *pdata;
+	struct platform_device *socinfo;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -85,11 +86,20 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
+	econfig.name = "mtk-efuse";
 	if (pdata->uses_post_processing)
 		econfig.fixup_dt_cell_info = &mtk_efuse_fixup_dt_cell_info;
 	nvmem = devm_nvmem_register(dev, &econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
 
-	return PTR_ERR_OR_ZERO(nvmem);
+	socinfo = platform_device_register_data(&pdev->dev, "mtk-socinfo",
+						PLATFORM_DEVID_AUTO, NULL, 0);
+	if (IS_ERR(socinfo))
+		dev_info(dev, "MediaTek SoC Information will be unavailable\n");
+
+	platform_set_drvdata(pdev, socinfo);
+	return 0;
 }
 
 static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
@@ -108,8 +118,17 @@ static const struct of_device_id mtk_efuse_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
 
+static void mtk_efuse_remove(struct platform_device *pdev)
+{
+	struct platform_device *socinfo = platform_get_drvdata(pdev);
+
+	if (!IS_ERR_OR_NULL(socinfo))
+		platform_device_unregister(socinfo);
+}
+
 static struct platform_driver mtk_efuse_driver = {
 	.probe = mtk_efuse_probe,
+	.remove_new = mtk_efuse_remove,
 	.driver = {
 		.name = "mediatek,efuse",
 		.of_match_table = mtk_efuse_of_match,
-- 
2.25.1


