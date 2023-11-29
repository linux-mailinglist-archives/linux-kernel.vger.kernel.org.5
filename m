Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544207FD2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjK2J3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2J2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:28:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C231FFA;
        Wed, 29 Nov 2023 01:28:43 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-135.catv02.itscom.jp [175.177.49.135])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 26B69F02;
        Wed, 29 Nov 2023 10:28:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701250086;
        bh=Edrymv5691+fMNHomNnzzNr4DmSpwPe97XaFQm/kkW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDXlrcTI9ujlwLviFejRx+86njHF7zKPxbHPS3bIt9iAygP67XR5zGuBFoQe1SA9e
         ZgPxXYj9EnTmQtlN79OzIdjLjKkQd6Mk8icNqxbC93QIk02+bRGHIgU62RWfXvOQyv
         GbugVP2iLOawbOF5UGjvLr9+d/B4iGThKrlyq7aM=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com, aford173@gmail.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/11] media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
Date:   Wed, 29 Nov 2023 18:27:53 +0900
Message-Id: <20231129092759.242641-6-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231129092759.242641-1-paul.elder@ideasonboard.com>
References: <20231129092759.242641-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISP8000Nano, found in the i.MX8MP, has a different architecture to
crop at the resizer input. Instead of the "dual crop" block between the
ISP and the resizers found in the RK3399, cropping has been moved to the
input of the resizer blocks. As a result, the resizer CFG_UPD and
CFG_UPD_AUTO bits have been moved to make space for a new CROP_ENABLE
bit.

Fix the resizer shadow update accordingly, using the DUAL_CROP feature
to infer whether or not the resizer implements cropping. Support for
resizer cropping itself will be added in a subsequent commit.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes since v3:

- Condition on RKISP1_FEATURE_DUAL_CROP feature
- Update commit message

Changes since v2:

- Condition on RKISP1_FEATURE_RSZ_CROP feature
- Rename bits
- Use the rkisp1_has_feature() macro

 .../media/platform/rockchip/rkisp1/rkisp1-regs.h  |  5 +++++
 .../platform/rockchip/rkisp1/rkisp1-resizer.c     | 15 +++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
index 3b19c8411360..95646b45f28b 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
@@ -168,6 +168,11 @@
 #define RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO		BIT(9)
 #define RKISP1_CIF_RSZ_SCALER_FACTOR			BIT(16)
 
+/* For resizer instances that support cropping */
+#define RKISP1_CIF_RSZ_CTRL_CROP_ENABLE			BIT(8)
+#define RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD		BIT(9)
+#define RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD_AUTO		BIT(10)
+
 /* MI_IMSC - MI_MIS - MI_RIS - MI_ICR - MI_ISR */
 #define RKISP1_CIF_MI_FRAME(stream)			BIT((stream)->id)
 #define RKISP1_CIF_MI_MBLK_LINE				BIT(2)
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index c1aaeed58acc..6d6ebc53c6e5 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -178,10 +178,17 @@ static void rkisp1_rsz_update_shadow(struct rkisp1_resizer *rsz,
 {
 	u32 ctrl_cfg = rkisp1_rsz_read(rsz, RKISP1_CIF_RSZ_CTRL);
 
-	if (when == RKISP1_SHADOW_REGS_ASYNC)
-		ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO;
-	else
-		ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD;
+	if (when == RKISP1_SHADOW_REGS_ASYNC) {
+		if (rkisp1_has_feature(rsz->rkisp1, DUAL_CROP))
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO;
+		else
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD_AUTO;
+	} else {
+		if (rkisp1_has_feature(rsz->rkisp1, DUAL_CROP))
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CFG_UPD;
+		else
+			ctrl_cfg |= RKISP1_CIF_RSZ_CTRL_CROP_CFG_UPD;
+	}
 
 	rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_CTRL, ctrl_cfg);
 }
-- 
2.39.2

