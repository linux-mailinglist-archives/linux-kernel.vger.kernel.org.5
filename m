Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4994B7EDD48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjKPJC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345007AbjKPJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:02:14 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E1D4B;
        Thu, 16 Nov 2023 01:02:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SWDBm30Bzz9ycMw;
        Thu, 16 Nov 2023 16:45:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnY3Nq2lVlSdzEAA--.16671S6;
        Thu, 16 Nov 2023 10:01:56 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 4/5] smack: Initialize the in-memory inode in smack_inode_init_security()
Date:   Thu, 16 Nov 2023 10:01:24 +0100
Message-Id: <20231116090125.187209-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAnY3Nq2lVlSdzEAA--.16671S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCry8WFWfGF4kAw18GFW5Awb_yoW5Zw13pF
        Zxt3W7KwnYyF97WrWvyF47Ww1SkayFkr4UGrZxJr1xA3Zrtw1xKF1Fqr45ZF15Wr4kZa1F
        va1j9ry3WFn0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5KFoAAAsD
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Currently, Smack initializes in-memory new inodes in three steps. It first
sets the xattrs in smack_inode_init_security(), fetches them in
smack_d_instantiate() and finally, in the same function, sets the in-memory
inodes depending on xattr values, unless they are in specially-handled
filesystems.

Other than being inefficient, this also prevents filesystems not supporting
xattrs from working properly since, without xattrs, there is no way to pass
the label determined in smack_inode_init_security() to
smack_d_instantiate().

Since the LSM infrastructure allows setting and getting the security field
without xattrs through the inode_setsecurity and inode_getsecurity hooks,
make the inode creation work too, by initializing the in-memory inode
earlier in smack_inode_init_security().

Also mark the inode as instantiated, to prevent smack_d_instantiate() from
overwriting the security field. As mentioned above, this potentially has
impact for inodes in specially-handled filesystems in
smack_d_instantiate(), if they are not handled in the same way in
smack_inode_init_security().

Filesystems other than tmpfs don't call security_inode_init_security(), so
they would be always initialized in smack_d_instantiate(), as before. For
tmpfs, the current behavior is to assign to inodes the label '*', but
actually that label is overwritten with the one fetched from the SMACK64
xattr, set in smack_inode_init_security() (default: '_').

Initializing the in-memory inode is straightforward: if not transmuting,
nothing more needs to be done; if transmuting, overwrite the current inode
label with the one from the parent directory, and set SMK_INODE_TRANSMUTE.
Finally, set SMK_INODE_INSTANT for all cases, to mark the inode as
instantiated.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/smack/smack_lsm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 72f97492f5c3..43e9389cbdfa 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -993,6 +993,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     struct xattr *xattrs, int *xattr_count)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
+	struct inode_smack *issp = smack_inode(inode);
 	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
@@ -1028,7 +1029,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		 * smack_inode_alloc_security().
 		 */
 		if (tsp->smk_task != tsp->smk_transmuted)
-			isp = dsp;
+			isp = issp->smk_inode = dsp;
+
+		issp->smk_flags |= SMK_INODE_TRANSMUTE;
 		xattr_transmute = lsm_get_xattr_slot(xattrs,
 						     xattr_count);
 		if (xattr_transmute) {
@@ -1043,6 +1046,8 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		}
 	}
 
+	issp->smk_flags |= SMK_INODE_INSTANT;
+
 	if (xattr) {
 		xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
 		if (!xattr->value)
-- 
2.34.1

