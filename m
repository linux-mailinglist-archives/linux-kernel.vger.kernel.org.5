Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE82772568
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjHGNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjHGNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE13E5D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A077461AF3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C247C433CA;
        Mon,  7 Aug 2023 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414519;
        bh=yto9V/zcEZBJmLMoKJpHfJ7xX1RdTjUYPmlgcSHSm3Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kXuN0prHwGPVCahFWS//CQaPPVvH11sUVgV4r4qQLljoqKaX8pye+QPhqCE0dbVHG
         Gpk7wL2o1SMKCWKManNbhZlmJsrwPGlqWKu0fMAW0tqGsNkg9OaG6Khh3et9goP8DR
         aowt7gIUQephCNrarYevOQi8Tsfxp3uIpbg9EpoK+jx8KIaXJgCRLKCPxlsJo/3VeK
         5ZrJMcybwOWPhkw/K35BtAJSmVa5SrqL/PRW+etTkRP6SqDo7vCxfmhhsGpFDGKhBb
         DoZqpUJmrbneZsUaDKUYu8KypW484yNIwRLzplQYaCreT5I3KmTC4TI4cINsTcdIQ2
         QgfRFebXvXMWw==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:20:57 +0200
Subject: [PATCH 03/41] mtd: spi-nor: xilinx: use SPI_NOR_ID() in
 S3AN_INFO()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-3-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 59273180299a ("mtd: spi-nor: Create macros to define chip IDs
and geometries") SPI_NOR_ID() were introduced, but it did only update
the INFO() macro in core.h. Also use it in S3AN_INFO().

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/xilinx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index 00d53eae5ee8..de5189c38432 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -22,12 +22,7 @@
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
 #define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
-		.id = {							\
-			((_jedec_id) >> 16) & 0xff,			\
-			((_jedec_id) >> 8) & 0xff,			\
-			(_jedec_id) & 0xff				\
-			},						\
-		.id_len = 3,						\
+		SPI_NOR_ID(_jedec_id, 0),				\
 		.sector_size = (8 * (_page_size)),			\
 		.n_sectors = (_n_sectors),				\
 		.page_size = (_page_size),				\

-- 
2.39.2

