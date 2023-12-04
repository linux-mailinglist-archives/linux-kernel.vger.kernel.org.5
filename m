Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32342802EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjLDJgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjLDJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:35:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954B418F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:35:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b595bf5d2so43876615e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701682522; x=1702287322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ4oN2yBzcOb1+JXtPZKrl0tpOl2eK1zlq9JfJmTld4=;
        b=2XtL2CigwSKmszxqX7TLCepiNZc1A/RDwZbLaBV1rSI2CGaZUoZhUGD+2dzckphruv
         TyB3s640VALGZqTnYbnBFPIdMfMjtcu2E5mgdCnC35ynuyTHQ+JShEN3s6PE6ehJwpPf
         4IL5ZveCjhFnXxTt4EcW66bGeQUOuukcBI9Ylwn+tZ25T31QPU/4ewd7WgPV0/2rZocm
         dCKOtYtRLJelTx5sp3E/n86WX5xPy+O7AaBEnKA/T+4T0v9RFj4mSPxYQWoXFP8nGh4M
         aMAdD/pjUL/VbC/5Vge7jvy29X9TxI2HX8nS5V82VD5G+ad4Lz2mplrJkdebWyP3UrIm
         1lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682522; x=1702287322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ4oN2yBzcOb1+JXtPZKrl0tpOl2eK1zlq9JfJmTld4=;
        b=M8gxjMPUyox+Flv19J+oogp2PHqVhmuu0Pl3wOG3jZZOAqukMaVMabATCBq55WomRw
         oCtES167rSzYGXFs3V1hUl+KIo3Cv2tzQrmLFhV8ky5DOupFTiw2I1cHCanGuIxfTu47
         zChWP43c0UeYuDXg838pyTUO5xuDwlEnvwSizXba1lIfDm4hwIPEGk9wqE+Rz1f4Msfv
         G4cL70fyLxxtYLNpk+4DM9tYx6Idc50Efnhebj1kZ57pjo3W2jqYf+63Vnc8nCYhulO7
         mjeZ14rvb14sQMMFSrv9BnIF9HFEYGw6i49UoyBEcsTFsvWgkpo/cBjkp7AB14dDQKew
         GtQQ==
X-Gm-Message-State: AOJu0YywVrZR0R5dXvfj/ZLCvCZJikW8AdCYoWn5YN8bcj9J/y7Lks+a
        hWOCAqGT5SLygbXM1c8MGQlfGA==
X-Google-Smtp-Source: AGHT+IHCuQnItV2lKs0M1bnxQ5NKnbh9Y4kTm+Isghykg16TLUiy7F8Pk77hB8yvqqxMFcrKeo7XlQ==
X-Received: by 2002:a05:600c:3c8f:b0:40b:5e21:c5ab with SMTP id bg15-20020a05600c3c8f00b0040b5e21c5abmr1618979wmb.121.1701682521977;
        Mon, 04 Dec 2023 01:35:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4cb1:229e:8c33:122a])
        by smtp.gmail.com with ESMTPSA id fs16-20020a05600c3f9000b0040b48690c49sm14266219wmb.6.2023.12.04.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:35:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 08/10] pinctrl: sppctl: use gpiochip_dup_line_label()
Date:   Mon,  4 Dec 2023 10:35:07 +0100
Message-Id: <20231204093509.19225-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204093509.19225-1-brgl@bgdev.pl>
References: <20231204093509.19225-1-brgl@bgdev.pl>
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
 drivers/pinctrl/sunplus/sppctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index bb5ef391dbe4..ae156f779a16 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -4,6 +4,7 @@
  * Copyright (C) Sunplus Tech / Tibbo Tech.
  */
 
+#include <linux/cleanup.h>
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -500,16 +501,15 @@ static int sppctl_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 
 static void sppctl_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
-	const char *label;
 	int i;
 
 	for (i = 0; i < chip->ngpio; i++) {
-		label = gpiochip_is_requested(chip, i);
-		if (!label)
-			label = "";
+		char *label __free(kfree) = gpiochip_dup_line_label(chip, i);
+		if (IS_ERR(label))
+			continue;
 
 		seq_printf(s, " gpio-%03d (%-16.16s | %-16.16s)", i + chip->base,
-			   chip->names[i], label);
+			   chip->names[i], label ?: "");
 		seq_printf(s, " %c", sppctl_gpio_get_direction(chip, i) ? 'I' : 'O');
 		seq_printf(s, ":%d", sppctl_gpio_get(chip, i));
 		seq_printf(s, " %s", sppctl_first_get(chip, i) ? "gpi" : "mux");
-- 
2.40.1

