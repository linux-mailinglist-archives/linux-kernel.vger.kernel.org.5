Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A947EC915
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjKOQuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjKOQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:50:10 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C71AE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:07 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d264e67d8so39424766d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700067006; x=1700671806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBzGno4D43Ros4hSmP6lFXf2RSbEodgJworHzjxav/U=;
        b=vPjtHPlX9qo45SMY2An0s5cvFgsnc/DPWwwA2fJ1H699LAhLmFqvN9ZREOmfxJEvD6
         lIYshiSUIIGnk4L4x+OoukIqcMQPcet+NYQCIdEmvY2mMeiQVEFiV0+97QEJ4x9lhwUH
         G3vKgtovD8Zz9P6M4GmiQXbsdA/e+ypyxY5Zb1Nb0TLmEtB9W1GFf9qYF4ZpnVFq/epP
         fXxi3XogmlqY3hkw3QB8Gx+hdQan9R96g1hlPcWC5r456nDMlEweg3a0cOm6KAHO6GZ0
         XENGoI0ms6MXbfB9H1LFfCisZfY2vq1y/n3rJLwOQXP8B54VDgsGIOX7gfgG3Ngub1uP
         l3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067006; x=1700671806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBzGno4D43Ros4hSmP6lFXf2RSbEodgJworHzjxav/U=;
        b=B40A+I1pLmkgGEAezhDmpS0atEgN2tWwfo+5h1xOOZLIbsL0xR0FS/PNsH4TuSQPI/
         6AYr7c+nBguuFXVLx47Tg39dGBCG2Iwf8xIWkIE3OesAoazjkeH3IL9yAuPvS/1LcU9E
         fqB5NY5Uxr5MhHN1CfLUzLQ1SN+HveA/84z7TKD60rQrwuvNcegkfaiYX5OKHRt8pFBt
         8XTb3p9C7M+7TKrBL5fzVYbLjZDZwN6TSwG1xNnscn9mMKku1vepIYOy3a7Lu2CmAsYv
         HT3lln1VtcJeGnmSubmeA2kCm29saUJiP8uiPpzYzaz4R2FUE/2K201woPiOxSAYRLGk
         BkBQ==
X-Gm-Message-State: AOJu0YyjnHYulnFcwtQeU4J8OekG564JgzS8dP/RRi4mFzow/TuiIwi+
        1MXw2Abo4nZm+Gn5/BSTyBB+2g==
X-Google-Smtp-Source: AGHT+IFRu8UzuC2/0PimlUZ+XtnZn4xYNBiel6D8QAFpK0dkZkTmuT6QrPD8tNJRmUck9qf84yYvwA==
X-Received: by 2002:a05:6214:5497:b0:677:a1d5:4331 with SMTP id lg23-20020a056214549700b00677a1d54331mr6464857qvb.33.1700067006554;
        Wed, 15 Nov 2023 08:50:06 -0800 (PST)
Received: from brgl-uxlite.. ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id mn16-20020a0562145ed000b00670a8921170sm658781qvb.112.2023.11.15.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:50:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] pinctrl: don't include GPIOLIB private header
Date:   Wed, 15 Nov 2023 17:50:01 +0100
Message-Id: <20231115165001.2932350-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231115165001.2932350-1-brgl@bgdev.pl>
References: <20231115165001.2932350-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpio_to_desc() is declared in linux/gpio.h so there's no need to include
gpiolib.h directly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 0b4d07aea387..e55959e1af5a 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
+#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 
 #include <linux/pinctrl/consumer.h>
@@ -31,10 +32,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 
-#ifdef CONFIG_GPIOLIB
-#include "../gpio/gpiolib.h"
-#endif
-
 #include "core.h"
 #include "devicetree.h"
 #include "pinconf.h"
-- 
2.40.1

