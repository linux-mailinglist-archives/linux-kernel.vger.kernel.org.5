Return-Path: <linux-kernel+bounces-35152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AC838CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455A928B998
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047F55D91B;
	Tue, 23 Jan 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAQA9lLk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E35D90B;
	Tue, 23 Jan 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007822; cv=none; b=oh3/t5k2y/x8CBu/Ym36LKlKuXQ9w/Xemg6bpd2O1s8XCHD5/MJEvYYDIFJv6AxEIg/JzuvbRSROe24zT5RP+2Btkc7AINU3eaqZBcrdy1P5JCEfeSFEJnYVrpFctv+vBmP2KEGAQ5DQrpjplgfJUdVftmkIwcuZSGLDLEJIqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007822; c=relaxed/simple;
	bh=yxslJnBmg5lxtsS0rsR6gRhm2LlSKzD9dPNmd8c8t9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nrORnU/Bx5PbZgZxrURN6IoLC0xEO1rUd9YQY56/sZer/0qAjCIe8B8dNLgJaW95BbuBGp4ZnkPXcebf9FXA5i/rVHHvUjYAeqEN4zQKWPaPaY4yBvM2lyy1s0anNkQq3QQfcgMd9DdkwWHmMPGuqx+O8+kV+WKpp2J+F6lfHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAQA9lLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293BEC433F1;
	Tue, 23 Jan 2024 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706007821;
	bh=yxslJnBmg5lxtsS0rsR6gRhm2LlSKzD9dPNmd8c8t9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAQA9lLk1o09pZ0OU8sEoF/LI25bbOJBw4xu8n0aWQpPnTEx4nmNze4zTXnxYEmmg
	 vi2y9jUVu4NQOo95uUULh2cBfA0tQq6g/j6fLGB0gUTJLstUoWvHdXcdrPMCzcB55M
	 VJ+ftYWffw3aPPns9d6PsiayBWddORbduSkroNcohTeAv3s7vkKT54j7zn0iGxg6z/
	 CrOJHnVUl+S3tYSe9ipau5qYUAZ88qVU077iPrvLsGtbyB3QPhmECoVyhcFWxhoPD+
	 2Nz9K11GGtgzIUG9fupGmRZTjAy5X2382nFvcUOJT/hZPWvwQwATwHPZDORIzM9wNs
	 4kPXh7FplRA3w==
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
Subject: [PATCH v5 1/1] irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing
Date: Tue, 23 Jan 2024 12:03:32 +0100
Message-Id: <20240123110332.112797-2-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123110332.112797-1-lpieralisi@kernel.org>
References: <20240123110332.112797-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GIC architecture specification defines a set of registers for
redistributors and ITSes that control the sharebility and cacheability
attributes of redistributors/ITSes initiator ports on the interconnect
(GICR_[V]PROPBASER, GICR_[V]PENDBASER, GITS_BASER<n>).

Architecturally the GIC provides a means to drive shareability and
cacheability attributes signals but it is not mandatory for designs to
wire up the corresponding interconnect signals that control the
cacheability/shareability of transactions.

Redistributors and ITSes interconnect ports can be connected to
non-coherent interconnects that are not able to manage the
shareability/cacheability attributes; this implicitly makes the
redistributors and ITSes non-coherent observers.

To enable non-coherent GIC designs on ACPI based systems, parse the MADT
GICC/GICR/ITS subtables non-coherent flags to determine whether the
respective components are non-coherent observers and force the
shareability attributes to be programmed into the redistributors and
ITSes registers.

An ACPI global function (acpi_get_madt_revision()) is added to retrieve
the MADT revision, in that it is essential to check the MADT revision
before checking for flags that were added with MADT revision 7 so that
if the kernel is booted with an ACPI MADT table with revision < 7 it
skips parsing the newly added flags (that should be zeroed reserved
values for MADT versions < 7 but they could turn out to be buggy and
should be ignored).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/processor_core.c    | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/linux/acpi.h             |  3 +++
 4 files changed, 31 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b203cfe28550..915713c0e9b7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
 	return rv;
 }
 
+int __init acpi_get_madt_revision(void)
+{
+	struct acpi_table_header *madt = NULL;
+	int revision;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0, &madt)))
+		return -EINVAL;
+
+	revision = madt->revision;
+
+	acpi_put_table(madt);
+
+	return revision;
+}
+
 static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fec1b58470df..a60c560ce891 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5591,6 +5591,10 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 		goto node_err;
 	}
 
+	if (acpi_get_madt_revision() >= 7 &&
+	    (its_entry->flags & ACPI_MADT_ITS_NON_COHERENT))
+		its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+
 	err = its_probe_one(its);
 	if (!err)
 		return 0;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..8cb8dff86c12 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2356,6 +2356,11 @@ gic_acpi_parse_madt_redist(union acpi_subtable_headers *header,
 		pr_err("Couldn't map GICR region @%llx\n", redist->base_address);
 		return -ENOMEM;
 	}
+
+	if (acpi_get_madt_revision() >= 7 &&
+	    (redist->flags & ACPI_MADT_GICR_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_request_region(redist->base_address, redist->length, "GICR");
 
 	gic_acpi_register_redist(redist->base_address, redist_base);
@@ -2380,6 +2385,10 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	gic_request_region(gicc->gicr_base_address, size, "GICR");
 
+	if (acpi_get_madt_revision() >= 7 &&
+	    (gicc->flags & ACPI_MADT_GICC_NON_COHERENT))
+		gic_data.rdists.flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
 	gic_acpi_register_redist(gicc->gicr_base_address, redist_base);
 	return 0;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b7165e52b3c6..4eedab0e51c3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -284,6 +284,9 @@ static inline bool invalid_phys_cpuid(phys_cpuid_t phys_id)
 	return phys_id == PHYS_CPUID_INVALID;
 }
 
+
+int __init acpi_get_madt_revision(void);
+
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
 /* Processor _CTS control */
-- 
2.34.1


