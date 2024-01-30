Return-Path: <linux-kernel+bounces-45157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC70842C42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329861F26702
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402D762D9;
	Tue, 30 Jan 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HE4bR2zZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20788762CE;
	Tue, 30 Jan 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641461; cv=none; b=iWDtrsQTVlFu5eCKEMyxxGsdFA607TjAzbQNad4n/BLhTURrlbV68I9tYRJJ3DvGLmIHKY5lJUsyezLUarsSilmiSs2WrsY1kOfgmxmfGWgJF8GDZmLdeGKWyXW28ITHXZJNJiUZAQMfuvWa1r8oz8SjUBy1QFreZryyFdvbC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641461; c=relaxed/simple;
	bh=VfkCiOcbDiF97nCdF1XS/rB91kgxot2LBBvCXyBvEHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCb56iAsAPw5P1qSTGqAt9q60jE73ofoLOjw4aIQYvPiGT+kcPvUTy795FHZEwQZmrAv4kxJXS20RvrU4ziLaq9yGkvYBXnbBMsgvoXStAl5sFrRHlJkBbVfE68h82rTXN/N3jluFIogg7bCNQ3ZsqOyCquPSQNQrNG81iQ3FDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HE4bR2zZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695FAC433C7;
	Tue, 30 Jan 2024 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706641460;
	bh=VfkCiOcbDiF97nCdF1XS/rB91kgxot2LBBvCXyBvEHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE4bR2zZg6i+6WEvZ49qbdu3atDQF/Z8KiZkSjdlT+O1NoUOIzsHjUoIRCP0QPJPP
	 aJ4XKQn5U4yPeZG9xliQ//NBL4c/PRXF4H9a/nrpDxp+YP61Y7NoCjk25mH6+H2tL8
	 w4VfRlXOs48PNEwx2vOS8lxTp5vkNw+uvpbN60D0=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/6] eventfs: remove unused 'd_parent' pointer field
Date: Tue, 30 Jan 2024 11:03:53 -0800
Message-ID: <20240130190355.11486-4-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.43.0.5.g38fb137bdb
In-Reply-To: <20240130190355.11486-1-torvalds@linux-foundation.org>
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's never used

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 fs/tracefs/event_inode.c | 4 +---
 fs/tracefs/internal.h    | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ad11063bdd53..1d0102bfd7da 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -685,10 +685,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	INIT_LIST_HEAD(&ei->list);
 
 	mutex_lock(&eventfs_mutex);
-	if (!parent->is_freed) {
+	if (!parent->is_freed)
 		list_add_tail(&ei->list, &parent->children);
-		ei->d_parent = parent->dentry;
-	}
 	mutex_unlock(&eventfs_mutex);
 
 	/* Was the parent freed? */
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 91c2bf0b91d9..8f38740bfb5b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -35,7 +35,6 @@ struct eventfs_attr {
  * @name:	the name of the directory to create
  * @children:	link list into the child eventfs_inode
  * @dentry:     the dentry of the directory
- * @d_parent:   pointer to the parent's dentry
  * @d_children: The array of dentries to represent the files when created
  * @entry_attrs: Saved mode and ownership of the @d_children
  * @attr:	Saved mode and ownership of eventfs_inode itself
@@ -50,7 +49,6 @@ struct eventfs_inode {
 	const char			*name;
 	struct list_head		children;
 	struct dentry			*dentry; /* Check is_freed to access */
-	struct dentry			*d_parent;
 	struct dentry			**d_children;
 	struct eventfs_attr		*entry_attrs;
 	struct eventfs_attr		attr;
-- 
2.43.0.5.g38fb137bdb


