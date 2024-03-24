Return-Path: <linux-kernel+bounces-114077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07817888F39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867211F34906
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04E15E7FA;
	Sun, 24 Mar 2024 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeV2rNR8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7D1E621F;
	Sun, 24 Mar 2024 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321368; cv=none; b=Z7UrzbvOwk9zUXvc04dXM8nrGIBczWOYtiyvb6/0N1lk32cVW/W58ZJhRH0IBlctJs1rimY1p7SDiE/xe0rIaAyRrLKGMaUm0jPwtlftFiVVSDqoSN5eMBb+04GhjDIQIh8DAPEl7obmCbzMN+hQDW+AGi1d1WS28w6CpZZIVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321368; c=relaxed/simple;
	bh=D9hvlI8xNbzDqTCCYkI+M/PgsdZQvS9mRrsdkd4mV3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haXbEaWBR6U9vcGEctqEpPxlDcoGZ43NxDiOv5QinhjBj4Cm9IUq5Dj4vpxrl0ht5jDGk/gK+GVBCwcaddZTjYOWQ51UKzYENCqXmIH99gWu9f1EXRkC/mlkE10e2AHET9BObsqq2CvaPW8axkIuaRSOI3G/GnoBiv5KvGXmTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeV2rNR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30402C433A6;
	Sun, 24 Mar 2024 23:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321367;
	bh=D9hvlI8xNbzDqTCCYkI+M/PgsdZQvS9mRrsdkd4mV3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XeV2rNR8gEBHWgfuT08Dm2qG13CxQ02u+r2MasNrQUKL1kAOQuMzTm+L6sWUkHfcw
	 Q+UzLmc1W90NUFhBCM7MDG8/8hT7dEmX6144iJZ7kbklWMe6k19O/MqFRIFdK+IFE/
	 +1bXQyYeGJNp80RratJaeNGiZNS7ln1D6chwVJ0orB3FKhUZTGxepoRrwvP+2MR5zW
	 yJPsXZ7ORa0OyB66PvR7NNBpBV7Fp1DXqtRTWVO4P+3eOE1nG09H35aL9hUGhyy/JN
	 IraP1BJ/z64oD1LLAbPMEr80H1xo0udUDgn7RaSXjHfsdGncuyO+iQtfBcg46CcpF9
	 A12l1OTZU0/oQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 092/638] ovl: add support for appending lowerdirs one by one
Date: Sun, 24 Mar 2024 18:52:09 -0400
Message-ID: <20240324230116.1348576-93-sashal@kernel.org>
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

[ Upstream commit 24e16e385f2272b1a9df51337a5c32d28a29c7ad ]

Add new mount options lowerdir+ and datadir+ that can be used to add
layers to lower layers stack one by one.

Unlike the legacy lowerdir mount option, special characters (i.e. colons
and cammas) are not unescaped with these new mount options.

The new mount options can be repeated to compose a large stack of lower
layers, but they may not be mixed with the lagacy lowerdir mount option,
because for displaying lower layers in mountinfo, we do not want to mix
escaped with unescaped lower layers path syntax.

Similar to data-only layer rules with the lowerdir mount option, the
datadir+ option must follow at least one lowerdir+ option and the
lowerdir+ option must not follow the datadir+ option.

If the legacy lowerdir mount option follows lowerdir+ and datadir+
mount options, it overrides them.  Sepcifically, calling:

  fsconfig(FSCONFIG_SET_STRING, "lowerdir", "", 0);

