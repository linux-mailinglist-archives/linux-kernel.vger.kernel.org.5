Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE97A7434
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjITHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITHdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:33:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB855CE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:32:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso129398066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695195177; x=1695799977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYrvQbB0FGaR2TMUy/U/vm4+WSiYScO9+N5v6KBchuQ=;
        b=KyREYUWECj3Z3ZaSBcaCno4kMnCH+FoyB3F+tjhrBOV47Cgd5d+ncxxjKQc/eHMGlh
         NVNF8KWyyf2dsMzOIlsdw97BcRvU//NUosTjIzvw77RJYSSeiv5e4mqOBnkXEfnNNrLb
         3vWH97fvIcBLuCbJSuHgJ3qNb4yEb53xouxCXWLPiftIeGsUKFwq/jgY3DX11JdZdh3E
         XKIxHQR55UnVdMQHSuEMI0YMjAzEe5hLv7S1c3LpisGuJXtI2iPcuydo3OnMoY98Klfu
         duuBxfl5bSiTXyxqFimbXC4FGaOxLRqlPoiFWU4Pc5nFkcqb/ZF/oueI0e14k1xW1K7M
         0qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195177; x=1695799977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYrvQbB0FGaR2TMUy/U/vm4+WSiYScO9+N5v6KBchuQ=;
        b=nSKGJfrQuLws2rriLtH6BTnlJbwRjf6gLktEIuJJdLDbMMAyuE3ff+Ynl0ZIXhtCGI
         V/lrAh0PThFpGq6Kxb7Pv/Jq/mjiXQlqxn9vOZRYjFTnIOViWXQ8UnzN5wfOuaJyW1Y9
         8SD7mDvgL88MKSwvZrLTwUJdHpaUq5Pttf7lSrpSxhK5ecHVzyHzgOKyB8lREcTnCI+3
         F9d3+gxslHKe8pz6fFauBZfprm739MPK6Xwh9S7o7tLHyJfpmLGG+kURm5kdT6l38GDq
         FLB0aEojw+f4n7ZcUHpIc89xviR4eDQmMj1Hw/w77hW8gCl5YfkTO1jy0akEPG4MhEzD
         AyGg==
X-Gm-Message-State: AOJu0YzP1vodo7xdgmxWBiUmt7yQxiDnXDDEh8NOpdhFbo3T1bDhiHdI
        4m1qTGaeE72FcKS+fkEljQIN8w==
X-Google-Smtp-Source: AGHT+IEvhe9pe7VdZSVff4gaCxhLQJggy4NQX7Vf2TOirfbE1fFyTlC1aU0PsDzOCSFOLtx7UXvBYA==
X-Received: by 2002:a17:907:3ad1:b0:9ae:513f:a4f3 with SMTP id fi17-20020a1709073ad100b009ae513fa4f3mr196156ejc.32.1695195177081;
        Wed, 20 Sep 2023 00:32:57 -0700 (PDT)
Received: from brgl-uxlite.. (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709064a9a00b009a13fdc139fsm8819453eju.183.2023.09.20.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:32:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5] gpio: sim: fix an invalid __free() usage
Date:   Wed, 20 Sep 2023 09:32:53 +0200
Message-Id: <20230920073253.51742-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

gpio_sim_make_line_names() returns NULL or ERR_PTR() so we must not use
__free(kfree) on the returned address. Split this function into two, one
that determines the size of the "gpio-line-names" array to allocate and
one that actually sets the names at correct offsets. The allocation and
assignment of the managed pointer happens in between.

Fixes: 3faf89f27aab ("gpio: sim: simplify code with cleanup helpers")
Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Closes: https://lore.kernel.org/all/07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Hopefully this is the last version of this patch. I restored the max()
assignment from v3 but kept the code simpler than v2. Tested most corner
cases that occurred to me.

v4 -> v5:
- restore checking for the higher offset in each iteration when counting
  named lines

v3 -> v4:
- simplify the line counting logic

v2 -> v3:
- restore the offset out-of-bounds checks

v1 -> v2:
- split the line name setting into two parts

 drivers/gpio/gpio-sim.c | 60 ++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 460389bb8e3f..3b7cdf44eb38 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/list.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -718,52 +719,32 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
 	return sprintf(page, "%c\n", live ? '1' : '0');
 }
 
-static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
-				       unsigned int *line_names_size)
+static unsigned int gpio_sim_get_line_names_size(struct gpio_sim_bank *bank)
 {
-	unsigned int max_offset = 0;
-	bool has_line_names = false;
 	struct gpio_sim_line *line;
-	char **line_names;
+	unsigned int size = 0;
 
 	list_for_each_entry(line, &bank->line_list, siblings) {
-		if (line->offset >= bank->num_lines)
+		if (!line->name || (line->offset >= bank->num_lines))
 			continue;
 
-		if (line->name) {
-			if (line->offset > max_offset)
-				max_offset = line->offset;
-
-			/*
-			 * max_offset can stay at 0 so it's not an indicator
-			 * of whether line names were configured at all.
-			 */
-			has_line_names = true;
-		}
+		size = max(size, line->offset + 1);
 	}
 
-	if (!has_line_names)
-		/*
-		 * This is not an error - NULL means, there are no line
-		 * names configured.
-		 */
-		return NULL;
-
-	*line_names_size = max_offset + 1;
+	return size;
+}
 
-	line_names = kcalloc(*line_names_size, sizeof(*line_names), GFP_KERNEL);
-	if (!line_names)
-		return ERR_PTR(-ENOMEM);
+static void
+gpio_sim_set_line_names(struct gpio_sim_bank *bank, char **line_names)
+{
+	struct gpio_sim_line *line;
 
 	list_for_each_entry(line, &bank->line_list, siblings) {
-		if (line->offset >= bank->num_lines)
+		if (!line->name || (line->offset >= bank->num_lines))
 			continue;
 
-		if (line->name && (line->offset <= max_offset))
-			line_names[line->offset] = line->name;
+		line_names[line->offset] = line->name;
 	}
-
-	return line_names;
 }
 
 static void gpio_sim_remove_hogs(struct gpio_sim_device *dev)
@@ -867,7 +848,7 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 			  struct fwnode_handle *parent)
 {
 	struct property_entry properties[GPIO_SIM_PROP_MAX];
-	unsigned int prop_idx = 0, line_names_size = 0;
+	unsigned int prop_idx = 0, line_names_size;
 	char **line_names __free(kfree) = NULL;
 
 	memset(properties, 0, sizeof(properties));
@@ -878,14 +859,19 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 		properties[prop_idx++] = PROPERTY_ENTRY_STRING("gpio-sim,label",
 							       bank->label);
 
-	line_names = gpio_sim_make_line_names(bank, &line_names_size);
-	if (IS_ERR(line_names))
-		return ERR_CAST(line_names);
+	line_names_size = gpio_sim_get_line_names_size(bank);
+	if (line_names_size) {
+		line_names = kcalloc(line_names_size, sizeof(*line_names),
+				     GFP_KERNEL);
+		if (!line_names)
+			return ERR_PTR(-ENOMEM);
+
+		gpio_sim_set_line_names(bank, line_names);
 
-	if (line_names)
 		properties[prop_idx++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
 						"gpio-line-names",
 						line_names, line_names_size);
+	}
 
 	return fwnode_create_software_node(properties, parent);
 }
-- 
2.39.2

