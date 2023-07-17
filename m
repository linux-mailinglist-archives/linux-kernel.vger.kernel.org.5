Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2909E756DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjGQUJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:09:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D82E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:09:27 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id LUX2q5vfabkI3LUX3qnKyX; Mon, 17 Jul 2023 22:09:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689624566;
        bh=UEj0AXAxlyKrDR2T9dRAsXWpemXdwncxY2h++Qk+qQw=;
        h=From:To:Cc:Subject:Date;
        b=d5cNBpyckTzPUqzqnhq0Y8pnMXCGVib/3GQbOzMQQsYxZ3ZYKt+G4E2/m0JKWFX+e
         qqDGQBU3SKWwxg6+fc7iAiwf/ujP3ncKaZh5EqZ0NlrQbWfy0k6ZMAHR2alnc/RV0O
         BRWLayHoFfKe22+BCe+9ZH74Rp3Yb4VGTr//1QNai0xaOnpWocQub4BxIKf/4/XYQQ
         aC6q05JzSPNLdSdhUaYi7DjgHHxT1Idu1MjlUL6CW1hWdXd95uygiX+S50KeqRHdcM
         t5KbEAcOD6WglubNCuVqoWfi+MZ7NLw0gvaibiq0kYwspynZkdd5yCqTNi6bIdnZRC
         sbthVNZOAmuLA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Jul 2023 22:09:26 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] media: mediatek: vcodec: Fix an error handling path in vdec_msg_queue_init()
Date:   Mon, 17 Jul 2023 22:09:19 +0200
Message-Id: <efa0d4910998931a2ec9d933117fa71482d7b33a.1689624542.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All errors go to the error handling path, except this one. Be consistent
and also branch to it.

Fixes: 2f5d0aef37c6 ("media: mediatek: vcodec: support stateless AV1 decoder")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
index 04e6dc6cfa1d..c6cc2785e0e8 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c
@@ -338,14 +338,16 @@ int vdec_msg_queue_init(struct vdec_msg_queue *msg_queue,
 			err = mtk_vcodec_mem_alloc(ctx, &lat_buf->rd_mv_addr);
 			if (err) {
 				mtk_v4l2_err("failed to allocate rd_mv_addr buf[%d]", i);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto mem_alloc_err;
 			}
 
 			lat_buf->tile_addr.size = VDEC_LAT_TILE_SZ;
 			err = mtk_vcodec_mem_alloc(ctx, &lat_buf->tile_addr);
 			if (err) {
 				mtk_v4l2_err("failed to allocate tile_addr buf[%d]", i);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto mem_alloc_err;
 			}
 		}
 
-- 
2.34.1

