Return-Path: <linux-kernel+bounces-125225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D47892271
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51A928CC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBE13849A;
	Fri, 29 Mar 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUmmw78W"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838513341C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732234; cv=none; b=SXx2xNrAsLblSLC4WVI776wTY5mni269f/ZUZWiyTpwr43W2sh8EytDMdUUGWZzDLcFBEI8xxMB94vA9V4GaPbr8pe7fG+l9zkLryX5sGI+wvchk9TMwds/q4EjX4CLzEHgux8uonbqt+PLqjT7vzuO3j9uqgu31D8aweA/bTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732234; c=relaxed/simple;
	bh=8PHeUGU+ZRvrLa0WyO7pGv+/fClxC3Ext0tzuOtYQUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuL6VHFfulD386nKLVWbdqHvzHy0ELwVrxuI8xjPCcWyep/nZTPlVgjzc7JB+H6v4xA4AV9vjH250+v69AtzePwDpzNTZCtaS6lDhwbe0jHW1Q+HnspBGPHh99hBy139UrX9ffsB9Iymrif6GrmACQPMwdClHaXNORouvnAXMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUmmw78W; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so18489785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711732231; x=1712337031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXP8LCcnnVa9d+y1k6oL+GlmX9060FPKOT56CxvkCmk=;
        b=cUmmw78WVNZx/+hCd2kDLwk3hExyp5chDzgNFU59CWAfjgvb9pzWBdsBKdtb3qIqik
         EeQz2f2R/73UGAofqdr/PqZ/PjKMm6kCJk8jcMTDXwHRZW5XHMlsoQkS0TkysKJ6F8kD
         6bO08tCh+VSh5yWG8pk9bShZT+35/yu63F94/DKZZ4FO7jaLXVkHmLTuvMW3DVIEBvMN
         kx7ceuk4Q/6NRAMGuzcB9UEcJQDEzAApY4UrZfAwy1p09ST743MARw+UikY0cavfxzRy
         mZPtCY4GElNeWvhL6lLLIoJ4il3Cy08tlbhNLP7zm0U8dUSL4cBx7kAVWcMzU3j0kbHx
         MJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711732231; x=1712337031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXP8LCcnnVa9d+y1k6oL+GlmX9060FPKOT56CxvkCmk=;
        b=Mh41RPSYUdTG0JmOa+GKYcnFETuU7qRci0uNbAexoC42OUmwkq3S8x271SlvXuFkfh
         9J+dMBBlQGk5I6t0ftVX6N9dIn9EfSb3VStG/Ev+4nZ6W3fYEMZRz30Eey7yKUkhrBBF
         jXnPsuCEJo1mYgEX8wQKtNTxJrccsGwKljYUyLSnj+sF+ErY+y3TibOgGwQc9I3etTCJ
         DgHRqAewtQAGqUa3Y1ZYqujz45alNQWDpQ1lseych8AGxxXElxD5KX/jOP2W/0cRwuXA
         pErfEufRdcmn6IcA4fRNxyzpp949edyOTXMXWya99SNyUx5n2LgYfuSw+RKXbQ+tpc+I
         URjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Kcqe+m2hO5v3oCpUQTxAEAfRlv9FgKN/z+ufW6WJbnTO/T9vWlJCG7y4B7o9HNDpQoEcmds8PNb1sWpl2KljpfxKEuJFMJBsiZWx
X-Gm-Message-State: AOJu0Yytuu7J7I08c2u27LjZIEvNxLXkdJCqYiQ6/XEzXcXREG4WVbMi
	1ez4aYoD+pxv3tMFeMLAA4gjdf2YziUbgK6G2tsY/AVMNHIenio+O6eokqjdLQQ=
X-Google-Smtp-Source: AGHT+IGESeQn/WY+9sDt6AYXXFEGPsBJDLNgHvdN9tKgNTMhMDCcaxBcRgMFF4AuYYmG6bqCbcDOXw==
X-Received: by 2002:a05:600c:4e94:b0:413:fdc2:d9da with SMTP id f20-20020a05600c4e9400b00413fdc2d9damr2587780wmq.12.1711732231217;
        Fri, 29 Mar 2024 10:10:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0033ec9936909sm4577665wrw.39.2024.03.29.10.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:10:30 -0700 (PDT)
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
Subject: [PATCH 3/6] wifi: rsi: sdio: simplify module initialization
Date: Fri, 29 Mar 2024 18:10:16 +0100
Message-Id: <20240329171019.63836-3-krzysztof.kozlowski@linaro.org>
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
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 31 +------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 8e7b757475d2..1e578533e473 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1519,36 +1519,7 @@ static struct sdio_driver rsi_driver = {
 	}
 #endif
 };
-
-/**
- * rsi_module_init() - This function registers the sdio module.
- * @void: Void.
- *
- * Return: 0 on success.
- */
-static int rsi_module_init(void)
-{
-	int ret;
-
-	ret = sdio_register_driver(&rsi_driver);
-	rsi_dbg(INIT_ZONE, "%s: Registering driver\n", __func__);
-	return ret;
-}
-
-/**
- * rsi_module_exit() - This function unregisters the sdio module.
- * @void: Void.
- *
- * Return: None.
- */
-static void rsi_module_exit(void)
-{
-	sdio_unregister_driver(&rsi_driver);
-	rsi_dbg(INFO_ZONE, "%s: Unregistering driver\n", __func__);
-}
-
-module_init(rsi_module_init);
-module_exit(rsi_module_exit);
+module_sdio_driver(rsi_driver);
 
 MODULE_AUTHOR("Redpine Signals Inc");
 MODULE_DESCRIPTION("Common SDIO layer for RSI drivers");
-- 
2.34.1


