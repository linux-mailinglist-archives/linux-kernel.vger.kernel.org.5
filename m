Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041DE76E922
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjHCNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjHCNDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E978E46;
        Thu,  3 Aug 2023 06:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98A1E61D98;
        Thu,  3 Aug 2023 13:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D3BC433CB;
        Thu,  3 Aug 2023 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067809;
        bh=zQE4rT5enBO5UT1ezJALmZAk6kcWK//Jfn4eLC+j/7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hn7VzLbLhbKyqqu6GA441R734ybvDl2odyoMshJvQxGsxlkfFtTHCjcOqrl7HmXQU
         Jt5uaP/SIM78l0kLKcb4r70a5cDK/v/RX8rSTzeHD67URlhhh3hMO/wzMuZhoFbqeC
         g+8SMGLVxh4ZLA8ZiK6NPKu3PH+ef1I6FacbX5bIDOY2Xd86/xd+UvprALUPUmzcew
         E+Mqq4/GmeNmYbXnlUKomKayJ2ShU7ODpVIBEF13KEM3UrpFg0RcUPCoyTwPSl0kk9
         8SrQ0PNpQXpYlVhhQyYEC9HtPY81nv0QbrlYFlLcmMenMdxosQilUiXqljm/WZuqZL
         RpLn0N1fuOH4A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 4/7] scsi: block: Improve checks in blk_revalidate_disk_zones()
Date:   Thu,  3 Aug 2023 09:03:17 -0400
Message-Id: <20230803130321.641516-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130321.641516-1-sashal@kernel.org>
References: <20230803130321.641516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 03e51c4a74b91b0b1a9ca091029b0b58f014be81 ]

blk_revalidate_disk_zones() implements checks of the zones of a zoned
block device, verifying that the zone size is a power of 2 number of
sectors, that all zones (except possibly the last one) have the same
size and that zones cover the entire addressing space of the device.

While these checks are appropriate to verify that well tested hardware
devices have an adequate zone configurations, they lack in certain areas
which may result in issues with emulated devices implemented with user
drivers such as ublk or tcmu. Specifically, this function does not
check if the device driver indicated support for the mandatory zone
append writes, that is, if the device max_zone_append_sectors queue
limit is set to a non-zero value. Additionally, invalid zones such as
a zero length zone with a start sector equal to the device capacity will
not be detected and result in out of bounds use of the zone bitmaps
prepared with the callback function blk_revalidate_zone_cb().

Improve blk_revalidate_disk_zones() to address these inadequate checks,
relying on the fact that all device drivers supporting zoned block
devices must set the device zone size (chunk_sectors queue limit) and
the max_zone_append_sectors queue limit before executing this function.

The check for a non-zero max_zone_append_sectors value is done in
blk_revalidate_disk_zones() before executing the zone report. The zone
report callback function blk_revalidate_zone_cb() is also modified to
add a check that a zone start is below the device capacity.

The check that the zone size is a power of 2 number of sectors is moved
to blk_revalidate_disk_zones() as the zone size is already known.
Similarly, the number of zones of the device can be calculated in
blk_revalidate_disk_zones() before executing the zone report.

The kdoc comment for blk_revalidate_disk_zones() is also updated to
mention that device drivers must set the device zone size and the
max_zone_append_sectors queue limit before calling this function.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20230703024812.76778-6-dlemoal@kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c | 86 +++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fce9082384d65..da92ce0c5da98 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -448,7 +448,6 @@ struct blk_revalidate_zone_args {
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
-	sector_t	zone_sectors;
 	sector_t	sector;
 };
 
@@ -462,38 +461,34 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	struct gendisk *disk = args->disk;
 	struct request_queue *q = disk->queue;
 	sector_t capacity = get_capacity(disk);
+	sector_t zone_sectors = q->limits.chunk_sectors;
+
+	/* Check for bad zones and holes in the zone report */
+	if (zone->start != args->sector) {
+		pr_warn("%s: Zone gap at sectors %llu..%llu\n",
+			disk->disk_name, args->sector, zone->start);
+		return -ENODEV;
+	}
+
+	if (zone->start >= capacity || !zone->len) {
+		pr_warn("%s: Invalid zone start %llu, length %llu\n",
+			disk->disk_name, zone->start, zone->len);
+		return -ENODEV;
+	}
 
 	/*
 	 * All zones must have the same size, with the exception on an eventual
 	 * smaller last zone.
 	 */
