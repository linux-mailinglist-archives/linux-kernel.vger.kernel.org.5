Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B0B7985A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbjIHKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjIHKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:18:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913A41FD2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:18:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E15C433C9;
        Fri,  8 Sep 2023 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168220;
        bh=QWKOHqqURgmtO3ZvDYmsY240tss0yR6QDXZ96fNjlXU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=skfPeefwmRhzrds/Mozc7/ifU/aaLyLbOonFKcLqsZf1LtN3Sp5qCY8NKNfWnWTnV
         2QKhKXPtyRtLpPv/K209EMHIPWNRE0GJeze3RSVgtgKFfUQQLMfEOHSvyqb4oBClPs
         Cb3Gb+igO7NP4IKAaZ46wW2QfspiFhr2xymoScXwE/AE1HgGW7SX5umsZRs4gMQGV6
         LkMChMOKWf6h+BV/7+Puj6sSQgitFoCYNIJ4bGvg2CG+VerdyUdX0Oa77/kI8t+xcU
         bjIaZu5xykVuDWL+bVUbHfGXx/AB+th+ne6Y6q2Vieg2ostCUPOnXgA53TrKZGEfX+
         QgNsQmtot4/AA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:33 +0200
Subject: [PATCH v3 15/41] mtd: spi-nor: add SNOR_ID() and SNOR_OTP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-15-e60548861b10@kernel.org>
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

After all the preparation, it is now time to introduce the new macros to
specify flashes in our database: SNOR_ID() and SNOR_OTP(). An flash_info
entry might now look like:
    {
        .id = SNOR_ID(0xef, 0x60, 0x16),
        .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
        .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
    }

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/core.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6d1870d5484d..14c1aa63bc51 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -561,6 +561,20 @@ struct flash_info {
 	const struct spi_nor_fixups *fixups;
 };
 
+#define SNOR_ID(...)							\
+	(&(const struct spi_nor_id){					\
+		.bytes = (const u8[]){ __VA_ARGS__ },			\
+		.len = sizeof((u8[]){ __VA_ARGS__ }),			\
+	})
+
+#define SNOR_OTP(_len, _n_regions, _base, _offset)			\
+	(&(const struct spi_nor_otp_organization){			\
+		.len = (_len),						\
+		.base = (_base),					\
+		.offset = (_offset),					\
+		.n_regions = (_n_regions),				\
+	})
+
 #define SPI_NOR_ID_2ITEMS(_id) ((_id) >> 8) & 0xff, (_id) & 0xff
 #define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
 

-- 
2.39.2

