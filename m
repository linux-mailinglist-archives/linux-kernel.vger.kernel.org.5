Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD32380823D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378125AbjLGH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbjLGH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:58:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F1A110;
        Wed,  6 Dec 2023 23:58:15 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29F24142F;
        Thu,  7 Dec 2023 08:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701935850;
        bh=PEgW8HpAPTSm60v9jbUcj/Sho2macS6ZjbgFOi8LEMg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Z7OD9VzHz//UNCY9/z0t37lielcaegQWTDdbz4wGWH18tyuug49jKU16DEwUrlQ79
         NICdAfRsbysn0uIw3hv7//q5muCX7qjH/B452SwnhV77xE2MCjynxsOwrWloFgJuIY
         mRRKTN69+89zuZqtv8ORKbnRdguEE81yIeqVNHl8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 07 Dec 2023 09:57:48 +0200
Subject: [PATCH v3 4/4] media: rkisp1: Fix IRQ disable race issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-rkisp-irq-fix-v3-4-358a2c871a3c@ideasonboard.com>
References: <20231207-rkisp-irq-fix-v3-0-358a2c871a3c@ideasonboard.com>
In-Reply-To: <20231207-rkisp-irq-fix-v3-0-358a2c871a3c@ideasonboard.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        aford173@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3565;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PEgW8HpAPTSm60v9jbUcj/Sho2macS6ZjbgFOi8LEMg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlcXsObhyE/ipqZwUoJ4G5ZPJUbcRLYb8ZvO7zA
 ynYiIDsH7uJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZXF7DgAKCRD6PaqMvJYe
 9TqaD/4kAipjfzi4A4X3RNcutStIe6k+RrBxaUqwBCV+dvTSv+VkkyKdgnWGzVHBRiGDVectDxW
 j9oxAK/Zvx6tsTXUbRolVw9iadLBwoWgihvZpXZLaI74r1Eh3lu8BjurewK/VJItKlVcCuhpxDL
 cs4aaCTnEvkz20KajppWwJ+NRU4GcznwaQBkruV1zKnCDzW2Q6F1JlHITn7NzdRbu8Q/xJEQoSZ
 8Ay3/4N4W8GwGB7ncx9LmXz6AA/u44Z/aJu8uKDKWML6MRBzziEFd+6CNXXwOQHFXAkeXjqJPIi
 Q+EvdaRfQjCTwCpauFBylHnRkNAs/h422SV1EzFnbikwr5PWtbNwf4djYEDNeDMog9NW8koydUN
 eGVGTT4uUnpKpHojdrw34/HNvJtEPhMiuXYVuKFrs/tfQHXUvjU6jFnDY7Db8gPYIwgaB1dEhd2
 yBuL9jW2Dl9HA4ujyR2SxsUJqqwtdn5frfYcMBDWI4mbqcjgbPRjY8+DDgqs47mH08dEXP7MGDw
 stDAQ55S6Mwdv31EoX1HAca7N+sDMZIPHAn9rT3SGL9f0dZfT7yPqX8ZI1OCwKlMWfXQL+jFuvu
 bj17pPGI3cMB4zAwvnd1vu95euLl7U7GDayI9NaB2tkMlLOq9FBrNkn/jgLj3LidAWwXebPYpTx
 Vn0WRUuLdkIdLvQ==
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

In rkisp1_isp_stop() and rkisp1_csi_disable() the driver masks the
interrupts and then apparently assumes that the interrupt handler won't
be running, and proceeds in the stop procedure. This is not the case, as
the interrupt handler can already be running, which would lead to the
ISP being disabled while the interrupt handler handling a captured
frame.

This brings up two issues: 1) the ISP could be powered off while the
interrupt handler is still running and accessing registers, leading to
board lockup, and 2) the interrupt handler code and the code that
disables the streaming might do things that conflict.

It is not clear to me if 2) causes a real issue, but 1) can be seen with
a suitable delay (or printk in my case) in the interrupt handler,
leading to board lockup.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Adam Ford <aford173@gmail.com>  #imx8mp-beacon
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c | 14 +++++++++++++-
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 20 +++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
index e6642a2167ef..b6e47e2f1b94 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
@@ -125,8 +125,20 @@ static void rkisp1_csi_disable(struct rkisp1_csi *csi)
 	struct rkisp1_device *rkisp1 = csi->rkisp1;
 	u32 val;
 
-	/* Mask and clear interrupts. */
+	/* Mask MIPI interrupts. */
 	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_IMSC, 0);
+
+	/* Flush posted writes */
+	rkisp1_read(rkisp1, RKISP1_CIF_MIPI_IMSC);
+
+	/*
+	 * Wait until the IRQ handler has ended. The IRQ handler may get called
+	 * even after this, but it will return immediately as the MIPI
+	 * interrupts have been masked.
+	 */
+	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MIPI]);
+
+	/* Clear MIPI interrupt status */
 	rkisp1_write(rkisp1, RKISP1_CIF_MIPI_ICR, ~0);
 
 	val = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_CTRL);
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index ca6703bfd27b..29b538a5e1bb 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -254,11 +254,25 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
 	 * ISP(mi) stop in mi frame end -> Stop ISP(mipi) ->
 	 * Stop ISP(isp) ->wait for ISP isp off
 	 */
-	/* stop and clear MI and ISP interrupts */
-	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
-	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
 
+	/* Mask MI and ISP interrupts */
+	rkisp1_write(rkisp1, RKISP1_CIF_ISP_IMSC, 0);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_IMSC, 0);
+
+	/* Flush posted writes */
+	rkisp1_read(rkisp1, RKISP1_CIF_MI_IMSC);
+
+	/*
+	 * Wait until the IRQ handler has ended. The IRQ handler may get called
+	 * even after this, but it will return immediately as the MI and ISP
+	 * interrupts have been masked.
+	 */
+	synchronize_irq(rkisp1->irqs[RKISP1_IRQ_ISP]);
+	if (rkisp1->irqs[RKISP1_IRQ_ISP] != rkisp1->irqs[RKISP1_IRQ_MI])
+		synchronize_irq(rkisp1->irqs[RKISP1_IRQ_MI]);
+
+	/* Clear MI and ISP interrupt status */
+	rkisp1_write(rkisp1, RKISP1_CIF_ISP_ICR, ~0);
 	rkisp1_write(rkisp1, RKISP1_CIF_MI_ICR, ~0);
 
 	/* stop ISP */

-- 
2.34.1

