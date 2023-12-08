Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDE80AF68
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574896AbjLHWIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjLHWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:08:09 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5C21706;
        Fri,  8 Dec 2023 14:08:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id A745B2D00FCF;
        Fri,  8 Dec 2023 23:08:11 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Pm6PtbYcO1Xs; Fri,  8 Dec 2023 23:08:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id C4CD72D00FCE;
        Fri,  8 Dec 2023 23:08:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl C4CD72D00FCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702073290;
        bh=OqUf+5qMMYkf8m8dTkgiVgao04lPLCwTYIySk9A5NlY=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=hmh5AfGbadyV6Y1sJdDJrvt+W6zrZhbGalxGYhz2woEeVgmT2A07pu1h8vdmYqZ4W
         sRQi+4cS3MzIPU47Qf5b6X6gZNCspXKZwsnsR4IIVR1Ay1iyfKJhye3L0b43mfWs7e
         UxHq3pLclgpbCv8riGhpNy3vggV8BHfKrMYVFeoj4mC+OzRNlQI73niTlklqH1HUv0
         r4ediBNW66UcvTEeptVuH2MfE9jcK380BB2RQ7tIrdbLB/UAAJF2gksfvVB1ZhJeoO
         27vjQpKdEzlCjC/I+ifMu5dav66kFCQwmvCJPzIzqQL1gcZ2xTWsiahTZ3beI/M9/H
         Leaq6fG5B1YmQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fAPQKYUSh1JW; Fri,  8 Dec 2023 23:08:10 +0100 (CET)
Received: from localhost.localdomain (unknown [10.125.125.6])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id 249152D00FCC;
        Fri,  8 Dec 2023 23:08:10 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Cc:     jankul@alatek.krakow.pl
Subject: [FIXED PATCH v4 6/8] dmaengine: xilinx: xdma: Add transfer error reporting
Date:   Fri,  8 Dec 2023 23:08:02 +0100
Message-Id: <20231208220802.56458-1-jankul@alatek.krakow.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
References: <9d683987-53db-a53e-9215-3a29f0167183@amd.com>
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

Extend the capability of transfer status reporting. Introduce error flag,
which allows to report error in case of a interrupt-reported error
condition.

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index d1bc36133a45..a7cd378b7e9a 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -85,6 +85,7 @@ struct xdma_chan {
  * @cyclic: Cyclic transfer vs. scatter-gather
  * @periods: Number of periods in the cyclic transfer
  * @period_size: Size of a period in bytes in cyclic transfers
+ * @error: tx error flag
  */
 struct xdma_desc {
 	struct virt_dma_desc		vdesc;
@@ -97,6 +98,7 @@ struct xdma_desc {
 	bool				cyclic;
 	u32				periods;
 	u32				period_size;
+	bool				error;
 };

 #define XDMA_DEV_STATUS_REG_DMA		BIT(0)
@@ -274,6 +276,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num,=
 bool cyclic)
 	sw_desc->chan =3D chan;
 	sw_desc->desc_num =3D desc_num;
 	sw_desc->cyclic =3D cyclic;
+	sw_desc->error =3D false;
 	dblk_num =3D DIV_ROUND_UP(desc_num, XDMA_DESC_ADJACENT);
 	sw_desc->desc_blocks =3D kcalloc(dblk_num, sizeof(*sw_desc->desc_blocks=
),
 				       GFP_NOWAIT);
@@ -770,20 +773,20 @@ static enum dma_status xdma_tx_status(struct dma_ch=
an *chan, dma_cookie_t cookie
 	spin_lock_irqsave(&xdma_chan->vchan.lock, flags);

 	vd =3D vchan_find_desc(&xdma_chan->vchan, cookie);
-	if (vd)
-		desc =3D to_xdma_desc(vd);
-	if (!desc || !desc->cyclic) {
-		spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);
-		return ret;
-	}
-
-	period_idx =3D desc->completed_desc_num % desc->periods;
-	residue =3D (desc->periods - period_idx) * desc->period_size;
+	if (!vd)
+		goto out;

+	desc =3D to_xdma_desc(vd);
+	if (desc->error) {
+		ret =3D DMA_ERROR;
+	} else if (desc->cyclic) {
+		period_idx =3D desc->completed_desc_num % desc->periods;
+		residue =3D (desc->periods - period_idx) * desc->period_size;
+		dma_set_residue(state, residue);
+	}
+out:
 	spin_unlock_irqrestore(&xdma_chan->vchan.lock, flags);

-	dma_set_residue(state, residue);
-
 	return ret;
 }

@@ -820,6 +823,7 @@ static irqreturn_t xdma_channel_isr(int irq, void *de=
v_id)
 	st &=3D XDMA_CHAN_STATUS_MASK;
 	if ((st & XDMA_CHAN_ERROR_MASK) ||
 		!(st & (CHAN_CTRL_IE_DESC_COMPLETED | CHAN_CTRL_IE_DESC_STOPPED))) {
+		desc->error =3D true;
 		xdma_err(xdev, "channel error, status register value: 0x%x", st);
 		goto out;
 	}
--
2.34.1

