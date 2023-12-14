Return-Path: <linux-kernel+bounces-184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DA813D33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AD4283611
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6F6720C;
	Thu, 14 Dec 2023 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZtCZvmd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07046720E;
	Thu, 14 Dec 2023 22:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC537C433C9;
	Thu, 14 Dec 2023 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592518;
	bh=D1SWee0qbMAuzH35ZwMpb5p/6OrM/Kgv+zE7T0NAfK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZtCZvmdr3hHYFYqIMQRmMXckjg3cxpMz9WIqioAgPe8v6IeJAFr0kv6X4KfmtRqp
	 3WGxZbrgScKD0w7sF+RW3pgjfmDl1j3DHWKDmjxIKnO4M/E+7wGCj8U8m8R/bFhW54
	 ogOBzA3d1+uDsXJ96FW4kv5DT4ZXyH1s8YGsTIfO1tFL6/lhDEplmOyjEWbzU3Yroz
	 O5g17NsoZElGkjWhwkgIbUlNJx69cj+r8UyJFXIXc7LBhJQ2QQSKlz+UzNAlZGoafm
	 9GOfIxJIWI81Srfr2QjmnOWz0iptd6+oM8KIKTKpScuK7Ek3Bt2IEg5RktQH0oP9j+
	 vkrK70GfkS/KA==
From: Song Liu <song@kernel.org>
To: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Neil Brown <neilb@suse.de>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Mateusz Grzonka <mateusz.grzonka@intel.com>,
	Jes Sorensen <jes@trained-monkey.org>
Subject: [PATCH 2/3] md: Remove deprecated CONFIG_MD_MULTIPATH
Date: Thu, 14 Dec 2023 14:21:06 -0800
Message-Id: <20231214222107.2016042-3-song@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214222107.2016042-1-song@kernel.org>
References: <20231214222107.2016042-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md-multipath has been marked as deprecated for 2.5 years. Remove it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Neil Brown <neilb@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: Mateusz Grzonka <mateusz.grzonka@intel.com>
Cc: Jes Sorensen <jes@trained-monkey.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 drivers/md/Kconfig             |  11 -
 drivers/md/Makefile            |   2 -
 drivers/md/md-multipath.c      | 463 ---------------------------------
 drivers/md/md.c                | 185 ++++++-------
 include/uapi/linux/raid/md_p.h |   2 +-
 include/uapi/linux/raid/md_u.h |   1 -
 6 files changed, 81 insertions(+), 583 deletions(-)
 delete mode 100644 drivers/md/md-multipath.c

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 0c721e0e5921..de4f47fe5a03 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -159,17 +159,6 @@ config MD_RAID456
 
 	  If unsure, say Y.
 
-config MD_MULTIPATH
-	tristate "Multipath I/O support (deprecated)"
-	depends on BLK_DEV_MD
-	help
-	  MD_MULTIPATH provides a simple multi-path personality for use
-	  the MD framework.  It is not under active development.  New
-	  projects should consider using DM_MULTIPATH which has more
-	  features and more testing.
-
-	  If unsure, say N.
-
 config MD_FAULTY
 	tristate "Faulty test module for MD (deprecated)"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index c72f76cf7b63..6287c73399e7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -29,7 +29,6 @@ dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
-multipath-y	+= md-multipath.o
 faulty-y	+= md-faulty.o
 
 # Note: link order is important.  All raid personalities
@@ -41,7 +40,6 @@ obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
 obj-$(CONFIG_MD_RAID10)		+= raid10.o
 obj-$(CONFIG_MD_RAID456)	+= raid456.o
-obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_MD_FAULTY)		+= faulty.o
 obj-$(CONFIG_MD_CLUSTER)	+= md-cluster.o
 obj-$(CONFIG_BCACHE)		+= bcache/
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
deleted file mode 100644
index 19c8625ea642..000000000000
--- a/drivers/md/md-multipath.c
+++ /dev/null
@@ -1,463 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * multipath.c : Multiple Devices driver for Linux
- *
- * Copyright (C) 1999, 2000, 2001 Ingo Molnar, Red Hat
- *
- * Copyright (C) 1996, 1997, 1998 Ingo Molnar, Miguel de Icaza, Gadi Oxman
- *
- * MULTIPATH management functions.
- *
- * derived from raid1.c.
- */
-
-#include <linux/blkdev.h>
-#include <linux/module.h>
-#include <linux/raid/md_u.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include "md.h"
-#include "md-multipath.h"
-
-#define MAX_WORK_PER_DISK 128
-
-#define	NR_RESERVED_BUFS	32
-
-static int multipath_map (struct mpconf *conf)
-{
-	int i, disks = conf->raid_disks;
-
-	/*
-	 * Later we do read balancing on the read side
-	 * now we use the first available disk.
-	 */
-
-	for (i = 0; i < disks; i++) {
-		struct md_rdev *rdev = conf->multipaths[i].rdev;
-
-		if (rdev && test_bit(In_sync, &rdev->flags) &&
-		    !test_bit(Faulty, &rdev->flags)) {
-			atomic_inc(&rdev->nr_pending);
-			return i;
-		}
-	}
-
-	pr_crit_ratelimited("multipath_map(): no more operational IO paths?\n");
-	return (-1);
-}
-
-static void multipath_reschedule_retry (struct multipath_bh *mp_bh)
-{
-	unsigned long flags;
-	struct mddev *mddev = mp_bh->mddev;
-	struct mpconf *conf = mddev->private;
-
-	spin_lock_irqsave(&conf->device_lock, flags);
-	list_add(&mp_bh->retry_list, &conf->retry_list);
-	spin_unlock_irqrestore(&conf->device_lock, flags);
-	md_wakeup_thread(mddev->thread);
-}
-
-/*
- * multipath_end_bh_io() is called when we have finished servicing a multipathed
- * operation and are ready to return a success/failure code to the buffer
- * cache layer.
- */
-static void multipath_end_bh_io(struct multipath_bh *mp_bh, blk_status_t status)
-{
-	struct bio *bio = mp_bh->master_bio;
-	struct mpconf *conf = mp_bh->mddev->private;
-
-	bio->bi_status = status;
-	bio_endio(bio);
-	mempool_free(mp_bh, &conf->pool);
-}
-
-static void multipath_end_request(struct bio *bio)
-{
-	struct multipath_bh *mp_bh = bio->bi_private;
-	struct mpconf *conf = mp_bh->mddev->private;
-	struct md_rdev *rdev = conf->multipaths[mp_bh->path].rdev;
-
-	if (!bio->bi_status)
-		multipath_end_bh_io(mp_bh, 0);
-	else if (!(bio->bi_opf & REQ_RAHEAD)) {
-		/*
-		 * oops, IO error:
-		 */
-		md_error (mp_bh->mddev, rdev);
-		pr_info("multipath: %pg: rescheduling sector %llu\n",
-			rdev->bdev,
-			(unsigned long long)bio->bi_iter.bi_sector);
-		multipath_reschedule_retry(mp_bh);
-	} else
-		multipath_end_bh_io(mp_bh, bio->bi_status);
-	rdev_dec_pending(rdev, conf->mddev);
-}
-
-static bool multipath_make_request(struct mddev *mddev, struct bio * bio)
-{
-	struct mpconf *conf = mddev->private;
-	struct multipath_bh * mp_bh;
-	struct multipath_info *multipath;
-
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
-	    && md_flush_request(mddev, bio))
-		return true;
-
-	md_account_bio(mddev, &bio);
-	mp_bh = mempool_alloc(&conf->pool, GFP_NOIO);
-
-	mp_bh->master_bio = bio;
-	mp_bh->mddev = mddev;
-
-	mp_bh->path = multipath_map(conf);
-	if (mp_bh->path < 0) {
-		bio_io_error(bio);
-		mempool_free(mp_bh, &conf->pool);
-		return true;
-	}
-	multipath = conf->multipaths + mp_bh->path;
-
-	bio_init_clone(multipath->rdev->bdev, &mp_bh->bio, bio, GFP_NOIO);
-
-	mp_bh->bio.bi_iter.bi_sector += multipath->rdev->data_offset;
-	mp_bh->bio.bi_opf |= REQ_FAILFAST_TRANSPORT;
-	mp_bh->bio.bi_end_io = multipath_end_request;
-	mp_bh->bio.bi_private = mp_bh;
-	mddev_check_write_zeroes(mddev, &mp_bh->bio);
-	submit_bio_noacct(&mp_bh->bio);
-	return true;
-}
-
-static void multipath_status(struct seq_file *seq, struct mddev *mddev)
-{
-	struct mpconf *conf = mddev->private;
-	int i;
-
-	lockdep_assert_held(&mddev->lock);
-
-	seq_printf (seq, " [%d/%d] [", conf->raid_disks,
-		    conf->raid_disks - mddev->degraded);
-	for (i = 0; i < conf->raid_disks; i++) {
-		struct md_rdev *rdev = READ_ONCE(conf->multipaths[i].rdev);
-
-		seq_printf(seq, "%s",
-			   rdev && test_bit(In_sync, &rdev->flags) ? "U" : "_");
-	}
-	seq_putc(seq, ']');
-}
-
-/*
- * Careful, this can execute in IRQ contexts as well!
- */
-static void multipath_error (struct mddev *mddev, struct md_rdev *rdev)
-{
-	struct mpconf *conf = mddev->private;
-
-	if (conf->raid_disks - mddev->degraded <= 1) {
-		/*
-		 * Uh oh, we can do nothing if this is our last path, but
-		 * first check if this is a queued request for a device
-		 * which has just failed.
-		 */
-		pr_warn("multipath: only one IO path left and IO error.\n");
-		/* leave it active... it's all we have */
-		return;
-	}
-	/*
-	 * Mark disk as unusable
-	 */
-	if (test_and_clear_bit(In_sync, &rdev->flags)) {
-		unsigned long flags;
-		spin_lock_irqsave(&conf->device_lock, flags);
-		mddev->degraded++;
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-	}
-	set_bit(Faulty, &rdev->flags);
-	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-	pr_err("multipath: IO failure on %pg, disabling IO path.\n"
-	       "multipath: Operation continuing on %d IO paths.\n",
-	       rdev->bdev,
-	       conf->raid_disks - mddev->degraded);
-}
-
-static void print_multipath_conf(struct mpconf *conf)
-{
-	int i;
-	struct multipath_info *tmp;
-
-	pr_debug("MULTIPATH conf printout:\n");
-	if (!conf) {
-		pr_debug("(conf==NULL)\n");
-		return;
-	}
-	pr_debug(" --- wd:%d rd:%d\n", conf->raid_disks - conf->mddev->degraded,
-		 conf->raid_disks);
-
-	lockdep_assert_held(&conf->mddev->reconfig_mutex);
-	for (i = 0; i < conf->raid_disks; i++) {
-		tmp = conf->multipaths + i;
-		if (tmp->rdev)
-			pr_debug(" disk%d, o:%d, dev:%pg\n",
-				 i,!test_bit(Faulty, &tmp->rdev->flags),
-				 tmp->rdev->bdev);
-	}
-}
-
-static int multipath_add_disk(struct mddev *mddev, struct md_rdev *rdev)
-{
-	struct mpconf *conf = mddev->private;
-	int err = -EEXIST;
-	int path;
-	struct multipath_info *p;
-	int first = 0;
-	int last = mddev->raid_disks - 1;
-
-	if (rdev->raid_disk >= 0)
-		first = last = rdev->raid_disk;
-
-	print_multipath_conf(conf);
-
-	for (path = first; path <= last; path++)
-		if ((p=conf->multipaths+path)->rdev == NULL) {
-			disk_stack_limits(mddev->gendisk, rdev->bdev,
-					  rdev->data_offset << 9);
-
-			err = md_integrity_add_rdev(rdev, mddev);
-			if (err)
-				break;
-			spin_lock_irq(&conf->device_lock);
-			mddev->degraded--;
-			rdev->raid_disk = path;
-			set_bit(In_sync, &rdev->flags);
-			spin_unlock_irq(&conf->device_lock);
-			WRITE_ONCE(p->rdev, rdev);
-			err = 0;
-			break;
-		}
-
-	print_multipath_conf(conf);
-
-	return err;
-}
-
-static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
-{
-	struct mpconf *conf = mddev->private;
-	int err = 0;
-	int number = rdev->raid_disk;
-	struct multipath_info *p = conf->multipaths + number;
-
-	print_multipath_conf(conf);
-
-	if (rdev == p->rdev) {
-		if (test_bit(In_sync, &rdev->flags) ||
-		    atomic_read(&rdev->nr_pending)) {
-			pr_warn("hot-remove-disk, slot %d is identified but is still operational!\n", number);
-			err = -EBUSY;
-			goto abort;
-		}
-		WRITE_ONCE(p->rdev, NULL);
-		err = md_integrity_register(mddev);
-	}
-abort:
-
-	print_multipath_conf(conf);
-	return err;
-}
-
-/*
- * This is a kernel thread which:
- *
- *	1.	Retries failed read operations on working multipaths.
- *	2.	Updates the raid superblock when problems encounter.
- *	3.	Performs writes following reads for array syncronising.
- */
-
-static void multipathd(struct md_thread *thread)
-{
-	struct mddev *mddev = thread->mddev;
-	struct multipath_bh *mp_bh;
-	struct bio *bio;
-	unsigned long flags;
-	struct mpconf *conf = mddev->private;
-	struct list_head *head = &conf->retry_list;
-
-	md_check_recovery(mddev);
-	for (;;) {
-		spin_lock_irqsave(&conf->device_lock, flags);
-		if (list_empty(head))
-			break;
-		mp_bh = list_entry(head->prev, struct multipath_bh, retry_list);
-		list_del(head->prev);
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-
-		bio = &mp_bh->bio;
-		bio->bi_iter.bi_sector = mp_bh->master_bio->bi_iter.bi_sector;
-
-		if ((mp_bh->path = multipath_map (conf))<0) {
-			pr_err("multipath: %pg: unrecoverable IO read error for block %llu\n",
-			       bio->bi_bdev,
-			       (unsigned long long)bio->bi_iter.bi_sector);
-			multipath_end_bh_io(mp_bh, BLK_STS_IOERR);
-		} else {
-			pr_err("multipath: %pg: redirecting sector %llu to another IO path\n",
-			       bio->bi_bdev,
-			       (unsigned long long)bio->bi_iter.bi_sector);
-			*bio = *(mp_bh->master_bio);
-			bio->bi_iter.bi_sector +=
-				conf->multipaths[mp_bh->path].rdev->data_offset;
-			bio_set_dev(bio, conf->multipaths[mp_bh->path].rdev->bdev);
-			bio->bi_opf |= REQ_FAILFAST_TRANSPORT;
-			bio->bi_end_io = multipath_end_request;
-			bio->bi_private = mp_bh;
-			submit_bio_noacct(bio);
-		}
-	}
-	spin_unlock_irqrestore(&conf->device_lock, flags);
-}
-
-static sector_t multipath_size(struct mddev *mddev, sector_t sectors, int raid_disks)
-{
-	WARN_ONCE(sectors || raid_disks,
-		  "%s does not support generic reshape\n", __func__);
-
-	return mddev->dev_sectors;
-}
-
-static int multipath_run (struct mddev *mddev)
-{
-	struct mpconf *conf;
-	int disk_idx;
-	struct multipath_info *disk;
-	struct md_rdev *rdev;
-	int working_disks;
-	int ret;
-
-	if (md_check_no_bitmap(mddev))
-		return -EINVAL;
-
-	if (mddev->level != LEVEL_MULTIPATH) {
-		pr_warn("multipath: %s: raid level not set to multipath IO (%d)\n",
-			mdname(mddev), mddev->level);
-		goto out;
-	}
-	/*
-	 * copy the already verified devices into our private MULTIPATH
-	 * bookkeeping area. [whatever we allocate in multipath_run(),
-	 * should be freed in multipath_free()]
-	 */
-
-	conf = kzalloc(sizeof(struct mpconf), GFP_KERNEL);
-	mddev->private = conf;
-	if (!conf)
-		goto out;
-
-	conf->multipaths = kcalloc(mddev->raid_disks,
-				   sizeof(struct multipath_info),
-				   GFP_KERNEL);
-	if (!conf->multipaths)
-		goto out_free_conf;
-
-	working_disks = 0;
-	rdev_for_each(rdev, mddev) {
-		disk_idx = rdev->raid_disk;
-		if (disk_idx < 0 ||
-		    disk_idx >= mddev->raid_disks)
-			continue;
-
-		disk = conf->multipaths + disk_idx;
-		disk->rdev = rdev;
-		disk_stack_limits(mddev->gendisk, rdev->bdev,
-				  rdev->data_offset << 9);
-
-		if (!test_bit(Faulty, &rdev->flags))
-			working_disks++;
-	}
-
-	conf->raid_disks = mddev->raid_disks;
-	conf->mddev = mddev;
-	spin_lock_init(&conf->device_lock);
-	INIT_LIST_HEAD(&conf->retry_list);
-
-	if (!working_disks) {
-		pr_warn("multipath: no operational IO paths for %s\n",
-			mdname(mddev));
-		goto out_free_conf;
-	}
-	mddev->degraded = conf->raid_disks - working_disks;
-
-	ret = mempool_init_kmalloc_pool(&conf->pool, NR_RESERVED_BUFS,
-					sizeof(struct multipath_bh));
-	if (ret)
-		goto out_free_conf;
-
-	rcu_assign_pointer(mddev->thread,
-			   md_register_thread(multipathd, mddev, "multipath"));
-	if (!mddev->thread)
-		goto out_free_conf;
-
-	pr_info("multipath: array %s active with %d out of %d IO paths\n",
-		mdname(mddev), conf->raid_disks - mddev->degraded,
-		mddev->raid_disks);
-	/*
-	 * Ok, everything is just fine now
-	 */
-	md_set_array_sectors(mddev, multipath_size(mddev, 0, 0));
-
-	if (md_integrity_register(mddev))
-		goto out_free_conf;
-
-	return 0;
-
-out_free_conf:
-	mempool_exit(&conf->pool);
-	kfree(conf->multipaths);
-	kfree(conf);
-	mddev->private = NULL;
-out:
-	return -EIO;
-}
-
-static void multipath_free(struct mddev *mddev, void *priv)
-{
-	struct mpconf *conf = priv;
-
-	mempool_exit(&conf->pool);
-	kfree(conf->multipaths);
-	kfree(conf);
-}
-
-static struct md_personality multipath_personality =
-{
-	.name		= "multipath",
-	.level		= LEVEL_MULTIPATH,
-	.owner		= THIS_MODULE,
-	.make_request	= multipath_make_request,
-	.run		= multipath_run,
-	.free		= multipath_free,
-	.status		= multipath_status,
-	.error_handler	= multipath_error,
-	.hot_add_disk	= multipath_add_disk,
-	.hot_remove_disk= multipath_remove_disk,
-	.size		= multipath_size,
-};
-
-static int __init multipath_init (void)
-{
-	return register_md_personality (&multipath_personality);
-}
-
-static void __exit multipath_exit (void)
-{
-	unregister_md_personality (&multipath_personality);
-}
-
-module_init(multipath_init);
-module_exit(multipath_exit);
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("simple multi-path personality for MD (deprecated)");
-MODULE_ALIAS("md-personality-7"); /* MULTIPATH */
-MODULE_ALIAS("md-multipath");
-MODULE_ALIAS("md-level--4");
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8649b63cd93b..7b5e6dd67dab 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1286,17 +1286,11 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 	rdev->sb_size = MD_SB_BYTES;
 	rdev->badblocks.shift = -1;
 
