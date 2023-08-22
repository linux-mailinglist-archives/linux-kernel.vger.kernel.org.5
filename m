Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662C2783A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjHVHLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjHVHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98851A5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:10:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5403649E9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AACC433CC;
        Tue, 22 Aug 2023 07:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688204;
        bh=ZU2Q5S8n0WBM33+d5apjMFKUzdUvVi8jQVBjbDv54Zo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CLpFl8rdoJ0R6kk2mTdBt/4eZwu6kCVd5JURG9mxSKaP3NPXSf/YHb2WLGLXKZkcv
         tbS2Me1I+qtzw5Q2e/cykCBwrkObgHz0PtWBzhj1ZHDXAgMorXbVRQbtEQkQEP75JT
         guEyQt7rb97+xz56hKkm9/6XDTnu0iVOj/5tfqfTzneJyPM6mr13KlzSqsboVltws/
         6RIbRfnNncd1oE6jeCTHFkJbgTc+L5TozmwXP4g3k7xq/q8w6wxiue+uKdmr/cgJbL
         SVxgjmS+jbmnv70KrVWBMOgYGenjFmK1+8S9tyapLBQB3Tg2pDDELpM6MrWW5wHiYC
         FSvgnt1lgxitg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:30 +0200
Subject: [PATCH v2 14/41] mtd: spi-nor: rename .otp_org to .otp and make it
 a pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-14-291a0f39f8d8@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 81535f31907f..c22f5cf65a58 100644
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