-	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
-			return -ENODEV;
-		}
-
-		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
-	} else if (zone->start + args->zone_sectors < capacity) {
-		if (zone->len != args->zone_sectors) {
+	if (zone->start + zone->len < capacity) {
+		if (zone->len != zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
 				disk->disk_name);
 			return -ENODEV;
 		}
-	} else {
-		if (zone->len > args->zone_sectors) {
-			pr_warn("%s: Invalid zoned device with larger last zone size\n",
-				disk->disk_name);
-			return -ENODEV;
-		}
-	}
-
-	/* Check for holes in the zone report */
-	if (zone->start != args->sector) {
-		pr_warn("%s: Zone gap at sectors %llu..%llu\n",
-			disk->disk_name, args->sector, zone->start);
+	} else if (zone->len > zone_sectors) {
+		pr_warn("%s: Invalid zoned device with larger last zone size\n",
+			disk->disk_name);
 		return -ENODEV;
 	}
 
@@ -532,11 +527,13 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  * @disk:	Target disk
  * @update_driver_data:	Callback to update driver data on the frozen disk
  *
- * Helper function for low-level device drivers to (re) allocate and initialize
- * a disk request queue zone bitmaps. This functions should normally be called
- * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
- * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
- * is correct.
+ * Helper function for low-level device drivers to check and (re) allocate and
+ * initialize a disk request queue zone bitmaps. This functions should normally
+ * be called within the disk ->revalidate method for blk-mq based drivers.
+ * Before calling this function, the device driver must already have set the
+ * device zone size (chunk_sector limit) and the max zone append limit.
+ * For BIO based drivers, this function cannot be used. BIO based device drivers
+ * only need to set disk->nr_zones so that the sysfs exposed value is correct.
  * If the @update_driver_data callback function is not NULL, the callback is
  * executed with the device request queue frozen after all zones have been
  * checked.
@@ -545,9 +542,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 			      void (*update_driver_data)(struct gendisk *disk))
 {
 	struct request_queue *q = disk->queue;
-	struct blk_revalidate_zone_args args = {
-		.disk		= disk,
-	};
+	sector_t zone_sectors = q->limits.chunk_sectors;
+	sector_t capacity = get_capacity(disk);
+	struct blk_revalidate_zone_args args = { };
 	unsigned int noio_flag;
 	int ret;
 
@@ -556,13 +553,31 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	if (WARN_ON_ONCE(!queue_is_mq(q)))
 		return -EIO;
 
-	if (!get_capacity(disk))
-		return -EIO;
+	if (!capacity)
+		return -ENODEV;
+
+	/*
+	 * Checks that the device driver indicated a valid zone size and that
+	 * the max zone append limit is set.
+	 */
+	if (!zone_sectors || !is_power_of_2(zone_sectors)) {
+		pr_warn("%s: Invalid non power of two zone size (%llu)\n",
+			disk->disk_name, zone_sectors);
+		return -ENODEV;
+	}
+
+	if (!q->limits.max_zone_append_sectors) {
+		pr_warn("%s: Invalid 0 maximum zone append limit\n",
+			disk->disk_name);
+		return -ENODEV;
+	}
 
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
 	 */
+	args.disk = disk;
+	args.nr_zones = (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
 	noio_flag = memalloc_noio_save();
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
 				       blk_revalidate_zone_cb, &args);
@@ -576,7 +591,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 * If zones where reported, make sure that the entire disk capacity
 	 * has been checked.
 	 */
-	if (ret > 0 && args.sector != get_capacity(disk)) {
+	if (ret > 0 && args.sector != capacity) {
 		pr_warn("%s: Missing zones from sector %llu\n",
 			disk->disk_name, args.sector);
 		ret = -ENODEV;
@@ -589,7 +604,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
-		blk_queue_chunk_sectors(q, args.zone_sectors);
 		disk->nr_zones = args.nr_zones;
 		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
-- 
2.40.1

