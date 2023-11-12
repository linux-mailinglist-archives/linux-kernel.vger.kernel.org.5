Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B77E90BF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjKLNaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjKLN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E12702;
        Sun, 12 Nov 2023 05:28:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE670C433C7;
        Sun, 12 Nov 2023 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795718;
        bh=7njd7rHDcDEJC4muEuWcnWP9qLng80yM0XXtgvnALtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs+J7VWPgblPcfmkgQn8QSFk+hWJJX42wpbsQvX5Pbw+CMcXSUJPRWXQtEIqvOGB6
         6qtHj4LJ19nSRr4kzRWYuF+ks5dmB8/1IaPIg2kLtL7XqjRQ7iOT6NL0GRsqnJDgCi
         lCobK8ZL8ObQ8PceSAIWV6+V97ihnGH75GV2qsFRAS5CV3eHjM7QrTgUD0Ftv+2DRK
         +wdmHjv6BRo2e5P37mE4Vb1qN3pHsKp2TVh91qqg+Sap69/rF6jL5YbCM8lANe2O+S
         Ed5dvhhxZL7X1s3O/6+W/xp5k0HMh+ojh3rPZWN5sJRPo7fe2VLG2Qlkn5aGeVztci
         yvUKyotuJdVsw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, hans.verkuil@cisco.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/9] media: cobalt: Use FIELD_GET() to extract Link Width
Date:   Sun, 12 Nov 2023 08:28:25 -0500
Message-ID: <20231112132830.176228-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132830.176228-1-sashal@kernel.org>
References: <20231112132830.176228-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.138
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit f301fedbeecfdce91cb898d6fa5e62f269801fee ]

Use FIELD_GET() to extract PCIe Negotiated and Maximum Link Width fields
instead of custom masking and shifting.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cobalt/cobalt-driver.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index 16af58f2f93cc..f9cee061517bd 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -8,6 +8,7 @@
  *  All rights reserved.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <media/i2c/adv7604.h>
 #include <media/i2c/adv7842.h>
@@ -210,17 +211,17 @@ void cobalt_pcie_status_show(struct cobalt *cobalt)
 	pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &stat);
 	cobalt_info("PCIe link capability 0x%08x: %s per lane and %u lanes\n",
 			capa, get_link_speed(capa),
-			(capa & PCI_EXP_LNKCAP_MLW) >> 4);
+			FIELD_GET(PCI_EXP_LNKCAP_MLW, capa));
 	cobalt_info("PCIe link control 0x%04x\n", ctrl);
 	cobalt_info("PCIe link status 0x%04x: %s per lane and %u lanes\n",
 		    stat, get_link_speed(stat),
-		    (stat & PCI_EXP_LNKSTA_NLW) >> 4);
+		    FIELD_GET(PCI_EXP_LNKSTA_NLW, stat));
 
 	/* Bus */
 	pcie_capability_read_dword(pci_bus_dev, PCI_EXP_LNKCAP, &capa);
 	cobalt_info("PCIe bus link capability 0x%08x: %s per lane and %u lanes\n",
 			capa, get_link_speed(capa),
-			(capa & PCI_EXP_LNKCAP_MLW) >> 4);
+			FIELD_GET(PCI_EXP_LNKCAP_MLW, capa));
 
 	/* Slot */
 	pcie_capability_read_dword(pci_dev, PCI_EXP_SLTCAP, &capa);
@@ -239,7 +240,7 @@ static unsigned pcie_link_get_lanes(struct cobalt *cobalt)
 	if (!pci_is_pcie(pci_dev))
 		return 0;
 	pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &link);
-	return (link & PCI_EXP_LNKSTA_NLW) >> 4;
+	return FIELD_GET(PCI_EXP_LNKSTA_NLW, link);
 }
 
 static unsigned pcie_bus_link_get_lanes(struct cobalt *cobalt)
@@ -250,7 +251,7 @@ static unsigned pcie_bus_link_get_lanes(struct cobalt *cobalt)
 	if (!pci_is_pcie(pci_dev))
 		return 0;
 	pcie_capability_read_dword(pci_dev, PCI_EXP_LNKCAP, &link);
-	return (link & PCI_EXP_LNKCAP_MLW) >> 4;
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, link);
 }
 
 static void msi_config_show(struct cobalt *cobalt, struct pci_dev *pci_dev)
-- 
2.42.0

