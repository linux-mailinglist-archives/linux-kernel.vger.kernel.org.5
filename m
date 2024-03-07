Return-Path: <linux-kernel+bounces-94959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD3874740
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EE6284FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD61CA84;
	Thu,  7 Mar 2024 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aQ+nfug9"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024B91AACE;
	Thu,  7 Mar 2024 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785184; cv=none; b=cEPh22hu3K3gOEdyvIRM+m6J8qs47FQmBEXaCd6N3adznQooUe85Zjv/7cFQBrjyaScK8yMZ69v7Y2CpgXaaDrdOdvM5stOwhVWyFdWRbQmU3MFLwCDpGXmL0CkJHTmZjCRepReAqnSFRxwaUBN5p3sRR74T0cOFk00TvjMkvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785184; c=relaxed/simple;
	bh=ozxL5somyqRqKjDLdW5j/dUN0mz8Cr7seBGTq1xbvRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7C8B8UZdMjxNQAMuvmUL0Q5CVijDJOhS+cISL5mU4YKQypALH6cNW9YqUMRwz7fJNrPJO7eKwAs7eAeGrsQvpE/TTVFFdLuQ+5LC0iQsxjdfOBDHno9ZX6T2AvIwpIEsIuTxBz6LgPEABzwnAZHh0AegztqIfVV99l7bcR3Ylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=aQ+nfug9; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0j7iX
	kFpDrkLiTAq08vwO+JSZACPLyqH2NU/Ak+4Uy4=; b=aQ+nfug95ZArDZ3TDMZbV
	T6OfqDRdrGhsdNT55z5ekY2hcQ+h9AOnYaE8jUVzMjkG7qL3M+E49PdPYrdzRDzi
	OSrubetqj0+tESCycVwcfk3lWyWbw16yxCBefvg6Txt+7XQrcmyhDIW9KxemsnOB
	CiIERGfU2ZQtlRJrx8Z/7A=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S8;
	Thu, 07 Mar 2024 12:19:16 +0800 (CST)
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
Subject: [PATCH linux-5.4.y 4/8] loop: Factor out setting loop device size
Date: Thu,  7 Mar 2024 12:14:07 +0800
Message-Id: <20240307041411.3792061-5-zhanggenjian@126.com>
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
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4fGrWUZr15Zr1kGFy5XFb_yoW5JFyxpF
	13Wa4fJ3yF9Fy7WFsIqr1kZFWYga1kW347ury7C3409a15trnagF1rAry8WFWktrWkWF15
	Za98Jr109r1UGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jK89_UUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBiafmWWf4vfzwAAsj

From: Martijn Coenen <maco@android.com>

[ Upstream commit 5795b6f5607f7e4db62ddea144727780cb351a9b ]

This code is used repeatedly.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 45237d44a867..78bfba4bce8a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -226,20 +226,35 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
+/**
+ * loop_set_size() - sets device size and notifies userspace
+ * @lo: struct loop_device to set the size for
+ * @size: new size of the loop device
+ *
+ * Callers must validate that the size passed into this function fits into
+ * a sector_t, eg using loop_validate_size()
+ */
+static void loop_set_size(struct loop_device *lo, loff_t size)
+{
+	struct block_device *bdev = lo->lo_device;
+
+	set_capacity(lo->lo_disk, size);
+	bd_set_size(bdev, size << SECTOR_SHIFT);
+	/* let user-space know about the new size */
+	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+}
+
 static void
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	struct block_device *bdev = lo->lo_device;
 
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	loop_set_size(lo, size);
 }
 
 static inline int
@@ -1033,11 +1048,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, size << 9);
 	loop_sysfs_init(lo);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
-- 
2.25.1


