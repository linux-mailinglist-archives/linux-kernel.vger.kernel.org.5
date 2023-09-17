Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE25B7A34DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjIQJNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 05:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjIQJMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 05:12:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D118C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:12:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso40381335e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 02:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694941956; x=1695546756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MJIm7l05TNgBD7fIZpFbmCq3yhWvKvp7t4WFx7t1Es=;
        b=YUxwIP+gcHNUi8WcBPft7GNx27/mR/hARGdlGtX7kN023f4/tuJtgWgoYllFPnTsKe
         H/hnJsOOtWjt6aTwig3N2zP2ZxPU2H27goXfLI5nq/G+YgCXt0686/1F1ZGcY0f5PTp5
         RNMjcIRYl98ETI1YJn/WtiHDKI6K6dB9p/rUqsHmFq02Ob+qZTzg4R/3gEAHOtDLmuKC
         nCEXHtxhKFxWgX0BuqVJd6dqOQbngnLlVZDwELCC4B1+7gFMHAa91yfrwLsWRuZZO7r8
         nlea19n4zOak2Jeu37XMy09FphF4UZ6B5AGHQvT1OAb3Nzq9+YIWm7AbPyZiHfzI5xfc
         ZzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694941956; x=1695546756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MJIm7l05TNgBD7fIZpFbmCq3yhWvKvp7t4WFx7t1Es=;
        b=A3njAZ9rIrXtWO8A2zTMny2EYBq95a0ngBX77pIEMeDfW6oafPL6tfnz2Ab169rPNd
         /oYsHIZBnLEekETjS6YitV9CVWb+WfuOCb+KyCq5Nvw0GYfFs6xsacWUnc+w0AXSQo83
         vyXT7qKceK3vfZM6G0uUdk25f5bUPC4zdqneyM4nqqlnoSpmNM1SgrvIyfmZsHYCkfu+
         Ve9OvRG7pXJ1V2yZXv6jkZ8NPGGN81hDQx2YAz/CggP2RJ8sPDzG0qap6nK4O2PlDQxb
         tmdskIcTFOGWqltUsT5dSJavGtkyZRrWGGmGYEraV8WwWFiBsZIkmp0/I89GD+5ZlD1d
         LZSw==
X-Gm-Message-State: AOJu0Yw1U3kKUwxfVwamtu04YsktWMIQh4YhhOQff9185lOrJVI4X+hQ
        Iz224/SL2yaDhSMu6zuY8y7qww==
X-Google-Smtp-Source: AGHT+IGAzYBRWtRh8FD1NMvO0VUhIN/uPXY3sGJSVtlZXag/NLl3mQhQx0seam4ZuE7J2+JEj+n7bQ==
X-Received: by 2002:a5d:6dcd:0:b0:317:6a7c:6e07 with SMTP id d13-20020a5d6dcd000000b003176a7c6e07mr4214828wrz.32.1694941955766;
        Sun, 17 Sep 2023 02:12:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4ea0:9945:6800:8739])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0031ad2f9269dsm9099688wrt.40.2023.09.17.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 02:12:35 -0700 (PDT)
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
Subject: [PATCH v3 1/2] gpio: sim: fix an invalid __free() usage
Date:   Sun, 17 Sep 2023 11:12:24 +0200
Message-Id: <20230917091225.6350-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230917091225.6350-1-brgl@bgdev.pl>
References: <20230917091225.6350-1-brgl@bgdev.pl>
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
 drivers/gpio/gpio-sim.c | 64 +++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 59cba5b5f54a..7d52f7caa1c7 100644
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
@@ -718,52 +719,42 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
 	return sprintf(page, "%c\n", live ? '1' : '0');
 }
 
-static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
-				       unsigned int *line_names_size)
+static unsigned int gpio_sim_get_line_names_size(struct gpio_sim_bank *bank)
 {
 	unsigned int max_offset = 0;
 	bool has_line_names = false;
 	struct gpio_sim_line *line;
-	char **line_names;
 
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
+		has_line_names = true;
+		max_offset = max(line->offset, max_offset);
 	}
 
-	if (!has_line_names)
-		/*
-		 * This is not an error - NULL means, there are no line
-		 * names configured.
-		 */
-		return NULL;
+	/*
+	 * It's possible that only the line at offset 0 has a name in which
+	 * case max_offset will be 0 but we still want to allocate an array
+	 * of size 1.
+	 */
+	if (has_line_names)
+		max_offset++;
 
-	*line_names_size = max_offset + 1;
+	return max_offset;
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
@@ -867,7 +858,7 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 			  struct fwnode_handle *parent)
 {
 	struct property_entry properties[GPIO_SIM_PROP_MAX];
-	unsigned int prop_idx = 0, line_names_size = 0;
+	unsigned int prop_idx = 0, line_names_size;
 	char **line_names __free(kfree) = NULL;
 
 	memset(properties, 0, sizeof(properties));
@@ -878,14 +869,19 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
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

