Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6C7F8466
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346067AbjKXT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbjKXT0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:26:40 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A173864;
        Fri, 24 Nov 2023 11:26:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 15F2C2CE00DA;
        Fri, 24 Nov 2023 20:26:43 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id NX6Ds4Qmq5FP; Fri, 24 Nov 2023 20:26:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id A4BC72CE00D9;
        Fri, 24 Nov 2023 20:26:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl A4BC72CE00D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700854002;
        bh=t2DvnPm/DmspTUPI5isSC5hKU7aNqpJg/iZh1RieKVk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=NAXPePizDyluzoIYXNGgwTbgLizk7FSpGZAGRGlK2ePP/os0ZEWj6oLBmNobORfxN
         V6OVBJqWD3ZHuOXgw4MKYEvlqhNLomHOKqiUMCfGtRA2g9PghgJU33z2i4tu/dqpHD
         IY/ujoX1TYdHBWFdA/0FcckFVcQFcZ2AZGwvgMxWmvVbq6PJqkMqIVH4G4nwSIhzZV
         ilYzr+mtMR+MDLvbZ8XTuVTx0zClecYF/5vLTOAu16YSyt1R7ziub3QkmgD4fngUKu
         KXwIj+8QRkfXz+SKJuzyez3vxJ4li+gCm/1nkXgfqnN0hzi7r+fk8Qe6dzt7VlqTRj
         wll3wbnJcNs+A==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UsCI8iUtAkr6; Fri, 24 Nov 2023 20:26:42 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id 70DAA2CE00D8;
        Fri, 24 Nov 2023 20:26:42 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, runtimeca39d@amd.com
Cc:     Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH v3 4/5] dmaengine: xilinx: xdma: Rework xdma_channel_isr()
Date:   Fri, 24 Nov 2023 20:25:57 +0100
Message-Id: <20231124192558.135004-5-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124192524.134989-1-jankul@alatek.krakow.pl>
References: <20231124192524.134989-1-jankul@alatek.krakow.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xdma's channel status register may be read and cleared
simultaneously, by accesing it via seperate XDMA_CHAN_STATUS_RC
register. Therefore, it is possible to simplify the code
by just getting rid of a seperate redundant write.

Also, implement the actual status register checking as well.
Previously, the cyclic callback would be scheduled regardless of the
status register state. Fix it.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h |  2 ++
 drivers/dma/xilinx/xdma.c      | 16 ++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

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
index b8de15e3dcfc..de4615bd4ee5 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -814,15 +814,15 @@ static irqreturn_t xdma_channel_isr(int irq, void *=
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
+	ret =3D regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st)=
;
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

