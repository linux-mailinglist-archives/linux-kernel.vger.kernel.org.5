Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22D57E8E28
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjKLEMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjKLEMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:12:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF31F30E6;
        Sat, 11 Nov 2023 20:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762329; x=1731298329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DCQy9ziTOxUJmllg1ZKA+yDNfB6XKqM3GiK9nVcKCAU=;
  b=YCQghsjykYPIODV/cTAWzVgUuAeAK8PDeSLxVJshMN5xAqY1ATLNgBCd
   luG9Xl3TJ2tjOZPzcPU/rpHasoRoeIiVxWoL8zEQJ0guBBnj2UbKU4Vwt
   83WORiv0QzLXv6LXPDrnX/bFBjRjlJjNI5XY3b+caDHQvAP1KmlaMPyGc
   KCpZfyxiPaAb5XA326wg4XmR8Xt42Udl1f7jHZHZyfsqK4AcVBBGuAAhs
   9ME1w6nVMSLdhz6ndICtAbTYoW3HLYjeUDF8PDOXEpisMYuNT5bkrfetS
   ykd62ZjqlYqrvCSv1bDF6441cD914ppwJ+heh5bEgyQfo8Yx2jRvtbcZf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533880"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533880"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936747"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936747"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2023 20:12:08 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
        iommu@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        "Lu Baolu" <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Borislav Petkov" <bp@alien8.de>,
        "Ingo Molnar" <mingo@redhat.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org,
        peterz@infradead.org, seanjc@google.com,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH RFC 04/13] iommu/vt-d: Add helper and flag to check/disable posted MSI
Date:   Sat, 11 Nov 2023 20:16:34 -0800
Message-Id: <20231112041643.2868316-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow command line opt-out posted MSI under CONFIG_X86_POSTED_MSI=y.
And add a helper function for testing if posted MSI is supported on the
CPU side.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_remapping.h | 11 +++++++++++
 drivers/iommu/irq_remapping.c        | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 7a2ed154a5e1..706f58900962 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -50,6 +50,17 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
 	return x86_vector_domain;
 }
 
+#ifdef CONFIG_X86_POSTED_MSI
+extern unsigned int posted_msi_off;
+
+static inline bool posted_msi_supported(void)
+{
+	return !posted_msi_off && irq_remapping_cap(IRQ_POSTING_CAP);
+}
+#else
+static inline bool posted_msi_supported(void) { return false; };
+#endif
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline bool irq_remapping_cap(enum irq_remap_cap cap) { return 0; }
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 83314b9d8f38..00de6963bb07 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -24,6 +24,23 @@ int no_x2apic_optout;
 
 int disable_irq_post = 0;
 
+#ifdef CONFIG_X86_POSTED_MSI
+
+unsigned int posted_msi_off;
+
+static int __init cmdl_posted_msi_off(char *str)
+{
+	int value = 0;
+
+	get_option(&str, &value);
+	posted_msi_off = value;
+
+	return 1;
+}
+
+__setup("posted_msi_off=", cmdl_posted_msi_off);
+#endif
+
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
 
-- 
2.25.1

