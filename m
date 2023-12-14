Return-Path: <linux-kernel+bounces-185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD4813D36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24ED1C21DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20616721D;
	Thu, 14 Dec 2023 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6P1wIES"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067066AB4;
	Thu, 14 Dec 2023 22:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA425C433C7;
	Thu, 14 Dec 2023 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592524;
	bh=XjcNC16Nyvaxi746s6pMS8kVZJFhhzEmZ1vgtDAy6Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6P1wIESzFs2X6OPnIf12wLEuCncs9d6ybZuorOHrjfMG5XWl5WNoL39lLSMclz81
	 NQLQqDBJh1BgZWDoUk7RcWCTZiomUv2081yfcRHAHJYXM88HF9Uj01y2guH/k8MjxA
	 R4LgRj3mwJCWbuTaT9XNElcRtTVfDIhihJK2SyVh/7tesRpyduG6SPMjI4VMS2gDNL
	 jn6gueKBa2FS4PTO1g+7l3hx8oDX6SeDP+RvMcLYFl3hmMs2u84fTdBK+A/w6GVW9y
	 hz7yQI+DamHOxcW6XSU3x2uTDbLzY+niWqtlvGn6KWUk54T7e5bNsUkpf4hLATkcOK
	 ZDhip303NZM5w==
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
Subject: [PATCH 3/3] md: Remove deprecated CONFIG_MD_FAULTY
Date: Thu, 14 Dec 2023 14:21:07 -0800
Message-Id: <20231214222107.2016042-4-song@kernel.org>
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

md-faulty has been marked as deprecated for 2.5 years. Remove it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Neil Brown <neilb@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: Mateusz Grzonka <mateusz.grzonka@intel.com>
Cc: Jes Sorensen <jes@trained-monkey.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 drivers/md/Kconfig             |  10 -
 drivers/md/Makefile            |   2 -
 drivers/md/md-faulty.c         | 365 ---------------------------------
 include/uapi/linux/raid/md_u.h |   3 -
 4 files changed, 380 deletions(-)
 delete mode 100644 drivers/md/md-faulty.c

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index de4f47fe5a03..f6dc2acdf1ed 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -159,16 +159,6 @@ config MD_RAID456
 
 	  If unsure, say Y.
 
-config MD_FAULTY
-	tristate "Faulty test module for MD (deprecated)"
-	depends on BLK_DEV_MD
-	help
-	  The "faulty" module allows for a block device that occasionally returns
-	  read or write errors.  It is useful for testing.
-
-	  In unsure, say N.
-
-
 config MD_CLUSTER
 	tristate "Cluster Support for MD"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 6287c73399e7..027d7cfeca3f 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -29,7 +29,6 @@ dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
-faulty-y	+= md-faulty.o
 
 # Note: link order is important.  All raid personalities
 # and must come before md.o, as they each initialise
@@ -40,7 +39,6 @@ obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
 obj-$(CONFIG_MD_RAID10)		+= raid10.o
 obj-$(CONFIG_MD_RAID456)	+= raid456.o
-obj-$(CONFIG_MD_FAULTY)		+= faulty.o
 obj-$(CONFIG_MD_CLUSTER)	+= md-cluster.o
 obj-$(CONFIG_BCACHE)		+= bcache/
 obj-$(CONFIG_BLK_DEV_MD)	+= md-mod.o
