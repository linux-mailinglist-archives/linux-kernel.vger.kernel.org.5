Return-Path: <linux-kernel+bounces-58662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC884E9A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264E7B2E438
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD638F86;
	Thu,  8 Feb 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syzCU7pA"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13426383BF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423721; cv=none; b=kTQi9I2WJBnbjG+WztS8cLhBMNip/fGD/3J8zayiCVoSYXqKD0LAnjkcyHMFbT4T+fKV+HLryNJnaaco8D4CutpEkx96ace5LaaybAaH5lkEjyQ+eiEFJ0pfli/fIlrgLQQBfTUM+7qCBPSurgGc2jFHItT4WwH8QzS6QFAlzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423721; c=relaxed/simple;
	bh=v5ksPX416jwrJG8mY5GmdGPuDUaCNPfM6x8sAX5n/LE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtodQvsW1lvt+pFnxKVxvEIElC9cjeyhy+0nphLW77foBLC83uhAlrl+3oRy7OFVpACJyUOuuetcQGJbfr0mXyAvGEUr7y2qsRe8ZS4aZEeZGYrPZbsofritFoau2Bjx7A4K8S5qWK4UQJC8hnCHKRAYJ7D6KulHCWxze/2Shok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=syzCU7pA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41028900b83so1908635e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707423718; x=1708028518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lE5JHtuoDHy+7aqvLjhPRWMnVsRSmskZVIVhUopIObI=;
        b=syzCU7pAjTRkZkZcR+xuv9fLP1V+ym2cjipDeoF63wAAzuyg3is7s/vZ1++Mmm6nJ+
         U6hZwx6yXNIfEJxtLsqEwgX3ttbR8sBq4vO5jCOnk066A283Kl0nkZ1m+uYL/orfM3tW
         aQ+w5XHUFpfuau4Ld44cp8NB2Ft6r9Y1ljUyCyYhy+acwklfBkZMmP5I8V1Z3Nt+hwY6
         woDc7VRi7Na3jI188xLqpLKV1Q/QIsw14DccBx3KRwz1CLRH2ejBYsFam8j1tGtqwAf5
         cMu4zpVJqJGelzEBFYhfDcS21R7A3gsDVCocqkCNA/2ttMKrMaWrU/GQtpLsK7pUx0Tn
         UZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423718; x=1708028518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE5JHtuoDHy+7aqvLjhPRWMnVsRSmskZVIVhUopIObI=;
        b=nlRJgZ8vtPb+mqVlJ7OJ0eCQW4v5c/2Lb2jhnzzWPahyC6kAEcQRQCLlEE2sZm1Zmb
         hERgjU9hER4Slc+OaQKX1Db/nuDfHMJ7qytdBxUg+HUttxWnFjAUbnWliCYeOLEibjKZ
         evLQcyp2hl/7Afo7uroMhPNPXEYGS2M+kDMu2XP0/bkowknb6spcKioPxtklg6KWbLeP
         a9x+uUWoEy+/LAYPbwc3uTrluZ06YM+T9FXkm7LvRl9DHAZTA3qI4vmBXM7+X4dvtf4G
         vuuC0rl2DdV2fG2c9Dhnpc0KwKq769Sxp9XlVbNVqcHtHQ3zTmnGXbdXHb3cjLhq+6wo
         6tNw==
X-Forwarded-Encrypted: i=1; AJvYcCVhtzS8AX74yqc6PbdddAnxafZ8dWWP4Blve6b6MZQ1p3a2VScGOWA4ULKS90RLhmfoDupSw9qIvKRv5024zKSQ8wPx2fynwUurTvmA
X-Gm-Message-State: AOJu0YxsJbgbHEqcD1V1f7Ber6vnXzEPn/5XQZ32FOUa5WYZCzDUrthp
	IP7dCLs1H4ZY/I9EQP/rVaPnM6qsLMLjzxrPpy+HcpuWjyai6b9Opt5nAIvnmQ9vR5c00aqdMMx
	0
X-Google-Smtp-Source: AGHT+IEaFwr7Ir7SFzCiJ6urpwKh+LdpNeuyufC6D8xxMzWgeML4up0YeKPgsQ7Yc2BMv9/r/rDuGA==
X-Received: by 2002:a05:600c:1ca9:b0:40f:d738:c213 with SMTP id k41-20020a05600c1ca900b0040fd738c213mr312002wms.29.1707423718366;
        Thu, 08 Feb 2024 12:21:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiHg0p24NmyO7pEv4MGwMY/f2h/TMeuPNCg4obAkWV6IvhjnDaxeEulhC9wcvYIqN9rPeK2GOMGA4QBEwX961UGoi9wfdFbUzPFhOweQ1lqT+1CgTJz7H0Civw+u2j2Cyhr1Hl4lEk
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b0040fdd7cbc8dsm361481wms.47.2024.02.08.12.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:21:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] spi: pl022: Use typedef for dma_filter_fn
Date: Thu,  8 Feb 2024 21:21:52 +0100
Message-Id: <20240208202154.630336-1-krzysztof.kozlowski@linaro.org>
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
 include/linux/amba/pl022.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index 9bf58aac0df2..e08488df6d28 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -16,6 +16,7 @@
 #ifndef _SSP_PL022_H
 #define _SSP_PL022_H
 
+#include <linux/dmaengine.h>
 #include <linux/types.h>
 
 /**
@@ -235,7 +236,7 @@ struct dma_chan;
 struct pl022_ssp_controller {
 	u16 bus_id;
 	u8 enable_dma:1;
-	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
+	dma_filter_fn dma_filter;
 	void *dma_rx_param;
 	void *dma_tx_param;
 	int autosuspend_delay;
-- 
2.34.1


