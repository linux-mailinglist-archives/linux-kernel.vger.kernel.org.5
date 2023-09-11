Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4979A1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjIKDmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIKDmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:42:13 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3CF1BE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 20:42:07 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id fVVvq5yNkyYOwfXoNqEUM3; Mon, 11 Sep 2023 03:42:07 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id fXoKq5n0Z7HinfXoMqPwMr; Mon, 11 Sep 2023 03:42:07 +0000
X-Authority-Analysis: v=2.4 cv=Lq+Bd1Rc c=1 sm=1 tr=0 ts=64fe8c8f
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=CKMxHAookNUaJbGn3r6bzg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=zNV7Rl7Rt7sA:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8 a=jE1H5azQshHf5kA64NAA:9
 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MuNSiSam9s9sOHsuZDhJYrPrBgShwLml5HSi7hbqpw4=; b=b32ScKqw/7yCdjy8/B/mrZ8g8o
        MAtzuaqG4ae0v02+IHH07CiWumFS77793RrGKBjsX2BifxvZAE9+YABtjZPvinSb0dTxn6vqvSnoq
        vTDyOd/3mAD2QWoacBDtXNABu83HK8Ka335FBnXMNKlWW0NZkcUtYCqOytIC10T98UgLZ1AVYfG5t
        15KJsMQOBZhfPYs3Ua4BGdZhAMZgUhd2kgPzbgwvEpvZQYNNFhzp0301VIoI2dcfNc5CNjrDPiIz6
        HemNz6NG+0wH/fM3tAeIWby9UNrxDElpSwnZgUUwwyIK5ro7UPRwDGppxkwQBOXEP4bHNet7Okg0a
        36ZY9uGg==;
Received: from [103.163.95.214] (port=46382 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <saravanan@linumiz.com>)
        id 1qfXoJ-002lKM-2L;
        Mon, 11 Sep 2023 09:12:03 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH 3/3] hwmon: (pmbus/mpq2286) Add a support for mpq2286 Power Management IC
Date:   Mon, 11 Sep 2023 09:11:50 +0530
Message-Id: <20230911034150.181880-4-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911034150.181880-1-saravanan@linumiz.com>
References: <20230911034150.181880-1-saravanan@linumiz.com>
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
X-Exim-ID: 1qfXoJ-002lKM-2L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.163.95.214]:46382
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 36
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIr11PKJoAQf5J7sDWd28ohwrGpovLnfLfKxIfTlmzpbDGWnQkjSLdsuMLznt9gpyAVnNvSSQxu5aQOV0DWFVkVsbqW1OXcctv5Zd+eUa05U/bpyNAfI
 rwWIVM94uzWFAGNPmTGxat3hwReqfYq/J6Emd5HKXiERW46j5zYl9m60uW7q863/VxvhpJ10+vtTSwaTYIXlIpNks5h3TUUWR8k=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/hwmon/pmbus/mpq7932.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
index af3e5e9590c8..3ffeece28e2d 100644
--- a/drivers/hwmon/pmbus/mpq7932.c
+++ b/drivers/hwmon/pmbus/mpq7932.c
@@ -21,6 +21,7 @@
 #define MPQ7932_N_VOLTAGES		256
 #define MPQ7932_VOUT_MAX		0xFF
 #define MPQ7932_NUM_PAGES		6
+#define MPQ2286_NUM_PAGES		1
 
 #define MPQ7932_TON_DELAY		0x60
 #define MPQ7932_VOUT_STARTUP_SLEW	0xA3
@@ -130,12 +131,14 @@ static int mpq7932_probe(struct i2c_client *client)
 
 static const struct of_device_id mpq7932_of_match[] = {
 	{ .compatible = "mps,mpq7932", .data = (void *)MPQ7932_NUM_PAGES },
+	{ .compatible = "mps,mpq2286", .data = (void *)MPQ2286_NUM_PAGES },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpq7932_of_match);
 
 static const struct i2c_device_id mpq7932_id[] = {
 	{ "mpq7932", },
+	{ "mpq2286", },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, mpq7932_id);
-- 
2.34.1

