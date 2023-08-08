Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C210774122
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHHRPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjHHROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:14:22 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B626BD3E;
        Tue,  8 Aug 2023 09:06:01 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qTPD4-0007bf-1p;
        Tue, 08 Aug 2023 16:05:26 +0000
Date:   Tue, 8 Aug 2023 17:05:18 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] mtd: ubi: populate ubi volume fwnode
Message-ID: <eca0fc4ec44cfb5e4392474a9b225ebdc868f9b6.1691510312.git.daniel@makrotopia.org>
References: <cover.1691510312.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691510312.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mtd/ubi/vmt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index eed4b57c61bda..ee756a00a370b 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -124,6 +124,31 @@ static void vol_release(struct device *dev)
 	kfree(vol);
 }
 
+static struct fwnode_handle *find_volume_fwnode(struct ubi_volume *vol)
+{
+	struct fwnode_handle *fw_vols, *fw_vol;
+	const char *volname;
+	u32 volid;
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
+		if (!fwnode_property_read_u32(fw_vol, "volid", &volid) &&
+		    vol->vol_id != volid)
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
@@ -223,6 +248,7 @@ int ubi_create_volume(struct ubi_device *ubi, struct ubi_mkvol_req *req)
 	vol->name_len  = req->name_len;
 	memcpy(vol->name, req->name, vol->name_len);
 	vol->ubi = ubi;
+	device_set_node(&vol->dev, find_volume_fwnode(vol));
 
 	/*
 	 * Finish all pending erases because there may be some LEBs belonging
@@ -597,6 +623,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
 	vol->dev.class = &ubi_class;
 	vol->dev.groups = volume_dev_groups;
 	dev_set_name(&vol->dev, "%s_%d", ubi->ubi_name, vol->vol_id);
+	device_set_node(&vol->dev, find_volume_fwnode(vol));
 	err = device_register(&vol->dev);
 	if (err) {
 		cdev_del(&vol->cdev);
-- 
2.41.0
