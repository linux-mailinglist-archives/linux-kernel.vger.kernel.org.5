Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329F9800CD4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379098AbjLAOFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379114AbjLAOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:04:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CAE1B2;
        Fri,  1 Dec 2023 06:05:05 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D4D64FAD;
        Fri,  1 Dec 2023 15:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701439467;
        bh=MFcStENnnolCSllpVqU3n3QSpfDjGV2JE1o/1bWj2kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qa1SZLwHWB9/IALx/ETlJuQtmJcmv5BtbnooiP5QzYVp2ZvlKKBZCcfPb68UruJXw
         ivdpwxsKhv0P/FQovfBYBo5c0pAAqsN+bsLefogBotizdxhN02TTJzA/bL4c4GqbGu
         nU6qoldIDPqXTwj+U8f2MxesCQRgs4fsohKGDDy0=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] media: rkisp1: debug: Count completed frame interrupts
Date:   Fri,  1 Dec 2023 23:04:32 +0900
Message-Id: <20231201140433.2126011-4-paul.elder@ideasonboard.com>
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

Add a counter to debugfs to count the number of frame-end interrupts.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h | 1 +
 drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c  | 2 ++
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c    | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 1e7cea1bea5e..be69173958a4 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -417,6 +417,7 @@ struct rkisp1_debug {
 	unsigned long stats_error;
 	unsigned long stop_timeout[2];
 	unsigned long frame_drop[2];
+	unsigned long complete_frames;
 };
 
 /*
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
index d2fbed42164e..79cda589d935 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
@@ -221,6 +221,8 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
 			     &debug->frame_drop[RKISP1_MAINPATH]);
 	debugfs_create_ulong("sp_frame_drop", 0444, debug->debugfs_dir,
 			     &debug->frame_drop[RKISP1_SELFPATH]);
+	debugfs_create_ulong("complete_frames", 0444, debug->debugfs_dir,
+			     &debug->complete_frames);
 	debugfs_create_file("input_status", 0444, debug->debugfs_dir, rkisp1,
 			    &rkisp1_debug_input_status_fops);
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 88ca8b2283b7..bd3acd926410 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -989,6 +989,8 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
 	if (status & RKISP1_CIF_ISP_FRAME) {
 		u32 isp_ris;
 
+		rkisp1->debug.complete_frames++;
+
 		/* New frame from the sensor received */
 		isp_ris = rkisp1_read(rkisp1, RKISP1_CIF_ISP_RIS);
 		if (isp_ris & RKISP1_STATS_MEAS_MASK)
-- 
2.39.2

