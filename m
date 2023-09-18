Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C27A4EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbjIRPYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239986AbjIRPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:24:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3411992
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:21:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5310aec4121so1576225a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695050476; x=1695655276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+kdSJ4sQ1S01UdF8CEB51WLv93rf0qpn38b7uekeAw=;
        b=ZC8yjZqdh5fa1uyOULW90//iZVc6cI8y6UDlt09RsVDy+MCJ4ADv4XRjf7+rVB7vBE
         UtFQpsxEeNzQUDTwOdqXFEZYJ/XVfimQGWCbp6tewQp6g63A1mj3flZTtEN0MNQy9Voa
         jnPp+xZ32G0t2m1ScYtM/53M4IXjbPTplAL8uLBJaKMBFhuRjS+YauaIHeBJEp74xzT6
         1bDDV3YmCwSQZ/OumNtQFQlzML541VtSuylNx/sZCOHQHba2xCkeiuWFQCBxy9XPq5y5
         qxoGsfNLNjTTQuuXLZqMkOxqvWs/lrGcJ6Xx9WrbF73mcqT6rAO9Wo9cPuDqDo/Pdw/K
         xltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050476; x=1695655276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+kdSJ4sQ1S01UdF8CEB51WLv93rf0qpn38b7uekeAw=;
        b=biAqOUPWyGilhh4vPCBwFgahGndw17CnqV5tY+eRq0HAbqc1wO2TzcIkDoaku61wY1
         cuP5lM9RJnsd51Mjgt8VAh8Bl8VcYhTBBlfW1uw1VPdiJQpR6uoYibT6ygD57mQiU22b
         9xXdVnOSaBPO9VoQCMRo56CS8MsC7TZjaozSl5VZ4KLq9dqFTR28zNosdQuRevRqnJMA
         KCiwlIRw+3xrl0PErhCtjXGuhcRm0Q6J/JmgkFe4cGxjfL9yQ0O+BDTV2RpskhOzhhHG
         6jxCko9Zpt1U/S1suq9mp77X0NFHRRejPuMtPk9aKL/CZSWAqcxrjpnAlzYY/sVYYm6T
         tNcg==
X-Gm-Message-State: AOJu0Yzs+kqVd7dCwKf8fWNiVzmgBg6eHQRRq0Mmg3xkObqaxwmfGWki
        Yplkhv/C9HtlNzKTWkS5DM/uJSN1NLGyk1A+d6U=
X-Google-Smtp-Source: AGHT+IE+mKlomEDK+2JFy6MEL88/jRlHFUbeM6YI6GKmBoXZsEayExX5oVZd6W3v8KrY4sWjwDjJ/Q==
X-Received: by 2002:adf:d208:0:b0:320:4d1:d5f3 with SMTP id j8-20020adfd208000000b0032004d1d5f3mr5306035wrh.6.1695048938243;
        Mon, 18 Sep 2023 07:55:38 -0700 (PDT)
Received: from brgl-uxlite.nice.aeroport.fr ([193.57.185.11])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b0031c5dda3aedsm12995208wrs.95.2023.09.18.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:55:37 -0700 (PDT)
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
Subject: [PATCH v4] gpio: sim: fix an invalid __free() usage
Date:   Mon, 18 Sep 2023 16:55:33 +0200
Message-Id: <20230918145533.14642-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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
Linus,

I followed the pattern for determining the size of the line-names array
from your patch in the end but with a changed variable naming. If this is
fine, I'll queue it for fixes for the next rc.

Bart

v3 -> v4:
- simplify the line counting logic

v2 -> v3:
- restore the offset out-of-bounds checks

v1 -> v2:
- split the line name setting into two parts

 drivers/gpio/gpio-sim.c | 59 +++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 460389bb8e3f..b66abb55ef4d 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -718,52 +718,32 @@ gpio_sim_device_config_live_show(struct config_item *item, char *page)
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
+		size = line->offset + 1;
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
@@ -867,7 +847,7 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
 			  struct fwnode_handle *parent)
 {
 	struct property_entry properties[GPIO_SIM_PROP_MAX];
-	unsigned int prop_idx = 0, line_names_size = 0;
+	unsigned int prop_idx = 0, line_names_size;
 	char **line_names __free(kfree) = NULL;
 
 	memset(properties, 0, sizeof(properties));
@@ -878,14 +858,19 @@ gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
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

