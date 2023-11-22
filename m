Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39E77F4772
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbjKVNOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKVNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:14:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF8193;
        Wed, 22 Nov 2023 05:14:15 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 18BDF29A;
        Wed, 22 Nov 2023 14:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700658821;
        bh=T8/2/eVWOaSK74Zk/huyWx16HxOvhau72w6ke9khnUk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=q9SkXhu4AQI4R7ZMreUYZcuHkeiW7TLR2XuUdvegGAgerF8PVMtLjXJtq6eval9aC
         JD/KOU8ZnYDr04uxr0kIZo4+gO4qlE0UDhqAq6vkzN+76f/0KXjXQuSwhmfp1EKhzu
         ZsQSiRHaj7FGYrtYcfhg9jFcCKD5aKciIKJdsLLY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 22 Nov 2023 15:13:48 +0200
Subject: [PATCH 1/2] media: imx-mipi-csis: Fix clock handling in remove()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-imx-csis-v1-1-0617368eb996@ideasonboard.com>
References: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
In-Reply-To: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=T8/2/eVWOaSK74Zk/huyWx16HxOvhau72w6ke9khnUk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlXf6hZE9bpUJV4Xp6/7RrJtsJvOTki0kH73Zcr
 0+T/K2GQRyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZV3+oQAKCRD6PaqMvJYe
 9YCED/oCFm3ABpBs9PrRCrZNYgdhLzwVyaBddL4bnnEd2fj7Vebw/mDfOLyots2G/qgh3WUNpMO
 JZhPrZ+Xi4aoVX7kC1i0TM5nZu9POri2ZeExU4FvkSmumv5W9bX7PRAduTVaVEBlYP7Lo+9RGqq
 vuOXFereBiNFf6eORCGVVkqOl0QH8jp//mpAToioKRNnPKR2XoJ+/uFY3FJxdhGnGPv//bwiSK/
 eAzx29cSVH5F8wzNwZyTsfpMawgXe34+olYfRGKDgimDqhxrTUgzL/+iKEy3++jH+LxRnYUBAtR
 EpYBh2ZHXAxLj0HKY/qHKf+hP2WLQgd/ixo56OZOhE7J12lJI9lZdGZQ/wECil0sHzywmXE2TVN
 ylQZoqv7AnaA5+v9YzuTFyG/UKGibHafEtR6+gmYgG6y3yWdslKRuMtPo9nSsUgOLIQX1qUPhVh
 2pKA4F7IhpgxruyQxR7nCSBl3M1nLHgYpZKL7DRzSP4dHZk1szlGszk8e+k0EN/Ob7vINkiw28E
 ayWAgQ15wKhtqA/xgzSy6nWF6/grR/Xft73DHDxnxS6ikIeptO0Z+nz0L/iQob6BqsxGe+TEfZ8
 8jI9JDALlV+H5lt87UkVKvemv2BaNhptriVCQpNs+BPuRpxrRO9ej6ab58qBqC8cmpNqQoOdH8W
 WyCa57C2XU1DUKA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver always calls mipi_csis_runtime_suspend() and
mipi_csis_clk_disable() in remove(). This causes multiple WARNs from the
kernel, as the clocks get disabled too many times.

Fix the remove() to call mipi_csis_runtime_suspend() and
mipi_csis_clk_disable() in a way that reverses what is done in probe().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/nxp/imx-mipi-csis.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
index 6cb20b45e0a1..b39d7aeba750 100644
--- a/drivers/media/platform/nxp/imx-mipi-csis.c
+++ b/drivers/media/platform/nxp/imx-mipi-csis.c
@@ -1502,8 +1502,10 @@ static void mipi_csis_remove(struct platform_device *pdev)
 	v4l2_async_nf_cleanup(&csis->notifier);
 	v4l2_async_unregister_subdev(&csis->sd);
 
+	if (!pm_runtime_enabled(&pdev->dev))
+		mipi_csis_runtime_suspend(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
-	mipi_csis_runtime_suspend(&pdev->dev);
 	mipi_csis_clk_disable(csis);
 	v4l2_subdev_cleanup(&csis->sd);
 	media_entity_cleanup(&csis->sd.entity);

-- 
2.34.1

