Return-Path: <linux-kernel+bounces-139779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45048A079B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1381D1C23D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EC13C822;
	Thu, 11 Apr 2024 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="JTpXVoEq"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759713C806;
	Thu, 11 Apr 2024 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813059; cv=none; b=GfYDk625Ndlxmg6M2z9MSVOr8C23H+mjtKlOkyilAe+Djba9Ij1J3SETX6IRjuVyoh4cA+mnt5Kx+xN2zCb49XrrYTJyHAXJBOVrh/Fu+Zr4XEJpRbwq/oOnAZwE3e8nfcH2pR8mDy6mT81Q9BnHYeoXWij0fkgj4d9gp9UuKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813059; c=relaxed/simple;
	bh=WR9O76GumOlNTXVFrACeC491JghxmHVFac0PfnhnFCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXRR3HMJkvuWQesOKulyXaBEYgEXzpDqmeeZjDTjI79bYSPfpWcideWIe7j7zeVW9pwjsPriUZKkkIp/4ZFPFBq03Htu9b8TFy8bLhSkdcnD0wf6FoUQ5aln7hHff29V3Xkx3If+dV8VQXsj/+ieGwY5KD9BICgztkqEky2/Vzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=JTpXVoEq; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 52885603E6;
	Thu, 11 Apr 2024 05:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712813057;
	bh=WR9O76GumOlNTXVFrACeC491JghxmHVFac0PfnhnFCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTpXVoEqsH8CQVr3SccEkkw7fTI14yW5Fo3EQaut3+NiBmHZSfvbeNWmEog1CZAUR
	 AwLJjVItiVSzM5yxi1+wJkUiXubfiNv+fvFbW+XcrYcu5fAoFZtTDRbySpM4Sp/D/L
	 ZTYpoFgWEBtcckNiAQLSE5aF2coDkrcO1ARw9ow/rKzHFeT0AtvL6F2Zy+rczdE9Ml
	 /H4TD4mt5jY5XvUnK415zlkEQ/DyaOoChcUY8Bw1fatO5rtiRyOpmoVMAaswWIC7Vw
	 2vCZ8qTcxjEUedLu8A7c7uhI9mkHGG+pRCGQISIGOxtg0pXBVcK9iYWAjwQIU7eVtb
	 LocFKUlC8rPfg==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [RFC PATCH 3/4] bus: ti-sysc: Implement reset control framework for soft reset
Date: Thu, 11 Apr 2024 08:22:56 +0300
Message-ID: <20240411052257.2113-4-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411052257.2113-1-tony@atomide.com>
References: <20240411052257.2113-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can implement reset control framework for ti-sysc for the connected
devices to use for the interconnect target reset.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -25,6 +25,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/reset-controller.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
@@ -42,6 +43,7 @@
 
 #define SOC_FLAG(match, flag)	{ .machine = match, .data = (void *)(flag), }
 
