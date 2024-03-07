Return-Path: <linux-kernel+bounces-94963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD3587474D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C0E1F2404D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC6200DE;
	Thu,  7 Mar 2024 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mJfe0h+P"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376157484;
	Thu,  7 Mar 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785190; cv=none; b=U7keh4InqymvtlTV0d7QRb1vXJhMeWK9izB1cbMPaSQMhbhxXGvoa8fQakoex7b/x/84RptIlaVGVMiY/J4e9EEx7VjeaP93CKyYX5dQwLxHgbV5zcgJK6jO7TzgpoXNQ+NGEhygrBlF28CmzPqrLgf4CCkxlbnIwCevsSJMkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785190; c=relaxed/simple;
	bh=e2bhHrOwQeDgAKyoVc5WzHKd697WiF5XcMsoy1z5sI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mKgsaL/Ju0OpIZg4DD8j4ZXbzcOW/0PHPaw/RyVFtNcBsbMZneouHrvGL3XRSlvM5mqd3AEQ5hgVAbsC0tBjiAvBopYgfkLQdqL6o6yc1UISk4F62ugUsBfcvAGiW9HJDLFhqBF10W7gELT7hTmRK02Z5m6peJera/r2ZYrLqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mJfe0h+P; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=r/rBM
	ENEVMoRhNYsxqvtzmdqWbZKq2KJxpW3M0pI9Po=; b=mJfe0h+P2YQjxD5GyXyLj
	asaK2bP8Utt8vu7m8c2cSuFbsTa4bHcys2GsfJsjKSHAij+6tc+KX1Et3TsrjJIr
	yvFXoEBLv7HmMoN4mimxKEbanOcR9AMQ8Nu4ML3r7aSCdHOr0+TOvRII/rXI8Jup
	Cftbtn0orBLySWiFHyYDUU=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S10;
	Thu, 07 Mar 2024 12:19:18 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	Martijn Coenen <maco@android.com>,
	Christoph Hellwig <hch@lst.de>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH linux-5.4.y 6/8] loop: Factor out configuring loop from status
Date: Thu,  7 Mar 2024 12:14:09 +0800
Message-Id: <20240307041411.3792061-7-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307041411.3792061-1-zhanggenjian@126.com>
References: <20240307041411.3792061-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4xZr43Jw1UGr4DXF4kXrb_yoWrtF4rpF
	sIgFyYyrWFqF4xWF45tw4kWFW5G3Wjk347Cry7J34jkr1jvr9Iq34akryjga97JryDua4Y
	q390yF1ruryUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtiSLUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHgqafmV2z-5wPQAAsf

From: Martijn Coenen <maco@android.com>

[ Upstream commit 0c3796c244598122a5d59d56f30d19390096817f ]

Factor out this code into a separate function, so it can be reused by
other code more easily.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 117 +++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 54f0f592423d..eadb189be0cc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1258,75 +1258,43 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
+/**
+ * loop_set_status_from_info - configure device from loop_info
+ * @lo: struct loop_device to configure
+ * @info: struct loop_info64 to configure the device with
+ *
+ * Configures the loop device parameters according to the passed
+ * in loop_info64 configuration.
+ */
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
 {
 	int err;
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
-	struct block_device *bdev;
-	bool partscan = false;
-	bool size_changed = false;
-
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
-	if (lo->lo_encrypt_key_size &&
-	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN)) {
-		err = -EPERM;
-		goto out_unlock;
-	}
-	if (lo->lo_state != Lo_bound) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		size_changed = true;
-		sync_blockdev(lo->lo_device);
-		invalidate_bdev(lo->lo_device);
-	}
 
-	/* I/O need to be drained during transfer transition */
-	blk_mq_freeze_queue(lo->lo_queue);
-
-	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
-		/* If any pages were dirtied after invalidate_bdev(), try again */
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
+		return -EINVAL;
 
 	err = loop_release_xfer(lo);
 	if (err)
-		goto out_unfreeze;
+		return err;
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
-		if (type >= MAX_LO_CRYPT) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
+		if (type >= MAX_LO_CRYPT)
+			return -EINVAL;
 		xfer = xfer_funcs[type];
-		if (xfer == NULL) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
+		if (xfer == NULL)
+			return -EINVAL;
 	} else
 		xfer = NULL;
 
 	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		goto out_unfreeze;
+		return err;
 
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
@@ -1353,6 +1321,55 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	return 0;
+}
+
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+{
+	int err;
+	struct block_device *bdev;
+	kuid_t uid = current_uid();
+	bool partscan = false;
+	bool size_changed = false;
+
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		return err;
+	if (lo->lo_encrypt_key_size &&
+	    !uid_eq(lo->lo_key_owner, uid) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit) {
+		size_changed = true;
+		sync_blockdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
+	}
+
+	/* I/O need to be drained during transfer transition */
+	blk_mq_freeze_queue(lo->lo_queue);
+
+	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
+		/* If any pages were dirtied after invalidate_bdev(), try again */
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
+	err = loop_set_status_from_info(lo, info);
+	if (err)
+		goto out_unfreeze;
+
 	if (size_changed) {
 		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
 					   lo->lo_backing_file);
-- 
2.25.1


