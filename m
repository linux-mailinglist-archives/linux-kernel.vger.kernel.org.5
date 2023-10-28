Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4E7DA565
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJ1G7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 02:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1G7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 02:59:30 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9B7E3;
        Fri, 27 Oct 2023 23:59:24 -0700 (PDT)
X-QQ-mid: bizesmtp63t1698476359tcw69q76
Received: from localhost.localdomain ( [175.10.24.131])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 28 Oct 2023 14:59:13 +0800 (CST)
X-QQ-SSF: 00400000000000O0T000000A0000000
X-QQ-FEAT: S0uf0xb+BQn1Qs6ENthHsLfFauTVfiNdT4Kdi4ekkZOrMzbIs+8ImU0wAvR5U
        GehrhuypVGXjps3h1ip/EFdWFlYbfZ1PiHxGEXt+RRO1215o398S9M2A2RnHRfKM2QmCQNH
        QwOROKIvO596jthBOGmMCjaOgU7a3SoRA9TMiVi8v40cAhCMbiL5a9x7UHSCNoFbaUSZdiy
        5/MJm4a3qVk/SBv5pUqPwlz3Pvn5PEKiqiPv2nNVQQQApH83PT7eF8ysr5rdoyPsopUfSeO
        pTKMXOPVjUvns7108Y++J1ntULyLTBUfkv/ZUGyCu85wywdbZmmTaTD2LiWAMafFHiZY5OQ
        RP345d+IHz/XC+5tDAHQW8ZVhvcJwN3ToSL3HQNl9nuLu+9khE3t5psQv1iew==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11460424809230058568
From:   Zhou Jifeng <zhoujifeng@kylinos.com.cn>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Subject: [PATCH] fuse: Track process write operations in both direct and writethrough modes
Date:   Sat, 28 Oct 2023 14:59:12 +0800
Message-Id: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.com.cn:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the fact that fuse does not count the write IO of processes in the
direct and writethrough write modes, user processes cannot track
write_bytes through the “/proc/[pid]/io” path. For example, the system
tool iotop cannot count the write operations of the corresponding process.

Signed-off-by: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
---
 fs/fuse/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..6051d2e2a021 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
+#include <linux/task_io_accounting_ops.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -1305,6 +1306,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t written = 0;
 	struct inode *inode = mapping->host;
 	ssize_t err;
+	ssize_t count;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	if (fc->writeback_cache) {
@@ -1326,10 +1328,12 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 writethrough:
 	inode_lock(inode);
 
-	err = generic_write_checks(iocb, from);
-	if (err <= 0)
+	count = generic_write_checks(iocb, from);
+	if (count <= 0)
 		goto out;
 
+	task_io_account_write(count);
+
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -1600,6 +1604,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
+		task_io_account_write(res);
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
-- 
2.18.1

