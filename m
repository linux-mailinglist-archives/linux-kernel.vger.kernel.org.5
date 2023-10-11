Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B257C5989
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376273AbjJKQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbjJKQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:48:28 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977EF8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:48:24 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id qYv9q52wkMZBkqcNkqXoAP; Wed, 11 Oct 2023 16:48:24 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id qcNhqvgjic2SQqcNjqY5by; Wed, 11 Oct 2023 16:48:24 +0000
X-Authority-Analysis: v=2.4 cv=JIYoDuGb c=1 sm=1 tr=0 ts=6526d1d8
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=J9R/PiKqv2o3jGxbVGXx4w==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=bhdUkHdE2iEA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=IAJAY4PeTjA2mm825RAA:9
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tFyva4Q9jWPeOZMrGywen6tgCDCkf6/RuFRJk5iEinI=; b=hQRDnBeeRKphaGpWKMTzJSa93B
        oBwtFjUmCPot+IA3es+n7mk+w3j4dTcYzFAMk0CjtMgZOa9UFz+RH6GOmX42+4ntBJQ2o72CAKKkg
        I4pe76D41p76QaTlW5vXkJ21dhymk6/rim/LO9cc6trIHJ0LSTMLbA8Qj21ir2kJuO5vM79LtJgg1
        M0wUvXlLcJSvPo23qDSoom1S9UAe4aGHU5+sm/+DhGzqP7I4xvrlxeFGUYSFZBvkCZ5xgzanTtUg3
        GbTWcLmIvgAf8UzIS2DugHzzxAkSwxkyW04vEEOZtZ7/8wXL+aYLg4zuz30MPotr7HxIpLDWD8bYh
        fUdeINuw==;
Received: from [103.186.120.251] (port=36530 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <saravanan@linumiz.com>)
        id 1qqcNg-002Xlh-0u;
        Wed, 11 Oct 2023 22:18:20 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v4 4/4] hwmon: (pmbus/mpq2286) Add a support for mpq2286 Power Management IC
Date:   Wed, 11 Oct 2023 22:17:54 +0530
Message-Id: <20231011164754.449399-5-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011164754.449399-1-saravanan@linumiz.com>
References: <20231011164754.449399-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 103.186.120.251
X-Source-L: No
X-Exim-ID: 1qqcNg-002Xlh-0u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.186.120.251]:36530
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 47
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOP9RNV9QZ9Tjg7EbTh0+2eJjZYJ85jg6sGBzWuH6NSk/8Dd6sTTopW8J0J2dlWkTdrw6urBB8dfQ2heGSWhmMTYSfKfUddYuGzX00OOW4YSUTYviAta
 j5pHrjU8nW9fw5XNFPXnOq/G623eLDWb9UhF1d2ufbzLI+AfOjQXFxIcy/hWZDotKiR/n3G+PGVpGkP3GIQxL6DDZEUZuufpMpo=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPQ2286 is a programmable, high frequency synchronous buck regulator
designed to power a variety of Automotive system peripherals. Single buck
converters with hardware monitoring capability is configurable over PMBus
interface.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 drivers/hwmon/pmbus/mpq7932.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
index 723c314a57a2..67487867c70f 100644
--- a/drivers/hwmon/pmbus/mpq7932.c
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -21,6 +21,7 @@
 #define MPQ7932_N_VOLTAGES		256
 #define MPQ7932_VOUT_MAX		0xFF
 #define MPQ7932_NUM_PAGES		6
+#define MPQ2286_NUM_PAGES		1
 
 #define MPQ7932_TON_DELAY		0x60
 #define MPQ7932_VOUT_STARTUP_SLEW	0xA3
@@ -48,6 +49,11 @@ static struct regulator_desc mpq7932_regulators_desc[] = {
 	PMBUS_REGULATOR_STEP("buck", 5, MPQ7932_N_VOLTAGES,
 			     MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
 };
+
+static const struct regulator_desc mpq7932_regulators_desc_one[] = {
+	PMBUS_REGULATOR_STEP_ONE("buck", MPQ7932_N_VOLTAGES,
+				 MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
+};
 #endif
 
 static int mpq7932_write_word_data(struct i2c_client *client, int page, int reg,
@@ -116,7 +122,10 @@ static int mpq7932_probe(struct i2c_client *client)
 
 #if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
 	info->num_regulators = info->pages;
-	info->reg_desc = mpq7932_regulators_desc;
+	if (info->num_regulators == 1)
+		info->reg_desc = mpq7932_regulators_desc_one;
+	else
+		info->reg_desc = mpq7932_regulators_desc;
 #endif
 
 	info->read_word_data = mpq7932_read_word_data;
@@ -129,12 +138,14 @@ static int mpq7932_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mpq7932_of_match[] = {
+	{ .compatible = "mps,mpq2286", .data = (void *)MPQ2286_NUM_PAGES },
 	{ .compatible = "mps,mpq7932", .data = (void *)MPQ7932_NUM_PAGES },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpq7932_of_match);
 
 static const struct i2c_device_id mpq7932_id[] = {
+	{ "mpq2286", },
 	{ "mpq7932", },
 	{ },
 };
-- 
2.34.1

