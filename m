Return-Path: <linux-kernel+bounces-114076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6C888F38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1C31F34A32
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA714E2E2;
	Sun, 24 Mar 2024 23:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6nUrM4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51303130AFA;
	Sun, 24 Mar 2024 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321367; cv=none; b=ZyPt7l4sOWxXq6oUoYlxT8aVQ7bjeyWo5jzhXmNk9UDEFUKf8YjqzSPwaApTE1Pu+02H1QAU9nS+asOxCJSRDcm8by81m/BQTm/RLMjqkz0aYxt2DxnJKvgVaCn7mVMU/v/gO10/hEQBN46QXYp+gTfRXe73gJ2df4Zbz4EEovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321367; c=relaxed/simple;
	bh=+qbaCAofjncVFu4+vwJQ5PxTT816Cw4fc9hpPcujUto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Toi1Gfnfq8QpVu0arX2Sdr1Lzj/ldYqQPcUV7Xn8bhR2peEuniFStAflQTaGNpN3FN1GMS+rMDniaaaNEujn58eUZTAAUAplgFLRa7yS0fIOIY9CCCGMDuBSjrammXlfLsKViYrb59EUE+xdaa5yz1iQA0+6vZSQ6SrDv1RFNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6nUrM4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D786C43399;
	Sun, 24 Mar 2024 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321366;
	bh=+qbaCAofjncVFu4+vwJQ5PxTT816Cw4fc9hpPcujUto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j6nUrM4TixKJfqyL3tJ+UwVDWQy4BZvxsHh0SvgrDu0Nk9H125VubcM0W7nOLeLsB
	 YgHym2ml/lhfY9lccxma1cFqN8Op4fY18sJIHPNFQmSxAaZ1QN/4JvuQPOV8TBlwsf
	 nugvgiid19SSAIk1O4AIdrC43bmILipZijnCi8nvbg42xhwXrlOYaocPf6xcxktbb/
	 aVSZei7SCX9+uwaRf5vn3QNrMgUM7oJcILyYzEh5m2sowS4UiLaBNe5QTPX/7VnuSE
	 CF7d03fGSTk03r/d5GOYeyvRdvyR7jTXV+58iZDW1dFDTZkHp5XZJJRhY/E+c06ffm
	 MgruhU27gi+lA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 091/638] ovl: refactor layer parsing helpers
Date: Sun, 24 Mar 2024 18:52:08 -0400
Message-ID: <20240324230116.1348576-92-sashal@kernel.org>
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

[ Upstream commit 819829f0319a759e8a6ccb7e4f1113f3f9f07aa3 ]

In preparation for new mount options to add lowerdirs one by one,
generalize ovl_parse_param_upperdir() into helper ovl_parse_layer()
that will be used for parsing a single lower layers.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpegt7VC94KkRtb1dfHG8+4OzwPBLYqhtc8=QFUxpFJE+=RQ@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Stable-dep-of: 2824083db76c ("ovl: Always reject mounting over case-insensitive directories")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/params.c | 121 +++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 0bf754a69e919..88725982b6dd3 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -43,7 +43,7 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0644);
 MODULE_PARM_DESC(metacopy,
 		 "Default to on or off for the metadata only copy up feature");
 
-enum {
+enum ovl_opt {
 	Opt_lowerdir,
 	Opt_upperdir,
 	Opt_workdir,
@@ -238,19 +238,8 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
 		pr_err("failed to resolve '%s': %i\n", name, err);
 		goto out;
 	}
-	err = -EINVAL;
-	if (ovl_dentry_weird(path->dentry)) {
-		pr_err("filesystem on '%s' not supported\n", name);
-		goto out_put;
-	}
-	if (!d_is_dir(path->dentry)) {
-		pr_err("'%s' not a directory\n", name);
-		goto out_put;
-	}
 	return 0;
 
-out_put:
-	path_put_init(path);
 out:
 	return err;
 }
@@ -268,7 +257,7 @@ static void ovl_unescape(char *s)
 	}
 }
 
-static int ovl_mount_dir(const char *name, struct path *path, bool upper)
+static int ovl_mount_dir(const char *name, struct path *path)
 {
 	int err = -ENOMEM;
 	char *tmp = kstrdup(name, GFP_KERNEL);
@@ -276,60 +265,82 @@ static int ovl_mount_dir(const char *name, struct path *path, bool upper)
 	if (tmp) {
 		ovl_unescape(tmp);
 		err = ovl_mount_dir_noesc(tmp, path);
-
-		if (!err && upper && path->dentry->d_flags & DCACHE_OP_REAL) {
-			pr_err("filesystem on '%s' not supported as upperdir\n",
-			       tmp);
-			path_put_init(path);
-			err = -EINVAL;
-		}
 		kfree(tmp);
 	}
 	return err;
 }
 
