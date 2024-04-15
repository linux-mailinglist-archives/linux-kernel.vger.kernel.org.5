Return-Path: <linux-kernel+bounces-144434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D98A4661
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5261C2125C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130546BF;
	Mon, 15 Apr 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/9ybJAU"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D71859;
	Mon, 15 Apr 2024 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141624; cv=none; b=b+PQgRIuN9EQrrt7Q08/ybkfMu7ujHkflIaKAxgCV4gT0Mb7C/Ae9aUKC7cub6oln0408L5vYhub+XtkPxz7GrHk3b7xyJ42bPG+tk4JzUjbQjRG30f9JRfM83+mb4cBUKoZjpIfRmrTWz4g44mN6nAsjDwa5ttt0TaO357n/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141624; c=relaxed/simple;
	bh=iQlzzmlkkcsjXqkdwfgCF4ZCJUO8YG5RXp5OS6ION1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVzcH0KKnfZHQ7U0/EsqCoN5ZEw4aliZG0LbwzVvEpt6KIaSTUbGDzupodc0TnUZD2hAmYjkqDSuc41SvTOsrjSr2PGSa27lODUNOfwyfELfsk7a3wX8ReC52jSlMLATQp5ZFog+kthV4uD7lvDT7mq5gXcTH89ghv9vidU6nEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/9ybJAU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a2ab5a05dso12443915ab.2;
        Sun, 14 Apr 2024 17:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713141621; x=1713746421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJzHJYqm9cEleo6og2FxZikBNx9MbCNpwTRyUR9B8k0=;
        b=f/9ybJAUiojSbtQzGKGmN5Sixmm8/fE/JwDQ4ddgNVwHVIFGiDAvZqy48nKRUUJbjL
         m975TpLgRrpzLdVzqtLVZyfgCoJZCJyh7AIihbUFTragVJ9Z1+hfKlmyFe76RMZ4TPv7
         IcMYsIhrDcZ3m5zgkqtO1C7qjSKaO3W45oDOoWHvclGtptlMblTg5hTa2EHplQyZPTMX
         KUbTZLU7xlX0M852CaZ89xio/XwfZ8zR/r6AwIRURzC1dneQ1FVMsPzaNI7n+uwsaQkX
         nvV7GCDtKInQyfg4jmnJGFNZBK+A8K8wDpNQQUpGFdKoafpdrw7a+vtCp3I6BshwVXqx
         SY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713141621; x=1713746421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJzHJYqm9cEleo6og2FxZikBNx9MbCNpwTRyUR9B8k0=;
        b=a7jjpSBpk8WVbcJiiCQ2WdlmQp1c+4zekhb+Z7cxdAKQA7Mz1NjSKuzcmND6643W/R
         thlkuVxDdBufk6WZk3IpVRjDWXnnOkXAFSbpQs3oxavRQzPOWx1GDGxppOCZ/W+BvLeK
         1AwP/JLo+ZK3kKbvezKX8txhWmGbA7uiXKzoPoKAYkXePC3UjE9PzYwWoWkA2V+jqufw
         xQHQvXgPuBsh3S/gzFSahno7qsNM3svy4shu2v1mmnRQnEdXpuBegr5HBbOSqLq/5oAK
         LsaVrshyOCKVqAbCPCfM73iCDe7LGhQ4u/Pd92zBODZdH1wInxtxX1LalB2V7cs7wSs0
         inMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn/LGfSb6JjPLx9tnQP3wKe3DxMWuwoRShc/e4KxqpJgRPhNMErG1552ZlAszUPwqMrdUqc+q6ymSsNH8joEYOv6vxA+qwBZPp7uLE+Jpk8wjQQCMa6ZYTMhBcQyfSJMvr2ocd+CMQQMCnP+Flw5o=
X-Gm-Message-State: AOJu0Yy0OefMy8KmBpIEzOolIwyzSqFIsRzIRENwUxmiGWJ4jrJhcrRf
	t+oicS4muzrqtKUAJ0fDHhNFcImccaq9c/DU6blFtYnGG3wRQSZu
X-Google-Smtp-Source: AGHT+IE7TLQRmn6MQvbZZQ4KmVzPFc/46RGTaTcbSYdprI+Y5m9b8zWk0XjVhcZ3KdggzpTwOHk0BQ==
X-Received: by 2002:a05:6e02:170b:b0:36a:20be:bf89 with SMTP id u11-20020a056e02170b00b0036a20bebf89mr11365073ill.16.1713141621359;
        Sun, 14 Apr 2024 17:40:21 -0700 (PDT)
Received: from shiv-machina.. (c-73-169-52-138.hsd1.co.comcast.net. [73.169.52.138])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056638620700b00482b2dc023esm2730851jab.18.2024.04.14.17.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 17:40:21 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivani Gupta <shivani07g@gmail.com>
Subject: [PATCH] gpu: drm: exynos: hdmi: eliminate uses of of_node_put()
Date: Mon, 15 Apr 2024 00:39:58 +0000
Message-Id: <20240415003958.721061-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize the __free() cleanup handler within the hdmi_get_phy_io function
to automatically release the device node when it is out of scope.
This eliminates the manual invocation of of_node_put(), reducing the
potential for memory leaks.

The modification requires initializing the device node at the beginning
of the function, ensuring that the automatic cleanup is safely executed.

Consequently, this removes the need for error cleanup paths that utilize
goto statements and the jump to out is no longer necessary.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index b1d02dec3774..a741fd949482 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1919,10 +1919,9 @@ static int hdmi_get_ddc_adapter(struct hdmi_context *hdata)
 static int hdmi_get_phy_io(struct hdmi_context *hdata)
 {
 	const char *compatible_str = "samsung,exynos4212-hdmiphy";
-	struct device_node *np;
-	int ret = 0;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, compatible_str);

-	np = of_find_compatible_node(NULL, NULL, compatible_str);
 	if (!np) {
 		np = of_parse_phandle(hdata->dev->of_node, "phy", 0);
 		if (!np) {
@@ -1937,21 +1936,17 @@ static int hdmi_get_phy_io(struct hdmi_context *hdata)
 		if (!hdata->regs_hdmiphy) {
 			DRM_DEV_ERROR(hdata->dev,
 				      "failed to ioremap hdmi phy\n");
-			ret = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 	} else {
 		hdata->hdmiphy_port = of_find_i2c_device_by_node(np);
 		if (!hdata->hdmiphy_port) {
 			DRM_INFO("Failed to get hdmi phy i2c client\n");
-			ret = -EPROBE_DEFER;
-			goto out;
+			return -EPROBE_DEFER;
 		}
 	}

-out:
-	of_node_put(np);
-	return ret;
+	return 0;
 }

 static int hdmi_probe(struct platform_device *pdev)
--
2.34.1


