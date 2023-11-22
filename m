Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DE7F5306
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjKVWL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjKVWLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:11:25 -0500
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41571D4F;
        Wed, 22 Nov 2023 14:11:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id 399FC2D00B67;
        Wed, 22 Nov 2023 23:11:19 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id myf48UbQDSqH; Wed, 22 Nov 2023 23:11:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by helios.alatek.com.pl (Postfix) with ESMTP id DE31B2D00B66;
        Wed, 22 Nov 2023 23:11:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl DE31B2D00B66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
        s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1700691078;
        bh=uZ+7hCD2vT8n0SaxTdHVUD9PS0Q6BCcg7P18KUDliew=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=ub4fzT4ygt8aOn+/jnwPW50jLQbpPDijox4ElW+v78BfJpHRHWKCQyu8YjrytjqVU
         lFcD1bco8NAaDw5TEFXPK1id6VTKWXIo7XXhuUDg9VaSJCd9P/WVtpn267AKtynv+U
         B2fyt0Hkxje5DqNaxT3Ew/xg5PQnHOY9CN4iGb4Y6snEgCNbWea13GUiKEdB/A63Xp
         R9/r0E2hdP4vPQM8yLLm6ufY8H5JyiExCWqBQBqXGiXm+4jEHkBsNPuZjOY/BHzRok
         QOMim/tlglzdJ2YVnp/zKCbO1+nUQ0jjSMv7mla6hcKhdI92UWDsycAxDlNsb48Lug
         ceZwUc8A2WkOg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id D11LkTmYqi1Q; Wed, 22 Nov 2023 23:11:18 +0100 (CET)
Received: from ideapad.. (unknown [10.0.2.2])
        by helios.alatek.com.pl (Postfix) with ESMTPSA id A68B92D00B64;
        Wed, 22 Nov 2023 23:11:18 +0100 (CET)
From:   Jan Kuliga <jankul@alatek.krakow.pl>
To:     lizhi.hou@amd.com, brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        vkoul@kernel.org, michal.simek@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jan Kuliga <jankul@alatek.krakow.pl>
Subject: [PATCH 5/5] dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
Date:   Wed, 22 Nov 2023 23:09:21 +0100
Message-Id: <20231122220921.117428-6-jankul@alatek.krakow.pl>
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
index dc7f43f17103..9e382ce524a4 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -730,9 +730,9 @@ static int xdma_alloc_chan_resources(struct dma_chan =
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

