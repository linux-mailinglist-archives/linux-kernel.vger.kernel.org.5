Return-Path: <linux-kernel+bounces-46657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FAD844256
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADAA1F2C95A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8A913BE92;
	Wed, 31 Jan 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JjHJsjHP"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6912DDA9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712644; cv=none; b=pm+VBNAiIwjFKaTU/mc6eBcJm/MTNvn39ezn5oJOjiifXHUtCdhOtsRofwFG0DDSbPzLLzO5YOX05gNzg17XeaWdut/6dQw81BiI3vp0rqhmNu418Yc+jN5ofxffKm/o73JF2nCIb/rJ8lkTuWg4nc5vAG+4/zXEPeZ01+PwHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712644; c=relaxed/simple;
	bh=OTygjA4/zqkMcLzy2Gg1jeWwMSho3aV5rkAj1T8ZylY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3jk//ScK0trzcYcNjF6bDRXansT4+IvT9j0AP8GcjptpZP1Dd0Cd0IKVb5085IQX1QO0g0Fx4zlcn1RBFX8HTfRIwPWVaDGJLdMslK7wJpTkfX4n8bsE1xWAdgNWR/Y5591gi4jAytLQlQ/jeuNpRN3U2ukPY2wt84oLKGmYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JjHJsjHP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394b892691so569425f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712634; x=1707317434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9Sp8tnqEoSGzZNzvEoFRhxoKeB+4kRZaokZMRP2FF0=;
        b=JjHJsjHPmJjxL//SdjrTq4U7sMSg4b9GUqLEsUMZkluWksNmZyuUvf7mdYDjbj2iRt
         fwuONTFkAIuQjixO7XuMx6ifz0Z7DUe0q2bRk3P1OjSdpI2a44bTdvobN9jfl7WIOp9O
         WlBuXCTmOhBN2MVBI4hnRxtfxsHWKx4StLPCLTGg6/YNPjx4E76IxV069w2665JE/Efr
         WaLlDSacgmu33XVt4/FcJGkzmUVilmMNgL/XEFMk+9S4F5xltF3pp3kQNHCIBJo1W//M
         f77RBfO61TYswV7ek5fXrEb6klWj7Bk09lDvFVOjqv+bAxSX3OW63u59WJX0sNpj+Zyn
         nUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712634; x=1707317434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9Sp8tnqEoSGzZNzvEoFRhxoKeB+4kRZaokZMRP2FF0=;
        b=FcGZ/i/zxksbWTHid2gyIMMDqBsq7Zf7llAXyhpsCbJYT2eafRINQ6rqmVwN/hp1+v
         3Hp9OVcXWxL01jrFgWZs32Lna3jd2v0BO8Pa36Ku4/+6IOrbDZv1UH9CM2b1sXtrDfmX
         Vz8/9XuFcpRwYkFZwq/zBgw22/ZqMYyNMyd6y7cy0wlCpynNWOaj/eKv9IV+09yJrYje
         7jbL8uNpvS45X5eaCVj3QogRuiBCPz4tao169P8aJ1qDQ7Iya0wmem13DvEcmoyhtCdi
         Krqqv3SDbsjdr9kEP6IoLxX6zKPlPz/CoTZiEk84sU/a/vvpcvsRlV4HBP8eqkBx8TNK
         T2Sg==
X-Gm-Message-State: AOJu0YyLHqWuzqbfziEQkJ804C4YHk4iTRo2/HqnAj1PB3JP1d3q3AMi
	vbrUgHfakYfHC+tcUd9+MLZLUFkKMjlIWhf7h6/3jUEhg8l9GKFKSMfSJWMqWpx39cvW8PxAU5V
	L
X-Google-Smtp-Source: AGHT+IEj4AhL9N7EmyXN+NwJ00B4eIrx0fUqbj9uGrytpLE8/rWa9LIKnuYECcbew5Ef0dJuFmFBpg==
X-Received: by 2002:a5d:64c3:0:b0:337:aa92:74cb with SMTP id f3-20020a5d64c3000000b00337aa9274cbmr2434534wri.0.1706712634193;
        Wed, 31 Jan 2024 06:50:34 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:33 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 22/28] blkdev.h: move declarations to blkdev_types.h
