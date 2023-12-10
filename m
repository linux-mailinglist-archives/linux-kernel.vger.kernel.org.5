Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7A80BC54
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjLJRU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjLJRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:20:54 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79847FC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:21:00 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNUArclegsaM8CNUArtR4j; Sun, 10 Dec 2023 18:20:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702228858;
        bh=C9fceqXzVbndKoQVbdNeb4fI05XCiHfbkjzq+6X8Vgs=;
        h=From:To:Cc:Subject:Date;
        b=ZXZ1qU84Kqhmmpjwh13l6+ke0Q+qqj6pYHCmQRR7hz/4ewZcYXMbXIk4YMBQStOba
         eulTp9iEgrpKwz/Riqco8pu2ldMMsSAAp4/JKsl3i7jjNoD27NBsc7kqTi74tXxZm7
         xEkXtLUd9eFVscbfNz2sIHIPtTarLP+R5alTvyM6MhpykCYm+e2t7awfX26ltO5qYz
         9lNeS+xPaDOGAh7tRHUeaN3gcm0vHGSdzLWoVOdUSDiI6mKkILj2VPq4CcW4ABL0lq
         elw1cb0gc3Y9rSOWQui2SAy6D6e+QyKq0QqKUt5e6R4WAO0uk66jnEmBI05MDsREff
         INJCogq9xnosQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:20:58 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: xpad - Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:20:57 +0100
Message-Id: <a3e30e30f18cc5d6f032c8013ce9d900c8e223e5.1702228806.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/joystick/xpad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f5c21565bb3c..00c77e906744 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1669,7 +1669,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->pad_nr = ida_simple_get(&xpad_pad_seq, 0, 0, GFP_KERNEL);
+	xpad->pad_nr = ida_alloc(&xpad_pad_seq, GFP_KERNEL);
 	if (xpad->pad_nr < 0) {
 		error = xpad->pad_nr;
 		goto err_free_mem;
@@ -1692,7 +1692,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	return 0;
 
 err_free_id:
-	ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
+	ida_free(&xpad_pad_seq, xpad->pad_nr);
 err_free_mem:
 	kfree(led);
 	xpad->led = NULL;
@@ -1705,7 +1705,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 
 	if (xpad_led) {
 		led_classdev_unregister(&xpad_led->led_cdev);
-		ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
+		ida_free(&xpad_pad_seq, xpad->pad_nr);
 		kfree(xpad_led);
 	}
 }
-- 
2.34.1

