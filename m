Return-Path: <linux-kernel+bounces-183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D4813D30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03ED3B21AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734AF2C69C;
	Thu, 14 Dec 2023 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW9zR8+q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12067201;
	Thu, 14 Dec 2023 22:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6845AC433C8;
	Thu, 14 Dec 2023 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592512;
	bh=W7QZ4zmlVx0ro/U1ubNET7AZJpyzX7worml57y6t+go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW9zR8+qVR7SGcazGJo/uV2tf37Q4j5KW9yObmrKjF7gzHs9g1qeYmCd6gBSDG89g
	 H1YS9RotVI2BClV+Ih2kyKOA+/FXFDj8gExZrzOJe/BPwyJ+a8X+3aMa7t5fIfZZpp
	 qDOJjP10v7n7On/nMcZ7uVfASwdI0dFRcf7qSM1VPScTyOp85TWCp3Xcf7QQfDMkLj
	 J9J58qIc3nKNzJWFFxNHvgSq4RpowAitTG198xPN7T8//cj0iF0WAvoKk7fOXIMNz6
	 JcA2rVgv9HAIb41vQHcRS4RHfjD+CA5+jFWm+Q6oFs+9BDpd3hTG8fFMnr91KpDigU
	 LevjDVSgsnNxg==
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
Subject: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
Date: Thu, 14 Dec 2023 14:21:05 -0800
Message-Id: <20231214222107.2016042-2-song@kernel.org>
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

md-linear has been marked as deprecated for 2.5 years. Remove it.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Neil Brown <neilb@suse.de>
Cc: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: Mateusz Grzonka <mateusz.grzonka@intel.com>
Cc: Jes Sorensen <jes@trained-monkey.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 drivers/md/Kconfig             |  13 --
 drivers/md/Makefile            |   6 +-
 drivers/md/md-autodetect.c     |   8 +-
 drivers/md/md-linear.c         | 318 ---------------------------------
 drivers/md/md.c                |   2 +-
 include/uapi/linux/raid/md_p.h |   8 +-
 include/uapi/linux/raid/md_u.h |   7 +-
 7 files changed, 8 insertions(+), 354 deletions(-)
 delete mode 100644 drivers/md/md-linear.c

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 2a8b081bce7d..0c721e0e5921 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -61,19 +61,6 @@ config MD_BITMAP_FILE
 	  various kernel APIs and can only work with files on a file system not
 	  actually sitting on the MD device.
 
-config MD_LINEAR
-	tristate "Linear (append) mode (deprecated)"
-	depends on BLK_DEV_MD
-	help
-	  If you say Y here, then your multiple devices driver will be able to
-	  use the so-called linear mode, i.e. it will combine the hard disk
-	  partitions by simply appending one to the other.
-
-	  To compile this as a module, choose M here: the module
-	  will be called linear.
-
-	  If unsure, say Y.
-
 config MD_RAID0
 	tristate "RAID-0 (striping) mode"
 	depends on BLK_DEV_MD
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 84291e38dca8..c72f76cf7b63 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -29,16 +29,14 @@ dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
-linear-y	+= md-linear.o
 multipath-y	+= md-multipath.o
 faulty-y	+= md-faulty.o
 
 # Note: link order is important.  All raid personalities
-# and must come before md.o, as they each initialise 
-# themselves, and md.o may use the personalities when it 
+# and must come before md.o, as they each initialise
+# themselves, and md.o may use the personalities when it
 # auto-initialised.
 
-obj-$(CONFIG_MD_LINEAR)		+= linear.o
 obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
 obj-$(CONFIG_MD_RAID10)		+= raid10.o
diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 4b80165afd23..b2a00f213c2c 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -49,7 +49,6 @@ static int md_setup_ents __initdata;
  *             instead of just one.  -- KTK
  * 18May2000: Added support for persistent-superblock arrays:
  *             md=n,0,factor,fault,device-list   uses RAID0 for device n
- *             md=n,-1,factor,fault,device-list  uses LINEAR for device n
  *             md=n,device-list      reads a RAID superblock from the devices
  *             elements in device-list are read by name_to_kdev_t so can be
  *             a hex number or something like /dev/hda1 /dev/sdb
