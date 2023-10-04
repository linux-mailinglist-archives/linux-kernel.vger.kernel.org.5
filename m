Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099D77B8581
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbjJDQjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243442AbjJDQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:39:39 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE980C0;
        Wed,  4 Oct 2023 09:39:34 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8488240002;
        Wed,  4 Oct 2023 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696437573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MoL7tK/sFHlVwmkaF58wS2KqlyZYUgDZWDR3PVlkupE=;
        b=EeIP1pmbPB4UEYGgstYTh/lmdthejHe4/FFLflsZRL+bQMujIgkkiA5LkFtc1qnlK11wjZ
        n/THbQQkDOa88yXwfGKTa1fQbZKoHcze/VmgaCP/Rtw58Y9/3sTNbaM0Tooy6nn86su1F/
        C4iNR3Vz/wB22JnadJdYpeOM4JhhON1crG3J6DMHaxBPIccUp5ToUBOrQf25bzwBhEflaH
        SD13HVFaWua+Futq9F5QRi8pe1/vHKBhFjKbsYm1Z3cuDI8fsLR46Sz2+RXc5BdAQf4SUN
        2sVnc/1HqBgwg6kgMfpNTJn/AEUZIY1f8YCgvs4UtIELD9MQfMZyfO8d3bEnUQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
Date:   Wed, 04 Oct 2023 18:39:28 +0200
Subject: [PATCH 2/2] iio: accel: mxc4005: allow module autoloading via OF
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-mxc4005-device-tree-support-v1-2-e7c0faea72e4@bootlin.com>
References: <20231004-mxc4005-device-tree-support-v1-0-e7c0faea72e4@bootlin.com>
In-Reply-To: <20231004-mxc4005-device-tree-support-v1-0-e7c0faea72e4@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OF device table with compatible strings to allow automatic module
loading.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/iio/accel/mxc4005.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 75d142bc14b4..41182531feb5 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -476,6 +476,13 @@ static const struct acpi_device_id mxc4005_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
 
+static const struct of_device_id mxc4005_of_match[] = {
+	{ .compatible = "memsic,mxc4005", },
+	{ .compatible = "memsic,mxc6655", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mxc4005_of_match);
+
 static const struct i2c_device_id mxc4005_id[] = {
 	{"mxc4005",	0},
 	{"mxc6655",	0},
@@ -487,6 +494,7 @@ static struct i2c_driver mxc4005_driver = {
 	.driver = {
 		.name = MXC4005_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
+		.of_match_table = mxc4005_of_match,
 	},
 	.probe		= mxc4005_probe,
 	.id_table	= mxc4005_id,

-- 
2.34.1

