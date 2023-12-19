Return-Path: <linux-kernel+bounces-4592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C440817FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CD51C22446
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68B4411;
	Tue, 19 Dec 2023 02:22:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4174401
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BJ2LOSe060334;
	Tue, 19 Dec 2023 10:21:24 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SvKz30Xv3z2P0R2m;
	Tue, 19 Dec 2023 10:15:11 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 19 Dec 2023 10:21:21 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH V4] f2fs: show more discard status by sysfs
Date: Tue, 19 Dec 2023 10:21:04 +0800
Message-ID: <1702952464-22050-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BJ2LOSe060334

The current pending_discard attr just only shows the discard_cmd_cnt
information. More discard status can be shown so that we can check
them through sysfs when needed.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
changes of v2: Improve the patch according to Chao's suggestions.
changes of v3: Add a blank line for easy reading.
changes of v4: Split to three entries
---
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
 fs/f2fs/sysfs.c                         | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 4f1d4e6..606a298 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -159,6 +159,21 @@ Date:		November 2021
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:	Shows the number of pending discard commands in the queue.
 
+What:           /sys/fs/f2fs/<disk>/issued_discard
+Date:           December 2023
+Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:    Shows the number of issued discard.
+
+What:           /sys/fs/f2fs/<disk>/queued_discard
+Date:           December 2023
+Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:    Shows the number of queued discard.
+
+What:           /sys/fs/f2fs/<disk>/undiscard_blks
+Date:           December 2023
+Contact:        "Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:    Shows the total number of undiscard blocks.
+
 What:		/sys/fs/f2fs/<disk>/max_victim_search
 Date:		January 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7099ffa..666efdd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -143,6 +143,33 @@ static ssize_t pending_discard_show(struct f2fs_attr *a,
 				&SM_I(sbi)->dcc_info->discard_cmd_cnt));
 }
 
+static ssize_t issued_discard_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	if (!SM_I(sbi)->dcc_info)
+		return -EINVAL;
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
+				&SM_I(sbi)->dcc_info->issued_discard));
+}
+
+static ssize_t queued_discard_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	if (!SM_I(sbi)->dcc_info)
+		return -EINVAL;
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
+				&SM_I(sbi)->dcc_info->queued_discard));
+}
+
+static ssize_t undiscard_blks_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	if (!SM_I(sbi)->dcc_info)
+		return -EINVAL;
+	return sysfs_emit(buf, "%u\n",
+				SM_I(sbi)->dcc_info->undiscard_blks);
+}
+
 static ssize_t gc_mode_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1025,6 +1052,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
 F2FS_GENERAL_RO_ATTR(pending_discard);
+F2FS_GENERAL_RO_ATTR(issued_discard);
+F2FS_GENERAL_RO_ATTR(queued_discard);
+F2FS_GENERAL_RO_ATTR(undiscard_blks);
 F2FS_GENERAL_RO_ATTR(gc_mode);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_GENERAL_RO_ATTR(moved_blocks_background);
@@ -1084,6 +1114,9 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 	ATTR_LIST(max_ordered_discard),
 	ATTR_LIST(discard_io_aware),
 	ATTR_LIST(pending_discard),
+	ATTR_LIST(issued_discard),
+	ATTR_LIST(queued_discard),
+	ATTR_LIST(undiscard_blks),
 	ATTR_LIST(gc_mode),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
-- 
1.9.1


