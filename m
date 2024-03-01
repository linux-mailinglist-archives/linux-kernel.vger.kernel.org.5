Return-Path: <linux-kernel+bounces-87774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784FD86D8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC481C210FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08A39AE8;
	Fri,  1 Mar 2024 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YrvIPpMC"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271CB38F84;
	Fri,  1 Mar 2024 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256789; cv=none; b=FtwhFgzOa0ZOEzKtN9dh5JRZN4sZQERC0engnlKpP2M5KUrq9ak0dEQHlNX9arlAAY+n4HYPorHjPeyxaJMfTQW9HW1c8EtewcVJB8RYbOkPgGmRW3c/aCcZU+eDoo3EVtJyWHWsysWianKs3sw/FwLBcpOKPn3JhpCqvR+7z2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256789; c=relaxed/simple;
	bh=JjZ7W3t4/yI9ATJXoIRSdNMeNL4PQtI7LA+8bo2tGz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIW5YympEiy4WxVbh88V3XjjWM97kYPEUKsNxswFBoaRVolMUfxLrRvEtbs2T4ZGoDcnsS6T5It8wAXHlGj+k/Ia4JMmJVEoHd/1ZauNx1AAhSotHwyq7WyUAZxc105Uq0gabaE1gilDDFscRQto/lLJjbzW6wiAY9o4+Y01kVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YrvIPpMC; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k22cU
	pbPjJDJz3jqCUUmugzbccutXgTxXfhtlbr5D/8=; b=YrvIPpMC8oi+gEuig4XaK
	/qIVNyKK/o+OkA43Cg9FWq6xJ5QbdgPGsRLLPjrOF2EyDEFGndXpB5BGk4cU8myQ
	PaCDddbU201LAll9nzWsN3W45wOTNmQgV9t1PjEGksTBySt3JT/T8mhH1k6lmahJ
	5AjEaN22uR0FpsJUQjWmkM=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S9;
	Fri, 01 Mar 2024 09:32:40 +0800 (CST)
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
Subject: [PATCH 4.19.y 5/9] loop: Refactor loop_set_status() size calculation
Date: Fri,  1 Mar 2024 09:30:24 +0800
Message-Id: <20240301013028.2293831-6-zhanggenjian@126.com>
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
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rWw13XryDAr43GrWUCFg_yoWrXw1kpF
	nFga4Yy3yFqFW8WFsFqr4kuFW5G3WDC3y3Ary7J34jyr1jqr9aqrW2kryrW397Jr95ZayY
	qan8tr1kuw1Uur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdUUbUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyBqUfmWWf0mcQwABsj

From: Martijn Coenen <maco@android.com>

[ Upstream commit b0bd158dd630bd47640e0e418c062cda1e0da5ad ]

figure_loop_size() calculates the loop size based on the passed in
parameters, but at the same time it updates the offset and sizelimit
parameters in the loop device configuration. That is a somewhat
unexpected side effect of a function with this name, and it is only only
needed by one of the two callers of this function - loop_set_status().

Move the lo_offset and lo_sizelimit assignment back into loop_set_status(),
and use the newly factored out functions to validate and apply the newly
calculated size. This allows us to get rid of figure_loop_size() in a
follow-up commit.

Signed-off-by: Martijn Coenen <maco@android.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6bd07fa3a1fc..1a6805642ed2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -248,11 +248,6 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
 
-	if (lo->lo_offset != offset)
-		lo->lo_offset = offset;
-	if (lo->lo_sizelimit != sizelimit)
-		lo->lo_sizelimit = sizelimit;
-
 	loop_set_size(lo, size);
 }
 
@@ -1225,6 +1220,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool size_changed = false;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1246,6 +1242,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		size_changed = true;
 		sync_blockdev(lo->lo_device);
 		invalidate_bdev(lo->lo_device);
 	}
@@ -1253,6 +1250,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
+		/* If any pages were dirtied after invalidate_bdev(), try again */
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
 	err = loop_release_xfer(lo);
 	if (err)
 		goto out_unfreeze;
@@ -1276,19 +1282,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (err)
 		goto out_unfreeze;
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
-		figure_loop_size(lo, info->lo_offset, info->lo_sizelimit);
-	}
-
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1312,6 +1307,12 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	if (size_changed) {
+		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
+					   lo->lo_backing_file);
+		loop_set_size(lo, new_size);
+	}
+
 	loop_config_discard(lo);
 
 	/* update dio if lo_offset or transfer is changed */
-- 
2.25.1


