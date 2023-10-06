Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64CC7BB862
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjJFNAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjJFNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:00:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7901F13E
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4422FC433D9;
        Fri,  6 Oct 2023 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696597194;
        bh=G/RQSqdHo7lASFBMYlpWo2xm4T11AQkeeRKHxs9lv7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIP+xKCfRF09WaE97Ss+r3ih7yMoOZmpuQzoMGvh8Beq9Q/CCys6e51B+ou47+uBT
         KB1r/5YDUFwExz43PG6Ua0FkPe3qFqkN1zoj9stT+JHWkjI+BI+YuJq8WZ6c40I3sI
         a5FL7PCzV8ro4aR9LBMtffrN0mBztkev+e+ICE0ne5JwYGeDnIruNB/EvhCfEXVldj
         hl0NSBtRXYe5q06TbHe7C6Gqis7cenpI8FmUSXPYOOHFcNzbfIQaIlT+tVW7dPuj93
         2QfUaCfPJhM7PlEr9LKIiNNVnU1C5EE++NwE45PaJ6QlvGWM0Jo3KPUQgGUfWfUeyG
         3+P/ANk4+eI4g==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>
Subject: [PATCH v3 5/5] irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
Date:   Fri,  6 Oct 2023 14:59:29 +0200
Message-Id: <20231006125929.48591-6-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006125929.48591-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231006125929.48591-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

To enable non-coherent GIC designs on ACPI based systems, parse the MADT
GICC/GICR/ITS subtables non-coherent flags to determine whether the
respective components are non-coherent observers and force the shareability
attributes to be programmed into the redistributors and ITSes registers.

An ACPI global function (acpi_get_madt_revision()) is added to retrieve
the MADT revision, in that it is essential to check the MADT revision
before checking for flags that were added with MADT revision 7 so that
if the kernel is booted with ACPI tables (MADT rev < 7) it skips parsing
the newly added flags (that should be zeroed reserved values for MADT
versions < 7 but they could turn out to be buggy and should be ignored).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
 drivers/irqchip/irq-gic-common.h |  8 ++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/linux/acpi.h             |  3 +++
 5 files changed, 45 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 7dd6dbaa98c3..d3c7c6b0bb23 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -215,6 +215,27 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 	return rv;
 }
 
+u8 __init acpi_get_madt_revision(void)
+{
+	static u8 madt_revision __initdata;
+	static bool madt_read __initdata;
+	struct acpi_table_header *madt = NULL;
+
+	if (!madt_read) {
+		madt_read = true;
+
+		acpi_get_table(ACPI_SIG_MADT, 0, &madt);
+		if (!madt)
+			return madt_revision;
+
+		madt_revision = madt->revision;
+
+		acpi_put_table(madt);
+	}
+
+	return madt_revision;
+}
+
 static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index f407cce9ecaa..8dffee95f7e8 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -6,6 +6,7 @@
 #ifndef _IRQ_GIC_COMMON_H
 #define _IRQ_GIC_COMMON_H
 
+#include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/arm-gic-common.h>
@@ -29,6 +30,13 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
+#ifdef CONFIG_ACPI
+static inline bool gic_acpi_non_coherent_flag(u32 flags, u32 mask)
+{
+	return (acpi_get_madt_revision() >= 7) && (flags & mask);
+}
+#endif
+
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75a2dd550625..72ae9422a26f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5574,6 +5574,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 		goto node_err;
 	}
 
+	if (gic_acpi_non_coherent_flag(its_entry->flags,
+				       ACPI_MADT_ITS_NON_COHERENT))
+		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+
 	err = its_probe_one(its);
 	if (!err)
 		return 0;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f59ac9586b7b..720d76790ada 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2364,6 +2364,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+
+	if (gic_acpi_non_coherent_flag(redist->flags,
+				       ACPI_MADT_GICR_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_request_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
@@ -2389,6 +2394,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	gic_request_region(gicc->gicr_base_address, size, "GICR");
 
+	if (gic_acpi_non_coherent_flag(gicc->flags,
+				       ACPI_MADT_GICC_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a73246c3c35e..56e4e5f39a62 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -298,6 +298,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 	return phys_id == PHYS_CPUID_INVALID;
 }
 
+
+u8 __init acpi_get_madt_revision(void);
+
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
 /* Processor _CTS control */
-- 
2.34.1

