Return-Path: <linux-kernel+bounces-78629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA2861615
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7412D28211E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925882879;
	Fri, 23 Feb 2024 15:41:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35682863
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702898; cv=none; b=s6F3useJEOKH1FavtJxqox++x7z1T0ASTVGU5tAQrRxp8tMGE63aoTJYvFejgWlVw0ze8fzLKaVsOCrkYy/6oAscSAjYpSOqiRVl0Y5nvOEMcBqChCjCtAQ5RXHq+LK7VVabJcS0SKpPAwIq4Zs7InaYZ+tALZjxaR7Q4P9SWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702898; c=relaxed/simple;
	bh=ISOpelRzcKba5NgCuFuc5tbG/MHEVgcIyOM8/9vVlnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNue3PkZ656iYfLz4VJkCEbiV9ZM4/HbMkpKFvPkoHepTarcsTWhsbpUG1tf00jN5QRgltTjHmksFplf7jZq2ol9uF7VR5OOofqHZsPZdLUudU5ybGAP+HCveBiwyqG+UioyQZHnpj3aA6tDSjE6cz1t77Htvylgd7GZWs9uIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1rdXg3-0001um-4d; Fri, 23 Feb 2024 16:41:31 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: srinivas.kandagatla@linaro.org,
	miquel.raynal@bootlin.com,
	michael@walle.cc
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] nvmem: core: add sysfs cell write support
Date: Fri, 23 Feb 2024 16:41:29 +0100
Message-Id: <20240223154129.1902905-1-m.felsch@pengutronix.de>
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
cells from sysfs as well e.g. for device provisioning. The write support
is limited to EEPROM based nvmem devices and to nvmem-cells which don't
require post-processing.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/nvmem/core.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 980123fb4dde..b1f86cb431ef 100644
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
@@ -458,13 +492,20 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	/* Initialize each attribute to take the name and size of the cell */
 	list_for_each_entry(entry, &nvmem->cells, node) {
+		umode_t mode = nvmem_bin_attr_get_umode(nvmem);
+
+		/* Limit cell-write support to EEPROMs at the moment */
+		if (entry->read_post_process || nvmem->type != NVMEM_TYPE_EEPROM)
+			mode &= ~0222;
+
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


