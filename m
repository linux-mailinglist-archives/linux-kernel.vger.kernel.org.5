Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A357E42F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjKGPLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjKGPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:11:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14240619E;
        Tue,  7 Nov 2023 07:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699369322; x=1730905322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SefIc9ILSqdc9XL8YiZXGRG69G2enCZ2JSkPRZ5JvNk=;
  b=VM4hRFr2T+Pa1iQHfjAiYkwCRi/m0amln0MKrjhxG4liBgOTGK38tESS
   MiZ9o0cNaxtme89iptVnhnyWJ04rJmTU93sa7q+TTzFtClMZ78LTt8LrZ
   8StUlYig7LtXJdOwBAv/h7zQ/qRivio04KYgChV8llj5LRMWItV1TllkO
   C7kL9c5pIefydLtUNdIs535HbBcE16BFjAD+Y/3hv/xfYLz2w50+fN6wM
   /Inm7CHI6THkINHYQyxL8mi1peO74ilXufRIoqbI+l6DROb1dtVmlniCB
   KK8Y7QcDfu/WF4Knj8dun1wGgokg2z8Fa0cTqPKpFA2oVkgZiKNr+vtNO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="388397608"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="388397608"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="10446838"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:00:59 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
Subject: [PATCH v6 10/16] KVM: x86/tdp_mmu: Allocate private page table for large page split
Date:   Tue,  7 Nov 2023 07:00:37 -0800
Message-Id: <042103ab22aee26739a391b9f893c1dc78654e67.1699368363.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1699368363.git.isaku.yamahata@intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Make tdp_mmu_alloc_sp_split() aware of private page table.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/mmu/mmu_internal.h | 14 ++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c      |  8 ++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index d8d46a4d00ff..1da98be74ad2 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -202,6 +202,15 @@ static inline void kvm_mmu_alloc_private_spt(struct kvm_vcpu *vcpu, struct kvm_m
 	}
 }
 
+static inline int kvm_alloc_private_spt_for_split(struct kvm_mmu_page *sp, gfp_t gfp)
+{
+	gfp &= ~__GFP_ZERO;
+	sp->private_spt = (void *)__get_free_page(gfp);
+	if (!sp->private_spt)
+		return -ENOMEM;
+	return 0;
+}
+
 static inline void kvm_mmu_free_private_spt(struct kvm_mmu_page *sp)
 {
 	if (sp->private_spt)
@@ -230,6 +239,11 @@ static inline void kvm_mmu_alloc_private_spt(struct kvm_vcpu *vcpu, struct kvm_m
 {
 }
 
+static inline int kvm_alloc_private_spt_for_split(struct kvm_mmu_page *sp, gfp_t gfp)
+{
+	return -ENOMEM;
+}
+
 static inline void kvm_mmu_free_private_spt(struct kvm_mmu_page *sp)
 {
 }
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index d806574f7f2d..7873e9ee82ad 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1583,8 +1583,12 @@ static struct kvm_mmu_page *__tdp_mmu_alloc_sp_for_split(gfp_t gfp, union kvm_mm
 
 	sp->role = role;
 	sp->spt = (void *)__get_free_page(gfp);
-	/* TODO: large page support for private GPA. */
-	WARN_ON_ONCE(kvm_mmu_page_role_is_private(role));
+	if (kvm_mmu_page_role_is_private(role)) {
+		if (kvm_alloc_private_spt_for_split(sp, gfp)) {
+			free_page((unsigned long)sp->spt);
+			sp->spt = NULL;
+		}
+	}
 	if (!sp->spt) {
 		kmem_cache_free(mmu_page_header_cache, sp);
 		return NULL;
-- 
2.25.1

