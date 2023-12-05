Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B8804BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376476AbjLEIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjLEIKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:10:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15AA127;
        Tue,  5 Dec 2023 00:10:07 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2FF0CEEE;
        Tue,  5 Dec 2023 09:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701763764;
        bh=WNFwBf6lfujD0ZQ+VOP/UJchIYnz0NMJp9HloMbZytA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PnaOPacsNt55CsSxBteS0KdXjZuHHlLbjuZw2U3XpRZbabFJD3MEq1VFag4cIAX0a
         G+DyM175on5WDyMg4NpXol3r2XHfXQO7jcaH2w8f/wEZhrPo/utPUtbZ7HbU6EUCsm
         YRpjZvs+dlf4TcgalR58edCgbVZG5D86YwSQPKRI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Tue, 05 Dec 2023 10:09:33 +0200
Subject: [PATCH 2/4] media: rkisp1: Fix IRQ handler return values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-rkisp-irq-fix-v1-2-f4045c74ba45@ideasonboard.com>
References: <20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com>
In-Reply-To: <20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=WNFwBf6lfujD0ZQ+VOP/UJchIYnz0NMJp9HloMbZytA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlbtrYHUyIcw9QFvbFkSIrfTb+8f/fz4Git+i/W
 6Gu5IM4MJqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZW7a2AAKCRD6PaqMvJYe
 9dKSEACJtMy5hagG9Dgbka6/kKGcekwuWk4WVA+I0YyWHK3zz6ryIxYta3z/0swDdSIz7cAg58m
 af6c5kr2Mi5CgLYgh4sokjBBQOaX3AFIz0rGSxz2J/KFdQZOz4Yq9BBciF8qQBpetAIzDgcxgkq
 nEGmykPUCKesFrjk1gQOFIlq4EMbg0yfIuCs6E0Bc52Mu0yEy+91sgiCqwX76AOS62xaPUMVndJ
 vQB/A//jHQxdn5zeNtoUYlXcnpl7BT5CBQcIaEUTiMSCS29PZvBZ/kqmyFXQ4MasjBkBDGrHB6D
 GFc7xbsYYzqTn+tzg8Jcw7fZEPKoDV6Dg3eTo0biDVSCyu4l8CRFODZU+LcvXj+I7RmAJNOVgw+
 qGbCKH1iE/IbygRVFS3nWQuKIp4rO0JjTBH8fbspQifIsjuk0DYeJj4DzqlpmnWbvNbobfc/kzq
 lxrCrLrEm7EJgaOx3Ww4iaE0XoFKzkkGx7TnBoX79ywepqARu6EWgb6ejdkd5rhhGn5aAPdVAH0
 j7J6QM0mH41FwAky6Gzu5AjCwhUndC3p6zZy2wUQB4VW4zG9acoueE3xuXB3IUABBVELQeBs37v
 ZNaCMzxlAg4v/GpDtZTDoREqphZKSmtjvxSOQwNgdNH44JI2UPvm7xvK6THnIAQ49HuRYw6XYTS
 SfnS5jlZ1/b/xAQ==
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

The IRQ handler rkisp1_isr() calls sub-handlers, all of which returns an
irqreturn_t value, but rkisp1_isr() ignores those values and always
returns IRQ_HANDLED.

Fix this by collecting the return values, and returning IRQ_HANDLED or
IRQ_NONE as appropriate.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 76f93614b4cf..1d60f4b8bd09 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -445,17 +445,27 @@ static int rkisp1_entities_register(struct rkisp1_device *rkisp1)
 
 static irqreturn_t rkisp1_isr(int irq, void *ctx)
 {
+	irqreturn_t ret;
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
+	ret = IRQ_NONE;
+
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

