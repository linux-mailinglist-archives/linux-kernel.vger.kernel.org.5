Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73787772573
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjHGNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjHGNWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113CD26A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE72261AAC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E754C433CB;
        Mon,  7 Aug 2023 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414542;
        bh=lVNHe40ZD+qOohBgV1PoniWN1QEJCYIZ2y5SGmIv6ik=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BLzgVoV9Kw93tRTL4v19Z6zKs5jepRwI5NdutVFedJCOcVomkJkGqQcv5ZZuEGcpq
         tAZA5Hsj7rOvIs05mA6Mc8aJXbXQbcQn4iqen6YWw+0QHPj/MZ4Q7RC94kYfLmDjvr
         iuuHmh+nYiv+fjWriB+GBrumYyjczTn1tkXsWzleUHc9w4Gus0dloarTebDAQRkrwm
         iarBY1+C3moLn/4kKvx2ZenQdWAN3INCRmy3vzqo3hR8FGWyGv2/gqBt9hMgjjU4ds
         IqDMppSeQ2Pq9qrx1IiMg0M4LuhuvqdYkGtJJswCjcKnINEeThYCGbJc0lLuDaGx23
         PfhPscFx9RMJA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:08 +0200
Subject: [PATCH 14/41] mtd: spi-nor: rename .otp_org to .otp and make it a
 pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-14-3d3d5bef4ba4@kernel.org>
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

Move the OTP ops out of the flash_info structure. Besides of saving some
space, there will be a new macro SNOR_OTP() which can be used to set the
ops:
  .otp = SNOR_OTP(...),

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 drivers/mtd/spi-nor/core.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1319fcb97e16..06b34d9ad8a1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2977,7 +2977,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->otp.org = &info->otp_org;
+	params->otp.org = info->otp;
 
 	/* Default to 16-bit Write Status (01h) Command */
 	nor->flags |= SNOR_F_HAS_16BIT_SR;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 57272bb51eff..e26a17d11c14 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -555,7 +555,7 @@ struct flash_info {
 
 	u8 mfr_flags;
 
-	const struct spi_nor_otp_organization otp_org;
+	const struct spi_nor_otp_organization *otp;
 	const struct spi_nor_fixups *fixups;
 };
 
@@ -605,7 +605,7 @@ struct flash_info {
 		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
 
 #define OTP_INFO(_len, _n_regions, _base, _offset)			\
-		.otp_org = {						\
+		.otp = &(const struct spi_nor_otp_organization){	\
 			.len = (_len),					\
 			.base = (_base),				\
 			.offset = (_offset),				\

-- 
2.39.2