Date: Wed, 31 Jan 2024 15:50:02 +0100
Message-Id: <20240131145008.1345531-23-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/blkdev.h         | 444 +------------------------------
 include/linux/blkdev_types.h   | 461 +++++++++++++++++++++++++++++++++
 include/linux/cdrom.h          |   2 +-
 include/linux/io_uring_types.h |   2 +-
 io_uring/io_uring.c            |   1 +
 5 files changed, 465 insertions(+), 445 deletions(-)
 create mode 100644 include/linux/blkdev_types.h

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc108e5fcec0..c8b172c92004 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -5,11 +5,9 @@
 #ifndef _LINUX_BLKDEV_H
 #define _LINUX_BLKDEV_H
 
-#include <linux/types.h>
+#include <linux/blkdev_types.h>
 #include <linux/fs.h> // for inode_unhashed()
 #include <linux/blk_types.h>
-#include <linux/device_types.h>
-#include <linux/list.h>
 #include <linux/minmax.h>
 #include <linux/timer_types.h>
 #include <linux/workqueue_types.h>
@@ -44,173 +42,6 @@ extern const struct device_type disk_type;
 extern const struct device_type part_type;
 extern struct class block_class;
 
-/*
- * Maximum number of blkcg policies allowed to be registered concurrently.
- * Defined here to simplify include dependency.
- */
-#define BLKCG_MAX_POLS		6
-
-#define DISK_MAX_PARTS			256
-#define DISK_NAME_LEN			32
-
-#define PARTITION_META_INFO_VOLNAMELTH	64
-/*
- * Enough for the string representation of any kind of UUID plus NULL.
- * EFI UUID is 36 characters. MSDOS UUID is 11 characters.
- */
-#define PARTITION_META_INFO_UUIDLTH	(UUID_STRING_LEN + 1)
-
-struct partition_meta_info {
-	char uuid[PARTITION_META_INFO_UUIDLTH];
-	u8 volname[PARTITION_META_INFO_VOLNAMELTH];
-};
-
-/**
- * DOC: genhd capability flags
- *
- * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
- * removable media.  When set, the device remains present even when media is not
- * inserted.  Shall not be set for devices which are removed entirely when the
- * media is removed.
- *
- * ``GENHD_FL_HIDDEN``: the block device is hidden; it doesn't produce events,
- * doesn't appear in sysfs, and can't be opened from userspace or using
- * blkdev_get*. Used for the underlying components of multipath devices.
- *
- * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
- * scan for partitions from add_disk, and users can't add partitions manually.
- *
- */
-enum {
-	GENHD_FL_REMOVABLE			= 1 << 0,
-	GENHD_FL_HIDDEN				= 1 << 1,
-	GENHD_FL_NO_PART			= 1 << 2,
-};
-
-enum {
-	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
-};
-
-enum {
-	/* Poll even if events_poll_msecs is unset */
-	DISK_EVENT_FLAG_POLL			= 1 << 0,
-	/* Forward events to udev */
-	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
-	/* Block event polling when open for exclusive write */
-	DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE	= 1 << 2,
-};
-
-struct disk_events;
-struct badblocks;
-
-struct blk_integrity {
-	const struct blk_integrity_profile	*profile;
-	unsigned char				flags;
-	unsigned char				tuple_size;
-	unsigned char				interval_exp;
-	unsigned char				tag_size;
-};
-
-typedef unsigned int __bitwise blk_mode_t;
-
-/* open for reading */
-#define BLK_OPEN_READ		((__force blk_mode_t)(1 << 0))
-/* open for writing */
-#define BLK_OPEN_WRITE		((__force blk_mode_t)(1 << 1))
-/* open exclusively (vs other exclusive openers */
-#define BLK_OPEN_EXCL		((__force blk_mode_t)(1 << 2))
-/* opened with O_NDELAY */
-#define BLK_OPEN_NDELAY		((__force blk_mode_t)(1 << 3))
-/* open for "writes" only for ioctls (specialy hack for floppy.c) */
-#define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
-/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
-#define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
-
-struct gendisk {
-	/*
-	 * major/first_minor/minors should not be set by any new driver, the
-	 * block core will take care of allocating them automatically.
-	 */
-	int major;
-	int first_minor;
-	int minors;
-
-	char disk_name[DISK_NAME_LEN];	/* name of major driver */
-
-	unsigned short events;		/* supported events */
-	unsigned short event_flags;	/* flags related to event processing */
-
-	struct xarray part_tbl;
-	struct block_device *part0;
-
-	const struct block_device_operations *fops;
-	struct request_queue *queue;
-	void *private_data;
-
-	struct bio_set bio_split;
-
-	int flags;
-	unsigned long state;
-#define GD_NEED_PART_SCAN		0
-#define GD_READ_ONLY			1
-#define GD_DEAD				2
-#define GD_NATIVE_CAPACITY		3
-#define GD_ADDED			4
-#define GD_SUPPRESS_PART_SCAN		5
-#define GD_OWNS_QUEUE			6
-
-	struct mutex open_mutex;	/* open/close mutex */
-	unsigned open_partitions;	/* number of open partitions */
-
-	struct backing_dev_info	*bdi;
-	struct kobject queue_kobj;	/* the queue/ directory */
-	struct kobject *slave_dir;
-#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
-	struct list_head slave_bdevs;
-#endif
-	struct timer_rand_state *random;
-	atomic_t sync_io;		/* RAID */
-	struct disk_events *ev;
-
-#ifdef CONFIG_BLK_DEV_ZONED
-	/*
-	 * Zoned block device information for request dispatch control.
-	 * nr_zones is the total number of zones of the device. This is always
-	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
-	 * bits which indicates if a zone is conventional (bit set) or
-	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
-	 * bits which indicates if a zone is write locked, that is, if a write
-	 * request targeting the zone was dispatched.
-	 *
-	 * Reads of this information must be protected with blk_queue_enter() /
-	 * blk_queue_exit(). Modifying this information is only allowed while
-	 * no requests are being processed. See also blk_mq_freeze_queue() and
-	 * blk_mq_unfreeze_queue().
-	 */
-	unsigned int		nr_zones;
-	unsigned int		max_open_zones;
-	unsigned int		max_active_zones;
-	unsigned long		*conv_zones_bitmap;
-	unsigned long		*seq_zones_wlock;
-#endif /* CONFIG_BLK_DEV_ZONED */
-
-#if IS_ENABLED(CONFIG_CDROM)
-	struct cdrom_device_info *cdi;
-#endif
-	int node_id;
-	struct badblocks *bb;
-	struct lockdep_map lockdep_map;
-	u64 diskseq;
-	blk_mode_t open_mode;
-
-	/*
-	 * Independent sector access ranges. This is always NULL for
-	 * devices that do not have multiple independent access ranges.
-	 */
-	struct blk_independent_access_ranges *ia_ranges;
-};
-
 static inline bool disk_live(struct gendisk *disk)
 {
 	return !inode_unhashed(disk->part0->bd_inode);
@@ -259,57 +90,6 @@ static inline int blk_validate_block_size(unsigned long bsize)
 	return 0;
 }
 
