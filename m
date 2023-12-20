Return-Path: <linux-kernel+bounces-6629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D9B819B32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205F92865AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9641D6BA;
	Wed, 20 Dec 2023 09:15:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B911D6AE;
	Wed, 20 Dec 2023 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3BK9ELam045394;
	Wed, 20 Dec 2023 17:14:21 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Sw7516cbWz2PrKRR;
	Wed, 20 Dec 2023 17:08:05 +0800 (CST)
Received: from tj10388pcu.spreadtrum.com (10.5.32.11) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 20 Dec 2023 17:14:19 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: Dongliang Cui <cuidongliang390@gmail.com>,
        Hongyu Jin
	<hongyu.jin@unisoc.com>
Subject: [PATCH]eventfs: Apply the gid in the mounting parameters to all files
Date: Wed, 20 Dec 2023 17:15:06 +0800
Message-ID: <1703063706-30539-1-git-send-email-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 3BK9ELam045394

I found that in the latest version, the nodes of 
tracefs have been changed to dynamically created.

This has caused me to encounter a problem where 
the gid I specified in the mounting parameters 
cannot apply to all files, as in the following
situation:

/data/tmp/events # mount | grep tracefs
tracefs on /data/tmp type tracefs (rw,seclabel,relatime,gid=3012)

gid 3012 = readtracefs

/data/tmp # ls -lh
total 0
-r--r-----   1 root readtracefs 0 1970-01-01 08:00 README
-r--r-----   1 root readtracefs 0 1970-01-01 08:00 available_events

ums9621_1h10:/data/tmp/events # ls -lh
total 0
drwxr-xr-x 2 root root 0 2023-12-19 00:56 alarmtimer
drwxr-xr-x 2 root root 0 2023-12-19 00:56 asoc

It will prevent certain applications from accessing
tracefs properly, I try to avoid this issue by making 
the following modifications.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
---
 fs/tracefs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index ae648de..5296ff7 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -560,6 +560,16 @@ struct dentry *eventfs_failed_creating(struct dentry *dentry)
  */
 struct dentry *eventfs_end_creating(struct dentry *dentry)
 {
+	struct tracefs_fs_info *fsi;
+	struct tracefs_mount_opts *opts;
+
+	if (dentry && dentry->d_inode) {
+		fsi = dentry->d_inode->i_sb->s_fs_info;
+		opts = &fsi->mount_opts;
+		if (opts->opts & BIT(Opt_gid))
+			change_gid(dentry, opts->gid);
+	}
+
 	return dentry;
 }
 
-- 
2.7.4



