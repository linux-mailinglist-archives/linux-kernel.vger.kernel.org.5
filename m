Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19C800CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379102AbjLAOEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:04:50 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D094;
        Fri,  1 Dec 2023 06:04:56 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 22F67138C;
        Fri,  1 Dec 2023 15:04:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701439457;
        bh=6zAIEj5ay2gT7+AvgvT+WUyzdRwwv76PYE4uLNb3qOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs4yQcW/vUdx9xaVmGD7CpLkHEu69wWuVl/djvZU0fy+fZTmDBUhNtZ6czqnNIUPs
         aM1PGitQ4siHqyu2UvsLCVLdAXLNbiG2JcPzLNTDHDBj5CZhF0NJ5R8ZKW+DSb8sKo
         gMcrmimq8GEvoBE0Pn+B+/SeLldJcmSmUX1T9/3Q=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] media: rkisp1: regs: Consolidate MI interrupt wrap fields
Date:   Fri,  1 Dec 2023 23:04:30 +0900
Message-Id: <20231201140433.2126011-2-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231201140433.2126011-1-paul.elder@ideasonboard.com>
References: <20231201140433.2126011-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate the wraparound fields in the memory interface interrupt
status registers, so that it can be more succinctly expressed by taking
the stream ID (main or self) as a parameter.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
index 350f452e676f..bea69a0d766a 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
@@ -172,12 +172,9 @@
 #define RKISP1_CIF_MI_FRAME(stream)			BIT((stream)->id)
 #define RKISP1_CIF_MI_MBLK_LINE				BIT(2)
 #define RKISP1_CIF_MI_FILL_MP_Y				BIT(3)
-#define RKISP1_CIF_MI_WRAP_MP_Y				BIT(4)
-#define RKISP1_CIF_MI_WRAP_MP_CB			BIT(5)
-#define RKISP1_CIF_MI_WRAP_MP_CR			BIT(6)
-#define RKISP1_CIF_MI_WRAP_SP_Y				BIT(7)
-#define RKISP1_CIF_MI_WRAP_SP_CB			BIT(8)
-#define RKISP1_CIF_MI_WRAP_SP_CR			BIT(9)
+#define RKISP1_CIF_MI_WRAP_Y(stream)			BIT(4 + (stream)->id * 3)
+#define RKISP1_CIF_MI_WRAP_CB(stream)			BIT(5 + (stream)->id * 3)
+#define RKISP1_CIF_MI_WRAP_CR(stream)			BIT(6 + (stream)->id * 3)
 #define RKISP1_CIF_MI_DMA_READY				BIT(11)
 
 /* MI_STATUS */
-- 
2.39.2

