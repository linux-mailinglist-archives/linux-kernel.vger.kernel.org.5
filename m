Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D61F812C61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443509AbjLNJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443498AbjLNJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:59:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A1114;
        Thu, 14 Dec 2023 01:59:08 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d098b87eeeso71339295ad.0;
        Thu, 14 Dec 2023 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702547948; x=1703152748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGiGfD+/fY4XI4R5gDWMpTDZ9kiH8OA3IkETS/R7xgk=;
        b=DNYFr3aCXnBXiMVzM9rtfCLVT2RefWVMBCTX1HS3MIA2Wwx/znCO6gpN8tkxzhGfGG
         LOuvQYpp87l17pZeUcODQV14UGOIYDf4ECZgmVrEsmek9NVgrUHzNx4BqavnllDVXfbU
         w/dKikvrhOBc0rSH5G1mSigUE+pDSiWd5DLTXYXrWjetAtmdve2N46YBJ6b7hA2EC87r
         yw45Wyw7FsUBz9XZbmkKTseDPNMrMiQsdStV2Q6cZxsTpLVelv7C6LddWFu8X9OcBo8Y
         RqQwMw2O1RRcxRcMa1BkJd+zafuiT6xPf67C8qhzp88G1PNtLajHJaI2lU/vyw6FGB9Y
         Q5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547948; x=1703152748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGiGfD+/fY4XI4R5gDWMpTDZ9kiH8OA3IkETS/R7xgk=;
        b=KDVACPEb0fvp4vn/tSQAyEHYXxmlw7Ao4IPv+hpcyrPyDR5EB+ZUeb+iHDFIQ0vsZ5
         eD1cves3Dw5ixQVc+nmlAbU92tq70DmINt1Okt/sLt3dVtA6lvAFBpiYCwgeCw0R21ak
         Gw7c9T7l4n456dPqC53+tMkz6EOMEK2+fDGAuOQM/6YZREoQG9RKPHsUaEoryx/Tk3aF
         L1Pyon7LQCt1yFKdwfK50cdYE/LApuYPj2KNrIkbqf+Te0KHnpbHtLNFY36GLDsffwWG
         z0mD3v4h1Qmz57Fbfdpd5ckewEXXyfp3VwW773JVYYqbgIqT8tQr2vU56Bo+T0uB02Qa
         8xzw==
X-Gm-Message-State: AOJu0YzzNmntwG7YHFs0mCmKOs1G/Xj57M1zYF9bVfBUxr6ZKAZZ7xxi
        Qosr3yiJzM35h20GWUEFrslU0qvpvN8=
X-Google-Smtp-Source: AGHT+IFJDoIRWpvhSguHfFYouUpZhCq5uPxqEAbwup02dcQY7LdehLjSbpxZmqegcVHRx403WDjdpg==
X-Received: by 2002:a17:902:d58a:b0:1d3:766f:364e with SMTP id k10-20020a170902d58a00b001d3766f364emr41384plh.134.1702547948131;
        Thu, 14 Dec 2023 01:59:08 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709028bc200b001bc6e6069a6sm922807plo.122.2023.12.14.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:59:07 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 4/5] gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
Date:   Thu, 14 Dec 2023 17:58:13 +0800
Message-Id: <20231214095814.132400-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214095814.132400-1-warthog618@gmail.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the time holding the gpio_lock by snapshotting the desc flags,
rather than testing them individually while holding the lock.

Accept that the calculation of the used field is inherently racy, and
only check the availability of the line from pinctrl if other checks
pass, so avoiding the check for lines that are otherwise in use.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 72 ++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 7da3b3706547..73262305de0f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2378,74 +2378,72 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 				  struct gpio_v2_line_info *info)
 {
 	struct gpio_chip *gc = desc->gdev->chip;
-	bool ok_for_pinctrl;
 	unsigned long flags;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
 
-	/*
-	 * This function takes a mutex so we must check this before taking
-	 * the spinlock.
-	 *
-	 * FIXME: find a non-racy way to retrieve this information. Maybe a
-	 * lock common to both frameworks?
-	 */
-	ok_for_pinctrl = pinctrl_gpio_can_use_line(gc, info->offset);
+	scoped_guard(spinlock_irqsave, &gpio_lock) {
+		if (desc->name)
+			strscpy(info->name, desc->name, sizeof(info->name));
 
-	spin_lock_irqsave(&gpio_lock, flags);
+		if (desc->label)
+			strscpy(info->consumer, desc->label,
+				sizeof(info->consumer));
 
-	if (desc->name)
-		strscpy(info->name, desc->name, sizeof(info->name));
-
-	if (desc->label)
-		strscpy(info->consumer, desc->label, sizeof(info->consumer));
+		flags = READ_ONCE(desc->flags);
+	}
 
 	/*
-	 * Userspace only need to know that the kernel is using this GPIO so
-	 * it can't use it.
+	 * Userspace only need know that the kernel is using this GPIO so it
+	 * can't use it.
+	 * The calculation of the used flag is slightly racy, as it may read
+	 * desc, gc and pinctrl state without a lock covering all three at
+	 * once.  Worst case if the line is in transition and the calculation
+	 * is inconsistent then it looks to the user like they performed the
+	 * read on the other side of the transition - but that can always
+	 * happen.
+	 * The definitive test that a line is available to userspace is to
+	 * request it.
 	 */
-	info->flags = 0;
-	if (test_bit(FLAG_REQUESTED, &desc->flags) ||
-	    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
-	    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
-	    test_bit(FLAG_EXPORT, &desc->flags) ||
-	    test_bit(FLAG_SYSFS, &desc->flags) ||
+	if (test_bit(FLAG_REQUESTED, &flags) ||
+	    test_bit(FLAG_IS_HOGGED, &flags) ||
+	    test_bit(FLAG_USED_AS_IRQ, &flags) ||
+	    test_bit(FLAG_EXPORT, &flags) ||
+	    test_bit(FLAG_SYSFS, &flags) ||
 	    !gpiochip_line_is_valid(gc, info->offset) ||
-	    !ok_for_pinctrl)
+	    !pinctrl_gpio_can_use_line(gc, info->offset))
 		info->flags |= GPIO_V2_LINE_FLAG_USED;
 
-	if (test_bit(FLAG_IS_OUT, &desc->flags))
+	if (test_bit(FLAG_IS_OUT, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_OUTPUT;
 	else
 		info->flags |= GPIO_V2_LINE_FLAG_INPUT;
 
-	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+	if (test_bit(FLAG_ACTIVE_LOW, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_ACTIVE_LOW;
 
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
+	if (test_bit(FLAG_OPEN_DRAIN, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_OPEN_DRAIN;
-	if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
+	if (test_bit(FLAG_OPEN_SOURCE, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_OPEN_SOURCE;
 
-	if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
+	if (test_bit(FLAG_BIAS_DISABLE, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_BIAS_DISABLED;
-	if (test_bit(FLAG_PULL_DOWN, &desc->flags))
+	if (test_bit(FLAG_PULL_DOWN, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN;
-	if (test_bit(FLAG_PULL_UP, &desc->flags))
+	if (test_bit(FLAG_PULL_UP, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_BIAS_PULL_UP;
 
-	if (test_bit(FLAG_EDGE_RISING, &desc->flags))
+	if (test_bit(FLAG_EDGE_RISING, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EDGE_RISING;
-	if (test_bit(FLAG_EDGE_FALLING, &desc->flags))
+	if (test_bit(FLAG_EDGE_FALLING, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EDGE_FALLING;
 
-	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
+	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
-	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
+	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
 }
 
 struct gpio_chardev_data {
-- 
2.39.2

