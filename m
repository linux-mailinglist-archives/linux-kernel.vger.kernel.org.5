Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B087F5303
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjKVWLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjKVWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:11:21 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7F8D60;
        Wed, 22 Nov 2023 14:11:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 33FF92D00B64;
        Wed, 22 Nov 2023 23:11:13 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lZtZOJ0CpnMK; Wed, 22 Nov 2023 23:11:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id DA8372D00B62;
        Wed, 22 Nov 2023 23:11:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl DA8372D00B62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700691072;
        bh=2g2bmVj9SU3TVbirdM1FQyRxNd9ZH2+KEdtfAh0SdvE=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=hNI956b+XzSkkYw/4p2g3NaXQ4e+U/EUUMMsoB+G11hxr+oboFsusaUDx1HKfxl48
         SDhFOuAzPXXhVSjsqaTQDY0NQcgvPtQNBZZFxzcBvqgLWjh0nX+Efa5L4j30b7Oo97
         zuymZw3vcVM+j+wFomhfPRvv10ZkKRIZeamhLoH4MUAGBnWNUtqHm3qUbX7XMo2hy0
         wSfp63o9zVSVdsEWJFkLlZdXxs19wr/h85yZUFT/q9YuuoRgBIpd8Xtj2ZEclVk376
         UB9Viy7/G7xCICepLkEVcSVGZS9L5zaZP5rTvVqQuCxj24QartfynnuRvS9jGyoXKY
         /esb985kjZKKw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5SsUR_9Zgj94; Wed, 22 Nov 2023 23:11:12 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id 966852D00B60;
        Wed, 22 Nov 2023 23:11:12 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH 4/5] dmaengine: xilinx: xdma: Rework xdma_channel_isr()
Date:   Wed, 22 Nov 2023 23:09:20 +0100
Message-Id: <20231122220921.117428-5-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122220830.117403-1-jankul@alatek.krakow.pl>
References: <20231122220830.117403-1-jankul@alatek.krakow.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xdma's channel status register may be read and cleared
simultaneously, by accessing it via separate XDMA_CHAN_STATUS_RC
register. Therefore, it is possible to simplify the code
by just getting rid of a separate redundant write.

Also, implement the actual status register checking as well.
Previously, the cyclic callback would be scheduled regardless of the
status register state. Fix it.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h |  2 ++
 drivers/dma/xilinx/xdma.c      | 17 +++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 654c5e41112d..6bf7ae84e452 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -116,6 +116,8 @@ struct xdma_hw_desc {
 			 CHAN_CTRL_IE_WRITE_ERROR |			\
 			 CHAN_CTRL_IE_DESC_ERROR)
=20
+#define XDMA_CHAN_STATUS_MASK CHAN_CTRL_START
+
 /* bits of the channel interrupt enable mask */
 #define CHAN_IM_DESC_ERROR			BIT(19)
 #define CHAN_IM_READ_ERROR			BIT(9)
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 58539a093de2..dc7f43f17103 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -809,15 +809,16 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
dev_id)
=20
 	desc->completed_desc_num +=3D complete_desc_num;
=20
-	if (desc->cyclic) {
-		ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS,
-				  &st);
-		if (ret)
-			goto out;
-
-		regmap_write(xdev->rmap, xchan->base + XDMA_CHAN_STATUS, st);
+	/* clear-on-read the status register */
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC,
+			  &st);
+	if (ret)
+		goto out;
=20
-		vchan_cyclic_callback(vd);
+	if (desc->cyclic) {
+		st &=3D XDMA_CHAN_STATUS_MASK;
+		if (st & CHAN_CTRL_IE_DESC_COMPLETED)
+			vchan_cyclic_callback(vd);
 		goto out;
 	}
=20
--=20
2.34.1

