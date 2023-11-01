Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1B7DDE51
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjKAJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjKAJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:19:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EF0D79
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:19:07 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40B541BCF;
        Wed,  1 Nov 2023 10:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698830304;
        bh=3IFzGY8oeGtxO2wTPUesFMIUoPVmmi/6+htUtk+hmMU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bxicC3Jq2ObCiLXFkkxIaCrLYIoMnPswexqgEjg8SUjH7lVGl94HZEavlfrxBUsdZ
         wz8Cmze3bRQvAtn1SOknfy4OhnadRb9dbc8FGdnlMyEhjchlBsjsFpLPul5pL3qwbw
         aRhtwaOP8nv0k3xnjSiLc++WwwpNriZreTA3GOl8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 01 Nov 2023 11:17:46 +0200
Subject: [PATCH 09/10] drm/tidss: IRQ code cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-tidss-probe-v1-9-45149e0f9415@ideasonboard.com>
References: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
In-Reply-To: <20231101-tidss-probe-v1-0-45149e0f9415@ideasonboard.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3782;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3IFzGY8oeGtxO2wTPUesFMIUoPVmmi/6+htUtk+hmMU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlQhfosECtSzzwvEaTrWTML4kgj007cpTx8f/P/
 TAbV/DRdCuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUIX6AAKCRD6PaqMvJYe
 9YocD/9tLemVTGiztuTbwCBaz1BWvl38Jfz8WJagRPJmto7sGPyNo9UqO/uxA2zhR/Yjq89IAYJ
 XooT8GZcZZ27w3VffTDbh23HNCqbZeBssaosJffxqs9PzUEvedQHTyOHs5YUTNSBoUGtcE+GEel
 p5+EIBvsXiLM9Xy91k6T5Z0Im/X5BsL/VNdTQjPx50Sx8KTnNeJeM7b5cyQH8yflC19ubvi7mJy
 SYEvzQRcrqGNdYwlg3lpsCZcEeITXRtRiWtbNwp4spud3GlCOppzUf8UG6kpHg0/T0HNf33/FI5
 6UaBC0J7TVH2ieI7ESv27SXm5nnSqjkalnbyOD2iLWgkL60TI1dQfboUUlEuUOsCYDkbqnWonvQ
 kK1XgdplucnltZSGxq/+tN/etgxJUjAlu9u322dc5VT2h7uow6G33qzp0LWdt7MaB3iJYThW73l
 eY7OhelAM/1p/T7dcy4zE7ajHDCrJUXCuh7z/4kqdWtVHZMrkiPL7hiUpA10g8Hu2+ShJtjtGfo
 6mFt28u1GRH1LPFODkjOvIazVGUANFA2J6rHIkL3fYoFPvNPAtuqJefB546y5SDXPXZv9iEA4kh
 aLi5VYr09/Xmb2HOT9M4EosYph0kPv6N5rnWVkVm4X7oOYR2XVGvmeUJLU7zHdmgBeqdmPQVQjh
 3LMoGQ1pZh7u4vQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ setup code is overly complex. All we really need to do is
initialize the related fields in struct tidss_device, and request the
IRQ.

We can drop all the HW accesses, as they are pointless: the driver will
set the IRQs correctly when it needs any of the IRQs, and at probe time
we have done a reset, so we know that all the IRQs are masked by default
in the hardware.

Thus we can combine the tidss_irq_preinstall() and
tidss_irq_postinstall() into the tidss_irq_install() function, drop the
HW accesses, and drop the use of spinlock, as this is done at init time
and there can be no races.

We can also drop the HW access from the tidss_irq_uninstall(), as the
driver will anyway disable and suspend the hardware at remove time.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_drv.c |  2 ++
 drivers/gpu/drm/tidss/tidss_irq.c | 54 ++++++---------------------------------
 2 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 64914331715a..37693f30d98b 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -138,6 +138,8 @@ static int tidss_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, tidss);
 
+	spin_lock_init(&tidss->wait_lock);
+
 	ret = dispc_init(tidss);
 	if (ret) {
 		dev_err(dev, "failed to initialize dispc: %d\n", ret);
diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
index 0c681c7600bc..604334ef526a 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.c
+++ b/drivers/gpu/drm/tidss/tidss_irq.c
@@ -93,33 +93,21 @@ void tidss_irq_resume(struct tidss_device *tidss)
 	spin_unlock_irqrestore(&tidss->wait_lock, flags);
 }
 
-static void tidss_irq_preinstall(struct drm_device *ddev)
-{
-	struct tidss_device *tidss = to_tidss(ddev);
-
-	spin_lock_init(&tidss->wait_lock);
-
-	tidss_runtime_get(tidss);
-
-	dispc_set_irqenable(tidss->dispc, 0);
-	dispc_read_and_clear_irqstatus(tidss->dispc);
-
-	tidss_runtime_put(tidss);
-}
-
-static void tidss_irq_postinstall(struct drm_device *ddev)
+int tidss_irq_install(struct drm_device *ddev, unsigned int irq)
 {
 	struct tidss_device *tidss = to_tidss(ddev);
-	unsigned long flags;
-	unsigned int i;
+	int ret;
 
-	tidss_runtime_get(tidss);
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
 
-	spin_lock_irqsave(&tidss->wait_lock, flags);
+	ret = request_irq(irq, tidss_irq_handler, 0, ddev->driver->name, ddev);
+	if (ret)
+		return ret;
 
 	tidss->irq_mask = DSS_IRQ_DEVICE_OCP_ERR;
 
-	for (i = 0; i < tidss->num_crtcs; ++i) {
+	for (unsigned int i = 0; i < tidss->num_crtcs; ++i) {
 		struct tidss_crtc *tcrtc = to_tidss_crtc(tidss->crtcs[i]);
 
 		tidss->irq_mask |= DSS_IRQ_VP_SYNC_LOST(tcrtc->hw_videoport);
@@ -127,28 +115,6 @@ static void tidss_irq_postinstall(struct drm_device *ddev)
 		tidss->irq_mask |= DSS_IRQ_VP_FRAME_DONE(tcrtc->hw_videoport);
 	}
 
-	tidss_irq_update(tidss);
-
-	spin_unlock_irqrestore(&tidss->wait_lock, flags);
-
-	tidss_runtime_put(tidss);
-}
-
-int tidss_irq_install(struct drm_device *ddev, unsigned int irq)
-{
-	int ret;
-
-	if (irq == IRQ_NOTCONNECTED)
-		return -ENOTCONN;
-
-	tidss_irq_preinstall(ddev);
-
-	ret = request_irq(irq, tidss_irq_handler, 0, ddev->driver->name, ddev);
-	if (ret)
-		return ret;
-
-	tidss_irq_postinstall(ddev);
-
 	return 0;
 }
 
@@ -156,9 +122,5 @@ void tidss_irq_uninstall(struct drm_device *ddev)
 {
 	struct tidss_device *tidss = to_tidss(ddev);
 
-	tidss_runtime_get(tidss);
-	dispc_set_irqenable(tidss->dispc, 0);
-	tidss_runtime_put(tidss);
-
 	free_irq(tidss->irq, ddev);
 }

-- 
2.34.1

