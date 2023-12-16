Return-Path: <linux-kernel+bounces-2039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EE81573E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CE61F25912
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AED10A12;
	Sat, 16 Dec 2023 04:17:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437D1095F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b3d54a346dso156105739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702700273; x=1703305073;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMrgEcEX0GmYTq86igCnRTgrjwBUPAcjBGPBvHKtqA0=;
        b=Rxn00dKOiGekoEMteGM9C+ybbrVLdXxQCXroWVSs1VzaiEMrx+EIz6N2QaCRUbrDHg
         4DO+XVQoqQk4/OJWgEQmbTJLQluvJKsAzSgOIy9m2244gjh2S69bih/0HzIZRF+bqXNo
         YELkqd6g1PBDsApuCxZL3ka/81UKIeLBJEKTv9frSRERDo3i1eOKomaVXMzgFSJDEylz
         geWK65AyQ+FOhhWeAOzZtu1w6w7tcapCR3Q1Lk3km5nxUVif0shcqlR9C/ozO9di+bce
         auEdCjQBV+mCNUcLY2nUr4DAP0BSaLYwB72rJWCha5SEzKUJxkeBwcDSY3w8/3m/p0/Y
         zXKw==
X-Gm-Message-State: AOJu0YyCnHeUZU3ImHjkwy1+rMx7Jm24HOtouUzfZDpaoH2Ta9jIFS1y
	ulIil/yXQkkRVLm+EwGajpYujHoS2B2Yy2rgwMB3Df+h5D6eZTE=
X-Google-Smtp-Source: AGHT+IGQkaKtvP7GDXD6pMFWKB/uabE7/bNbstnRC6XZZl5ELZFe+ITArTCtXHeSqEGpoPSJM/+kBvKHFAWZ2BTy9kWTqVoO1yTp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2056:b0:45c:34a5:6d09 with SMTP id
 t22-20020a056638205600b0045c34a56d09mr492829jaj.2.1702700273378; Fri, 15 Dec
 2023 20:17:53 -0800 (PST)
Date: Fri, 15 Dec 2023 20:17:53 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f42f25060c98cc96@google.com>
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
index 6f73b02d549c..17ead61b00e2 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -854,6 +854,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 
 	disk_block_events(disk);
 
+	printk("next om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	ret = -ENXIO;
 	if (!disk_live(disk))
@@ -887,6 +888,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -900,6 +902,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, %s\n", bdev, __func__);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -964,6 +967,7 @@ void bdev_release(struct bdev_handle *handle)
 	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
+	printk("nxt om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	bdev_yield_write_access(bdev, handle->mode);
 
@@ -982,6 +986,7 @@ void bdev_release(struct bdev_handle *handle)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
diff --git a/block/ioctl.c b/block/ioctl.c
index 9c73a763ef88..67825e6bec13 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -483,6 +483,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
+	printk("s: %d, b: %p, bd: %p, %s\n", n, bdev, bdev->bd_dev, __func__);
 	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
 	if (IS_ERR(handle))
 		return -EBUSY;
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
 


