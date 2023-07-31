Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F076A0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjGaTOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGaTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:14:02 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10555184
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:14:02 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qQYL8-0001iX-2t;
        Mon, 31 Jul 2023 19:14:00 +0000
Date:   Mon, 31 Jul 2023 20:13:47 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 5/6] mtd: ubi: populate ubi volume fwnode
Message-ID: <3efb1ac62048dd6818688737e22cdaabb9f65ce3.1690823629.git.daniel@makrotopia.org>
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

Look for the 'volumes' subnode of an MTD partition attached to a UBI
device and attach matching child nodes to UBI volumes.
This allows UBI volumes to be referenced in device tree, e.g. for use
as NVMEM providers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/vmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index eed4b57c61bda..3b997256cfba7 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -124,6 +124,35 @@ static void vol_release(struct device *dev)
 	kfree(vol);
 }
 
+static struct fwnode_handle *find_volume_fwnode(struct ubi_volume *vol)
+{
+	struct fwnode_handle *fw_vols, *fw_vol;
+	const char *volname;
+	u32 reg;
+
+	fw_vols = device_get_named_child_node(vol->dev.parent->parent, "volumes");
+	if (!fw_vols)
+		return NULL;
+
+	fwnode_for_each_child_node(fw_vols, fw_vol) {
+		if (!fwnode_property_read_string(fw_vol, "volname", &volname) &&
+		    strncmp(volname, vol->name, vol->name_len))
+			continue;
+
+		/*
+		 * volume id (reg) in device tree greater than UBI_MAX_VOLUMES
+		 * can be used to match by volname only
+		 */
+		if (!fwnode_property_read_u32(fw_vol, "reg", &reg) &&
+		    reg < UBI_MAX_VOLUMES && vol->vol_id != reg)
+			continue;
+
+		return fw_vol;
+	}
+
+	return NULL;
+}
+
 /**
  * ubi_create_volume - create volume.
  * @ubi: UBI device description object
@@ -223,6 +252,7 @@ int ubi_create_volume(struct ubi_device *ubi, struct ubi_mkvol_req *req)
 	vol->name_len  = req->name_len;
 	memcpy(vol->name, req->name, vol->name_len);
 	vol->ubi = ubi;
+	device_set_node(&vol->dev, find_volume_fwnode(vol));
 
 	/*
 	 * Finish all pending erases because there may be some LEBs belonging
@@ -597,6 +627,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
 	vol->dev.class = &ubi_class;
 	vol->dev.groups = volume_dev_groups;
 	dev_set_name(&vol->dev, "%s_%d", ubi->ubi_name, vol->vol_id);
+	device_set_node(&vol->dev, find_volume_fwnode(vol));
 	err = device_register(&vol->dev);
 	if (err) {
 		cdev_del(&vol->cdev);
-- 
2.41.0
