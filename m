Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAD79CABA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjILI4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjILI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:56:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1610CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401b5516104so56635105e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694508962; x=1695113762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxpXhgDL+WYT4ZjQ7cMsLe1CH/MZvqWCA7Gdeim4PCs=;
        b=1dN+zwd9sbyJaqZbbt41SfLR3ySrf4k5uG/AxWM19SHvTAFGUJ7eZCF1EhwG01ydvj
         BiHujRgbK4saG4AdA1jSFbIEsjA1sDR1UxWzLqCgQ/wMMqWhStXpiw3brRdTPEZjRHcz
         74wNypnZVqRHQoUwhj2lQrf1JThLBWzqidFHOik9/BvFrOPuY5sFpgA5uBFXjqJD9B58
         kppSpnpHqP4KwyU/ze1sQsvFsWU/u5mxgoDOsaDF9HNNTFpDJ3MZgW6LULmzYqM2an3a
         xVt1ZzbPFGvxMgqvR2tVGSrgPQ7iLj08xzXjZTMrEC9pLbrkH6hmTS8xaEMa9+XMJ27P
         UmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508962; x=1695113762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxpXhgDL+WYT4ZjQ7cMsLe1CH/MZvqWCA7Gdeim4PCs=;
        b=CmJsEC+XVA/edME1Znrt0XaY1LE/kJ/P/abi/eH/XcWrJqCk2MqLNwf33pe0gTRQzG
         iS9zFdFRhEdUfZEomoZ4GGVGK2aHtEpSjYJyARwyWQ72tbDo+13OH+VPsL2Lcjj69PYG
         RLKXX+t7rtT1l9APAfJmUWMxyMKSpyaAgr/AUEG+zFHh7d2RGvR8iYIrOPo5xedVg/M9
         FLKjljYa5EOWwmmZRMX7HJDTs6jFk4WabFWZ4L+cNP7zQBkTi3dsNdQXLYyP3hEmIflg
         KCqXMKYXhs8xMJK25ObBmtTTOGHMq3dmpCO2G268dr9MFE6HnAQPYN1O7ccnKK8jAfkp
         3M7w==
X-Gm-Message-State: AOJu0YxlhGad3Oxx2h/7UyFuGq5cg61Jhsu8KW8a/wM3DfM0b4uFMN9D
        0QJZpYXqHjfO2nNsvebbZdymuQ==
X-Google-Smtp-Source: AGHT+IHwVYNadCpGQMP7winv93kpz4rGjYqP/F+H8Bl7Z5RwaFYy/5WX+GP4G96mrTKE18ljwclUiQ==
X-Received: by 2002:a05:6000:180b:b0:31a:d450:c513 with SMTP id m11-20020a056000180b00b0031ad450c513mr10252463wrh.26.1694508962038;
        Tue, 12 Sep 2023 01:56:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b00317ddccb0d1sm12310028wro.24.2023.09.12.01.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:56:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/4] genirq/irq_sim: order headers alphabetically
Date:   Tue, 12 Sep 2023 10:55:40 +0200
Message-Id: <20230912085541.13682-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912085541.13682-1-brgl@bgdev.pl>
References: <20230912085541.13682-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and maintenance keep headers in alphabetical
order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index f5ebb3ba6f9a..b0d50b48dbd1 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,10 +4,10 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
-#include <linux/interrupt.h>
 #include <linux/slab.h>
 
 struct irq_sim_work_ctx {
-- 
2.39.2

