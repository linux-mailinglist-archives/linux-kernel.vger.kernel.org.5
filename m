Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149F7D83FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbjJZN4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjJZNz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:59 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488AD54;
        Thu, 26 Oct 2023 06:55:55 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e07e5f3aso1028053b6e.0;
        Thu, 26 Oct 2023 06:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328555; x=1698933355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvFrN6RkHOEg6+kdZIT7qu8F7MiUG3qfKprWNC+gw7c=;
        b=TPeTS3TPM3mZZ8D9Nc8qM165TuuUqTe41UnfTanHe3MFeL6BFpw9f5I32+bXaVIr+n
         psvMGRGBqyOwijwUGsxDNW6aAU91tITFDXEeATcs60omZjOGplWc2ei5VPbggKtrif7z
         VDovKClQLVsxWCKWApk2JiJCVhhKYrp6ClT6fjafeE4wthdDYfF5ZSANOfcyMEM5vo2H
         Q9ABWX9oQYwX43pLuMfWquiVnb8KkH94AQqV8yfrrqdBTZ+Uq13VPJkqdG2+Oj7g0G3/
         s+S0H1aI8xBPut+Wmm0VZ6FQn4ihAopVZyM76BFTgZQm4MY4XfakfeKdlJIhSAKyqyUx
         gI8w==
X-Gm-Message-State: AOJu0YwXyHtR5qP2/SFXlRaSlt4cNTyhZ7XF/MD+1cirQ7OjCn5lDcJ7
        IEFjsJir1qqEXXe+LsHO1bF5HVKXjA==
X-Google-Smtp-Source: AGHT+IGoVC4Kyb4A1PcHBnfW6kCpsMlNPSGpBUJTOVOFk4x7EK0/yhtKbN2/0QAkxo3AqpJ2AJ0PNQ==
X-Received: by 2002:a05:6808:24f:b0:3b2:f4a2:e7fc with SMTP id m15-20020a056808024f00b003b2f4a2e7fcmr1541559oie.25.1698328554938;
        Thu, 26 Oct 2023 06:55:54 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808029200b003b2f369a932sm2763797oic.49.2023.10.26.06.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:55:54 -0700 (PDT)
Received: (nullmailer pid 3566879 invoked by uid 1000);
        Thu, 26 Oct 2023 13:55:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] of: address: Consolidate bus .map() functions
Date:   Thu, 26 Oct 2023 08:53:59 -0500
Message-ID: <20231026135358.3564307-3-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026135358.3564307-2-robh@kernel.org>
References: <20231026135358.3564307-2-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus .map() functions vary only by checking the flag cells values
and skipping over any flag cells to read the addresses. Otherwise they
all do the same reading 'ranges' address and size and returning the
address's offset if it is within the 'ranges' entry.

Refactor all the .map() functions to pass in the flag cell size so that
each bus can check the bus specific flags and then call a common
function to do everything else.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 54 +++++++++-----------------------------------
 1 file changed, 11 insertions(+), 43 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 997f431af165..b59956310f66 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -43,7 +43,7 @@ struct of_bus {
 	void		(*count_cells)(struct device_node *child,
 				       int *addrc, int *sizec);
 	u64		(*map)(__be32 *addr, const __be32 *range,
-				int na, int ns, int pna);
+				int na, int ns, int pna, int fna);
 	int		(*translate)(__be32 *addr, u64 offset, int na);
 	int		flag_cells;
 	unsigned int	(*get_flags)(const __be32 *addr);
@@ -63,13 +63,13 @@ static void of_bus_default_count_cells(struct device_node *dev,
 }
 
 static u64 of_bus_default_map(__be32 *addr, const __be32 *range,
-		int na, int ns, int pna)
+		int na, int ns, int pna, int fna)
 {
 	u64 cp, s, da;
 
-	cp = of_read_number(range, na);
+	cp = of_read_number(range + fna, na - fna);
 	s  = of_read_number(range + na + pna, ns);
-	da = of_read_number(addr, na);
+	da = of_read_number(addr + fna, na - fna);
 
 	pr_debug("default map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
 
@@ -101,24 +101,13 @@ static unsigned int of_bus_default_get_flags(const __be32 *addr)
 }
 
 static u64 of_bus_default_flags_map(__be32 *addr, const __be32 *range, int na,
-				    int ns, int pna)
+				    int ns, int pna, int fna)
 {
-	u64 cp, s, da;
-
 	/* Check that flags match */
 	if (*addr != *range)
 		return OF_BAD_ADDR;
 
-	/* Read address values, skipping high cell */
-	cp = of_read_number(range + 1, na - 1);
-	s  = of_read_number(range + na + pna, ns);
-	da = of_read_number(addr + 1, na - 1);
-
-	pr_debug("default flags map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
-
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
+	return of_bus_default_map(addr, range, na, ns, pna, fna);
 }
 
 static int of_bus_default_flags_translate(__be32 *addr, u64 offset, int na)
@@ -192,9 +181,8 @@ static void of_bus_pci_count_cells(struct device_node *np,
 }
 
 static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
-		int pna)
+		int pna, int fna)
 {
-	u64 cp, s, da;
 	unsigned int af, rf;
 
 	af = of_bus_pci_get_flags(addr);
@@ -204,16 +192,7 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32 *range, int na, int ns,
 	if ((af ^ rf) & (IORESOURCE_MEM | IORESOURCE_IO))
 		return OF_BAD_ADDR;
 
-	/* Read address values, skipping high cell */
-	cp = of_read_number(range + 1, na - 1);
-	s  = of_read_number(range + na + pna, ns);
-	da = of_read_number(addr + 1, na - 1);
-
-	pr_debug("PCI map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
-
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
+	return of_bus_default_map(addr, range, na, ns, pna, fna);
 }
 
 #endif /* CONFIG_PCI */
@@ -319,24 +298,13 @@ static void of_bus_isa_count_cells(struct device_node *child,
 }
 
 static u64 of_bus_isa_map(__be32 *addr, const __be32 *range, int na, int ns,
-		int pna)
+		int pna, int fna)
 {
-	u64 cp, s, da;
-
 	/* Check address type match */
 	if ((addr[0] ^ range[0]) & cpu_to_be32(1))
 		return OF_BAD_ADDR;
 
-	/* Read address values, skipping high cell */
-	cp = of_read_number(range + 1, na - 1);
-	s  = of_read_number(range + na + pna, ns);
-	da = of_read_number(addr + 1, na - 1);
-
-	pr_debug("ISA map, cp=%llx, s=%llx, da=%llx\n", cp, s, da);
-
-	if (da < cp || da >= (cp + s))
-		return OF_BAD_ADDR;
-	return da - cp;
+	return of_bus_default_map(addr, range, na, ns, pna, fna);
 }
 
 static unsigned int of_bus_isa_get_flags(const __be32 *addr)
@@ -486,7 +454,7 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	rlen /= 4;
 	rone = na + pna + ns;
 	for (; rlen >= rone; rlen -= rone, ranges += rone) {
-		offset = bus->map(addr, ranges, na, ns, pna);
+		offset = bus->map(addr, ranges, na, ns, pna, bus->flag_cells);
 		if (offset != OF_BAD_ADDR)
 			break;
 	}
-- 
2.42.0

