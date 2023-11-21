Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9F7F2A10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjKUKRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjKUKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1250011C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 756A9C433CD;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=0BvXHNAq6MxvTFFypFKVLfm202ysR+MbTta68aDgcfw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=eM9cxBHG3fTojuudhsxbw1lZ7Gau0JELf/VvK07u5vpOTcme0gJ4xu+Itj8nCrBSS
         pQ69EQgUShyyhjHqyvtNK2fVLPjWzmn3347UIdDPX5pmrsJ9BNyBTiTtY5sWz3020C
         1pF2EKHPSBIM7uYjXbgTbtpIiVU8tqs+yJIhruao5qJns1oBXNxyzQgSuqsAuc5rj5
         j/4tC4i/BSgLYG/bNh5GL4Lb/bNJZgxQBh9frk9hEv1o+hRZ74LtQrT9pUsmM0NKwJ
         Mddy82xhpqFXPLV5KIcEOMEJ6uUrRPtQ/JJQjqjP0EiQQXm3lH0T31LaKT20IKzTiv
         Rj83/7XWraOOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 63334C61D92;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:19 +0100
Subject: [PATCH 06/12] iio: adc: ad9467: add mutex to struct ad9467_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=1622;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=g3tcVMAWnAaNpfd4zR0L8lXR29z5KekLRZe6sxMF/hk=;
 b=c73pLlPBK+gRvwbzpMIaQzg2/RJK0F0Puv/XvfzcIUdIwAgeIeOujPcKeq6HBext2kU07mya6
 y+9u9e194XEB1j4VRHh9o3JjEgyQO25ay/PCBtt95QyHrc9TUVacvKt
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

When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
are done which means we need to properly protect the whole operation so
we are sure we will be in a sane state if two concurrent calls occur.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 04474dbfa631..91821dee03b7 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2012-2020 Analog Devices Inc.
  */
-
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -122,6 +122,8 @@ struct ad9467_state {
 	unsigned int			output_mode;
 
 	struct gpio_desc		*pwrdown_gpio;
+	/* protect against concurrent accesses to the device */
+	struct mutex			lock;
 };
 
 static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
@@ -162,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	int ret;
 
 	if (!readval) {
+		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(spi, reg, writeval);
 		if (ret)
 			return ret;
@@ -310,6 +313,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
+		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
 				       info->scale_table[i][1]);
 		if (ret < 0)

-- 
2.42.1

