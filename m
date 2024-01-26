Return-Path: <linux-kernel+bounces-40258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881283DD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC22F1F2784D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA59134AA;
	Fri, 26 Jan 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwxCyu1z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7E1CF98
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282392; cv=none; b=Gg2kHdT5mO++m3tFN3RqxDz8UjcE4kkYzrjwBhWMMbQYdsYoLb/l5XsTQOuKE4m/+mo5AWdlQb8HYb5d2cPJJvLowMaxkpv4omq0kq1G//ESWJR0LeARXvehMr1NOYhY6IQdCRT3GxJ7RtT6Hm2ywuxGvVgp6FFLBlqYEkNrtj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282392; c=relaxed/simple;
	bh=v0r271/Aca9Iq1+M0kEV3V6R+A1O5TG7PLpWMF87qP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YghmFsInPZaG1F6anwnKP55ITzg1ULDQnnRlRnHrvdJa25lN3mm4v2nMUD+EpwQy0fmnkkvTGsxPwDlIRFakNQxrmeLCDxnPESJygR8YdXH+oT+yiqvx7/noallB/JgfXmQwXOZIkRvRTOGfeApFY/r0YK+Dt4PHzkSyRaA1aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwxCyu1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF1C433F1;
	Fri, 26 Jan 2024 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282391;
	bh=v0r271/Aca9Iq1+M0kEV3V6R+A1O5TG7PLpWMF87qP4=;
	h=From:To:Cc:Subject:Date:From;
	b=OwxCyu1zXtBHeh+Zx/nQmVm+DeEqXQlRCUFIuFxWE9JStsF8nXy1w5feEVw7HEgFk
	 u2wJSLDUAz4qEtTZukcTSRbSg26My6xMExKZXNlq4MnI6+MWW8HOmT33q0PGY4iVXE
	 AbMRRHf11AFxSCHYBw/1KMbstvLWsnnFJRYHqY1y9nUI1Yqqti3i7IFGNKyl/+9JPi
	 By7RWDTDCCuWGAY5xOlSUKbx8beWHYIJ/Lw/n+bZibqG6jFy3FaZBth25N3HzsOx9u
	 0X1X+H01ERW7EREdVBrIuVwMyU8H8W7EbF2xo6FOKZcWnpXrGp4adms9DndokVwANM
	 kN8nYDdJ5PzmQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: support printk_ratelimited() in f2fs_printk()
Date: Fri, 26 Jan 2024 23:19:16 +0800
Message-Id: <20240126151917.837565-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports using printk_ratelimited() in f2fs_printk(), and
wrap ratelimited f2fs_printk() into f2fs_{err,warn,info}_ratelimited(),
then, use these new helps to clean up codes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 10 +++++-----
 fs/f2fs/dir.c      |  5 ++---
 fs/f2fs/f2fs.h     | 40 +++++++++++++++++++++++-----------------
 fs/f2fs/super.c    | 11 ++++++++---
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ff26b49c0d71..0fd839358c15 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -512,8 +512,8 @@ static int lzorle_compress_pages(struct compress_ctx *cc)
 	ret = lzorle1x_1_compress(cc->rbuf, cc->rlen, cc->cbuf->cdata,
 					&cc->clen, cc->private);
 	if (ret != LZO_E_OK) {
-		printk_ratelimited("%sF2FS-fs (%s): lzo-rle compress failed, ret:%d\n",
-				KERN_ERR, F2FS_I_SB(cc->inode)->sb->s_id, ret);
+		f2fs_err_ratelimited(F2FS_I_SB(cc->inode),
+				"lzo-rle compress failed, ret:%d", ret);
 		return -EIO;
 	}
 	return 0;
