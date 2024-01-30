Return-Path: <linux-kernel+bounces-43724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE974841864
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F00A1F24931
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C936B1A;
	Tue, 30 Jan 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAAuZhTk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7166364CA;
	Tue, 30 Jan 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578559; cv=none; b=B7/eIvYQDCAjZqFL1vuR32/B1dyD+ym4vM5ki8yKL9kVUPWYHKICk1qnwGtWDBKDGRq+DLxfj1MdBcUhpGo7uypSa+Xob2j0cYYbzEI3hjTC1G4fzr/VxqQB+x+9ubsj1FZAL9n6FPMLmq+D8DdtjdioHUiiMQadSxpHAalLxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578559; c=relaxed/simple;
	bh=OvMM8iJkFhvWNhsVLNub4HhcW21nuv8NW9IL6jHpWeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9rJZ8JPNK0zYLMrz+Z3dV7dhSGT0WSIXt/n3V46eo8v9CX7QAkuDweSbKRwb5ovKFTUwWQ3VxdaDUcuaxf4MJ2+7b8MnCzk2Zkl2tdeL06fhAtB8FZWZ22wjyYL10Y2sJ1R3kxP9I+9331Olr7fQ8WEUbrsKhWzbYfGRBxX5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAAuZhTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0964FC43330;
	Tue, 30 Jan 2024 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578559;
	bh=OvMM8iJkFhvWNhsVLNub4HhcW21nuv8NW9IL6jHpWeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAAuZhTk9Ynq9mnYQP2Pkmcbpcd5Lg6BDiyjM+rZXnkWTHikCQS1p9FHvI24SkFhD
	 ZdhKkrHuUzxpbRD/VtTqVpzP0p+HECcFBDoPaDHb5356mZzQC2joaa14LWsPrDuGfB
	 lJoV1XYenWuoKc3znKqn8HLKPeKxHvYJtmWfopvS/Z5aAViVj17+6NmxfJVPcyDj8G
	 Ue/aEGz9BUlxrfWlCSAOQD4ejnXtZXptj80MiSBKwxqs2FpaIehQdmnbmPE8ooRgT0
	 EvBuZRpWCsb/FbF4hz5ysYQZXWg85FXnwU0SECSbVZp7NPKKPdr50dZkyM2fr9o0lL
	 gA1Iyha6cBm4A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mm/damon/dbgfs: make debugfs interface deprecation message a macro
Date: Mon, 29 Jan 2024 17:35:43 -0800
Message-Id: <20240130013549.89538-5-sj@kernel.org>
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

DAMON debugfs interface deprecation message is written twice, once for
the warning, and again for DEPRECATED file's read output.  De-duplicate
those by defining the message as a macro and reuse.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index fc6ece5a9f37..fbc0cd63f34c 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -15,6 +15,11 @@
 #include <linux/page_idle.h>
 #include <linux/slab.h>
 
+#define DAMON_DBGFS_DEPRECATION_NOTICE					\
+	"DAMON debugfs interface is deprecated, so users should move "	\
+	"to DAMON_SYSFS. If you cannot, please report your usecase to "	\
+	"damon@lists.linux.dev and linux-mm@kvack.org.\n"
+
 static struct damon_ctx **dbgfs_ctxs;
 static int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
@@ -22,10 +27,7 @@ static DEFINE_MUTEX(damon_dbgfs_lock);
 
 static void damon_dbgfs_warn_deprecation(void)
 {
-	pr_warn_once("DAMON debugfs interface is deprecated, "
-		     "so users should move to DAMON_SYSFS. If you cannot, "
-		     "please report your usecase to damon@lists.linux.dev and "
-		     "linux-mm@kvack.org.\n");
+	pr_warn_once(DAMON_DBGFS_DEPRECATION_NOTICE);
 }
 
 /*
@@ -808,10 +810,7 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
 static ssize_t damon_dbgfs_deprecated_read(struct file *file,
 		char __user *buf, size_t count, loff_t *ppos)
 {
-	char kbuf[512] = "DAMON debugfs interface is deprecated, "
-		     "so users should move to DAMON_SYSFS. If you cannot, "
-		     "please report your usecase to damon@lists.linux.dev and "
-		     "linux-mm@kvack.org.\n";
+	char kbuf[512] = DAMON_DBGFS_DEPRECATION_NOTICE;
 	int len = strnlen(kbuf, 1024);
 
 	return simple_read_from_buffer(buf, count, ppos, kbuf, len);
-- 
2.39.2


