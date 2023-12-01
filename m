Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA6800CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379111AbjLAOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLAOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:04:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796094;
        Fri,  1 Dec 2023 06:05:00 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3A3118A2;
        Fri,  1 Dec 2023 15:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701439462;
        bh=GCySINWmuCR5JodNHhNRp4B30t3rx5GHASe7kUWliPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bn5kQflYY6ZjgS3HSwJuWGk06QH7hZbvaEufHauqZ8LtlOMT0f3Ob9ErzD5scA+MX
         i+DjWr/Z8tjLamXiSMxFBHzBdYekA3spRIeZiAMLD2E15GempKuwoQNWg5Gmi/yQCh
         Nw7LbxSuHjE/MCUOV1LqL//sPyfgn8pSkDDCloVo=
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
Subject: [PATCH v2 2/4] media: rkisp1: debug: Add register dump for IS
Date:   Fri,  1 Dec 2023 23:04:31 +0900
Message-Id: <20231201140433.2126011-3-paul.elder@ideasonboard.com>
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

Add register dump for the ISP image stabilizer module to debugfs. This
helps debugging issues related to digital zoom.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---
Changes in v2:
- Move from IS debugfs file into the ISP debugfs file

 drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
index 71df3dc95e6f..d2fbed42164e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
@@ -92,6 +92,10 @@ static int rkisp1_debug_dump_isp_regs_show(struct seq_file *m, void *p)
 		RKISP1_DEBUG_REG(ISP_FLAGS_SHD),
 		RKISP1_DEBUG_REG(ISP_RIS),
 		RKISP1_DEBUG_REG(ISP_ERR),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),
 		{ /* Sentinel */ },
 	};
 	struct rkisp1_device *rkisp1 = m->private;
-- 
2.39.2

