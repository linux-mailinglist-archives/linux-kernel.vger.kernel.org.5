Return-Path: <linux-kernel+bounces-2445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E0815D48
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146CA1F221F4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151310F2;
	Sun, 17 Dec 2023 03:11:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A6A28
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7a9f90f04so318470139f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702782665; x=1703387465;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s37Cy1fFIvBRjvTOQ/1nkR0toDXimNAuJWXDRInIdTE=;
        b=X1g/a/XBkMnb3FekZZ4I1dUZMh+14O/bYKaBmt1W6B+24uj0931cS1CERRxixv+Nwx
         f+wa7PrCfVkR9cqoY2jSnWP7yvfdaEQ1V9dR0zOmeo9lBSsGCpHcpASA2Sk0ZEn+awb2
         5acJc/a79iNTtc4FfSXdEien2jclGIwoG9gridz3TF3ri9GO2fukhRq22q9WBas39dkV
         3WuG5WaUm+TM8ZDbvfbmBmk+KHm4mzhLIX1QGVNrgDdM/4G1hy9OULJAAe1G32IXFFlC
         TWm89blcxODQc56v9NkLGP9ZP0MoVOVnfWFabhOlPZf3Z+brksAbGhtgqii7FkKDtsnT
         BQpQ==
X-Gm-Message-State: AOJu0YzYipN1lqBoltCd5+yHnREE6ER1rwoP3HJ7Pe/IsupmczoMy3lc
	l5I+gtTZkTKP8SSo98me0ZvPUFF3eTQP+lLXusm7XsIBXbPA3c4=
X-Google-Smtp-Source: AGHT+IEvKFeFzE33nIa2ec4MnSyeZexg6tMucGCdOtPzqCCYESysCatTyPnQOH1t1kvfkVLpvKqzswk4zc1J7URoDd2nTDnxcHcZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:62a1:b0:466:5e39:7098 with SMTP id
 fh33-20020a05663862a100b004665e397098mr782169jab.5.1702782665706; Sat, 16 Dec
 2023 19:11:05 -0800 (PST)
Date: Sat, 16 Dec 2023 19:11:05 -0800
In-Reply-To: <000000000000098af2060b5ff161@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb5971060cabfb37@google.com>
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
index 6f73b02d549c..95be32bc8dea 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -938,6 +938,7 @@ struct bdev_handle *bdev_open_by_path(const char *path, blk_mode_t mode,
 	if (error)
 		return ERR_PTR(error);
 
+	printk("dev: %u, path: %s, holder: %p, %s\n", dev, path, holder, __func__);
 	handle = bdev_open_by_dev(dev, mode, holder, hops);
 	if (!IS_ERR(handle) && (mode & BLK_OPEN_WRITE) &&
 	    bdev_read_only(handle->bdev)) {
@@ -964,6 +965,7 @@ void bdev_release(struct bdev_handle *handle)
 	if (atomic_read(&bdev->bd_openers) == 1)
 		sync_blockdev(bdev);
 
+	printk("nxt om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 	mutex_lock(&disk->open_mutex);
 	bdev_yield_write_access(bdev, handle->mode);
 
@@ -982,6 +984,7 @@ void bdev_release(struct bdev_handle *handle)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	printk("out om, b: %p, dk: %p, %s\n", bdev, disk, __func__);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
@@ -1092,7 +1095,8 @@ void sync_bdevs(bool wait)
 		old_inode = inode;
 		bdev = I_BDEV(inode);
 
-		mutex_lock(&bdev->bd_disk->open_mutex);
+		printk("in, b: %p, dk: %p, %s\n", bdev, bdev->bd_disk, __func__);
+		mutex_lock(&bdev->bd_disk->sync_mutex);
 		if (!atomic_read(&bdev->bd_openers)) {
 			; /* skip */
 		} else if (wait) {
@@ -1106,7 +1110,8 @@ void sync_bdevs(bool wait)
 		} else {
 			filemap_fdatawrite(inode->i_mapping);
 		}
-		mutex_unlock(&bdev->bd_disk->open_mutex);
+		mutex_unlock(&bdev->bd_disk->sync_mutex);
+		printk("out, b: %p, dk: %p, %s\n", bdev, bdev->bd_disk, __func__);
 
 		spin_lock(&blockdev_superblock->s_inode_list_lock);
 	}
diff --git a/block/genhd.c b/block/genhd.c
index 13db3a7943d8..da44d4739915 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1355,6 +1355,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 
 	disk->node_id = node_id;
 	mutex_init(&disk->open_mutex);
+	mutex_init(&disk->sync_mutex);
 	xa_init(&disk->part_tbl);
 	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
 		goto out_destroy_part_tbl;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b6414e1e645b..c302df0caebf 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -475,10 +475,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 		 */
 		struct nbd_sock *nsock = config->socks[cmd->index];
 		cmd->retries++;
-		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",
+		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds, nbd: %p, d: %p\n",
 			req, nbdcmd_to_ascii(req_to_nbd_cmd_type(req)),
 			(unsigned long long)blk_rq_pos(req) << 9,
-			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries);
+			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries,
+			nbd, nbd->disk);
 
 		mutex_lock(&nsock->tx_lock);
 		if (cmd->cookie != nsock->cookie) {
@@ -1425,6 +1426,7 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args->index = i;
 		queue_work(nbd->recv_workq, &args->work);
 	}
+	printk("bs: %lld, blks: %lld, %s\n", config->bytesize, nbd_blksize(config), __func__);
 	return nbd_set_size(nbd, config->bytesize, nbd_blksize(config));
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3f8a21cd9233..31c6a7d6a74c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -161,6 +161,7 @@ struct gendisk {
 #define GD_OWNS_QUEUE			6
 
 	struct mutex open_mutex;	/* open/close mutex */
+	struct mutex sync_mutex;	/* sync mutex */
 	unsigned open_partitions;	/* number of open partitions */
 
 	struct backing_dev_info	*bdi;


