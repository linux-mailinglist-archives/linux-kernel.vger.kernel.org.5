Return-Path: <linux-kernel+bounces-125224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053C892270
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930291F2648E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52C137934;
	Fri, 29 Mar 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTA3rqNe"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67B131E5C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732234; cv=none; b=mIR9dbCg4YVKtKQ8a0Ol6wSgqb+rogNS9X6Gh2EH6xppatErv3B+8IXJTQDqJVPq/b5oIoleuUdTRYdTgoVTGcAno45zVeUehkc/IgFh9snhDkI0U5Y+KwvrxTGyUPRR/o8N9+gG4YU+ANsH15V8+IxIqa4IX4FZphp9Y/0UtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732234; c=relaxed/simple;
	bh=1do6tfNH68DObpEKyzA1h8TA9LOtGeD6ZTJRXrUWXBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2ItQI3WQj3rGXlwHvtndxvDF0i9gtCCAONBWo88g2A5pBc59BsJvVD/goIuwxlTNStN4w0MlWfneS1CUdil2r2KB1ljJa2vRJY4kRBUXJJ31qSbHwRSqo5ARG+f/pxHmUQZh1j3GPtgTi60a90I7KN5ntbUTxCVoxWVKOGaKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTA3rqNe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3416df43cabso1497772f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732230; x=1712337030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl9e/glL3WN5Ke/EqF6PlMNs4wHLhHYNYdj8lwPraLU=;
        b=qTA3rqNe3HAuOX8zS3pIZjF07nneZy0VMQVEDGMMX3Ul+Yq1nhz27sqdyA9Dk4tHag
         dpLMI+HqoJu8ju9RrzFpjjxN+qpkRzSrVMQ9fF0w9AQPwFdMt4RkR0Uw/OfTN/d78TXa
         4X18NN0HtAKYACKJFhBka63MH4uWERlReRnTsuRu3nIaXtrdAlkI6pBUQv+Iq2OQ8qEK
         IDd76XAGRx6TEZewkOs1w5PRRlc6Ms6xWtgDemhXyEV9/vmVrXbWfT+bityzqXymJsTG
         Xizp3blV4aJWjRDrSGnsKg3EZPvJGphBrmK+MAcpKGT91r8nCjMEg6lIUipJosEm2dRy
         vZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732230; x=1712337030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yl9e/glL3WN5Ke/EqF6PlMNs4wHLhHYNYdj8lwPraLU=;
        b=h05n5axJ11EDNsNn9EqwTafER+GG4Hwszg58gZmarmNcbGGKrvhvYASr+hoeX+JFZS
         Ijsik26JkE83Q8EMIHMHX17sw27KJlImMtwzx073CiggXHNCI7vuNHMgCV3bjiaH8RMw
         3HFPuZDWcn34odjjk//3Kfn1JQ0cafa6mgGxGVtoef/GYp0saIFsPjsEtc6z24kL1PJS
         Xxw+IEHWIE+cFdrJ9PKJHXxacpYFoR+RcmWqxFM1DQfmHSY+AOh68v0Gca3gYJOu8t9v
         3ZLtdQ683rykAk2+HSFCtXo8DKsmKgheF6io6gt7DLNi4+9NtAY7PpvuJZYJSX3XOnPY
         vjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlXhYrfBWLnFqsDMfulxwxgynI2lwHQLha7s40vUjCwAbJqtQQDbZjiIkEuJMlJOvaIa37wf/MeYDoEClGUScguTzA2651W5NmcoE8
X-Gm-Message-State: AOJu0Yw3RcHshr38MEXS5Q8SuhLPIbAFyCgR6dui7xAf9fSCWkOTvCBc
	g4in6jsjfJ6WAz8P1oRU4cx/2yOdM17EcoiAli63G9C3OgHLYwl6a7RcTSxZuec=
X-Google-Smtp-Source: AGHT+IGWRmVRru6HhXuMrT26wbmLt8juVtl8/ndRNMn7ZfdtMw/RN4XPuzVFDz8oZ9VNkUeJPKHs3g==
X-Received: by 2002:a5d:4750:0:b0:33e:69db:bf8a with SMTP id o16-20020a5d4750000000b0033e69dbbf8amr1582625wrs.59.1711732229769;
        Fri, 29 Mar 2024 10:10:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] wifi: ath6kl: sdio: simplify module initialization
Date: Fri, 29 Mar 2024 18:10:15 +0100
Message-Id: <20240329171019.63836-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
References: <20240329171019.63836-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver's initialization functions do not perform any custom code,
except printing messages.  Printing messages on modules
loading/unloading is discouraged because it pollutes the dmesg
regardless whether user actually has this device.  Core kernel code
already gives tools to investigate whether module was loaded or not.

Drop the printing messages which allows to replace open-coded
module_sdio_driver().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
---
 drivers/net/wireless/ath/ath6kl/sdio.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/sdio.c b/drivers/net/wireless/ath/ath6kl/sdio.c
index 8a43c48ec1cf..9ab091044706 100644
--- a/drivers/net/wireless/ath/ath6kl/sdio.c
+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
@@ -1427,25 +1427,7 @@ static struct sdio_driver ath6kl_sdio_driver = {
 	.remove = ath6kl_sdio_remove,
 	.drv.pm = ATH6KL_SDIO_PM_OPS,
 };
-
-static int __init ath6kl_sdio_init(void)
-{
-	int ret;
-
-	ret = sdio_register_driver(&ath6kl_sdio_driver);
-	if (ret)
-		ath6kl_err("sdio driver registration failed: %d\n", ret);
-
-	return ret;
-}
-
-static void __exit ath6kl_sdio_exit(void)
-{
-	sdio_unregister_driver(&ath6kl_sdio_driver);
-}
-
-module_init(ath6kl_sdio_init);
-module_exit(ath6kl_sdio_exit);
+module_sdio_driver(ath6kl_sdio_driver);
 
 MODULE_AUTHOR("Atheros Communications, Inc.");
 MODULE_DESCRIPTION("Driver support for Atheros AR600x SDIO devices");
-- 
2.34.1


