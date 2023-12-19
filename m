Return-Path: <linux-kernel+bounces-4601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A4817FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF00B23DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF533FDD;
	Tue, 19 Dec 2023 02:32:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987753BD;
	Tue, 19 Dec 2023 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rFPuP-0008I2-0u;
	Tue, 19 Dec 2023 02:32:38 +0000
Date: Tue, 19 Dec 2023 02:32:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/7] mtd: ubi: block: use notifier to create ubiblock from
 parameter
Message-ID: <af5981d9bc41b6425e88c7389b4669bc07c27429.1702952891.git.daniel@makrotopia.org>
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

Use UBI_VOLUME_ADDED notification to create ubiblock device specified
on kernel cmdline or module parameter.
This makes thing more simple and has the advantage that ubiblock devices
on volumes which are not present at the time the ubi module is probed
will still be created.

Suggested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c | 136 ++++++++++++++++++++--------------------
 drivers/mtd/ubi/kapi.c  |  54 +++++++++++-----
 drivers/mtd/ubi/ubi.h   |   1 +
 3 files changed, 106 insertions(+), 85 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 309a42aeaa4cd..a467df5aa130a 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -65,10 +65,10 @@ struct ubiblock_pdu {
 };
 
 /* Numbers of elements set in the @ubiblock_param array */
-static int ubiblock_devs __initdata;
+static int ubiblock_devs;
 
 /* MTD devices specification parameters */
-static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES] __initdata;
+static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES];
 
 struct ubiblock {
 	struct ubi_volume_desc *desc;
@@ -534,6 +534,70 @@ static int ubiblock_resize(struct ubi_volume_info *vi)
 	return 0;
 }
 
