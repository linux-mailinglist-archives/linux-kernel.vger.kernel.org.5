Return-Path: <linux-kernel+bounces-2162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA468158D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8E61C23967
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924818EB4;
	Sat, 16 Dec 2023 11:37:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02488182DA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b711ddbf1aso181682239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702726623; x=1703331423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gyEtGdBsSN0DwBLSJReKnkbCadvTcS+5RKYyywNr94=;
        b=YAuq0Pyhl9hzCb204UWnlYL2Hj+93mXb6EGsz2iD0nO23woGOy4S79/+vQ72mS8v7K
         /I+qVmFdnoGIPxhIXtKdgQceYEPIMon8Q1CykmO7A3rFWEfEQ55KZ/Aem7Fy2Bxnxynj
         eacfnsOdyjUQUGyyuOTuQFRO03FnE0smcYrra6TnMf4PAFGM6zzU8iEPNh6JhD4PP/Dj
         WiKaKDy1V1s7VHnJPjB+T6VU+vwoVKuc/kGTHaiaDESuysjZ2Q8Te/iWNKSXoYLlKSsN
         44jIRtUwC/zxB7/xiZMv2LkzLsxt6X5t1zdM5jvZD7+DJrNOUJTZ1jh+MOUWaKYqsifZ
         Z04Q==
X-Gm-Message-State: AOJu0YzDFcraoIoqQkv3e17WfVUcWyLgw2uqF/nuUlGMtJ85dq7ia5C3
	LmareroLzOysJitGvtcu4Om9ugq2xlO1wNQgZoATwr311Nhk1lQ=
X-Google-Smtp-Source: AGHT+IHZBNn/spSw6t0Cdz8Z8dUQ63m64ZABWcPoHFa4eLxssLLRKabCkpfLA4B5w8tCtdI9rrlPCGdr4T3utxcCj7LRCrIrJLfV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c84:b0:35f:70f3:62cd with SMTP id
 w4-20020a056e021c8400b0035f70f362cdmr403225ill.5.1702726623154; Sat, 16 Dec
 2023 03:37:03 -0800 (PST)
Date: Sat, 16 Dec 2023 03:37:03 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085da1f060c9eefc4@google.com>
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
index 6f73b02d549c..06ce1a73b4d0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -646,11 +646,13 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
 	if (disk->fops->open) {
 		ret = disk->fops->open(disk, mode);
+		printk("r: %d, b: %p, disk: %p, %s\n", ret, bdev, disk, __func__);
 		if (ret) {
 			/* avoid ghost partitions on a removed medium */
 			if (ret == -ENOMEDIUM &&
 			     test_bit(GD_NEED_PART_SCAN, &disk->state))
 				bdev_disk_changed(disk, true);
+			printk("r: %d, b: %p, disk: %p, %s\n", ret, bdev, disk, __func__);
 			return ret;
 		}
 	}
@@ -660,6 +662,7 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
+	printk("out, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	return 0;
 }
 
@@ -863,10 +866,12 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
 		goto abort_claiming;
+	printk("in1, b: %p, disk: %p, h: %p, %s\n", bdev, disk, holder, __func__);
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
 		ret = blkdev_get_whole(bdev, mode);
+	printk("in2, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	if (ret)
 		goto put_module;
 	bdev_claim_write_access(bdev, mode);
@@ -887,6 +892,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -900,6 +906,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, %s\n", bdev, __func__);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -964,6 +971,7 @@ void bdev_release(struct bdev_handle *handle)
 	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
+	printk("nxt om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	bdev_yield_write_access(bdev, handle->mode);
 
@@ -982,6 +990,7 @@ void bdev_release(struct bdev_handle *handle)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
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


