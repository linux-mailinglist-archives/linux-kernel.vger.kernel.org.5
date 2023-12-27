Return-Path: <linux-kernel+bounces-11976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E1281EE67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F101F210BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8588E44C6F;
	Wed, 27 Dec 2023 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8F45LaI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107C44C6A;
	Wed, 27 Dec 2023 11:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D503C433D9;
	Wed, 27 Dec 2023 11:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703674855;
	bh=falpcbXSJNuiEF3sSfc61cz1dUhSak77oGu3XO7JpyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8F45LaIzTKvZCbpbEQ4q4CfGGD0hkeWOOuqEP/rNa8Svhx5OzI04buJnTX1fyzOK
	 Fzn2pbudXRCl3Uc8xQ8JxibkpMqPBIkz7k4KwLPGx2YfxoYzxJxGdYutKdTG+7MHf4
	 uF2XpvJTJB3zqnH9eph8HjqrmE5I3+gJF1xlX/NltYXyzWqTjiwQg/mKiKpFKvig5M
	 3X5krhCmO9h5WCXsCjrexCwgTD4Sc66jI1x8+aBu0PcTjZGpAUcNXNnPewhF80cEkl
	 GAFTstILMEHQ14md3wUbVN4NeAPDMSHxg3aPU9rU1VDMAlpQ7KCPUBjPWkyJZiQOMe
	 LMGX6re4wnPlw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v4 3/3] irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
Date: Wed, 27 Dec 2023 12:00:38 +0100
Message-Id: <20231227110038.55453-4-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227110038.55453-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
 <20231227110038.55453-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index b203cfe28550..c253d151275e 100644
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
index 9a7a74239eab..8d088fca65a1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5578,6 +5578,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
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
index 98b0329b7154..48e02838fdc8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2356,6 +2356,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
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
@@ -2380,6 +2385,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
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
index 54189e0e5f41..a292f2bdb693 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -283,6 +283,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
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