+static bool
+match_volume_desc(struct ubi_volume_info *vi, const char *name, int ubi_num, int vol_id)
+{
+	int err, len, cur_ubi_num, cur_vol_id;
+
+	if (ubi_num == -1) {
+		/* No ubi num, name must be a vol device path */
+		err = ubi_get_num_by_path(name, &cur_ubi_num, &cur_vol_id);
+		if (err || vi->ubi_num != cur_ubi_num || vi->vol_id != cur_vol_id)
+			return false;
+
+		return true;
+	}
+
+	if (vol_id == -1) {
+		/* Got ubi_num, but no vol_id, name must be volume name */
+		if (vi->ubi_num != ubi_num)
+			return false;
+
+		len = strnlen(name, UBI_VOL_NAME_MAX + 1);
+		if (len < 1 || vi->name_len != len)
+			return false;
+
+		if (strcmp(name, vi->name))
+			return false;
+
+		return true;
+	}
+
+	if (vi->ubi_num != ubi_num)
+		return false;
+
+	if (vi->vol_id != vol_id)
+		return false;
+
+	return true;
+}
+
+static void
+ubiblock_create_from_param(struct ubi_volume_info *vi)
+{
+	int i, ret = 0;
+	struct ubiblock_param *p;
+
+	/*
+	 * Iterate over ubiblock cmdline parameters. If a parameter matches the
+	 * newly added volume create the ubiblock device for it.
+	 */
+	for (i = 0; i < ubiblock_devs; i++) {
+		p = &ubiblock_param[i];
+
+		if (!match_volume_desc(vi, p->name, p->ubi_num, p->vol_id))
+			continue;
+
+		ret = ubiblock_create(vi);
+		if (ret) {
+			pr_err(
+			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
+			       vi->name, p->ubi_num, p->vol_id, ret);
+		}
+		break;
+	}
+}
+
 static int ubiblock_notify(struct notifier_block *nb,
 			 unsigned long notification_type, void *ns_ptr)
 {
@@ -541,10 +605,7 @@ static int ubiblock_notify(struct notifier_block *nb,
 
 	switch (notification_type) {
 	case UBI_VOLUME_ADDED:
-		/*
-		 * We want to enforce explicit block device creation for
-		 * volumes, so when a volume is added we do nothing.
-		 */
+		ubiblock_create_from_param(&nt->vi);
 		break;
 	case UBI_VOLUME_REMOVED:
 		ubiblock_remove(&nt->vi);
@@ -570,56 +631,6 @@ static struct notifier_block ubiblock_notifier = {
 	.notifier_call = ubiblock_notify,
 };
 
-static struct ubi_volume_desc * __init
-open_volume_desc(const char *name, int ubi_num, int vol_id)
-{
-	if (ubi_num == -1)
-		/* No ubi num, name must be a vol device path */
-		return ubi_open_volume_path(name, UBI_READONLY);
-	else if (vol_id == -1)
-		/* No vol_id, must be vol_name */
-		return ubi_open_volume_nm(ubi_num, name, UBI_READONLY);
-	else
-		return ubi_open_volume(ubi_num, vol_id, UBI_READONLY);
-}
-
-static void __init ubiblock_create_from_param(void)
-{
-	int i, ret = 0;
-	struct ubiblock_param *p;
-	struct ubi_volume_desc *desc;
-	struct ubi_volume_info vi;
-
-	/*
-	 * If there is an error creating one of the ubiblocks, continue on to
-	 * create the following ubiblocks. This helps in a circumstance where
-	 * the kernel command-line specifies multiple block devices and some
-	 * may be broken, but we still want the working ones to come up.
-	 */
-	for (i = 0; i < ubiblock_devs; i++) {
-		p = &ubiblock_param[i];
-
-		desc = open_volume_desc(p->name, p->ubi_num, p->vol_id);
-		if (IS_ERR(desc)) {
-			pr_err(
-			       "UBI: block: can't open volume on ubi%d_%d, err=%ld\n",
-			       p->ubi_num, p->vol_id, PTR_ERR(desc));
-			continue;
-		}
-
-		ubi_get_volume_info(desc, &vi);
-		ubi_close_volume(desc);
-
-		ret = ubiblock_create(&vi);
-		if (ret) {
-			pr_err(
-			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
-			       vi.name, p->ubi_num, p->vol_id, ret);
-			continue;
-		}
-	}
-}
-
 static void ubiblock_remove_all(void)
 {
 	struct ubiblock *next;
@@ -645,18 +656,7 @@ int __init ubiblock_init(void)
 	if (ubiblock_major < 0)
 		return ubiblock_major;
 
-	/*
-	 * Attach block devices from 'block=' module param.
-	 * Even if one block device in the param list fails to come up,
-	 * still allow the module to load and leave any others up.
-	 */
-	ubiblock_create_from_param();
-
-	/*
-	 * Block devices are only created upon user requests, so we ignore
-	 * existing volumes.
-	 */
-	ret = ubi_register_volume_notifier(&ubiblock_notifier, 1);
+	ret = ubi_register_volume_notifier(&ubiblock_notifier, 0);
 	if (ret)
 		goto err_unreg;
 	return 0;
diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index 5db653eacbd45..fbf3a7fe2af79 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -279,6 +279,41 @@ struct ubi_volume_desc *ubi_open_volume_nm(int ubi_num, const char *name,
 }
 EXPORT_SYMBOL_GPL(ubi_open_volume_nm);
 
+/**
+ * ubi_get_num_by_path - get UBI device and volume number from device path
+ * @pathname: volume character device node path
+ * @ubi_num: pointer to UBI device number to be set
+ * @vol_id: pointer to UBI volume ID to be set
+ *
+ * Returns 0 on success and sets ubi_num and vol_id, returns error otherwise.
+ */
+int ubi_get_num_by_path(const char *pathname, int *ubi_num, int *vol_id)
+{
+	int error;
+	struct path path;
+	struct kstat stat;
+
+	error = kern_path(pathname, LOOKUP_FOLLOW, &path);
+	if (error)
+		return error;
+
+	error = vfs_getattr(&path, &stat, STATX_TYPE, AT_STATX_SYNC_AS_STAT);
+	path_put(&path);
+	if (error)
+		return error;
+
+	if (!S_ISCHR(stat.mode))
+		return -EINVAL;
+
+	*ubi_num = ubi_major2num(MAJOR(stat.rdev));
+	*vol_id = MINOR(stat.rdev) - 1;
+
+	if (*vol_id < 0 || *ubi_num < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
 /**
  * ubi_open_volume_path - open UBI volume by its character device node path.
  * @pathname: volume character device node path
@@ -290,32 +325,17 @@ EXPORT_SYMBOL_GPL(ubi_open_volume_nm);
 struct ubi_volume_desc *ubi_open_volume_path(const char *pathname, int mode)
 {
 	int error, ubi_num, vol_id;
-	struct path path;
-	struct kstat stat;
 
 	dbg_gen("open volume %s, mode %d", pathname, mode);
 
 	if (!pathname || !*pathname)
 		return ERR_PTR(-EINVAL);
 
-	error = kern_path(pathname, LOOKUP_FOLLOW, &path);
-	if (error)
-		return ERR_PTR(error);
-
-	error = vfs_getattr(&path, &stat, STATX_TYPE, AT_STATX_SYNC_AS_STAT);
-	path_put(&path);
+	error = ubi_get_num_by_path(pathname, &ubi_num, &vol_id);
 	if (error)
 		return ERR_PTR(error);
 
-	if (!S_ISCHR(stat.mode))
-		return ERR_PTR(-EINVAL);
-
-	ubi_num = ubi_major2num(MAJOR(stat.rdev));
-	vol_id = MINOR(stat.rdev) - 1;
-
-	if (vol_id >= 0 && ubi_num >= 0)
-		return ubi_open_volume(ubi_num, vol_id, mode);
-	return ERR_PTR(-ENODEV);
+	return ubi_open_volume(ubi_num, vol_id, mode);
 }
 EXPORT_SYMBOL_GPL(ubi_open_volume_path);
 
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index a5ec566df0d74..17b463804c979 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -962,6 +962,7 @@ void ubi_free_internal_volumes(struct ubi_device *ubi);
 void ubi_do_get_device_info(struct ubi_device *ubi, struct ubi_device_info *di);
 void ubi_do_get_volume_info(struct ubi_device *ubi, struct ubi_volume *vol,
 			    struct ubi_volume_info *vi);
+int ubi_get_num_by_path(const char *pathname, int *ubi_num, int *vol_id);
 /* scan.c */
 int ubi_compare_lebs(struct ubi_device *ubi, const struct ubi_ainf_peb *aeb,
 		      int pnum, const struct ubi_vid_hdr *vid_hdr);
-- 
2.43.0

