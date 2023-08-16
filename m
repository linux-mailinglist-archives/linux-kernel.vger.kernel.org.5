Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5C77D787
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbjHPBO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbjHPBOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:14:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E961984
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:14:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d683c5f5736so3059901276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692148479; x=1692753279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9aBAiu+20AKswTuHb3c49no1CNIktUKzBfI4WLE/3/w=;
        b=Qzar2R7FjL81exSq1w1t1hne11NhaVGqj66+LOtwunm9JZ2TLXSL/p0E3GkrnIHYxT
         zS1h16XqOVKEjZAqcEtqeow7BCHVpzO5a8rZFmDK65lK9oA1rr0iQ7F/3KevM+2EBGhv
         eRqkyHFADAzqYbPBrclv2Qx37x7PnJjnyJpSizd74UVm9Rh7vBc0BYo2ocsWS8y7S78A
         UCi6hUlthySqWTt3x0rluBDWqN38fLtpa5WmD1cVrudO9NsSQz+9wyhZ8DKBOBd4wX0F
         Qy1ZRPgr8f2InbAoz6IZdbbXosdpdPHw1z3FxQdSPHMMJzzUFTajaJH9sHzjXP6pRZbK
         rKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692148479; x=1692753279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9aBAiu+20AKswTuHb3c49no1CNIktUKzBfI4WLE/3/w=;
        b=V5EDc5B3afi1xsF1QN1yji27C/XWdGg8qtf+y2LeDwyKHqjeWRknY3Keu8brFH2CSt
         AbXU0tbBiUtkMUfygBIs4f2btQyWDX4Ftcircysals/E8XzVqgnV81TGXGqYKrpQR7Ay
         0SL83FhkdrIODAD97RC9XBRAB5gM7noCwPnc5BkSqxpbi/fq0XqIUDtUvtlWyVMiqg30
         GtYoDtRLM3F791xSUCkm2JTJyyPcnvNiLzUeRzK1DamzfOuzdHWOwb/HQrbZWrIc6vRL
         ukCuOdNpP9bgDdS9+aKerDHqciaO5oX3HK8WaFgkq14Eqk1XPczyoRy1fAF2iCu37bmZ
         LceA==
X-Gm-Message-State: AOJu0YwG3baLW6a6bQRi0UiLguS2IXs01UUG7UYOpbhB0sGBtujfr8E3
        w6tqV/vJWAzRSh0lcTM7URnnREIudoA=
X-Google-Smtp-Source: AGHT+IFefHa0OuOiJUzg0poI1m6TvFdyu16T/KRtQdOV1sc5ko+Jfe74ZD25SN09L024tb74RcWF5SYkhow=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:19fa:33cd:f272:37ec])
 (user=drosen job=sendgmr) by 2002:a25:dc54:0:b0:d42:42f8:93bf with SMTP id
 y81-20020a25dc54000000b00d4242f893bfmr6622ybe.0.1692148478975; Tue, 15 Aug
 2023 18:14:38 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:14:32 -0700
In-Reply-To: <20230816011432.1966838-1-drosen@google.com>
Mime-Version: 1.0
References: <20230816011432.1966838-1-drosen@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816011432.1966838-2-drosen@google.com>
Subject: [PATCH 1/1] ANDROID: f2fs: Support Block Size == Page Size
From:   Daniel Rosenberg <drosen@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows f2fs to support cases where the block size = page size for
both 4K and 16K block sizes. Other sizes should work as well, should the
need arise. This does not currently support 4K Block size filesystems if
the page size is 16K.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/data.c          |  2 +-
 fs/f2fs/node.c          |  2 +-
 fs/f2fs/super.c         |  4 +--
 include/linux/f2fs_fs.h | 69 ++++++++++++++++++++++++-----------------
 4 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5d9697717353..c9e4d02d21d6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4052,7 +4052,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	sis->highest_bit = cur_lblock - 1;
 out:
 	if (not_aligned)
-		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(%u * N)",
+		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(%lu * N)",
 			  not_aligned, blks_per_sec * F2FS_BLKSIZE);
 	return ret;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ee2e1dd64f25..a2b2c6c7f66d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -633,7 +633,7 @@ static void f2fs_ra_node_pages(struct page *parent, int start, int n)
 
 	/* Then, try readahead for siblings of the desired node */
 	end = start + n;
