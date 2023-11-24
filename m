Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D977F6A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjKXBpY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 20:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXBpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:45:19 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31B10C7;
        Thu, 23 Nov 2023 17:45:22 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C27C924E245;
        Fri, 24 Nov 2023 09:45:14 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Nov
 2023 09:45:14 +0800
Received: from kevin-ThinkStation-P340.starfivetech.com (113.72.144.198) by
 EXMBX172.cuchost.com (172.16.6.92) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 24 Nov 2023 09:45:13 +0800
From:   Kevin Xie <kevin.xie@starfivetech.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mason.huo@starfivetech.com>, <leyfoon.tan@starfivetech.com>,
        <minda.chen@starfivetech.com>
Subject: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time value
Date:   Fri, 24 Nov 2023 09:45:08 +0800
Message-ID: <20231124014508.43358-1-kevin.xie@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.198]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
time between sending the first configuration request to the device and
exit from a conventional reset (or after link training completes).

As described in the conventional reset rules of PCI specifications,
there are two different use cases of the value:

   - With a downstream port that supports link speeds <= 5.0 GT/s,
     the waiting is following exit from a conventional reset.

   - With a downstream port that supports link speeds > 5.0 GT/s,
     the waiting is after link training completes.

Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 drivers/pci/pci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..4ca8766e546e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,13 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/*
+ * PCIe r6.0, sec 6.6.1, <Conventional Reset>
+ * Requires a minimum waiting of 100ms before sending a configuration
+ * request to the device.
+ */
+#define PCIE_CONFIG_REQUEST_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1

