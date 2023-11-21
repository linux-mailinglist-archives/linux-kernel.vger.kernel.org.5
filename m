Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6E7F2A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjKUKSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjKUKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309B134
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCEAAC433B7;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=3jqcpmMVgRdlV0OZKCqw9abAHNIj6Mrrp0uhYEWv1Tw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=MG22fP/8IbSk4s4y1vLdBrnoBg+zYmS0SAke44UgfmDz21OKuqfGt4MAF3OK+JWLl
         HSfavn7vxUR1o6bUUTQVNrOujw41oh/yjAV7vmM2OOqtgVHLW+QuM3rayrrUhd5SaX
         kNB3U5tO65hb5BNIoB0fE6BxIcwtI5y1Q8w7dWwuWM6S+gBGUcrB/Rm+UuClPVPTOX
         5aG04NOEmjBYdniXWXzx3pQxCM6H9/ofZFt8cyacAMQYYlsWPVUKKkuwDkN8s8bp0B
         Wcgehwn7348Unz8ppoiDBevUFpnbzAxM/LCQBLHRPoZRtIQ5kf+40sfvnAuGPVT42n
         ZdIoBP6JzXmEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id A924DC5ACB3;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:22 +0100
Subject: [PATCH 09/12] iio: adc: ad9467: use chip_info variables instead of
 array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-9-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=4457;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vkbr36xjXuQW5nYydBocFuU8wGwlSsFvoY57jHRaH1w=;
 b=He0UNjSCXL2IIli4eBSKtEN63uAMX1iX8sAVvjSjiwnMjnttPr8caWXTQQjkZG7/HQauGJe4v
 gsLvTYTUJw8AkRva2t7rNxuOc9TIj9MRnodf6mbaPiFcZGIUmpJ591x
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

Instead of having an array and keeping IDs for each entry of the array,
just have a chip_info struct per device.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 89 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index f0342c8942ee..5db5690ccee8 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -101,12 +101,6 @@
 #define AD9467_DEF_OUTPUT_MODE		0x08
 #define AD9467_REG_VREF_MASK		0x0F
 
-enum {
-	ID_AD9265,
-	ID_AD9434,
-	ID_AD9467,
-};
-
 struct ad9467_chip_info {
 	struct adi_axi_adc_chip_info	axi_adc_info;
 	unsigned int			default_output_mode;
@@ -234,43 +228,46 @@ static const struct iio_chan_spec ad9467_channels[] = {
 	AD9467_CHAN(0, 0, 16, 'S'),
 };
 
-static const struct ad9467_chip_info ad9467_chip_tbl[] = {
-	[ID_AD9265] = {
-		.axi_adc_info = {
-			.id = CHIPID_AD9265,
-			.max_rate = 125000000UL,
-			.scale_table = ad9265_scale_table,
-			.num_scales = ARRAY_SIZE(ad9265_scale_table),
-			.channels = ad9467_channels,
-			.num_channels = ARRAY_SIZE(ad9467_channels),
-		},
-		.default_output_mode = AD9265_DEF_OUTPUT_MODE,
-		.vref_mask = AD9265_REG_VREF_MASK,
+static const struct ad9467_chip_info ad9467_chip_tbl = {
+	.axi_adc_info = {
+		.name = "ad9467",
+		.id = CHIPID_AD9467,
+		.max_rate = 250000000UL,
+		.scale_table = ad9467_scale_table,
+		.num_scales = ARRAY_SIZE(ad9467_scale_table),
+		.channels = ad9467_channels,
+		.num_channels = ARRAY_SIZE(ad9467_channels),
 	},
-	[ID_AD9434] = {
-		.axi_adc_info = {
-			.id = CHIPID_AD9434,
-			.max_rate = 500000000UL,
-			.scale_table = ad9434_scale_table,
-			.num_scales = ARRAY_SIZE(ad9434_scale_table),
-			.channels = ad9434_channels,
-			.num_channels = ARRAY_SIZE(ad9434_channels),
-		},
-		.default_output_mode = AD9434_DEF_OUTPUT_MODE,
-		.vref_mask = AD9434_REG_VREF_MASK,
+	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
+	.vref_mask = AD9467_REG_VREF_MASK,
+};
+
+static const struct ad9467_chip_info ad9434_chip_tbl = {
+	.axi_adc_info = {
+		.name = "ad9434",
+		.id = CHIPID_AD9434,
+		.max_rate = 500000000UL,
+		.scale_table = ad9434_scale_table,
+		.num_scales = ARRAY_SIZE(ad9434_scale_table),
+		.channels = ad9434_channels,
+		.num_channels = ARRAY_SIZE(ad9434_channels),
 	},
-	[ID_AD9467] = {
-		.axi_adc_info = {
-			.id = CHIPID_AD9467,
-			.max_rate = 250000000UL,
-			.scale_table = ad9467_scale_table,
-			.num_scales = ARRAY_SIZE(ad9467_scale_table),
-			.channels = ad9467_channels,
-			.num_channels = ARRAY_SIZE(ad9467_channels),
-		},
-		.default_output_mode = AD9467_DEF_OUTPUT_MODE,
-		.vref_mask = AD9467_REG_VREF_MASK,
+	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
+	.vref_mask = AD9434_REG_VREF_MASK,
+};
+
+static const struct ad9467_chip_info ad9265_chip_tbl = {
+	.axi_adc_info = {
+		.name = "ad9265",
+		.id = CHIPID_AD9265,
+		.max_rate = 125000000UL,
+		.scale_table = ad9265_scale_table,
+		.num_scales = ARRAY_SIZE(ad9265_scale_table),
+		.channels = ad9467_channels,
+		.num_channels = ARRAY_SIZE(ad9467_channels),
 	},
+	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
+	.vref_mask = AD9265_REG_VREF_MASK,
 };
 
 static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
@@ -505,17 +502,17 @@ static int ad9467_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad9467_of_match[] = {
-	{ .compatible = "adi,ad9265", .data = &ad9467_chip_tbl[ID_AD9265], },
-	{ .compatible = "adi,ad9434", .data = &ad9467_chip_tbl[ID_AD9434], },
-	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
+	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
+	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
+	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
 
 static const struct spi_device_id ad9467_ids[] = {
-	{ "ad9265", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9265] },
-	{ "ad9434", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9434] },
-	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl[ID_AD9467] },
+	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
+	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
+	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad9467_ids);

-- 
2.42.1