@@ -88,7 +87,7 @@ static int __init md_setup(char *str)
 		md_setup_ents++;
 	switch (get_option(&str, &level)) {	/* RAID level */
 	case 2: /* could be 0 or -1.. */
-		if (level == 0 || level == LEVEL_LINEAR) {
+		if (level == 0) {
 			if (get_option(&str, &factor) != 2 ||	/* Chunk Size */
 					get_option(&str, &fault) != 2) {
 				printk(KERN_WARNING "md: Too few arguments supplied to md=.\n");
@@ -96,10 +95,7 @@ static int __init md_setup(char *str)
 			}
 			md_setup_args[ent].level = level;
 			md_setup_args[ent].chunk = 1 << (factor+12);
-			if (level ==  LEVEL_LINEAR)
-				pername = "linear";
-			else
-				pername = "raid0";
+			pername = "raid0";
 			break;
 		}
 		fallthrough;
diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
deleted file mode 100644
index 8eca7693b793..000000000000
--- a/drivers/md/md-linear.c
+++ /dev/null
@@ -1,318 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
-   linear.c : Multiple Devices driver for Linux
-	      Copyright (C) 1994-96 Marc ZYNGIER
-	      <zyngier@ufr-info-p7.ibp.fr> or
-	      <maz@gloups.fdn.fr>
-
-   Linear mode management functions.
-
-*/
-
-#include <linux/blkdev.h>
-#include <linux/raid/md_u.h>
-#include <linux/seq_file.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <trace/events/block.h>
-#include "md.h"
-#include "md-linear.h"
-
-/*
- * find which device holds a particular offset
- */
-static inline struct dev_info *which_dev(struct mddev *mddev, sector_t sector)
-{
-	int lo, mid, hi;
-	struct linear_conf *conf;
-
-	lo = 0;
-	hi = mddev->raid_disks - 1;
-	conf = mddev->private;
-
-	/*
-	 * Binary Search
-	 */
-
-	while (hi > lo) {
-
-		mid = (hi + lo) / 2;
-		if (sector < conf->disks[mid].end_sector)
-			hi = mid;
-		else
-			lo = mid + 1;
-	}
-
-	return conf->disks + lo;
-}
-
-static sector_t linear_size(struct mddev *mddev, sector_t sectors, int raid_disks)
-{
-	struct linear_conf *conf;
-	sector_t array_sectors;
-
-	conf = mddev->private;
-	WARN_ONCE(sectors || raid_disks,
-		  "%s does not support generic reshape\n", __func__);
-	array_sectors = conf->array_sectors;
-
-	return array_sectors;
-}
-
-static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
-{
-	struct linear_conf *conf;
-	struct md_rdev *rdev;
-	int i, cnt;
-
-	conf = kzalloc(struct_size(conf, disks, raid_disks), GFP_KERNEL);
-	if (!conf)
-		return NULL;
-
-	/*
-	 * conf->raid_disks is copy of mddev->raid_disks. The reason to
-	 * keep a copy of mddev->raid_disks in struct linear_conf is,
-	 * mddev->raid_disks may not be consistent with pointers number of
-	 * conf->disks[] when it is updated in linear_add() and used to
-	 * iterate old conf->disks[] earray in linear_congested().
-	 * Here conf->raid_disks is always consitent with number of
-	 * pointers in conf->disks[] array, and mddev->private is updated
-	 * with rcu_assign_pointer() in linear_addr(), such race can be
-	 * avoided.
-	 */
-	conf->raid_disks = raid_disks;
-
-	cnt = 0;
-	conf->array_sectors = 0;
-
-	rdev_for_each(rdev, mddev) {
-		int j = rdev->raid_disk;
-		struct dev_info *disk = conf->disks + j;
-		sector_t sectors;
-
-		if (j < 0 || j >= raid_disks || disk->rdev) {
-			pr_warn("md/linear:%s: disk numbering problem. Aborting!\n",
-				mdname(mddev));
-			goto out;
-		}
-
-		disk->rdev = rdev;
-		if (mddev->chunk_sectors) {
-			sectors = rdev->sectors;
-			sector_div(sectors, mddev->chunk_sectors);
-			rdev->sectors = sectors * mddev->chunk_sectors;
-		}
-
-		disk_stack_limits(mddev->gendisk, rdev->bdev,
-				  rdev->data_offset << 9);
-
-		conf->array_sectors += rdev->sectors;
-		cnt++;
-	}
-	if (cnt != raid_disks) {
-		pr_warn("md/linear:%s: not enough drives present. Aborting!\n",
-			mdname(mddev));
-		goto out;
-	}
-
-	/*
-	 * Here we calculate the device offsets.
-	 */
-	conf->disks[0].end_sector = conf->disks[0].rdev->sectors;
-
-	for (i = 1; i < raid_disks; i++)
-		conf->disks[i].end_sector =
-			conf->disks[i-1].end_sector +
-			conf->disks[i].rdev->sectors;
-
-	return conf;
-
-out:
-	kfree(conf);
-	return NULL;
-}
-
-static int linear_run (struct mddev *mddev)
-{
-	struct linear_conf *conf;
-	int ret;
-
-	if (md_check_no_bitmap(mddev))
-		return -EINVAL;
-	conf = linear_conf(mddev, mddev->raid_disks);
-
-	if (!conf)
-		return 1;
-	mddev->private = conf;
-	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
-
-	ret =  md_integrity_register(mddev);
-	if (ret) {
-		kfree(conf);
-		mddev->private = NULL;
-	}
-	return ret;
-}
-
-static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
-{
-	/* Adding a drive to a linear array allows the array to grow.
-	 * It is permitted if the new drive has a matching superblock
-	 * already on it, with raid_disk equal to raid_disks.
-	 * It is achieved by creating a new linear_private_data structure
-	 * and swapping it in in-place of the current one.
-	 * The current one is never freed until the array is stopped.
-	 * This avoids races.
-	 */
-	struct linear_conf *newconf, *oldconf;
-
-	if (rdev->saved_raid_disk != mddev->raid_disks)
-		return -EINVAL;
-
-	rdev->raid_disk = rdev->saved_raid_disk;
-	rdev->saved_raid_disk = -1;
-
-	newconf = linear_conf(mddev,mddev->raid_disks+1);
-
-	if (!newconf)
-		return -ENOMEM;
-
-	/* newconf->raid_disks already keeps a copy of * the increased
-	 * value of mddev->raid_disks, WARN_ONCE() is just used to make
-	 * sure of this. It is possible that oldconf is still referenced
-	 * in linear_congested(), therefore kfree_rcu() is used to free
-	 * oldconf until no one uses it anymore.
-	 */
-	oldconf = rcu_dereference_protected(mddev->private,
-			lockdep_is_held(&mddev->reconfig_mutex));
-	mddev->raid_disks++;
-	WARN_ONCE(mddev->raid_disks != newconf->raid_disks,
-		"copied raid_disks doesn't match mddev->raid_disks");
-	rcu_assign_pointer(mddev->private, newconf);
-	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
-	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
-	kfree_rcu(oldconf, rcu);
-	return 0;
-}
-
-static void linear_free(struct mddev *mddev, void *priv)
-{
-	struct linear_conf *conf = priv;
-
-	kfree(conf);
-}
-
-static bool linear_make_request(struct mddev *mddev, struct bio *bio)
-{
-	struct dev_info *tmp_dev;
-	sector_t start_sector, end_sector, data_offset;
-	sector_t bio_sector = bio->bi_iter.bi_sector;
-
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
-	    && md_flush_request(mddev, bio))
-		return true;
-
-	tmp_dev = which_dev(mddev, bio_sector);
-	start_sector = tmp_dev->end_sector - tmp_dev->rdev->sectors;
-	end_sector = tmp_dev->end_sector;
-	data_offset = tmp_dev->rdev->data_offset;
-
-	if (unlikely(bio_sector >= end_sector ||
-		     bio_sector < start_sector))
-		goto out_of_bounds;
-
-	if (unlikely(is_rdev_broken(tmp_dev->rdev))) {
-		md_error(mddev, tmp_dev->rdev);
-		bio_io_error(bio);
-		return true;
-	}
-
-	if (unlikely(bio_end_sector(bio) > end_sector)) {
-		/* This bio crosses a device boundary, so we have to split it */
-		struct bio *split = bio_split(bio, end_sector - bio_sector,
-					      GFP_NOIO, &mddev->bio_set);
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
-	}
-
-	md_account_bio(mddev, &bio);
-	bio_set_dev(bio, tmp_dev->rdev->bdev);
-	bio->bi_iter.bi_sector = bio->bi_iter.bi_sector -
-		start_sector + data_offset;
-
-	if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
-		     !bdev_max_discard_sectors(bio->bi_bdev))) {
-		/* Just ignore it */
-		bio_endio(bio);
-	} else {
-		if (mddev->gendisk)
-			trace_block_bio_remap(bio, disk_devt(mddev->gendisk),
-					      bio_sector);
-		mddev_check_write_zeroes(mddev, bio);
-		submit_bio_noacct(bio);
-	}
-	return true;
-
-out_of_bounds:
-	pr_err("md/linear:%s: make_request: Sector %llu out of bounds on dev %pg: %llu sectors, offset %llu\n",
-	       mdname(mddev),
-	       (unsigned long long)bio->bi_iter.bi_sector,
-	       tmp_dev->rdev->bdev,
-	       (unsigned long long)tmp_dev->rdev->sectors,
-	       (unsigned long long)start_sector);
-	bio_io_error(bio);
-	return true;
-}
-
-static void linear_status (struct seq_file *seq, struct mddev *mddev)
-{
-	seq_printf(seq, " %dk rounding", mddev->chunk_sectors / 2);
-}
-
-static void linear_error(struct mddev *mddev, struct md_rdev *rdev)
-{
-	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
-		char *md_name = mdname(mddev);
-
-		pr_crit("md/linear%s: Disk failure on %pg detected, failing array.\n",
-			md_name, rdev->bdev);
-	}
-}
-
-static void linear_quiesce(struct mddev *mddev, int state)
-{
-}
-
-static struct md_personality linear_personality =
-{
-	.name		= "linear",
-	.level		= LEVEL_LINEAR,
-	.owner		= THIS_MODULE,
-	.make_request	= linear_make_request,
-	.run		= linear_run,
-	.free		= linear_free,
-	.status		= linear_status,
-	.hot_add_disk	= linear_add,
-	.size		= linear_size,
-	.quiesce	= linear_quiesce,
-	.error_handler	= linear_error,
-};
-
-static int __init linear_init (void)
-{
-	return register_md_personality (&linear_personality);
-}
-
-static void linear_exit (void)
-{
-	unregister_md_personality (&linear_personality);
-}
-
-module_init(linear_init);
-module_exit(linear_exit);
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Linear device concatenation personality for MD (deprecated)");
-MODULE_ALIAS("md-personality-1"); /* LINEAR - deprecated*/
-MODULE_ALIAS("md-linear");
-MODULE_ALIAS("md-level--1");
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e9fe5cbeedc..8649b63cd93b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8090,7 +8090,7 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 		return;
 	mddev->pers->error_handler(mddev, rdev);
 
