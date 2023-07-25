Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B24761B30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjGYOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGYOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:14:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6A1FCB;
        Tue, 25 Jul 2023 07:14:24 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9Jsh0Gq7zrRx5;
        Tue, 25 Jul 2023 22:13:28 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 22:14:20 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <john.johansen@canonical.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <mike.salvatore@canonical.com>
CC:     <apparmor@lists.ubuntu.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] apparmor: cleanup unused functions in file.h
Date:   Tue, 25 Jul 2023 14:12:59 +0000
Message-ID: <20230725141259.233391-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After changes in commit 33bf60cabcc7 ("LSM: Infrastructure management of
the file security"), aa_alloc_file_ctx() and aa_free_file_ctx() are no
longer used, so remove them, and also remove aa_get_file_label() because
it seems that it's never been used before.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/apparmor/include/file.h | 37 --------------------------------
 1 file changed, 37 deletions(-)

diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 5be620af33ba..23cb6f9dbe6e 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -45,43 +45,6 @@ struct aa_file_ctx {
 	u32 allow;
 };
 
-/**
- * aa_alloc_file_ctx - allocate file_ctx
- * @label: initial label of task creating the file
- * @gfp: gfp flags for allocation
- *
- * Returns: file_ctx or NULL on failure
- */
-static inline struct aa_file_ctx *aa_alloc_file_ctx(struct aa_label *label,
-						    gfp_t gfp)
-{
-	struct aa_file_ctx *ctx;
-
-	ctx = kzalloc(sizeof(struct aa_file_ctx), gfp);
-	if (ctx) {
-		spin_lock_init(&ctx->lock);
-		rcu_assign_pointer(ctx->label, aa_get_label(label));
-	}
-	return ctx;
-}
-
-/**
- * aa_free_file_ctx - free a file_ctx
- * @ctx: file_ctx to free  (MAYBE_NULL)
- */
-static inline void aa_free_file_ctx(struct aa_file_ctx *ctx)
-{
-	if (ctx) {
-		aa_put_label(rcu_access_pointer(ctx->label));
-		kfree_sensitive(ctx);
-	}
-}
-
-static inline struct aa_label *aa_get_file_label(struct aa_file_ctx *ctx)
-{
-	return aa_get_label_rcu(&ctx->label);
-}
-
 /*
  * The xindex is broken into 3 parts
  * - index - an index into either the exec name table or the variable table
-- 
2.34.1

