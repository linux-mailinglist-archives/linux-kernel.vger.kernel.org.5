Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B337E7FB219
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjK1Gtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Gtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:49:42 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119BBE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:49:46 -0800 (PST)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3AS6mhXG087957;
        Tue, 28 Nov 2023 14:48:43 +0800 (+08)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SfXvy5tlyz2K1r9S;
        Tue, 28 Nov 2023 14:43:10 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 28 Nov 2023 14:48:41 +0800
From:   Zhiguo Niu <zhiguo.niu@unisoc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>
Subject: [PATCH V2] f2fs: show more discard status by sysfs
Date:   Tue, 28 Nov 2023 14:48:16 +0800
Message-ID: <1701154096-23883-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 3AS6mhXG087957
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current pending_discard attr just only shows the discard_cmd_cnt
information. More discard status can be shown so that we can check
them through sysfs when needed.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
changes of v2: Improve the patch according to Chao's suggestions.
---
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 36c3cb5..c6970e5 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -498,6 +498,12 @@ Description:	Show status of f2fs checkpoint in real time.
 		CP_RESIZEFS_FLAG		0x00004000
 		=============================== ==============================
 
+What:		/sys/fs/f2fs/<disk>/stat/discard_status
+Date:		November 2023
+Contact:	"Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:	Show status of f2fs discard in real time, including
+		"issued discard","queued discard" and "undiscard blocks".
+
 What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
 Date:		January 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 417fae96..2b80116 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -134,6 +134,22 @@ static ssize_t cp_status_show(struct f2fs_attr *a,
 	return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
 }
 
+static ssize_t discard_status_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	if (!dcc)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%llu, %llu, %u\n",
+			(unsigned long long)atomic_read(
+				&dcc->issued_discard),
+			(unsigned long long)atomic_read(
+				&dcc->queued_discard),
+			dcc->undiscard_blks);
+}
+
 static ssize_t pending_discard_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1197,9 +1213,11 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 
 F2FS_GENERAL_RO_ATTR(sb_status);
 F2FS_GENERAL_RO_ATTR(cp_status);
+F2FS_GENERAL_RO_ATTR(discard_status);
 static struct attribute *f2fs_stat_attrs[] = {
 	ATTR_LIST(sb_status),
 	ATTR_LIST(cp_status),
+	ATTR_LIST(discard_status),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
-- 
1.9.1

