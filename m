Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FE7985A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbjIHKSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbjIHKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:18:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F21213E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 03:17:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE35DC4339A;
        Fri,  8 Sep 2023 10:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168218;
        bh=AJHIitoloNWfRd5lKhp4V4mLHLnTlHTr9ZGvn4sDt+U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=i989L7XhHJsOJWNi35krvoh68IOegTz48kZVl2g92uZRSuTxhRnprY6lxDzcxIs0H
         5JPULQcgdVi6EwDlNG4GXBSu8q8B0/zkc9zsrc6sxjmygFfwsZIdyy8XmbUPiSsxc1
         QhyPrvKptCu1CKmxbK6EB55/36LV1lqUKyFTzGFxp1zmuL4ir6jUeMbnMTVktMqmpv
         0PzEgdRRLSQGERMg6ZdZmRvhDXOVoNNJkcpDWHofLzjivGLOixizkI+lwnGgEJX9SP
         vBrlMRRx4oygfOReoVC4qphAErCaUxSNG4mFBBQuTEI4xGjRL5uS80TdeyMkv1q2X0
         ldCqTTQMPe1vg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 08 Sep 2023 12:16:32 +0200
Subject: [PATCH v3 14/41] mtd: spi-nor: rename .otp_org to .otp and make it
 a pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v3-14-e60548861b10@kernel.org>
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

Move the OTP ops out of the flash_info structure. Besides of saving some
space, there will be a new macro SNOR_OTP() which can be used to set the
ops:
  .otp = SNOR_OTP(...),

Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
v3:
 - fix winbond_nor_late_init(), test for NULL pointer
---
 drivers/mtd/spi-nor/core.c    | 2 +-
 drivers/mtd/spi-nor/core.h    | 4 ++--
 drivers/mtd/spi-nor/winbond.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 80c340c7863a..1c443fe568cf 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2978,7 +2978,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->otp.org = &info->otp_org;
+	params->otp.org = info->otp;
 
 	/* Default to 16-bit Write Status (01h) Command */
 	nor->flags |= SNOR_F_HAS_16BIT_SR;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index fc6c8ddedc2f..6d1870d5484d 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -557,7 +557,7 @@ struct flash_info {
 
 	u8 mfr_flags;
 
-	const struct spi_nor_otp_organization otp_org;
+	const struct spi_nor_otp_organization *otp;
 	const struct spi_nor_fixups *fixups;
 };
 
@@ -607,7 +607,7 @@ struct flash_info {
 		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,		\
 
 #define OTP_INFO(_len, _n_regions, _base, _offset)			\
-		.otp_org = {						\
+		.otp = &(const struct spi_nor_otp_organization){	\
 			.len = (_len),					\
 			.base = (_base),				\
 			.offset = (_offset),				\
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 7873cc394f07..ecf52b9e3148 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -217,7 +217,7 @@ static int winbond_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
-	if (params->otp.org->n_regions)
+	if (params->otp.org)
 		params->otp.ops = &winbond_nor_otp_ops;
 
 	/*

-- 
2.39.2