-	end = min(end, NIDS_PER_BLOCK);
+	end = min(end, (int)NIDS_PER_BLOCK);
 	for (i = start; i < end; i++) {
 		nid = get_nid(parent, i, false);
 		f2fs_ra_node_page(sbi, nid);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a067466a694c..895122ff3964 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3469,7 +3469,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
-	/* Currently, support 512/1024/2048/4096 bytes sector size */
+	/* Currently, support 512/1024/2048/4096/16K bytes sector size */
 	if (le32_to_cpu(raw_super->log_sectorsize) >
 				F2FS_MAX_LOG_SECTOR_SIZE ||
 		le32_to_cpu(raw_super->log_sectorsize) <
@@ -4915,7 +4915,7 @@ static int __init init_f2fs_fs(void)
 	int err;
 
 	if (PAGE_SIZE != F2FS_BLKSIZE) {
-		printk("F2FS not supported on PAGE_SIZE(%lu) != %d\n",
+		printk("F2FS not supported on PAGE_SIZE(%lu) != BLOCK_SIZE(%lu)\n",
 				PAGE_SIZE, F2FS_BLKSIZE);
 		return -EINVAL;
 	}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a82a4bb6ce68..07ed69c2840d 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -13,10 +13,10 @@
 
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
-#define F2FS_MAX_LOG_SECTOR_SIZE	12	/* 12 bits for 4096 bytes */
-#define F2FS_LOG_SECTORS_PER_BLOCK	3	/* log number for sector/blk */
-#define F2FS_BLKSIZE			4096	/* support only 4KB block */
-#define F2FS_BLKSIZE_BITS		12	/* bits for F2FS_BLKSIZE */
+#define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
+#define F2FS_LOG_SECTORS_PER_BLOCK	(PAGE_SHIFT - 9) /* log number for sector/blk */
+#define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
+#define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
 #define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) >> F2FS_BLKSIZE_BITS)
@@ -210,14 +210,14 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[];
 } __packed;
 
-#define CP_CHKSUM_OFFSET	4092	/* default chksum offset in checkpoint */
+#define CP_CHKSUM_OFFSET	(F2FS_BLKSIZE - sizeof(__le32))	/* default chksum offset in checkpoint */
 #define CP_MIN_CHKSUM_OFFSET						\
 	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
 
 /*
  * For orphan inode management
  */
-#define F2FS_ORPHANS_PER_BLOCK	1020
+#define F2FS_ORPHANS_PER_BLOCK	((F2FS_BLKSIZE - 4 * sizeof(__le32)) / sizeof(__le32))
 
 #define GET_ORPHAN_BLOCKS(n)	(((n) + F2FS_ORPHANS_PER_BLOCK - 1) / \
 					F2FS_ORPHANS_PER_BLOCK)
@@ -243,14 +243,31 @@ struct f2fs_extent {
 #define F2FS_NAME_LEN		255
 /* 200 bytes for inline xattrs by default */
 #define DEFAULT_INLINE_XATTR_ADDRS	50
-#define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
+
+#define OFFSET_OF_END_OF_I_EXT		360
+#define SIZE_OF_I_NID			20
+
+struct node_footer {
+	__le32 nid;		/* node id */
+	__le32 ino;		/* inode number */
+	__le32 flag;		/* include cold/fsync/dentry marks and offset */
+	__le64 cp_ver;		/* checkpoint version */
+	__le32 next_blkaddr;	/* next node page block address */
+} __packed;
+
+/* Address Pointers in an Inode */
+#define DEF_ADDRS_PER_INODE	((F2FS_BLKSIZE - OFFSET_OF_END_OF_I_EXT	\
+					- SIZE_OF_I_NID	\
+					- sizeof(struct node_footer)) / sizeof(__le32))
 #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
 					get_extra_isize(inode))
 #define DEF_NIDS_PER_INODE	5	/* Node IDs in an Inode */
 #define ADDRS_PER_INODE(inode)	addrs_per_inode(inode)
-#define DEF_ADDRS_PER_BLOCK	1018	/* Address Pointers in a Direct Block */
+/* Address Pointers in a Direct Block */
+#define DEF_ADDRS_PER_BLOCK	((F2FS_BLKSIZE - sizeof(struct node_footer)) / sizeof(__le32))
 #define ADDRS_PER_BLOCK(inode)	addrs_per_block(inode)
-#define NIDS_PER_BLOCK		1018	/* Node IDs in an Indirect Block */
+/* Node IDs in an Indirect Block */
+#define NIDS_PER_BLOCK		((F2FS_BLKSIZE - sizeof(struct node_footer)) / sizeof(__le32))
 
 #define ADDRS_PER_PAGE(page, inode)	\
 	(IS_INODE(page) ? ADDRS_PER_INODE(inode) : ADDRS_PER_BLOCK(inode))