@@ -780,9 +780,9 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		if (provided != calculated) {
 			if (!is_inode_flag_set(dic->inode, FI_COMPRESS_CORRUPT)) {
 				set_inode_flag(dic->inode, FI_COMPRESS_CORRUPT);
-				printk_ratelimited(
-					"%sF2FS-fs (%s): checksum invalid, nid = %lu, %x vs %x",
-					KERN_INFO, sbi->sb->s_id, dic->inode->i_ino,
+				f2fs_info_ratelimited(sbi,
+					"checksum invalid, nid = %lu, %x vs %x",
+					dic->inode->i_ino,
 					provided, calculated);
 			}
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 042593aed1ec..3f20d94e12f9 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -995,9 +995,8 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		de = &d->dentry[bit_pos];
 		if (de->name_len == 0) {
 			if (found_valid_dirent || !bit_pos) {
-				printk_ratelimited(
-					"%sF2FS-fs (%s): invalid namelen(0), ino:%u, run fsck to fix.",
-					KERN_WARNING, sbi->sb->s_id,
+				f2fs_warn_ratelimited(sbi,
+					"invalid namelen(0), ino:%u, run fsck to fix.",
 					le32_to_cpu(de->ino));
 				set_sbi_flag(sbi, SBI_NEED_FSCK);
 			}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2c2916421d52..c5e7460d1a0a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1819,6 +1819,27 @@ struct f2fs_sb_info {
 #endif
 };
 
+__printf(3, 4)
+void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate, const char *fmt, ...);
+
+#define f2fs_err(sbi, fmt, ...)						\
+	f2fs_printk(sbi, false, KERN_ERR fmt, ##__VA_ARGS__)
+#define f2fs_warn(sbi, fmt, ...)					\
+	f2fs_printk(sbi, false, KERN_WARNING fmt, ##__VA_ARGS__)
+#define f2fs_notice(sbi, fmt, ...)					\
+	f2fs_printk(sbi, false, KERN_NOTICE fmt, ##__VA_ARGS__)
+#define f2fs_info(sbi, fmt, ...)					\
+	f2fs_printk(sbi, false, KERN_INFO fmt, ##__VA_ARGS__)
+#define f2fs_debug(sbi, fmt, ...)					\
+	f2fs_printk(sbi, false, KERN_DEBUG fmt, ##__VA_ARGS__)
+
+#define f2fs_err_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk(sbi, true, KERN_ERR fmt, ##__VA_ARGS__)
+#define f2fs_warn_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk(sbi, true, KERN_WARNING fmt, ##__VA_ARGS__)
+#define f2fs_info_ratelimited(sbi, fmt, ...)				\
+	f2fs_printk(sbi, true, KERN_INFO fmt, ##__VA_ARGS__)
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__,	\
 									__builtin_return_address(0))
@@ -1836,9 +1857,8 @@ static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
 	atomic_inc(&ffi->inject_ops);
 	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
 		atomic_set(&ffi->inject_ops, 0);
-		printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",
-			KERN_INFO, sbi->sb->s_id, f2fs_fault_name[type],
-			func, parent_func);
+		f2fs_info_ratelimited(sbi, "inject %s in %s of %pS",
+				f2fs_fault_name[type], func, parent_func);
 		return true;
 	}
 	return false;
@@ -2343,20 +2363,6 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
-__printf(2, 3)
-void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...);
-
-#define f2fs_err(sbi, fmt, ...)						\
-	f2fs_printk(sbi, KERN_ERR fmt, ##__VA_ARGS__)
-#define f2fs_warn(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_WARNING fmt, ##__VA_ARGS__)
-#define f2fs_notice(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_NOTICE fmt, ##__VA_ARGS__)
-#define f2fs_info(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_INFO fmt, ##__VA_ARGS__)
-#define f2fs_debug(sbi, fmt, ...)					\
-	f2fs_printk(sbi, KERN_DEBUG fmt, ##__VA_ARGS__)
-
 #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
 static inline bool page_private_##name(struct page *page) \
 { \
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5c672a11ca6e..4ca390363131 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -264,7 +264,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_err, NULL},
 };
 
-void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...)
+void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate,
+						const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -275,8 +276,12 @@ void f2fs_printk(struct f2fs_sb_info *sbi, const char *fmt, ...)
 	level = printk_get_level(fmt);
 	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
-	printk("%c%cF2FS-fs (%s): %pV\n",
-	       KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
+	if (limit_rate)
+		printk_ratelimited("%c%cF2FS-fs (%s): %pV\n",
+			KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
+	else
+		printk("%c%cF2FS-fs (%s): %pV\n",
+			KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);
 
 	va_end(args);
 }
-- 
2.40.1


