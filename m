Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE197C5393
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbjJKMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjJKMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:20:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33612C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4066241289bso63791895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026187; x=1697630987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1TfGq9ZUTHjJHsNkCdZo3V3ZE8dSm/Gv302pfRQaqA=;
        b=eTfCMhyDUcQLjBLy+jSp2B5rBlewXmVneO9QPMu1GvTK3jUhamVCGHTa8WAmGC4oYw
         RDI8nZ7qJVgHN5d8JhJznilTxrZLIgBOX5ow3Ezp2mVUlAgXNMyfKeeF25YgP4lJhjxH
         g3gXLQxRjSE1ANX0w6ZgFxHEQD79RvCeULl6bsfAOgHA3yaylm8+8v1yLrjcGen4YpOc
         sfCOirtNzw/WMPJWQ9eAVxBetAmheyp9lyAUNaH6X6Lb3i1Z5nVUkCWk8muwcs0w9YCG
         PT9gtepLCZNAfHVP+5/HjJHSN3KFIAKP7FyIaYGujY6Z17GCVATakDco1Oj6Nd5NNMQe
         5h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026187; x=1697630987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1TfGq9ZUTHjJHsNkCdZo3V3ZE8dSm/Gv302pfRQaqA=;
        b=GKn2eAfX3Wzy+W1GTZpnAL6DkfEaUpPHOZdSlGDOmlnrpljtIYJxBEM8NwCpdbYeBT
         jSlsSRw/vX8dTUGK9zNWuybJzM/UGGZDjL8pcXTxIibBi302S9ij3ETOWLlQ+DemovKa
         wkyRBoXarkQru3cRClXBHaR9LbQtFTCnjdlmf9du81YFCR0J01+BDDaYzAuZYybk6U8K
         MtJszu1p1ZoaZKy66i/yPN0lRgKEKmFmsQFs0O019sQgAYgpD1/oThk9hgT/0k8Mo3TS
         EtawJCzPT3piNQtx22n9PPxZhkrcogZOvpiJyDl+78eh08BhO8N1mq+gYCMAlEjLicBc
         5uaA==
X-Gm-Message-State: AOJu0YxbmCatjnmdkHQMAqa/JALoXA6z4nFqVXlj52rm+BekPqSZOEFD
        HuQSqvTmmqtDSErfL1slYMCJTA==
X-Google-Smtp-Source: AGHT+IGmmRYlRS77pWXSdEKmBXTYA9CFLs9xBAXETYvcReLzr8ebHqpBGdeY3RShIedVYqAO4OYy9w==
X-Received: by 2002:a05:600c:2218:b0:3f7:cb42:fa28 with SMTP id z24-20020a05600c221800b003f7cb42fa28mr17715760wml.28.1697026187109;
        Wed, 11 Oct 2023 05:09:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 43/62] pinctrl: change the signature of pinctrl_get_device_gpio_range()
Date:   Wed, 11 Oct 2023 14:08:11 +0200
Message-Id: <20231011120830.49324-44-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Modify pinctrl_get_device_gpio_range() to be in line with public GPIO
helpers and take a pair of GPIO chip & offset as arguments.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 24cc075044e9..2eebd86ca2bc 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -372,7 +372,8 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio) { return true; }
 
 /**
  * pinctrl_get_device_gpio_range() - find device for GPIO range
- * @gpio: the pin to locate the pin controller for
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  * @outdev: the pin control device if found
  * @outrange: the GPIO range if found
  *
@@ -381,7 +382,8 @@ static bool pinctrl_ready_for_gpio_range(unsigned gpio) { return true; }
  * -EPROBE_DEFER if the GPIO range could not be found in any device since it
  * may still have not been registered.
  */
-static int pinctrl_get_device_gpio_range(unsigned gpio,
+static int pinctrl_get_device_gpio_range(struct gpio_chip *gc,
+					 unsigned int offset,
 					 struct pinctrl_dev **outdev,
 					 struct pinctrl_gpio_range **outrange)
 {
@@ -393,7 +395,7 @@ static int pinctrl_get_device_gpio_range(unsigned gpio,
 	list_for_each_entry(pctldev, &pinctrldev_list, node) {
 		struct pinctrl_gpio_range *range;
 
-		range = pinctrl_match_gpio_range(pctldev, gpio);
+		range = pinctrl_match_gpio_range(pctldev, gc->base + offset);
 		if (range) {
 			*outdev = pctldev;
 			*outrange = range;
@@ -767,7 +769,7 @@ bool pinctrl_gpio_can_use_line(struct gpio_chip *gc, unsigned int offset)
 	 * we're probably dealing with GPIO driver
 	 * without a backing pin controller - bail out.
 	 */
-	if (pinctrl_get_device_gpio_range(gc->base + offset, &pctldev, &range))
+	if (pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range))
 		return true;
 
 	mutex_lock(&pctldev->mutex);
@@ -798,8 +800,7 @@ int pinctrl_gpio_request(struct gpio_chip *gc, unsigned int offset)
 	struct pinctrl_dev *pctldev;
 	int ret, pin;
 
-	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
-					    &range);
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
 	if (ret) {
 		if (pinctrl_ready_for_gpio_range(gc->base + offset))
 			ret = 0;
@@ -834,8 +835,7 @@ void pinctrl_gpio_free(struct gpio_chip *gc, unsigned int offset)
 	struct pinctrl_dev *pctldev;
 	int ret, pin;
 
-	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
-					    &range);
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
 	if (ret)
 		return;
 
@@ -858,8 +858,7 @@ static int pinctrl_gpio_direction(struct gpio_chip *gc, unsigned int offset,
 	int ret;
 	int pin;
 
-	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
-					    &range);
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
 	if (ret) {
 		return ret;
 	}
@@ -923,8 +922,7 @@ int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 	struct pinctrl_dev *pctldev;
 	int ret, pin;
 
-	ret = pinctrl_get_device_gpio_range(gc->base + offset, &pctldev,
-					    &range);
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
 	if (ret)
 		return ret;
 
-- 
2.39.2