-/*
- * BLK_BOUNCE_NONE:	never bounce (default)
- * BLK_BOUNCE_HIGH:	bounce all highmem pages
- */
-enum blk_bounce {
-	BLK_BOUNCE_NONE,
-	BLK_BOUNCE_HIGH,
-};
-
-struct queue_limits {
-	enum blk_bounce		bounce;
-	unsigned long		seg_boundary_mask;
-	unsigned long		virt_boundary_mask;
-
-	unsigned int		max_hw_sectors;
-	unsigned int		max_dev_sectors;
-	unsigned int		chunk_sectors;
-	unsigned int		max_sectors;
-	unsigned int		max_user_sectors;
-	unsigned int		max_segment_size;
-	unsigned int		physical_block_size;
-	unsigned int		logical_block_size;
-	unsigned int		alignment_offset;
-	unsigned int		io_min;
-	unsigned int		io_opt;
-	unsigned int		max_discard_sectors;
-	unsigned int		max_hw_discard_sectors;
-	unsigned int		max_secure_erase_sectors;
-	unsigned int		max_write_zeroes_sectors;
-	unsigned int		max_zone_append_sectors;
-	unsigned int		discard_granularity;
-	unsigned int		discard_alignment;
-	unsigned int		zone_write_granularity;
-
-	unsigned short		max_segments;
-	unsigned short		max_integrity_segments;
-	unsigned short		max_discard_segments;
-
-	unsigned char		misaligned;
-	unsigned char		discard_misaligned;
-	unsigned char		raid_partial_stripes_expensive;
-	bool			zoned;
-
-	/*
-	 * Drivers that set dma_alignment to less than 511 must be prepared to
-	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
-	 * due to possible offsets.
-	 */
-	unsigned int		dma_alignment;
-};
-
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 			       void *data);
 
@@ -350,194 +130,6 @@ struct blk_independent_access_ranges {
 	struct blk_independent_access_range	ia_range[];
 };
 
