Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA97D08AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376375AbjJTGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjJTGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:43:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714B3D7B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:43:34 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SBZgP37HSzMlyX;
        Fri, 20 Oct 2023 14:39:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 20 Oct
 2023 14:43:20 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v3 3/5] ubi: Add six fault injection type for testing
Date:   Fri, 20 Oct 2023 14:48:01 +0800
Message-ID: <20231020064803.643399-4-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231020064803.643399-1-wangzhaolong1@huawei.com>
References: <20231020064803.643399-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds six fault injection type for testing to cover the
abnormal path of the UBI driver.

Inject the following faults when the UBI reads the LEB:
 +----------------------------+-----------------------------------+
 |    Interface name          |       emulate behavior            |
 +----------------------------+-----------------------------------+
 |  emulate_eccerr            | ECC error                         |
 +----------------------------+-----------------------------------+
 |  emulate_read_failure      | read failure                      |
 |----------------------------+-----------------------------------+
 |  emulate_io_ff             | read content as all FF            |
 |----------------------------+-----------------------------------+
 |  emulate_io_ff_bitflips    | content FF with MTD err reported  |
 +----------------------------+-----------------------------------+
 |  emulate_bad_hdr           | bad leb header                    |
 |----------------------------+-----------------------------------+
 |  emulate_bad_hdr_ebadmsg   | bad header with ECC err           |
 +----------------------------+-----------------------------------+

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c |  30 +++++++
 drivers/mtd/ubi/debug.h | 170 ++++++++++++++++++++++++++++++++++++++--
 drivers/mtd/ubi/io.c    |  76 +++++++++++++++++-
 drivers/mtd/ubi/ubi.h   |  30 ++++---
 4 files changed, 286 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 3ce5265e3a16..e8aa1827f23a 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -13,10 +13,16 @@
 #include <linux/fault-inject.h>
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
+static DECLARE_FAULT_ATTR(fault_eccerr_attr);
 static DECLARE_FAULT_ATTR(fault_bitflips_attr);
+static DECLARE_FAULT_ATTR(fault_read_failure_attr);
 static DECLARE_FAULT_ATTR(fault_write_failure_attr);
 static DECLARE_FAULT_ATTR(fault_erase_failure_attr);
 static DECLARE_FAULT_ATTR(fault_power_cut_attr);
+static DECLARE_FAULT_ATTR(fault_io_ff_attr);
+static DECLARE_FAULT_ATTR(fault_io_ff_bitflips_attr);
+static DECLARE_FAULT_ATTR(fault_bad_hdr_attr);
+static DECLARE_FAULT_ATTR(fault_bad_hdr_ebadmsg_attr);
 
 #define FAIL_ACTION(name, fault_attr)			\
 bool should_fail_##name(void)				\
@@ -24,10 +30,16 @@ bool should_fail_##name(void)				\
 	return should_fail(&fault_attr, 1);		\
 }
 
+FAIL_ACTION(eccerr,		fault_eccerr_attr)
 FAIL_ACTION(bitflips,		fault_bitflips_attr)
+FAIL_ACTION(read_failure,	fault_read_failure_attr)
 FAIL_ACTION(write_failure,	fault_write_failure_attr)
 FAIL_ACTION(erase_failure,	fault_erase_failure_attr)
 FAIL_ACTION(power_cut,		fault_power_cut_attr)
+FAIL_ACTION(io_ff,		fault_io_ff_attr)
+FAIL_ACTION(io_ff_bitflips,	fault_io_ff_bitflips_attr)
+FAIL_ACTION(bad_hdr,		fault_bad_hdr_attr)
+FAIL_ACTION(bad_hdr_ebadmsg,	fault_bad_hdr_ebadmsg_attr)
 #endif
 
 /**
@@ -244,6 +256,12 @@ static void dfs_create_fault_entry(struct dentry *parent)
 		return;
 	}
 
+	fault_create_debugfs_attr("emulate_eccerr", dir,
+				  &fault_eccerr_attr);
+
+	fault_create_debugfs_attr("emulate_read_failure", dir,
+				  &fault_read_failure_attr);
+
 	fault_create_debugfs_attr("emulate_bitflips", dir,
 				  &fault_bitflips_attr);
 
@@ -255,6 +273,18 @@ static void dfs_create_fault_entry(struct dentry *parent)
 
 	fault_create_debugfs_attr("emulate_power_cut", dir,
 				  &fault_power_cut_attr);
+
+	fault_create_debugfs_attr("emulate_io_ff", dir,
+				  &fault_io_ff_attr);
+
+	fault_create_debugfs_attr("emulate_io_ff_bitflips", dir,
+				  &fault_io_ff_bitflips_attr);
+
+	fault_create_debugfs_attr("emulate_bad_hdr", dir,
+				  &fault_bad_hdr_attr);
+
+	fault_create_debugfs_attr("emulate_bad_hdr_ebadmsg", dir,
+				  &fault_bad_hdr_ebadmsg_attr);
 }
 #endif
 
diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index 7386c40474de..8b82f5b95390 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -87,18 +87,45 @@ static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
 /* Emulate a power cut when writing EC/VID header */
 #define MASK_POWER_CUT_EC			(1 << 0)
 #define MASK_POWER_CUT_VID			(1 << 1)
