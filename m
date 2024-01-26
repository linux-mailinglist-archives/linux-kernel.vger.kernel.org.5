Return-Path: <linux-kernel+bounces-40404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06783DFA0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A16D1C22542
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70120327;
	Fri, 26 Jan 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpBlhoc+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532431EB51
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289354; cv=none; b=TrkwYFK5toRsa2EqigiTDOzuPvklbkQl8h5Nq5MfTOEpn5W8IEE9wTShJuDsvJJLWkwdELkFwqsacD6oeYY50jSLQFQgkf5xEX++QvTvUdfM3ShG9uZCVv9+VKmzVhHMi6l338Oh+oUE5VbmvBl1ldfB/fRnGeBH6eCW8YxehzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289354; c=relaxed/simple;
	bh=c7iSgUJTrECnQEQ+PYY72b3yXlblzBzUREV9meR6/uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQk898MZ4OWelIGqIdn0puOGU1dr2Mp1KpSdYo5Ek108kzzVUPZZLu7ZH/KatbguKken9Jnwrgx6BXWTlgaPDTkQVQuYH65z6aExGDSNw4anNSoLBhv8oR7WAFxsXQSTR3KDG3N8AU6hfxX3e7bqyLQGy82QEScs+/gt9DNB0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dpBlhoc+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ee418e7edso9230805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289350; x=1706894150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8tycZHq++FMKvH1QpORqsbZ4vIzt59SLtlLRtqr3vk=;
        b=dpBlhoc+jYWT4TrtWnB/DOzlo4cVLvDDUoe+5lYzY2siAD8fD0PBCn8s2JBfe4jwj7
         udnMYSssKs6SO0JavvUcaCrQRza4ssH0j6dxKTqI1qngOlHcec+EVbBNPfCM1IQL6/Q1
         2890QU4OGv52nmTde4PialPCvl7Ql85spShd/FpZmahYWYBKgRWYtWzKT1KDfXA/saaM
         84ioRs3IOl7U6zsAc9AWn+Ah7sp4we1HdYs/k/o5TEF1iQYVV4RUt8evINlI79QbTBEg
         jMBf8KrOy8kV6qVhedobIvOrBkzwLeHk27meAkrxLEXiM/+iIXrXl2YKeCEW9U0XiK3u
         feCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289350; x=1706894150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8tycZHq++FMKvH1QpORqsbZ4vIzt59SLtlLRtqr3vk=;
        b=PoovxxtflRJPCEkevoKQUVV3/PfA2IQ7dmGZvVJucJ3lTi21TthG296ZzQIlDjp8Rp
         ju3gOWGkDbEGxVHg6tmbE9rv+FOgDcGz6aDAgKyzGJRLUU8T+V80M/7NAcriuw3ael0r
         w9GEnvyd60qGR6U/7r8puRaXlC5xjhzmt0C2g90PMdys5lCqhMzyHhsDZRfitJ2QXC0u
         ARY3Gg1/pO8vKXO9SOhkmaLxzJPgb6FEW6pn9m1LlKa9r5m6ia53O0g6pUtmtR0GXGQi
         bt2/vlur5rgk9p7XlrYGf73MRdL/SVM4ncOOKDZmeFOaQCRfSjiJz+hLZUpd6FiqaBvY
         haGQ==
X-Gm-Message-State: AOJu0YygaiM2Xc84aXgoyXHTNECDwtg6II4QuAR9cG+JiHPCVjSx4+y9
	YyO14Kh3A/dkXxfBMcQXb4H+PG+9q4j94B6iMDTvBosKkddoBS9kvsOXhGKKLbM=
X-Google-Smtp-Source: AGHT+IFpJ07QZ468cZz+H4b0+wED6nysxjU6/1yUoJI7/D6+IBIi5z+GZjqWxTNkdSU2UKwsAbuMig==
X-Received: by 2002:a05:600c:a082:b0:40d:8ff4:ea02 with SMTP id jh2-20020a05600ca08200b0040d8ff4ea02mr89344wmb.86.1706289350653;
        Fri, 26 Jan 2024 09:15:50 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:15:50 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 02/17] spi: s3c64xx: explicitly include <linux/bits.h>
Date: Fri, 26 Jan 2024 17:15:30 +0000
Message-ID: <20240126171546.1233172-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses GENMASK() but does not include <linux/bits.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 1224e29572f6 ("spi: s3c64xx: Fix large transfers with DMA")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c1cbc4780a3b..2b5bb7604526 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -3,6 +3,7 @@
 // Copyright (c) 2009 Samsung Electronics Co., Ltd.
 //      Jaswinder Singh <jassi.brar@samsung.com>
 
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-- 
2.43.0.429.g432eaa2c6b-goog


