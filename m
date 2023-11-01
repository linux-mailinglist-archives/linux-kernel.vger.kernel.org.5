Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD507DDE86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjKAJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjKAJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:36:13 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE66DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:36:10 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y7dwqR8ijQRiPy7dwqGq2i; Wed, 01 Nov 2023 10:36:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698831369;
        bh=NZ1iobFX10Nh/HKZlug5CXulRdixpZgCPip/7q+e51k=;
        h=From:To:Cc:Subject:Date;
        b=N58b8yS5T9e1AGnVTLHT5D9yQZIbYZvut3OPuh1dhJh5J+OBWVa55fwmOG+JqJyfb
         soCXr/tgO1by2Ka7A2gYbnjdl+iL/tPmSgTf4rLz4XscCcX2cIZ6LY8FfBjFFxWeHI
         woXsk7LBCEdRNIs2vWFJSftUAAz+KCF0YWPBnZT6BNyJMaGsykoLWEbV/de5jna5Nk
         PNzEVgmxODvu3TBSKH1gtwoZ5aArZ1w5+94pok0OXI3pnccDgz0gloII2R+kQJXbh2
         GMmTqlqow5kLrJL88qhcQhKxdni7hJzVcgZ1vabT0PEUew6+7D+luXVQm5cDPUXHk1
         hegOaO1W8Jofw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 10:36:09 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] software node: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 10:36:04 +0100
Message-Id: <c7cdc3566c783d106138698b1e1923351fabace8.1698831275.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/base/swnode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1886995a0b3a..f7c4317b2ccf 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -747,10 +747,10 @@ static void software_node_release(struct kobject *kobj)
 	struct swnode *swnode = kobj_to_swnode(kobj);
 
 	if (swnode->parent) {
-		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
+		ida_free(&swnode->parent->child_ids, swnode->id);
 		list_del(&swnode->entry);
 	} else {
-		ida_simple_remove(&swnode_root_ids, swnode->id);
+		ida_free(&swnode_root_ids, swnode->id);
 	}
 
 	if (swnode->allocated)
@@ -776,8 +776,8 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 	if (!swnode)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(parent ? &parent->child_ids : &swnode_root_ids,
-			     0, 0, GFP_KERNEL);
+	ret = ida_alloc(parent ? &parent->child_ids : &swnode_root_ids,
+			GFP_KERNEL);
 	if (ret < 0) {
 		kfree(swnode);
 		return ERR_PTR(ret);
-- 
2.34.1

