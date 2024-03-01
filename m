Return-Path: <linux-kernel+bounces-87772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B186D8D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C38281E96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEB376FE;
	Fri,  1 Mar 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="CnUngRMp"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D7A2B9D2;
	Fri,  1 Mar 2024 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256781; cv=none; b=vAF1h151rCPm6DNSEwyvjZa9AF9LbsOMN2wbPXuiO24Ew/hapaLKHNXfdQGx3sOAdCsaQar4wJqNzdt9zdOLdYTp8a2hvAMidKIu91qpo3WPu5ZbiWvt7TcqKNedvZDyLSsWwTv3ytNOq6mIDiIft4GRM+8HZ/lsfHGhfoexR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256781; c=relaxed/simple;
	bh=QWpCBUxGIwvUgnTYWNJI8geGzf6bM31MwNgicX8H3Zc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFajZJ6+4Vpza2xUXRgOCno+eSBaKpGJtbJKBeCFSg3mYdIE2gl8w3NL5qOTYRLBpVvZURI4zWo22bCiqqYU8DnFsyh/L19amaa3D/Du7TZxevfp4lH345ufINhAou1WytQd0FgVkM5L6lYI7/sinsVZFWxi0dyzsgimESrFmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=CnUngRMp; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=ybwauVZPrNHMvNzZYCxzA4shFMPOKAQSqwZ1heSYrjU=;
	b=CnUngRMpGh+j3GepSLK+vF3aysVSq5oYs+HgeSufvpOIV7gIxxANFX97/HvIHd
	MU9/56k8CxDoczsl5z6x1vTh96jgk/4lSNCJMRRq7nv7dl2dp8O7TjtfWWbIzJfH
	6PchkI/z8agj6V4LZJxAVhFYlZNFJpFhHwUAbZHBJwn+Y=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDn7+APMOFlZSfbBA--.18054S10;
	Fri, 01 Mar 2024 09:32:41 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	stable@kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanggenjian123@gmail.com,
	=?UTF-8?q?Holger=20Hoffst=C3=A4tte?= <holger.hoffstaette@googlemail.com>,
	holger@applied-asynchrony.com,
	Gwendal Grignou <gwendal@chromium.org>,
	Benjamin Gordon <bmgordon@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 6/9] loop: properly observe rotational flag of underlying device
Date: Fri,  1 Mar 2024 09:30:25 +0800
Message-Id: <20240301013028.2293831-7-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301013028.2293831-1-zhanggenjian@126.com>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7+APMOFlZSfbBA--.18054S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryUKFy8Xr4UWr4rZr4fKrg_yoW5XryDpF
	W3JFy0kay8KFWxWF4Iqa17ZFyak3Wvk343W3srCwn09w13Jr9aqa4fJFyUXFW8trZ5GF4Y
	qFWYgFyvkr4UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHCJQUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHhmUfmV2z7wVDwACsV

From: Holger Hoffstätte <holger.hoffstaette@googlemail.com>

[ Upstream commit 56a85fd8376ef32458efb6ea97a820754e12f6bb ]

The loop driver always declares the rotational flag of its device as
rotational, even when the device of the mapped file is nonrotational,
as is the case with SSDs or on tmpfs. This can confuse filesystem tools
which are SSD-aware; in my case I frequently forget to tell mkfs.btrfs
that my loop device on tmpfs is nonrotational, and that I really don't
need any automatic metadata redundancy.

The attached patch fixes this by introspecting the rotational flag of the
mapped file's underlying block device, if it exists. If the mapped file's
filesystem has no associated block device - as is the case on e.g. tmpfs -
we assume nonrotational storage. If there is a better way to identify such
non-devices I'd love to hear them.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: holger@applied-asynchrony.com
Signed-off-by: Holger Hoffstätte <holger.hoffstaette@googlemail.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Benjamin Gordon <bmgordon@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
---
 drivers/block/loop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1a6805642ed2..7a0461a6160b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -940,6 +940,24 @@ static int loop_prepare_queue(struct loop_device *lo)
 	return 0;
 }
 
+static void loop_update_rotational(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *file_inode = file->f_mapping->host;
+	struct block_device *file_bdev = file_inode->i_sb->s_bdev;
+	struct request_queue *q = lo->lo_queue;
+	bool nonrot = true;
+
+	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
+	if (file_bdev)
+		nonrot = blk_queue_nonrot(bdev_get_queue(file_bdev));
+
+	if (nonrot)
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
+}
+
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
@@ -1001,6 +1019,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
 		blk_queue_write_cache(lo->lo_queue, true, false);
 
+	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
 	loop_set_size(lo, size);
-- 
2.25.1


