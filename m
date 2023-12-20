Return-Path: <linux-kernel+bounces-6277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755B68196AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315B328841A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07612B84;
	Wed, 20 Dec 2023 02:01:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105E1173B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BK20NML067032;
	Wed, 20 Dec 2023 10:00:23 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4SvxSJ4c8cz2PpQ1x;
	Wed, 20 Dec 2023 09:54:08 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 20 Dec 2023 10:00:21 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH V5] f2fs: show more discard status by sysfs
Date: Wed, 20 Dec 2023 09:59:58 +0800
Message-ID: <1703037598-4359-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 3BK20NML067032

The current pending_discard attr just only shows the discard_cmd_cnt
information. More discard status can be shown so that we can check
them through sysfs when needed.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
changes of v2: Improve the patch according to Chao's suggestions.
changes of v3: Add a blank line for easy reading.
changes of v4: Split to three entries
changes of v5: move these entries from disk/xxx to disk/stat/xxx.
---
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
 fs/f2fs/sysfs.c                         | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 4f1d4e6..99fa87a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -498,6 +498,21 @@ Description:	Show status of f2fs checkpoint in real time.
 		CP_RESIZEFS_FLAG		0x00004000
 		=============================== ==============================
 
+What:		/sys/fs/f2fs/<disk>/stat/issued_discard
+Date:		December 2023
+Contact:	"Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:	Shows the number of issued discard.
+
+What:		/sys/fs/f2fs/<disk>/stat/queued_discard
+Date:		December 2023
+Contact:	"Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:	Shows the number of queued discard.
+
+What:		/sys/fs/f2fs/<disk>/stat/undiscard_blks
+Date:		December 2023
+Contact:	"Zhiguo Niu" <zhiguo.niu@unisoc.com>
+Description:	Shows the total number of undiscard blocks.
+
 What:		/sys/fs/f2fs/<disk>/ckpt_thread_ioprio
 Date:		January 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 7099ffa..c13eef0 100644
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
@@ -1206,9 +1233,16 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 
 F2FS_GENERAL_RO_ATTR(sb_status);
 F2FS_GENERAL_RO_ATTR(cp_status);
+F2FS_GENERAL_RO_ATTR(issued_discard);
+F2FS_GENERAL_RO_ATTR(queued_discard);
+F2FS_GENERAL_RO_ATTR(undiscard_blks);
+
 static struct attribute *f2fs_stat_attrs[] = {
 	ATTR_LIST(sb_status),
 	ATTR_LIST(cp_status),
+	ATTR_LIST(issued_discard),
+	ATTR_LIST(queued_discard),
+	ATTR_LIST(undiscard_blks),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
-- 
1.9.1


