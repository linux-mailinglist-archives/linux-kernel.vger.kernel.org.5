Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40334806B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377683AbjLFKNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377651AbjLFKNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:13:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E91D64;
        Wed,  6 Dec 2023 02:13:00 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EA622B09;
        Wed,  6 Dec 2023 11:12:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701857534;
        bh=PKUcBdc8Qj6XeTMDCk4F0nRr2AQygA1lnSwR9BIZ64A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mlZdKuCICZ5xqmYpghtsHBC1xpLI76Ws+DZsoYvWi8URIodqTSDt9hGX+aot1nvHW
         C9gdyHqwHmp09usqo56v9453JXWr3org8nQ9xwPX54CN1RXnilaS1EasyJKBLFCxSe
         /KhuS6lrDaxHWLYIpJpq4Jg4LfbyItKa0/eQnoBk=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 06 Dec 2023 12:12:31 +0200
Subject: [PATCH v2 4/4] media: rkisp1: Fix IRQ disable race issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-rkisp-irq-fix-v2-4-6ba4185eeb1f@ideasonboard.com>
References: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
In-Reply-To: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PKUcBdc8Qj6XeTMDCk4F0nRr2AQygA1lnSwR9BIZ64A=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlcEkhuPu8R/u0zTPQ1W//B0yzANJaz5h46O91S
 MX9rZ0rGhKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZXBJIQAKCRD6PaqMvJYe
 9SQ1D/0WNlBX1kQYLY1htxMCKTBE6WutW9vj9EDMkljHP4bFOTt76UdikAxDBt1ozRlskCeF6cE
 PNe0r5Ck2WlI7E+Ucfu1SmRgsqZf80Or7Lz3sqGYscuwl5RF1QUYnzmULiaNOSmkkJHc/ZIIemb
 p+G7vvjytJrpg1MGF/qJmhVlGCVZJhLn+r8oAHx80cCgzvnf9apfFuz0soMDZLzC60zk1TK9+/F
 mjhOSBnU8njOvS7TdFQJsxhr5fCWsZYXahNF41pY+luL+ZgS7KNpbkqprCw1k63yeO6XABJ9pAh
 Cyx7CtSaKsrLGO7GhnKZpcrO7cdQROBDpG4ymbwxFVMKnED45uChqhg9y663qTHBahXIVUhuyBX
 QwKPpwY7wFCORjm0WtGPW7dfE8Mgam1vqPHnzfi7s/JDZQMKNZvr1jlG3wgbHgF6/U7ngoDiR4E
 2U1qi4jqTB/V2vAKvSfqkJ1Zc4DcssxYYOcmO3iQVPkNCiBHwdXzttxza0KTWktARVZ5lyIaEXE
 hxTlkWxglasejh0NocZF5jfIeOPfHV5JhHFOmJ/6iaLAo1IEgFRRe5QGsm267E6IW3Obuk9+DZ1
 4rNodgTAdPKsYrQNbUDie5BXKjTjOwZUJ/uvb0/aKOm0G/15ajtHheOslDXihbxjSBiiX1RlVSW
 Ckl3LxDwT6v/JPA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c | 14 +++++++++++++-
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 20 +++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
index 47f4353a1784..0bab3303f2e4 100644
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
index dafbfd230542..33b5a714d117 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -364,11 +364,25 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
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

