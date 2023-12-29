Return-Path: <linux-kernel+bounces-13045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCA481FEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E1728484C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4C010A2B;
	Fri, 29 Dec 2023 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PdXYxk+0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7710A1A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86FE3E0005;
	Fri, 29 Dec 2023 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703845598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XMLKcnK90gOpD+J5rpO8cx0PRimbuDb4WQ7lFRnvvWg=;
	b=PdXYxk+04dB9yQzV/08jhNQFCbSSaETDsOMGnE9yLXZytoyFKC8bU7btQc9BznrgnRBvzV
	xYsfn0CKi3U9WE3N8mmdQIJghvvFMUr/iXLTru6f7BOZ3V2G1M5ElzQKuhLkiFBW35MA0c
	iUQgsfJrU6++TvvfWEiE9ltsIveLwadR1MBDeDj7V2ghI53nuDDZ0dhI3teQgSEr+GVdAg
	jVu4hNSq02swwxXvcHgUWwcxJkZw5ZlaFecTZTgitAFXSO3BitBZ3HiBFTFQjVWpRX4eRB
	SaMf4g/lwriZ2mQnIrkLrpyLDAtcottR0sET1SUABJMUa/VAwvM2UIEAqCf42g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 29 Dec 2023 11:26:26 +0100
Subject: [PATCH] nvmem: core: fix nvmem cells not being available in
 notifiers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231229-nvmem-cell-add-notification-v1-1-8d8b426be9f9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANGejmUC/x3MSwqAMAwA0atI1gY0Kn6uIi5qm2pAq7RFBPHuF
 pdvMfNAYC8cYMge8HxJkMMllHkGelVuYRSTDFRQVRL16K6dd9S8baiMQXdEsaJVTB1anrumbWu
 yhYJ0OD1buf/7OL3vB8p0cvptAAAA
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Walle <michael@walle.cc>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com

With current code, when an NVMEM notifier for NVMEM_CELL_ADD is called, the
cell is not accessible within the notifier call function.

This can be easily seen with a simple NVMEM notifier call doing:

    if (action == NVMEM_CELL_ADD)
        cell = nvmem_cell_get(hpm->dev, "id");

In this case nvmem_cell_get() always returns -EPROBE_DEFER if trying to get
the cell whose addition is being notified. Adding a long msleep() before
nvmem_cell_get() does not change the result. On the other hand,
nvmem_cell_get() works when invoked from a different code path not
involving the NVMEM event notifier.

The failing code path in my test case is:

 nvmem_cell_get()
 -> of_nvmem_cell_get()
    -> __nvmem_device_get()
       -> bus_find_device(); ---> returns NULL

The cause is in nvmem_register(), which adds the cells (via
nvmem_add_cells_from_fixed_layout() in my case) and in the process calls
the NVMEM_CELL_ADD notifiers _before_ calling device_add(&nvmem->dev), thus
before the nvmem device is added to the bus. This prevents
bus_find_device() from finding the device.

This makes the NVMEM_CELL_ADD notifier pretty useless, at least in the use
case where a consumer driver wants to read a cell when it becomes
available, without additional infrastructure to postpone the
nvmem_cell_get() call.

The easy solution would be moving the device_add() just before cell
addition instead of just after. This is exactly what the original
implementation was doing, but it had a race condition, which was fixed in
commit ab3428cfd9aa ("nvmem: core: fix registration vs use race") exactly
by swapping device_add() and cell addition.

Solve this problem by leaving cell addition before device_add() but moving
the notifications after. This would be pretty simple if all cells were
added by nvmem_register(), but cell layouts could run later if they are
built as modules, so they need to be allowed to notify when they add cells
after nvmem_register().

Solve this by adding a flag in struct nvmem_device to block all
notifications before calling device_add(), and keep track of whether each
cell got notified or not, so that exactly one notification is sent ber
cell.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/nvmem/core.c      | 35 +++++++++++++++++++++++++++++++++--
 drivers/nvmem/internals.h |  2 ++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ba559e81f77f..42f8edbfb39c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -36,6 +36,7 @@ struct nvmem_cell_entry {
 	struct device_node	*np;
 	struct nvmem_device	*nvmem;
 	struct list_head	node;
+	atomic_t		notified_add;
 };
 
 struct nvmem_cell {
@@ -520,9 +521,29 @@ static struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 
+/*
+ * Send cell add/remove notification unless it has been already sent.
+ *
+ * Uses and updates cell->notified_add to avoid duplicates.
+ *
+ * Must never be called with NVMEM_CELL_ADD after being called with
+ * NVMEM_CELL_REMOVE.
+ *
+ * @cell: the cell just added or going to be removed
+ * @event: NVMEM_CELL_ADD or NVMEM_CELL_REMOVE
+ */
+static void nvmem_cell_notify(struct nvmem_cell_entry *cell, unsigned long event)
+{
+	int new_notified = (event == NVMEM_CELL_ADD) ? 1 : 0;
+	int was_notified = atomic_xchg(&cell->notified_add, new_notified);
+
+	if (new_notified != was_notified)
+		blocking_notifier_call_chain(&nvmem_notifier, event, cell);
+}
+
 static void nvmem_cell_entry_drop(struct nvmem_cell_entry *cell)
 {
-	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
+	nvmem_cell_notify(cell, NVMEM_CELL_REMOVE);
 	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
 	mutex_unlock(&nvmem_mutex);
@@ -544,7 +565,9 @@ static void nvmem_cell_entry_add(struct nvmem_cell_entry *cell)
 	mutex_lock(&nvmem_mutex);
 	list_add_tail(&cell->node, &cell->nvmem->cells);
 	mutex_unlock(&nvmem_mutex);
-	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
+
+	if (cell->nvmem->do_notify_cell_add)
+		nvmem_cell_notify(cell, NVMEM_CELL_ADD);
 }
 
 static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
@@ -902,6 +925,7 @@ EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);
 struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 {
 	struct nvmem_device *nvmem;
+	struct nvmem_cell_entry *cell;
 	int rval;
 
 	if (!config->dev)
@@ -1033,6 +1057,13 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
+	/* After device_add() it is now OK to notify of new cells */
+	nvmem->do_notify_cell_add = true;
+
+	/* Notify about cells previously added but not notified */
+	list_for_each_entry(cell, &nvmem->cells, node)
+		nvmem_cell_notify(cell, NVMEM_CELL_ADD);
+
 	return nvmem;
 
 #ifdef CONFIG_NVMEM_SYSFS
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index 18fed57270e5..3dbaa8523530 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -33,6 +33,8 @@ struct nvmem_device {
 	struct nvmem_layout	*layout;
 	void *priv;
 	bool			sysfs_cells_populated;
+	/* Enable sending NVMEM_CELL_ADD notifications */
+	bool			do_notify_cell_add;
 };
 
 #if IS_ENABLED(CONFIG_OF)

---
base-commit: 399769c2014d2aa0463636d50f2bc6431b377331
change-id: 20231229-nvmem-cell-add-notification-feb857742f0a

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


