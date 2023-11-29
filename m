Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8607FD2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjK2Jbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjK2JbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:31:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4827126A2;
        Wed, 29 Nov 2023 01:30:23 -0800 (PST)
Received: from pyrite.hamster-moth.ts.net (h175-177-049-135.catv02.itscom.jp [175.177.49.135])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 565F289D;
        Wed, 29 Nov 2023 10:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701250184;
        bh=x5DGL3arJhhL6cHx1o46byLPKXKRQq29+jIxhF3wWFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhfCHa/UZW2Ewa8Uz+2l85e5dnvhDjW2zCDWDhZ/HjrqSnbeQ6CjnYYHM04tp4sSK
         9YTW7mvC0UeQM9BEdQkQS1fR+0ofIp5zOkd/UsVTWewly106P5pm23k/kko0/szIeh
         gO4BvK3sc4SdMKUJjYjvsGWbIHAITa9eb5BA8aB0=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
Date:   Wed, 29 Nov 2023 18:29:55 +0900
Message-Id: <20231129092956.250129-3-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231129092956.250129-1-paul.elder@ideasonboard.com>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com>
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

Add register dump for the image stabilizer module to debugfs.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-debug.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
index 71df3dc95e6f..f66b9754472e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
@@ -139,6 +139,21 @@ static int rkisp1_debug_dump_mi_mp_show(struct seq_file *m, void *p)
 }
 DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp);
 
+static int rkisp1_debug_dump_is_show(struct seq_file *m, void *p)
+{
+	static const struct rkisp1_debug_register registers[] = {
+		RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
+		RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),
+		{ /* Sentinel */ },
+	};
+	struct rkisp1_device *rkisp1 = m->private;
+
+	return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
+}
+DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_is);
+
 #define RKISP1_DEBUG_DATA_COUNT_BINS	32
 #define RKISP1_DEBUG_DATA_COUNT_STEP	(4096 / RKISP1_DEBUG_DATA_COUNT_BINS)
 
@@ -235,6 +250,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
 
 	debugfs_create_file("mi_mp", 0444, regs_dir, rkisp1,
 			    &rkisp1_debug_dump_mi_mp_fops);
+
+	debugfs_create_file("is", 0444, regs_dir, rkisp1,
+			    &rkisp1_debug_dump_is_fops);
 }
 
 void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)
-- 
2.39.2