+/* Emulate a power cut when writing data*/
+#define MASK_POWER_CUT_DATA			(1 << 2)
+/* Emulate bit-flips */
+#define MASK_BITFLIPS				(1 << 3)
+/* Emulate ecc error */
+#define MASK_ECCERR				(1 << 4)
+/* Emulates -EIO during data read */
+#define MASK_READ_FAILURE			(1 << 5)
+#define MASK_READ_FAILURE_EC			(1 << 6)
+#define MASK_READ_FAILURE_VID			(1 << 7)
+/* Emulates -EIO during data write */
+#define MASK_WRITE_FAILURE			(1 << 8)
+/* Emulates -EIO during erase a PEB*/
+#define MASK_ERASE_FAILURE			(1 << 9)
+/* Return UBI_IO_FF when reading EC/VID header */
+#define MASK_IO_FF_EC				(1 << 10)
+#define MASK_IO_FF_VID				(1 << 11)
+/* Return UBI_IO_FF_BITFLIPS when reading EC/VID header */
+#define MASK_IO_FF_BITFLIPS_EC			(1 << 12)
+#define MASK_IO_FF_BITFLIPS_VID			(1 << 13)
+/* Return UBI_IO_BAD_HDR when reading EC/VID header */
+#define MASK_BAD_HDR_EC				(1 << 14)
+#define MASK_BAD_HDR_VID			(1 << 15)
+/* Return UBI_IO_BAD_HDR_EBADMSG when reading EC/VID header */
+#define MASK_BAD_HDR_EBADMSG_EC			(1 << 16)
+#define MASK_BAD_HDR_EBADMSG_VID		(1 << 17)
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
-/* Emulate bit-flips */
-#define MASK_BITFLIPS				(1 << 2)
-/* Emulates -EIO during write/erase */
-#define MASK_WRITE_FAILURE			(1 << 3)
-#define MASK_ERASE_FAILURE			(1 << 4)
 
+extern bool should_fail_eccerr(void);
 extern bool should_fail_bitflips(void);
+extern bool should_fail_read_failure(void);
 extern bool should_fail_write_failure(void);
 extern bool should_fail_erase_failure(void);
 extern bool should_fail_power_cut(void);
