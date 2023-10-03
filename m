Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535C7B610B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJCGxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:53:23 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E19DC6;
        Mon,  2 Oct 2023 23:53:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 9C752E000A;
        Tue,  3 Oct 2023 06:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696315997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6B4cR6QdWY1kKYWcNt23ARo4mrs6WEQkCJ4dyTlEJ7w=;
        b=ZPHkEhu1OI88u1+y+PHughEdzAZtRUbT2bjgzsIvlxVaALqwxQD8bqvdVHgL7gFEOmtRAM
        4zP3/jnxxdEaU9H6Zn647dHOzbboiuqKq/POVbbbt7lDKqq2ReKvTlDPmip+l2TOMPc8rq
        FGr0o0BrDuVZNcFPdgU6Fgv/e0VksTyt1o3Soki+bX4/2w+WAFBmiT2w+x9jGAdxOg8/To
        jzz0FyMjBH2C0ct3cgevDYcnUxT/D4Yl/Z57z44U/pfXqZptxfKEYXsysyZAdZWVGyD+kS
        yWK+KhRsRLbnapgKn63dDiTyzD6hTxsilPtZRXTo+PAILF70rtBAS9mtC3TMKA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/1] of: address: Fix address translation when address-size is greater than 2
Date:   Tue,  3 Oct 2023 08:52:36 +0200
Message-ID: <20231003065236.121987-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
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
  compatible = "pci11ab,100\0pciclass,060400\0pciclass,0604";
  ranges = <0x82000000 0x00 0xe8000000
            0x82000000 0x00 0xe8000000
	    0x00 0x4400000>;
  ...
  dev@0,0 {
    #address-cells = <0x03>;
    #size-cells = <0x02>;
    compatible = "pci1055,9660\0pciclass,020000\0pciclass,0200";
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
---
 drivers/of/address.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e692809ff822..8665de3a6344 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -100,6 +100,58 @@ static unsigned int of_bus_default_get_flags(const __be32 *addr)
 	return IORESOURCE_MEM;
 }
 
+static bool of_addr_is_equal(const __be32 *addr1, const __be32 *addr2, int na)
+{
+	int i;
+	u32 a1;
+	u32 a2;
+
+	for (i = 0; i < na; i++) {
+		a1 = be32_to_cpup(addr1 + i);
+		a2 = be32_to_cpup(addr2 + i);
+		if (a1 == a2)
+			continue;
+		return false;
+	}
+	return true;
+}
+
+static u64 of_bus_default_flags_map(__be32 *addr, const __be32 *range, int na,
+				    int ns, int pna)
+{
+	u64 cp, s, da;
+	int extra = 0;
+
+	if (na > 2) {
+		/*
+		 * Given address contains more than 2 cells.
+		 * The address high extra part must match the range extra part
+		 * and must be filtered-out from 64bit offset computation.
+		 */
+		extra = na - 2;
+		if (!of_addr_is_equal(addr, range, extra))
+			return OF_BAD_ADDR;
+
+		cp = of_read_number(range + extra, na - extra);
+		s  = of_read_number(range + na + pna, ns);
+		da = of_read_number(addr + extra, na - extra);
+	} else {
+		cp = of_read_number(range, na);
+		s  = of_read_number(range + na + pna, ns);
+		da = of_read_number(addr, na);
+	}
+	pr_debug("default flags map, extra=%d cp=%llx, s=%llx, da=%llx\n", extra, cp, s, da);
+
+	if (da < cp || da >= (cp + s))
+		return OF_BAD_ADDR;
+	return da - cp;
+}
+
+static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int na)
+{
+	/* Keep "flags" part in translated address */
+	return of_bus_default_translate(addr + 1, offset, na - 1);
+}
 
 #ifdef CONFIG_PCI
 static unsigned int of_bus_pci_get_flags(const __be32 *addr)
@@ -374,8 +426,8 @@ static struct of_bus of_busses[] = {
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
2.41.0

