Return-Path: <linux-kernel+bounces-2192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D1815929
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7248E2832BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91A24A03;
	Sat, 16 Dec 2023 13:02:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37028219F7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7399e0707so195984239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702731739; x=1703336539;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbR8Fsh2M5lB952Po3IbpA8nnTS73zmHgvg5Bdyi2aQ=;
        b=CDrGao/RUTGaR/g6Sw6zttwmzMtbOn2mj6jK8EMvXcYktO4ZkcFp4DcEEmcNr1hBMj
         HQ3QtrcPhznNkFIYbCibV+8Jdscid3gRdIKuFbAROWHMArumGaQedw8yVUzA8L/tHat4
         9m2N6f+cDg+RO/RQXzeOO4DN4lk2RV8A0YkQgOp/12ULBwKqIb5degNGedYUi3HB2qXS
         DBJyLfF012ql10b4f7Zzsl0rM//UFJHOLpDDhVPJnpvs4HafNmWdi4aV3It5gZObY10b
         zW5cI4DW0bvsIlgFPPjAEZvGHqHWgqjL3xCg6S/e/oapAguZU9bCmfPif5Eo+V8Lvums
         lsrw==
X-Gm-Message-State: AOJu0Yx5qWK2+N8JOC8xvfbCXMeCKTtyXKS8OSpIaAeGoDrQPkpGt/Dp
	Dv4ykVt6chpzi86Wd6Ofouq4vohKWaS+3kMmhKuNS/UDlf4ZpOw=
X-Google-Smtp-Source: AGHT+IG342q/fct2QbJy//JLAQuUEJ6Oz9FyS7Ikz9JhDznLLzQpzv10K88nWUJERm4FCggnsFny2DT/1tcmAbV7SeXf1HhKQIaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:35d:3b19:73b4 with SMTP id
 u4-20020a056e021a4400b0035d3b1973b4mr525407ilv.1.1702731739435; Sat, 16 Dec
 2023 05:02:19 -0800 (PST)
Date: Sat, 16 Dec 2023 05:02:19 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a1cfe060ca020d3@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [block?] INFO: task hung in bdev_release
Author: eadavis@qq.com

please test task hung in bdev_release

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  8c9660f65153

diff --git a/block/bdev.c b/block/bdev.c
index 6f73b02d549c..9fdf2dbc450e 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -130,12 +130,14 @@ static void set_init_blocksize(struct block_device *bdev)
 	unsigned int bsize = bdev_logical_block_size(bdev);
 	loff_t size = i_size_read(bdev->bd_inode);
 
+	printk("s: %llu, %s\n", size, __func__);
 	while (bsize < PAGE_SIZE) {
 		if (size & bsize)
 			break;
 		bsize <<= 1;
 	}
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	printk("out s: %llu, %s\n", size, __func__);
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -870,6 +872,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (ret)
 		goto put_module;
 	bdev_claim_write_access(bdev, mode);
+	printk("%p, h: %p, %s\n", bdev, holder, __func__);
 	if (holder) {
 		bd_finish_claiming(bdev, holder, hops);
 
@@ -887,6 +890,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -900,6 +904,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, %s\n", bdev, __func__);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -964,6 +969,7 @@ void bdev_release(struct bdev_handle *handle)
 	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
+	printk("nxt om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	bdev_yield_write_access(bdev, handle->mode);
 
@@ -982,6 +988,7 @@ void bdev_release(struct bdev_handle *handle)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f47ffcfdfcec..e48c26513f4d 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -698,6 +698,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 
 	if (get_capacity(disk)) {
 		ret = blk_add_partitions(disk);
+		printk("r: %d, disk: %p, %s\n", ret, disk, __func__);
 		if (ret == -EAGAIN)
 			goto rescan;
 	} else if (invalidate) {
@@ -708,6 +709,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 	}
 
+	printk("disk: %p, %s\n", disk, __func__);
 	return ret;
 }
 /*
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b6414e1e645b..090cdef5899d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1137,6 +1137,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	int err;
 
 	/* Arg will be cast to int, check it to avoid overflow */
+	printk("arg: %d, nbd: %p, %s\n", arg, nbd, __func__);
 	if (arg > INT_MAX)
 		return -EINVAL;
 	sock = nbd_get_socket(nbd, arg, &err);
@@ -1188,10 +1189,12 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
 	blk_mq_unfreeze_queue(nbd->disk->queue);
+	printk("arg: %d, nbd: %p, nd: %p, nc: %d, %s\n", arg, nbd, nbd->disk, config->num_connections, __func__);
 
 	return 0;
 
 put_socket:
+	printk("nbd: %p, %s\n", nbd, __func__);
 	blk_mq_unfreeze_queue(nbd->disk->queue);
 	sockfd_put(sock);
 	return err;
@@ -1372,6 +1375,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 	int num_connections = config->num_connections;
 	int error = 0, i;
 
+	printk("dev: %p, nc: %d, pid: %d, socks: %p, %s\n", nbd, num_connections, nbd->pid, config->socks, __func__);
 	if (nbd->pid)
 		return -EBUSY;
 	if (!config->socks)
@@ -1425,6 +1429,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
+	printk("bs: %lld, blks: %lld, %s\n", config->bytesize, nbd_blksize(config), __func__);
 	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
 }
 
@@ -1596,6 +1601,7 @@ static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 	struct nbd_config *config;
 	int ret = 0;
 
+	printk("d: %p, %s\n", disk, __func__);
 	mutex_lock(&nbd_index_mutex);
 	nbd = disk->private_data;
 	if (!nbd) {
@@ -1629,6 +1635,7 @@ static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 			set_bit(GD_NEED_PART_SCAN, &disk->state);
 	}
 out:
+	printk("ret: %d, out, d: %p, %s\n", ret, disk, __func__);
 	mutex_unlock(&nbd_index_mutex);
 	return ret;
 }


