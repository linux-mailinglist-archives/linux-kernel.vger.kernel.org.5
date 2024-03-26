Return-Path: <linux-kernel+bounces-120069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C988D125
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B20B25365
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF5913E419;
	Tue, 26 Mar 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HOrp+wOs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8C13E021;
	Tue, 26 Mar 2024 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492664; cv=none; b=bNjOxtmxYGpjGVERCWhXQjlXAS315wmReyi8YlzQNzWVm6Fap8c53MhDgOrBscVPmgB65fvZEnnc9SyxJvf53EzIP3uFGF22CY2umaG7vKSXL7pEXyVR6mUUwur6OYee6FV2DqRlKw+RJm0St74PnFsRRfnHLbKiz5MBKYaLYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492664; c=relaxed/simple;
	bh=KfCKmYHywoKaCHHGNRiQeIrXMDQOxpWG74uFDT0bwKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaL0cZSVMJs+eXfEj1DmF/pIv2yf0BCG2cP7Wi9Whvojv/9r8ivPNzYl2AAVLOSeXB8FBhk0kEbrkSELX4e5NJXubP+VU7f1xrWwp/CCgL1kosow9RAk+nm0CeqpLokmIoLQ3Zlc58r6LGpdKAjSrqwynPdBiPj3aXZKVHas3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HOrp+wOs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbWGd122550;
	Tue, 26 Mar 2024 17:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711492652;
	bh=Lgm+zMk+iBG2wv4BvI+8VRJEkQ6t3xqJUb4WT18clKA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HOrp+wOsLao8NEe7IbHVfN5R8WnWUCQsZsgd3hFkv1JFOgKqx0z+MxdTmkIItXluo
	 0U8XqFSbkjhfVBXkqUtZ0aH7XoejlWrUDJUZTM7EQbq2FNn59jdf72ELB4CJhx46Id
	 0t38enLoiVxe7UNlbyAu8/zIKk+Vm9feTij/2XHU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QMbWiL106451
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 17:37:32 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 17:37:31 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 17:37:31 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbVmY109669;
	Tue, 26 Mar 2024 17:37:31 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/4] firmware: ti_sci: Use devm_register_restart_handler()
Date: Tue, 26 Mar 2024 17:37:27 -0500
Message-ID: <20240326223730.54639-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223730.54639-1-afd@ti.com>
References: <20240326223730.54639-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/firmware/ti_sci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8b9a2556de16d..9885e1763591b 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -87,7 +87,6 @@ struct ti_sci_desc {
  * struct ti_sci_info - Structure representing a TI SCI instance
  * @dev:	Device pointer
  * @desc:	SoC description for this instance
- * @nb:	Reboot Notifier block
  * @d:		Debugfs file entry
  * @debug_region: Memory region where the debug message are available
  * @debug_region_size: Debug region size
@@ -103,7 +102,6 @@ struct ti_sci_desc {
  */
 struct ti_sci_info {
 	struct device *dev;
-	struct notifier_block nb;
 	const struct ti_sci_desc *desc;
 	struct dentry *d;
 	void __iomem *debug_region;
@@ -122,7 +120,6 @@ struct ti_sci_info {
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
 #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
-#define reboot_to_ti_sci_info(n) container_of(n, struct ti_sci_info, nb)
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -3254,10 +3251,9 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
 
-static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
-				void *cmd)
+static int tisci_reboot_handler(struct sys_off_data *data)
 {
-	struct ti_sci_info *info = reboot_to_ti_sci_info(nb);
+	struct ti_sci_info *info = data->cb_data;
 	const struct ti_sci_handle *handle = &info->handle;
 
 	ti_sci_cmd_core_reboot(handle);
@@ -3400,10 +3396,9 @@ static int ti_sci_probe(struct platform_device *pdev)
 	ti_sci_setup_ops(info);
 
 	if (reboot) {
-		info->nb.notifier_call = tisci_reboot_handler;
-		info->nb.priority = 128;
-
-		ret = register_restart_handler(&info->nb);
+		ret = devm_register_restart_handler(dev,
+						    tisci_reboot_handler,
+						    info);
 		if (ret) {
 			dev_err(dev, "reboot registration fail(%d)\n", ret);
 			goto out;
-- 
2.39.2


