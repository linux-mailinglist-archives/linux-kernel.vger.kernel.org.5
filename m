Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6206B7E8E25
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjKLEMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKLEMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:12:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F8130D6;
        Sat, 11 Nov 2023 20:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762329; x=1731298329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ouYom2tBlHd3aDBaZZVG3gi5SN++gaATZnTLzCcbbws=;
  b=h/PjgH6q+G04R+PtwuR5ggWplCwXG3RlwKuciSl6RWbDb4LZje6Y7l3y
   RtwQt1iTOeY1TEwefpV/YYRkn9gMM9Xn/oFBPEImBI4D2VCilar+CFQ7p
   JfpkgrJBTsxn/58A16OO103R6MizrpQli7+9mCiW9pyPIbrjyui6GHLyj
   pPlCFJnlYWz0umip4qvyUGUmOJL1Neujd+haYG4UMM5Z/o0OfsFjobCgN
   HN3a0lrwCEAVwKD4F3hUKga/4LD01w2jiL2ULfC0rZzveftRifxg6c0Mf
   BiyRr7k4lhAtbe8MO3xvqOM6a3n/mXPVAp3tXNLVXiENQSXn2yAHbcQ3e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533871"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936743"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936743"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Nov 2023 20:12:07 -0800
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
Subject: [PATCH RFC 03/13] x86: Reserved a per CPU IDT vector for posted MSIs
Date:   Sat, 11 Nov 2023 20:16:33 -0800
Message-Id: <20231112041643.2868316-4-jacob.jun.pan@linux.intel.com>
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

Under posted MSIs, all device MSIs are multiplexed into a single CPU
notification vector. MSI handlers will be de-multiplexed at run-time by
system software without IDT delivery.

This vector has a priority class below the rest of the system vectors.

Potentially, external vector number space for MSIs can be expanded to
the entire 0-256 range.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/irq_vectors.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 3a19904c2db6..077ca38f5a91 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -99,9 +99,22 @@
 
 #define LOCAL_TIMER_VECTOR		0xec
 
+/*
+ * Posted interrupt notification vector for all device MSIs delivered to
+ * the host kernel.
+ *
+ * Choose lower priority class bit [7:4] than other system vectors such
+ * that it can be preempted by the system interrupts.
+ *
+ * It is also higher than all external vectors but it should not matter
+ * in that external vectors for posted MSIs are in a different number space.
+ */
+#define POSTED_MSI_NOTIFICATION_VECTOR	0xdf
 #define NR_VECTORS			 256
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef X86_POSTED_MSI
+#define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
+#elif defined(CONFIG_X86_LOCAL_APIC)
 #define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
 #else
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
-- 
2.25.1

