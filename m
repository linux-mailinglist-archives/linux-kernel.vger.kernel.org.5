Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFEB7F2A15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjKUKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjKUKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10031113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65C59C43215;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=qSUa7Hi/hUvGOoV6T8t+VfM63v3j7nIpVAXf0Nwefts=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=qWgIDHcjtrnHnJCZozZC23X8yKhhvdi6PscYnSnqGN/hur4B5WMyBBAgV9hbRKEHl
         Q5X15wT0LX9tPbiAun3N0ifbMEt+pKH+ztuPEdUESZGPk0WrwNsJ39eCLaFq4lJFpO
         gcBVv/nXhkcEQJt7RxSUJcIKJH0dwXazuVsqWMnqCoOP4YRJzE5Mx7oTAiRBL1Q14e
         mOECvk9dPv1Iy41EndovdhNow/5t8UDqGwDHmwY7PkkmgjIxc42OShjd7AVvcO97Zp
         5gfPdvexpN36clBpRCL9MZb8fE90mzGe8xrqjmhw1qXxQqhEqrAZuEAKIvhYBdB+TR
         gh6/HQUOz5aEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 554F2C61D88;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:18 +0100
Subject: [PATCH 05/12] iio: adc: ad9467: don't ignore error codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-5-6a3d542eba35@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=2285;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=p+reK//8NVmJckTKVuZ5PeMlMhxvLT/SuRjMD0wgKfo=;
 b=R49EuewoiHYxiFgzjwcP3nIvMmY3PaNku9HMivMl6qBa1cAQ4vL1PO2YimCWCUzwwgQil7p41
 rK7JWGwGhYhAXTFw/8uQ5/zSJbi1frMDouMhKua7NwtA37UYKhmdp5O
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

Make sure functions that return errors are not ignored.

Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 368ea57be117..04474dbfa631 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -160,11 +161,12 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	struct spi_device *spi = st->spi;
 	int ret;
 
-	if (readval == NULL) {
+	if (!readval) {
 		ret = ad9467_spi_write(spi, reg, writeval);
-		ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
-				 AN877_ADC_TRANSFER_SYNC);
-		return ret;
+		if (ret)
+			return ret;
+		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	ret = ad9467_spi_read(spi, reg);
@@ -274,6 +276,8 @@ static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
 	unsigned int i, vref_val;
 
 	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+	if (vref_val < 0)
+		return vref_val;
 
 	vref_val &= info1->vref_mask;
 
@@ -296,6 +300,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
 	unsigned int scale_val[2];
 	unsigned int i;
+	int ret;
 
 	if (val != 0)
 		return -EINVAL;
@@ -305,11 +310,13 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
 		if (scale_val[0] != val || scale_val[1] != val2)
 			continue;
 
-		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
-				 info->scale_table[i][1]);
-		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
-				 AN877_ADC_TRANSFER_SYNC);
-		return 0;
+		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
+				       info->scale_table[i][1]);
+		if (ret < 0)
+			return ret;
+
+		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
 	}
 
 	return -EINVAL;

-- 
2.42.1

