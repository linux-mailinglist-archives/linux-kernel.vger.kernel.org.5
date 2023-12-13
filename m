Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8780FBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377730AbjLMAJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377930AbjLMAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:08:57 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698DD68;
        Tue, 12 Dec 2023 16:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2/w5ERFrmChBMIDGO6+09pNbE8Y3dQuTTvG9JrP5JDY=; b=t5YLbKf59Ph5/HA4K3h5FNGpwN
        oQPJp3Z7OQTJZldru5/Ye5EzplzTdDLgbuUHdrGsgzNUjVaIIdg70ThXj7SPysucJNTrSHwfPRX8T
        PtXYfxX/UMoravlVxqRvgPgzTAqGApdMc8qJinBpphqMEPGycu0L+O7TOxROFS8yf/RmZwnYjmIC7
        XiRra8jeckgpVMzMKl/mS4aypG7O8hem1+xjlCcwvv6USWBsX1IgywWmfEuESQRDjBdTu5Yla51Aw
        4GPmIBKIVsSmI9g8EzsRCMthb003X/YZfAb4Mj7xjs5cnmMgzPD72sQyT8iu/3j2R7pdTcMld0Xpy
        Z33csicg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDCny-00BX25-1J;
        Wed, 13 Dec 2023 00:08:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] minixfs: Use dir_put_page() in minix_unlink() and minix_rename()
Date:   Wed, 13 Dec 2023 00:08:48 +0000
Message-Id: <20231213000849.2748576-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
References: <20231213000656.GI1674809@ZenIV>
 <20231213000849.2748576-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... rather than open-coding it there.  Counterpart of the
corresponding fs/sysv commit from Fabio's series...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/minix/dir.c   |  6 ------
 fs/minix/minix.h |  5 +++++
 fs/minix/namei.c | 12 ++++--------
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index 4e5483adea40..ccb6c47fd7fe 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -26,12 +26,6 @@ const struct file_operations minix_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
-static inline void dir_put_page(struct page *page)
-{
-	kunmap(page);
-	put_page(page);
-}
-
 /*
  * Return the offset into page `page_nr' of the last valid
  * byte in that page, plus one.
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d493507c064f..cb42b6cf7909 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -64,6 +64,11 @@ extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
 extern unsigned V1_minix_blocks(loff_t, struct super_block *);
 extern unsigned V2_minix_blocks(loff_t, struct super_block *);
 
+static inline void dir_put_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
 extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct page**);
 extern int minix_add_link(struct dentry*, struct inode*);
 extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 114084d5636a..20923a15e30a 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -149,8 +149,7 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 	if (!de)
 		return -ENOENT;
 	err = minix_delete_entry(de, page);
-	kunmap(page);
-	put_page(page);
+	dir_put_page(page);
 
 	if (err)
 		return err;
@@ -242,13 +241,10 @@ static int minix_rename(struct mnt_idmap *idmap,
 			inode_dec_link_count(old_dir);
 	}
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		dir_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	dir_put_page(old_page);
 out:
 	return err;
 }
-- 
2.39.2

