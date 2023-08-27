Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502B78A128
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjH0T1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjH0T05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE011B;
        Sun, 27 Aug 2023 12:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E6460BEC;
        Sun, 27 Aug 2023 19:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB15DC433C8;
        Sun, 27 Aug 2023 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693164414;
        bh=spqN/uZTeUdCcXxsbSgutnnLKVJ06OZltFJdVPC3W7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bw0sJTTnNAmsb4srsQzDoxt7wINKjRo8mZj54QRXVOsFRs7GlIAbmo5HZ2tBusNKc
         0F9LwcERnZHh8EZTfQTdaNVRIy5vyPYjcrjRSv9hxbRB+yJFgeQBOvI91c2YmcH2G8
         IMTDF7S8V4l9hV57/qubLh4s2RO6WM5BdK4f9GS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.49
Date:   Sun, 27 Aug 2023 21:26:41 +0200
Message-ID: <2023082706-reuse-dangling-b193@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023082706-region-directly-f70e@gregkh>
References: <2023082706-region-directly-f70e@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 8bb8dd199c55..61ebd54aba89 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 48
+SUBLEVEL = 49
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 78f39a78de29..4d1e48c676fa 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3431,6 +3431,7 @@ static inline bool __is_valid_data_blkaddr(block_t blkaddr)
  * file.c
  */
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
+void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
 int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3ce6da4fac9c..7b94f047cbf7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -628,6 +628,11 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 					 dn->ofs_in_node, nr_free);
 }
 
+void f2fs_truncate_data_blocks(struct dnode_of_data *dn)
+{
+	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
+}
+
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9fe502485930..a010b4bc36d2 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -923,7 +923,6 @@ static int truncate_node(struct dnode_of_data *dn)
 
 static int truncate_dnode(struct dnode_of_data *dn)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct page *page;
 	int err;
 
@@ -931,25 +930,16 @@ static int truncate_dnode(struct dnode_of_data *dn)
 		return 1;
 
 	/* get direct node */
-	page = f2fs_get_node_page(sbi, dn->nid);
+	page = f2fs_get_node_page(F2FS_I_SB(dn->inode), dn->nid);
 	if (PTR_ERR(page) == -ENOENT)
 		return 1;
 	else if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	if (IS_INODE(page) || ino_of_node(page) != dn->inode->i_ino) {
-		f2fs_err(sbi, "incorrect node reference, ino: %lu, nid: %u, ino_of_node: %u",
-				dn->inode->i_ino, dn->nid, ino_of_node(page));
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
-		f2fs_put_page(page, 1);
-		return -EFSCORRUPTED;
-	}
-
 	/* Make dnode_of_data for parameter */
 	dn->node_page = page;
 	dn->ofs_in_node = 0;
-	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
+	f2fs_truncate_data_blocks(dn);
 	err = truncate_node(dn);
 	if (err) {
 		f2fs_put_page(page, 1);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ff47aad636e5..b6dad389fa14 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1347,12 +1347,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
-		test_opt(sbi, FLUSH_MERGE)) {
-		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
-		return -EINVAL;
-	}
-
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
 		f2fs_err(sbi, "Allow to mount readonly mode only");
 		return -EROFS;
@@ -1939,10 +1933,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",inline_dentry");
 	else
 		seq_puts(seq, ",noinline_dentry");
-	if (test_opt(sbi, FLUSH_MERGE))
+	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
-	else
-		seq_puts(seq, ",noflush_merge");
 	if (test_opt(sbi, NOBARRIER))
 		seq_puts(seq, ",nobarrier");
 	if (test_opt(sbi, FASTBOOT))
@@ -2040,22 +2032,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static void default_options(struct f2fs_sb_info *sbi, bool remount)
+static void default_options(struct f2fs_sb_info *sbi)
 {
 	/* init some FS parameters */
-	if (!remount) {
-		set_opt(sbi, READ_EXTENT_CACHE);
-		clear_opt(sbi, DISABLE_CHECKPOINT);
-
-		if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
-			set_opt(sbi, DISCARD);
-
-		if (f2fs_sb_has_blkzoned(sbi))
-			F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
-		else
-			F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_BLOCK;
-	}
-
 	if (f2fs_sb_has_readonly(sbi))
 		F2FS_OPTION(sbi).active_logs = NR_CURSEG_RO_TYPE;
 	else
@@ -2078,16 +2057,22 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
+	set_opt(sbi, READ_EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
+	clear_opt(sbi, DISABLE_CHECKPOINT);
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
-		set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_sb_has_blkzoned(sbi))
+	set_opt(sbi, FLUSH_MERGE);
+	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
+		set_opt(sbi, DISCARD);
+	if (f2fs_sb_has_blkzoned(sbi)) {
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
-	else
+		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
+	} else {
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
+		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_BLOCK;
+	}
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
@@ -2259,7 +2244,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 	}
 
-	default_options(sbi, true);
+	default_options(sbi);
 
 	/* parse mount options */
 	err = parse_options(sb, data, true);
@@ -4156,7 +4141,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
 						sizeof(raw_super->uuid));
 
-	default_options(sbi, false);
+	default_options(sbi);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
 	if (data && !options) {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 77055b239165..ee0d75d9a302 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -104,7 +104,6 @@ enum f2fs_error {
 	ERROR_INCONSISTENT_SIT,
 	ERROR_CORRUPTED_VERITY_XATTR,
 	ERROR_CORRUPTED_XATTR,
-	ERROR_INVALID_NODE_REFERENCE,
 	ERROR_MAX,
 };
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 29c35279c7ed..1ed49ab4e871 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -796,8 +796,11 @@ bool arch_is_retpoline(struct symbol *sym)
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "retbleed_return_thunk");
+	return !strcmp(sym->name, "__x86_return_thunk");
+}
+
+bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return !strcmp(sym->name, "retbleed_return_thunk") ||
+	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 913bd361c368..f8008ab31eef 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1164,16 +1164,33 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
+__weak bool arch_is_embedded_insn(struct symbol *sym)
+{
+	return false;
+}
+
 #define NEGATIVE_RELOC	((void *)-1L)
 
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
@@ -1437,7 +1454,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * middle of another instruction.  Objtool only
 			 * knows about the outer instruction.
 			 */
-			if (sym && sym->return_thunk) {
+			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
 				continue;
 			}
@@ -2327,6 +2344,9 @@ static int classify_symbols(struct objtool_file *file)
 			if (arch_is_rethunk(func))
 				func->return_thunk = true;
 
+			if (arch_is_embedded_insn(func))
+				func->embedded_insn = true;
+
 			if (!strcmp(func->name, "__fentry__"))
 				func->fentry = true;
 
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index beb2f3aa94ff..861c0c60ac81 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -90,6 +90,7 @@ int arch_decode_hint_reg(u8 sp_reg, int *base);
 
 bool arch_is_retpoline(struct symbol *sym);
 bool arch_is_rethunk(struct symbol *sym);
+bool arch_is_embedded_insn(struct symbol *sym);
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 16f4067b82ae..5d4a841fbd31 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -60,6 +60,7 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 embedded_insn     : 1;
 	struct list_head pv_target;
 };
 
