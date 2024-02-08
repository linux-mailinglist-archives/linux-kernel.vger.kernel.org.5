Return-Path: <linux-kernel+bounces-58659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3184E9A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BC9B2D461
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4BC383B1;
	Thu,  8 Feb 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCE2oF5z"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89038DE8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423682; cv=none; b=bXug/yHGY8/qF5s5cnLFbQdYj9Kv03aJ0CCkk+/MznE6jh3hTuJnEwKTFErldOeUsvLBJGafEkngN4SXhOAnoUqs2mupUyotkq0Wh/6IOUl3pemlKy4hv81KcmqrRxE1Xm0/MsCN82ikXf+CyC3UhODbEmEHBfdRNhksCLMYIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423682; c=relaxed/simple;
	bh=JFECZkfHOEO+Q41y6E7xB+QIGKBK4MOk9yTZKj4LIrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIq/ug0PIXr7gjcYt6dO3vlvM9Mu314U3WNTet0/Sxld50ETmVYUNZSylvSklFSD6MMbjhn9PaF9/SQWc33oNZTj1inaNZieo3VHg2mLx9+QbRZKHkSMt+qHxh5ytLqDEjaNumaeZ8R8sGm/j7hesOhXS2JLhwst6yvLo+GB8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCE2oF5z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51032058f17so251224e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707423678; x=1708028478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYrd6d2Vrj5LAMP1/VHvIQz43NZRkWAQemJpz+Uzi6Y=;
        b=UCE2oF5ztaB4KzTrdn2MmO9mHBC7Ie/ZTD0z0vgFfBwFuUM2Z5PeCa1+6SLVE8Smpx
         ziDpuJg0iUnO9eqR4bOVjS0YJoOPTieycrnI8+RzcAlBNNRB8g0SHYvNdfDpWXcXbTu3
         UP1aiVIBNK62UTQnA5OpohUMoYopGyxVqj/J0lznDN6IsMk4m5dHAh82/rZOSSg0PkvS
         BKbRpdfGjc/vRTBlZFP9xvIXjzVU2cqxzANoldgl6UptDiRnFxlSZwMxgGWR0+U870eW
         JJnW7cF3sweJJtsIew/rOqIfT4ASpvMEI7SMv3QP0dbL1aQ4Oup2Pb9MWJtIxZcJNVpo
         sZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423678; x=1708028478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYrd6d2Vrj5LAMP1/VHvIQz43NZRkWAQemJpz+Uzi6Y=;
        b=cSqWvQi1AaQ9MjHV5NxYAojoNWcSQmQXe8K7VJ4aJZEpzkNKAf32+sTMf7jXGboz9J
         iN+KVUn/4fG5bz0gCj3Szvt8KXO8HMl8fzZ5RpAm83MvNhMPZ8356pIKo4DtRgdSoNLi
         MJVmi9PqH4oxISq0gQL/HvZuvzBibqtjVxBzlUAt9QuVdYhCzGhYH6XxTR1DHma72Hv0
         C183u44SDOvOh55HANgMkWInjAuwU/Y4igz/ZJ2ipg/LFEANGf88SaNTVIYAg+gZ8KUk
         KnwLN5reOlXrUMwGjC1R73YQQM4JB42gJUyBN/MYU9dx7CDaDd2RS6HpFtwoot3tZ3++
         l2jw==
X-Gm-Message-State: AOJu0YwsvtuRuxfGn0lfpzLfXg8B/VWbyZ94h/5qZETNfUA7zn4L/G2A
	Ujk3Mjcg8dF+thmq8U2NwOkyrINrZOzEl7o099PYUFMN/Nc9uBxcLm6HchW1sxo=
X-Google-Smtp-Source: AGHT+IHQanfxPW2CcC4hKnkMVwYvaA2KgElAkpb0g6w3+l0Q0oHVnoKZEhCdQCXZhKeHl/8aGWT4OA==
X-Received: by 2002:ac2:5397:0:b0:511:3489:507b with SMTP id g23-20020ac25397000000b005113489507bmr233368lfh.19.1707423678591;
        Thu, 08 Feb 2024 12:21:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBp2VGAIbDEkqCBR+eL3L/pt9z1QVnyLKjRsjGe3EtECzfO5TbNlfgzw7l6G9m0/RtVCLV8ZE1KZB/JfIq7CzKAW6PKZA6e4pJ1wzxByP34AdEjuP7aBB4enXHfxlkplJJg0uA7C4fKfhsSwPePv+rkZBoI0ZRiKmB+bgvb0X6qbkNS0z+IlD7BFBPipHtE0u+uesQzNxsNH18mEnal9X4Bq9tAoZMkz2qm9iFbT3U1fCQEhmim1/GPaQTpbc/mAM=
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05600c3d8e00b0040fe5994d0csm402866wmb.0.2024.02.08.12.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:21:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mtd: lpc32xx: use typedef for dma_filter_fn
Date: Thu,  8 Feb 2024 21:21:13 +0100
Message-Id: <20240208202113.630190-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing typedef for dma_filter_fn to avoid duplicating type
definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/linux/mtd/lpc32xx_mlc.h | 2 +-
 include/linux/mtd/lpc32xx_slc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/lpc32xx_mlc.h b/include/linux/mtd/lpc32xx_mlc.h
index d168c628c0d5..35e971be0950 100644
--- a/include/linux/mtd/lpc32xx_mlc.h
+++ b/include/linux/mtd/lpc32xx_mlc.h
@@ -11,7 +11,7 @@
 #include <linux/dmaengine.h>
 
 struct lpc32xx_mlc_platform_data {
-	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	dma_filter_fn dma_filter;
 };
 
 #endif  /* __LINUX_MTD_LPC32XX_MLC_H */
diff --git a/include/linux/mtd/lpc32xx_slc.h b/include/linux/mtd/lpc32xx_slc.h
index cf54a9f80460..a044b806566b 100644
--- a/include/linux/mtd/lpc32xx_slc.h
+++ b/include/linux/mtd/lpc32xx_slc.h
@@ -11,7 +11,7 @@
 #include <linux/dmaengine.h>
 
 struct lpc32xx_slc_platform_data {
-	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	dma_filter_fn dma_filter;
 };
 
 #endif  /* __LINUX_MTD_LPC32XX_SLC_H */
-- 
2.34.1


