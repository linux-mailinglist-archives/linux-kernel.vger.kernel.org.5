Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A791779087
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjHKNOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHKNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:14:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC5270F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:14:32 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbea147034so17332805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691759671; x=1692364471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vS6U9ByOuvwpjOWYK9b5NZuGJIMOD+YNxq8azPqe3fQ=;
        b=IMr+jRP8N25FWJVRdjMffMQQtK3/yI5RHBQJ7cVg1SdZqVwZXwKV9gublQkzhCfsvK
         t50FLIbVdL5JO9zsrwTPbtzmxox7wMldJVkx+IbLtt8yR9y4LOQPa2X982PqKxd2O9re
         Zrr2aed8bQ4CwRChrTkAxFR9ZKLBwzFFiAM67sJxSF9lCdMEAVaD+MaoqJ3bR/4+mXK2
         w7wWbjfWkqfACSgE7SPKpo7Qfy45UVW1aYISVsGJRp5ViebRk/OSW+iktNk4mrLWI+q/
         x7bU7TbHknpEpNy8MNvJ0iT4K6B/id4w6W27ejiPmVAnT0+SMuvPwZDkgkU/XTiXKYXA
         Ar5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759671; x=1692364471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vS6U9ByOuvwpjOWYK9b5NZuGJIMOD+YNxq8azPqe3fQ=;
        b=GqoDWkoMaNLGf05pjKBr9DjECDR5faQTpMvjjpBKZYl4coZJXlzSmfNWNsKCm+aTEi
         xiRE5uUgv/eKs9NTPdkW+hx81DInCTeZ1NbgwKteoBEZhQRJERgyw4DdVxQ5JNIGqxjC
         oH3j0pzmpN/lLwlRh4v11PpFJ+hmTh/2kOxsV+76LDymZ4oWXwAEVFX0AyZXX6qDJVIw
         uue2fxSNbfv0kS1/UX9SuoIQprqF5Yq7bSpB7GAh7K4TtGHeObPc0UJlnquySzCVT0Qg
         qqdraZQLEVIW3eiVQfvBW6c+5jCN1BREeCcERN0s+fNpJuWjcXpYsrBAYgT0qnfQHlyC
         VKsw==
X-Gm-Message-State: AOJu0Yw3z3sK6lOqM7iHFYMKB0zfV/EsU6Fa6skSW2OKPYs4DciW93fT
        ZDaqgbdWcbb8H/JzgXsTbIUAo5zHfsWkQkacpqSrrA==
X-Google-Smtp-Source: AGHT+IEd/H/N8EsyFQrs7K1p6f3J5b3KQas2v727xKUbr2HEDhcCHSJG/ACqw1rF1F+TU68n8OFlnA==
X-Received: by 2002:a5d:6ac9:0:b0:319:62ba:5d08 with SMTP id u9-20020a5d6ac9000000b0031962ba5d08mr687203wrw.33.1691759670685;
        Fri, 11 Aug 2023 06:14:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0f3:773f:e87a:3b82])
        by smtp.gmail.com with ESMTPSA id s2-20020adfecc2000000b0031433443265sm5365969wro.53.2023.08.11.06.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:14:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] gpio: sim: simplify gpio_sim_device_config_live_store()
Date:   Fri, 11 Aug 2023 15:14:26 +0200
Message-Id: <20230811131427.40466-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simplify the logic when checking the current live value against the user
input.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This is the same as what Andy suggested for gpio-consumer. Let's save a
line.

 drivers/gpio/gpio-sim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index dc4097dc0fbc..0177b41e0d72 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -986,8 +986,7 @@ gpio_sim_device_config_live_store(struct config_item *item,
 
 	mutex_lock(&dev->lock);
 
-	if ((!live && !gpio_sim_device_is_live_unlocked(dev)) ||
-	    (live && gpio_sim_device_is_live_unlocked(dev)))
+	if (live == gpio_sim_device_is_live_unlocked(dev))
 		ret = -EPERM;
 	else if (live)
 		ret = gpio_sim_device_activate_unlocked(dev);
-- 
2.39.2

