Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC617BA3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjJEP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjJEP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8984ED4;
        Thu,  5 Oct 2023 06:52:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D177DC4AF6E;
        Thu,  5 Oct 2023 13:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696512835;
        bh=Ajq8gV1LGJFvnPZhXDFFK3hzihK5NkBL+73XF7NmfLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnPv76MvuwiBgqT0NgoekRfweaFvnh+3jHOlQlW7mrJYPUb4SPLy3W1JV1ZEtZpnU
         SHKV1Kbs5ahtwZ31CnUJMi4jhkyP2Gaw13sJniLcx/imC72HsarqQ3+MV1L97SZcrm
         ZLRVgnOb3HNVtxsqIjyQVKlBIL1Xa4Zj8QOR+QSg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 2/2] tty: vc_screen: make vc_class constant
Date:   Thu,  5 Oct 2023 15:33:48 +0200
Message-ID: <2023100549-sixth-anger-ac34@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023100546-humbly-prologue-e58c@gregkh>
References: <2023100546-humbly-prologue-e58c@gregkh>
MIME-Version: 1.0
Lines:  67
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Ajq8gV1LGJFvnPZhXDFFK3hzihK5NkBL+73XF7NmfLI=; b=owGbwMvMwCRo6H6F97bub03G02pJDKlyu+3yq3oYfi5vZ1p9a+Hi5Av96lVGVge1BaQOep2o4 dZ8krC0I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACYiJsmwYN38TToLHZN+7te/ 9LvMguFf8FV3P4Y5nG90Xhf83Xa61FfjptL/l0Z8FeseAgA=
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
 drivers/tty/vt/vc_screen.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 829c4be66f3b..b16ea517bb17 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -786,23 +786,22 @@ static const struct file_operations vcs_fops = {
 	.release	= vcs_release,
 };
 
-static struct class *vc_class;
+static const struct class vc_class = {
+	.name = "vc",
+};
 
 void vcs_make_sysfs(int index)
 {
-	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, index + 1), NULL,
-		      "vcs%u", index + 1);
-	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, index + 65), NULL,
-		      "vcsu%u", index + 1);
-	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, index + 129), NULL,
-		      "vcsa%u", index + 1);
+	device_create(&vc_class, NULL, MKDEV(VCS_MAJOR, index + 1), NULL, "vcs%u", index + 1);
+	device_create(&vc_class, NULL, MKDEV(VCS_MAJOR, index + 65), NULL, "vcsu%u", index + 1);
+	device_create(&vc_class, NULL, MKDEV(VCS_MAJOR, index + 129), NULL, "vcsa%u", index + 1);
 }
 
 void vcs_remove_sysfs(int index)
 {
-	device_destroy(vc_class, MKDEV(VCS_MAJOR, index + 1));
-	device_destroy(vc_class, MKDEV(VCS_MAJOR, index + 65));
-	device_destroy(vc_class, MKDEV(VCS_MAJOR, index + 129));
+	device_destroy(&vc_class, MKDEV(VCS_MAJOR, index + 1));
+	device_destroy(&vc_class, MKDEV(VCS_MAJOR, index + 65));
+	device_destroy(&vc_class, MKDEV(VCS_MAJOR, index + 129));
 }
 
 int __init vcs_init(void)
@@ -811,11 +810,12 @@ int __init vcs_init(void)
 
 	if (register_chrdev(VCS_MAJOR, "vcs", &vcs_fops))
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
-	vc_class = class_create("vc");
+	if (class_register(&vc_class))
+		panic("unable to create vc_class");
 
-	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
-	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 64), NULL, "vcsu");
-	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
+	device_create(&vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	device_create(&vc_class, NULL, MKDEV(VCS_MAJOR, 64), NULL, "vcsu");
+	device_create(&vc_class, NULL, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	for (i = 0; i < MIN_NR_CONSOLES; i++)
 		vcs_make_sysfs(i);
 	return 0;
-- 
2.42.0

