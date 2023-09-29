Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF037B3B85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjI2Upi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjI2Up0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:45:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E992D1B0;
        Fri, 29 Sep 2023 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020323; x=1727556323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiJpifxZQPr3x5nJ9GwyBlCzwdV0vc7uO6aAQUWW42c=;
  b=P0ZuvPFFaZnCIF53fTyyBwvBnVbAxdGoIjjspyxXNvRyZZC/ZdDM4eDn
   ly6+PpjmNlq4u/ykuEZp1EQw3UGaihGpi+3oPLQZXo1O+zspi2Q/b7zdO
   KwXuvj7CKu8LBOGDtcRZTVVAFtR2FVj1GDgkKUX7qxYqBvKEVkKKjRBSh
   IbkJMg3E8ZjzhhrZAwGzUrIposVXDSrkAyKUKaivNs1owaSBePU1JGAlN
   /1Fawxb+ozW9HR4TGPH4BG8nB0PVzOBHPRu/2BWE668KAqUaUhC5DYamO
   +43q7B2aaoKZUTUOBuJ0dfNTenLAJ9ZpWxyhBNYQj2eN7rmZy8SBGBC3D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468654441"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468654441"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893539210"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="893539210"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:27:29 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 3/9] platform/x86/intel/ifs: Gen2 scan image loading
Date:   Fri, 29 Sep 2023 13:24:30 -0700
Message-Id: <20230929202436.2850388-4-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929202436.2850388-1-jithu.joseph@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scan image loading flow for newer IFS generations are slightly different
from that of current generation. In newer schemes, loading need not be
done once for each socket as was done in gen0.

Also the width of NUM_CHUNKS bitfield in SCAN_HASHES_STATUS MSR has
increased from 8 -> 16 bits. Similarly there are width differences for
CHUNK_AUTHENTICATION_STATUS too.

Further the parameter to AUTHENTICATE_AND_COPY_CHUNK is passed
differently in newer generations.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  27 +++++++
 drivers/platform/x86/intel/ifs/load.c | 112 +++++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index d666aeed20fc..4824316b3acd 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -137,6 +137,8 @@
 #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
 #define MSR_ACTIVATE_SCAN			0x000002c6
 #define MSR_SCAN_STATUS				0x000002c7
+#define MSR_SAF_CTRL				0x000004f0
+
 #define SCAN_NOT_TESTED				0
 #define SCAN_TEST_PASS				1
 #define SCAN_TEST_FAIL				2
@@ -158,6 +160,19 @@ union ifs_scan_hashes_status {
 	};
 };
 
+union ifs_scan_hashes_status_gen2 {
+	u64	data;
+	struct {
+		u16	chunk_size;
+		u16	num_chunks;
+		u32	error_code		:8;
+		u32	chunks_in_stride	:9;
+		u32	rsvd			:2;
+		u32	max_core_limit		:12;
+		u32	valid			:1;
+	};
+};
+
 /* MSR_CHUNKS_AUTH_STATUS bit fields */
 union ifs_chunks_auth_status {
 	u64	data;
@@ -170,6 +185,16 @@ union ifs_chunks_auth_status {
 	};
 };
 
