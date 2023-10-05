Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF87BA37F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbjJEP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbjJEP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EACF369F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:59:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52EEC43142;
        Thu,  5 Oct 2023 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696514320;
        bh=5pLx0oV6bg6h2ZrtEPu2Hn5oOoMFTmfUpUEMcaBhv+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2p1hDhNf/h8zw4v3DVF9FkdwMg8Zai0AvvpOf6zl6cAvMGLEnG2C3kJ1Pcg4cMh0
         CVJoBGxwyXXULQuaiuFNr+sUtJqK7otsLII7covBEu3tWQX9exB8NpY4ytvpsYtevU
         eSJx+a+hcirGFtWg83gRzJW3vt+blGerh6PCca2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>
Subject: [PATCH 2/3] staging: greybus: authentication: make cap_class constant
Date:   Thu,  5 Oct 2023 15:58:35 +0200
Message-ID: <2023100534-showoff-alright-6c95@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023100533-broadband-hunk-9e91@gregkh>
References: <2023100533-broadband-hunk-9e91@gregkh>
MIME-Version: 1.0
Lines:  78
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=5pLx0oV6bg6h2ZrtEPu2Hn5oOoMFTmfUpUEMcaBhv+g=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlyB7n2RddOaQudZy9QdP3BpG3GR5a513/qfyJ7xPTZn /hH+y+c7YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJsOswLDj9Q1bJ/+TVPYLz o54GWQb1CJRvAYo21XEwR0Ssn8TzJK45Zn4p45FAL1EA
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

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/authentication.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index 7e01790a4659..b67315641d18 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -36,7 +36,10 @@ struct gb_cap {
 	dev_t			dev_num;
 };
 
-static struct class *cap_class;
+static const struct class cap_class = {
+	.name = "gb_authenticate",
+};
+
 static dev_t cap_dev_num;
 static DEFINE_IDA(cap_minors_map);
 static LIST_HEAD(cap_list);
@@ -336,7 +339,7 @@ int gb_cap_connection_init(struct gb_connection *connection)
 		goto err_remove_ida;
 
 	/* Add a soft link to the previously added char-dev within the bundle */
-	cap->class_device = device_create(cap_class, cap->parent, cap->dev_num,
+	cap->class_device = device_create(&cap_class, cap->parent, cap->dev_num,
 					  NULL, "gb-authenticate-%d", minor);
 	if (IS_ERR(cap->class_device)) {
 		ret = PTR_ERR(cap->class_device);
@@ -370,7 +373,7 @@ void gb_cap_connection_exit(struct gb_connection *connection)
 
 	cap = gb_connection_get_data(connection);
 
-	device_destroy(cap_class, cap->dev_num);
+	device_destroy(&cap_class, cap->dev_num);
 	cdev_del(&cap->cdev);
 	ida_simple_remove(&cap_minors_map, MINOR(cap->dev_num));
 
@@ -402,9 +405,9 @@ int cap_init(void)
 {
 	int ret;
 
-	cap_class = class_create("gb_authenticate");
-	if (IS_ERR(cap_class))
-		return PTR_ERR(cap_class);
+	ret = class_register(&cap_class);
+	if (ret)
+		return ret;
 
 	ret = alloc_chrdev_region(&cap_dev_num, 0, NUM_MINORS,
 				  "gb_authenticate");
@@ -414,13 +417,13 @@ int cap_init(void)
 	return 0;
 
 err_remove_class:
-	class_destroy(cap_class);
+	class_unregister(&cap_class);
 	return ret;
 }
 
 void cap_exit(void)
 {
 	unregister_chrdev_region(cap_dev_num, NUM_MINORS);
-	class_destroy(cap_class);
+	class_unregister(&cap_class);
 	ida_destroy(&cap_minors_map);
 }
-- 
2.42.0

