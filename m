Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6327BA3BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjJEP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjJEP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559DD4EE1;
        Thu,  5 Oct 2023 06:52:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFF5C4AF72;
        Thu,  5 Oct 2023 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696512838;
        bh=8IfVfF+yODlDKa6ANhxVLRvpIO3XLnWZup5NNRdo240=;
        h=From:To:Cc:Subject:Date:From;
        b=I0V/yuL/So/i3//ZhJt78g3z9X9dZSJvUjZT2Uk6oSJ38b3Xdb06xMq5opiHyn9tr
         5ggu82U+8h5xVgIJUhKTJ2I2roQX9BPnj/PR2f//xi4c2cXMQrExzXTg7l+ZYirj91
         8G+QmwX+D3d0JqQ4cRbWo6cbWyx1mpxpZsDiNWUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 1/2] tty: vt: make vtconsole_class constant
Date:   Thu,  5 Oct 2023 15:33:47 +0200
Message-ID: <2023100546-humbly-prologue-e58c@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  71
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=8IfVfF+yODlDKa6ANhxVLRvpIO3XLnWZup5NNRdo240=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlyu60ypzWyc32//2TZlKD1l7e2zVldZvbzVmLG0cie1 YzVsUY7OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAizQ4M81QKqhNu6LO0Pcxl eytbd3Xn96UyiQzzY+9qvWPICa89dqp8fjOPmtDn9Wy2AA==
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

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 5c47f77804f0..7659b92db631 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3565,7 +3565,9 @@ int __init vty_init(const struct file_operations *console_fops)
 	return 0;
 }
 
-static struct class *vtconsole_class;
+static const struct class vtconsole_class = {
+	.name = "vtconsole",
+};
 
 static int do_bind_con_driver(const struct consw *csw, int first, int last,
 			   int deflt)
@@ -4092,7 +4094,7 @@ static int do_register_con_driver(const struct consw *csw, int first, int last)
 		goto err;
 
 	con_driver->dev =
-		device_create_with_groups(vtconsole_class, NULL,
+		device_create_with_groups(&vtconsole_class, NULL,
 					  MKDEV(0, con_driver->node),
 					  con_driver, con_dev_groups,
 					  "vtcon%i", con_driver->node);
@@ -4173,7 +4175,7 @@ static void con_driver_unregister_callback(struct work_struct *ignored)
 		console_unlock();
 
 		vtconsole_deinit_device(con_driver);
-		device_destroy(vtconsole_class, MKDEV(0, con_driver->node));
+		device_destroy(&vtconsole_class, MKDEV(0, con_driver->node));
 
 		console_lock();
 
@@ -4234,12 +4236,9 @@ static int __init vtconsole_class_init(void)
 {
 	int i;
 
-	vtconsole_class = class_create("vtconsole");
-	if (IS_ERR(vtconsole_class)) {
-		pr_warn("Unable to create vt console class; errno = %ld\n",
-			PTR_ERR(vtconsole_class));
-		vtconsole_class = NULL;
-	}
+	i = class_register(&vtconsole_class);
+	if (i)
+		pr_warn("Unable to create vt console class; errno = %d\n", i);
 
 	/* Add system drivers to sysfs */
 	for (i = 0; i < MAX_NR_CON_DRIVER; i++) {
@@ -4247,7 +4246,7 @@ static int __init vtconsole_class_init(void)
 
 		if (con->con && !con->dev) {
 			con->dev =
-				device_create_with_groups(vtconsole_class, NULL,
+				device_create_with_groups(&vtconsole_class, NULL,
 							  MKDEV(0, con->node),
 							  con, con_dev_groups,
 							  "vtcon%i", con->node);
-- 
2.42.0

