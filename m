Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CEB7BA3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjJEP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjJEP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F25254
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FACC32776;
        Thu,  5 Oct 2023 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696513439;
        bh=r+jEdL/TyFNdYoWkAT7QN/Pry5cHlDLJqXIOFwHWmXg=;
        h=From:To:Cc:Subject:Date:From;
        b=SdNS1OIeXifDyiBMS6Cdtyl+L9k+b71Uu3xq5NohLGCuJTc+NnLTL1mXrq9cVj+X0
         oLMj6ack8yJX1ZOMyNYFh3QDAwvrKCMSFHKK481CYLorMrnmssGS2L2+jcS5LOrCI8
         iTCGlE/xi7wJWfIeRk42FxJnha2LXS08S9vDJA3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>
Subject: [PATCH] staging: fieldbus: make controller_class constant
Date:   Thu,  5 Oct 2023 15:43:53 +0200
Message-ID: <2023100552-entrench-dingbat-093a@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  64
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=r+jEdL/TyFNdYoWkAT7QN/Pry5cHlDLJqXIOFwHWmXg=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlye2d+nfegQdpJwC7cK2x6S/zRqSYGZeoTXk6cfOHqR vOrfbPYOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiidIMczhYb0fo7Hyg8cHj LfMW3XWn5OuEDzMsWF8r4+soHxd56OpfqTg+8fz8W2+OAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, making all 'class' structures to be declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Sven Van Asbroeck <TheSven73@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index 6f69758a8b27..34d18b09bedd 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -218,7 +218,10 @@ static const struct regulator_desc can_power_desc = {
 	.ops = &can_power_ops,
 };
 
-static struct class *controller_class;
+static const struct class controller_class = {
+	.name = "arcx_anybus_controller",
+};
+
 static DEFINE_IDA(controller_index_ida);
 
 static int controller_probe(struct platform_device *pdev)
@@ -301,7 +304,7 @@ static int controller_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto out_ida;
 	}
-	cd->class_dev->class = controller_class;
+	cd->class_dev->class = &controller_class;
 	cd->class_dev->groups = controller_attribute_groups;
 	cd->class_dev->parent = dev;
 	cd->class_dev->id = id;
@@ -351,12 +354,12 @@ static int __init controller_init(void)
 {
 	int err;
 
-	controller_class = class_create("arcx_anybus_controller");
-	if (IS_ERR(controller_class))
-		return PTR_ERR(controller_class);
+	err = class_register(&controller_class);
+	if (err)
+		return err;
 	err = platform_driver_register(&controller_driver);
 	if (err)
-		class_destroy(controller_class);
+		class_unregister(&controller_class);
 
 	return err;
 }
@@ -364,7 +367,7 @@ static int __init controller_init(void)
 static void __exit controller_exit(void)
 {
 	platform_driver_unregister(&controller_driver);
-	class_destroy(controller_class);
+	class_unregister(&controller_class);
 	ida_destroy(&controller_index_ida);
 }
 
-- 
2.42.0

