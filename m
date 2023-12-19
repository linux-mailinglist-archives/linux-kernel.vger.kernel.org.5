Return-Path: <linux-kernel+bounces-4603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9617817FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DA1C21ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713B1FDD;
	Tue, 19 Dec 2023 02:33:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD4749D;
	Tue, 19 Dec 2023 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rFPvC-0008JR-1v;
	Tue, 19 Dec 2023 02:33:27 +0000
Date: Tue, 19 Dec 2023 02:33:24 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/7] mtd: ubi: introduce pre-removal notification for UBI
 volumes
Message-ID: <2b34c485ac7ab0a3bd3b7314063263ff6c3b071e.1702952891.git.daniel@makrotopia.org>
References: <cover.1702952891.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702952891.git.daniel@makrotopia.org>

Introduce a new notification type UBI_VOLUME_SHUTDOWN to inform users
that a volume is just about to be removed.
This is needed because users (such as the NVMEM subsystem) expect that
at the time their removal function is called, the parenting device is
still available (for removal of sysfs nodes, for example, in case of
NVMEM which otherwise WARNs on volume removal).

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/build.c | 19 ++++++++++++++-----
 drivers/mtd/ubi/kapi.c  |  2 +-
 drivers/mtd/ubi/ubi.h   |  2 ++
 drivers/mtd/ubi/vmt.c   | 17 +++++++++++++++--
 include/linux/mtd/ubi.h |  2 ++
 5 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 8c3f763e4ddb8..a7e3a6246c0e9 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -93,7 +93,7 @@ static struct ubi_device *ubi_devices[UBI_MAX_DEVICES];
 /* Serializes UBI devices creations and removals */
 DEFINE_MUTEX(ubi_devices_mutex);
 
-/* Protects @ubi_devices and @ubi->ref_count */
+/* Protects @ubi_devices, @ubi->ref_count and @ubi->is_dead */
 static DEFINE_SPINLOCK(ubi_devices_lock);
 
 /* "Show" method for files in '/<sysfs>/class/ubi/' */
@@ -261,6 +261,9 @@ struct ubi_device *ubi_get_device(int ubi_num)
 
 	spin_lock(&ubi_devices_lock);
 	ubi = ubi_devices[ubi_num];
+	if (ubi && ubi->is_dead)
+		ubi = NULL;
+
 	if (ubi) {
 		ubi_assert(ubi->ref_count >= 0);
 		ubi->ref_count += 1;
@@ -298,7 +301,7 @@ struct ubi_device *ubi_get_by_major(int major)
 	spin_lock(&ubi_devices_lock);
 	for (i = 0; i < UBI_MAX_DEVICES; i++) {
 		ubi = ubi_devices[i];
-		if (ubi && MAJOR(ubi->cdev.dev) == major) {
+		if (ubi && !ubi->is_dead && MAJOR(ubi->cdev.dev) == major) {
 			ubi_assert(ubi->ref_count >= 0);
 			ubi->ref_count += 1;
 			get_device(&ubi->dev);
@@ -327,7 +330,7 @@ int ubi_major2num(int major)
 	for (i = 0; i < UBI_MAX_DEVICES; i++) {
 		struct ubi_device *ubi = ubi_devices[i];
 
-		if (ubi && MAJOR(ubi->cdev.dev) == major) {
+		if (ubi && !ubi->is_dead && MAJOR(ubi->cdev.dev) == major) {
 			ubi_num = ubi->ubi_num;
 			break;
 		}
@@ -514,7 +517,7 @@ static void ubi_free_volumes_from(struct ubi_device *ubi, int from)
 	int i;
 
 	for (i = from; i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
-		if (!ubi->volumes[i])
+		if (!ubi->volumes[i] || ubi->volumes[i]->is_dead)
 			continue;
 		ubi_eba_replace_table(ubi->volumes[i], NULL);
 		ubi_fastmap_destroy_checkmap(ubi->volumes[i]);
@@ -1099,7 +1102,6 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 		return -EINVAL;
 
 	spin_lock(&ubi_devices_lock);
-	put_device(&ubi->dev);
 	ubi->ref_count -= 1;
 	if (ubi->ref_count) {
 		if (!anyway) {
@@ -1110,6 +1112,13 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 		ubi_err(ubi, "%s reference count %d, destroy anyway",
 			ubi->ubi_name, ubi->ref_count);
 	}
+	ubi->is_dead = true;
+	spin_unlock(&ubi_devices_lock);
+
+	ubi_notify_all(ubi, UBI_VOLUME_SHUTDOWN, NULL);
+
+	spin_lock(&ubi_devices_lock);
+	put_device(&ubi->dev);
 	ubi_devices[ubi_num] = NULL;
 	spin_unlock(&ubi_devices_lock);
 
diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index fbf3a7fe2af79..f1ea8677467fb 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -152,7 +152,7 @@ struct ubi_volume_desc *ubi_open_volume(int ubi_num, int vol_id, int mode)
 
 	spin_lock(&ubi->volumes_lock);
 	vol = ubi->volumes[vol_id];
-	if (!vol)
+	if (!vol || vol->is_dead)
 		goto out_unlock;
 
 	err = -EBUSY;
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 17b463804c979..56a74a3e2d9ab 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -348,6 +348,7 @@ struct ubi_volume {
 	int writers;
 	int exclusive;
 	int metaonly;
+	bool is_dead;
 
 	int reserved_pebs;
 	int vol_type;
@@ -568,6 +569,7 @@ struct ubi_device {
 	spinlock_t volumes_lock;
 	int ref_count;
 	int image_seq;
+	bool is_dead;
 
 	int rsvd_pebs;
 	int avail_pebs;
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 2c867d16f89f7..ee80c04d1d5d0 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -59,7 +59,7 @@ static ssize_t vol_attribute_show(struct device *dev,
 	struct ubi_device *ubi = vol->ubi;
 
 	spin_lock(&ubi->volumes_lock);
-	if (!ubi->volumes[vol->vol_id]) {
+	if (!ubi->volumes[vol->vol_id] || ubi->volumes[vol->vol_id]->is_dead) {
 		spin_unlock(&ubi->volumes_lock);
 		return -ENODEV;
 	}
@@ -189,7 +189,7 @@ int ubi_create_volume(struct ubi_device *ubi, struct ubi_mkvol_req *req)
 
 	/* Ensure that the name is unique */
 	for (i = 0; i < ubi->vtbl_slots; i++)
-		if (ubi->volumes[i] &&
+		if (ubi->volumes[i] && !ubi->volumes[i]->is_dead &&
 		    ubi->volumes[i]->name_len == req->name_len &&
 		    !strcmp(ubi->volumes[i]->name, req->name)) {
 			ubi_err(ubi, "volume \"%s\" exists (ID %d)",
@@ -352,6 +352,19 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
 		err = -EBUSY;
 		goto out_unlock;
 	}
+
+	/*
+	 * Mark volume as dead at this point to prevent that anyone
+	 * can take a reference to the volume from now on.
+	 * This is necessary as we have to release the spinlock before
+	 * calling ubi_volume_notify.
+	 */
+	vol->is_dead = true;
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
2.43.0

