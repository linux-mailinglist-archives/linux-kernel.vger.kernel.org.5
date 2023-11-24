Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08567F846D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbjKXT05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbjKXT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:26:47 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443C30F6;
        Fri, 24 Nov 2023 11:26:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 433D32CE00DC;
        Fri, 24 Nov 2023 20:26:50 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id zks-Igk9_28N; Fri, 24 Nov 2023 20:26:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 9F68C2CE00DA;
        Fri, 24 Nov 2023 20:26:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 9F68C2CE00DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700854009;
        bh=iavZyvPckMzvsc4PJ76HGqTRtzDPAKaZ+PAcAb4Ooms=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=NXuMCyTfUxMoRSTat1fhRymXai4F4TUn3SdDVzUBue580t1n4Ul99zVtpOFwgxlu1
         UIx9hQBXqR8ayg57kTDkhPKhT/miGEzjdqvF893OPPY4EK3ctxVOdaps8lkqHp4vxT
         ZUA6Lr8RBSZn6chMlbRlaK2P+t6rs3/l3q3SkPxUn/9ZNR0st6yAIK8R4esh+/YlRy
         AssQWo3rQ01MGme7859AEC4sHV+AWoDvy8l/cCocBAPMSUhMEVkmEEnJLV/3cG3aMx
         /p1XUMBvqyEa2rQLKCDFOJy5ENIo2gBHRX8lDXGl4zykPd4D8Z4SR51zT2KCSH3ffd
         EisC6gCVjD1Hg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id slmmGsWKQuNK; Fri, 24 Nov 2023 20:26:49 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id 63BBF2CE00D9;
        Fri, 24 Nov 2023 20:26:49 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, runtimeca39d@amd.com
Cc:     Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH v3 5/5] dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
Date:   Fri, 24 Nov 2023 20:25:58 +0100
Message-Id: <20231124192558.135004-6-jankul@alatek.krakow.pl>
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

According to the XDMA datasheet (PG195), the address of any descriptor
must be 32 byte aligned. The datasheet also states that a contiguous
block of descriptors must not cross a 4k address boundary. Therefore,
it is possible to ease the pressure put on the dma_pool allocator
just by requiring sufficient alignment and boundary values. Add proper
macro definition and change the values passed into the
dma_pool_create().

Signed-off-by: Jan Kuliga <jankul@alatek.krakow.pl>
---
 drivers/dma/xilinx/xdma-regs.h | 7 ++++---
 drivers/dma/xilinx/xdma.c      | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xdma-regs.h b/drivers/dma/xilinx/xdma-reg=
s.h
index 6bf7ae84e452..d5cb12e6b8d4 100644
--- a/drivers/dma/xilinx/xdma-regs.h
+++ b/drivers/dma/xilinx/xdma-regs.h
@@ -64,9 +64,10 @@ struct xdma_hw_desc {
 	__le64		next_desc;
 };
=20
-#define XDMA_DESC_SIZE		sizeof(struct xdma_hw_desc)
-#define XDMA_DESC_BLOCK_SIZE	(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
-#define XDMA_DESC_BLOCK_ALIGN	4096
+#define XDMA_DESC_SIZE			sizeof(struct xdma_hw_desc)
+#define XDMA_DESC_BLOCK_SIZE		(XDMA_DESC_SIZE * XDMA_DESC_ADJACENT)
+#define XDMA_DESC_BLOCK_ALIGN		32
+#define XDMA_DESC_BLOCK_BOUNDARY	4096
=20
 /*
  * Channel registers
diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index de4615bd4ee5..d32ae93e18b6 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -735,9 +735,9 @@ static int xdma_alloc_chan_resources(struct dma_chan =
*chan)
 		return -EINVAL;
 	}
=20
-	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan),
-					       dev, XDMA_DESC_BLOCK_SIZE,
-					       XDMA_DESC_BLOCK_ALIGN, 0);
+	xdma_chan->desc_pool =3D dma_pool_create(dma_chan_name(chan), dev,
+				XDMA_DESC_BLOCK_SIZE, XDMA_DESC_BLOCK_ALIGN,
+						XDMA_DESC_BLOCK_BOUNDARY);
 	if (!xdma_chan->desc_pool) {
 		xdma_err(xdev, "unable to allocate descriptor pool");
 		return -ENOMEM;
--=20
2.34.1

