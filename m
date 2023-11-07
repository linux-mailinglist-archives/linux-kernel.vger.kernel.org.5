Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8B7E3672
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjKGIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjKGIOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:14:08 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8771FE8;
        Tue,  7 Nov 2023 00:14:03 -0800 (PST)
X-QQ-mid: bizesmtp91t1699344838tve14rzx
Received: from localhost.localdomain ( [175.11.90.246])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 07 Nov 2023 16:13:52 +0800 (CST)
X-QQ-SSF: 00400000000000O0T000000A0000000
X-QQ-FEAT: 3M0okmaRx3gmxPjUV56yDKvB3Uhj8OcIpw7vWvpFGbsFfrB+bfwV7TozelY5e
        DMI/DxjOU8Tal584vSNyxOx5pZja88QCqwwjIl0o4CnUzPFLiXAU5V+M/gM+ILYnZlGx2fL
        Jtl2leZXWwQhqffFZSUUQEocdjWH3F4eOS62spWgc7UHKQqsP8msvrB1ZrTyn/0osDH2IbE
        vLMPurMnhNfp3gYSRyxXgXcSFR8EijFT4Tc5E7FQEEtmDyQ5kGlsh+q0H5Fhu9zhx67geNf
        LIX4c7sTyfsZqkCglfVxYcWEEYPYE2251UY5+kro/DpLtPKHGkK0BdTXZKmtZBmMBpLtKWV
        B1POWAVC+ErxfxG5NqfZuSDd+jfAvfTIqZSM81S0nMdu5b7Xn/ktDwb+Q498ZuzIU6ci3Qs
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11280650343400386784
From:   Zhou Jifeng <zhoujifeng@kylinos.com.cn>
To:     zhoujifeng@kylinos.com.cn
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu
Subject: [PATCH v2] fuse: Track process write operations in both direct and writethrough modes
Date:   Tue,  7 Nov 2023 16:13:50 +0800
Message-Id: <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
References: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.com.cn:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v1 -> v2: Fix "Miss error code" issue

 fs/fuse/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1cdb6327511e..4846ab8c01cf 100644
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
@@ -1330,6 +1332,9 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err <= 0)
 		goto out;
 
+	count = err;
+	task_io_account_write(count);
+
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -1600,6 +1605,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
+		task_io_account_write(res);
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
 			res = fuse_direct_IO(iocb, from);
 		} else {
-- 
2.18.1

