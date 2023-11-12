Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912147E8E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjKLEMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjKLEMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:12:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B336735BB;
        Sat, 11 Nov 2023 20:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762331; x=1731298331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nMrBMNqKNmE7TkVKdlJ7grKzLWcWZpw3D0RMZ2QEFQQ=;
  b=ZVNq8+xwI2juJuGpWyX6Ug5Dpfutn1YjEZ/AUVY6x7et5ETWyPp0B06b
   5bMVi6t7neCTUQnEDDkJeZ7eOMnsN81qIn+OqiI511TtXOtAkH3BQ+bnw
   1EAd3zdhoNOddE+E5PvhmiBzF8qmmNJxkYCZoan9gtTm6llvc/qmrPHxV
   eFQlsFiRfCXhbl3ibem/HuVg5/11x50ExoXUkveOylLWeK2IhJ+6gwRmy
   1Y1Z4gZaddUmr8q6/pMT6Z+BKEaSVNbytKf1EEh+mu/Fr73Li7dmEnC+R
   2+r1fabIp7j891TDtSPJmDIcc0x7e6gFTLsiANEtYl6rtFDM2TBw7UARK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533909"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533909"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936757"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936757"
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
Subject: [PATCH RFC 07/13] x86/irq: Add helpers for checking Intel PID
Date:   Sat, 11 Nov 2023 20:16:37 -0800
Message-Id: <20231112041643.2868316-8-jacob.jun.pan@linux.intel.com>
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

Intel posted interrupt descriptor (PID) stores pending interrupts in its
posted interrupt requests (PIR) bitmap.

Add helper functions to check individual vector status and the entire bitmap.

They are used for interrupt migration and runtime demultiplexing posted MSI
vectors.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/posted_intr.h | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index 3af00f5395e4..12a4fa3ff60e 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -98,9 +98,40 @@ static inline bool pi_test_sn(struct pi_desc *pi_desc)
 }
 
 #ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Not all external vectors are subject to interrupt remapping, e.g. IOMMU's
+ * own interrupts. Here we do not distinguish them since those vector bits in
+ * PIR will always be zero.
+ */
+static inline bool is_pi_pending_this_cpu(unsigned int vector)
+{
+	struct pi_desc *pid;
+
+	if (WARN_ON(vector > NR_VECTORS || vector < FIRST_EXTERNAL_VECTOR))
+		return false;
+
+	pid = this_cpu_ptr(&posted_interrupt_desc);
+
+	return (pid->pir[vector >> 5] & (1 << (vector % 32)));
+}
+
+static inline bool is_pir_pending(struct pi_desc *pid)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (pid->pir_l[i])
+			return true;
+	}
+
+	return false;
+}
+
 extern void intel_posted_msi_init(void);
 
 #else
+static inline bool is_pi_pending_this_cpu(unsigned int vector) {return false; }
+
 static inline void intel_posted_msi_init(void) {};
 
 #endif /* X86_POSTED_MSI */
-- 
2.25.1

