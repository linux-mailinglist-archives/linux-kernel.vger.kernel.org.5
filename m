Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0397E5695
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjKHM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbjKHM5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:57:17 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8781BFE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:57:14 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 90A93100031;
        Wed,  8 Nov 2023 15:57:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 90A93100031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1699448232;
        bh=lEL9hzC+yiSK5zTbNOAn5LFfqRWf2kGLJXMdItJSVyA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=oYJ2iqyiUotP9czMjrfyU8wlpc0texQiVRLNMkG2/hyauuls9B3s6Rvh4QaHh4QnX
         f5gigcnypL2BllMlJnzGyqw34HZA7qzHVDg5IJ6PO50AyO7w/HfYBG9FRT4HBlfgAC
         MZ8Wpgb/cXI+hLB/W9+4NL5510IqsnoAyXaIpdBHTTzC2NB22AZH5xe2jfgrhbQoqU
         WXWHcK8/C9Lr3hY8BJ6yPkPm7sgG99vToGBx4q4Q6AJlbYUosybUH5iZKKbWFntjfE
         hLkjyMQmcfWjK/Mrzwpy7NnfUfM1MPnFuB4Ts041BQfu4du6rGyLSXQ+WFoEU+9YSF
         zXB+wZ7Ehedqg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  8 Nov 2023 15:57:12 +0300 (MSK)
Received: from pc (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 8 Nov
 2023 15:57:12 +0300
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
Subject: [PATCH v1 2/2] firmware: meson-sm: unmap out_base shmem in error path
Date:   Wed, 8 Nov 2023 15:56:04 +0300
Message-ID: <20231108125604.162383-3-EABachinin@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/08 08:59:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/08 08:57:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/08 08:25:00 #22426097
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SM driver was introduced in [1], the code flow did not require
to unmap out_base shmem in case of errors inside probe().
During [2], the additional error path appeared, which requires unmap.

Patch adds iounmap() missed.

Links:
[1] https://lore.kernel.org/linux-amlogic/1466339944-602-2-git-send-email-carlo@caione.org/
[2] https://lore.kernel.org/linux-amlogic/1532613556-5398-1-git-send-email-narmstrong@baylibre.com/

Fixes: 0789724f86a5 ("firmware: meson_sm: Add serial number sysfs entry")
Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
 drivers/firmware/meson/meson_sm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 73878ff9833c..ca5f3534eddd 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -307,7 +307,7 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 		fw->sm_shmem_out_base = meson_sm_map_shmem(chip->cmd_shmem_out_base,
 							   chip->shmem_size);
 		if (WARN_ON(!fw->sm_shmem_out_base))
-			goto out_in_base;
+			goto unmap_in_base;
 	}
 
 	fw->chip = chip;
@@ -315,13 +315,15 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fw);
 
 	if (devm_of_platform_populate(dev))
-		goto out_in_base;
+		goto unmap_out_base;
 
 	pr_info("secure-monitor enabled\n");
 
 	return 0;
 
-out_in_base:
+unmap_out_base:
+	iounmap(fw->sm_shmem_out_base);
+unmap_in_base:
 	iounmap(fw->sm_shmem_in_base);
 out:
 	return -EINVAL;
-- 
2.34.1

