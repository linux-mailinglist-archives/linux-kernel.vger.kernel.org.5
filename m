Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5294379DA00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjILUWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:22:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96670E4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CFFCC433C7;
        Tue, 12 Sep 2023 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694550134;
        bh=SOwPjO8ogNZe+fryTz558cHWCx9nSaTQDFnAxRRRas0=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=W03PHTWwhHe3V4aWN62jOT7yQl7BK9ISkl7uzpxcpzEVadTZJ2YwhskOewMPnUq6R
         4qO0sCcGyJqPTg0hpkvoCmre63ZdfJAKzCdVgT+UIF+VFCcdyYN7i398PTDaZnfd6z
         bL0JxZ+c/psF8gRotiZaEyYj5gYlflfREeWADKsSXCqLI0J6nndmuVZOSCGtGVIc2l
         fz/YNXwuTPKyd0e3t5cAQ27NJp1aeXQaq0KAYqXUKdhU0fDCGrXpYKqsRdvhidJEGU
         MYNzSCmt0kTKBUaBJtG8NpKl1qCyr9Q/gU8O70inphRKNdrmG63avGK65YA6HfQsgH
         9DE+xnWVAo/WQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0D678EE3F29;
        Tue, 12 Sep 2023 20:22:14 +0000 (UTC)
From:   Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date:   Tue, 12 Sep 2023 22:22:05 +0200
Subject: [PATCH v2] drm/simpledrm: Add support for multiple "power-domains"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-simpledrm-multiple-power-domains-v2-1-01b66bfb1980@jannau.net>
X-B4-Tracking: v=1; b=H4sIAGzIAGUC/5WNQQ6CMBBFr0Jm7RiKiuDKexgWI53KGNqSFlBDu
 LuVG7j77y/eWyByEI5wyRYIPEsU7xIUuwzajtyDUXRiKPLikNcqxyh26FkHi3bqR0kbB//igNp
 bEhfRHBUbKknX9xaSZghs5L0lbk3iTuLow2crzur3/iGfFSo01VlVxKYtq9P1Sc7RtHc8QrOu6
 xfOQqoA0QAAAA==
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5966; i=j@jannau.net;
 h=from:subject:message-id; bh=++CkedQIUrBzc1lKOmCeLyAl+ixyBvXQdHhD4vxqutU=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhlSGEyW2vvVGhqHXdtQw/ft+hEn+Wkj+8ofiuf+sjt4/c
 Fhqs0RjRykLgxgHg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgInENjIytDEZlMmVBafybp6W
 1BI0q3cK665daUd9525OPHHLKk/3LsM/vQdvPjl9aL2Z5LTx6PtdN/fWVuj3yixwViiaqjNHpD6
 WAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: <j@jannau.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janne Grunau <j@jannau.net>

Multiple power domains need to be handled explicitly in each driver. The
driver core can not handle it automatically since it is not aware of
power sequencing requirements the hardware might have. This is not a
problem for simpledrm since everything is expected to be powered on by
the bootloader. simpledrm has just ensure it remains powered on during
its lifetime.
This is required on Apple silicon M2 and M2 Pro/Max/Ultra desktop
systems. The HDMI output initialized by the bootloader requires keeping
the display controller and a DP phy power domain on.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- removed broken drm_err() log statement only ment for debugging
- removed commented cast
- use correct format spcifier for 'int' in log statement
- add 'continue;' after failure to get device for power_domain
- use drm_warn() in non fatal error cases
- removed duplicate PTR_ERR conversion
- Link to v1: https://lore.kernel.org/r/20230910-simpledrm-multiple-power-domains-v1-1-f8718aefc685@jannau.net
---
 drivers/gpu/drm/tiny/simpledrm.c | 105 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index ff86ba1ae1b8..9c597461d1e2 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -6,6 +6,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_aperture.h>
@@ -227,6 +228,12 @@ struct simpledrm_device {
 	unsigned int regulator_count;
 	struct regulator **regulators;
 #endif
+	/* power-domains */
+#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
+	int pwr_dom_count;
+	struct device **pwr_dom_devs;
+	struct device_link **pwr_dom_links;
+#endif
 
 	/* simplefb settings */
 	struct drm_display_mode mode;
@@ -468,6 +475,101 @@ static int simpledrm_device_init_regulators(struct simpledrm_device *sdev)
 }
 #endif
 
