Return-Path: <linux-kernel+bounces-92956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89110872896
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0471C22241
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FE412D1E1;
	Tue,  5 Mar 2024 20:24:10 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD421272CC;
	Tue,  5 Mar 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670250; cv=none; b=TS4Yx3jb7wlZeNweop2d/sO4acxbTRXLP+y7t0d2AV0AKES6HxSeNxWst5h2MlCe7x+dLx9KEITwhpeucntOz3kUzvP232bF1iWDLVvnOyiP5RhASNRheY+sVz9AKSEMPqPJYfFQs7XqimHYQZhbPmw6IEF3ROIMw+D7w9ARH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670250; c=relaxed/simple;
	bh=B7sCKtL9SO97ATHX5/GObMMyjqJrNuWBY8nTqV2huAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azUH4cMxAjeHF2gFcM0IxjBCwR7U2ARb1F2TX34Hc3AlKa14UbQynm5z7t525Nol51DfJUWbsCv8d+dB1E4NdpbQO4MMMkFpju9UL4iiXz7M6Im3HrU2NLYBACD7LTiPZSHo/J2cMt7wegz0ItASjuG37d1UOGLoOibn9jCvDwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rhbK5-0001MZ-0F;
	Tue, 05 Mar 2024 20:23:37 +0000
Date: Tue, 5 Mar 2024 20:23:32 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
	Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Cc: Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: [RFC PATCH v2 2/8] block: partitions: populate fwnode
Message-ID: <feaffcb7461718d76070d98406aab2298da1bbe3.1709667858.git.daniel@makrotopia.org>
References: <cover.1709667858.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709667858.git.daniel@makrotopia.org>

Let block partitions to be represented by a firmware node and hence
allow them to being referenced e.g. for use with blk-nvmem.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/core.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5f5ed5c75f04d..48d7f01d76c6a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,8 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
+#include <linux/property.h>
+
 #include "check.h"
 
 static int (*const check_part[])(struct parsed_partitions *) = {
@@ -281,6 +283,43 @@ static ssize_t whole_disk_show(struct device *dev,
 }
 static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
 
+static struct fwnode_handle *find_partition_fwnode(struct block_device *bdev)
+{
+	struct fwnode_handle *fw_parts, *fw_part;
+	struct device *ddev = disk_to_dev(bdev->bd_disk);
+	const char *partname, *uuid;
+	u32 partno;
+
+	fw_parts = device_get_named_child_node(ddev, "partitions");
+	if (!fw_parts)
+		fw_parts = device_get_named_child_node(ddev->parent, "partitions");
+
+	if (!fw_parts)
+		return NULL;
+
+	fwnode_for_each_child_node(fw_parts, fw_part) {
+		if (!fwnode_property_read_string(fw_part, "uuid", &uuid) &&
+		    (!bdev->bd_meta_info || strncmp(uuid,
+						    bdev->bd_meta_info->uuid,
+						    PARTITION_META_INFO_UUIDLTH)))
+			continue;
+
+		if (!fwnode_property_read_string(fw_part, "partname", &partname) &&
+		    (!bdev->bd_meta_info || strncmp(partname,
+						    bdev->bd_meta_info->volname,
+						    PARTITION_META_INFO_VOLNAMELTH)))
+			continue;
+
+		if (!fwnode_property_read_u32(fw_part, "partno", &partno) &&
+		    bdev->bd_partno != partno)
+			continue;
+
+		return fw_part;
+	}
+
+	return NULL;
+}
+
 /*
  * Must be called either with open_mutex held, before a disk can be opened or
  * after all disk users are gone.
@@ -355,6 +394,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 			goto out_put;
 	}
 
+	device_set_node(pdev, find_partition_fwnode(bdev));
+
 	/* delay uevent until 'holders' subdir is created */
 	dev_set_uevent_suppress(pdev, 1);
 	err = device_add(pdev);
-- 
2.44.0

