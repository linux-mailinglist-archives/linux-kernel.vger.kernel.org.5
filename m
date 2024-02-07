Return-Path: <linux-kernel+bounces-56440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E89384CA30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF412286050
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3259B63;
	Wed,  7 Feb 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="my4M3EB0"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D515A0F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307483; cv=none; b=sIcdgrPy8K7X2ONc5Cir9y9MnVd2FijgVJsEbVnhKFoHQ4mR46FScNwHbaFHF8Z+mBls9aHVta0GoozVJcOzcS3sVEwSqrc1e7uBw7mcZbuN6XNX0B9FYojGcobN5pNsA9weyu9lJoPZuJkuVewMwzfZ1Il0Spvr+OWFSxJn8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307483; c=relaxed/simple;
	bh=JzXPRHVlj4kMqFgLLajSwxxBue7T3bsxJTGhEF3WWDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hI5VOR1r3NXfHkXCswiUNLJyOQnysK0ZdMzgJSGjcEviIsPq1yl8oz9+8xOYNnCCh2G2zN9jbvxBUrk1ptaGtt+ckylmq17vvNB8/VMOJ77+nYl4mWfTpuf5LosB8WrXQsx9whBRBr4KmV/0PSPJwmL19C3s+F/YhxomOH9g3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=my4M3EB0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b4e06c239so421030f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707307478; x=1707912278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=souH4fszIHhl+7lfvTkAEtznZt5fFUz7qZaAcpHpDRU=;
        b=my4M3EB0DSPRbD5A6Qg5j6EX56/wypw6EV4gTa2HAVAg0g5ZMswgU03WY3M0y802O0
         AfFk7PzqIMB7+WBiSU1ykixSzEXHj5/SNszWBR73kdxqhe1634nKKmewNBTj1Lr8sniQ
         rZuq8WMAGlYoYpk+A1GcX4bl1Q+XOXovqHcn/d/1qnNy772DTtRg6/uxLa0m8pBjCZVa
         +jF6AOkIpZdbmAbxUB8XltIcGYXnQVPrD/PAICZGG9uQWRM+StOHKcXDmVSRW4Mxn7CL
         awZH75b/uFy8WJC/E6xrmWHpklmWbVGbaWUXNE0EyzVeNjqTMod6kVCOMWKT4+oubL8e
         hZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307478; x=1707912278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=souH4fszIHhl+7lfvTkAEtznZt5fFUz7qZaAcpHpDRU=;
        b=ZWrF1WrGQGaQVEZeVLkOi6hC8dWWIUzGo6pf2HFCgUF7+8LdcLvgJHwmGTguVZ4+PV
         1q3Al66VReyEC67g2IkRUfc5KQlEyDl/KxCQqX4EIvNTLaLyhazLghC3VMcF1lSk5sn7
         n3416SRyxsgHQOgnQfgSmjQGEboYpt4B2L8mMVuWjqn8YWqL3wfyPPthMCbNANjt0a5W
         B8TNgiUJE8wx4aLyZaz5lI/6/I9JcWahEgUyduI5vsBZSNonfOfvevITMRtmd18l6lT6
         Fe6kkWjS9RBzRI0tk2pLy71oSMZvVVzcJceByouRlTlONCFxHrkal7gOkntIDnTXMwOE
         ZPCQ==
X-Gm-Message-State: AOJu0YzQlJXHW14wUKfjNg8dfqNbTFOG8rfWZpgIrMLuIPZ+fXG8Z9qC
	wndpxi7EAN9RXLtN1hqB1fTdYiWyyTYB4pmpxJeE8HvNGhmXPKEBZVs6Vz8XN/M=
X-Google-Smtp-Source: AGHT+IGFAtOw1qhjZckIfIOZZA6LDfXKXdro8MKlf13WGl1nFl3I1Ds/CFMhfACjQyDW7Ng2Q7vQpw==
X-Received: by 2002:adf:e643:0:b0:33b:1c1e:3e5f with SMTP id b3-20020adfe643000000b0033b1c1e3e5fmr3850519wrn.16.1707307478768;
        Wed, 07 Feb 2024 04:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEFqJKyWijUEzhbJRb74h2KdtPJux/+fuKK07LYNtY+mMmKVgLvpxl1mOnsS+0GP/LQ6RGT/rP/2ouqOYd8BDJu+w22E1Iit2rIBbvfJQ/RhXAgbVXTjlPGykU72wy5jfmLjQ1sohfh8T+OIM9iN5l6MugccbbO3fQdIi7WFk0E0wNy7U9clh3jFVG+iXZUqPeOjQxa/wKhx0pcf7INIk83Nq69iaw3Cr9FVjoHooq8vAYNs+uv0vPZZMPWOC/WGoDqL7dmagp4DgDvgaT0aP5hSUJ4tC377Tsj6vNpXwXoXCb1o+zA8wxYpZUgLV5R0fpqEQmU130/XHBiBhJd/kLsCjNRQ9InQJPvaidJKoyjMuh8ALsi2l7Q2008zppRfI8M8UQZlL4uKr37bM2e8uAEPL6zGy54VcOwutS0LlvrHGGS8XJ2A1pK9QwZmRtjFZdQZ+lorY/jFqFYQboJrsWRowKETmuzx14/k3mnPrHYyvz7QYTA3XvwL1AQQ==
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033b44a349e1sm1349967wrw.38.2024.02.07.04.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:04:37 -0800 (PST)
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
Subject: [PATCH v5 02/17] spi: s3c64xx: explicitly include <linux/io.h>
Date: Wed,  7 Feb 2024 12:04:16 +0000
Message-ID: <20240207120431.2766269-3-tudor.ambarus@linaro.org>
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

The driver uses readl() but does not include <linux/io.h>.

It is good practice to directly include all headers used, it avoids
implicit dependencies and spurious breakage if someone rearranges
headers and causes the implicit include to vanish.

Include the missing header.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 1455cbd2fa8d..9882eb0f4bea 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -9,6 +9,7 @@
 #include <linux/dmaengine.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/spi-s3c64xx.h>
-- 
2.43.0.687.g38aa6559b0-goog


