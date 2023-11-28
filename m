Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9EB7FB5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbjK1Jbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjK1Jbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:31:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D6CB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:31:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E569BC433C7;
        Tue, 28 Nov 2023 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701163898;
        bh=G4S7OaZ+7+gNaP/ANhOUYrSGPJa7mnRp3UrQ13Aljts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfoI+uJu2cYqV1quN6GEoY4pCDQoAKo0iNtVygR0GM8h9rYdGgSFovSUq5fsp3DCN
         XR+bFFHllMZOdmUp36p1PQsjWXcdmmFjihsNpv8BHhj9C5Uv4PI7mrN5NvgMkiE9py
         vCRGCbgBt9k4Bq788JiNDjMGU8uuVklRGZIlU0vv5xo3pqsrUG95wo3CDIuyUcOEDl
         9LKaRi2KZFPmvn22MBt5odlp4lV5XLs1yrZe4Our8dSOGpROTUIglCJ4wsD6LH2wdO
         7C47lXZZFmWGIMxlc1r433jYvzujanL5pfrVbQEKGxqQF68ZOOtA3fGtXzW5uhX9x1
         wwzh3a//mHh9A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: show i_mode in trace_f2fs_new_inode()
Date:   Tue, 28 Nov 2023 17:31:30 +0800
Message-Id: <20231128093130.2885216-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128093130.2885216-1-chao@kernel.org>
References: <20231128093130.2885216-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports to show i_mode field in trace_f2fs_new_inode().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 include/trace/events/f2fs.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 36d9e29ca3c5..479d26eae22f 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -161,6 +161,19 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
 		{ EX_READ,	"Read" },				\
 		{ EX_BLOCK_AGE,	"Block Age" })
 
+#define show_inode_type(x) \
+	__print_symbolic(x, \
+		{ S_IFLNK,		"symbolic" }, \
+		{ S_IFREG,		"regular" }, \
+		{ S_IFDIR,		"directory" }, \
+		{ S_IFCHR,		"character" }, \
+		{ S_IFBLK,		"block" }, \
+		{ S_IFIFO,		"fifo" }, \
+		{ S_IFSOCK,		"sock" })
+
+#define S_ALL_PERM	(S_ISUID | S_ISGID | S_ISVTX |	\
+			S_IRWXU | S_IRWXG | S_IRWXO)
+
 struct f2fs_sb_info;
 struct f2fs_io_info;
 struct extent_info;
@@ -215,17 +228,21 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
+		__field(umode_t, mode)
 		__field(int,	ret)
 	),
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
+		__entry->mode	= inode->i_mode;
 		__entry->ret	= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, ret = %d",
+	TP_printk("dev = (%d,%d), ino = %lu, type: %s, mode = 0%o, ret = %d",
 		show_dev_ino(__entry),
+		show_inode_type(__entry->mode & S_IFMT),
+		__entry->mode & S_ALL_PERM,
 		__entry->ret)
 );
 
-- 
2.40.1

