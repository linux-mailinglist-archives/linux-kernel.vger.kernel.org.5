Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751E75FA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGXPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGXPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:19:06 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C51729;
        Mon, 24 Jul 2023 08:18:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R8k4N5s47z9ycNT;
        Mon, 24 Jul 2023 23:05:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHTlU3lr5kJcTzBA--.28220S5;
        Mon, 24 Jul 2023 16:18:42 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 3/5] smack: Always determine inode labels in smack_inode_init_security()
Date:   Mon, 24 Jul 2023 17:13:39 +0200
Message-Id: <20230724151341.538889-4-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
References: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHTlU3lr5kJcTzBA--.28220S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWkWr1rKry7tr1xGF1rJFb_yoWrGr17pa
        yUWa9xCF1DtFnxu3y0yF47Ww4a9as5Cr4UWr9Fqr9avFsrtryIgFW0qryYgFyxXr97Zrn0
        qr4avryrZ3WY9wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVWx
        Jr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj4zfjQAAsh
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

The inode_init_security hook is already a good place to initialize the
in-memory inode. And that is also what SELinux does.

In preparation for this, move the existing smack_inode_init_security() code
outside the 'if (xattr)' condition, and set the xattr, if provided.

This change does not have any impact on the current code, since every time
security_inode_init_security() is called, the initxattr() callback is
passed and, thus, xattr is non-NULL.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack_lsm.c | 80 +++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9eae830527d..5a31d005c6d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -948,51 +948,51 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	int may;
 
-	if (xattr) {
-		/*
-		 * If equal, transmuting already occurred in
-		 * smack_dentry_create_files_as(). No need to check again.
-		 */
-		if (tsp->smk_task != tsp->smk_transmuted) {
-			rcu_read_lock();
-			may = smk_access_entry(skp->smk_known, dsp->smk_known,
-					       &skp->smk_rules);
-			rcu_read_unlock();
-		}
+	/*
+	 * If equal, transmuting already occurred in
+	 * smack_dentry_create_files_as(). No need to check again.
+	 */
+	if (tsp->smk_task != tsp->smk_transmuted) {
+		rcu_read_lock();
+		may = smk_access_entry(skp->smk_known, dsp->smk_known,
+				       &skp->smk_rules);
+		rcu_read_unlock();
+	}
+
+	/*
+	 * In addition to having smk_task equal to smk_transmuted,
+	 * if the access rule allows transmutation and the directory
+	 * requests transmutation then by all means transmute.
+	 * Mark the inode as changed.
+	 */
+	if ((tsp->smk_task == tsp->smk_transmuted) ||
+	    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+	     smk_inode_transmutable(dir))) {
+		struct xattr *xattr_transmute;
 
 		/*
-		 * In addition to having smk_task equal to smk_transmuted,
-		 * if the access rule allows transmutation and the directory
-		 * requests transmutation then by all means transmute.
-		 * Mark the inode as changed.
+		 * The caller of smack_dentry_create_files_as()
+		 * should have overridden the current cred, so the
+		 * inode label was already set correctly in
+		 * smack_inode_alloc_security().
 		 */
-		if ((tsp->smk_task == tsp->smk_transmuted) ||
-		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		     smk_inode_transmutable(dir))) {
-			struct xattr *xattr_transmute;
-
-			/*
-			 * The caller of smack_dentry_create_files_as()
-			 * should have overridden the current cred, so the
-			 * inode label was already set correctly in
-			 * smack_inode_alloc_security().
-			 */
-			if (tsp->smk_task != tsp->smk_transmuted)
-				isp = dsp;
-			xattr_transmute = lsm_get_xattr_slot(xattrs,
-							     xattr_count);
-			if (xattr_transmute) {
-				xattr_transmute->value = kmemdup(TRANS_TRUE,
-								 TRANS_TRUE_SIZE,
-								 GFP_NOFS);
-				if (!xattr_transmute->value)
-					return -ENOMEM;
-
-				xattr_transmute->value_len = TRANS_TRUE_SIZE;
-				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
-			}
+		if (tsp->smk_task != tsp->smk_transmuted)
+			isp = dsp;
+		xattr_transmute = lsm_get_xattr_slot(xattrs,
+						     xattr_count);
+		if (xattr_transmute) {
+			xattr_transmute->value = kmemdup(TRANS_TRUE,
+							 TRANS_TRUE_SIZE,
+							 GFP_NOFS);
+			if (!xattr_transmute->value)
+				return -ENOMEM;
+
+			xattr_transmute->value_len = TRANS_TRUE_SIZE;
+			xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
 		}
+	}
 
+	if (xattr) {
 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
 		if (!xattr->value)
 			return -ENOMEM;
-- 
2.34.1

