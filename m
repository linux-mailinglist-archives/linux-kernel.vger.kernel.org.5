Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06976A0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGaTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjGaTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:13:29 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE9184
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:13:25 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQYKY-0001iC-0W;
        Mon, 31 Jul 2023 19:13:23 +0000
Date:   Mon, 31 Jul 2023 20:13:11 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 4/6] mtd: ubi: introduce pre-removal notification for UBI
 volumes
Message-ID: <bd9b2cdaa2517817830ab14bc9e0e2567a4aae78.1690823629.git.daniel@makrotopia.org>
References: <cover.1690823629.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690823629.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new notification type UBI_VOLUME_SHUTDOWN to inform users
that a volume is just about to be removed.
This is needed because users (such as the NVMEM subsystem) expect that
at the time their removal function is called, the parenting device is
still available (for removal of sysfs nodes, for example, in case of
NVMEM which otherwise WARNs on volume removal).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c | 26 ++++++++++++++++++++++++++
 drivers/mtd/ubi/build.c |  7 ++++++-
 drivers/mtd/ubi/vmt.c   |  5 +++++
 include/linux/mtd/ubi.h |  2 ++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 99b5f502c9dbc..1d5148371991b 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -533,6 +533,29 @@ static int ubiblock_resize(struct ubi_volume_info *vi)
 	return 0;
 }
 
+static int ubiblock_shutdown(struct ubi_volume_info *vi)
+{
+	struct ubiblock *dev;
+	struct gendisk *disk;
+	int ret = 0;
+
+	mutex_lock(&devices_mutex);
+	dev = find_dev_nolock(vi->ubi_num, vi->vol_id);
+	if (!dev) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	disk = dev->gd;
+
+out_unlock:
+	mutex_unlock(&devices_mutex);
+
+	if (!ret)
+		blk_mark_disk_dead(disk);
+
+	return ret;
+};
+
 static bool
 match_volume_desc(struct ubi_volume_info *vi, const char *name, int ubi_num, int vol_id)
 {
@@ -624,6 +647,9 @@ static int ubiblock_notify(struct notifier_block *nb,
 	case UBI_VOLUME_REMOVED:
 		ubiblock_remove(&nt->vi, true);
 		break;
+	case UBI_VOLUME_SHUTDOWN:
+		ubiblock_shutdown(&nt->vi);
+		break;
 	case UBI_VOLUME_RESIZED:
 		ubiblock_resize(&nt->vi);
 		break;
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index c153373c13dab..ccee4a28ffe97 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1088,7 +1088,6 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock)
 		return -EINVAL;
 
 	spin_lock(&ubi_devices_lock);
-	put_device(&ubi->dev);
 	ubi->ref_count -= 1;
 	if (ubi->ref_count) {
 		if (!anyway) {
@@ -1099,6 +1098,12 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway, bool have_lock)
 		ubi_err(ubi, "%s reference count %d, destroy anyway",
 			ubi->ubi_name, ubi->ref_count);
 	}
+	spin_unlock(&ubi_devices_lock);
+
+	ubi_notify_all(ubi, UBI_VOLUME_SHUTDOWN, NULL);
+
+	spin_lock(&ubi_devices_lock);
+	put_device(&ubi->dev);
 	ubi_devices[ubi_num] = NULL;
 	spin_unlock(&ubi_devices_lock);
 
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 2c867d16f89f7..eed4b57c61bda 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -352,6 +352,11 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
 		err = -EBUSY;
 		goto out_unlock;
 	}
+	spin_unlock(&ubi->volumes_lock);
+
+	ubi_volume_notify(ubi, vol, UBI_VOLUME_SHUTDOWN);
+
+	spin_lock(&ubi->volumes_lock);
 	ubi->volumes[vol_id] = NULL;
 	spin_unlock(&ubi->volumes_lock);
 
diff --git a/include/linux/mtd/ubi.h b/include/linux/mtd/ubi.h
index a529347fd75b2..562f92504f2b7 100644
--- a/include/linux/mtd/ubi.h
+++ b/include/linux/mtd/ubi.h
@@ -192,6 +192,7 @@ struct ubi_device_info {
  *			or a volume was removed)
  * @UBI_VOLUME_RESIZED: a volume has been re-sized
  * @UBI_VOLUME_RENAMED: a volume has been re-named
+ * @UBI_VOLUME_SHUTDOWN: a volume is going to removed, shutdown users
  * @UBI_VOLUME_UPDATED: data has been written to a volume
  *
  * These constants define which type of event has happened when a volume
@@ -202,6 +203,7 @@ enum {
 	UBI_VOLUME_REMOVED,
 	UBI_VOLUME_RESIZED,
 	UBI_VOLUME_RENAMED,
+	UBI_VOLUME_SHUTDOWN,
 	UBI_VOLUME_UPDATED,
 };
 
-- 
2.41.0