@@ -342,14 +359,6 @@ enum {
 
 #define OFFSET_BIT_MASK		GENMASK(OFFSET_BIT_SHIFT - 1, 0)
 
-struct node_footer {
-	__le32 nid;		/* node id */
-	__le32 ino;		/* inode number */
-	__le32 flag;		/* include cold/fsync/dentry marks and offset */
-	__le64 cp_ver;		/* checkpoint version */
-	__le32 next_blkaddr;	/* next node page block address */
-} __packed;
-
 struct f2fs_node {
 	/* can be one of three types: inode, direct, and indirect types */
 	union {
@@ -363,7 +372,7 @@ struct f2fs_node {
 /*
  * For NAT entries
  */
-#define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
+#define NAT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / sizeof(struct f2fs_nat_entry))
 
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
@@ -378,12 +387,13 @@ struct f2fs_nat_block {
 /*
  * For SIT entries
  *
- * Each segment is 2MB in size by default so that a bitmap for validity of
- * there-in blocks should occupy 64 bytes, 512 bits.
+ * A validity bitmap of 64 bytes covers 512 blocks of area. For a 4K page size,
+ * this results in a segment size of 2MB. For 16k pages, the default segment size
+ * is 8MB.
  * Not allow to change this.
  */
 #define SIT_VBLOCK_MAP_SIZE 64
-#define SIT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_sit_entry))
+#define SIT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / sizeof(struct f2fs_sit_entry))
 
 /*
  * F2FS uses 4 bytes to represent block address. As a result, supported size of
@@ -418,7 +428,7 @@ struct f2fs_sit_block {
  * For segment summary
  *
  * One summary block contains exactly 512 summary entries, which represents
- * exactly 2MB segment by default. Not allow to change the basic units.
+ * exactly one segment by default. Not allow to change the basic units.
  *
  * NOTE: For initializing fields, you must use set_summary
  *
@@ -429,12 +439,12 @@ struct f2fs_sit_block {
  * from node's page's beginning to get a data block address.
  * ex) data_blkaddr = (block_t)(nodepage_start_address + ofs_in_node)
  */
-#define ENTRIES_IN_SUM		512
+#define ENTRIES_IN_SUM		(F2FS_BLKSIZE / 8)
 #define	SUMMARY_SIZE		(7)	/* sizeof(struct summary) */
 #define	SUM_FOOTER_SIZE		(5)	/* sizeof(struct summary_footer) */
 #define SUM_ENTRY_SIZE		(SUMMARY_SIZE * ENTRIES_IN_SUM)
 
-/* a summary entry for a 4KB-sized block in a segment */
+/* a summary entry for a block in a segment */
 struct f2fs_summary {
 	__le32 nid;		/* parent node id */
 	union {
@@ -518,7 +528,7 @@ struct f2fs_journal {
 	};
 } __packed;
 
-/* 4KB-sized summary block structure */
+/* Block-sized summary block structure */
 struct f2fs_summary_block {
 	struct f2fs_summary entries[ENTRIES_IN_SUM];
 	struct f2fs_journal journal;
@@ -559,11 +569,14 @@ typedef __le32	f2fs_hash_t;
  * Note: there are more reserved space in inline dentry than in regular
  * dentry, when converting inline dentry we should handle this carefully.
  */
-#define NR_DENTRY_IN_BLOCK	214	/* the number of dentry in a block */
+
+/* the number of dentry in a block */
+#define NR_DENTRY_IN_BLOCK	((BITS_PER_BYTE * F2FS_BLKSIZE) / \
+					((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * BITS_PER_BYTE + 1))
 #define SIZE_OF_DIR_ENTRY	11	/* by byte */
 #define SIZE_OF_DENTRY_BITMAP	((NR_DENTRY_IN_BLOCK + BITS_PER_BYTE - 1) / \
 					BITS_PER_BYTE)
-#define SIZE_OF_RESERVED	(PAGE_SIZE - ((SIZE_OF_DIR_ENTRY + \
+#define SIZE_OF_RESERVED	(F2FS_BLKSIZE - ((SIZE_OF_DIR_ENTRY + \
 				F2FS_SLOT_LEN) * \
 				NR_DENTRY_IN_BLOCK + SIZE_OF_DENTRY_BITMAP))
 #define MIN_INLINE_DENTRY_SIZE		40	/* just include '.' and '..' entries */
@@ -576,7 +589,7 @@ struct f2fs_dir_entry {
 	__u8 file_type;		/* file type */
 } __packed;
 
-/* 4KB-sized directory entry block */
+/* Block-sized directory entry block */
 struct f2fs_dentry_block {
 	/* validity bitmap for directory entries in each block */
 	__u8 dentry_bitmap[SIZE_OF_DENTRY_BITMAP];
-- 
2.41.0.694.ge786442a9b-goog

