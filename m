Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D37CBCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJQHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjJQHr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:47:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2C95
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:47:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50797cf5b69so4928493e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697528841; x=1698133641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bICu1GqEvASkF3QTCjaB9iY9vbiHktzihLzzDCRLjzo=;
        b=GBvdzaRa6yMVbdMCJbkjr21iCg9N7nW7XXVVmvvfKV3mAkkyf+ZASA0i02MlrPHSug
         liq5Fkx27TzyIL3cSsA5j4jmMCpJuMc4ubu4u7+RsNPk/KAm9hFCTE/x2WVsl0Iq8gbq
         hnx3lHTtAgXml5zQw+C88mlHY8UkRZZe3nJ9gEto1+vzfQusPAES2iS8VX/pa/qyvH10
         y+t5EvE1+AHAlJBS+bXY9F6yG0WFGdheMFO9z/8bRB8fev8Z0vdWzPP8roBpA3e7QE5y
         FcfeVOoyb+4+VyFhAPf4tLZ0whK1O0XAXrx5RH/h6d9jVP/gywgKYzTnjXByFrDBGSGP
         ogag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697528841; x=1698133641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bICu1GqEvASkF3QTCjaB9iY9vbiHktzihLzzDCRLjzo=;
        b=WBs4PTH3z3wwnyylV6eO8x8wZebTmujegWPM41HYGqeRbIHwgeGDa5Jub+ylH/WPFp
         4WiidJDChHQHx/Rk2oBGK5RecfuwdiTA6J2BZ9PfvJ5uSNO9CZvAjJF4gLrtE60Q0//1
         oreBhsGICo+eh8F+8tasyoqE/cs/Mf3LIqepLalJlBa6Dsx1PNIR/Dl35V/b2+vWoXRE
         4JpFtAPvRl59/iNwPdABlWyeqYri20Y1X1PXSS8qNQN8Hgs3safk+yP48tcOJyo2QXRW
         gHEOPJKNab1LQ1LVofOGdp/61WtrW0ZwpeX7z0S06hjjd1u4dmmPW84zbKtl+l9p1Yh0
         jzTQ==
X-Gm-Message-State: AOJu0YwugZOu0t8ZrtJhacU+q2wvMCMHIeK2NzO45zfKZx+gbvAlTgYZ
        fiQeKR9HOS2jXQJVWV9+yWsSrg==
X-Google-Smtp-Source: AGHT+IGFf3vvTJ2uau564lVggc/4H2caGhnGuivhtBz6PsH5Rx/6g4C/CoeFFRi5ToHprly3jDf5YA==
X-Received: by 2002:a05:6512:3ca9:b0:507:aad2:96af with SMTP id h41-20020a0565123ca900b00507aad296afmr1567303lfv.21.1697528841097;
        Tue, 17 Oct 2023 00:47:21 -0700 (PDT)
Received: from 1.. ([213.233.104.181])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b0053db1ca293asm718688edb.19.2023.10.17.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:47:20 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamta.shukla@leica-geosystems.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 2/2] mtd: spi-nor: micron-st: use SFDP table for mt25qu512a
Date:   Tue, 17 Oct 2023 10:47:11 +0300
Message-Id: <20231017074711.12167-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017074711.12167-1-tudor.ambarus@linaro.org>
References: <20231017074711.12167-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=tudor.ambarus@linaro.org; h=from:subject; bh=FS2q6zrOmfpSOtiknrC9GrXWj5PLgtLxG87Opf7GBTE=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlLjv+EexaOpz77Pk52gOho3pNYcyalUboB4xuo u2WgCUmFLKJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZS47/gAKCRBLVU9HpY0U 6TxJB/sEGjLjyJCMlPNiyldxpiZEBRNaZ034R4s01nusA2GUizqc1S7tOMpaY4xA0qxoZX7Kv0W kb2o24Vi7KGPP5sbumW/3x0xzuYzPjXEzSd+C+0NK7/5LJxkHfdVcCJ6H6OE82zMA7v2S/Qw7Ph U/7fBfASavWumCwa/dJ/14kZFIkAshuaYZmGhhUGpuKa5OAgHNfhTPXBiFax7RRkVFMv6TjtLWX wXELkXrQVN9Vpq7+q6iD0B13DzAwGHIIYpj06baut+V/PS7c/S41IQ3t+q1hrbtNUzhHo9YzXnf C8jcpbHXxip4m3TwNksJTBFu5zgGVxkdqeGBmjdHpurwcZ0J
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mamta Shukla <mamta.shukla@leica-geosystems.com>

Parse SFDP table to get size and functions of mt25qu512a. BFPT wrongly
advertises 16bit SR support and made the locking fail. Add a post BFPT
fixup hook to clear the 16bit SR support.

cat /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/jedec_id
20bb20104400

cat /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/manufacturer
st

cat /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/partname
mt25qu512a

xxd -p  /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/sfdp
53464450060101ff00060110300000ff84000102800000ffffffffffffff
ffffffffffffffffffffffffffffffffffffe520fbffffffff1f29eb276b
273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
03e1ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
ffffffffffffffffffe7ffff21dcffff

md5sum  /sys/bus/spi/devices/spi-PRP0001:00/spi-nor/sfdp
610efba1647e00ac6db18beb11e84c04
/sys/bus/spi/devices/spi-PRP0001:00/spi-nor/sfdp

Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/micron-st.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 756391c906e5..8920547c12bf 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -180,6 +180,18 @@ static const struct flash_info micron_nor_parts[] = {
 	},
 };
 
+static int mt25qu512a_post_bfpt_fixup(struct spi_nor *nor,
+				      const struct sfdp_parameter_header *bfpt_header,
+				      const struct sfdp_bfpt *bfpt)
+{
+	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
+	return 0;
+}
+
+static struct spi_nor_fixups mt25qu512a_fixups = {
+	.post_bfpt = mt25qu512a_post_bfpt_fixup,
+};
+
 static const struct flash_info st_nor_parts[] = {
 	{
 		.name = "m25p05-nonjedec",
@@ -407,10 +419,8 @@ static const struct flash_info st_nor_parts[] = {
 		.name = "mt25qu512a",
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
 			 SPI_NOR_BP3_SR_BIT6,
-		.size = SZ_64M,
-		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
 		.mfr_flags = USE_FSR,
+		.fixups = &mt25qu512a_fixups,
 	}, {
 		.id = SNOR_ID(0x20, 0xbb, 0x20),
 		.name = "n25q512a",
-- 
2.34.1

