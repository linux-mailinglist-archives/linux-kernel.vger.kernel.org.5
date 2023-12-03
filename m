Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86D8026F4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjLCTeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLCTeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:21 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4690107;
        Sun,  3 Dec 2023 11:33:57 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5c85e8fdd2dso41211967b3.2;
        Sun, 03 Dec 2023 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632036; x=1702236836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ottP/3goJGHKBScZHd3MAwUBENHBLDJkj8UrprLPbFs=;
        b=UerbT+umyTVEtazTLa9H6JEBOXy2LGZxB0k6pjJstiKh3Eeg7jc5a6USx9F/+zXcfA
         QGeVPhasfy4PsjV7Q/3Ehrws8K7uOZ9FyOCdk5wTEuB2SRB2dnV6FVRWT8inHfQGpBfX
         7HMVXsU7WaQnxuAX/9aVpNp5XVSt+KFKj9792qXwj2IdncAO/TbpgztxAsR5g3W9OM2v
         Te6+xSr8ti2JX+zneNW08Yd1TjJGNXj1ci0+1Wu/NqMhYpaXQfYvyHAx4N+iXxA12vD9
         PmbkNYgGK8vkGTcr3Bt+pGQ+xoybvSaKbGA9eTeJmVZ9b9YPd1Xkb4cd+s+bYX+VzHNo
         Ot5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632036; x=1702236836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ottP/3goJGHKBScZHd3MAwUBENHBLDJkj8UrprLPbFs=;
        b=i4YYHPfFoBAJUgInbB1czyhDfGp1LF3O8wSPZf70v5mzdN4wQFQ8nUF3IVAnt3323j
         rlS80hGt/md51JwYVVGfohIRVdxWRrN/tYdgu/Cgr+kRoVDOeIwPgGaooEAyknSlfCny
         42i4HzZoplwXmNaFWKTbUszDKhRCHt8Z0ObXuxj1vLNrxkSDjn/9b4ooVJxjCbddLWdE
         q6wd1CgLD8NhUroc3yog6YvelCA/B3ZQkHey+O5jg1YGfikNv38e4zpBfml7XB7wwlGL
         /tSADQfdUO36WqWgdgxkJNlp2mEGwvLiRbgUfuAfBkhqIKNoD4PK77QDuBW7AbhoHF/k
         6ruA==
X-Gm-Message-State: AOJu0YzrULEIRXZZg8L8gfCgStZsqkob/xphgaEKGcDcfwdNSHVzFux6
        VeXwHPfqswKbyCCtSCMMam1mEQ7GpFoqQA==
X-Google-Smtp-Source: AGHT+IH1ZX5h+cmeOmKxSOoGS5TqhHIYdM4449+xqDFi+MujJ82hBv7NxPxg3bBJtd+51eboQJUVCg==
X-Received: by 2002:a81:9ad6:0:b0:5d7:1940:dd8b with SMTP id r205-20020a819ad6000000b005d71940dd8bmr1542923ywg.97.1701632036556;
        Sun, 03 Dec 2023 11:33:56 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id c22-20020a814e16000000b005d875372a84sm300576ywb.38.2023.12.03.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:55 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-media@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 27/35] media: em28xx: cx231xx: fix opencoded find_and_set_bit()
Date:   Sun,  3 Dec 2023 11:32:59 -0800
Message-Id: <20231203193307.542794-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions in the media/usb drivers opencode find_and_set_bit() by
polling on a found bit in a while-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/media/usb/cx231xx/cx231xx-cards.c | 16 ++++------
 drivers/media/usb/em28xx/em28xx-cards.c   | 37 +++++++++--------------
 2 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c b/drivers/media/usb/cx231xx/cx231xx-cards.c
index 92efe6c1f47b..b314603932d7 100644
--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -1708,16 +1708,12 @@ static int cx231xx_usb_probe(struct usb_interface *interface,
 		return -ENODEV;
 
 	/* Check to see next free device and mark as used */
-	do {
-		nr = find_first_zero_bit(&cx231xx_devused, CX231XX_MAXBOARDS);
-		if (nr >= CX231XX_MAXBOARDS) {
-			/* No free device slots */
-			dev_err(d,
-				"Supports only %i devices.\n",
-				CX231XX_MAXBOARDS);
-			return -ENOMEM;
-		}
-	} while (test_and_set_bit(nr, &cx231xx_devused));
+	nr = find_and_set_bit(&cx231xx_devused, CX231XX_MAXBOARDS);
+	if (nr >= CX231XX_MAXBOARDS) {
+		/* No free device slots */
+		dev_err(d, "Supports only %i devices.\n", CX231XX_MAXBOARDS);
+		return -ENOMEM;
+	}
 
 	udev = usb_get_dev(interface_to_usbdev(interface));
 
diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 4d037c92af7c..af4809fe74a8 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3684,17 +3684,14 @@ static int em28xx_duplicate_dev(struct em28xx *dev)
 		return -ENOMEM;
 	}
 	/* Check to see next free device and mark as used */
-	do {
-		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
-		if (nr >= EM28XX_MAXBOARDS) {
-			/* No free device slots */
-			dev_warn(&dev->intf->dev, ": Supports only %i em28xx boards.\n",
-				 EM28XX_MAXBOARDS);
-			kfree(sec_dev);
-			dev->dev_next = NULL;
-			return -ENOMEM;
-		}
-	} while (test_and_set_bit(nr, em28xx_devused));
+	nr = find_and_set_bit(em28xx_devused, EM28XX_MAXBOARDS);
+	if (nr >= EM28XX_MAXBOARDS) {
+		/* No free device slots */
+		dev_warn(&dev->intf->dev, ": Supports only %i em28xx boards.\n", EM28XX_MAXBOARDS);
+		kfree(sec_dev);
+		dev->dev_next = NULL;
+		return -ENOMEM;
+	}
 	sec_dev->devno = nr;
 	snprintf(sec_dev->name, 28, "em28xx #%d", nr);
 	sec_dev->dev_next = NULL;
@@ -3827,17 +3824,13 @@ static int em28xx_usb_probe(struct usb_interface *intf,
 	udev = usb_get_dev(interface_to_usbdev(intf));
 
 	/* Check to see next free device and mark as used */
-	do {
-		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
-		if (nr >= EM28XX_MAXBOARDS) {
-			/* No free device slots */
-			dev_err(&intf->dev,
-				"Driver supports up to %i em28xx boards.\n",
-			       EM28XX_MAXBOARDS);
-			retval = -ENOMEM;
-			goto err_no_slot;
-		}
-	} while (test_and_set_bit(nr, em28xx_devused));
+	nr = find_and_set_bit(em28xx_devused, EM28XX_MAXBOARDS);
+	if (nr >= EM28XX_MAXBOARDS) {
+		/* No free device slots */
+		dev_err(&intf->dev, "Driver supports up to %i em28xx boards.\n", EM28XX_MAXBOARDS);
+		retval = -ENOMEM;
+		goto err_no_slot;
+	}
 
 	/* Don't register audio interfaces */
 	if (intf->altsetting[0].desc.bInterfaceClass == USB_CLASS_AUDIO) {
-- 
2.40.1

