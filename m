Return-Path: <linux-kernel+bounces-2172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7E58158EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146F1B23665
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A12C86C;
	Sat, 16 Dec 2023 12:15:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640132C69C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35d678edc08so9798585ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702728929; x=1703333729;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/yRYGCxDzTqPaFNvTXeWdlJq4pAUSXK8PLFOG8kyb8=;
        b=LZ3clESYFKj+4uN9xZouPbSNOBuO9junhtd0ItHijHDGkQc/ahrOwqvhaLmxdZOPnC
         vsXmCEqn8YqPt+GSehk9CIbW4NGRLuQi1lQ3O2ULvKv6BFK3T53pJovB5T6Besr6oYI2
         zQ4XrU5jJz8j2oOu/LCfvk/UkpxxYxMc2Ec1ECEuZ/bjqmCXUOln4z+jspl5g4G28eiE
         s/RRPnupJS63FiYg2wqJQbptGod6+203cV+9/7r1DEObouWOxF1QAliQW3sRyda1OJ3u
         qOYZxuTevGm2F8wjNG62IYTtltJqJolWh6Ch9tDqaHgtBaT6PGCcHk+GSD2eobBLnten
         Dc4g==
X-Gm-Message-State: AOJu0YyR9GgJZds/7ux4oF0dN9AnKnNbrpeWEf6Js5HvFR6uAVoynMPy
	MdBz9WyKXPGkH1u0cr1gQFmAkigZSme4yN6xpnpX5LPkdmWGws4=
X-Google-Smtp-Source: AGHT+IGzbfyCRHpKJ0XINz/6BAYUXJheTxdjUqUtNuG8Tv0/Q+8Meu7QBvTN78wca87Gz1JJgqQK3vhddlj9wV5627tGaKTh/GEK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c10a:0:b0:35f:959d:1ad6 with SMTP id
 p10-20020a92c10a000000b0035f959d1ad6mr243006ile.2.1702728929625; Sat, 16 Dec
 2023 04:15:29 -0800 (PST)
Date: Sat, 16 Dec 2023 04:15:29 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffd091060c9f7859@google.com>
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
index 6f73b02d549c..05abc096518f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -887,6 +887,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, disk: %p, %s\n", bdev, disk, __func__);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -900,6 +901,7 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, %s\n", bdev, __func__);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -964,6 +966,7 @@ void bdev_release(struct bdev_handle *handle)
 	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
+	printk("nxt om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	bdev_yield_write_access(bdev, handle->mode);
 
@@ -982,6 +985,7 @@ void bdev_release(struct bdev_handle *handle)
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


