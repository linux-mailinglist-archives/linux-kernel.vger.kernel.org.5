Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F40806B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377605AbjLFKNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377608AbjLFKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:12:51 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F38D67;
        Wed,  6 Dec 2023 02:12:57 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BEFD21F73;
        Wed,  6 Dec 2023 11:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701857532;
        bh=kTEQJAdraKwrzcd8ZJfODsKyAzCts6sPzE51t6mPv5U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cz2haK2OD5bPWnsON1BgC7pXGyYxdoSU5/LFsDYGcDMEQKRBpbOa9angdhJunGisq
         +toHkNLKqCXqRr/o8MhkAPkDmg3jCoKpMCOFqR6oCXzOrWeAgMsvSHH70cTgQ37YaU
         pRcQOWuWBntCvDjIqAqJ++QzXsF/GYzSy3UJYaOQ=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 06 Dec 2023 12:12:29 +0200
Subject: [PATCH v2 2/4] media: rkisp1: Fix IRQ handler return values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-rkisp-irq-fix-v2-2-6ba4185eeb1f@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=kTEQJAdraKwrzcd8ZJfODsKyAzCts6sPzE51t6mPv5U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlcEkhBdljqzcxdBz+n0Wffu84QmzeeRNvsvGC9
 cGZSQNUbE+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZXBJIQAKCRD6PaqMvJYe
 9aUMD/sECwuIEzxXDMinK22ykn6sULYtxlmWoqQFVcpYw+bgJVHt+hioXxZCPYN3ombSxlxQvUP
 XAf9qCLnbP6ywYh/g2iz/pf2CUJ8lr2vwMgD/mn+krMg3H0RubK5JM2mDdxp4Q/41VR6ETh+el1
 /9xu2KTLFtOvjltjNUANLQJr8a16LwuDh8Ah5GtaD/T3qaVx7/ztWxkhCmKMn501fvi1lWHkwb3
 6INakLtaDUMWNK33/ves8vzO77xQwemh9VBeh+Si8npZjrUDuui31TZcrdE9J3P66MLC3avRfVx
 NzE030mRNOv6eYYpXloFk1yCeCDdsSC4hae7M7YUyKPtUy0xnhHb4GFdzI52a3B3uZNp0KumFA6
 /WVfNjO1scszA5xbpCUmiQVNTewp4GYp0jIRm39SBqA+M2Bvts2aydSdIGRmlsja2Fm7nGa2upJ
 V4XOnY+Kd2NI1REQ67usKfmPk5TXUALa9KpqGGeIBYeuFZn37joHclghA7Tjr96hAjmnBqOqILu
 DsVaqLUsQjaEV/batt9ydgvTYOq97ISZW2gZrmbCoLbxExWCsdL2Q1sNTtijABONT2r5lB3xBJZ
 dKeb0vSidXxLX4g0Gwon37xOsfFbpPP+lNSem+uVNur/4R7fOWj++2pGUM1k0VxDgLmYh1lGff8
 wBMUB02ZqLQ45CQ==
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

The IRQ handler rkisp1_isr() calls sub-handlers, all of which returns an
irqreturn_t value, but rkisp1_isr() ignores those values and always
returns IRQ_HANDLED.

Fix this by collecting the return values, and returning IRQ_HANDLED or
IRQ_NONE as appropriate.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index d4950294b7b9..030eb8c79546 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -444,17 +444,25 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
 
 static irqreturn_t rkisp1_isr(int irq, void *ctx)
 {
+	irqreturn_t ret = IRQ_NONE;
+
 	/*
 	 * Call rkisp1_capture_isr() first to handle the frame that
 	 * potentially completed using the current frame_sequence number before
 	 * it is potentially incremented by rkisp1_isp_isr() in the vertical
 	 * sync.
 	 */
-	rkisp1_capture_isr(irq, ctx);
-	rkisp1_isp_isr(irq, ctx);
-	rkisp1_csi_isr(irq, ctx);
 
-	return IRQ_HANDLED;
+	if (rkisp1_capture_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	if (rkisp1_isp_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	if (rkisp1_csi_isr(irq, ctx) == IRQ_HANDLED)
+		ret = IRQ_HANDLED;
+
+	return ret;
 }
 
 static const char * const px30_isp_clks[] = {

-- 
2.34.1

