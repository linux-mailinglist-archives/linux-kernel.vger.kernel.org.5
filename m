Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122047B629C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjJCHjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjJCHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:39:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5883
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:39:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50437c618b4so686532e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696318782; x=1696923582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tmSPARAlc4pAu0fx6WWRS8V/BeHfaSNDUWviGGzaOk=;
        b=HpcVflxFmsOT/dVDQJEHW2+djxuDOVeG/CJnGbc+icVXoV+wa2tm+SmmMX7btFOjwd
         JZRUTcKMu3Kz2Q1LL5qBBIesTkrPyIO/ZX6MOzI4OwjgBBUCoODiGF3DwDhUQ2h8nP6E
         ouO4tWhTCwpuPgPO8utz/G9s93VNbUG5wFu8QJQZJdQWXNHmjBdqWOAlJyGcaVTeQin6
         R9EDmSHa7YYqJdPX7VT74Kz64CD9Z2PAmEwZr7gTe8t1ijn5JOvuJIIItoXxBJDy/pWe
         U4GGebu1DkZkih4uUCfVlHteLOFSqcmTZaKreFeZD4juVm3tp63seE5JMr3544jhdgEt
         r4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696318782; x=1696923582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tmSPARAlc4pAu0fx6WWRS8V/BeHfaSNDUWviGGzaOk=;
        b=LEU9jCtOD8L9cuhdlgEX+G3nt4BBci/U/GLaL6ohHgRr5lGai9PJk6UeXWtXfld7nH
         ODeOGfOuy/mJPRtkorOxSyhIcTYYcdeu3UFVvJtT7f96t+4QqMR0avBZhPMdA3LhwcvD
         vBxYWusoWIWAeFpai+IOsBz85ZBMsR1z/HNDWgpEV5H48ihr5ErpRDpKClv6i5Tmv8Bx
         nSBVTb1bUuui/tORCi6I4C+namIzh1E7c+QjFbIso1v8TCIkEgx0k4+YSkbg1mqEtnbY
         qP2HK4Vr8EbHf/1AWN8BYAOqjErqoO7GVT69A7kqqa0QfpRRrihl54QHwqORL3YPdtLv
         MIZA==
X-Gm-Message-State: AOJu0YzGanSyyB/jD1kIgxEmdkrEa+icIyCLASbbrLlk+lkf7bEh9Gea
        WVJLkc2DH42WpWg72Hjgwi3Ovy+DUo0HecqYsQ8=
X-Google-Smtp-Source: AGHT+IHvsE0u2jtEjXnhMBmdfrInIMp2SgRhm3O6etKbIOM9cTHyQjMpPOT4GNx3cIxDcZSUH1zWBg==
X-Received: by 2002:a19:644f:0:b0:501:bee7:487b with SMTP id b15-20020a19644f000000b00501bee7487bmr10092366lfj.11.1696318782149;
        Tue, 03 Oct 2023 00:39:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d6843000000b003143867d2ebsm889516wrw.63.2023.10.03.00.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:39:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()
Date:   Tue,  3 Oct 2023 09:39:26 +0200
Message-Id: <20231003073926.10771-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

pinctrl_gpio_set_config() expects the GPIO number from the global GPIO
numberspace, not the controller-relative offset, which needs to be added
to the chip base.

Fixes: 5ae4cb94b313 ("gpio: aspeed: Add debounce support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index da33bbbdacb9..58f107194fda 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -973,7 +973,7 @@ static int aspeed_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	else if (param == PIN_CONFIG_BIAS_DISABLE ||
 			param == PIN_CONFIG_BIAS_PULL_DOWN ||
 			param == PIN_CONFIG_DRIVE_STRENGTH)
-		return pinctrl_gpio_set_config(offset, config);
+		return pinctrl_gpio_set_config(chip->base + offset, config);
 	else if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN ||
 			param == PIN_CONFIG_DRIVE_OPEN_SOURCE)
 		/* Return -ENOTSUPP to trigger emulation, as per datasheet */
-- 
2.39.2

