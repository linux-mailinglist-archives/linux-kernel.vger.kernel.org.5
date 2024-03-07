Return-Path: <linux-kernel+bounces-94960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB5874744
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06DE284607
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00F14F7F;
	Thu,  7 Mar 2024 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="d7oX/IXX"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA781BF31;
	Thu,  7 Mar 2024 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785187; cv=none; b=uDZwYod9R3s42EteDTIyT0D3e9sQpy+Z4qNQRn3Hap7v607YKX220OxYqcV9qIsUZh91KYk7g/NK5TRGQ7wOysqxBdl06FkMG7kWhVZN2txsUDWGXSdBV8Pnd/D4Fme1x87bPTypbYIELRbyX+NC1QUlEH694mzrpnifnoMuWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785187; c=relaxed/simple;
	bh=x4l4i0okOVJg1fCzJtYVS4AjjsbY5OXvw6bFSr9LBRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rn3jBq/o96pIjJBuRy4HM14r23b9KS3DA2gDcbcKdHdrSJt1KlLl5i4R/k87InZ0CkKdhBo1elKAf2SS6HKyvu5GKqrhCjU2ARaQVakw19DAutk/b3i+FNuiHC4ykwTHdCCrBiEogztdC+1C1RqhooKu8G7I83jlGSNRq1F58j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=d7oX/IXX; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vAXjC
	SRhV4yPC3D/E/SDl/LHTykPxMFdHxEmxQuRiBA=; b=d7oX/IXXKHLdXiGKYkARh
	wOlFXe07FUj+MSu1wxO+sdAdIRw7sxaTCxYQyTgUY5LFfFMm00CrQSCvfrDZ/plC
	ooYnEQQqGH4++6GTc4i4oJPRhz1DlO5Atqfd+vlu/uVcX7jj8Wc2zLlMWD8sSTKE
	dYjmsd616BeHseC2sZGZsA=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wBXrmdmP+llh0IFAA--.11885S7;
	Thu, 07 Mar 2024 12:19:15 +0800 (CST)
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
Subject: [PATCH linux-5.4.y 3/8] loop: Remove sector_t truncation checks
Date: Thu,  7 Mar 2024 12:14:06 +0800
Message-Id: <20240307041411.3792061-4-zhanggenjian@126.com>
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
X-CM-TRANSID:_____wBXrmdmP+llh0IFAA--.11885S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryDKF45WF15XrWxZry7KFg_yoW5Gw43pF
	47uFyfAayFqFWxWFsFqr4kZFy5W3WDW343ury7C34F9r1YqrnYqF13CFyFgrWvqrykZF1Y
	vws8JFy8uF1UGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jGoGdUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHgWafmV2z-5v+AAAsK

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
index eb7b9629f6dd..45237d44a867 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -226,24 +226,20 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
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
@@ -1002,10 +998,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
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
@@ -1326,10 +1320,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
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
@@ -1532,7 +1523,9 @@ static int loop_set_capacity(struct loop_device *lo)
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