-static int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
-				    bool workdir)
+static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
+			       enum ovl_opt layer, const char *name, bool upper)
 {
-	int err;
-	struct ovl_fs *ofs = fc->s_fs_info;
-	struct ovl_config *config = &ofs->config;
-	struct ovl_fs_context *ctx = fc->fs_private;
-	struct path path;
-	char *dup;
+	if (ovl_dentry_weird(path->dentry))
+		return invalfc(fc, "filesystem on %s not supported", name);
 
-	err = ovl_mount_dir(name, &path, true);
-	if (err)
-		return err;
+	if (!d_is_dir(path->dentry))
+		return invalfc(fc, "%s is not a directory", name);
 
 	/*
 	 * Check whether upper path is read-only here to report failures
 	 * early. Don't forget to recheck when the superblock is created
 	 * as the mount attributes could change.
 	 */
-	if (__mnt_is_readonly(path.mnt)) {
-		path_put(&path);
-		return -EINVAL;
+	if (upper) {
+		if (path->dentry->d_flags & DCACHE_OP_REAL)
+			return invalfc(fc, "filesystem on %s not supported as upperdir", name);
+		if (__mnt_is_readonly(path->mnt))
+			return invalfc(fc, "filesystem on %s is read-only", name);
 	}
+	return 0;
+}
 
-	dup = kstrdup(name, GFP_KERNEL);
-	if (!dup) {
-		path_put(&path);
-		return -ENOMEM;
-	}
+static void ovl_add_layer(struct fs_context *fc, enum ovl_opt layer,
+			 struct path *path, char **pname)
+{
+	struct ovl_fs *ofs = fc->s_fs_info;
+	struct ovl_config *config = &ofs->config;
+	struct ovl_fs_context *ctx = fc->fs_private;
 
-	if (workdir) {
-		kfree(config->workdir);
-		config->workdir = dup;
-		path_put(&ctx->work);
-		ctx->work = path;
-	} else {
-		kfree(config->upperdir);
-		config->upperdir = dup;
-		path_put(&ctx->upper);
-		ctx->upper = path;
+	switch (layer) {
+	case Opt_workdir:
+		swap(config->workdir, *pname);
+		swap(ctx->work, *path);
+		break;
+	case Opt_upperdir:
+		swap(config->upperdir, *pname);
+		swap(ctx->upper, *path);
+		break;
+	default:
+		WARN_ON(1);
 	}
-	return 0;
+}
+
+static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
+			   enum ovl_opt layer)
+{
+	char *name = kstrdup(param->string, GFP_KERNEL);
+	bool upper = (layer == Opt_upperdir || layer == Opt_workdir);
+	struct path path;
+	int err;
+
+	if (!name)
+		return -ENOMEM;
+
+	err = ovl_mount_dir(name, &path);
+	if (err)
+		goto out_free;
+
+	err = ovl_mount_dir_check(fc, &path, layer, name, upper);
+	if (err)
+		goto out_put;
+
+	/* Store the user provided path string in ctx to show in mountinfo */
+	ovl_add_layer(fc, layer, &path, &name);
+
+out_put:
+	path_put(&path);
+out_free:
+	kfree(name);
+	return err;
 }
 
 static void ovl_reset_lowerdirs(struct ovl_fs_context *ctx)
@@ -417,7 +428,11 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 	for (nr = 0; nr < nr_lower; nr++, l++) {
 		memset(l, 0, sizeof(*l));
 
-		err = ovl_mount_dir(iter, &l->path, false);
+		err = ovl_mount_dir(iter, &l->path);
+		if (err)
+			goto out_put;
+
+		err = ovl_mount_dir_check(fc, &l->path, Opt_lowerdir, iter, false);
 		if (err)
 			goto out_put;
 
@@ -505,10 +520,8 @@ static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		err = ovl_parse_param_lowerdir(param->string, fc);
 		break;
 	case Opt_upperdir:
-		fallthrough;
 	case Opt_workdir:
-		err = ovl_parse_param_upperdir(param->string, fc,
-					       (Opt_workdir == opt));
+		err = ovl_parse_layer(fc, param, opt);
 		break;
 	case Opt_default_permissions:
 		config->default_permissions = true;
-- 
2.43.0


