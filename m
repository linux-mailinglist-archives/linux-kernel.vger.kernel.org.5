Return-Path: <linux-kernel+bounces-2122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3DF815825
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298991F257E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ABD154A0;
	Sat, 16 Dec 2023 07:03:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467514A85
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7399e0707so168273539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702710195; x=1703314995;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3cfabcPJeejlhvXrWHA4deKXvxyR9Zy7D4wuW5cirE=;
        b=pARQDsE0zN5R3j3b2CZhW2rl+kv5XIU9SVkSk09drzfchqF7tgwWIccvw80IqlmPId
         UDVsipXPu9pfeGPgReLnNuwLwjzugdSPg92erRyiugjlc1R7baF/YNt6C01XNeWMusJt
         0DydCbRx37V3GXkivLtXB4c49sB8FuzaisvZXDzZal3GXmQcdRa5rONHh18B8qtv/y5H
         z8Ukh/3+b3bEQJSD01XmpkQXXEG+tnVGVCDf+RHcPWuL55Gx7uef17AMhDPJORdtclR+
         1HR8bRWlTOvFEnWgmD4MpbBn2Iir8RdaXYSujDB9ouzdcu7bQSpQxOQOwvG4RN2Ojggo
         yGLQ==
X-Gm-Message-State: AOJu0YxCphIq7LXBPCv4QCRBa9Jb3Cmp60SnMMKm1rYxt00OHHeUjTbK
	AkhobdyVa4Z/a6V/k+uNBcSyOdaGcn0DUEWtQDUgXTrlRxVz39k=
X-Google-Smtp-Source: AGHT+IElZJEWsEXEqFgvzhblMZljbXARsVezJtSpacR0GuwBCH77RbdX+OKY1Dx0H2x/di3KF21yDsFSLnC/XLljQPUaqH8B+Ncy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b0b:b0:469:23f3:badc with SMTP id
 fm11-20020a0566382b0b00b0046923f3badcmr548686jab.4.1702710194897; Fri, 15 Dec
 2023 23:03:14 -0800 (PST)
Date: Fri, 15 Dec 2023 23:03:14 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005289fd060c9b1cb3@google.com>
Subject: Re: [syzbot] Re: [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [block?] INFO: task hung in bdev_release
Author: eadavis@qq.com

please test task hung in bdev_release

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  8c9660f65153

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b6414e1e645b..3cc7993b0b67 100644
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
 
diff --git a/block/bdev.c b/block/bdev.c
index 6f73b02d549c..59a3a23ed281 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -645,6 +645,7 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 	int ret;
 
 	if (disk->fops->open) {
+		printk(" b: %p, disk: %p, %s\n", bdev, disk, __func__);
 		ret = disk->fops->open(disk, mode);
 		if (ret) {
 			/* avoid ghost partitions on a removed medium */
@@ -660,6 +661,7 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
+	printk("out, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	return 0;
 }
 
@@ -854,24 +856,31 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 
 	disk_block_events(disk);
 
+	printk("next om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	ret = -ENXIO;
 	if (!disk_live(disk))
 		goto abort_claiming;
+	printk("in1, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	if (!try_module_get(disk->fops->owner))
 		goto abort_claiming;
+	printk("in2, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
 		goto abort_claiming;
+	printk("in3, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
 		ret = blkdev_get_whole(bdev, mode);
+	printk("in4, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	if (ret)
 		goto put_module;
 	bdev_claim_write_access(bdev, mode);
+	printk("in5, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	if (holder) {
 		bd_finish_claiming(bdev, holder, hops);
+		printk("in6, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 
 		/*
 		 * Block event polling for write claims if requested.  Any write
@@ -887,6 +896,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -900,6 +910,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, %s\n", bdev, __func__);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -964,6 +975,7 @@ void bdev_release(struct bdev_handle *handle)
 	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
+	printk("nxt om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	bdev_yield_write_access(bdev, handle->mode);
 
@@ -982,6 +994,7 @@ void bdev_release(struct bdev_handle *handle)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);


