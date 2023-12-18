Return-Path: <linux-kernel+bounces-3416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CBD816BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842F5B22F33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAD199A0;
	Mon, 18 Dec 2023 11:09:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E235199B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BIB8Ygh044195;
	Mon, 18 Dec 2023 19:08:34 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Stxjq3bTwz2PjHGh;
	Mon, 18 Dec 2023 19:02:23 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 18 Dec 2023 19:08:33 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH V3] f2fs: show more discard status by sysfs
Date: Mon, 18 Dec 2023 19:07:56 +0800
Message-ID: <1702897676-12851-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 3BIB8Ygh044195

The current pending_discard attr just only shows the discard_cmd_cnt
information. More discard status can be shown so that we can check
them through sysfs when needed.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
changes of v2: Improve the patch according to Chao's suggestions.
changes of v3: Add a blank line for easy reading.
---
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/sysfs.c                         | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

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
index 417fae96..312a4dc 100644
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
@@ -1197,9 +1213,12 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
 
 F2FS_GENERAL_RO_ATTR(sb_status);
 F2FS_GENERAL_RO_ATTR(cp_status);
+F2FS_GENERAL_RO_ATTR(discard_status);
+
 static struct attribute *f2fs_stat_attrs[] = {
 	ATTR_LIST(sb_status),
 	ATTR_LIST(cp_status),
+	ATTR_LIST(discard_status),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
-- 
1.9.1


