Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562E880BC68
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjLJRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJRnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:43:55 -0500
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580FFA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:44:01 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNqQrGkpo4QGMCNqQrBwSr; Sun, 10 Dec 2023 18:43:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702230239;
        bh=2DakXtZBtjglxJAoYvjwjPdRqQfAlWSOjON3AQhn3rc=;
        h=From:To:Cc:Subject:Date;
        b=NvTFoZCVJvQwlvL0Wn2x7DmMrz9pm1f7rxr9S2sRlJ7Ik3bHV4UDmoR2sT1tZ3gcm
         OGN5dfyRznLHL6WNUcAY4K1d3x/c9RO12yQNzNYKdO2620eUQkpYKn/hBxt3jmCsFY
         KBUVyR9wjT6ov2dsFLYBZs8HBAnJcraQEtiLDFEaQGaWuyzcAW/w6BagmKh8pcVgL0
         6+A2QWM5QrASpfVdyUSXqZYIaNdFPHusarZSoUYKLNA8G9lrNfFrhNJMiimVYcs7iv
         mHgUbufvuYYsUodNXvagfkksysGEPcB8oTy+h87DXsEXhL++wRYWQOsXAYdCIZYMvP
         SXchW/Uz6p0YQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:43:59 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: chipidea: Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:43:56 +0100
Message-Id: <8bf382976c0ba0986c0dbe93427266273f0776ef.1702230217.git.christophe.jaillet@wanadoo.fr>
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
 drivers/usb/chipidea/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 7ac39a281b8c..0af9e68035fb 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -862,7 +862,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	id = ida_simple_get(&ci_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ci_ida, GFP_KERNEL);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -892,7 +892,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 err:
 	platform_device_put(pdev);
 put_id:
-	ida_simple_remove(&ci_ida, id);
+	ida_free(&ci_ida, id);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(ci_hdrc_add_device);
@@ -901,7 +901,7 @@ void ci_hdrc_remove_device(struct platform_device *pdev)
 {
 	int id = pdev->id;
 	platform_device_unregister(pdev);
-	ida_simple_remove(&ci_ida, id);
+	ida_free(&ci_ida, id);
 }
 EXPORT_SYMBOL_GPL(ci_hdrc_remove_device);
 
-- 
2.34.1