-struct request_queue {
-	/*
-	 * The queue owner gets to use this for whatever they like.
-	 * ll_rw_blk doesn't touch it.
-	 */
-	void			*queuedata;
-
-	struct elevator_queue	*elevator;
-
-	const struct blk_mq_ops	*mq_ops;
-
-	/* sw queues */
-	struct blk_mq_ctx __percpu	*queue_ctx;
-
-	/*
-	 * various queue flags, see QUEUE_* below
-	 */
-	unsigned long		queue_flags;
-
-	unsigned int		rq_timeout;
-
-	unsigned int		queue_depth;
-
-	refcount_t		refs;
-
-	/* hw dispatch queues */
-	unsigned int		nr_hw_queues;
-	struct xarray		hctx_table;
-
-	struct percpu_ref	q_usage_counter;
-
-	struct request		*last_merge;
-
-	spinlock_t		queue_lock;
-
-	int			quiesce_depth;
-
-	struct gendisk		*disk;
-
-	/*
-	 * mq queue kobject
-	 */
-	struct kobject *mq_kobj;
-
-	struct queue_limits	limits;
-
-#ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct blk_integrity integrity;
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
-
-#ifdef CONFIG_PM
-	struct device		*dev;
-	enum rpm_status		rpm_status;
-#endif
-
-	/*
-	 * Number of contexts that have called blk_set_pm_only(). If this
-	 * counter is above zero then only RQF_PM requests are processed.
-	 */
-	atomic_t		pm_only;
-
-	struct blk_queue_stats	*stats;
-	struct rq_qos		*rq_qos;
-	struct mutex		rq_qos_mutex;
-
-	/*
-	 * ida allocated id for this queue.  Used to index queues from
-	 * ioctx.
-	 */
-	int			id;
-
-	unsigned int		dma_pad_mask;
-
-	/*
-	 * queue settings
-	 */
-	unsigned long		nr_requests;	/* Max # of requests */
-
-#ifdef CONFIG_BLK_INLINE_ENCRYPTION
-	struct blk_crypto_profile *crypto_profile;
-	struct kobject *crypto_kobject;
-#endif
-
-	struct timer_list	timeout;
-	struct work_struct	timeout_work;
-
-	atomic_t		nr_active_requests_shared_tags;
-
-	unsigned int		required_elevator_features;
-
-	struct blk_mq_tags	*sched_shared_tags;
-
-	struct list_head	icq_list;
-#ifdef CONFIG_BLK_CGROUP
-	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
-	struct blkcg_gq		*root_blkg;
-	struct list_head	blkg_list;
-	struct mutex		blkcg_mutex;
-#endif
-
-	int			node;
-
-	spinlock_t		requeue_lock;
-	struct list_head	requeue_list;
-	struct delayed_work	requeue_work;
-
-#ifdef CONFIG_BLK_DEV_IO_TRACE
-	struct blk_trace __rcu	*blk_trace;
-#endif
-	/*
-	 * for flush operations
-	 */
-	struct blk_flush_queue	*fq;
-	struct list_head	flush_list;
-
-	struct mutex		sysfs_lock;
-	struct mutex		sysfs_dir_lock;
-
-	/*
-	 * for reusing dead hctx instance in case of updating
-	 * nr_hw_queues
-	 */
-	struct list_head	unused_hctx_list;
-	spinlock_t		unused_hctx_lock;
-
-	int			mq_freeze_depth;
-
-#ifdef CONFIG_BLK_DEV_THROTTLING
-	/* Throttle data */
-	struct throtl_data *td;
-#endif
-	struct rcu_head		rcu_head;
-	wait_queue_head_t	mq_freeze_wq;
-	/*
-	 * Protect concurrent access to q_usage_counter by
-	 * percpu_ref_kill() and percpu_ref_reinit().
-	 */
-	struct mutex		mq_freeze_lock;
-
-	struct blk_mq_tag_set	*tag_set;
-	struct list_head	tag_set_list;
-
-	struct dentry		*debugfs_dir;
-	struct dentry		*sched_debugfs_dir;
-	struct dentry		*rqos_debugfs_dir;
-	/*
-	 * Serializes all debugfs metadata operations using the above dentries.
-	 */
-	struct mutex		debugfs_mutex;
-
-	bool			mq_sysfs_init_done;
-};
-
-/* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
-#define QUEUE_FLAG_DYING	1	/* queue being torn down */
-#define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-#define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
-#define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
-#define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
-#define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
-#define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
-#define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
-#define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
-#define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
-#define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
-#define QUEUE_FLAG_HW_WC	13	/* Write back caching supported */
-#define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
-#define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
-#define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
-#define QUEUE_FLAG_WC		17	/* Write back caching */
-#define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
-#define QUEUE_FLAG_DAX		19	/* device supports DAX */
-#define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
-#define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
-#define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
-#define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
-#define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
-#define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
-#define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
-#define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
-#define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
-#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
-
-#define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
-				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
-				 (1UL << QUEUE_FLAG_NOWAIT))
-
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
@@ -920,32 +512,6 @@ extern void blk_put_queue(struct request_queue *);
 void blk_mark_disk_dead(struct gendisk *disk);
 
 #ifdef CONFIG_BLOCK