+extern bool should_fail_io_ff(void);
+extern bool should_fail_io_ff_bitflips(void);
+extern bool should_fail_bad_hdr(void);
+extern bool should_fail_bad_hdr_ebadmsg(void);
 
 static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
 {
@@ -129,12 +156,65 @@ static inline bool ubi_dbg_fail_power_cut(const struct ubi_device *ubi,
 	return false;
 }
 
+static inline bool ubi_dbg_fail_read(const struct ubi_device *ubi,
+					   unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_read_failure();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_eccerr(const struct ubi_device *ubi)
+{
+	if (ubi->dbg.emulate_failures & MASK_ECCERR)
+		return should_fail_eccerr();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_ff(const struct ubi_device *ubi,
+				 unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_io_ff();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_ff_bitflips(const struct ubi_device *ubi,
+					  unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_io_ff_bitflips();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_bad_hdr(const struct ubi_device *ubi,
+				      unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_bad_hdr();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_bad_hdr_ebadmsg(const struct ubi_device *ubi,
+					      unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_bad_hdr_ebadmsg();
+	return false;
+}
 #else /* CONFIG_MTD_UBI_FAULT_INJECTION */
 
 #define ubi_dbg_fail_bitflip(u)           false
 #define ubi_dbg_fail_write(u)             false
 #define ubi_dbg_fail_erase(u)             false
 #define ubi_dbg_fail_power_cut(u,c)       false
+#define ubi_dbg_fail_read(u,c)            false
+#define ubi_dbg_fail_eccerr(u)            false
+#define ubi_dbg_fail_ff(u,c)              false
+#define ubi_dbg_fail_ff_bitflips(u,v)     false
+#define ubi_dbg_fail_bad_hdr(u,c)         false
+#define ubi_dbg_fail_bad_hdr_ebadmsg(u,c) false
+
 #endif
 
 /**
@@ -192,6 +272,86 @@ static inline bool ubi_dbg_is_erase_failure(const struct ubi_device *ubi)
 	return ubi_dbg_fail_erase(ubi);
 }
 
+/**
+ * ubi_dbg_is_eccerr - if it is time to emulate ECC error.
+ * @ubi: UBI device description object
+ *
+ * Returns true if a ECC error should be emulated, otherwise returns false.
+ */
+static inline bool ubi_dbg_is_eccerr(const struct ubi_device *ubi)
+{
+	return ubi_dbg_fail_eccerr(ubi);
+}
+
+/**
+ * ubi_dbg_is_read_failure - if it is time to emulate a read failure.
+ * @ubi: UBI device description object
+ *
+ * Returns true if a read failure should be emulated, otherwise returns
+ * false.
+ */
+static inline bool ubi_dbg_is_read_failure(const struct ubi_device *ubi,
+					   unsigned int caller)
+{
+	return ubi_dbg_fail_read(ubi, caller);
+}
+
+/**
+ * ubi_dbg_is_ff - if it is time to emulate that read region is only 0xFF.
+ * @ubi: UBI device description object
+ *
+ * Returns true if read region should be emulated 0xFF, otherwise
+ * returns false.
+ */
+static inline bool ubi_dbg_is_ff(const struct ubi_device *ubi,
+				 unsigned int caller)
+{
+	return ubi_dbg_fail_ff(ubi, caller);
+}
+
+/**
+ * ubi_dbg_is_ff_bitflips - if it is time to emulate that read region is only 0xFF
+ * with error reported by the MTD driver
+ *
+ * @ubi: UBI device description object
+ *
+ * Returns true if read region should be emulated 0xFF and error
+ * reported by the MTD driver, otherwise returns false.
+ */
+static inline bool ubi_dbg_is_ff_bitflips(const struct ubi_device *ubi,
+					  unsigned int caller)
+{
+	return ubi_dbg_fail_ff_bitflips(ubi, caller);
+}
+
+/**
+ * ubi_dbg_is_bad_hdr - if it is time to emulate a bad header
+ * @ubi: UBI device description object
+ *
+ * Returns true if a bad header error should be emulated, otherwise
+ * returns false.
+ */
+static inline bool ubi_dbg_is_bad_hdr(const struct ubi_device *ubi,
+				      unsigned int caller)
+{
+	return ubi_dbg_fail_bad_hdr(ubi, caller);
+}
+
+/**
+ * ubi_dbg_is_bad_hdr_ebadmsg - if it is time to emulate a bad header with
+ * ECC error.
+ *
+ * @ubi: UBI device description object
+ *
+ * Returns true if a bad header with ECC error should be emulated, otherwise
+ * returns false.
+ */
+static inline bool ubi_dbg_is_bad_hdr_ebadmsg(const struct ubi_device *ubi,
+					      unsigned int caller)
+{
+	return ubi_dbg_fail_bad_hdr_ebadmsg(ubi, caller);
+}
+
 /**
  * ubi_dbg_is_bgt_disabled - if the background thread is disabled.
  * @ubi: UBI device description object
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index ffa7bbf27bc2..803e2b7f1d17 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -195,7 +195,19 @@ int ubi_io_read(const struct ubi_device *ubi, void *buf, int pnum, int offset,
 
 		if (ubi_dbg_is_bitflip(ubi)) {
 			dbg_gen("bit-flip (emulated)");
-			err = UBI_IO_BITFLIPS;
+			return  UBI_IO_BITFLIPS;
+		}
+
+		if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE)) {
+			ubi_warn(ubi, "cannot read %d bytes from PEB %d:%d (emulated)",
+				 len, pnum, offset);
+			return -EIO;
+		}
+
+		if (ubi_dbg_is_eccerr(ubi)) {
+			ubi_warn(ubi, "ECC error (emulated) while reading %d bytes from PEB %d:%d, read %zd bytes",
+				 len, pnum, offset, read);
+			return -EBADMSG;
 		}
 	}
 
@@ -782,7 +794,36 @@ int ubi_io_read_ec_hdr(struct ubi_device *ubi, int pnum,
 	 * If there was %-EBADMSG, but the header CRC is still OK, report about
 	 * a bit-flip to force scrubbing on this PEB.
 	 */
-	return read_err ? UBI_IO_BITFLIPS : 0;
+	if (read_err)
+		return UBI_IO_BITFLIPS;
+
+	if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE_EC)) {
+		ubi_warn(ubi, "cannot read EC header from PEB %d(emulated)",
+			 pnum);
+		return -EIO;
+	}
+
+	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_EC)) {
+		ubi_warn(ubi, "bit-all-ff (emulated)");
+		return UBI_IO_FF;
+	}
+
+	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_EC)) {
+		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)");
+		return UBI_IO_FF_BITFLIPS;
+	}
+
+	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_EC)) {
+		ubi_warn(ubi, "bad_hdr (emulated)");
+		return UBI_IO_BAD_HDR;
+	}
+
+	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_EC)) {
+		ubi_warn(ubi, "bad_hdr with ECC error (emulated)");
+		return UBI_IO_BAD_HDR_EBADMSG;
+	}
+
+	return 0;
 }
 
 /**
@@ -1032,7 +1073,36 @@ int ubi_io_read_vid_hdr(struct ubi_device *ubi, int pnum,
 		return -EINVAL;
 	}
 
-	return read_err ? UBI_IO_BITFLIPS : 0;
+	if (read_err)
+		return UBI_IO_BITFLIPS;
+
+	if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE_VID)) {
+		ubi_warn(ubi, "cannot read VID header from PEB %d(emulated)",
+			 pnum);
+		return -EIO;
+	}
+
+	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_VID)) {
+		ubi_warn(ubi, "bit-all-ff (emulated)\n");
+		return UBI_IO_FF;
+	}
+
+	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_VID)) {
+		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)\n");
+		return UBI_IO_FF_BITFLIPS;
+	}
+
+	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_VID)) {
+		ubi_warn(ubi, "bad_hdr (emulated)\n");
+		return UBI_IO_BAD_HDR;
+	}
+
+	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_VID)) {
+		ubi_warn(ubi, "bad_hdr with ECC error (emulated)\n");
+		return UBI_IO_BAD_HDR_EBADMSG;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 41f57d5717b2..e4b547514504 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -1117,6 +1117,19 @@ static inline struct ubi_vid_hdr *ubi_get_vid_hdr(struct ubi_vid_io_buf *vidb)
 	return vidb->hdr;
 }
 
+/**
+ * ubi_ro_mode - switch to read-only mode.
+ * @ubi: UBI device description object
+ */
+static inline void ubi_ro_mode(struct ubi_device *ubi)
+{
+	if (!ubi->ro_mode) {
+		ubi->ro_mode = 1;
+		ubi_warn(ubi, "switch to read-only mode");
+		dump_stack();
+	}
+}
+
 /*
  * This function is equivalent to 'ubi_io_read()', but @offset is relative to
  * the beginning of the logical eraseblock, not to the beginning of the
@@ -1138,20 +1151,13 @@ static inline int ubi_io_write_data(struct ubi_device *ubi, const void *buf,
 				    int pnum, int offset, int len)
 {
 	ubi_assert(offset >= 0);
-	return ubi_io_write(ubi, buf, pnum, offset + ubi->leb_start, len);
-}
 
-/**
- * ubi_ro_mode - switch to read-only mode.
- * @ubi: UBI device description object
- */
-static inline void ubi_ro_mode(struct ubi_device *ubi)
-{
-	if (!ubi->ro_mode) {
-		ubi->ro_mode = 1;
-		ubi_warn(ubi, "switch to read-only mode");
-		dump_stack();
+	if (ubi_dbg_power_cut(ubi, MASK_POWER_CUT_DATA)) {
+		ubi_warn(ubi, "XXXXX emulating a power cut when writing data XXXXX");
+		ubi_ro_mode(ubi);
+		return -EROFS;
 	}
+	return ubi_io_write(ubi, buf, pnum, offset + ubi->leb_start, len);
 }
 
 /**
-- 
2.31.1

