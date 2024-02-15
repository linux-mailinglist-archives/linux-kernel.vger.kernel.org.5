Return-Path: <linux-kernel+bounces-67685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE04856F24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BDD1C2241B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47513B798;
	Thu, 15 Feb 2024 21:14:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2B132461
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031657; cv=none; b=VccMJpe60yCfpkpNEphBxxGSishxt2gLF16YN4I3RH+A+RXPND1A0hr5saV56C6bEmALCIO3zy9T6E34hxkG0BADS14bo2WHdWrJfL3T/tYAClh7ME9q7ykzJw90/D0JqmXUd2AxYiHqIWTcHEaHOSM+iVthaK3CmVWsdTlbbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031657; c=relaxed/simple;
	bh=XVy3hOobm6zUM/uUVP4IVcxxMoT0bKOg5SLpDVCDiZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/EJwnXo2dZAO9cUSx+TK22RYj5DS85FjpzBC6r1os6huJv7wllWXUYmk8dnvceWAoaff8Jyb3PBvLIBSZtno2DdOFe5QqbHm+hfAM/J9GufmTO3hUBFO1XlIZ7T42wXORIRu84tupwxzRSRTXh/aB0lyRs0E51D38CRUVSIxTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1raj3W-0001Cg-Ff; Thu, 15 Feb 2024 22:14:06 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: srinivas.kandagatla@linaro.org,
	gregkh@linuxfoundation.org,
	miquel.raynal@bootlin.com,
	michael@walle.cc,
	rafal@milecki.pl
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [RFC PATCH] nvmem: core: add sysfs cell write support
Date: Thu, 15 Feb 2024 22:14:01 +0100
Message-Id: <20240215211401.1201004-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the sysfs cell write support to make it possible to write to exposed
cells from sysfs as well e.g. for device provisioning.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Hi,

the purpose of this patch is to make the NVMEM cells exposed via the
testing ABI sysfs writeable, to allow changes during devie life-time.

Regards,
  Marco

 drivers/nvmem/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 980123fb4dde..5a497188cfea 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -336,6 +336,40 @@ static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
 	return read_len;
 }
 
+static ssize_t nvmem_cell_attr_write(struct file *filp, struct kobject *kobj,
+				     struct bin_attribute *attr, char *buf,
+				     loff_t pos, size_t count)
+{
+	struct nvmem_cell_entry *entry;
+	struct nvmem_cell *cell;
+	int ret;
+
+	entry = attr->private;
+
+	if (!entry->nvmem->reg_write)
+		return -EPERM;
+
+	if (pos >= entry->bytes)
+		return -EFBIG;
+
+	if (pos + count > entry->bytes)
+		count = entry->bytes - pos;
+
+	cell = nvmem_create_cell(entry, entry->name, 0);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	if (!cell)
+		return -EINVAL;
+
+	ret = nvmem_cell_write(cell, buf, count);
+
+	kfree_const(cell->id);
+	kfree(cell);
+
+	return ret;
+}
+
 /* default read/write permissions */
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
@@ -432,6 +466,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 	struct bin_attribute **cells_attrs, *attrs;
 	struct nvmem_cell_entry *entry;
 	unsigned int ncells = 0, i = 0;
+	umode_t mode;
 	int ret = 0;
 
 	mutex_lock(&nvmem_mutex);
@@ -456,15 +491,18 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 		goto unlock_mutex;
 	}
 
+	mode = nvmem_bin_attr_get_umode(nvmem);
+
 	/* Initialize each attribute to take the name and size of the cell */
 	list_for_each_entry(entry, &nvmem->cells, node) {
 		sysfs_bin_attr_init(&attrs[i]);
 		attrs[i].attr.name = devm_kasprintf(&nvmem->dev, GFP_KERNEL,
 						    "%s@%x", entry->name,
 						    entry->offset);
-		attrs[i].attr.mode = 0444;
+		attrs[i].attr.mode = mode;
 		attrs[i].size = entry->bytes;
 		attrs[i].read = &nvmem_cell_attr_read;
+		attrs[i].write = &nvmem_cell_attr_write;
 		attrs[i].private = entry;
 		if (!attrs[i].attr.name) {
 			ret = -ENOMEM;
-- 
2.39.2