-/*
- * blk_plug permits building a queue of related requests by holding the I/O
- * fragments for a short period. This allows merging of sequential requests
- * into single larger request. As the requests are moved from a per-task list to
- * the device's request_queue in a batch, this results in improved scalability
- * as the lock contention for request_queue lock is reduced.
- *
- * It is ok not to disable preemption when adding the request to the plug list
- * or when attempting a merge. For details, please see schedule() where
- * blk_flush_plug() is called.
- */
-struct blk_plug {
-	struct request *mq_list; /* blk-mq requests */
-
-	/* if ios_left is > 1, we can batch tag/rq allocations */
-	struct request *cached_rq;
-	u64 cur_ktime;
-	unsigned short nr_ios;
-
-	unsigned short rq_count;
-
-	bool multiple_queues;
-	bool has_elevator;
-
-	struct list_head cb_list; /* md requires an unplug callback */
-};
 
 struct blk_plug_cb;
 typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
@@ -982,8 +548,6 @@ static inline void blk_plug_invalidate_ts(struct task_struct *tsk)
 int blkdev_issue_flush(struct block_device *bdev);
 long nr_blockdev_pages(void);
 #else /* CONFIG_BLOCK */
-struct blk_plug {
-};
 
 static inline void blk_start_plug_nr_ios(struct blk_plug *plug,
 					 unsigned short nr_ios)
@@ -1545,12 +1109,6 @@ static inline int early_lookup_bdev(const char *pathname, dev_t *dev)
 int bdev_freeze(struct block_device *bdev);
 int bdev_thaw(struct block_device *bdev);
 
-struct io_comp_batch {
-	struct request *req_list;
-	bool need_ts;
-	void (*complete)(struct io_comp_batch *);
-};
-
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
 #endif /* _LINUX_BLKDEV_H */
