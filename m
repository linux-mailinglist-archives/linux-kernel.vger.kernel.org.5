Return-Path: <linux-kernel+bounces-115610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857E889CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8991C3269D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A771FF7A8;
	Mon, 25 Mar 2024 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrfziV1O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B3130AF2;
	Sun, 24 Mar 2024 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321367; cv=none; b=piKbJzpu9FX3FFiKOLNYZ88gHAoT4LXLjuRkB5541nGKQI7Y6sFtOs5XciQfxhdKY8rQ8j/E+7FtgRVSpLOm1AX7cc1GUcJhBQzZlZzRtjNm89U/E2+je/m8iIkQuTvGDDvsBCOP6N4eb+5x4XK3W1Lt0mt+PoCJcJMYQ7EAVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321367; c=relaxed/simple;
	bh=jOC1QaG75pxY/4EBQxqMHFvdTzj7nAouj7c7sRrQpQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUTYQnMQNu9iWys95wzjXDLI6cpSkgwE/zbZEkG7QEZsPpaY83pNF4EXQq5muk36m88kWCdKj9q29ccLvTFqlh+9CTfmNvS5xQIZKNjSdbNx8O9yMEOyKt5dGqPgyEpgEy4eSksUaXZNKvv7K8CKd9VBS/fCs9HqCjtq4l+Iop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrfziV1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB24C43390;
	Sun, 24 Mar 2024 23:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321366;
	bh=jOC1QaG75pxY/4EBQxqMHFvdTzj7nAouj7c7sRrQpQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrfziV1O19TwDC5Q6xHmpAqYr5/QLKNPArN+QL9JCKf4SMtMr5cpxJ6CyVXM9yoLh
	 LnNbR5SIlrcyRJ9WVOZRJGvGJNyZ9Q1V+F+nFAaV3k8sKav2VuLdm1qqeMFMZE8syD
	 4yBa7TRCZsGjVHuawZenFYSGL6xklDxR9iEp6T7ijBD9zjcN+ETIraOWCvu+aF+tqF
	 1TiVS2FEQXK0IiVKH5D3ksdql2DZ5b2wgFq84ffn0dYNrbckDEDHBJ2uAYXTa8nBc8
	 xKnqrmSpkaZgknna8ja+ajKmtwYvCaAZzyra7eOCv45u6PMjklVbJgrmfcWjBmXjC4
	 4cmyiaVHWnhmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 090/638] ovl: store and show the user provided lowerdir mount option
Date: Sun, 24 Mar 2024 18:52:07 -0400
Message-ID: <20240324230116.1348576-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 0cea4c097d97fdc89de488bd4202d0b087ccec58 ]

We are about to add new mount options for adding lowerdir one by one,
but those mount options will not support escaping.

For the existing case, where lowerdir mount option is provided as a colon
separated list, store the user provided (possibly escaped) string and
display it as is when showing the lowerdir mount option.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: 2824083db76c ("ovl: Always reject mounting over case-insensitive directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/params.c | 46 +++++++++++++++++++++----------------------
 fs/overlayfs/params.h |  1 +
 fs/overlayfs/super.c  |  5 ++++-
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 0059cc405159e..0bf754a69e919 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -332,12 +332,18 @@ static int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
 	return 0;
 }
 
-static void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
+static void ovl_reset_lowerdirs(struct ovl_fs_context *ctx)
 {
-	for (size_t nr = 0; nr < ctx->nr; nr++) {
-		path_put(&ctx->lower[nr].path);
-		kfree(ctx->lower[nr].name);
-		ctx->lower[nr].name = NULL;
+	struct ovl_fs_context_layer *l = ctx->lower;
+
+	// Reset old user provided lowerdir string
+	kfree(ctx->lowerdir_all);
+	ctx->lowerdir_all = NULL;
+
+	for (size_t nr = 0; nr < ctx->nr; nr++, l++) {
+		path_put(&l->path);
+		kfree(l->name);
+		l->name = NULL;
 	}
 	ctx->nr = 0;
 	ctx->nr_data = 0;
@@ -366,7 +372,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	 */
 
 	/* drop all existing lower layers */
-	ovl_parse_param_drop_lowerdir(ctx);
+	ovl_reset_lowerdirs(ctx);
 
 	if (!*name)
 		return 0;
@@ -376,6 +382,11 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		return -EINVAL;
 	}
 
+	// Store user provided lowerdir string to show in mount options
+	ctx->lowerdir_all = kstrdup(name, GFP_KERNEL);
+	if (!ctx->lowerdir_all)
+		return -ENOMEM;
+
 	dup = kstrdup(name, GFP_KERNEL);
 	if (!dup)
 		return -ENOMEM;
@@ -448,7 +459,7 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	return 0;
 
 out_put:
-	ovl_parse_param_drop_lowerdir(ctx);
+	ovl_reset_lowerdirs(ctx);
 
 out_err:
 	kfree(dup);
@@ -554,7 +565,7 @@ static int ovl_get_tree(struct fs_context *fc)
 
 static inline void ovl_fs_context_free(struct ovl_fs_context *ctx)
 {
-	ovl_parse_param_drop_lowerdir(ctx);
+	ovl_reset_lowerdirs(ctx);
 	path_put(&ctx->upper);
 	path_put(&ctx->work);
 	kfree(ctx->lower);
@@ -870,24 +881,13 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
-	size_t nr, nr_merged_lower = ofs->numlayer - ofs->numdatalayer;
+	char **lowerdirs = ofs->config.lowerdirs;
 
 	/*
-	 * lowerdirs[] starts from offset 1, then
-	 * >= 0 regular lower layers prefixed with : and
-	 * >= 0 data-only lower layers prefixed with ::
-	 *
-	 * we need to escase comma and space like seq_show_option() does and
-	 * we also need to escape the colon separator from lowerdir paths.
+	 * lowerdirs[0] holds the colon separated list that user provided
+	 * with lowerdir mount option.
 	 */
-	seq_puts(m, ",lowerdir=");
-	for (nr = 1; nr < ofs->numlayer; nr++) {
-		if (nr > 1)
-			seq_putc(m, ':');
-		if (nr >= nr_merged_lower)
-			seq_putc(m, ':');
-		seq_escape(m, ofs->config.lowerdirs[nr], ":, \t\n\\");
-	}
+	seq_show_option(m, "lowerdir", lowerdirs[0]);
 	if (ofs->config.upperdir) {
 		seq_show_option(m, "upperdir", ofs->config.upperdir);
 		seq_show_option(m, "workdir", ofs->config.workdir);
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
index 8750da68ab2a4..c96d939820211 100644
--- a/fs/overlayfs/params.h
+++ b/fs/overlayfs/params.h
@@ -32,6 +32,7 @@ struct ovl_fs_context {
 	size_t nr_data;
 	struct ovl_opt_set set;
 	struct ovl_fs_context_layer *lower;
+	char *lowerdir_all; /* user provided lowerdir string */
 };
 
 int ovl_init_fs_context(struct fs_context *fc);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index c71d185980c08..2c056d737c27c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1374,8 +1374,11 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	ofs->layers = layers;
 	/*
 	 * Layer 0 is reserved for upper even if there's no upper.
-	 * For consistency, config.lowerdirs[0] is NULL.
+	 * config.lowerdirs[0] is used for storing the user provided colon
+	 * separated lowerdir string.
 	 */
+	ofs->config.lowerdirs[0] = ctx->lowerdir_all;
+	ctx->lowerdir_all = NULL;
 	ofs->numlayer = 1;
 
 	sb->s_stack_depth = 0;
-- 
2.43.0


