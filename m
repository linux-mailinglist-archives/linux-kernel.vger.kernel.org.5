Return-Path: <linux-kernel+bounces-63675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B4853318
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7861F28706C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3757880;
	Tue, 13 Feb 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z589w6IZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330325789F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834532; cv=none; b=OXcHpsKSx2Za8PX1vAnr51/dDgKb4feOtJl715XAjbTIhw6HLTUvygtq0dDqp/5kocfuTg8RMKQmUFKpkfbL4XVkbgTrEv/C+Fp3V7FMT2zueUO/37ZMrtg9eh10rwiZFNHknp3eetWWIrRCKw9XkTNOGSUJRFoGHk+iiym/lXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834532; c=relaxed/simple;
	bh=9Rs+Z1D53lFg4letHGtTelZBrVpQkf1x4avjmD7lVBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4IN0qLAO+jYV4qcHcSL6h1+XeYWy4me4PTJ7rsAsAnyLPiRWCjvzKT9AkBj7CP+Ygihr/C72m4A8gc7Xku+OOJ5kgUkCjn4S668AENltGmtf21BmQJSmilJShd9FHVLQo7i5yxOQaIKgVgx65b/CWuYzQaO9Th4BX50gidazOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z589w6IZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411a5a86078so10474535e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707834527; x=1708439327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/P5OEV1VZDQ2Y6WiXRGS4Q89qwUlbC22uYjuCjHTuIU=;
        b=z589w6IZiDUb9MPSRhyntaVnu3Nr0CUNcXzCQ44mDsBt/zgO7ieps75uVcSWSOv6e4
         TDIiQc5SR9lEV37ZIDdfmGN1Gc3xT9e34BuRzTfpHuGCXw0aZDV6m2Ip4rBGJ0mELzPR
         Q62kUIWg3C08H/IdfQtkINTJ34fQvMGWnVYdFdMwKmfu5HtRIbsWJape/yvv+8rhsWpR
         71LYpU/gMfGw74qUsrW0FARBIfqFqUFr/iE6QjDaFbwg+2xDsxwu7ARRE6Dsx8jBOhgz
         IVVN/L2EjkAjiqpLEHKsScrMnigRFJTqpAj7ybPI2LQfPF4JRruqgctEfUXPQ6b2g1Bf
         QFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834527; x=1708439327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/P5OEV1VZDQ2Y6WiXRGS4Q89qwUlbC22uYjuCjHTuIU=;
        b=KrzSFPP+LJX+csR8dTnK00ABN+L2oD3Q9gpxyYSkdR2VGFocA7orrmDI5FRXISWcTs
         ic0q6QwQKxz/aGKtkluE6e6w9rMwLvC6qVf2jKWdOObsLWe99C0659JIPEa6bVJy9dMQ
         PNydQLBjhVe/kaR9rNcyGOP1zAgIjcKZxGjdGf0VUo618S5SdgitkMtJHv+O9fl+1udP
         NaC970YX3G43k0R/Pkrk5wJqZZUCKuUUCGD2urGREYPtI/vki+KuTNvsZa7bzTCYJcjk
         AxOHQSkTzxeFUmQh1luLNa0e9jvgzYRCTKY+nAPjwEAKBeLSsA4PoS2t6qHQqZoeoczx
         berw==
X-Forwarded-Encrypted: i=1; AJvYcCXMm6uqn5fB45p3h/WmBO6Q4ND0aTQ8uXzkZk4rGa1d8byPUKfXSa1oUdXTI3eQZauPAWjx1SAejKDjcGqt8GRVa3yL2f62OGm7JfQp
X-Gm-Message-State: AOJu0YxS3Ryi48oCseC7zOlHZ4RJbmUE4cZTwyG9LJRElTBNtzfAKhOp
	J9fdVmvIVqxbX5VjNUU3LZRH861pjQKss1hWbFzA2ESljPnUlfzfESAcM3QpkX4=
X-Google-Smtp-Source: AGHT+IGiC793LinMHbSN0tqOwAmEoL553oU7/A6JdVsIKr0NUqRw6b4JfedsvFaXrsTmYf3tExqs3A==
X-Received: by 2002:a5d:6049:0:b0:33b:830c:4747 with SMTP id j9-20020a5d6049000000b0033b830c4747mr4011709wrt.30.1707834527328;
        Tue, 13 Feb 2024 06:28:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXquBLIVBSe9TCBJGJYv2su4y13BafAYhwiX0ElOknAk6XMiKuZMqZpHY/sqIlHyFuQkPvSj03zBEvur9j88JaXMgQ9THxZYuC5RSujIuZBWhZbKIiLg3h6nk4DEgt2wcNOfWXzIamNTygjXtGFE7gxeuKEx+R1MNhm5+R8wsZpmRWscM+awpuwYtaYKLuMLHMagF0zXI2t7386evdi4s6AgCL+lT/aBCVJiwS/7tprLpJlWK59xPN/L7yhi7BuHSVOA+5bL+593PDYrttx5yVi1vpAh7cwbHAkxLS0iTLGlDspuk0dfeYzwA84OVRbOF0Q7jBGIFaU1mI6vMYq5vdJlwJr1ActrIFIPInnbcCWQQhMmV270rvyP/zQpekscueZ0lTROJwdFu93vyfJp/9w7T9kZXscuLUseKLoR9w4m8BHoJpJiZdwQoXXtJcGE16KBDuhR8N/T4G8QiQY2yA+eQjnilujsne457Mzk7zcEwST2R8UkRTUJtS6l09c9g==
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:509b:4241:48a3:e3e0])
        by smtp.googlemail.com with ESMTPSA id bs25-20020a056000071900b0033b45bdb2a1sm9880114wrb.4.2024.02.13.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:28:46 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] nvmem: meson-efuse: fix function pointer type mismatch
Date: Tue, 13 Feb 2024 15:28:28 +0100
Message-ID: <20240213142831.3069049-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

drivers/nvmem/meson-efuse.c:78:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   78 |                                        (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 611fbca1c861 ("nvmem: meson-efuse: add peripheral clock")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index b922df99f9bc..33678d0af2c2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -47,7 +47,6 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config *econfig;
 	struct clk *clk;
 	unsigned int size;
-	int ret;
 
 	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
 	if (!sm_np) {
@@ -60,27 +59,9 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	if (!fw)
 		return -EPROBE_DEFER;
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get efuse gate");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "failed to enable gate");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       clk);
-	if (ret) {
-		dev_err(dev, "failed to add disable callback");
-		return ret;
-	}
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get efuse gate");
 
 	if (meson_sm_call(fw, SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
 		dev_err(dev, "failed to get max user");
-- 
2.43.0


