Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DB7E3BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjKGMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjKGMJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:09:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F926AC;
        Tue,  7 Nov 2023 04:08:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842B0C433CB;
        Tue,  7 Nov 2023 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358920;
        bh=dN7/KtImMvyag0cEUmZ23oKenryc3mgEBKQkieEj3Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phqfPuQp4ViIBKMFujNOQ9qhuFN3AL+7ZCpiU0XFXWJnMSWAyfI3oVId8ACqsJOOK
         XAQ+A2mpp66svXITqI5i9lImSLmWtegO1zOwwmlaAjBI7SKbUbQUr3qP0s8vpGgi+w
         WaDj3xONXGTKh2xc7LKk3cYtGsTWU2KyPixY6UlBFJB3ygtlHym1TApWeRNkMkNalM
         bJtZTC1TFX1kQTa1Rte3dFnRoc/UgDdEcLAWQ9UREeKUGqg+R5T/NtiTLWlZsrfsMx
         5hB8vf4YJ0bQjAxs3YPlBtyWhvoQ95AIr0QdDhlL0M73uFKbcZa+BcmhRwkROy9b3D
         zIaAPpUsQ6yiA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        robh+dt@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 30/31] of: address: Fix address translation when address-size is greater than 2
Date:   Tue,  7 Nov 2023 07:06:17 -0500
Message-ID: <20231107120704.3756327-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit 42604f8eb7ba04b589375049cc76282dad4677d2 ]

With the recent addition of of_pci_prop_ranges() in commit 407d1a51921e
("PCI: Create device tree node for bridge"), the ranges property can
have a 3 cells child address, a 3 cells parent address and a 2 cells
child size.

A range item property for a PCI device is filled as follow:
  <BAR_nbr> 0 0 <phys.hi> <phys.mid> <phys.low> <BAR_sizeh> <BAR_sizel>
  <-- Child --> <-- Parent (PCI definition) --> <- BAR size (64bit) -->

This allow to translate BAR addresses from the DT. For instance:
pci@0,0 {
  #address-cells = <0x03>;
  #size-cells = <0x02>;
  device_type = "pci";
  compatible = "pci11ab,100", "pciclass,060400", "pciclass,0604";
  ranges = <0x82000000 0x00 0xe8000000
            0x82000000 0x00 0xe8000000
	    0x00 0x4400000>;
  ...
  dev@0,0 {
    #address-cells = <0x03>;
    #size-cells = <0x02>;
    compatible = "pci1055,9660", "pciclass,020000", "pciclass,0200";
    /* Translations for BAR0 to BAR5 */
    ranges = <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
              0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
              0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000
              0x03 0x00 0x00 0x82010000 0x00 0xeb800000 0x00 0x800000
              0x04 0x00 0x00 0x82010000 0x00 0xec000000 0x00 0x20000
              0x05 0x00 0x00 0x82010000 0x00 0xec020000 0x00 0x2000>;
    ...
    pci-ep-bus@0 {
      #address-cells = <0x01>;
      #size-cells = <0x01>;
      compatible = "simple-bus";
      /* Translate 0xe2000000 to BAR0 and 0xe0000000 to BAR1 */
      ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
                0xe0000000 0x01 0x00 0x00 0x1000000>;
      ...
    };
  };
};

During the translation process, the "default-flags" map() function is
used to select the matching item in the ranges table and determine the
address offset from this matching item.
This map() function simply calls of_read_number() and when address-size
is greater than 2, the map() function skips the extra high address part
(ie part over 64bit). This lead to a wrong matching item and a wrong
offset computation.
Also during the translation itself, the extra high part related to the
parent address is not present in the translated address.

Fix the "default-flags" map() and translate() in order to take into
account the child extra high address part in map() and the parent extra
high address part in translate() and so having a correct address
translation for ranges patterns such as the one given in the example
above.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20231017110221.189299-2-herve.codina@bootlin.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/address.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e692809ff8227..3219c51777507 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -100,6 +100,32 @@ static unsigned int of_bus_default_get_flags(const __be32 *addr)
 	return IORESOURCE_MEM;
 }
 
+static u64 of_bus_default_flags_map(__be32 *addr, const __be32 *range, int na,
+				    int ns, int pna)
+{
+	u64 cp, s, da;
+
+	/* Check that flags match */
+	if (*addr != *range)
+		return OF_BAD_ADDR;
+
+	/* Read address values, skipping high cell */
+	cp = of_read_number(range + 1, na - 1);
+	s  = of_read_number(range + na + pna, ns);
+	da = of_read_number(addr + 1, na - 1);
+
+	pr_debug("default flags map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
+
+	if (da < cp || da >= (cp + s))
+		return OF_BAD_ADDR;
+	return da - cp;
+}
+
+static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int na)
+{
+	/* Keep "flags" part (high cell) in translated address */
+	return of_bus_default_translate(addr + 1, offset, na - 1);
+}
 
 #ifdef CONFIG_PCI
 static unsigned int of_bus_pci_get_flags(const __be32 *addr)
@@ -374,8 +400,8 @@ static struct of_bus of_busses[] = {
 		.addresses = "reg",
 		.match = of_bus_default_flags_match,
 		.count_cells = of_bus_default_count_cells,
-		.map = of_bus_default_map,
-		.translate = of_bus_default_translate,
+		.map = of_bus_default_flags_map,
+		.translate = of_bus_default_flags_translate,
 		.has_flags = true,
 		.get_flags = of_bus_default_flags_get_flags,
 	},
-- 
2.42.0

