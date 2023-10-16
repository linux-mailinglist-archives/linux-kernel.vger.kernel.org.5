Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CCC7CADE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJPPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjJPPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:43:28 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE4F3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:43:26 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57ba5f05395so2872931eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697471006; x=1698075806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlKED5cDX4/M6RtMRhnbbTpnZitsZnGbgslw3+b0ID8=;
        b=XU6B6WGnnCr97JXcgd85B4yek2KrTx6NX62lt8duS2SfwRKSWvK1yADhalunxrUYrf
         aelpDPzWibRDhdqo7Ul8+QzKv2c65aEbw1brhulyRTP4eBKYVauZ9AvwbUCKa7V80ier
         gIO5CjkGJlKvXpTsVrE33cQvLDbkrS30qOFjwSnUyGwf5Bc2L7nz6YT8GKHQSVOG0Dv1
         9qM4wCpXCgV9LN5uiamgqrNYekLdHxrX3xGyoZRVKyzBK0yhxjvDrKU6uz2PBtVXWjOl
         8VtYqKZMaTdJl41LnaHiZ5u3lknO4K1i+aYhWcJEqO4Bbq0l7g3v1V+sy6QDZ08wlg9W
         3hAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471006; x=1698075806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlKED5cDX4/M6RtMRhnbbTpnZitsZnGbgslw3+b0ID8=;
        b=VWGZhGT/7t+K0ngDDvnZ4PACLCcOFSGwslh1GbRo8uV2VpktqD3/8LB7RZl2bXlE4G
         Ui+xUFmBFlgl//wsKtuCEmEx4QPueM6JZy9JplpsiObwd4yzdhRcBsjHq9RVAcxUm1m9
         EALP11WBuCh+foAU1EfI2JO3B9Z3mgkTy1XNhDveo3J8ftGeh3jdtsWZza3z98FLalas
         yMEN+rCHc0ta+6YQ3MsWWhJvTqQFgckZd+jag0zKQoKRyy0UYvxMiaeUa6Jzup9RC1Q/
         gPoLPVhu3aq3RdCXWzs/VrmfXHtSYSMonMWPIuUKs08PLZ+CMrjjerxl7F8S+diCA9U2
         9VHw==
X-Gm-Message-State: AOJu0Yw1LVGza+uZIxoQ50smMZYNOXHo89ZiFAE9u6VnoFm4lQ8OYGUl
        voaKzElv7I2V93uumgc6cPLZr1PQDAFl0l2UN71ogw==
X-Google-Smtp-Source: AGHT+IHgf0crmnnbH2S+hBlp+z4v3au1y/pafgssxZtwQGZp3PMuDIsa+dColbvineFADD3dOo2nXA==
X-Received: by 2002:a4a:3009:0:b0:57b:92f2:1f64 with SMTP id q9-20020a4a3009000000b0057b92f21f64mr36167216oof.8.1697471005822;
        Mon, 16 Oct 2023 08:43:25 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id w18-20020a4ad032000000b0057327cecdd8sm1122632oor.10.2023.10.16.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:43:25 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: resolver: ad2s1210: add reset gpio support
Date:   Mon, 16 Oct 2023 10:43:09 -0500
Message-ID: <20231016154311.38547-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the optional reset gpio to the ad2s1210 resolver
driver. If the gpio is present in the device tree, it is toggled during
driver probe before the reset of the device initialization. As per the
devicetree bindings, it is expected for the gpio to configured as active
low.

Suggested-by: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/resolver/ad2s1210.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index 8646389ec88d..a414eef12e5e 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1426,6 +1426,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
 	struct gpio_descs *resolution_gpios;
+	struct gpio_desc *reset_gpio;
 	DECLARE_BITMAP(bitmap, 2);
 	int ret;
 
@@ -1481,6 +1482,17 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 					     "failed to set resolution gpios\n");
 	}
 
+	/* If the optional reset GPIO is present, toggle it to do a hard reset. */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "failed to request reset GPIO\n");
+
+	if (reset_gpio) {
+		udelay(10);
+		gpiod_set_value(reset_gpio, 0);
+	}
+
 	return 0;
 }
 
-- 
2.42.0

