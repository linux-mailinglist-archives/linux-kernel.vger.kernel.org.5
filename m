Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F145F80B462
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjLIMgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIMgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:36:20 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD6B1703
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 04:36:21 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id BwZ7rbI0E6wd8BwZ7re9vS; Sat, 09 Dec 2023 13:36:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702125379;
        bh=bXiXUI7HOibThetI/WgePYhHkYZjFZBA7O1RkI3V6uI=;
        h=From:To:Cc:Subject:Date;
        b=oKW5DHKslOm34e9Qg3zWDWUgyjW5pxek3pqWPWHHPlsh8p0Jbyej5JRSHI2Zver/A
         RxfPEAMHE1/P/qAtqtuq8z3kkVfpxZ3dgj2EJ1Hz8DLop173gbjg1x3qYnPTBdrA4+
         8GyM41Z9wp1F4MaZnQ7CJ2uoKlmqIOSFjZYn+GUqNY9CB70XG7X59gcXGfH/QLQn8E
         pgH7t+HcjIlTGTaW3fGlBIoGyVBfbOb+NqAbWCitnOqDs4LN+KDqxZuwD7Wydx2ATQ
         RxgaPEH7InuWzBX8NzFtpuq2IMXwSqqpjo9Wx3usZWZlMq7EYq00CFTX0i+jjAkTUx
         wnv9+gv5yYlYg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Dec 2023 13:36:19 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 1/2] VMCI: Remove handle_arr_calc_size()
Date:   Sat,  9 Dec 2023 13:36:14 +0100
Message-Id: <84e7f2d8e7c4c2eab68f958307d56546978f76e3.1702125347.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of handle_arr_calc_size().
This is much more conventional.

While at it, use size_add() when computing the needed size in
vmci_handle_arr_append_entry(). This prevents from (unlikely) overflow
when computing the new size to reallocate.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
   - use size_add() in vmci_handle_arr_append_entry()   [Kees Cook]

v1: https://lore.kernel.org/all/adf0c48a57d911be5509688614d2e00694ff57eb.1702068153.git.christophe.jaillet@wanadoo.fr/
---
 drivers/misc/vmw_vmci/vmci_handle_array.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_handle_array.c b/drivers/misc/vmw_vmci/vmci_handle_array.c
index de7fee7ead1b..681b3500125a 100644
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
+					      size_add(array->capacity, capacity_bump));
 
 		if (array->size >= array->max_capacity)
 			return VMCI_ERROR_NO_MEM;
-- 
2.34.1

