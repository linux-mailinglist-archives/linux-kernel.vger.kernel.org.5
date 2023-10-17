Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909F37CC169
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbjJQLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbjJQLCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:02:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E38A2;
        Tue, 17 Oct 2023 04:02:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 723301BF20A;
        Tue, 17 Oct 2023 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697540548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lbFtser67SYseIF06reyKNuH0tjeKU5ctx46j+l0JI=;
        b=nDzsSsiWv1vkOUWTMxTmRFkTMpYsb47lohNTu1Zj+wlw4Ob99VSTr/WiRqlgMgHEeel3F1
        Yq521H+a/XkajebN63SEjRGrgl7pKq7bn/4e2dN1WGIxoVO4BEzXucNFM66AtleuIoi149
        lGNgAZ5hepTqkTZuGUqrwRxcZ9m8OL9WuK/KBzvMEjuabunD/Fz1xEFm9j1TPbkNR+7CVw
        mWY9gKYdXk8/ZmrNGdDESfi6a1SuWWfOQgCH5XATyd0njso4GTomNDqrq1cNQIloSHynRW
        JFpgkkN8DaLlfyK7LP3oZdOorF/BxglDguh7qAFLU09+D8bPHPYKUMt2kYaqEg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 2/3] of: address: Remove duplicated functions
Date:   Tue, 17 Oct 2023 13:02:17 +0200
Message-ID: <20231017110221.189299-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017110221.189299-1-herve.codina@bootlin.com>
References: <20231017110221.189299-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently added of_bus_default_flags_translate() performs the exact
same operation as of_bus_pci_translate() and of_bus_isa_translate().

Avoid duplicated code replacing both of_bus_pci_translate() and
of_bus_isa_translate() with of_bus_default_flags_translate().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/address.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 3219c5177750..d21a3b74ac56 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -216,10 +216,6 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 	return da - cp;
 }
 
-static int of_bus_pci_translate(__be32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
-}
 #endif /* CONFIG_PCI */
 
 /*
@@ -343,11 +339,6 @@ static u64 of_bus_isa_map(__be32 *addr, const __be32 *range, int na, int ns,
 	return da - cp;
 }
 
-static int of_bus_isa_translate(__be32 *addr, u64 offset, int na)
-{
-	return of_bus_default_translate(addr + 1, offset, na - 1);
-}
-
 static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 {
 	unsigned int flags = 0;
@@ -378,7 +369,7 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_pci_match,
 		.count_cells = of_bus_pci_count_cells,
 		.map = of_bus_pci_map,
-		.translate = of_bus_pci_translate,
+		.translate = of_bus_default_flags_translate,
 		.has_flags = true,
 		.get_flags = of_bus_pci_get_flags,
 	},
@@ -390,7 +381,7 @@ static struct of_bus of_busses[] = {
 		.match = of_bus_isa_match,
 		.count_cells = of_bus_isa_count_cells,
 		.map = of_bus_isa_map,
-		.translate = of_bus_isa_translate,
+		.translate = of_bus_default_flags_translate,
 		.has_flags = true,
 		.get_flags = of_bus_isa_get_flags,
 	},
-- 
2.41.0

