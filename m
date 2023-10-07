Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32AC7BC921
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbjJGQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344080AbjJGQ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:58:25 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D620B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 09:58:24 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id p9mbqKPxSaLCxpAdDqsfFT; Sat, 07 Oct 2023 16:58:23 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id pAdBqg3D9VbZDpAdCqgaCY; Sat, 07 Oct 2023 16:58:22 +0000
X-Authority-Analysis: v=2.4 cv=YvAc+qUX c=1 sm=1 tr=0 ts=65218e2e
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=J9R/PiKqv2o3jGxbVGXx4w==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=bhdUkHdE2iEA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=rM9D5TWVn6pDyQQmvLkA:9
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4z+nM1mxoZBItzWTXHKdYlwbBxVGpaluekfGFIeavRs=; b=JY+dO9v4v3xDE3rAuXhtdLgEdk
        sbY++wXnmb0Ka9Cf9hmEQ7wTnnnqzwqKpNbpLFcml3m0KtrBpCft/qEFvIBkRmgcRd8Nkg+Ngtb3w
        a/StchzVUkslyrKqwEP0FfI3IyvtKKxrsjKHlMu3drNXk87qnOIPOAWW9rWsvLYY/dxjBugvDxrE1
        4RBScLLvHRUwBnO9cPOFend9tP81FEza6IWF9Fise07kjaiEqOdkI6YrEafaLlI9Osu4e3qdFw1s/
        TbGQ9AjE2z8Knunumy/0AUlzvHTF8Flv7P6t3P2RRS7N0eVNjXq+yff7Z6xXIU8Pz/iVJpagU2Lyj
        ZjzByz1Q==;
Received: from [103.186.120.251] (port=39748 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <saravanan@linumiz.com>)
        id 1qpAdA-002Tlj-09;
        Sat, 07 Oct 2023 22:28:20 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v3 1/3] hwmon: (pmbus/mpq7932) Get page count based on chip info
Date:   Sat,  7 Oct 2023 22:28:01 +0530
Message-Id: <20231007165803.239718-2-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007165803.239718-1-saravanan@linumiz.com>
References: <20231007165803.239718-1-saravanan@linumiz.com>
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
X-Exim-ID: 1qpAdA-002Tlj-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.186.120.251]:39748
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 14
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDJwk9F1oRZeTShTkl7jgg/m2oRyMU4kDoBivHis6sZ5k5REQb6IUIu0D3zqcbVdYuH6KHvxLu9YG1Yn4FL+Uxh3PFjFOuVn5uJYc7tG7xpv5Gt8VIdg
 2LqV+uFi684LpGK+l9/yZVygjRHGR1JlF4ugG96yNrxUWY8L1JjICuJQxxyssiKe/qhkE2Nb0BFXSW6xbV2nixBytmGrXqe1B+Y=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

