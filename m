Return-Path: <linux-kernel+bounces-87775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD486D8E1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4281C21329
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E73A1A7;
	Fri,  1 Mar 2024 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LNV7gEd4"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24138DC3;
	Fri,  1 Mar 2024 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256792; cv=none; b=RS/XotqBPd/IO3nAo/iIjQIIeGsxyXyprUKhO2gaZ0NQk9qX7rXu0+uutXpyTTg2OMyAv6Wn4UEJHwvIbTg/oGfPU1wIp7dfH3Jpkp0qY4XVD0SGgSg4WhqvpQ28eA8K0wgpNt+Unqk7sl5mJtbL9aZJBeIYBSgbVrcz8T1M7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256792; c=relaxed/simple;
	bh=//shxWOgs6DUM19ppmRaIyOvk+IKSFn/j4eaP7r+Vgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7yze/Wte9hvaRdra7+xwFaJZWgwvB3JKD6vffdiaoHCWDqX2B2Q4nIHGLFKnhG1kleRfOgyrC80t2cDjlub3VG0d0iUnlNGu2cwmnZ5nYcjSnyVSxh3liNr6DHeengLV0DN44ohG5mJbVAPJyyXa29TvOYIXvKujv1BZSWF3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=LNV7gEd4; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EqfKZ
	GDvpnWQ+qwyxpLC5/VVhwI3t8YX1f9H+0jPymU=; b=LNV7gEd4lcR0AT8fPpbOh
	isQfXcqySwZELJK+RkJV1ziIir+AwX7UsmPT28xH64Dqo+1lDj8mwKGttJWpjLJr
	1jDiTpXu4BrfwP57HCsD37lZ+ckRHy+eRIUmMm8X/DAzbUYbJS9ywMq31/t4A9dc
	1JK62+ID1kKXLEx0a9Gmzg=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S7;
	Fri, 01 Mar 2024 09:32:39 +0800 (CST)
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
Subject: [PATCH 4.19.y 3/9] loop: Remove sector_t truncation checks
Date: Fri,  1 Mar 2024 09:30:22 +0800
Message-Id: <20240301013028.2293831-4-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301013028.2293831-1-zhanggenjian@126.com>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryDKF45WF17Ar4fuFy3Arb_yoW5Gw4xpF
	sruFy5AayFqFWxWFsFqr4kZFyYg3ZrW343ury7C3409r1YqrnYqFy3AryFgrWktrykZF1Y
	vws8JFy8ur1UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUYFZUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHhmUfmV2z7wVDwABsW

From: Martijn Coenen <maco@android.com>

[ Upstream commit 083a6a50783ef54256eec3499e6575237e0e3d53 ]

sector_t is now always u64, so we don't need to check for truncation.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bd94406b90c9..281aefba2a6f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -225,24 +225,20 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
-static int
+static void
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	sector_t x = (sector_t)size;
 	struct block_device *bdev = lo->lo_device;
 
-	if (unlikely((loff_t)x != size))
-		return -EFBIG;
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
+	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
-	return 0;
 }
 
 static inline int
@@ -972,10 +968,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = -EFBIG;
 	size = get_loop_size(lo, file);
-	if ((loff_t)(sector_t)size != size)
-		goto out_unlock;
+
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -1280,10 +1274,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 				lo->lo_device->bd_inode->i_mapping->nrpages);
 			goto out_unfreeze;
 		}
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
-			err = -EFBIG;
-			goto out_unfreeze;
-		}
+		figure_loop_size(lo, info->lo_offset, info->lo_sizelimit);
 	}
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
@@ -1486,7 +1477,9 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+
+	return 0;
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
-- 
2.25.1