+#define TI_SYSC_SOFTRESET_ID			0
 #define MAX_MODULE_SOFTRESET_WAIT		10000
 
 enum sysc_soc {
@@ -79,6 +81,11 @@ struct sysc_soc_info {
 	struct notifier_block nb;
 };
 
+struct sysc_reset_lookup {
+	struct list_head node;
+	struct reset_control_lookup lookup;
+};
+
 enum sysc_clocks {
 	SYSC_FCK,
 	SYSC_ICK,
@@ -147,6 +154,9 @@ struct sysc {
 	const char **clock_roles;
 	int nr_clocks;
 	struct reset_control *rsts;
+	struct reset_controller_dev rcdev;
+	struct list_head child_resets;
+	struct mutex child_lock; /* child device data list lock */
 	const char *legacy_mode;
 	const struct sysc_capabilities *cap;
 	struct sysc_config cfg;
@@ -2194,6 +2204,46 @@ static int sysc_reset(struct sysc *ddata)
 	return error;
 }
 
+/*
+ * Only handles the softreset for the interconnect target, does not consider
+ * the device specific external resets. We must ensure the interconnect target
+ * is runtime PM active for the reset. And we must restore the sysconfig
+ * register after reset. Locking is currently not needed as we only touch the
+ * sysconfig register on PM runtime state changes, and no other sysconfig
+ * register access happens when the interconnect target is runtime PM active.
+ * Interconnect targets with multiple children must coordinate the reset
+ * usage with reset_control_get_shared().
+ */
+static int ti_sysc_reset_control_reset(struct reset_controller_dev *rcdev,
+				       unsigned long id)
+{
+	struct sysc *ddata;
+	int error;
+
+	if (id != TI_SYSC_SOFTRESET_ID)
+		return -EINVAL;
+
+	ddata = container_of(rcdev, struct sysc, rcdev);
+
+	error = pm_runtime_resume_and_get(ddata->dev);
+	if (error < 0)
+		return error;
+
+	error = sysc_reset(ddata);
+	if (error)
+		dev_warn(ddata->dev, "reset failed: %i\n", error);
+
+	sysc_write_sysconfig(ddata, ddata->sysconfig);
+
+	pm_runtime_put_sync(ddata->dev);
+
+	return error;
+}
+
+static const struct reset_control_ops ti_sysc_reset_ops = {
+	.reset = ti_sysc_reset_control_reset,
+};
+
 /*
  * At this point the module is configured enough to read the revision but
  * module may not be completely configured yet to use PM runtime. Enable
@@ -2408,6 +2458,45 @@ static int sysc_child_add_clocks(struct sysc *ddata,
 	return 0;
 }
 
+static int sysc_child_add_reset(struct sysc *ddata,
+				struct device *child)
+{
+	struct sysc_reset_lookup *srl;
+
+	srl = kzalloc(sizeof(*srl), GFP_KERNEL);
+	if (!srl)
+		return -ENOMEM;
+
+	srl->lookup.provider = dev_name(ddata->dev);
+	srl->lookup.index = TI_SYSC_SOFTRESET_ID;
+	srl->lookup.dev_id = dev_name(child);
+	srl->lookup.con_id = "softreset";
+	reset_controller_add_lookup(&srl->lookup, 1);
+	mutex_lock(&ddata->child_lock);
+	list_add(&srl->node, &ddata->child_resets);
+	mutex_unlock(&ddata->child_lock);
+
+	return 0;
+}
+
+static void sysc_child_remove_reset(struct sysc *ddata,
+				    struct device *child)
+{
+	struct sysc_reset_lookup *srl;
+
+	mutex_lock(&ddata->child_lock);
+	list_for_each_entry(srl, &ddata->child_resets, node) {
+		if (srl->lookup.index == TI_SYSC_SOFTRESET_ID &&
+		    !strcmp(dev_name(child), srl->lookup.dev_id)) {
+			reset_controller_remove_lookup(&srl->lookup, 1);
+			list_del(&srl->node);
+			kfree(srl);
+			break;
+		}
+	}
+	mutex_unlock(&ddata->child_lock);
+}
+
 static const struct device_type sysc_device_type = {
 };
 
@@ -2541,6 +2630,14 @@ static int sysc_notifier_call(struct notifier_block *nb,
 		error = sysc_child_add_clocks(ddata, dev);
 		if (error)
 			return error;
+
+		error = sysc_child_add_reset(ddata, dev);
+		if (error)
+			return error;
+
+		break;
+	case BUS_NOTIFY_REMOVED_DEVICE:
+		sysc_child_remove_reset(ddata, dev);
 		break;
 	default:
 		break;
@@ -3186,6 +3283,8 @@ static int sysc_probe(struct platform_device *pdev)
 	ddata->offsets[SYSC_SYSCONFIG] = -ENODEV;
 	ddata->offsets[SYSC_SYSSTATUS] = -ENODEV;
 	ddata->dev = &pdev->dev;
+	mutex_init(&ddata->child_lock);
+	INIT_LIST_HEAD(&ddata->child_resets);
 	platform_set_drvdata(pdev, ddata);
 
 	error = sysc_init_static_data(ddata);
@@ -3266,6 +3365,16 @@ static int sysc_probe(struct platform_device *pdev)
 
 	ddata->dev->type = &sysc_device_type;
 
+	ddata->rcdev.owner = THIS_MODULE;
+	ddata->rcdev.nr_resets = 1;
+	ddata->rcdev.ops = &ti_sysc_reset_ops;
+	ddata->rcdev.dev = &pdev->dev;
+	ddata->rcdev.of_node = ddata->dev->of_node;
+
+	error = devm_reset_controller_register(ddata->dev, &ddata->rcdev);
+	if (error)
+		goto err;
+
 	if (!ddata->reserved) {
 		error = of_platform_populate(ddata->dev->of_node,
 					     sysc_match_table,
-- 
2.44.0

