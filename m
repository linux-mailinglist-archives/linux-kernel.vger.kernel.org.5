Return-Path: <linux-kernel+bounces-80360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C4866757
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A251F21432
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79114267;
	Mon, 26 Feb 2024 00:23:42 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5856B46AF;
	Mon, 26 Feb 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708907021; cv=none; b=BiRujBbk24qc5TLmhmOXgdgajXqa7qFNc0mcO1vznTydQWFWqYZ4sWo845cxa5LzELjrHqsSgsX4FI+z3TBvOQJcfVDhhXNmHYqmZxdoT6kCTiO6SuVzGvvfaSxxoSU82nG1AN+eEP13f6FcQgwdlEvy9l2RIAUryW6qDuFsLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708907021; c=relaxed/simple;
	bh=8ZN/uqPCf9gZGtjw4nLeVdgvb5J82r/tQ0SJ2C+AHBE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpxMTZvB/K9WfWB9w0o2dOXuWzSWbBVta5zoqRX4Sfmf+Tcn7/mb6cSIDsKTEfBjrJnQbJx8PPJHTKGyJMkdpzuuap77oCBcVkFZ+Yn5dXuODNO7T6P46SIAB2u3po7iCXMGiGxhSjrxYS3sdR1FlTNUwJC7LRW+UA2YDEUQbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1reOmM-0001qF-1C;
	Mon, 26 Feb 2024 00:23:34 +0000
Date: Mon, 26 Feb 2024 00:23:31 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/7] mtd: ubi: populate ubi volume fwnode
Message-ID: <8097c9d13f92b51145ed747610de0bc9ad26d079.1708906456.git.daniel@makrotopia.org>
References: <cover.1708906456.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708906456.git.daniel@makrotopia.org>

Look for the 'volumes' subnode of an MTD partition attached to a UBI
device and attach matching child nodes to UBI volumes.
This allows UBI volumes to be referenced in device tree, e.g. for use
as NVMEM providers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/vmt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index ee80c04d1d5d0..7824ff069bd62 100644
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
@@ -605,6 +631,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
 	vol->dev.class = &ubi_class;
 	vol->dev.groups = volume_dev_groups;
 	dev_set_name(&vol->dev, "%s_%d", ubi->ubi_name, vol->vol_id);
+	device_set_node(&vol->dev, find_volume_fwnode(vol));
 	err = device_register(&vol->dev);
 	if (err) {
 		cdev_del(&vol->cdev);
-- 
2.44.0

