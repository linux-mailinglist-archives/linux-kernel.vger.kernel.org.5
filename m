Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D02675E725
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjGXBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGXBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:24:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4556019A9;
        Sun, 23 Jul 2023 18:22:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AA1460F1D;
        Mon, 24 Jul 2023 01:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C892AC433C9;
        Mon, 24 Jul 2023 01:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161769;
        bh=SryEwRecL/h/LuGScixb9fHQTh1zrXN+ikgoNGQ2X3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TU92PNTQ2Fy3dN5oeAelgI7702RtgATfUf4B0Mz44imHpl/HP2R4jlhm0aNx8Dvei
         VlXvahrcHVypd3pg5gvtOptrrATLP72JoXefxv8zndqz5AjS+6DDabDec23QjGHWAr
         wYC0Kvs972pP1XcGuchVhxtlxDGlmnVG2LNsKdWplZ1E/oaqXfTqOVxba6z3N9B41w
         ODJqzaneZNliy711NVVSDQqJSWH/XFSL0gtNbvHdA1lT54kUMfc9Wj5PRU1kEMpVzi
         /rAvuqX7O0E3RnUB1R3N2KLeTLbyaqrFhQpDWQaWBtSP5LJOpjEPf73WDfyXHXMqaO
         pKZsoFUAlCdXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        joro@8bytes.org, will@kernel.org, gregkh@linuxfoundation.org,
        kim.phillips@amd.com, bp@suse.de, eiichi.tsukata@nutanix.com,
        stephen@networkplumber.org, linux-doc@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 25/41] iommu/amd: Introduce Disable IRTE Caching Support
Date:   Sun, 23 Jul 2023 21:20:58 -0400
Message-Id: <20230724012118.2316073-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

[ Upstream commit 66419036f68a838c00cbccacd6cb2e99da6e5710 ]

An Interrupt Remapping Table (IRT) stores interrupt remapping configuration
for each device. In a normal operation, the AMD IOMMU caches the table
to optimize subsequent data accesses. This requires the IOMMU driver to
invalidate IRT whenever it updates the table. The invalidation process
includes issuing an INVALIDATE_INTERRUPT_TABLE command following by
a COMPLETION_WAIT command.

However, there are cases in which the IRT is updated at a high rate.
For example, for IOMMU AVIC, the IRTE[IsRun] bit is updated on every
vcpu scheduling (i.e. amd_iommu_update_ga()). On system with large
amount of vcpus and VFIO PCI pass-through devices, the invalidation
process could potentially become a performance bottleneck.

Introducing a new kernel boot option:

    amd_iommu=irtcachedis

which disables IRTE caching by setting the IRTCachedis bit in each IOMMU
Control register, and bypass the IRT invalidation process.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Link: https://lore.kernel.org/r/20230530141137.14376-4-suravee.suthikulpanit@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  1 +
 drivers/iommu/amd/amd_iommu_types.h           |  4 +++
 drivers/iommu/amd/init.c                      | 36 +++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6b838869554b1..71e93d8e2c130 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -323,6 +323,7 @@
 				       option with care.
 			pgtbl_v1     - Use v1 page table for DMA-API (Default).
 			pgtbl_v2     - Use v2 page table for DMA-API.
+			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5ecc17240eff5..f5e9377b55212 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -172,6 +172,7 @@
 #define CONTROL_GAINT_EN	29
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
+#define CONTROL_IRTCACHEDIS	59
 #define CONTROL_SNPAVIC_EN	61
 
 #define CTRL_INV_TO_MASK	(7 << CONTROL_INV_TIMEOUT)
@@ -708,6 +709,9 @@ struct amd_iommu {
 	/* if one, we need to send a completion wait command */
 	bool need_sync;
 
+	/* true if disable irte caching */
+	bool irtcachedis_enabled;
+
 	/* Handle for IOMMU core code */
 	struct iommu_device iommu;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b0af8b5967e0d..f6e64c9858021 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,6 +160,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 static bool amd_iommu_detected;
 static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
+static bool amd_iommu_irtcachedis;
 static int amd_iommu_target_ivhd_type;
 
 /* Global EFR and EFR2 registers */
@@ -477,6 +478,9 @@ static void iommu_disable(struct amd_iommu *iommu)
 
 	/* Disable IOMMU hardware itself */
 	iommu_feature_disable(iommu, CONTROL_IOMMU_EN);
+
+	/* Clear IRTE cache disabling bit */
+	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
 }
 
 /*
@@ -2700,6 +2704,33 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
 #endif
 }
 
+static void iommu_disable_irtcachedis(struct amd_iommu *iommu)
+{
+	iommu_feature_disable(iommu, CONTROL_IRTCACHEDIS);
+}
+
+static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
+{
+	u64 ctrl;
+
+	if (!amd_iommu_irtcachedis)
+		return;
+
+	/*
+	 * Note:
+	 * The support for IRTCacheDis feature is dertermined by
+	 * checking if the bit is writable.
+	 */
+	iommu_feature_enable(iommu, CONTROL_IRTCACHEDIS);
+	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+	ctrl &= (1ULL << CONTROL_IRTCACHEDIS);
+	if (ctrl)
+		iommu->irtcachedis_enabled = true;
+	pr_info("iommu%d (%#06x) : IRT cache is %s\n",
+		iommu->index, iommu->devid,
+		iommu->irtcachedis_enabled ? "disabled" : "enabled");
+}
+
 static void early_enable_iommu(struct amd_iommu *iommu)
 {
 	iommu_disable(iommu);
@@ -2710,6 +2741,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
+	iommu_enable_irtcachedis(iommu);
 	iommu_enable(iommu);
 	iommu_flush_all_caches(iommu);
 }
@@ -2760,10 +2792,12 @@ static void early_enable_iommus(void)
 		for_each_iommu(iommu) {
 			iommu_disable_command_buffer(iommu);
 			iommu_disable_event_buffer(iommu);
+			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
 			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
+			iommu_enable_irtcachedis(iommu);
 			iommu_set_device_table(iommu);
 			iommu_flush_all_caches(iommu);
 		}
@@ -3411,6 +3445,8 @@ static int __init parse_amd_iommu_options(char *str)
 			amd_iommu_pgtable = AMD_IOMMU_V1;
 		} else if (strncmp(str, "pgtbl_v2", 8) == 0) {
 			amd_iommu_pgtable = AMD_IOMMU_V2;
+		} else if (strncmp(str, "irtcachedis", 11) == 0) {
+			amd_iommu_irtcachedis = true;
 		} else {
 			pr_notice("Unknown option - '%s'\n", str);
 		}
-- 
2.39.2

