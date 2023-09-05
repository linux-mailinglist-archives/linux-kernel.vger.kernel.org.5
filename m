Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06499792BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbjIEQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354337AbjIEKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:47:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835C2199;
        Tue,  5 Sep 2023 03:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD2E1CE1178;
        Tue,  5 Sep 2023 10:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AA8C433A9;
        Tue,  5 Sep 2023 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693910855;
        bh=be3LTeFm799ZIVXUkbKCDmqLg5EZsxWtrrfYzGafTQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kn2eZZwyL2WrmDC9u1LV85D4PdFEhtw9KkxYls2VcOJ2Yo5YjFuIJlGgulxVuvPra
         wUc6CkhPD1ZV7DFJe348R2JAET0zkHfPX6h3CS/rx2IC54DEuvPd1Q5wHPFgF3rNo9
         hC7IQr88u5L6Cz5LXpYaTnvBueqMQTWjTFPrtEEElSUmNeTdF8cP72MVF8ddZoPBo4
         mvYv8Yor76j11jo4Jb13UrqWUyHpfvFSX3Ew5YJu/ryRtvi9X9z+SXOCJfzDrLFfvY
         98WKpVK0lpoX6BgwGDci2DWb2UkybEtadDt8A21tDQnvYxmzyjGQeAFTqv20f0fwe1
         whP6SGZ3DfxDA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: [PATCH 2/2] irqchip/gic-v3: Enable non-coherent redistributors/ITSes probing
Date:   Tue,  5 Sep 2023 12:47:21 +0200
Message-Id: <20230905104721.52199-3-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905104721.52199-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC architecture specification defines a set of registers
for redistributors and ITSes that control the sharebility and
cacheability attributes of redistributors/ITSes initiator ports
on the interconnect (GICR_[V]PROPBASER, GICR_[V]PENDBASER,
GITS_BASER<n>).

Architecturally the GIC provides a means to drive shareability
and cacheability attributes signals and related IWB/OWB/ISH barriers
but it is not mandatory for designs to wire up the corresponding
interconnect signals that control the cacheability/shareability
of transactions.

Redistributors and ITSes interconnect ports can be connected to
non-coherent interconnects that are not able to manage the
shareability/cacheability attributes; this implicitly makes
the redistributors and ITSes non-coherent observers.

So far, the GIC driver on probe executes a write to "probe" for
the redistributors and ITSes registers shareability bitfields
by writing a value (ie InnerShareable - the shareability domain the
CPUs are in) and check it back to detect whether the value sticks or
not; this hinges on a GIC programming model behaviour that predates the
current specifications, that just define shareability bits as writeable
but do not guarantee that writing certain shareability values
enable the expected behaviour for the redistributors/ITSes
memory interconnect ports.

To enable non-coherent GIC designs, introduce the "dma-noncoherent"
device tree property to allow firmware to describe redistributors and
ITSes as non-coherent observers on the memory interconnect and use the
property to force the shareability attributes to be programmed into the
redistributors and ITSes registers.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e0c2b10d154d..758ea3092305 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5056,7 +5056,8 @@ static int __init its_compute_its_list_map(struct resource *res,
 }
 
 static int __init its_probe_one(struct resource *res,
-				struct fwnode_handle *handle, int numa_node)
+				struct fwnode_handle *handle, int numa_node,
+				bool non_coherent)
 {
 	struct its_node *its;
 	void __iomem *its_base;
@@ -5148,7 +5149,7 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
-	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
+	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE || non_coherent)
 		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
 
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
@@ -5356,11 +5357,19 @@ static const struct of_device_id its_device_id[] = {
 	{},
 };
 
+static void of_check_rdists_coherent(struct device_node *node)
+{
+	if (of_property_read_bool(node, "dma-noncoherent"))
+		gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+}
+
 static int __init its_of_probe(struct device_node *node)
 {
 	struct device_node *np;
 	struct resource res;
 
+	of_check_rdists_coherent(node);
+
 	/*
 	 * Make sure *all* the ITS are reset before we probe any, as
 	 * they may be sharing memory. If any of the ITS fails to
@@ -5396,7 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
 			continue;
 		}
 
-		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
+		its_probe_one(&res, &np->fwnode, of_node_to_nid(np),
+			      of_property_read_bool(np, "dma-noncoherent"));
 	}
 	return 0;
 }
@@ -5533,7 +5543,8 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 	}
 
 	err = its_probe_one(&res, dom_handle,
-			acpi_get_its_numa_node(its_entry->translation_id));
+			acpi_get_its_numa_node(its_entry->translation_id),
+			false);
 	if (!err)
 		return 0;
 
-- 
2.34.1

