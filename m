Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42527F6A09
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXBJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:09:49 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1221BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:09:54 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3AO199em043798;
        Fri, 24 Nov 2023 09:09:09 +0800 (+08)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SbxZ81N8sz2K5kLN;
        Fri, 24 Nov 2023 09:03:44 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 24 Nov 2023 09:09:06 +0800
From:   Zhiguo Niu <zhiguo.niu@unisoc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>
Subject: [PATCH] f2fs: show more discard stat by sysfs
Date:   Fri, 24 Nov 2023 09:08:48 +0800
Message-ID: <1700788128-29002-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3AO199em043798
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current pending_discard attr just only shows the discard_cmd_cnt
information, which is not very meaningful. More discard information
can be shown so that we can check them through sysfs when needed.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/sysfs.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 417fae96..f98e680 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -134,13 +134,22 @@ static ssize_t cp_status_show(struct f2fs_attr *a,
 	return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
 }
 
-static ssize_t pending_discard_show(struct f2fs_attr *a,
+static ssize_t discard_stat_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	if (!SM_I(sbi)->dcc_info)
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	if (!dcc)
 		return -EINVAL;
-	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
-				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
+
+	return sysfs_emit(buf, "%llu, %llu, %llu, %u\n",
+			(unsigned long long)atomic_read(
+				&dcc->discard_cmd_cnt),
+			(unsigned long long)atomic_read(
+				&dcc->issued_discard),
+			(unsigned long long)atomic_read(
+				&dcc->queued_discard),
+			dcc->undiscard_blks);
 }
 
 static ssize_t gc_mode_show(struct f2fs_attr *a,
@@ -1016,7 +1025,7 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
-F2FS_GENERAL_RO_ATTR(pending_discard);
+F2FS_GENERAL_RO_ATTR(discard_stat);
 F2FS_GENERAL_RO_ATTR(gc_mode);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_GENERAL_RO_ATTR(moved_blocks_background);
@@ -1074,7 +1083,7 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 	ATTR_LIST(discard_urgent_util),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(max_ordered_discard),
-	ATTR_LIST(pending_discard),
+	ATTR_LIST(discard_stat),
 	ATTR_LIST(gc_mode),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
-- 
1.9.1

