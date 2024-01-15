Return-Path: <linux-kernel+bounces-25611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123482D38C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 04:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD24281515
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663D2568;
	Mon, 15 Jan 2024 03:56:29 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2C63920F4;
	Mon, 15 Jan 2024 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 161F46019B694;
	Mon, 15 Jan 2024 11:56:18 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: mcgrof@kernel.org,
	keescook@chromium.org,
	yzaikin@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] proc: proc_sysctl: Optimize proc_sys_fill_cache() variable
Date: Mon, 15 Jan 2024 11:56:14 +0800
Message-Id: <20240115035614.26187-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The ino and type variables are assigned values before use, and they do
not need to be assigned values when defined.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/proc/proc_sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c88854df0b624..cdda684551599 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -683,8 +683,8 @@ static bool proc_sys_fill_cache(struct file *file,
 	struct dentry *child, *dir = file->f_path.dentry;
 	struct inode *inode;
 	struct qstr qname;
-	ino_t ino = 0;
-	unsigned type = DT_UNKNOWN;
+	ino_t ino;
+	unsigned type;
 
 	qname.name = table->procname;
 	qname.len  = strlen(table->procname);
-- 
2.18.2