-	if (sb->level == LEVEL_MULTIPATH)
-		rdev->desc_nr = -1;
-	else
-		rdev->desc_nr = sb->this_disk.number;
-
-	/* not spare disk, or LEVEL_MULTIPATH */
-	if (sb->level == LEVEL_MULTIPATH ||
-		(rdev->desc_nr >= 0 &&
-		 rdev->desc_nr < MD_SB_DISKS &&
-		 sb->disks[rdev->desc_nr].state &
-		 ((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE))))
+	rdev->desc_nr = sb->this_disk.number;
+
+	/* not spare disk */
+	if (rdev->desc_nr >= 0 && rdev->desc_nr < MD_SB_DISKS &&
+	    sb->disks[rdev->desc_nr].state & ((1<<MD_DISK_SYNC) | (1 << MD_DISK_ACTIVE)))
 		spare_disk = false;
 
 	if (!refdev) {
@@ -1442,31 +1436,28 @@ static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
 			return 0;
 	}
 
-	if (mddev->level != LEVEL_MULTIPATH) {
-		desc = sb->disks + rdev->desc_nr;
+	desc = sb->disks + rdev->desc_nr;
 
-		if (desc->state & (1<<MD_DISK_FAULTY))
-			set_bit(Faulty, &rdev->flags);
-		else if (desc->state & (1<<MD_DISK_SYNC) /* &&
-			    desc->raid_disk < mddev->raid_disks */) {
-			set_bit(In_sync, &rdev->flags);
+	if (desc->state & (1<<MD_DISK_FAULTY))
+		set_bit(Faulty, &rdev->flags);
+	else if (desc->state & (1<<MD_DISK_SYNC)) {
+		set_bit(In_sync, &rdev->flags);
+		rdev->raid_disk = desc->raid_disk;
+		rdev->saved_raid_disk = desc->raid_disk;
+	} else if (desc->state & (1<<MD_DISK_ACTIVE)) {
+		/* active but not in sync implies recovery up to
+		 * reshape position.  We don't know exactly where
+		 * that is, so set to zero for now
+		 */
+		if (mddev->minor_version >= 91) {
+			rdev->recovery_offset = 0;
 			rdev->raid_disk = desc->raid_disk;
-			rdev->saved_raid_disk = desc->raid_disk;
-		} else if (desc->state & (1<<MD_DISK_ACTIVE)) {
-			/* active but not in sync implies recovery up to
-			 * reshape position.  We don't know exactly where
-			 * that is, so set to zero for now */
-			if (mddev->minor_version >= 91) {
-				rdev->recovery_offset = 0;
-				rdev->raid_disk = desc->raid_disk;
-			}
 		}
-		if (desc->state & (1<<MD_DISK_WRITEMOSTLY))
-			set_bit(WriteMostly, &rdev->flags);
-		if (desc->state & (1<<MD_DISK_FAILFAST))
-			set_bit(FailFast, &rdev->flags);
-	} else /* MULTIPATH are always insync */
-		set_bit(In_sync, &rdev->flags);
+	}
+	if (desc->state & (1<<MD_DISK_WRITEMOSTLY))
+		set_bit(WriteMostly, &rdev->flags);
+	if (desc->state & (1<<MD_DISK_FAILFAST))
+		set_bit(FailFast, &rdev->flags);
 	return 0;
 }
 