diff --git a/drivers/md/md-faulty.c b/drivers/md/md-faulty.c
deleted file mode 100644
index a039e8e20f55..000000000000
--- a/drivers/md/md-faulty.c
+++ /dev/null
@@ -1,365 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * faulty.c : Multiple Devices driver for Linux
- *
- * Copyright (C) 2004 Neil Brown
- *
- * fautly-device-simulator personality for md
- */
-
-
-/*
- * The "faulty" personality causes some requests to fail.
- *
- * Possible failure modes are:
- *   reads fail "randomly" but succeed on retry
- *   writes fail "randomly" but succeed on retry
- *   reads for some address fail and then persist until a write
- *   reads for some address fail and then persist irrespective of write
- *   writes for some address fail and persist
- *   all writes fail
- *
- * Different modes can be active at a time, but only
- * one can be set at array creation.  Others can be added later.
- * A mode can be one-shot or recurrent with the recurrence being
- * once in every N requests.
- * The bottom 5 bits of the "layout" indicate the mode.  The
- * remainder indicate a period, or 0 for one-shot.
- *
- * There is an implementation limit on the number of concurrently
- * persisting-faulty blocks. When a new fault is requested that would
- * exceed the limit, it is ignored.
- * All current faults can be clear using a layout of "0".
- *
- * Requests are always sent to the device.  If they are to fail,
- * we clone the bio and insert a new b_end_io into the chain.
- */
-
-#define	WriteTransient	0
-#define	ReadTransient	1
-#define	WritePersistent	2
-#define	ReadPersistent	3
-#define	WriteAll	4 /* doesn't go to device */
-#define	ReadFixable	5
-#define	Modes	6
-
-#define	ClearErrors	31
-#define	ClearFaults	30
-
-#define AllPersist	100 /* internal use only */
-#define	NoPersist	101
-
-#define	ModeMask	0x1f
-#define	ModeShift	5
-
-#define MaxFault	50
-#include <linux/blkdev.h>
-#include <linux/module.h>
-#include <linux/raid/md_u.h>
-#include <linux/slab.h>
-#include "md.h"
-#include <linux/seq_file.h>
-
-
-static void faulty_fail(struct bio *bio)
-{
-	struct bio *b = bio->bi_private;
-
-	b->bi_iter.bi_size = bio->bi_iter.bi_size;
-	b->bi_iter.bi_sector = bio->bi_iter.bi_sector;
-
-	bio_put(bio);
-
-	bio_io_error(b);
-}
-
-struct faulty_conf {
-	int period[Modes];
-	atomic_t counters[Modes];
-	sector_t faults[MaxFault];
-	int	modes[MaxFault];
-	int nfaults;
-	struct md_rdev *rdev;
-};
-
-static int check_mode(struct faulty_conf *conf, int mode)
-{
-	if (conf->period[mode] == 0 &&
-	    atomic_read(&conf->counters[mode]) <= 0)
-		return 0; /* no failure, no decrement */
-
-
-	if (atomic_dec_and_test(&conf->counters[mode])) {
-		if (conf->period[mode])
-			atomic_set(&conf->counters[mode], conf->period[mode]);
-		return 1;
-	}
-	return 0;
-}
-
-static int check_sector(struct faulty_conf *conf, sector_t start, sector_t end, int dir)
-{
-	/* If we find a ReadFixable sector, we fix it ... */
-	int i;
-	for (i=0; i<conf->nfaults; i++)
-		if (conf->faults[i] >= start &&
-		    conf->faults[i] < end) {
-			/* found it ... */
-			switch (conf->modes[i] * 2 + dir) {
-			case WritePersistent*2+WRITE: return 1;
-			case ReadPersistent*2+READ: return 1;
-			case ReadFixable*2+READ: return 1;
-			case ReadFixable*2+WRITE:
-				conf->modes[i] = NoPersist;
-				return 0;
-			case AllPersist*2+READ:
-			case AllPersist*2+WRITE: return 1;
-			default:
-				return 0;
-			}
-		}
-	return 0;
-}
-
-static void add_sector(struct faulty_conf *conf, sector_t start, int mode)
-{
-	int i;
-	int n = conf->nfaults;
-	for (i=0; i<conf->nfaults; i++)
-		if (conf->faults[i] == start) {
-			switch(mode) {
-			case NoPersist: conf->modes[i] = mode; return;
-			case WritePersistent:
-				if (conf->modes[i] == ReadPersistent ||
-				    conf->modes[i] == ReadFixable)
-					conf->modes[i] = AllPersist;
-				else
-					conf->modes[i] = WritePersistent;
-				return;
-			case ReadPersistent:
-				if (conf->modes[i] == WritePersistent)
-					conf->modes[i] = AllPersist;
-				else
-					conf->modes[i] = ReadPersistent;
-				return;
-			case ReadFixable:
-				if (conf->modes[i] == WritePersistent ||
-				    conf->modes[i] == ReadPersistent)
-					conf->modes[i] = AllPersist;
-				else
-					conf->modes[i] = ReadFixable;
-				return;
-			}
-		} else if (conf->modes[i] == NoPersist)
-			n = i;
-
-	if (n >= MaxFault)
-		return;
-	conf->faults[n] = start;
-	conf->modes[n] = mode;
-	if (conf->nfaults == n)
-		conf->nfaults = n+1;
-}
-
-static bool faulty_make_request(struct mddev *mddev, struct bio *bio)
-{
-	struct faulty_conf *conf = mddev->private;
-	int failit = 0;
-
-	if (bio_data_dir(bio) == WRITE) {
-		/* write request */
-		if (atomic_read(&conf->counters[WriteAll])) {
-			/* special case - don't decrement, don't submit_bio_noacct,
-			 * just fail immediately
-			 */
-			bio_io_error(bio);
-			return true;
-		}
-
-		if (check_sector(conf, bio->bi_iter.bi_sector,
-				 bio_end_sector(bio), WRITE))
-			failit = 1;
-		if (check_mode(conf, WritePersistent)) {
-			add_sector(conf, bio->bi_iter.bi_sector,
-				   WritePersistent);
-			failit = 1;
-		}
-		if (check_mode(conf, WriteTransient))
-			failit = 1;
-	} else {
-		/* read request */
-		if (check_sector(conf, bio->bi_iter.bi_sector,
-				 bio_end_sector(bio), READ))
-			failit = 1;
-		if (check_mode(conf, ReadTransient))
-			failit = 1;
-		if (check_mode(conf, ReadPersistent)) {
-			add_sector(conf, bio->bi_iter.bi_sector,
-				   ReadPersistent);
-			failit = 1;
-		}
-		if (check_mode(conf, ReadFixable)) {
-			add_sector(conf, bio->bi_iter.bi_sector,
-				   ReadFixable);
-			failit = 1;
-		}
-	}
-
-	md_account_bio(mddev, &bio);
-	if (failit) {
-		struct bio *b = bio_alloc_clone(conf->rdev->bdev, bio, GFP_NOIO,
-						&mddev->bio_set);
-
-		b->bi_private = bio;
-		b->bi_end_io = faulty_fail;
-		bio = b;
-	} else
-		bio_set_dev(bio, conf->rdev->bdev);
-
-	submit_bio_noacct(bio);
-	return true;
-}
-
-static void faulty_status(struct seq_file *seq, struct mddev *mddev)
-{
-	struct faulty_conf *conf = mddev->private;
-	int n;
-
-	if ((n=atomic_read(&conf->counters[WriteTransient])) != 0)
-		seq_printf(seq, " WriteTransient=%d(%d)",
-			   n, conf->period[WriteTransient]);
-
-	if ((n=atomic_read(&conf->counters[ReadTransient])) != 0)
-		seq_printf(seq, " ReadTransient=%d(%d)",
-			   n, conf->period[ReadTransient]);
-
-	if ((n=atomic_read(&conf->counters[WritePersistent])) != 0)
-		seq_printf(seq, " WritePersistent=%d(%d)",
-			   n, conf->period[WritePersistent]);
-
-	if ((n=atomic_read(&conf->counters[ReadPersistent])) != 0)
-		seq_printf(seq, " ReadPersistent=%d(%d)",
-			   n, conf->period[ReadPersistent]);
-
-
-	if ((n=atomic_read(&conf->counters[ReadFixable])) != 0)
-		seq_printf(seq, " ReadFixable=%d(%d)",
-			   n, conf->period[ReadFixable]);
-
-	if ((n=atomic_read(&conf->counters[WriteAll])) != 0)
-		seq_printf(seq, " WriteAll");
-
-	seq_printf(seq, " nfaults=%d", conf->nfaults);
-}
-
-
-static int faulty_reshape(struct mddev *mddev)
-{
-	int mode = mddev->new_layout & ModeMask;
-	int count = mddev->new_layout >> ModeShift;
-	struct faulty_conf *conf = mddev->private;
-
-	if (mddev->new_layout < 0)
-		return 0;
-
-	/* new layout */
-	if (mode == ClearFaults)
-		conf->nfaults = 0;
-	else if (mode == ClearErrors) {
-		int i;
-		for (i=0 ; i < Modes ; i++) {
-			conf->period[i] = 0;
-			atomic_set(&conf->counters[i], 0);
-		}
-	} else if (mode < Modes) {
-		conf->period[mode] = count;
-		if (!count) count++;
-		atomic_set(&conf->counters[mode], count);
-	} else
-		return -EINVAL;
-	mddev->new_layout = -1;
-	mddev->layout = -1; /* makes sure further changes come through */
-	return 0;
-}
-
-static sector_t faulty_size(struct mddev *mddev, sector_t sectors, int raid_disks)
-{
-	WARN_ONCE(raid_disks,
-		  "%s does not support generic reshape\n", __func__);
-
-	if (sectors == 0)
-		return mddev->dev_sectors;
-
-	return sectors;
-}
-
-static int faulty_run(struct mddev *mddev)
-{
-	struct md_rdev *rdev;
-	int i;
-	struct faulty_conf *conf;
-
-	if (md_check_no_bitmap(mddev))
-		return -EINVAL;
-
-	conf = kmalloc(sizeof(*conf), GFP_KERNEL);
-	if (!conf)
-		return -ENOMEM;
-
-	for (i=0; i<Modes; i++) {
-		atomic_set(&conf->counters[i], 0);
-		conf->period[i] = 0;
-	}
-	conf->nfaults = 0;
-
-	rdev_for_each(rdev, mddev) {
-		conf->rdev = rdev;
-		disk_stack_limits(mddev->gendisk, rdev->bdev,
-				  rdev->data_offset << 9);
-	}
-
-	md_set_array_sectors(mddev, faulty_size(mddev, 0, 0));
-	mddev->private = conf;
-
-	faulty_reshape(mddev);
-
-	return 0;
-}
-
-static void faulty_free(struct mddev *mddev, void *priv)
-{
-	struct faulty_conf *conf = priv;
-
-	kfree(conf);
-}
-
-static struct md_personality faulty_personality =
-{
-	.name		= "faulty",
-	.level		= LEVEL_FAULTY,
-	.owner		= THIS_MODULE,
-	.make_request	= faulty_make_request,
-	.run		= faulty_run,
-	.free		= faulty_free,
-	.status		= faulty_status,
-	.check_reshape	= faulty_reshape,
-	.size		= faulty_size,
-};
-
-static int __init raid_init(void)
-{
-	return register_md_personality(&faulty_personality);
-}
-
-static void raid_exit(void)
-{
-	unregister_md_personality(&faulty_personality);
-}
-
-module_init(raid_init);
-module_exit(raid_exit);
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Fault injection personality for MD (deprecated)");
-MODULE_ALIAS("md-personality-10"); /* faulty */
-MODULE_ALIAS("md-faulty");
-MODULE_ALIAS("md-level--5");
diff --git a/include/uapi/linux/raid/md_u.h b/include/uapi/linux/raid/md_u.h
index b44bbc356643..7be89a4906e7 100644
--- a/include/uapi/linux/raid/md_u.h
+++ b/include/uapi/linux/raid/md_u.h
@@ -103,9 +103,6 @@ typedef struct mdu_array_info_s {
 
 } mdu_array_info_t;
 
-/* non-obvious values for 'level' */
-#define	LEVEL_FAULTY		(-5)
-
 /* we need a value for 'no level specified' and 0
  * means 'raid0', so we need something else.  This is
  * for internal use only
-- 
2.34.1


