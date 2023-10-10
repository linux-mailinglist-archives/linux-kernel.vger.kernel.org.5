Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782E27C0313
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbjJJRzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjJJRze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:55:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D6D3;
        Tue, 10 Oct 2023 10:55:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39AHtRNv018200;
        Tue, 10 Oct 2023 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696960527;
        bh=Zaus7Gie6qHv+bp5Vv5G6I7IcCxb/UdUdWGr++n6yKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rWICb+/kX1SzQJzPiU0/yqnZxYL3cul5mhcf0VwKLxJ6+nhfg+sjudpIvMLek8/pP
         fK8d2XRiNZMusRluVDU3QTx5HJ3HK7oHtAMssnkBhMDthxrH7aYwdsynU3PF15/Lg2
         ayW8MIx46XHPpkvTpciXtDLcAyfOdZanbcULtTDY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39AHtRSN097595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Oct 2023 12:55:27 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Oct 2023 12:55:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Oct 2023 12:55:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39AHtQ9R085859;
        Tue, 10 Oct 2023 12:55:26 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        ARM Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 2/2] cpufreq: ti-cpufreq: Add opp support for am62p5 SoCs
Date:   Tue, 10 Oct 2023 12:55:27 -0500
Message-ID: <20231010175524.558577-6-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010175524.558577-4-bb@ti.com>
References: <20231010175524.558577-4-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=bb@ti.com; h=from:subject; bh=oiw5jmvhIpjWbcu11ZW56kGgRNZ9ita9AYwhDYguzd0=; b=owNCWmg5MUFZJlNZm81aOQAAaX///vfbq3/9Kv3Pr+pzm7P++/t7z+Sk/e/7/r2snN1n928wA RmYjtQAA0BoADQA0AAaABoNAABoAA0GnqBkAeo0aeoHqDQGJpoGh6ajZpqiA0AeoDTQAAGRoaMJ p6jQ00yAB6mgyAyBpo000NBkPUGTTRtIeo00DQGQBpgg9QyTNTIxMmgZNDRk00yAaZBoZA0DQ0M gyAD0TEA0AYJ6mg0GgAyA0DQNAGmjAglhtUCNFq2wsgPKviU+G2mDFdyCRzDDzck0FDXsaTAt/h 0BnV/GKH7NXtWcKcbuxFYYvkMH5fz4Mnl1qShokPhcvArtWAEG6gBTNzAl1DM95uZ2ZElXiOkHf hgQg1duCXqX4ELluHEZoAeSAJuCmfQw82Z8yEKEUPis6+Q0e9WCFho7xGeuWzijX7ZQRnf6dbAD soiiQ5261+KognDRMAfLCc6lrpDjQ/ad/wC7sWSUmXbDXaB5IXO4xy+2AAsl5lxZnYJ/RVLqP4K t1YEom5oWKRtE/Sh+sUidq6Y2HV5bxYseRcpR2i9l6uBKk6l7/hYboLdsX8DYH1vKfaubBPFDK5 y2czyoH3GFmjy5YhfuICJlJvHMrWHyzCJkMr0lmUkRtwQJkpwUgO5H5haYxh6DcBtqIgDrohgVh LQvpYY//i7kinChITeatHI=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am62p5 is a variation of the am625 and the am62a7 SoC families. Add
the am62p5 to the list using the same cpufreq data as the rest of the
am62x extended family.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/cpufreq/ti-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3c37d78996607..46c41e2ca727b 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -338,6 +338,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	{ .compatible = "ti,am62a7", .data = &am625_soc_data, },
+	{ .compatible = "ti,am62p5", .data = &am625_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
 	{ .compatible = "ti,omap3630", .data = &omap36xx_soc_data, },
-- 
2.42.0

