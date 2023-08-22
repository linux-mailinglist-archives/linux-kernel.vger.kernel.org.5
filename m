Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F22783A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjHVHLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjHVHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96F6E52
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF60A64D6B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F37C433CA;
        Tue, 22 Aug 2023 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692688206;
        bh=1BqJXay47IJkDiLieyHrXUXTDhVgV0Z2mEF/bEZLRbo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=MfbuYVyqfTz+LJxpA3Vvlht5s9QxfQq07qdNfo7uh1io30zLA/F8vF2IUFWl+JTBX
         E6BitISMs6u8vHDOVb2PNMTkiQoSXakdRGY1kjqPdgtmr1PZmy2Lx0UAh/XHPnTmR6
         GHobdbYGm9u2v8d2d7L/Mpxv0+1oS+n6zNLpylLjHEGrW6vP/ZBjhAa//WbE+Chptj
         5h9WLfPU7yiLz1dAzGJ9oHJR79OLM6aZ4z1ZsrG85Pb0S75WEX6jEpFuhMIx/f2pX5
         Bu8Ll+FJBfaB7Y6l2fYSmxzkv9D2ZZaIB9Rl6Wf/UbAxTJZW9ZX693zPBOyX0g2AaM
         kDAek4EHWz10g==
From:   Michael Walle <mwalle@kernel.org>
Date:   Tue, 22 Aug 2023 09:09:31 +0200
Subject: [PATCH v2 15/41] mtd: spi-nor: add SNOR_ID() and SNOR_OTP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v2-15-291a0f39f8d8@kernel.org>
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
---
 drivers/mtd/spi-nor/core.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index c22f5cf65a58..420e5ca2cfe1 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -559,6 +559,20 @@ struct flash_info {
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

