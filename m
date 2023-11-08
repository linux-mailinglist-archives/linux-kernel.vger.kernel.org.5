Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B7E7E5694
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjKHM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjKHM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:57:12 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3991BF7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:57:09 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 878F6120007;
        Wed,  8 Nov 2023 15:57:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 878F6120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699448227;
        bh=73YJxpyKrfQZjMMYETXxSzxu5XhjcgY9c/ld2sap6w8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=WkehRfNprPkAjldqLgYlSoymSgsc2+zIApNxi6F8mrZNHKSCou8BTz+LASJO8ihAO
         tMlZypl0xezt6PdmYbjA6Dnr19LqqD0NKUUHW3/OXJKg9/EqSGAdLda3P3Bp8ajYFl
         3IgU5Gi3a4B5W/md/xPg2OKwmehqGOlMz/lI8ZjPdpLZEW8BVYUxXzLUZcZ+QBHo8E
         M0fgsDFIy8Ca1qeF6DG3i7pQkry5SzSeH2yEJxhAoo2OSr/FrWrqneblPtT6kjcrzT
         8N0nSVu7Be/RgsmW8cOK3tZ/XpM69yJ0RLpcLwCFiQevtntBL0mrT/Fm7G4DDo4x/n
         /Fdxfi79rCIaQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  8 Nov 2023 15:57:07 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 8 Nov
 2023 15:57:07 +0300
From:   Evgeny Bachinin <EABachinin@salutedevices.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Evgeny Bachinin <EABachinin@salutedevices.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Miles Chen <miles.chen@mediatek.com>,
        Alexey Romanov <avromanov@salutedevices.com>
CC:     <kernel@sberdevices.ru>, <evgen89bachinin@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] firmware: meson_sm: refactor serial sysfs entry via dev_groups attrs
Date:   Wed, 8 Nov 2023 15:56:03 +0300
Message-ID: <20231108125604.162383-2-EABachinin@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108125604.162383-1-EABachinin@salutedevices.com>
References: <20231108125604.162383-1-EABachinin@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181206 [Nov 08 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/08 12:09:00 #22428609
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce just another way to register sysfs serial entry:
the less code, the better in the absence of extra error-paths

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 drivers/firmware/meson/meson_sm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 27a8cd4747f8..73878ff9833c 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -273,14 +273,11 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(serial);
 
-static struct attribute *meson_sm_sysfs_attributes[] = {
+static struct attribute *meson_sm_sysfs_attrs[] = {
 	&dev_attr_serial.attr,
 	NULL,
 };
-
-static const struct attribute_group meson_sm_sysfs_attr_group = {
-	.attrs = meson_sm_sysfs_attributes,
-};
+ATTRIBUTE_GROUPS(meson_sm_sysfs);
 
 static const struct of_device_id meson_sm_ids[] = {
 	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
@@ -320,9 +317,6 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 	if (devm_of_platform_populate(dev))
 		goto out_in_base;
 
-	if (sysfs_create_group(&pdev->dev.kobj, &meson_sm_sysfs_attr_group))
-		goto out_in_base;
-
 	pr_info("secure-monitor enabled\n");
 
 	return 0;
@@ -337,6 +331,7 @@ static struct platform_driver meson_sm_driver = {
 	.driver = {
 		.name = "meson-sm",
 		.of_match_table = of_match_ptr(meson_sm_ids),
+		.dev_groups = meson_sm_sysfs_groups,
 	},
 };
 module_platform_driver_probe(meson_sm_driver, meson_sm_probe);
-- 
2.34.1

