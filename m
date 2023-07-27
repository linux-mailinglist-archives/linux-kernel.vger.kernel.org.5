Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE6A7656B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjG0PDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjG0PDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:03:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C3B5;
        Thu, 27 Jul 2023 08:03:47 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RCaNnw025960;
        Thu, 27 Jul 2023 17:03:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=kgwPhXs1Maa25udKJpXQZWNhB3KaaHj5JLRCEEzOU1U=;
 b=I4TEnSw0wcy0ori4+4VXxUOZq+V9oYq0Ohc/rzs9UIX9h+7Dx8b7qMrth6Ax5bwYaVQl
 rb5CvSXYbisiBDEnan20dLUR7f0AEVKDX1+Nx0PmbksPcBK6p9XCV6k7f8YMDJqc9Dzd
 miQRg4g3Ig/mzaMKu9vpts6BYShTY/90BmE3ntr3XlPx8b8FkcqjovrS2wxSmczEqEWt
 8eSu/v85886gyMh0LcHqWH2a6zpGTu1toUdwv5k3Yba1OFovPdiNG1TEoriPqJqomRoK
 HBBylzkU4HUXMq63mH76re+phXeDDOIjs1s+b9lGDuU83rlcsx6zGd8lLLLGzPkHDnXV Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3n7wtbr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:03:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2993310002A;
        Thu, 27 Jul 2023 17:03:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 231A9209BA0;
        Thu, 27 Jul 2023 17:03:38 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:03:37 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 02/11] of: property: add device link support for io-backends
Date:   Thu, 27 Jul 2023 17:03:13 +0200
Message-ID: <20230727150324.1157933-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for creating device links out of more DT properties.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index ddc75cd50825..864e29e4707c 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1244,6 +1244,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
 DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
+DEFINE_SIMPLE_PROP(io_backends, "io-backend", "#io-backend-cells")
 DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
@@ -1332,6 +1333,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
+	{ .parse_prop = parse_io_backends, },
 	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },
-- 
2.25.1

