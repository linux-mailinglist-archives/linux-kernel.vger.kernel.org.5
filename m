Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0815979858B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbjIHKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbjIHKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:16:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3171BC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:16:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605EDC433C8;
        Fri,  8 Sep 2023 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168195;
        bh=p5Y5K3Xbj3iXrfruziYXy2/bPOWNRacEU1TN2LbDodw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gT/7RouDaSzng4+dO2Oq3SstNK6cknSRBZbW09iClfhvgxZF1BwBs1D/uEKs05OSd
         LBJT9OStYXFQWlJ9maLFEBcQCSoNRh2ivHzuvJkKNV32ZO7kAPxgoJYRPxfmv7plGf
         NqdHClwyRV2GvxF9zHyQpa0GdtsQ8mj3rCcGJYJIeB638D5Czoabz1FMdNAM6y1WZ8
         ob8klZ8pEjVEf+hzcxaCpYWOmQVKEePPSYC4HUI3wYXFzwhLJSp563AY3p2aCPXtKP
         yCR/H8s09X5EfXFW3gQaf04Z/L27RGh4AY/4eTrIEQAyKaoePlyEsD6viKoJWHttkn
         +wO7+B2I3QIGg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:21 +0200
Subject: [PATCH v3 03/41] mtd: spi-nor: xilinx: use SPI_NOR_ID() in
 S3AN_INFO()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-3-e60548861b10@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 59273180299a ("mtd: spi-nor: Create macros to define chip IDs
and geometries") SPI_NOR_ID() were introduced, but it did only update
the INFO() macro in core.h. Also use it in S3AN_INFO().

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
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

