Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A287D83FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbjJZN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbjJZNzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:55 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40564D55;
        Thu, 26 Oct 2023 06:55:53 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1d544a4a2f2so517460fac.3;
        Thu, 26 Oct 2023 06:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698328552; x=1698933352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dS2bQbsQIb8CArWmGPDMcF+yvzLcVqjiAEJzVYwbS4Y=;
        b=WXv98GxHzt2vF0zr3O1BOVadpHB2m/CMItumCtVwmLY03ZCoBCumdZFuo5RQTtGDXX
         3ufMt0KAAtGtMntMQ3dYWSNtE5TkOGDVay9n0Zvu3CJsb5k4BObx1KNzkupVfCbHOJHc
         tdsO9teLmm2wauB53lhQvOcK0rVhRYFieXtorEUK6xE1GExJDUcd3L4hVX2uKPpy9+Ra
         8gtGKhqVQbqQLqYWvgIr0kuvSB/bF8e/LTMYH6rqAfxZ/n14uu91vn7KToGuhHkN/eNj
         orWkaPoMsQY1puYYJjdvDyWTuRbmfj7lZqpuVNrLu87OTr2U/aT6zVaEBZqCP0qlGHIu
         +hBQ==
X-Gm-Message-State: AOJu0Yw7tRC1bfekSbi+Rhlm/TWIkSUc1pAPwz2N3XYHdwGgKpbgd13b
        8Pbyz7FVAa98b/z3aLe7kQ==
X-Google-Smtp-Source: AGHT+IHgf8CUyKOpw+cAs/S6m6eInBTBXSRM7rx9/VPe+g8iy1ZVcIgDIaA3FB/mqMoSQ4Z1mFgJTw==
X-Received: by 2002:a05:6870:7a1b:b0:1e9:f0be:cbbe with SMTP id hf27-20020a0568707a1b00b001e9f0becbbemr24245194oab.9.1698328552259;
        Thu, 26 Oct 2023 06:55:52 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z7-20020a056870e14700b001c5a3e31474sm3046274oaa.45.2023.10.26.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 06:55:51 -0700 (PDT)
Received: (nullmailer pid 3566795 invoked by uid 1000);
        Thu, 26 Oct 2023 13:55:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] of: address: Store number of bus flag cells rather than bool
Date:   Thu, 26 Oct 2023 08:53:58 -0500
Message-ID: <20231026135358.3564307-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is more useful to know how many flags cells a bus has rather than
whether a bus has flags or not as ultimately the number of cells is the
information used. Replace 'has_flags' boolean with 'flag_cells' count.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This series applies on top of Herve's[1].

Rob

[1] https://lore.kernel.org/all/20231017110221.189299-1-herve.codina@bootlin.com/

 drivers/of/address.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index d21a3b74ac56..997f431af165 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -45,7 +45,7 @@ struct of_bus {
 	u64		(*map)(__be32 *addr, const __be32 *range,
 				int na, int ns, int pna);
 	int		(*translate)(__be32 *addr, u64 offset, int na);
-	bool	has_flags;
+	int		flag_cells;
 	unsigned int	(*get_flags)(const __be32 *addr);
 };
 
@@ -370,7 +370,7 @@ static struct of_bus of_busses[] = {
 		.count_cells = of_bus_pci_count_cells,
 		.map = of_bus_pci_map,
 		.translate = of_bus_default_flags_translate,
-		.has_flags = true,
+		.flag_cells = 1,
 		.get_flags = of_bus_pci_get_flags,
 	},
 #endif /* CONFIG_PCI */
@@ -382,7 +382,7 @@ static struct of_bus of_busses[] = {
 		.count_cells = of_bus_isa_count_cells,
 		.map = of_bus_isa_map,
 		.translate = of_bus_default_flags_translate,
-		.has_flags = true,
+		.flag_cells = 1,
 		.get_flags = of_bus_isa_get_flags,
 	},
 	/* Default with flags cell */
@@ -393,7 +393,7 @@ static struct of_bus of_busses[] = {
 		.count_cells = of_bus_default_count_cells,
 		.map = of_bus_default_flags_map,
 		.translate = of_bus_default_flags_translate,
-		.has_flags = true,
+		.flag_cells = 1,
 		.get_flags = of_bus_default_flags_get_flags,
 	},
 	/* Default */
@@ -826,7 +826,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	int na = parser->na;
 	int ns = parser->ns;
 	int np = parser->pna + na + ns;
-	int busflag_na = 0;
+	int busflag_na = parser->bus->flag_cells;
 
 	if (!range)
 		return NULL;
@@ -836,10 +836,6 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 
 	range->flags = parser->bus->get_flags(parser->range);
 
-	/* A extra cell for resource flags */
-	if (parser->bus->has_flags)
-		busflag_na = 1;
-
 	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
 
 	if (parser->dma)
-- 
2.42.0

