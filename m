Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACAA80AE37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574752AbjLHUqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbjLHUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:46:15 -0500
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198C21995
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:46:20 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id BhjkrXIBfToaHBhjkr2fgx; Fri, 08 Dec 2023 21:46:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702068378;
        bh=c7yN6XYmPkSmYh2d3ai7nF5rpx6ZA/0115qJPRMOJ2Q=;
        h=From:To:Cc:Subject:Date;
        b=t+pSJO4x/EZmGcAEdRrc6oukLmyBQhaRLPhPdh4WTYVNlpMHBvWHw2lwi98ggOEU0
         dBIjGStSWPZ8YQuDdKuJu/0uURu/swVSxKrR+f3KpGsQHeIYWpvclddjl6KLLrOOYD
         bhZuXSyRGC1yCgIK9DI4QxXamkJ7YilG+1phzyTYSD8Fe2ahI6H0AiM1V3Ofs8BmLM
         pgok+pd0j9jnzX3Zmp9go7DIpd2KIWzJ6+Y5KuZDSkTBT3c2+UmeDUFLoRkx2blMUb
         5TtTMEOmxS/Bx30r6zJFsmRZVzUqX5jBUqHSIEJ93n8+USicxGa33ZebtPaW8kbWsO
         VFTFYsXtiOc6Q==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 08 Dec 2023 21:46:18 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] VMCI: Remove handle_arr_calc_size()
Date:   Fri,  8 Dec 2023 21:46:09 +0100
Message-Id: <adf0c48a57d911be5509688614d2e00694ff57eb.1702068153.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of handle_arr_calc_size().
This is much more conventionnal.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/vmw_vmci/vmci_handle_array.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.c b/drivers/misc/vmw_vmci/vmci_handle_array.c
index de7fee7ead1b..56d48d42736b 100644
--- a/drivers/misc/vmw_vmci/vmci_handle_array.c
+++ b/drivers/misc/vmw_vmci/vmci_handle_array.c
@@ -8,12 +8,6 @@
 #include <linux/slab.h>
 #include "vmci_handle_array.h"
 
-static size_t handle_arr_calc_size(u32 capacity)
-{
-	return VMCI_HANDLE_ARRAY_HEADER_SIZE +
-	    capacity * sizeof(struct vmci_handle);
-}
-
 struct vmci_handle_arr *vmci_handle_arr_create(u32 capacity, u32 max_capacity)
 {
 	struct vmci_handle_arr *array;
@@ -25,7 +19,7 @@ struct vmci_handle_arr *vmci_handle_arr_create(u32 capacity, u32 max_capacity)
 		capacity = min((u32)VMCI_HANDLE_ARRAY_DEFAULT_CAPACITY,
 			       max_capacity);
 
-	array = kmalloc(handle_arr_calc_size(capacity), GFP_ATOMIC);
+	array = kmalloc(struct_size(array, entries, capacity), GFP_ATOMIC);
 	if (!array)
 		return NULL;
 
@@ -51,8 +45,8 @@ int vmci_handle_arr_append_entry(struct vmci_handle_arr **array_ptr,
 		struct vmci_handle_arr *new_array;
 		u32 capacity_bump = min(array->max_capacity - array->capacity,
 					array->capacity);
-		size_t new_size = handle_arr_calc_size(array->capacity +
-						       capacity_bump);
+		size_t new_size = struct_size(array, entries,
+					      array->capacity + capacity_bump);
 
 		if (array->size >= array->max_capacity)
 			return VMCI_ERROR_NO_MEM;
-- 
2.34.1

