Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BF379781A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjIGQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjIGQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:41:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A54C25
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:50:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502984f5018so448583e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694101713; x=1694706513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/2YQRFzw6VwClsyr++RExaQTGHU2Q9mZM8LcXjJixY=;
        b=Q1Ys8BI+fn+DqHFP7cdJhDSRWs1iZdjsu5wZMyWV+sEh3jU6cWTrdl9v4qreT1ORsK
         w16Jcbje4k0SH+IExaCGn6BqOUILn57v9NHPCzlr2OgUenmmFXX9lgC4v2JtBDRPdhk/
         nB4kigsUZexfT3EyOshRE8wU7Ua27S//h0FTa7apGCQUMzcOopzwumBHe/9xluETFlhN
         QE7fLruFI0zW6oq7Q0xtNHkx3+NKibplCrHRc6ZziJmAwJl8wVNzmsGvutIcTM4Da/gf
         qOB59IVRsaQsUN9iyzHwzMDUVZmB7u083in32GkhPbm7dgBfaYkPJxDzEpc56hUSDMVa
         eIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101713; x=1694706513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/2YQRFzw6VwClsyr++RExaQTGHU2Q9mZM8LcXjJixY=;
        b=Q16m2GX/5UlpruECyH8v9ACBQVopqAUH9dRH/trFXxxwVB+1CxQXJ2xcPhMyF1jy3t
         bTYXrSuv/cCPbRHcPkb9sYubV4SOhvjlMz83iLeRHElHrdfL5KtLc1gyMKrclwukIQDD
         ojOImrvR9hEkZTaaevsRbZ6EGdcMuMBw576TfgMeni0Rmm0WZMErW3MVAmR5w0MI+HB9
         dW/KgQgVtkOS+AFCbJMJXZZZyczpF8ISUJnBMFStrpBaps5JTtX/FhluwzRAuULy1zKT
         1jGPjsnHHsY82QA5tbq7cEhsWQwT9YEPGXw48FbmtYEwl1pNjPNSjHUpbUCSfrEmEexh
         Vt0w==
X-Gm-Message-State: AOJu0YxNXJp2co19kPohSXnz3OK5TEy0O8jpkNflanuB6J32QjZqhyiB
        7P8aS33Ox9Cy/PuOv0WoOOZs5UobAp5Wq4DCx3w=
X-Google-Smtp-Source: AGHT+IFNnMZUCfIg0VmYtVkkHWQ56jupSQhxmu9VyxODnOTBsDUjstLbANCvb1NNvJCUxIP8YGRitw==
X-Received: by 2002:a7b:ce94:0:b0:401:b204:3b85 with SMTP id q20-20020a7bce94000000b00401b2043b85mr5110118wmj.36.1694098354840;
        Thu, 07 Sep 2023 07:52:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:56f5:e2d4:1e04:b28e])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c020200b003feef82bbefsm2757588wmi.29.2023.09.07.07.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 07:52:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/5] gpio: mockup: deprecate the old testing module
Date:   Thu,  7 Sep 2023 16:52:28 +0200
Message-Id: <20230907145230.44085-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907145230.44085-1-brgl@bgdev.pl>
References: <20230907145230.44085-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have a much better alternative to the clunky old gpio-mockup. Don't
remove it just yet (there are tests depending on it out there) but make
Kconfig say that it should no longer be used in new projects.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 673bafb8be58..913948876c93 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1790,9 +1790,11 @@ config GPIO_LATCH
 	  connected to other GPIOs.
 
 config GPIO_MOCKUP
-	tristate "GPIO Testing Driver"
+	tristate "GPIO Testing Driver (DEPRECATED)"
 	select IRQ_SIM
 	help
+	  This module is DEPRECATED. Please consider using gpio-sim instead.
+
 	  This enables GPIO Testing driver, which provides a way to test GPIO
 	  subsystem through sysfs (or char device) and debugfs.
 	  User could use it through the script in
-- 
2.39.2

