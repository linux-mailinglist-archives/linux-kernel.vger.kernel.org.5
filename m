Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7497AF8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjI0D7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjI0D5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:57:39 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9696580
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:40:16 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTP
        id lLDuqy5agOzKllLPLql2mb; Wed, 27 Sep 2023 03:40:15 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id lLPJqrNOTaV1hlLPKqQHe7; Wed, 27 Sep 2023 03:40:15 +0000
X-Authority-Analysis: v=2.4 cv=Gf8EICbL c=1 sm=1 tr=0 ts=6513a41f
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=CKMxHAookNUaJbGn3r6bzg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=zNV7Rl7Rt7sA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=rM9D5TWVn6pDyQQmvLkA:9
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4z+nM1mxoZBItzWTXHKdYlwbBxVGpaluekfGFIeavRs=; b=e3Sw1E4+a83e8ZYNKF01dIMKhG
        DiGf3X5wZlDDYowmTe4xa4/+p4385ezbeGA5gZQo93n3/ZFvmf9UIWLWwIUq0rDomYhCKtRoKegIA
        s3NVJPHhrJB/TLsRwI4KPXoKKRIiKkDluLZjbYdFt2yKkSyWyrliWwV+nL1BLQMHa3MPMVwa2XSYv
        Cf3IE9tIwjmULqaDjmfv6MTbLjIMGGVLF0zz5Gmg/qVC+pu1Dw18+jEYzxPuvwemjLaOpMP/IPtrS
        1nJaI/7DWhrVIQrEyAe8uoOGd0sutY6vQRslU+HszzRB35+cgJgK2ctx9DHE6TrDVCUp+Aj9vJ0F3
        r8WHRjOQ==;
Received: from [103.163.95.214] (port=59728 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <saravanan@linumiz.com>)
        id 1qlLPI-000tFx-24;
        Wed, 27 Sep 2023 09:10:12 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v2 1/3] hwmon: (pmbus/mpq7932) Get page count based on chip info
Date:   Wed, 27 Sep 2023 09:09:51 +0530
Message-Id: <20230927033953.1503440-2-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927033953.1503440-1-saravanan@linumiz.com>
References: <20230927033953.1503440-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 103.163.95.214
X-Source-L: No
X-Exim-ID: 1qlLPI-000tFx-24
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.163.95.214]:59728
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 14
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLWtWGBaxHMjiyHKW0YHHVp4AUbZfK3ObSfmxjSz46npoN0ShDYkTKX/3iMg9nSHz9Kup8jhE7IoUoweh4PkXiSgUiVu5yim9E8/IDsIk0eFzGdey1OB
 wNt3gr4AWe69LyZgC/Rq8NeKrZs8FJDRZyVmTYtH91kCETUAGCvxrrJMTpkFvmKSVRIQSa3mon8Adsoqv7epTbtkqg3eGtQVwWg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get page count using compatible match to support the series of chipsets
which differs in number of regualator/page.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 drivers/hwmon/pmbus/mpq7932.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
index 6c62f01da7c6..723c314a57a2 100644
--- a/drivers/hwmon/pmbus/mpq7932.c
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -105,7 +105,7 @@ static int mpq7932_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	info = &data->info;
-	info->pages = MPQ7932_NUM_PAGES;
+	info->pages = (int)(unsigned long)device_get_match_data(&client->dev);
 	info->format[PSC_VOLTAGE_OUT] = direct;
 	info->m[PSC_VOLTAGE_OUT] = 160;
 	info->b[PSC_VOLTAGE_OUT] = -33;
@@ -115,7 +115,7 @@ static int mpq7932_probe(struct i2c_client *client)
 	}
 
 #if IS_ENABLED(CONFIG_SENSORS_MPQ7932_REGULATOR)
-	info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
+	info->num_regulators = info->pages;
 	info->reg_desc = mpq7932_regulators_desc;
 #endif
 
@@ -129,7 +129,7 @@ static int mpq7932_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mpq7932_of_match[] = {
-	{ .compatible = "mps,mpq7932"},
+	{ .compatible = "mps,mpq7932", .data = (void *)MPQ7932_NUM_PAGES },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpq7932_of_match);
-- 
2.34.1

