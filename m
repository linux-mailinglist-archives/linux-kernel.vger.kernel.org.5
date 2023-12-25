Return-Path: <linux-kernel+bounces-11096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE381E139
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2238F1C212DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C68537F2;
	Mon, 25 Dec 2023 15:03:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDF51C27
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SzLk23Qx3z1wpDk;
	Mon, 25 Dec 2023 23:02:50 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id ABD851402CB;
	Mon, 25 Dec 2023 23:03:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 25 Dec
 2023 23:03:10 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH V6 3/5] ubi: Add six fault injection type for testing
Date: Mon, 25 Dec 2023 23:00:47 +0800
Message-ID: <20231225150049.183756-4-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225150049.183756-1-wangzhaolong1@huawei.com>
References: <20231225150049.183756-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)

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
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/debug.c |  30 +++++++
 drivers/mtd/ubi/debug.h | 172 ++++++++++++++++++++++++++++++++++++++--
 drivers/mtd/ubi/io.c    |  76 +++++++++++++++++-
 drivers/mtd/ubi/ubi.h   |  30 ++++---
 4 files changed, 287 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 186306228b4d..007f82d71020 100644
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
index 8cdd25eee013..b2fd97548808 100644
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
@@ -122,19 +149,72 @@ static inline bool ubi_dbg_fail_erase(const struct ubi_device *ubi)
 }
 
 static inline bool ubi_dbg_fail_power_cut(const struct ubi_device *ubi,
-					unsigned int caller)
+					  unsigned int caller)
 {
 	if (ubi->dbg.emulate_failures & caller)
 		return should_fail_power_cut();
 	return false;
 }
 
+static inline bool ubi_dbg_fail_read(const struct ubi_device *ubi,
+				     unsigned int caller)
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
+				   unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_io_ff();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_ff_bitflips(const struct ubi_device *ubi,
+					    unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_io_ff_bitflips();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_bad_hdr(const struct ubi_device *ubi,
+					 unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_bad_hdr();
+	return false;
+}
+
+static inline bool ubi_dbg_fail_bad_hdr_ebadmsg(const struct ubi_device *ubi,
+						 unsigned int caller)
+{
+	if (ubi->dbg.emulate_failures & caller)
+		return should_fail_bad_hdr_ebadmsg();
+	return false;
+}
 #else /* CONFIG_MTD_UBI_FAULT_INJECTION */
 
 #define ubi_dbg_fail_bitflip(u)             false
 #define ubi_dbg_fail_write(u)               false
 #define ubi_dbg_fail_erase(u)               false
 #define ubi_dbg_fail_power_cut(u, c)        false
+#define ubi_dbg_fail_read(u, c)             false
+#define ubi_dbg_fail_eccerr(u)              false
+#define ubi_dbg_fail_ff(u, c)               false
+#define ubi_dbg_fail_ff_bitflips(u, v)      false
+#define ubi_dbg_fail_bad_hdr(u, c)          false
+#define ubi_dbg_fail_bad_hdr_ebadmsg(u, c)  false
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
index fb70f5227f18..a4999bce435f 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -195,7 +195,19 @@ int ubi_io_read(const struct ubi_device *ubi, void *buf, int pnum, int offset,
 
 		if (ubi_dbg_is_bitflip(ubi)) {
 			dbg_gen("bit-flip (emulated)");
-			err = UBI_IO_BITFLIPS;
+			return UBI_IO_BITFLIPS;
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
+		ubi_warn(ubi, "cannot read EC header from PEB %d (emulated)",
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
+		ubi_warn(ubi, "cannot read VID header from PEB %d (emulated)",
+			 pnum);
+		return -EIO;
+	}
+
+	if (ubi_dbg_is_ff(ubi, MASK_IO_FF_VID)) {
+		ubi_warn(ubi, "bit-all-ff (emulated)");
+		return UBI_IO_FF;
+	}
+
+	if (ubi_dbg_is_ff_bitflips(ubi, MASK_IO_FF_BITFLIPS_VID)) {
+		ubi_warn(ubi, "bit-all-ff with error reported by MTD driver (emulated)");
+		return UBI_IO_FF_BITFLIPS;
+	}
+
+	if (ubi_dbg_is_bad_hdr(ubi, MASK_BAD_HDR_VID)) {
+		ubi_warn(ubi, "bad_hdr (emulated)");
+		return UBI_IO_BAD_HDR;
+	}
+
+	if (ubi_dbg_is_bad_hdr_ebadmsg(ubi, MASK_BAD_HDR_EBADMSG_VID)) {
+		ubi_warn(ubi, "bad_hdr with ECC error (emulated)");
+		return UBI_IO_BAD_HDR_EBADMSG;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index cc4777983bd2..0b42bb45dd84 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -1123,6 +1123,19 @@ static inline struct ubi_vid_hdr *ubi_get_vid_hdr(struct ubi_vid_io_buf *vidb)
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
@@ -1144,20 +1157,13 @@ static inline int ubi_io_write_data(struct ubi_device *ubi, const void *buf,
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
2.39.2


