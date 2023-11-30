Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A2F7FFD19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376737AbjK3UvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376734AbjK3UvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:51:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54470170E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04c097e34so2398485ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377481; x=1701982281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daQzNB2URKMV+sGdSQk1lzvSeEi/h6YPbuK5AOf4e9k=;
        b=GwbbwszrZbxzNbo6OHTqVXbMyo6NbtEskUiM7FER0CpwulRKzKtZUSBFiMdPdvgY8h
         e1hyS9VLOdKthYgDsXSfKtqE9nkHxqbiYW67yknVinDGRH2IBRP6j58tp+ABBLtTXqTa
         Lftt1yYpB82Uea1dsL1d+GcfhdtOFW/duTMIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377481; x=1701982281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daQzNB2URKMV+sGdSQk1lzvSeEi/h6YPbuK5AOf4e9k=;
        b=WJafGKuM+P+Rip9PP19DLc7HbIAnEbF2nnTwCoLyJ/zjUIw15ZJKenYPSlhED85C9H
         ZNWbqAirFD4pJ+3wGSzHQnkfOE0nOdPjrFn/cHfDU8Dc+3RkC/w21NXNa72tP1MEdy8Z
         0GRoMpAmjW640/paLzKYqASPT44EtQSVU2sS3E7L9DtKLq1iTPDhQSn72yDZ4i7nSxF6
         tkRAeee3wwdE1PNqqKQpMrN6hM+p5Gq0FmCWF8eWEy2lze/IZw3HfHOymIbeFxXPMQ3p
         cKJUtjIV2QZxl7pEFGbpBsPEJVU1x7a56Pgs1r4nd63lhW9IRMJTc9XWroD0ywVt+iex
         LKKA==
X-Gm-Message-State: AOJu0Yyk3ab+irMZ2eSjUh21NVo7QELrNh6Bp55v5WqPzQDjNkGW9y8m
        AX86ulOiZcBrexCoZx7pyNfW5A==
X-Google-Smtp-Source: AGHT+IHFtjpICHKn3Q8/UcYWyeb0BGbc5ECaZmX3q5ThxOEZ/5KIGsiuNres0vs4MvREPdZNLpWt9w==
X-Received: by 2002:a17:902:aa92:b0:1d0:44f6:ccca with SMTP id d18-20020a170902aa9200b001d044f6cccamr2143307plr.32.1701377481681;
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm1840613plo.278.2023.11.30.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] qnx4: Extract dir entry filename processing into helper
Date:   Thu, 30 Nov 2023 12:51:18 -0800
Message-Id: <20231130205120.3642477-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130205010.it.412-kees@kernel.org>
References: <20231130205010.it.412-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5530; i=keescook@chromium.org;
 h=from:subject; bh=DfWvLuw+1Lt1r34F/RNAIGyeJ3JO5Pv4v9kUKjoCgFA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPXHlsbg/RAPaF3lRor/e48qn5raSb02XFsxv
 4ZkTemLuR+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWj1xwAKCRCJcvTf3G3A
 Ju2FD/9yVnVUO73divQnIWrfkfSj+m1SuNrgcl/i1pzadtaT1HTZsGUv+Ya3kGmHdGQ6fKVnWXi
 AJn7Pxt6bDSI6Pnp7WwFOPBb50LY7rDQD8VIVpPCShrBa8JeJ8rq6g8STu1qmTtxV7T1JuiacGt
 1b2ANdJqcUJJ8cMf5NSaFV/FhgOcihqgxKmKg80oK/N777WPtUHKsO/8X0epDkYWno5tpOxB4K/
 EiofZJ8k0RZESvH42dGmA42jq4x/AkPusFHZ6T7oI6+GtzcgcMT5c4Qlh2kMelzZgqSsnkL5yPa
 WtKaqrom/6134zXVgWqqhQHwg2JPvdnZCWCaPq5Kvy7ERMBDM0bNtU35mIueySSSRdxRF8C9O7W
 bB5/orMoswd6pf0ksFbpvpGU/F0cCYDEMt/5cH6iM4d6XDbNaEj+o2utREOzfvGRZkNGSvV3rhh
 byj83Bl55pNV48ZVFGPhRJYI0hqGWqq7b5ZQebP6Je0KZQ2+g6SjaXjCh5fD7PIZrSuwFPubmj9
 zp9ooNGudzBGisaj/ruuw5Zuw9bvB+rBbgcFyeUPaLYijtn4kVy/lX+6+yj/LIOf746oaO7TqTd
 xbns0Al2CLsr5HmW2BYYaNJhz1/SOKSiVb6fHGk9ilzv6MsBmow/kOy0uae+UB39OCG1LcWHl1J KxbuPyxHqnqro3A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
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

Both dir.c and namei.c need to perform the same work to figure out a
directory entry's name and size. Extract this into a helper for use
in the next patch.

Cc: Anders Larsen <al@alarsen.net>
Link: https://lore.kernel.org/r/20231118033225.2181299-1-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/qnx4/dir.c  | 52 ++++++-------------------------------------
 fs/qnx4/qnx4.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index 66645a5a35f3..42a529e26bd6 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -15,43 +15,6 @@
 #include <linux/buffer_head.h>
 #include "qnx4.h"
 
