Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DDD7BE22B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376743AbjJIOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346526AbjJIOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:11:23 -0400
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47BE091
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:11:20 -0700 (PDT)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id DFA7F3E1B16;
        Mon,  9 Oct 2023 17:11:16 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Joel Becker <jlbec@evilplan.org>, Mark Fasheh <mark@fasheh.com>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Kurt Hackel <kurt.hackel@oracle.com>,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] fs: ocfs2: Check status values
Date:   Mon,  9 Oct 2023 17:11:11 +0300
Message-Id: <20231009141111.149858-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180481 [Oct 09 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 536 536 1ae19c7800f69da91432b5e67ed4a00b9ade0d03, {Tracking_from_domain_doesnt_match_to}, localhost.biz:7.1.1;red-soft.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/09 07:46:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/09 10:51:00 #22099682
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test return values before overwriting.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 fs/ocfs2/namei.c       | 8 ++++++++
 fs/ocfs2/quota_local.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 5cd6d7771cea..836c4279a979 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1597,6 +1597,10 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 	if (update_dot_dot) {
 		status = ocfs2_update_entry(old_inode, handle,
 					    &old_inode_dot_dot_res, new_dir);
+		if (status < 0) {
+			mlog_errno(status);
+			goto bail;
+		}
 		drop_nlink(old_dir);
 		if (new_inode) {
 			drop_nlink(new_inode);
@@ -1636,6 +1640,10 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 							 INODE_CACHE(old_dir),
 							 old_dir_bh,
 							 OCFS2_JOURNAL_ACCESS_WRITE);
+			if (status < 0) {
+				mlog_errno(status);
+				goto bail;
+			}
 			fe = (struct ocfs2_dinode *) old_dir_bh->b_data;
 			ocfs2_set_links_count(fe, old_dir->i_nlink);
 			ocfs2_journal_dirty(handle, old_dir_bh);
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index dfaae1e52412..e09842fc9d4d 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -1240,6 +1240,10 @@ int ocfs2_create_local_dquot(struct dquot *dquot)
 				     &od->dq_local_phys_blk,
 				     &pcount,
 				     NULL);
+	if (status < 0) {
+		mlog_errno(status);
+		goto out;
+	}
 
 	/* Initialize dquot structure on disk */
 	status = ocfs2_local_write_dquot(dquot);
-- 
2.37.3

