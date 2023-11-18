Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D6E7EFD6B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjKRDcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRDcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:32:31 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A900D79
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:32:28 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b40d5ea323so1716869b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700278347; x=1700883147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuOAsHHFZPOuWQfa7HR/CRP8rWW9OFa4zlb7H8K+PqI=;
        b=hRw7TE3Aw9mQGJeK8iKAqXHV4cXi1r/D8nRX/XkqFKl20avtMidhRSDLOd2ByznuDq
         VzP6oxDEnobAZJtuHScSkingQNUDhvs0tO1lO1h10DIXadeb2ZVcJ2aPC4OyLSIUFSqM
         ywvWhGLsaf1C9NP9wsn9iPpr8gqoyxZSGcGhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278347; x=1700883147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuOAsHHFZPOuWQfa7HR/CRP8rWW9OFa4zlb7H8K+PqI=;
        b=KllK00r+sBmraJPGdTF5xudovWkF48GPXNSvAdWTkyYssUS8b2V5G58hfZY+lYKJU/
         6TB+GcKPLk9hGfrxeKo2R74b0MU8Oo4LuEadNo0FOMRdn2vgkZuum68IIRp/7HcfoBDM
         t5HWCk9IVNv7wJ/bFXc0nSbo3/lZ5kz9bc6NCag9HnUrJ1uu3uqjWm5yXT3+ZIviWuSI
         ZAvfHjT2NazkDtht5c+j6OW1eqfe16tpzyKhbuY0TezLS4kQy/+Ryw8lhmxNU+c1Rqv7
         W9kvIvG3WPeF2xEA2QoZoGqupt+fRgM/CT/d+gU2BYBXI6fjrG+2Tq+azXs0KXs7qBba
         dCpQ==
X-Gm-Message-State: AOJu0YzwErBTH3dpXA6TU/u0i/sICUHhMarpQqYW8uiySxJY19GQblLi
        1y0SRrXLhNaIIqwxWPa29uY6QA==
X-Google-Smtp-Source: AGHT+IF2HbSv7SVWLufTInHe2pC1ytOAKg2gxYRthtrdxLEph49hv/X+einil+ezVqrpebMN2+0uQw==
X-Received: by 2002:a05:6808:159c:b0:3b2:e520:dfab with SMTP id t28-20020a056808159c00b003b2e520dfabmr1858538oiw.44.1700278347367;
        Fri, 17 Nov 2023 19:32:27 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005bd3d6e270dsm2110896pgj.68.2023.11.17.19.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:32:26 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] qnx4: Extract dir entry filename processing into helper
Date:   Fri, 17 Nov 2023 19:32:22 -0800
Message-Id: <20231118033225.2181299-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118032638.work.955-kees@kernel.org>
References: <20231118032638.work.955-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5459; i=keescook@chromium.org;
 h=from:subject; bh=XEizXpbYB2hSkZgTWepdo9gwxqKciXPea2V6fD+lP5k=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlWDBGMRS5pTns5wDRKgex0lEioCJEEml3GQ5kv
 Nh32TbQdjeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVgwRgAKCRCJcvTf3G3A
 JouAD/9ZvesC+kPMzN1CYhx7iEpEFQrI4FoTIpnppDCfjhk9vXwzvPtaa/M62cBMlQde1ZepANK
 GW8J3xOeaN4ZV1xQbiinxYQUwW/p2Tj56rkA8h12t8TF/MDj6Kxg5+umawN+95WNB8epZSkHNMk
 G65lyhqloSJfUGBu8AtmWgAkrtAn+Amo459NTcjo/ilLqjLt9Rl7E8A0AG/iv+ZW09D9nQVwCC+
 TMSPPTXphxSYAPS7lzFhHtYK4E+d0did4ft3KEdjPfX/USAeuNuTR+lRbvDHkR9cVt5FZkw10cf
 DugNmZxA8oqUUlDbYM3nMD5emCwjow9guRLFrGEg+iVeYXAaJnFeFIrZQvOA/BgGdkX2g7RYBEG
 17TOcyJBk7Cbwaih6Kix6kfm5YNOOqLS34h4V9Lx06KGwnQE2Uo1WPlrj3OIzPjZeiyygY7Ozi8
 ZK+SX8Cvw3sK8Jn5NIdUdfoLIvhlf35wBSl3DZBOX8/2XcjCiIYGkFrIs7XzYsQf6oKl0DT7sRq
 dzkaWBRLcaM6K+tXhMCL2o1R1OyZKLe9Ieu1lW6u5TWjor0NPpFxJqrVmGlUjVrt0vdqKZ/lrtm
 A0gv9b0cwsnuWdMKSMjuZFmwv8IXjdPEi8DSllHujMPThw5UgbOleCo9pMyoTaTVclE4NV+ABCe 9HQ2VabwzIb9NRQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both dir.c and namei.c need to perform the same work to figure out a
directory entry's name and size. Extract this into a helper for use
in the next patch.

Cc: Anders Larsen <al@alarsen.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/qnx4/dir.c  | 52 ++++++--------------------------------------
 fs/qnx4/qnx4.h | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 45 deletions(-)

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
index 6283705466a4..0b6b86ee09dd 100644
--- a/fs/qnx4/qnx4.h
+++ b/fs/qnx4/qnx4.h
@@ -44,3 +44,62 @@ static inline struct qnx4_inode_entry *qnx4_raw_inode(struct inode *inode)
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
+/* Make sure the status byte is in the same place for all structs. */
+_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
+	       offsetof(struct qnx4_link_info, dl_status));
+_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
+	       offsetof(union qnx4_directory_entry, de_status));
+
+static inline const char *get_entry_fname(union qnx4_directory_entry *de,
+					  int *size)
+{
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