diff --git a/include/linux/blkdev_types.h b/include/linux/blkdev_types.h
new file mode 100644
index 000000000000..35a1dcf98bf6
--- /dev/null
+++ b/include/linux/blkdev_types.h
@@ -0,0 +1,461 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BLKDEV_TYPES_H
+#define _LINUX_BLKDEV_TYPES_H
+
+#include <linux/bio_types.h>
+#include <linux/list.h>
+#include <linux/kobject_types.h>
+#include <linux/percpu-refcount_types.h>
+#include <linux/pm.h>
+#include <linux/uuid.h>
+#include <linux/xarray_types.h>
+
+/*
+ * Maximum number of blkcg policies allowed to be registered concurrently.
+ * Defined here to simplify include dependency.
+ */
+#define BLKCG_MAX_POLS		6
+
+#define DISK_MAX_PARTS			256
+#define DISK_NAME_LEN			32
+
+#define PARTITION_META_INFO_VOLNAMELTH	64
+/*
+ * Enough for the string representation of any kind of UUID plus NULL.
+ * EFI UUID is 36 characters. MSDOS UUID is 11 characters.
+ */
+#define PARTITION_META_INFO_UUIDLTH	(UUID_STRING_LEN + 1)
+
+struct partition_meta_info {
+	char uuid[PARTITION_META_INFO_UUIDLTH];
+	u8 volname[PARTITION_META_INFO_VOLNAMELTH];
+};
+
+/**
+ * DOC: genhd capability flags
+ *
+ * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
+ * removable media.  When set, the device remains present even when media is not
+ * inserted.  Shall not be set for devices which are removed entirely when the
+ * media is removed.
+ *
+ * ``GENHD_FL_HIDDEN``: the block device is hidden; it doesn't produce events,
+ * doesn't appear in sysfs, and can't be opened from userspace or using
+ * blkdev_get*. Used for the underlying components of multipath devices.
+ *
+ * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
+ * scan for partitions from add_disk, and users can't add partitions manually.
+ *
+ */
+enum {
+	GENHD_FL_REMOVABLE			= 1 << 0,
+	GENHD_FL_HIDDEN				= 1 << 1,
+	GENHD_FL_NO_PART			= 1 << 2,
+};
+
+enum {
+	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
+	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
+};
+
+enum {
+	/* Poll even if events_poll_msecs is unset */
+	DISK_EVENT_FLAG_POLL			= 1 << 0,
+	/* Forward events to udev */
+	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
+	/* Block event polling when open for exclusive write */
+	DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE	= 1 << 2,
+};
+
+struct disk_events;
+struct badblocks;
+
+struct blk_integrity {
+	const struct blk_integrity_profile	*profile;
+	unsigned char				flags;
+	unsigned char				tuple_size;
+	unsigned char				interval_exp;
+	unsigned char				tag_size;
+};
+
+typedef unsigned int __bitwise blk_mode_t;
+
+/* open for reading */
+#define BLK_OPEN_READ		((__force blk_mode_t)(1 << 0))
+/* open for writing */
+#define BLK_OPEN_WRITE		((__force blk_mode_t)(1 << 1))
+/* open exclusively (vs other exclusive openers */
+#define BLK_OPEN_EXCL		((__force blk_mode_t)(1 << 2))
+/* opened with O_NDELAY */
+#define BLK_OPEN_NDELAY		((__force blk_mode_t)(1 << 3))
+/* open for "writes" only for ioctls (specialy hack for floppy.c) */
+#define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
+/* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
+#define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+
+struct gendisk {
+	/*
+	 * major/first_minor/minors should not be set by any new driver, the
+	 * block core will take care of allocating them automatically.
+	 */
+	int major;
+	int first_minor;
+	int minors;
+
+	char disk_name[DISK_NAME_LEN];	/* name of major driver */
+
+	unsigned short events;		/* supported events */
+	unsigned short event_flags;	/* flags related to event processing */
+
+	struct xarray part_tbl;
+	struct block_device *part0;
+
+	const struct block_device_operations *fops;
+	struct request_queue *queue;
+	void *private_data;
+
+	struct bio_set bio_split;
+
+	int flags;
+	unsigned long state;
+#define GD_NEED_PART_SCAN		0
+#define GD_READ_ONLY			1
+#define GD_DEAD				2
+#define GD_NATIVE_CAPACITY		3
+#define GD_ADDED			4
+#define GD_SUPPRESS_PART_SCAN		5
+#define GD_OWNS_QUEUE			6
+
+	struct mutex open_mutex;	/* open/close mutex */
+	unsigned open_partitions;	/* number of open partitions */
+
+	struct backing_dev_info	*bdi;
+	struct kobject queue_kobj;	/* the queue/ directory */
+	struct kobject *slave_dir;
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
+	struct list_head slave_bdevs;
+#endif
+	struct timer_rand_state *random;
+	atomic_t sync_io;		/* RAID */
+	struct disk_events *ev;
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	/*
+	 * Zoned block device information for request dispatch control.
+	 * nr_zones is the total number of zones of the device. This is always
+	 * 0 for regular block devices. conv_zones_bitmap is a bitmap of nr_zones
+	 * bits which indicates if a zone is conventional (bit set) or
+	 * sequential (bit clear). seq_zones_wlock is a bitmap of nr_zones
+	 * bits which indicates if a zone is write locked, that is, if a write
+	 * request targeting the zone was dispatched.
+	 *
+	 * Reads of this information must be protected with blk_queue_enter() /
+	 * blk_queue_exit(). Modifying this information is only allowed while
+	 * no requests are being processed. See also blk_mq_freeze_queue() and
+	 * blk_mq_unfreeze_queue().
+	 */
+	unsigned int		nr_zones;
+	unsigned int		max_open_zones;
+	unsigned int		max_active_zones;
+	unsigned long		*conv_zones_bitmap;
+	unsigned long		*seq_zones_wlock;
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+#if IS_ENABLED(CONFIG_CDROM)
+	struct cdrom_device_info *cdi;
+#endif
+	int node_id;
+	struct badblocks *bb;
+	struct lockdep_map lockdep_map;
+	u64 diskseq;
+	blk_mode_t open_mode;
+
+	/*
+	 * Independent sector access ranges. This is always NULL for
+	 * devices that do not have multiple independent access ranges.
+	 */
+	struct blk_independent_access_ranges *ia_ranges;
+};
+
+/*
+ * BLK_BOUNCE_NONE:	never bounce (default)
+ * BLK_BOUNCE_HIGH:	bounce all highmem pages
+ */
+enum blk_bounce {
+	BLK_BOUNCE_NONE,
+	BLK_BOUNCE_HIGH,
+};
+
+struct queue_limits {
+	enum blk_bounce		bounce;
+	unsigned long		seg_boundary_mask;
+	unsigned long		virt_boundary_mask;
+
+	unsigned int		max_hw_sectors;
+	unsigned int		max_dev_sectors;
+	unsigned int		chunk_sectors;
+	unsigned int		max_sectors;
+	unsigned int		max_user_sectors;
+	unsigned int		max_segment_size;
+	unsigned int		physical_block_size;
+	unsigned int		logical_block_size;
+	unsigned int		alignment_offset;
+	unsigned int		io_min;
+	unsigned int		io_opt;
+	unsigned int		max_discard_sectors;
+	unsigned int		max_hw_discard_sectors;
+	unsigned int		max_secure_erase_sectors;
+	unsigned int		max_write_zeroes_sectors;
+	unsigned int		max_zone_append_sectors;
+	unsigned int		discard_granularity;
+	unsigned int		discard_alignment;
+	unsigned int		zone_write_granularity;
+
+	unsigned short		max_segments;
+	unsigned short		max_integrity_segments;
+	unsigned short		max_discard_segments;
+
+	unsigned char		misaligned;
+	unsigned char		discard_misaligned;
+	unsigned char		raid_partial_stripes_expensive;
+	bool			zoned;
+
+	/*
+	 * Drivers that set dma_alignment to less than 511 must be prepared to
+	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
+	 * due to possible offsets.
+	 */
+	unsigned int		dma_alignment;
+};
+
+struct request_queue {
+	/*
+	 * The queue owner gets to use this for whatever they like.
+	 * ll_rw_blk doesn't touch it.
+	 */
+	void			*queuedata;
+
+	struct elevator_queue	*elevator;
+
+	const struct blk_mq_ops	*mq_ops;
+
+	/* sw queues */
+	struct blk_mq_ctx __percpu	*queue_ctx;
+
+	/*
+	 * various queue flags, see QUEUE_* below
+	 */
+	unsigned long		queue_flags;
+
+	unsigned int		rq_timeout;
+
+	unsigned int		queue_depth;
+
+	refcount_t		refs;
+
+	/* hw dispatch queues */
+	unsigned int		nr_hw_queues;
+	struct xarray		hctx_table;
+
+	struct percpu_ref	q_usage_counter;
+
+	struct request		*last_merge;
+
+	spinlock_t		queue_lock;
+
+	int			quiesce_depth;
+
+	struct gendisk		*disk;
+
+	/*
+	 * mq queue kobject
+	 */
+	struct kobject *mq_kobj;
+
+	struct queue_limits	limits;
+
+#ifdef  CONFIG_BLK_DEV_INTEGRITY
+	struct blk_integrity integrity;
+#endif	/* CONFIG_BLK_DEV_INTEGRITY */
+
+#ifdef CONFIG_PM
+	struct device		*dev;
+	enum rpm_status		rpm_status;
+#endif
+
+	/*
+	 * Number of contexts that have called blk_set_pm_only(). If this
+	 * counter is above zero then only RQF_PM requests are processed.
+	 */
+	atomic_t		pm_only;
+
+	struct blk_queue_stats	*stats;
+	struct rq_qos		*rq_qos;
+	struct mutex		rq_qos_mutex;
+
+	/*
+	 * ida allocated id for this queue.  Used to index queues from
+	 * ioctx.
+	 */
+	int			id;
+
+	unsigned int		dma_pad_mask;
+
+	/*
+	 * queue settings
+	 */
+	unsigned long		nr_requests;	/* Max # of requests */
+
+#ifdef CONFIG_BLK_INLINE_ENCRYPTION
+	struct blk_crypto_profile *crypto_profile;
+	struct kobject *crypto_kobject;
+#endif
+
+	struct timer_list	timeout;
+	struct work_struct	timeout_work;
+
+	atomic_t		nr_active_requests_shared_tags;
+
+	unsigned int		required_elevator_features;
+
+	struct blk_mq_tags	*sched_shared_tags;
+
+	struct list_head	icq_list;
+#ifdef CONFIG_BLK_CGROUP
+	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
+	struct blkcg_gq		*root_blkg;
+	struct list_head	blkg_list;
+	struct mutex		blkcg_mutex;
+#endif
+
+	int			node;
+
+	spinlock_t		requeue_lock;
+	struct list_head	requeue_list;
+	struct delayed_work	requeue_work;
+
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	struct blk_trace __rcu	*blk_trace;
+#endif
+	/*
+	 * for flush operations
+	 */
+	struct blk_flush_queue	*fq;
+	struct list_head	flush_list;
+
+	struct mutex		sysfs_lock;
+	struct mutex		sysfs_dir_lock;
+
+	/*
+	 * for reusing dead hctx instance in case of updating
+	 * nr_hw_queues
+	 */
+	struct list_head	unused_hctx_list;
+	spinlock_t		unused_hctx_lock;
+
+	int			mq_freeze_depth;
+
+#ifdef CONFIG_BLK_DEV_THROTTLING
+	/* Throttle data */
+	struct throtl_data *td;
+#endif
+	struct rcu_head		rcu_head;
+	wait_queue_head_t	mq_freeze_wq;
+	/*
+	 * Protect concurrent access to q_usage_counter by
+	 * percpu_ref_kill() and percpu_ref_reinit().
+	 */
+	struct mutex		mq_freeze_lock;
+
+	struct blk_mq_tag_set	*tag_set;
+	struct list_head	tag_set_list;
+
+	struct dentry		*debugfs_dir;
+	struct dentry		*sched_debugfs_dir;
+	struct dentry		*rqos_debugfs_dir;
+	/*
+	 * Serializes all debugfs metadata operations using the above dentries.
+	 */
+	struct mutex		debugfs_mutex;
+
+	bool			mq_sysfs_init_done;
+};
+
+/* Keep blk_queue_flag_name[] in sync with the definitions below */
+#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
+#define QUEUE_FLAG_DYING	1	/* queue being torn down */
+#define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
+#define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
+#define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
+#define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
+#define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
+#define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
+#define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
+#define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
+#define QUEUE_FLAG_SYNCHRONOUS	11	/* always completes in submit context */
+#define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
+#define QUEUE_FLAG_HW_WC	13	/* Write back caching supported */
+#define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
+#define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
+#define QUEUE_FLAG_POLL		16	/* IO polling enabled if set */
+#define QUEUE_FLAG_WC		17	/* Write back caching */
+#define QUEUE_FLAG_FUA		18	/* device supports FUA writes */
+#define QUEUE_FLAG_DAX		19	/* device supports DAX */
+#define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
+#define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
+#define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
+#define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
+#define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
+#define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
+#define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
+#define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
+#define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
+#define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
+
+#define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
+				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
+				 (1UL << QUEUE_FLAG_NOWAIT))
+
+#ifdef CONFIG_BLOCK
+
+/*
+ * blk_plug permits building a queue of related requests by holding the I/O
+ * fragments for a short period. This allows merging of sequential requests
+ * into single larger request. As the requests are moved from a per-task list to
+ * the device's request_queue in a batch, this results in improved scalability
+ * as the lock contention for request_queue lock is reduced.
+ *
+ * It is ok not to disable preemption when adding the request to the plug list
+ * or when attempting a merge. For details, please see schedule() where
+ * blk_flush_plug() is called.
+ */
+struct blk_plug {
+	struct request *mq_list; /* blk-mq requests */
+
+	/* if ios_left is > 1, we can batch tag/rq allocations */
+	struct request *cached_rq;
+	u64 cur_ktime;
+	unsigned short nr_ios;
+
+	unsigned short rq_count;
+
+	bool multiple_queues;
+	bool has_elevator;
+
+	struct list_head cb_list; /* md requires an unplug callback */
+};
+
+#else /* CONFIG_BLOCK */
+
+struct blk_plug {
+};
+
+#endif /* CONFIG_BLOCK */
+
+struct io_comp_batch {
+	struct request *req_list;
+	bool need_ts;
+	void (*complete)(struct io_comp_batch *);
+};
+
+#endif /* _LINUX_BLKDEV_TYPES_H */
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 98c6fd0b39b6..d99709e14ecb 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -13,7 +13,7 @@
 
 #include <linux/fs.h>		/* not really needed, later.. */
 #include <linux/list.h>
-#include <linux/blkdev.h>
+#include <linux/blkdev_types.h>
 #include <scsi/scsi_common.h>
 #include <uapi/linux/cdrom.h>
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 854ad67a5f70..fd9e5bafdf85 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -1,7 +1,7 @@
 #ifndef IO_URING_TYPES_H
 #define IO_URING_TYPES_H
 
-#include <linux/blkdev.h>
+#include <linux/blkdev_types.h>
 #include <linux/task_work.h>
 #include <linux/bitmap.h>
 #include <linux/llist.h>
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 49db7fa2cebd..264c295b503c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -47,6 +47,7 @@
 #include <linux/refcount.h>
 #include <linux/uio.h>
 #include <linux/bits.h>
+#include <linux/blkdev.h>
 
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
-- 
2.39.2