-/*
- * A qnx4 directory entry is an inode entry or link info
- * depending on the status field in the last byte. The
- * first byte is where the name start either way, and a
- * zero means it's empty.
- *
- * Also, due to a bug in gcc, we don't want to use the
- * real (differently sized) name arrays in the inode and
- * link entries, but always the 'de_name[]' one in the
- * fake struct entry.
- *
- * See
- *
- *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578#c6
- *
- * for details, but basically gcc will take the size of the
- * 'name' array from one of the used union entries randomly.
- *
- * This use of 'de_name[]' (48 bytes) avoids the false positive
- * warnings that would happen if gcc decides to use 'inode.di_name'
- * (16 bytes) even when the pointer and size were to come from
- * 'link.dl_name' (48 bytes).
- *
- * In all cases the actual name pointer itself is the same, it's
- * only the gcc internal 'what is the size of this field' logic
- * that can get confused.
- */
-union qnx4_directory_entry {
-	struct {
-		const char de_name[48];
-		u8 de_pad[15];
-		u8 de_status;
-	};
-	struct qnx4_inode_entry inode;
-	struct qnx4_link_info link;
-};
-
 static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
@@ -74,26 +37,25 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
 		ix = (ctx->pos >> QNX4_DIR_ENTRY_SIZE_BITS) % QNX4_INODES_PER_BLOCK;
 		for (; ix < QNX4_INODES_PER_BLOCK; ix++, ctx->pos += QNX4_DIR_ENTRY_SIZE) {
 			union qnx4_directory_entry *de;
+			const char *fname;
 
 			offset = ix * QNX4_DIR_ENTRY_SIZE;
 			de = (union qnx4_directory_entry *) (bh->b_data + offset);
 
-			if (!de->de_name[0])
-				continue;
-			if (!(de->de_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
+			fname = get_entry_fname(de, &size);
+			if (!fname)
 				continue;
+
 			if (!(de->de_status & QNX4_FILE_LINK)) {
-				size = sizeof(de->inode.di_fname);
 				ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;
 			} else {
-				size = sizeof(de->link.dl_fname);
 				ino = ( le32_to_cpu(de->link.dl_inode_blk) - 1 ) *
 					QNX4_INODES_PER_BLOCK +
 					de->link.dl_inode_ndx;
 			}
-			size = strnlen(de->de_name, size);
-			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, name));
-			if (!dir_emit(ctx, de->de_name, size, ino, DT_UNKNOWN)) {
+
+			QNX4DEBUG((KERN_INFO "qnx4_readdir:%.*s\n", size, fname));
+			if (!dir_emit(ctx, fname, size, ino, DT_UNKNOWN)) {
 				brelse(bh);
 				return 0;
 			}
diff --git a/fs/qnx4/qnx4.h b/fs/qnx4/qnx4.h
index 6283705466a4..5c2b1fb6b952 100644
--- a/fs/qnx4/qnx4.h
+++ b/fs/qnx4/qnx4.h
@@ -44,3 +44,63 @@ static inline struct qnx4_inode_entry *qnx4_raw_inode(struct inode *inode)
 {
 	return &qnx4_i(inode)->raw;
 }
+
+/*
+ * A qnx4 directory entry is an inode entry or link info
+ * depending on the status field in the last byte. The
+ * first byte is where the name start either way, and a
+ * zero means it's empty.
+ *
+ * Also, due to a bug in gcc, we don't want to use the
+ * real (differently sized) name arrays in the inode and
+ * link entries, but always the 'de_name[]' one in the
+ * fake struct entry.
+ *
+ * See
+ *
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578#c6
+ *
+ * for details, but basically gcc will take the size of the
+ * 'name' array from one of the used union entries randomly.
+ *
+ * This use of 'de_name[]' (48 bytes) avoids the false positive
+ * warnings that would happen if gcc decides to use 'inode.di_name'
+ * (16 bytes) even when the pointer and size were to come from
+ * 'link.dl_name' (48 bytes).
+ *
+ * In all cases the actual name pointer itself is the same, it's
+ * only the gcc internal 'what is the size of this field' logic
+ * that can get confused.
+ */
+union qnx4_directory_entry {
+	struct {
+		const char de_name[48];
+		u8 de_pad[15];
+		u8 de_status;
+	};
+	struct qnx4_inode_entry inode;
+	struct qnx4_link_info link;
+};
+
+static inline const char *get_entry_fname(union qnx4_directory_entry *de,
+					  int *size)
+{
+	/* Make sure the status byte is in the same place for all structs. */
+	BUILD_BUG_ON(offsetof(struct qnx4_inode_entry, di_status) !=
+			offsetof(struct qnx4_link_info, dl_status));
+	BUILD_BUG_ON(offsetof(struct qnx4_inode_entry, di_status) !=
+			offsetof(union qnx4_directory_entry, de_status));
+
+	if (!de->de_name[0])
+		return NULL;
+	if (!(de->de_status & (QNX4_FILE_USED|QNX4_FILE_LINK)))
+		return NULL;
+	if (!(de->de_status & QNX4_FILE_LINK))
+		*size = sizeof(de->inode.di_fname);
+	else
+		*size = sizeof(de->link.dl_fname);
+
+	*size = strnlen(de->de_name, *size);
+
+	return de->de_name;
+}
-- 
2.34.1