+union ifs_chunks_auth_status_gen2 {
+	u64	data;
+	struct {
+		u16	valid_chunks;
+		u16	total_chunks;
+		u32	error_code	:8;
+		u32	rsvd2		:24;
+	};
+};
+
 /* MSR_ACTIVATE_SCAN bit fields */
 union ifs_scan {
 	u64	data;
@@ -230,6 +255,7 @@ struct ifs_test_caps {
  * @scan_details: opaque scan status code from h/w
  * @cur_batch: number indicating the currently loaded test file
  * @generation: IFS test generation enumerated by hardware
+ * @chunk_size: size of a test chunk
  */
 struct ifs_data {
 	int	loaded_version;
@@ -240,6 +266,7 @@ struct ifs_data {
 	u64	scan_details;
 	u32	cur_batch;
 	u32	generation;
+	u32	chunk_size;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 851c97cc6a6b..6b827247945b 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2022 Intel Corporation. */
 
 #include <linux/firmware.h>
+#include <linux/sizes.h>
 #include <asm/cpu.h>
 #include <asm/microcode.h>
 
@@ -26,6 +27,11 @@ union meta_data {
 
 #define IFS_HEADER_SIZE	(sizeof(struct microcode_header_intel))
 #define META_TYPE_IFS	1
+#define INVALIDATE_STRIDE	0x1UL
+#define IFS_GEN_STRIDE_AWARE	2
+#define AUTH_INTERRUPTED_ERROR	5
+#define IFS_AUTH_RETRY_CT	10
+
 static  struct microcode_header_intel *ifs_header_ptr;	/* pointer to the ifs image header */
 static u64 ifs_hash_ptr;			/* Address of ifs metadata (hash) */
 static u64 ifs_test_image_ptr;			/* 256B aligned address of test pattern */
@@ -44,7 +50,10 @@ static const char * const scan_hash_status[] = {
 static const char * const scan_authentication_status[] = {
 	[0] = "No error reported",
 	[1] = "Attempt to authenticate a chunk which is already marked as authentic",
-	[2] = "Chunk authentication error. The hash of chunk did not match expected value"
+	[2] = "Chunk authentication error. The hash of chunk did not match expected value",
+	[3] = "Reserved",
+	[4] = "Chunk outside the current stride",
+	[5] = "Authentication flow interrupted",
 };
 
 #define MC_HEADER_META_TYPE_END		(0)
@@ -154,6 +163,102 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 	complete(&ifs_done);
 }
 
+static int get_num_chunks(int gen, union ifs_scan_hashes_status_gen2 status)
+{
+	return gen >= IFS_GEN_STRIDE_AWARE ? status.chunks_in_stride : status.num_chunks;
+}
+
+static bool need_copy_scan_hashes(struct ifs_data *ifsd)
+{
+	return !ifsd->loaded ||
+		ifsd->generation < IFS_GEN_STRIDE_AWARE ||
+		ifsd->loaded_version != ifs_header_ptr->rev;
+}
+
+static int copy_hashes_authenticate_chunks_gen2(struct device *dev)
+{
+	union ifs_scan_hashes_status_gen2 hashes_status;
+	union ifs_chunks_auth_status_gen2 chunk_status;
+	u32 err_code, valid_chunks, total_chunks;
+	int i, num_chunks, chunk_size;
+	union meta_data *ifs_meta;
+	int starting_chunk_nr;
+	struct ifs_data *ifsd;
+	u64 linear_addr, base;
+	u64 chunk_table[2];
+	int retry_count;
+
+	ifsd = ifs_get_data(dev);
+
+	if (need_copy_scan_hashes(ifsd)) {
+		wrmsrl(MSR_COPY_SCAN_HASHES, ifs_hash_ptr);
+		rdmsrl(MSR_SCAN_HASHES_STATUS, hashes_status.data);
+
+		/* enumerate the scan image information */
+		chunk_size = hashes_status.chunk_size * SZ_1K;
+		err_code = hashes_status.error_code;
+
+		num_chunks = get_num_chunks(ifsd->generation, hashes_status);
+
+		if (!hashes_status.valid) {
+			hashcopy_err_message(dev, err_code);
+			return -EIO;
+		}
+		ifsd->loaded_version = ifs_header_ptr->rev;
+		ifsd->chunk_size = chunk_size;
+	} else {
+		num_chunks = ifsd->valid_chunks;
+		chunk_size = ifsd->chunk_size;
+	}
+
+	if (ifsd->generation >= IFS_GEN_STRIDE_AWARE) {
+		wrmsrl(MSR_SAF_CTRL, INVALIDATE_STRIDE);
+		rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
+		if (chunk_status.valid_chunks != 0) {
+			dev_err(dev, "Couldn't invalidate installed stride - %d\n",
+				chunk_status.valid_chunks);
+			return -EIO;
+		}
+	}
+
+	base = ifs_test_image_ptr;
+	ifs_meta = (union meta_data *)find_meta_data(ifs_header_ptr, META_TYPE_IFS);
+	starting_chunk_nr = ifs_meta->starting_chunk;
+
+	/* scan data authentication and copy chunks to secured memory */
+	for (i = 0; i < num_chunks; i++) {
+		retry_count = IFS_AUTH_RETRY_CT;
+		linear_addr = base + i * chunk_size;
+
+		chunk_table[0] = starting_chunk_nr + i;
+		chunk_table[1] = linear_addr;
+		do {
+			wrmsrl(MSR_AUTHENTICATE_AND_COPY_CHUNK, (u64)chunk_table);
+			rdmsrl(MSR_CHUNKS_AUTHENTICATION_STATUS, chunk_status.data);
+			err_code = chunk_status.error_code;
+		} while (err_code == AUTH_INTERRUPTED_ERROR && --retry_count);
+
+		if (err_code) {
+			ifsd->loading_error = true;
+			auth_err_message(dev, err_code);
+			return -EIO;
+		}
+	}
+
+	valid_chunks = chunk_status.valid_chunks;
+	total_chunks = chunk_status.total_chunks;
+
+	if (valid_chunks != total_chunks) {
+		ifsd->loading_error = true;
+		dev_err(dev, "Couldn't authenticate all the chunks. Authenticated %d total %d.\n",
+			valid_chunks, total_chunks);
+		return -EIO;
+	}
+	ifsd->valid_chunks = valid_chunks;
+
+	return 0;
+}
+
 static int validate_ifs_metadata(struct device *dev)
 {
 	struct ifs_data *ifsd = ifs_get_data(dev);
@@ -206,7 +311,9 @@ static int scan_chunks_sanity_check(struct device *dev)
 		return ret;
 
 	ifsd->loading_error = false;
-	ifsd->loaded_version = ifs_header_ptr->rev;
+
+	if (ifsd->generation > 0)
+		return copy_hashes_authenticate_chunks_gen2(dev);
 
 	/* copy the scan hash and authenticate per package */
 	cpus_read_lock();
@@ -226,6 +333,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 		ifs_pkg_auth[curr_pkg] = 1;
 	}
 	ret = 0;
+	ifsd->loaded_version = ifs_header_ptr->rev;
 out:
 	cpus_read_unlock();
 
-- 
2.25.1

