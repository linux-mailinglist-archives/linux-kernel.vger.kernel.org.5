Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B57E9510
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 03:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjKMCel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 21:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMCej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 21:34:39 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09610E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:34:36 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so2888801b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699842876; x=1700447676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3x9HMy2KOCVDwBY1aKyWkU7yvsdzFHPBbEJCciD5yLQ=;
        b=JuygbspNqMr3rkxFBnw8mb79whkOEmqHm6n3kiFY3P2wDBeVpbmJ7Sx1JfGb3fpKkh
         Ed4CCOWtlMpKLsel6zhInjMuZgbmxT+Pq+i6gAi/tk11rgSZdfmAT6uGH9NcNxOt43dD
         VgDB6P068mrPmOjMRE96/YWzeRueurz7TNCb9TnSW9kZoktZrtdDx1lsHC/UdllAydP+
         AP8i0Dl3xeawdsxRiabAF9P8imei6lWig9EuXYR+HUDu7g77YPCUX1u1xKqnN5fphfAZ
         xMu0W29Drz3xvDkTWlnZgXsrFFJ6v60OQLIc1IV+oa3gUhk0W4DwWlzjvyTqzQNUvQ+/
         IRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699842876; x=1700447676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x9HMy2KOCVDwBY1aKyWkU7yvsdzFHPBbEJCciD5yLQ=;
        b=Ss8S0tc8dcR8Tdz+z9YgOnN0C4H0XZfp4+JEPhMkh63nlLkQsDYqPgo/e6wX0Hzh/2
         cizP22wP04IrnV5c96NFdueYJmNDQ+/iw/ySQXhd8ivAjXdYzzgZHl7CiAuTxHbIo2ld
         WCHJSTm/xdolxmnKsAs5kF1WwzyYPDPAo6Lpuxtw7rAtMN1ofZAqQ7LJaicCFprmxiNX
         5sixdJVAEpaTa5C1+MHGEFiJadUmT4Ltx5CltnpLRxahlaQo+jewFLuMBX2lRdOzUAlr
         IYbvqR2+Z3M5v6DjNlrSRey01ova1cE2dI1eta5upVqcz8QR9UItgYl2SbyFKtkvVMmm
         sZ0g==
X-Gm-Message-State: AOJu0YzHFH575t+d802T0XuU4SNLMr+V+IphBjV0g98xmYhFMICVQuo6
        DYcRMti42andOKAKbvgvKtURvA==
X-Google-Smtp-Source: AGHT+IEnZh+aR0sLWPKOFMs80myLNe8uYYzars/PhN40NDuSuCYLfhLw30h/2jkP74tE/0IvSzLuEA==
X-Received: by 2002:a05:6a00:800c:b0:6c3:5f49:6da5 with SMTP id eg12-20020a056a00800c00b006c35f496da5mr7110474pfb.34.1699842876238;
        Sun, 12 Nov 2023 18:34:36 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id hy12-20020a056a006a0c00b0068fb8080939sm3015184pfb.65.2023.11.12.18.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 18:34:35 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>,
        Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2] gpio: sifive: remove unneeded call to platform_set_drvdata()
Date:   Sun, 12 Nov 2023 18:34:32 -0800
Message-ID: <20231113023434.1186043-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Coardos <aboutphysycs@gmail.com>

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Rebase on v6.7-rc1

 drivers/gpio/gpio-sifive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 8decd9b5d229..067c8edb62e2 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -250,7 +250,6 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	girq->handler = handle_bad_irq;
 	girq->default_type = IRQ_TYPE_NONE;
 
-	platform_set_drvdata(pdev, chip);
 	return gpiochip_add_data(&chip->gc, chip);
 }
 
-- 
2.42.0