+#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
+/*
+ * Generic power domain handling code.
+ *
+ * Here we handle the power-domains properties of our "simple-framebuffer"
+ * dt node. This is only necessary if there is more than one power-domain.
+ * A single power-domains is handled automatically by the driver core. Multiple
+ * power-domains have to be handled by drivers since the driver core can't know
+ * the correct power sequencing. Power sequencing is not an issue for simpledrm
+ * since the bootloader has put the power domains already in the correct state.
+ * simpledrm has only to ensure they remain active for its lifetime.
+ *
+ * When the driver unloads, we detach from the power-domains.
+ *
+ * We only complain about errors here, no action is taken as the most likely
+ * error can only happen due to a mismatch between the bootloader which set
+ * up the "simple-framebuffer" dt node, and the PM domain providers in the
+ * device tree. Chances are that there are no adverse effects, and if there are,
+ * a clean teardown of the fb probe will not help us much either. So just
+ * complain and carry on, and hope that the user actually gets a working fb at
+ * the end of things.
+ */
+static void simpledrm_device_detach_genpd(void *res)
+{
+	int i;
+	struct simpledrm_device *sdev = res;
+
+	if (sdev->pwr_dom_count <= 1)
+		return;
+
+	for (i = sdev->pwr_dom_count - 1; i >= 0; i--) {
+		if (!sdev->pwr_dom_links[i])
+			device_link_del(sdev->pwr_dom_links[i]);
+		if (!IS_ERR_OR_NULL(sdev->pwr_dom_devs[i]))
+			dev_pm_domain_detach(sdev->pwr_dom_devs[i], true);
+	}
+}
+
+static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
+{
+	struct device *dev = sdev->dev.dev;
+	int i;
+
+	sdev->pwr_dom_count = of_count_phandle_with_args(dev->of_node, "power-domains",
+							 "#power-domain-cells");
+	/*
+	 * Single power-domain devices are handled by driver core nothing to do
+	 * here. The same for device nodes without "power-domains" property.
+	 */
+	if (sdev->pwr_dom_count <= 1)
+		return 0;
+
+	sdev->pwr_dom_devs = devm_kcalloc(dev, sdev->pwr_dom_count,
+					       sizeof(*sdev->pwr_dom_devs),
+					       GFP_KERNEL);
+	if (!sdev->pwr_dom_devs)
+		return -ENOMEM;
+
+	sdev->pwr_dom_links = devm_kcalloc(dev, sdev->pwr_dom_count,
+						sizeof(*sdev->pwr_dom_links),
+						GFP_KERNEL);
+	if (!sdev->pwr_dom_links)
+		return -ENOMEM;
+
+	for (i = 0; i < sdev->pwr_dom_count; i++) {
+		sdev->pwr_dom_devs[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(sdev->pwr_dom_devs[i])) {
+			int ret = PTR_ERR(sdev->pwr_dom_devs[i]);
+			if (ret == -EPROBE_DEFER) {
+				simpledrm_device_detach_genpd(sdev);
+				return ret;
+			}
+			drm_warn(&sdev->dev,
+				 "pm_domain_attach_by_id(%u) failed: %d\n", i, ret);
+			continue;
+		}
+
+		sdev->pwr_dom_links[i] = device_link_add(dev,
+							 sdev->pwr_dom_devs[i],
+							 DL_FLAG_STATELESS |
+							 DL_FLAG_PM_RUNTIME |
+							 DL_FLAG_RPM_ACTIVE);
+		if (!sdev->pwr_dom_links[i])
+			drm_warn(&sdev->dev, "failed to link power-domain %d\n", i);
+	}
+
+	return devm_add_action_or_reset(dev, simpledrm_device_detach_genpd, sdev);
+}
+#else
+static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
+{
+	return 0;
+}
+#endif
+
 /*
  * Modesetting
  */
@@ -651,6 +753,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	if (ret)
 		return ERR_PTR(ret);
 	ret = simpledrm_device_init_regulators(sdev);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = simpledrm_device_attach_genpd(sdev);
 	if (ret)
 		return ERR_PTR(ret);
 

---
base-commit: 15d30b46573d75f5cb58cfacded8ebab9c76a2b0
change-id: 20230910-simpledrm-multiple-power-domains-f41efa6ad9bc

Best regards,
-- 
Janne Grunau <j@jannau.net>

