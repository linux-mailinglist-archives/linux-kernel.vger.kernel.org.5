Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5037D35D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjJWLxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjJWLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:53:51 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7DF9;
        Mon, 23 Oct 2023 04:53:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VukpfTY_1698062022;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VukpfTY_1698062022)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 19:53:43 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc:     zyfjeff@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: make delete_stale configurable
Date:   Mon, 23 Oct 2023 19:53:41 +0800
Message-Id: <20231023115341.60127-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifei Zhang <zyfjeff@linux.alibaba.com>

Fuse tends to cache dentries in LRU list for performance, which makes
the fuse server always keep a reference to the opened fd.  If the file
is deleted by a third party process (neither fuse server nor fuse
client), the fuse server will always keep a reference to the deleted
file, in which case the deleted file cannot be released.

Fix this by making the delete_stale feature configurable.  Fuse servers
can enable this if a file may be unlinked not through fuse server nor
client.  Actually virtiofs enables this by default.  Make this
configurable for other fuse filesystems.

Signed-off-by: Yifei Zhang <zyfjeff@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/inode.c           | 5 ++++-
 include/uapi/linux/fuse.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..635bf0b11147 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1234,6 +1234,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->create_supp_group = 1;
 			if (flags & FUSE_DIRECT_IO_RELAX)
 				fc->direct_io_relax = 1;
+			if (flags & FUSE_DELETE_STALE)
+				fc->delete_stale = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1280,7 +1282,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_RELAX;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_RELAX |
+		FUSE_DELETE_STALE;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index db92a7202b34..8d0926d21d2e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -411,6 +411,7 @@ struct fuse_file_lock {
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  * FUSE_DIRECT_IO_RELAX: relax restrictions in FOPEN_DIRECT_IO mode, for now
  *                       allow shared mmap
+ * FUSE_DELETE_STALE:	delete dentry if timeout is zero
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -450,6 +451,7 @@ struct fuse_file_lock {
 #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 #define FUSE_DIRECT_IO_RELAX	(1ULL << 36)
+#define FUSE_DELETE_STALE	(1ULL << 37)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.19.1.6.gb485710b