@@ -1756,10 +1747,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	    && rdev->new_data_offset < sb_start + (rdev->sb_size/512))
 		return -EINVAL;
 
-	if (sb->level == cpu_to_le32(LEVEL_MULTIPATH))
-		rdev->desc_nr = -1;
-	else
-		rdev->desc_nr = le32_to_cpu(sb->dev_number);
+	rdev->desc_nr = le32_to_cpu(sb->dev_number);
 
 	if (!rdev->bb_page) {
 		rdev->bb_page = alloc_page(GFP_KERNEL);
@@ -1812,12 +1800,10 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	    sb->level != 0)
 		return -EINVAL;
 
-	/* not spare disk, or LEVEL_MULTIPATH */
-	if (sb->level == cpu_to_le32(LEVEL_MULTIPATH) ||
-		(rdev->desc_nr >= 0 &&
-		rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
-		(le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
-		 le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL)))
+	/* not spare disk */
+	if (rdev->desc_nr >= 0 && rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
+	    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
+	     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
 		spare_disk = false;
 
 	if (!refdev) {
@@ -1860,6 +1846,7 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	__u64 ev1 = le64_to_cpu(sb->events);
+	int role;
 
 	rdev->raid_disk = -1;
 	clear_bit(Faulty, &rdev->flags);
@@ -1973,58 +1960,55 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 			/* just a hot-add of a new device, leave raid_disk at -1 */
 			return 0;
 	}
-	if (mddev->level != LEVEL_MULTIPATH) {
-		int role;
-		if (rdev->desc_nr < 0 ||
-		    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
-			role = MD_DISK_ROLE_SPARE;
-			rdev->desc_nr = -1;
-		} else
-			role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
-		switch(role) {
-		case MD_DISK_ROLE_SPARE: /* spare */
-			break;
-		case MD_DISK_ROLE_FAULTY: /* faulty */
-			set_bit(Faulty, &rdev->flags);
-			break;
-		case MD_DISK_ROLE_JOURNAL: /* journal device */
-			if (!(le32_to_cpu(sb->feature_map) & MD_FEATURE_JOURNAL)) {
-				/* journal device without journal feature */
-				pr_warn("md: journal device provided without journal feature, ignoring the device\n");
-				return -EINVAL;
-			}
-			set_bit(Journal, &rdev->flags);
-			rdev->journal_tail = le64_to_cpu(sb->journal_tail);
-			rdev->raid_disk = 0;
-			break;
-		default:
-			rdev->saved_raid_disk = role;
-			if ((le32_to_cpu(sb->feature_map) &
-			     MD_FEATURE_RECOVERY_OFFSET)) {
-				rdev->recovery_offset = le64_to_cpu(sb->recovery_offset);
-				if (!(le32_to_cpu(sb->feature_map) &
-				      MD_FEATURE_RECOVERY_BITMAP))
-					rdev->saved_raid_disk = -1;
-			} else {
-				/*
-				 * If the array is FROZEN, then the device can't
-				 * be in_sync with rest of array.
-				 */
-				if (!test_bit(MD_RECOVERY_FROZEN,
-					      &mddev->recovery))
-					set_bit(In_sync, &rdev->flags);
-			}
-			rdev->raid_disk = role;
-			break;
+
+	if (rdev->desc_nr < 0 ||
+	    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
+		role = MD_DISK_ROLE_SPARE;
+		rdev->desc_nr = -1;
+	} else
+		role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+	switch (role) {
+	case MD_DISK_ROLE_SPARE: /* spare */
+		break;
+	case MD_DISK_ROLE_FAULTY: /* faulty */
+		set_bit(Faulty, &rdev->flags);
+		break;
+	case MD_DISK_ROLE_JOURNAL: /* journal device */
+		if (!(le32_to_cpu(sb->feature_map) & MD_FEATURE_JOURNAL)) {
+			/* journal device without journal feature */
+			pr_warn("md: journal device provided without journal feature, ignoring the device\n");
+			return -EINVAL;
 		}
-		if (sb->devflags & WriteMostly1)
-			set_bit(WriteMostly, &rdev->flags);
-		if (sb->devflags & FailFast1)
-			set_bit(FailFast, &rdev->flags);
-		if (le32_to_cpu(sb->feature_map) & MD_FEATURE_REPLACEMENT)
-			set_bit(Replacement, &rdev->flags);
-	} else /* MULTIPATH are always insync */
-		set_bit(In_sync, &rdev->flags);
+		set_bit(Journal, &rdev->flags);
+		rdev->journal_tail = le64_to_cpu(sb->journal_tail);
+		rdev->raid_disk = 0;
+		break;
+	default:
+		rdev->saved_raid_disk = role;
+		if ((le32_to_cpu(sb->feature_map) &
+		     MD_FEATURE_RECOVERY_OFFSET)) {
+			rdev->recovery_offset = le64_to_cpu(sb->recovery_offset);
+			if (!(le32_to_cpu(sb->feature_map) &
+			      MD_FEATURE_RECOVERY_BITMAP))
+				rdev->saved_raid_disk = -1;
+		} else {
+			/*
+			 * If the array is FROZEN, then the device can't
+			 * be in_sync with rest of array.
+			 */
+			if (!test_bit(MD_RECOVERY_FROZEN,
+				      &mddev->recovery))
+				set_bit(In_sync, &rdev->flags);
+		}
+		rdev->raid_disk = role;
+		break;
+	}
+	if (sb->devflags & WriteMostly1)
+		set_bit(WriteMostly, &rdev->flags);
+	if (sb->devflags & FailFast1)
+		set_bit(FailFast, &rdev->flags);
+	if (le32_to_cpu(sb->feature_map) & MD_FEATURE_REPLACEMENT)
+		set_bit(Replacement, &rdev->flags);
 
 	return 0;
 }
@@ -2842,10 +2826,6 @@ void md_update_sb(struct mddev *mddev, int force_change)
 		} else
 			pr_debug("md: %pg (skipping faulty)\n",
 				 rdev->bdev);
