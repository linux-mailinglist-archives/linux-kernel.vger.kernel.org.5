Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E577DDE50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjKAJT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjKAJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:19:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BAD4B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:19:03 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73F1F1BB1;
        Wed,  1 Nov 2023 10:18:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698830304;
        bh=XebHXvtm9Gfpkkb4vxBLxt9Z+vX/euBnejSOchv4oXo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=N4Lf32+MT3uYNIlocIzcnORczhVJRTG3EGbyQNJkYJ+uIw4qQIRTY1ccLlYdR4oFp
         1VgWWQr4sCpl4Fua3bZPcz+uDottvhUeetdyYc9FKCcl2X9y1cilDYUGcg2vlPNdZ2
         Z2N9MgEpQLQYU1FG744fbCxx6y0UNVFmb5QZaAAU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 01 Nov 2023 11:17:45 +0200
Subject: [PATCH 08/10] drm/tidss: Add dispc_is_idle()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-tidss-probe-v1-8-45149e0f9415@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=XebHXvtm9Gfpkkb4vxBLxt9Z+vX/euBnejSOchv4oXo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlQhfouctsmX1lsKBLN4hTuScM6P6dOalET/fhs
 HZs+OBlhFmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUIX6AAKCRD6PaqMvJYe
 9ZLdEACvwMBfXZe0UFUyJAWitzqcRdI8rq8Fv/GHlhHVRw6N5qjExuo05m0ZiCJ6WIRz9xkTK2K
 zAk+ELQ45A7rymVJBlRzVnEdfKOrpYltqBFjJKtN86fyj/9QuSmpnlgqMVvVeP0QjHEVbM1x67n
 /v1xfm0zSLtYWjB4sXzrDAHxcQUIVc6SCOGDGAITlg1Wblo5ZyRUzOeOGJTg7jovU6OCPXRY8jD
 c9x7sXrml0VY+hv/IvmVTDqE1opMxhcSBdOWmNAoRMPObo2jAMt5OnsdP3sGvVErVmFd6y3e5aK
 vnWSbTv4yGyZdwRueI9dIztZkn/hQj9HNHUTtokEI2yvGny8gI3tDIG7bR+WP5d7jNfT9i+sjp0
 WggxHMj/poiPeMIZyTV8tLQx2kZ+repaWIw+1O4sFL+AIL6fvS0/pDx8cGDs23VY+A7+Je3dMIs
 VvD22BMSLeRDdilvHDEm5VhM27fxm5KZybEYtLWO2cfsdO1TzuFd9OjAHBNOkwg+0B2G5i2soET
 ZXakM7ynJ6Ywl6+Ougzskf3YSSJgQPZGrAuR2hOMAY6BTVMYaPuDC8aZrwRqRY6M7Fw2wwymt7K
 iDGIuOn5dXSMwPoiz2Yz6xyYumkGCHPWc+4r4NqZG6IFOCg0z2Nd7oqXdpL88td6UsveBDz/dz8
 gxLsbPLhYe97xEg==
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

Add a helper function, dispc_is_idle(), which returns whether the DSS is
idle (i.e. is any video port enabled).

For now we add a call to it in the suspend and resume callbacks, and
print a warning if in either place the DSS is not idle. In the future
this can be used to detect if the bootloader had enabled the DSS, and
the driver can act on that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 13db062892e3..a527c28c8833 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2603,10 +2603,18 @@ void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
 	dispc_vp_set_color_mgmt(dispc, hw_videoport, state, newmodeset);
 }
 
+static bool dispc_is_idle(struct dispc_device *dispc)
+{
+	return REG_GET(dispc, DSS_SYSSTATUS, 9, 9);
+}
+
 int dispc_runtime_suspend(struct dispc_device *dispc)
 {
 	dev_dbg(dispc->dev, "suspend\n");
 
+	if (!dispc_is_idle(dispc))
+		dev_warn(dispc->dev, "Bad HW state: DSS not idle when suspending");
+
 	dispc->is_enabled = false;
 
 	clk_disable_unprepare(dispc->fclk);
@@ -2620,6 +2628,9 @@ int dispc_runtime_resume(struct dispc_device *dispc)
 
 	clk_prepare_enable(dispc->fclk);
 
+	if (!dispc_is_idle(dispc))
+		dev_warn(dispc->dev, "Bad HW state: DSS not idle when resuming");
+
 	if (REG_GET(dispc, DSS_SYSSTATUS, 0, 0) == 0)
 		dev_warn(dispc->dev, "DSS FUNC RESET not done!\n");
 

-- 
2.34.1

