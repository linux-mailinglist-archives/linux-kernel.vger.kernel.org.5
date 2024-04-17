Return-Path: <linux-kernel+bounces-149240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F176A8A8D89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A901F22037
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81948495CB;
	Wed, 17 Apr 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb32onrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28B18C19
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388323; cv=none; b=FBfAkW6orgC52UGG0exG43XQQv92HQIWC2zEPIaYGqc4IQZZDEq/54UR6OkE5Ax0LUxj0tpAuwQ1j/55VXlrL+4AZJmpQCxbRVsNlxTVHAAjMnfc8lQ+7yp4/Jsd+rGKSo+RR5zy+a7WL61wbAC/+sTZwDTFXUJLRLy0Xllw+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388323; c=relaxed/simple;
	bh=QarXj+s/wPiCd324CLbe5/b03kj2VCCAjbBMQT6SOZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZDh8TRVMavlDQ0zBxvqbS8uaEXwDIxZYjBxdbhfhgj9p9XU6+KHvlP8iBoO3htALbN/PtcOQLK+R5EwUeyX0EMsy3h/cX7H930oviGbG1L72tXEZa4KT2m17zbAoigyGe4C57L86Te866ZXmYtVoRih9P2qTt0sUh8vaidUVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb32onrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A0DC072AA;
	Wed, 17 Apr 2024 21:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713388323;
	bh=QarXj+s/wPiCd324CLbe5/b03kj2VCCAjbBMQT6SOZc=;
	h=From:To:Cc:Subject:Date:From;
	b=lb32onrf4lOWuPDyDlZMiePYzDKx+PU7/6WoDuB3z3gHKmZ+7Ne+rL6T5GjDDq+Bo
	 8XbYS3ExHuGsBM1AVsf8ubHtzaznUHkJBNu+BkViUDBPsOUNMthMf89x1ozzt1dEZw
	 +oYh+61mwxbaLCA+Xmq/KDd2FScFpsvBG/vHmhfpslFPnsKU9Mp3tILMJddxQ21PVw
	 nfydajmXUaKJXAc3TJ3gEMTSXV38N7JJtKH5D8nQA//22fiIpvyZ06+LMbuRmvja2N
	 Fgr+Cdta1EXskNh2Wf3oEROGvfRwAVSa0vMQDWotXfrY6YsipVgfsLV+uBYqovMuGN
	 V5NUgBqJNoH2w==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: assign the write hint per stream by default
Date: Wed, 17 Apr 2024 21:12:01 +0000
Message-ID: <20240417211201.3919770-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 930e2607638d ("f2fs: remove obsolete whint_mode"), as we
decide to pass write hints to the disk.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 29 +++++++++++++++
 fs/f2fs/data.c                     |  2 +
 fs/f2fs/f2fs.h                     |  2 +
 fs/f2fs/segment.c                  | 59 ++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index efc3493fd6f8..68a0885fb5e6 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -774,6 +774,35 @@ In order to identify whether the data in the victim segment are valid or not,
 F2FS manages a bitmap. Each bit represents the validity of a block, and the
 bitmap is composed of a bit stream covering whole blocks in main area.
 
+Write-hint Policy
+-----------------
+
+F2FS sets the whint all the time with the below policy.
+
+===================== ======================== ===================
+User                  F2FS                     Block
+===================== ======================== ===================
+N/A                   META                     WRITE_LIFE_NONE|REQ_META
+N/A                   HOT_NODE                 WRITE_LIFE_NONE
+N/A                   WARM_NODE                WRITE_LIFE_MEDIUM
+N/A                   COLD_NODE                WRITE_LIFE_LONG
+ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+extension list        "                        "
+
+-- buffered io
+N/A                   COLD_DATA                WRITE_LIFE_EXTREME
+N/A                   HOT_DATA                 WRITE_LIFE_SHORT
+N/A                   WARM_DATA                WRITE_LIFE_NOT_SET
+
+-- direct io
+WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+===================== ======================== ===================
+
 Fallocate(2) Policy
 -------------------
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5d641fac02ba..ed7d08785fcf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -465,6 +465,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
+		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
+						fio->type, fio->temp);
 	}
 	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dd530dc70005..b3b878acc86b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3745,6 +3745,8 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
 void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+			enum page_type type, enum temp_type temp);
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f0da516ba8dc..daa94669f7ee 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3364,6 +3364,65 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
 	}
 }
 
+/*
+ * This returns write hints for each segment type. This hints will be
+ * passed down to block layer as below by default.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_NONE|REQ_META
+ *                       HOT_NODE                 WRITE_LIFE_NONE
+ *                       WARM_NODE                WRITE_LIFE_MEDIUM
+ *                       COLD_NODE                WRITE_LIFE_LONG
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+ * extension list        "                        "
+ *
+ * -- buffered io
+ *                       COLD_DATA                WRITE_LIFE_EXTREME
+ *                       HOT_DATA                 WRITE_LIFE_SHORT
+ *                       WARM_DATA                WRITE_LIFE_NOT_SET
+ *
+ * -- direct io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+ * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+ * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+ */
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+				enum page_type type, enum temp_type temp)
+{
+	switch (type) {
+	case DATA:
+		switch (temp) {
+		case WARM:
+			return WRITE_LIFE_NOT_SET;
+		case HOT:
+			return WRITE_LIFE_SHORT;
+		case COLD:
+			return WRITE_LIFE_EXTREME;
+		default:
+			return WRITE_LIFE_NONE;
+		}
+	case NODE:
+		switch (temp) {
+		case WARM:
+			return WRITE_LIFE_MEDIUM;
+		case HOT:
+			return WRITE_LIFE_NONE;
+		case COLD:
+			return WRITE_LIFE_LONG;
+		default:
+			return WRITE_LIFE_NONE;
+		}
+	case META:
+		return WRITE_LIFE_NONE;
+	default:
+		return WRITE_LIFE_NONE;
+	}
+}
+
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
-- 
2.44.0.683.g7961c838ac-goog


