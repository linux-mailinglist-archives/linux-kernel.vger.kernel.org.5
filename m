Return-Path: <linux-kernel+bounces-56447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5384CA48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F08828D54C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC35BAE3;
	Wed,  7 Feb 2024 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fCJ6QAjv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FA65A0EA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307494; cv=none; b=uT0xqHD+A7OUCVWf3FbY1T4+JNMyDPZZSbSEoWODogHZtd4nOGJFOb3KjnofIDSw4wTfo2w/UeaiiOh3WYPS2M4jc5p0FvJsz5Wzijs4BedTJDpHZqV762s6JFVQRYJaGcfpqzCnP3dKeHL/ZjIMzn3q42rHrufo6+VXAv+lYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307494; c=relaxed/simple;
	bh=r4K8vV5hlsfDw5ywNfN10FQ/vhQV2berw8NklQKyxSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkCVymSr8Ji5dRz6QK+cbgfQLuFvJ88Ea0KtjLmRdYEXaf54q9rGMhwq+00uFtWJPrXOZLdKyerHpOmPjieLU7hNyjRpQcRJ68wHRarGZAMZar3ugBpFBf7hiQ2EWZjH18y322CGMbh4UdiSE/ljExa0t703FshqvE/0L6GEXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fCJ6QAjv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fdc63f4feso4725025e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307480; x=1707912280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI0XGnXFUeGyPrdGimOqJnqeOPorDQn4uPXnM/OBJYI=;
        b=fCJ6QAjv5ypSIgAoZ/C7isGZMR2OeSSqfTwUTarUWjwUqo0vJ7jQodYmHLAOz1OtsG
         9QUFW2WMKAYGwP3P0duQ8j3FqA0GYBUCKIccEumPlZ+II2zJTHhK/3pR1r7AQmn1BKAE
         YE+nZ8YtLJVDX+YVHcqda4CmgsObG0yDj36bH2en+uc6GvmOqYg63xQNX1jGFU/fO/Lv
         ea+DT/aV8mzE5CYyEMeVabpGHZ7wtZBbui7DcPkkR/nsdXNUl3jqekRHNjqWGtzvulWX
         51eNx+joG+RrZy7jnn6J+pP8ew6/57KOe6kxRMyM41gKc6uLq/0lI4ob+6VQtPrGrn5n
         FoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307480; x=1707912280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI0XGnXFUeGyPrdGimOqJnqeOPorDQn4uPXnM/OBJYI=;
        b=ZC+i20arUTjxgBDvRV7ONrMgQ+JcrlYeHz/FjUNbgbIlCH6bo1kLVN9O6TbTSB1q/k
         nrvClkdPJlQVHp9x7mWdFPJCHD4ZosERgbH1nLRVI7biPlOuSeAZxYkaVOZuIu9EQasb
         PQMjDStPpUI6GGkD9Xbo9ZbDKDhhBk8kDactnRKU6AaFyASgkrbUiI9zR+yP6/YNhNfP
         peGyhZ4djmuoxuHsjMpdsSAfNQpIwLcsd7Wnf6khk69ZLwpWrsWmo9K0NiEMjZlIiiZq
         +gP940XH6fxJJN6/Dw0WNSy36KBySEflj2T/K7MIZjpDWkdjZ3LVIlMRRmmR6gjljafT
         uy3w==
X-Gm-Message-State: AOJu0YwCtv3uCPrG4VhA5amblCyn6tK8x4iMZPFEvzGMm1rTeiVz6CGZ
	aOYMC6e8QUCud5ByxJKEoGvSzDDP7XPkT6x5PGU5mIuCcrQtZQVj/BgjcYP4Y7Y=
X-Google-Smtp-Source: AGHT+IEzOauR1QCen0vBXFzjms6qTiywBdD82cqpw42ffLN+8RpFlsZOmAUT0myNuGQ3y729cTXgng==
X-Received: by 2002:a05:600c:510b:b0:40e:b9fb:103 with SMTP id o11-20020a05600c510b00b0040eb9fb0103mr3758517wms.23.1707307480664;
        Wed, 07 Feb 2024 04:04:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2clzqkIRwq5SydoLx7yLk3NTnY9gMjjVS6k9FBDzOZEbGVRvMfarAx1a8KKhon8gTb10h2OH6QQPEQM7g4sSKFuXNcwt+2hOHEDl5CU/iR7VTDaOHDuWgGID7WmcCIj8Hd+9zYVdyzUIbWJ7pJo3IcyRM5CK9zQbs/SGukOsf+g5sBVYWK2Uu2CY9QTeg4Qurq/PdPhEt6zWJgCJNH193tyQRgBJCYysbHG6yVCtwoebNtpgaGSXUrVO9OwHjv57oWQOgRrhBRKVWTYu7M+6a/KxxErrp38jI5ebkS1qba/+aIrIYsVXVAagO49Mat8NdJkIDUJu4FmioLV7UkaUZbyPxhrbJ+0Q9dxoEb1A1RVWcuGOdjFj5v2zdkeD5mA7yGQwtRIjJk+FLwTVWHgHzEoeA+PHNKf7YFNVG4HZDkW2s/Qfj+k2fMAQrJzTN2uTeTh3OjPqfdFkIjagOh7KHPyw+aD7jrh6f6YW2bKM7/CaPl7lxV2uoGApXdA==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:40 -0800 (PST)
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
Subject: [PATCH v5 04/17] spi: s3c64xx: explicitly include <linux/types.h>
Date: Wed,  7 Feb 2024 12:04:18 +0000
Message-ID: <20240207120431.2766269-5-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
References: <20240207120431.2766269-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses u32 and relies on an implicit inclusion of
<linux/types.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b1564a447a6e..0a30d034e288 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #define MAX_SPI_PORTS		16
 #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
-- 
2.43.0.687.g38aa6559b0-goog


