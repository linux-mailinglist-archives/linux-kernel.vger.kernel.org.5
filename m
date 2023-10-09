Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABA7BD4A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbjJIHux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjJIHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:50:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193794
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 00:50:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3997oKU9105316;
        Mon, 9 Oct 2023 02:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696837820;
        bh=hMhNhiQXIqGgkhXjrKdWywjOqrAnsFm8Fb6SqEbSumo=;
        h=From:To:CC:Subject:Date;
        b=V+zpjydLJUEB+8gWr7uWNdNyjZzRIHxJSsvsVC9v4efGhsveFmQUXxtwcXdkPlJRq
         J8bwQfROhUEb75G3JUhRt0BRLeRlKKITrTahD5XBRj+SRUAfLX6Koi7zzfdlja8yOc
         /GBvgbdAcVS7DPUB26GdTeq1pnNoh9UgXKckJ8ec=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3997oKqa093936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Oct 2023 02:50:20 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Oct 2023 02:50:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Oct 2023 02:50:20 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3997oJ5K031125;
        Mon, 9 Oct 2023 02:50:19 -0500
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <r-ravikumar@ti.com>,
        <j-choudhary@ti.com>, <devarsht@ti.com>
Subject: [PATCH] drm/tidss: Power up attached PM domains on probe
Date:   Mon, 9 Oct 2023 13:20:18 +0530
Message-ID: <20231009075018.2836020-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoC's such as AM62P have dedicated power domains
for OLDI which need to be powered on separetely along
with display controller.

So during driver probe, power up all attached PM domains
enumerated in devicetree node for DSS.

This also prepares base to add display support for AM62P.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 76 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_drv.h |  5 ++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 4d063eb9cd0b..a703a27d17bf 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -8,6 +8,7 @@
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -114,6 +115,72 @@ static const struct drm_driver tidss_driver = {
 	.minor			= 0,
 };
 
+static int tidss_detach_pm_domains(struct tidss_device *tidss)
+{
+	int i;
+
+	if (tidss->num_domains <= 1)
+		return 0;
+
+	for (i = 0; i < tidss->num_domains; i++) {
+		if (tidss->pd_link[i] && !IS_ERR(tidss->pd_link[i]))
+			device_link_del(tidss->pd_link[i]);
+		if (tidss->pd_dev[i] && !IS_ERR(tidss->pd_dev[i]))
+			dev_pm_domain_detach(tidss->pd_dev[i], true);
+		tidss->pd_dev[i] = NULL;
+		tidss->pd_link[i] = NULL;
+	}
+
+	return 0;
+}
+
+static int tidss_attach_pm_domains(struct tidss_device *tidss)
+{
+	struct device *dev = tidss->dev;
+	int i;
+	int ret;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = pdev->dev.of_node;
+
+	tidss->num_domains = of_count_phandle_with_args(np, "power-domains",
+							"#power-domain-cells");
+	if (tidss->num_domains <= 1) {
+		dev_dbg(dev, "One or less power domains, no need to do attach domains\n");
+		return 0;
+	}
+
+	tidss->pd_dev = devm_kmalloc_array(dev, tidss->num_domains,
+					   sizeof(*tidss->pd_dev), GFP_KERNEL);
+	if (!tidss->pd_dev)
+		return -ENOMEM;
+
+	tidss->pd_link = devm_kmalloc_array(dev, tidss->num_domains,
+					    sizeof(*tidss->pd_link), GFP_KERNEL);
+	if (!tidss->pd_link)
+		return -ENOMEM;
+
+	for (i = 0; i < tidss->num_domains; i++) {
+		tidss->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(tidss->pd_dev[i])) {
+			ret = PTR_ERR(tidss->pd_dev[i]);
+			goto fail;
+		}
+
+		tidss->pd_link[i] = device_link_add(dev, tidss->pd_dev[i],
+						    DL_FLAG_STATELESS |
+						    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
+		if (!tidss->pd_link[i]) {
+			ret = -EINVAL;
+			goto fail;
+		}
+	}
+
+	return 0;
+fail:
+	tidss_detach_pm_domains(tidss);
+	return ret;
+}
+
 static int tidss_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -136,6 +203,13 @@ static int tidss_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tidss);
 
+	/* powering up associated OLDI domains */
+	ret = tidss_attach_pm_domains(tidss);
+	if (ret < 0) {
+		dev_err(dev, "failed to attach power domains %d\n", ret);
+		return ret;
+	}
+
 	ret = dispc_init(tidss);
 	if (ret) {
 		dev_err(dev, "failed to initialize dispc: %d\n", ret);
@@ -193,6 +267,7 @@ static int tidss_probe(struct platform_device *pdev)
 	dispc_runtime_suspend(tidss->dispc);
 #endif
 	pm_runtime_disable(dev);
+	tidss_detach_pm_domains(tidss);
 
 	return ret;
 }
@@ -220,6 +295,7 @@ static void tidss_remove(struct platform_device *pdev)
 	/* devm allocated dispc goes away with the dev so mark it NULL */
 	dispc_remove(tidss);
 
+	tidss_detach_pm_domains(tidss);
 	dev_dbg(dev, "%s done\n", __func__);
 }
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.h b/drivers/gpu/drm/tidss/tidss_drv.h
index d7f27b0b0315..3c8b37b3aba6 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.h
+++ b/drivers/gpu/drm/tidss/tidss_drv.h
@@ -31,6 +31,11 @@ struct tidss_device {
 
 	spinlock_t wait_lock;	/* protects the irq masks */
 	dispc_irq_t irq_mask;	/* enabled irqs in addition to wait_list */
+
+	int num_domains; /* Handle attached PM domains */
+	struct device **pd_dev;
+	struct device_link **pd_link;
+
 };
 
 #define to_tidss(__dev) container_of(__dev, struct tidss_device, ddev)
-- 
2.34.1

