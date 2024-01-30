Return-Path: <linux-kernel+bounces-43723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381BC841862
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36C31F2448C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9B36AE9;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar1EzV9w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49835364AB;
	Tue, 30 Jan 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578559; cv=none; b=ElfeLCKVnrr+ajWowBzW6n0HbJqk8GpUFjG924o1VsYn8i0gSSHsaLfcSYbA/cNhrJlfIRzbDezAWRy8HGwpOQaLxiuKia3X3tJrZphARWBOkynp4fb70wUfAZR0Exn7i4GWy72sKm/8s2Ecz2QL7kEGf1sZIT+gGyCoCYI2do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578559; c=relaxed/simple;
	bh=ZtqTd8FEkkcClpmqlfGDvu7x6/2aDbjjseJMMQvFCaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIwTugF/iO9yuYoLuCP1dDmWLFrstz5reyDidizMSzpGvhy7e7WthLxmd4GEgXZJr4bEXFZB4jrVi2aToMPBQCh4sCykxiDD8WVAONWzCKGGfgPrJ8mpljqQ2SgkAg8jzETZ3ZMZcridXumKPdNL3X9PTXmukNHJWV1lZ5j5Qxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar1EzV9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7BFC43399;
	Tue, 30 Jan 2024 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578558;
	bh=ZtqTd8FEkkcClpmqlfGDvu7x6/2aDbjjseJMMQvFCaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ar1EzV9wNYgpLqVA34gUAYP+W08RR2XTVvtZgE00US0nj7kI9ZKC/9C//HPb7yjPx
	 1P28YQXu6KYnZhxlnPAyRzaD3EoOMiaVBemIcYC0xbUylzOSVORSSk6jrcjA1FOhz/
	 cG/tuWrU4q4wEt4TNO4bk6MHsQfTZPYx4olpMaknqtNkDxF1YAv8djDsfC/HMrnrXi
	 TD5uvIub3mm3mocZ4dVFSt2/xzN6eCDURNSZ5UJDVTu0ij5WT0G5X/M1nyFryHy/Cx
	 R9c83IgtwWEXPgx8V5U7cFDaq/ZC4y7Ubvj4D3sG0UMkDRG1ezz8rcDh6O1XpvtMVr
	 VUSdhLduqygrw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] mm/damon/dbgfs: implement deprecation notice file
Date: Mon, 29 Jan 2024 17:35:42 -0800
Message-Id: <20240130013549.89538-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240130013549.89538-1-sj@kernel.org>
References: <20240130013549.89538-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a read-only file for DAMON debugfs interface deprecation
notice, to let users who manually read/write the DAMON debugfs files
from their shell command line easily notice the fact.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 7dac24e69e3b..fc6ece5a9f37 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -805,6 +805,18 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
 	damon_destroy_ctx(ctx);
 }
 
+static ssize_t damon_dbgfs_deprecated_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	char kbuf[512] = "DAMON debugfs interface is deprecated, "
+		     "so users should move to DAMON_SYSFS. If you cannot, "
+		     "please report your usecase to damon@lists.linux.dev and "
+		     "linux-mm@kvack.org.\n";
+	int len = strnlen(kbuf, 1024);
+
+	return simple_read_from_buffer(buf, count, ppos, kbuf, len);
+}
+
 /*
  * Make a context of @name and create a debugfs directory for it.
  *
@@ -1056,6 +1068,10 @@ static int damon_dbgfs_static_file_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
+static const struct file_operations deprecated_fops = {
+	.read = damon_dbgfs_deprecated_read,
+};
+
 static const struct file_operations mk_contexts_fops = {
 	.open = damon_dbgfs_static_file_open,
 	.write = dbgfs_mk_context_write,
@@ -1076,9 +1092,9 @@ static int __init __damon_dbgfs_init(void)
 {
 	struct dentry *dbgfs_root;
 	const char * const file_names[] = {"mk_contexts", "rm_contexts",
-		"monitor_on"};
+		"monitor_on", "DEPRECATED"};
 	const struct file_operations *fops[] = {&mk_contexts_fops,
-		&rm_contexts_fops, &monitor_on_fops};
+		&rm_contexts_fops, &monitor_on_fops, &deprecated_fops};
 	int i;
 
 	dbgfs_root = debugfs_create_dir("damon", NULL);
-- 
2.39.2