can be used to reset previously setup lower layers.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpegt7VC94KkRtb1dfHG8+4OzwPBLYqhtc8=QFUxpFJE+=RQ@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: 2824083db76c ("ovl: Always reject mounting over case-insensitive directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/overlayfs.rst | 17 +++++-
 fs/overlayfs/params.c                   | 78 ++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 5b93268e400f4..56a5ad7a4fbd2 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -344,10 +344,11 @@ escaping the colons with a single backslash.  For example:
 
   mount -t overlay overlay -olowerdir=/a\:lower\:\:dir /merged
 
-Since kernel version v6.5, directory names containing colons can also
-be provided as lower layer using the fsconfig syscall from new mount api:
+Since kernel version v6.8, directory names containing colons can also
+be configured as lower layer using the "lowerdir+" mount options and the
+fsconfig syscall from new mount api.  For example:
 
-  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/a:lower::dir", 0);
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir+", "/a:lower::dir", 0);
 
 In the latter case, colons in lower layer directory names will be escaped
 as an octal characters (\072) when displayed in /proc/self/mountinfo.
@@ -416,6 +417,16 @@ Only the data of the files in the "data-only" lower layers may be visible
 when a "metacopy" file in one of the lower layers above it, has a "redirect"
 to the absolute path of the "lower data" file in the "data-only" lower layer.
 
+Since kernel version v6.8, "data-only" lower layers can also be added using
+the "datadir+" mount options and the fsconfig syscall from new mount api.
+For example:
+
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir+", "/l1", 0);
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir+", "/l2", 0);
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir+", "/l3", 0);
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "datadir+", "/do1", 0);
+  fsconfig(fs_fd, FSCONFIG_SET_STRING, "datadir+", "/do2", 0);
+
 
 fs-verity support
 ----------------------
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 88725982b6dd3..ddab9ea267d12 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -45,6 +45,8 @@ MODULE_PARM_DESC(metacopy,
 
 enum ovl_opt {
 	Opt_lowerdir,
+	Opt_lowerdir_add,
+	Opt_datadir_add,
 	Opt_upperdir,
 	Opt_workdir,
 	Opt_default_permissions,
@@ -140,8 +142,11 @@ static int ovl_verity_mode_def(void)
 #define fsparam_string_empty(NAME, OPT) \
 	__fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, NULL)
 
+
 const struct fs_parameter_spec ovl_parameter_spec[] = {
 	fsparam_string_empty("lowerdir",    Opt_lowerdir),
+	fsparam_string("lowerdir+",         Opt_lowerdir_add),
+	fsparam_string("datadir+",          Opt_datadir_add),
 	fsparam_string("upperdir",          Opt_upperdir),
 	fsparam_string("workdir",           Opt_workdir),
 	fsparam_flag("default_permissions", Opt_default_permissions),
@@ -273,12 +278,15 @@ static int ovl_mount_dir(const char *name, struct path *path)
 static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 			       enum ovl_opt layer, const char *name, bool upper)
 {
+	struct ovl_fs_context *ctx = fc->fs_private;
+
 	if (ovl_dentry_weird(path->dentry))
 		return invalfc(fc, "filesystem on %s not supported", name);
 
 	if (!d_is_dir(path->dentry))
 		return invalfc(fc, "%s is not a directory", name);
 
+
 	/*
 	 * Check whether upper path is read-only here to report failures
 	 * early. Don't forget to recheck when the superblock is created
@@ -289,16 +297,45 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 			return invalfc(fc, "filesystem on %s not supported as upperdir", name);
 		if (__mnt_is_readonly(path->mnt))
 			return invalfc(fc, "filesystem on %s is read-only", name);
+	} else {
+		if (ctx->lowerdir_all && layer != Opt_lowerdir)
+			return invalfc(fc, "lowerdir+ and datadir+ cannot follow lowerdir");
+		if (ctx->nr_data && layer == Opt_lowerdir_add)
+			return invalfc(fc, "regular lower layers cannot follow data layers");
+		if (ctx->nr == OVL_MAX_STACK)
+			return invalfc(fc, "too many lower directories, limit is %d",
+				       OVL_MAX_STACK);
 	}
 	return 0;
 }
 
+static int ovl_ctx_realloc_lower(struct fs_context *fc)
+{
+	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs_context_layer *l;
+	size_t nr;
+
+	if (ctx->nr < ctx->capacity)
+		return 0;
+
+	nr = min_t(size_t, max(4096 / sizeof(*l), ctx->capacity * 2),
+		   OVL_MAX_STACK);
+	l = krealloc_array(ctx->lower, nr, sizeof(*l), GFP_KERNEL_ACCOUNT);
+	if (!l)
+		return -ENOMEM;
+
+	ctx->lower = l;
+	ctx->capacity = nr;
+	return 0;
+}
+
 static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 			 struct path *path, char **pname)
 {
 	struct ovl_fs *ofs = fc->s_fs_info;
 	struct ovl_config *config = &ofs->config;
 	struct ovl_fs_context *ctx = fc->fs_private;
+	struct ovl_fs_context_layer *l;
 
 	switch (layer) {
 	case Opt_workdir:
@@ -309,6 +346,16 @@ static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
 		swap(config->upperdir, *pname);
 		swap(ctx->upper, *path);
 		break;
+	case Opt_datadir_add:
+		ctx->nr_data++;
+		fallthrough;
+	case Opt_lowerdir_add:
+		WARN_ON(ctx->nr >= ctx->capacity);
+		l = &ctx->lower[ctx->nr++];
+		memset(l, 0, sizeof(*l));
+		swap(l->name, *pname);
+		swap(l->path, *path);
+		break;
 	default:
 		WARN_ON(1);
 	}
@@ -325,7 +372,10 @@ static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
 	if (!name)
 		return -ENOMEM;
 
-	err = ovl_mount_dir(name, &path);
+	if (upper)
+		err = ovl_mount_dir(name, &path);
+	else
+		err = ovl_mount_dir_noesc(name, &path);
 	if (err)
 		goto out_free;
 
@@ -333,6 +383,12 @@ static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
 	if (err)
 		goto out_put;
 
+	if (!upper) {
+		err = ovl_ctx_realloc_lower(fc);
+		if (err)
+			goto out_put;
+	}
+
 	/* Store the user provided path string in ctx to show in mountinfo */
 	ovl_add_layer(fc, layer, &path, &name);
 
@@ -519,6 +575,8 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_lowerdir:
 		err = ovl_parse_param_lowerdir(param->string, fc);
 		break;
+	case Opt_lowerdir_add:
+	case Opt_datadir_add:
 	case Opt_upperdir:
 	case Opt_workdir:
 		err = ovl_parse_layer(fc, param, opt);
@@ -894,13 +952,29 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
+	size_t nr, nr_merged_lower, nr_lower = 0;
 	char **lowerdirs = ofs->config.lowerdirs;
 
 	/*
 	 * lowerdirs[0] holds the colon separated list that user provided
 	 * with lowerdir mount option.
+	 * lowerdirs[1..numlayer] hold the lowerdir paths that were added
+	 * using the lowerdir+ and datadir+ mount options.
+	 * For now, we do not allow mixing the legacy lowerdir mount option
+	 * with the new lowerdir+ and datadir+ mount options.
 	 */
-	seq_show_option(m, "lowerdir", lowerdirs[0]);
+	if (lowerdirs[0]) {
+		seq_show_option(m, "lowerdir", lowerdirs[0]);
+	} else {
+		nr_lower = ofs->numlayer;
+		nr_merged_lower = nr_lower - ofs->numdatalayer;
+	}
+	for (nr = 1; nr < nr_lower; nr++) {
+		if (nr < nr_merged_lower)
+			seq_show_option(m, "lowerdir+", lowerdirs[nr]);
+		else
+			seq_show_option(m, "datadir+", lowerdirs[nr]);
+	}
 	if (ofs->config.upperdir) {
 		seq_show_option(m, "upperdir", ofs->config.upperdir);
 		seq_show_option(m, "workdir", ofs->config.workdir);
-- 
2.43.0


