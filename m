Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0497E8189
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbjKJS3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346571AbjKJS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E6C83FB;
        Thu,  9 Nov 2023 23:24:56 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SRVb85pfpzMmdt;
        Fri, 10 Nov 2023 15:20:20 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 15:24:50 +0800
From:   Zizhi Wo <wozizhi@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <akpm@linux-foundation.org>, <oleg@redhat.com>,
        <jlayton@kernel.org>, <dchinner@redhat.com>, <adobriyan@gmail.com>,
        <yang.lee@linux.alibaba.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wozizhi@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH next V3] proc: support file->f_pos checking in mem_lseek
Date:   Fri, 10 Nov 2023 23:19:28 +0800
Message-ID: <20231110151928.2667204-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WoZ1zh1 <wozizhi@huawei.com>

In mem_lseek, file->f_pos may overflow. And it's not a problem that
mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
(kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
file->f_pos updated to an abnormal number, fix it by checking overflow and
FMODE_UNSIGNED_OFFSET.

Signed-off-by: WoZ1zh1 <wozizhi@huawei.com>
---
 fs/proc/base.c     | 31 +++++++++++++++++++++++--------
 fs/read_write.c    |  5 -----
 include/linux/fs.h |  5 ++++-
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index dd31e3b6bf77..20f5fcf6b73e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -903,18 +903,33 @@ static ssize_t mem_write(struct file *file, const char __user *buf,
 
 loff_t mem_lseek(struct file *file, loff_t offset, int orig)
 {
+	loff_t ret = 0;
+
+	spin_lock(&file->f_lock);
 	switch (orig) {
-	case 0:
-		file->f_pos = offset;
-		break;
-	case 1:
-		file->f_pos += offset;
+	case SEEK_CUR:
+		offset += file->f_pos;
+		fallthrough;
+	case SEEK_SET:
+		/* to avoid userland mistaking f_pos=-9 as -EBADF=-9 */
+		if ((unsigned long long)offset >= -MAX_ERRNO)
+			ret = -EOVERFLOW;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	force_successful_syscall_return();
-	return file->f_pos;
+	if (!ret) {
+		if (offset < 0 && !(unsigned_offsets(file))) {
+			ret = -EINVAL;
+		} else {
+			file->f_pos = offset;
+			ret = file->f_pos;
+			force_successful_syscall_return();
+		}
+	}
+
+	spin_unlock(&file->f_lock);
+	return ret;
 }
 
 static int mem_release(struct inode *inode, struct file *file)
diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..2f456d5a1df5 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -34,11 +34,6 @@ const struct file_operations generic_ro_fops = {
 
 EXPORT_SYMBOL(generic_ro_fops);
 
-static inline bool unsigned_offsets(struct file *file)
-{
-	return file->f_mode & FMODE_UNSIGNED_OFFSET;
-}
-
 /**
  * vfs_setpos - update the file offset for lseek
  * @file:	file structure in question
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..dde0756d2350 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2994,7 +2994,10 @@ extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 		loff_t *opos, size_t len, unsigned int flags);
 
-
+static inline bool unsigned_offsets(struct file *file)
+{
+	return file->f_mode & FMODE_UNSIGNED_OFFSET;
+}
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
 extern loff_t noop_llseek(struct file *file, loff_t offset, int whence);
-- 
2.39.2

