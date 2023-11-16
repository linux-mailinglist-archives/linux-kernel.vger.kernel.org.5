Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DDD7EDD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjKPJCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbjKPJCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:02:25 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B9A4;
        Thu, 16 Nov 2023 01:02:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SWDBy4mt2z9v7YZ;
        Thu, 16 Nov 2023 16:45:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAnY3Nq2lVlSdzEAA--.16671S7;
        Thu, 16 Nov 2023 10:02:01 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 5/5] ramfs: Initialize security of in-memory inodes
Date:   Thu, 16 Nov 2023 10:01:25 +0100
Message-Id: <20231116090125.187209-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
References: <20231116090125.187209-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAnY3Nq2lVlSdzEAA--.16671S7
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1ftr1UKrW5JF4UWrWktFb_yoW5GF4DpF
        42qas8Gwn5XFyxWr1ftF4Duw1SgayfKr4DJw4xZw1xA3Z3Xw1DtF1Syr13CF1rJrW8Gw1I
        qr4Y9r1UC3W5ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5KFoAABsC
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

Add a call security_inode_init_security() after ramfs_get_inode(), to let
LSMs initialize the inode security field. Skip ramfs_fill_super(), as the
initialization is done through the sb_set_mnt_opts hook.

Calling security_inode_init_security() call inside ramfs_get_inode() is
not possible since, for CONFIG_SHMEM=n, tmpfs also calls the former after
the latter.

Pass NULL as initxattrs() callback to security_inode_init_security(), since
the purpose of the call is only to initialize the in-memory inodes.

Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/ramfs/inode.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 4ac05a9e25bc..8006faaaf0ec 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -102,11 +102,20 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	int error = -ENOSPC;
 
 	if (inode) {
+		error = security_inode_init_security(inode, dir,
+						     &dentry->d_name, NULL,
+						     NULL);
+		if (error) {
+			iput(inode);
+			goto out;
+		}
+
 		d_instantiate(dentry, inode);
 		dget(dentry);	/* Extra count - pin the dentry in core */
 		error = 0;
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	}
+out:
 	return error;
 }
 
@@ -134,6 +143,15 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	inode = ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
+
+		error = security_inode_init_security(inode, dir,
+						     &dentry->d_name, NULL,
+						     NULL);
+		if (error) {
+			iput(inode);
+			goto out;
+		}
+
 		error = page_symlink(inode, symname, l);
 		if (!error) {
 			d_instantiate(dentry, inode);
@@ -143,6 +161,7 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		} else
 			iput(inode);
 	}
+out:
 	return error;
 }
 
@@ -150,12 +169,23 @@ static int ramfs_tmpfile(struct mnt_idmap *idmap,
 			 struct inode *dir, struct file *file, umode_t mode)
 {
 	struct inode *inode;
+	int error;
 
 	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
 	if (!inode)
 		return -ENOSPC;
+
+	error = security_inode_init_security(inode, dir,
+					     &file_dentry(file)->d_name, NULL,
+					     NULL);
+	if (error) {
+		iput(inode);
+		goto out;
+	}
+
 	d_tmpfile(file, inode);
-	return finish_open_simple(file, 0);
+out:
+	return finish_open_simple(file, error);
 }
 
 static const struct inode_operations ramfs_dir_inode_operations = {
-- 
2.34.1

