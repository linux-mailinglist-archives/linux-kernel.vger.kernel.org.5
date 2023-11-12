Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB77E8E2C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjKLEMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLEMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:12:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AF43253;
        Sat, 11 Nov 2023 20:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699762331; x=1731298331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4JwSbwScASMaLOkydBAHwmmqkSbLjlt1xmF7LwItuo=;
  b=Up+2QgpBEV0ySWhwR8cJzWzuKk5x5MVNfl/HfWPTWKWZlsSvBMqj/ZmQ
   Sh094lmy6+rzxXvSHo/NvZyoxzNyMtWoqcM/L58oPkidv9hOJi+LJL2pH
   EzHf1qMinKfr1FH2Dknb9TR2OmYtDtCnzhjrRJ9isNnQjplzvw+2ZPLmU
   uZHrnqQ/88040NVyL+nA6d0DmRCFgzaQrWQORTc2wTGLDqBG7OZzfZLmn
   /ZFXPnSZfFHxCr5WnrFPYpVQiTeoPdydQO9bk83syn9ZvNqwIh0CeTdDP
   AKTeW57lHf1o0eXY4FTsjF8MYhkzw/XTInMugymYd7V6LLPk3QkpVxyAF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="476533917"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="476533917"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 20:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="713936760"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="713936760"
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
Subject: [PATCH RFC 08/13] x86/irq: Factor out calling ISR from common_interrupt
Date:   Sat, 11 Nov 2023 20:16:38 -0800
Message-Id: <20231112041643.2868316-9-jacob.jun.pan@linux.intel.com>
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

Prepare for calling external IRQ handlers directly from the posted MSI
demultiplexing loop. Extract the common code with common interrupt to
avoid code duplication.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/kernel/irq.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index fd4d664d81bb..0bffe8152385 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -242,18 +242,10 @@ static __always_inline void handle_irq(struct irq_desc *desc,
 		__handle_irq(desc, regs);
 }
 
-/*
- * common_interrupt() handles all normal device IRQ's (the special SMP
- * cross-CPU interrupts have their own entry points).
- */
-DEFINE_IDTENTRY_IRQ(common_interrupt)
+static __always_inline void call_irq_handler(int vector, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
-	/* entry code tells RCU that we're not quiescent.  Check it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
-
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
@@ -268,7 +260,20 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
 	}
+}
+
+/*
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own entry points).
+ */
+DEFINE_IDTENTRY_IRQ(common_interrupt)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	/* entry code tells RCU that we're not quiescent.  Check it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
 
+	call_irq_handler(vector, regs);
 	set_irq_regs(old_regs);
 }
 
-- 
2.25.1