-
-		if (mddev->level == LEVEL_MULTIPATH)
-			/* only need to write one superblock... */
-			break;
 	}
 	if (md_super_wait(mddev) < 0)
 		goto rewrite;
@@ -3846,13 +3826,8 @@ static int analyze_sbs(struct mddev *mddev)
 				continue;
 			}
 		}
-		if (mddev->level == LEVEL_MULTIPATH) {
-			rdev->desc_nr = i++;
-			rdev->raid_disk = rdev->desc_nr;
-			set_bit(In_sync, &rdev->flags);
-		} else if (rdev->raid_disk >=
-			    (mddev->raid_disks - min(0, mddev->delta_disks)) &&
-			   !test_bit(Journal, &rdev->flags)) {
+		if (rdev->raid_disk >= (mddev->raid_disks - min(0, mddev->delta_disks)) &&
+		    !test_bit(Journal, &rdev->flags)) {
 			rdev->raid_disk = -1;
 			clear_bit(In_sync, &rdev->flags);
 		}
diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md_p.h
index b36e282a413d..5a43c23f53bf 100644
--- a/include/uapi/linux/raid/md_p.h
+++ b/include/uapi/linux/raid/md_p.h
@@ -233,7 +233,7 @@ struct mdp_superblock_1 {
 	char	set_name[32];	/* set and interpreted by user-space */
 
 	__le64	ctime;		/* lo 40 bits are seconds, top 24 are microseconds or 0*/
-	__le32	level;		/* -4 (multipath), 0,1,4,5 */
+	__le32	level;		/* 0,1,4,5 */
 	__le32	layout;		/* only for raid5 and raid10 currently */
 	__le64	size;		/* used size of component devices, in 512byte sectors */
 
diff --git a/include/uapi/linux/raid/md_u.h b/include/uapi/linux/raid/md_u.h
index c285f76e5d8d..b44bbc356643 100644
--- a/include/uapi/linux/raid/md_u.h
+++ b/include/uapi/linux/raid/md_u.h
@@ -104,7 +104,6 @@ typedef struct mdu_array_info_s {
 } mdu_array_info_t;
 
 /* non-obvious values for 'level' */
-#define	LEVEL_MULTIPATH		(-4)
 #define	LEVEL_FAULTY		(-5)
 
 /* we need a value for 'no level specified' and 0
-- 
2.34.1


