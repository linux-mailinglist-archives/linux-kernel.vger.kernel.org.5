Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7577FD942
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbjK2OY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjK2OYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:24:21 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD199E1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so48866345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701267866; x=1701872666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7P6Y0m2hGBRRFmWFTt/dmCRHf+pQxLzAw7kKW52hRs=;
        b=fmMbM2XquS3hB1agy/V7FOyts6vnMhNULjoxw3yQIOw30649AXKQNfFdu/Yh9+TYDH
         RSyMOtSvQ9PPxQ78bPtCbWpydycAS5/VouqSBEUpWV8OKHktZsGdzKpd8NwRKd1VBeQH
         0zsj+5mhPk+6aahgwNALOrFbSAYMTD9Ut1MIHUv9U2J8fgEOULgwwN2cImtuxtPsJ+uN
         EeV6BEWkM+GEeSF0ud2cj0n2p/5TxRlOxbbbYQ0PJJgI3coki+so9VXsyKKVEj3crfgw
         r3i+bD3n/rnVa9DyXcLlcvVS3fUlg+YDkARJPjnlz0VQZytJO/SHUkZM1ZVWqChKQ7KT
         kT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267866; x=1701872666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7P6Y0m2hGBRRFmWFTt/dmCRHf+pQxLzAw7kKW52hRs=;
        b=HK474ic5kSy7oxN2Zd343xFjLEJiSr/RRiumPi1x0X9XDQRJnfOfRqnEeAJjCTu5hv
         H6WMtcq8p9pTCnhA/xRb7W2Ig+rYFbwx/ToqI2j7sbhbSgSN080iy7nHEdGmmdgTYnzS
         8MCSeV1HF9g6K3oVQvuizyxIP3BN+0W9jSBlmKtkDBeCF4jJvX7nVhqGIJkizO6J6HZD
         6PAXuOZVhfNfui9XDfts0ncirixcSUWokDPM5H5jauw1k7btoEWfTBLc1ou07SA1+u6W
         d3KmhDXIPxC+igUeGHD+mWVr+wvQ0Rq36U/QvQjJXhjofkgcncKywZACY0FtbqEvK11J
         6rog==
X-Gm-Message-State: AOJu0YzpMieTsbo764yHa+lu33UOPCZx8B1Jf/WJLN/YPzBZtwni8E65
        AIS9pCpXbiCeA3nMX+y4wNFMVA==
X-Google-Smtp-Source: AGHT+IE9BfsGxTjT5b568IE45xWg41xMIwavHOZrpDPhRpbyx+zNNYTDpinUA7Bc7rGGWxcYdxfPjw==
X-Received: by 2002:a05:600c:4f82:b0:40b:2b42:a1c9 with SMTP id n2-20020a05600c4f8200b0040b2b42a1c9mr12880421wmq.23.1701267866421;
        Wed, 29 Nov 2023 06:24:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4520:2f25:4d3a:4adf])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2406848wms.12.2023.11.29.06.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:24:25 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 04/10] gpio: stmpe: use gpiochip_dup_line_label()
Date:   Wed, 29 Nov 2023 15:24:05 +0100
Message-Id: <20231129142411.76863-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129142411.76863-1-brgl@bgdev.pl>
References: <20231129142411.76863-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the new gpiochip_dup_line_label() helper to safely retrieve the
descriptor label.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-stmpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 27cc4da53565..6c5ee81d71b3 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -5,6 +5,7 @@
  * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
  */
 
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -255,7 +256,6 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 {
 	struct stmpe_gpio *stmpe_gpio = gpiochip_get_data(gc);
 	struct stmpe *stmpe = stmpe_gpio->stmpe;
-	const char *label = gpiochip_is_requested(gc, offset);
 	bool val = !!stmpe_gpio_get(gc, offset);
 	u8 bank = offset / 8;
 	u8 dir_reg = stmpe->regs[STMPE_IDX_GPDR_LSB + bank];
@@ -263,6 +263,10 @@ static void stmpe_dbg_show_one(struct seq_file *s,
 	int ret;
 	u8 dir;
 
+	char *label __free(kfree) = gpiochip_dup_line_label(gc, offset);
+	if (IS_ERR(label))
+		return;
+
 	ret = stmpe_reg_read(stmpe, dir_reg);
 	if (ret < 0)
 		return;
-- 
2.40.1