-	if (mddev->pers->level == 0 || mddev->pers->level == LEVEL_LINEAR)
+	if (mddev->pers->level == 0)
 		return;
 
 	if (mddev->degraded && !test_bit(MD_BROKEN, &mddev->flags))
diff --git a/include/uapi/linux/raid/md_p.h b/include/uapi/linux/raid/md_p.h
index 6c0aa577730f..b36e282a413d 100644
--- a/include/uapi/linux/raid/md_p.h
+++ b/include/uapi/linux/raid/md_p.h
@@ -2,15 +2,11 @@
 /*
    md_p.h : physical layout of Linux RAID devices
           Copyright (C) 1996-98 Ingo Molnar, Gadi Oxman
-	  
+
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2, or (at your option)
    any later version.
-   
-   You should have received a copy of the GNU General Public License
-   (for example /usr/src/linux/COPYING); if not, write to the Free
-   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  
 */
 
 #ifndef _MD_P_H
@@ -237,7 +233,7 @@ struct mdp_superblock_1 {
 	char	set_name[32];	/* set and interpreted by user-space */
 
 	__le64	ctime;		/* lo 40 bits are seconds, top 24 are microseconds or 0*/
-	__le32	level;		/* -4 (multipath), -1 (linear), 0,1,4,5 */
+	__le32	level;		/* -4 (multipath), 0,1,4,5 */
 	__le32	layout;		/* only for raid5 and raid10 currently */
 	__le64	size;		/* used size of component devices, in 512byte sectors */
 
diff --git a/include/uapi/linux/raid/md_u.h b/include/uapi/linux/raid/md_u.h
index 105307244961..c285f76e5d8d 100644
--- a/include/uapi/linux/raid/md_u.h
+++ b/include/uapi/linux/raid/md_u.h
@@ -2,15 +2,11 @@
 /*
    md_u.h : user <=> kernel API between Linux raidtools and RAID drivers
           Copyright (C) 1998 Ingo Molnar
-	  
+
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2, or (at your option)
    any later version.
-   
-   You should have received a copy of the GNU General Public License
-   (for example /usr/src/linux/COPYING); if not, write to the Free
-   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  
 */
 
 #ifndef _UAPI_MD_U_H
@@ -109,7 +105,6 @@ typedef struct mdu_array_info_s {
 
 /* non-obvious values for 'level' */
 #define	LEVEL_MULTIPATH		(-4)
-#define	LEVEL_LINEAR		(-1)
 #define	LEVEL_FAULTY		(-5)
 
 /* we need a value for 'no level specified' and 0
-- 
2.34.1


