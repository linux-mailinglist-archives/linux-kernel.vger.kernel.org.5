Return-Path: <linux-kernel+bounces-52632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11F849AAF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA580283A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92A1CD0B;
	Mon,  5 Feb 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfrLPn19"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5A1BC58
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137123; cv=none; b=fP16NT9gog3kEV5JpRoTJsn87wj1IZ8w0KMa9SbWpwqIYpTv9dZwbSAQ9DpQkef0UpOwhB6qH8pteH4d6508OPKbJ4S6DfkMu58Eb6NHjMD99WI8SyRieP9YT98vL8kI+rIleM7Zj2nO/r9NfNku0LXJ7ZAg0KUFpDW+FGd+p/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137123; c=relaxed/simple;
	bh=w5JFDx3igBQ6hCvWUpDTLodih1IhDobo9CBbUVJNHT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ8Cw82AGaXSXvZ6Os5tLpX5Ty3/MCk6Km4vPlncKZJgAggfabLpcSFBZSiui6kgXinVti4efKvRNYksfgaOnEm9eFp5YGgMkAMvuWEZFcLIuAvpTy+E7LScjypSB8KNhIZs3e0cN66Gmnp93pS/OtxV095VmGqDQokc8n2RozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AfrLPn19; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fd55c7f93so12810185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137118; x=1707741918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5ZHz3RUkQzpbVKYtYrrDh0U5BmbIjj4KbeJaOU/Fns=;
        b=AfrLPn19rAnlYjgMSt3zmwaoRTjgrHtP6XChKelZ3zrZNcueRhteLqgKypIdnUe972
         cVupn9gFODR5HHxQO7lQFSPHs596k0X1leFfVQ22iy/fQTs6ya2FEbdvEiNh3czJ6hxz
         0UI7L870mEscceHvFVzz0n+7FL6u0pjMcmOfgHHWC2yd5F5NQ/GGJAI0keVdYPGiILN1
         zkntVg/i6E7na+nmjzj2H6F9Lur+T02CEBYYsdwM95GRpJ2TWYVDxwBasKkVBzoC97sO
         DKFOGY/XjcxZ3Bi64TB8lJ0CseIqLbx3zB0K0n3Us1yvyNP2ph/WsOO5Gaio17+r6UPW
         fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137118; x=1707741918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5ZHz3RUkQzpbVKYtYrrDh0U5BmbIjj4KbeJaOU/Fns=;
        b=cuWO5xheDEbNrvijvMemEBjaaRKDJr9I6aFvzg6chfWKrskm0bjfMWB9yN5M97QUKF
         gU33ZMw1OStang6k/Pc4HcaU/xchVQ7orPvcAL4HC959ZvMWC9FI6fRy5b/9dA7g2yjn
         vZfvHzan8aMhxkLkoCeKvT2t9m/+Y4wYtVZm40dxfW9xLWy8LACyiC+JG+7aYaLYj5/0
         Ed82bVaCnWkUXJ98j+0njRevGmqH/Mjt25tsdULFDz0WNz0Ns7u1bIUK/ARHNq3Vm4nL
         RjRTWnpAR0TIk7AFJD5bd+EeM+I63C8KXpsKhsIb3t172T7IpoSJDj9I6fWqcEzxuh3/
         MEvg==
X-Gm-Message-State: AOJu0Yw5dzLw0jUf6UNJ4XjJDBC7vov8eLACVxAucupKfpw0R5DKDUkT
	4wHhwpqBkkMXHnBhaSvMjH+1+mvXa7fYEQ3MTgwj5+lgpzD7sqTh4FSYXaOoP4Y=
X-Google-Smtp-Source: AGHT+IH2g+aR/d3Fae3kdapdUimxpiado+1l+RHT/8yqZSKFvLAV9z7ZolUfNyqRIwCk2qjcXVUgDw==
X-Received: by 2002:adf:e5cf:0:b0:33b:271c:7816 with SMTP id a15-20020adfe5cf000000b0033b271c7816mr5677447wrn.34.1707137117995;
        Mon, 05 Feb 2024 04:45:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXtbBtwOp4puWrLL5c/VhRl/CPpo7l2wIBvMapxm89/G7uxlduwkxRUThQZ0QEbczFrOy48ou7ofI5BCEX40lsslzCFFjvWAjmuzT8DjVAW+riZ9tU5nE//rSfXikq78EmH1ppYoo96wXmU/vYmhOfuAEGjukCYaq+1IxulzaxLMtMl4koGrrABfSCPx1y73OJTy4thv/5CfAlkB6PpHktM7bLpjIcgTC+ms0jQsrpjKsj9eQwKOVq0sm7DJdOMsZb5s0mrIEMDqkFSI4+F7+Q6ZfhXh5Lrvc2+bBv2CzNSlKm8k8btEv14J1iv2H7Vq1pmzW9ipVGP8BFDGuKP8S0GQwg2uVB9LpURT2M7q9iuqF4qkZPx4OlNFnn9kqqrpwFtWe2qqbPhI5ju/hL9LSwSgZFo2z8/D82IwbTrrmKlgcSY9fveajc8V715ICpC2OfquSxvtrDUPp3Tj9qMg4DRZf1JBbDbcYaDoqzWM4SOw2SUaiu5kmkqiu5i1Q==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9-20020adff089000000b0033b35da384fsm3650812wro.33.2024.02.05.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:45:17 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 01/16] spi: s3c64xx: explicitly include <linux/io.h>
Date: Mon,  5 Feb 2024 12:44:58 +0000
Message-ID: <20240205124513.447875-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240205124513.447875-1-tudor.ambarus@linaro.org>
References: <20240205124513.447875-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses readl() but does not include <linux/io.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7f7eb8f742e4..c1cbc4780a3b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
-- 
2.43.0.594.gd9cf4e227d-goog


