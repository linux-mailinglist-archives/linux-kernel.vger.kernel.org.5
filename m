Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BBF75D916
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGVCXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGVCXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:23:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E8119
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:23:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c6db61f7f64so2575938276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689992583; x=1690597383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8R5tRLm4LxOnjTEGwM7a4ioC3VdBYtUr1OruyGFhsg=;
        b=cfBIBtaMGZEf4AhY6J0548A+CtaTY7s4VELnEIeFABxI92SvaWQW27WRnp+/q887jd
         b1TjIDORVqU07EPUQ/Q19Kx672JDaqfeiAMzany/gcKSRQRyhlDPKz73ZGnNHtbWJBcs
         UdVEkbrC7PTnQ3AO+JgNGaP9tE7X1Jr8LevbOQPisjvpV/1GUqvSezpBlGv+V1Pa8Bk/
         Dz7iMBvzxCmA92YdIR4l8vs0QhvpSPRaa9AWLGqWcLL0gam+6TRFZut+BKtU94QsycPh
         UUDfnGqhH3nalOxviTCBnCVfFkZB08T951R3KSDpXW/NULcZOSqnOMHnzE4x6FrSPe5l
         ug3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689992583; x=1690597383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8R5tRLm4LxOnjTEGwM7a4ioC3VdBYtUr1OruyGFhsg=;
        b=YHHfEp9A6Mnjy8KzCNc4ln43IE/KuRw0hjtIZqEHkfit1g77yTJS4y69h/HsuoCP8n
         BlYCyzJPSLUCfVz0BI/0rAh99Wu8/2mlD9VspvkRP0XpM943JV+dXE8RWJTy8d/BOHWu
         f2COgRGvD/SRjb5NjMPdlB+lsihDkmKoyyQt0h1R7LFqH5pY5oL+jeR7w9fW5YFgR+2g
         oAF3JBgGQBG1bhYJyDm5haaps0PK0I8FbcCwGhcDZeKOPwG/X9LTwt4BT+f0q8hWyNc/
         X03Egs+E+YgZsYnRrEPSyYUe/pIvQQmJI7z4mutxcAhoUZ7cDQ6gyOCXZw7hrNl5HWen
         3SOQ==
X-Gm-Message-State: ABy/qLaCjakSyggCR24rdV4JUV2Csi5UULD9p/PLzOWJb2AFag8zYPPx
        hFPD0XS+vGg6NLQo0Ei9Vx/p5KUNE6MD
X-Google-Smtp-Source: APBJJlHQt1NDcPAocmh72u+0bhsq/dtXjKO55NUZwrSeo0TWR6BjgNiz1KwqJUxErtKe8+mwZ90j9gI+Kx9y
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a05:6902:102f:b0:c22:38c2:43de with SMTP
 id x15-20020a056902102f00b00c2238c243demr26408ybt.11.1689992582937; Fri, 21
 Jul 2023 19:23:02 -0700 (PDT)
Date:   Sat, 22 Jul 2023 02:22:47 +0000
In-Reply-To: <20230722022251.3446223-1-rananta@google.com>
Mime-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230722022251.3446223-9-rananta@google.com>
Subject: [PATCH v7 08/12] KVM: arm64: Define kvm_tlb_flush_vmid_range()
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the helper kvm_tlb_flush_vmid_range() that acts
as a wrapper for range-based TLB invalidations. For the
given VMID, use the range-based TLBI instructions to do
the job or fallback to invalidating all the TLB entries.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 10 ++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 8294a9a7e566..5e8b1ff07854 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -754,4 +754,14 @@ enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
  *	   kvm_pgtable_prot format.
  */
 enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
+
+/**
+ * kvm_tlb_flush_vmid_range() - Invalidate/flush a range of TLB entries
+ *
+ * @mmu:	Stage-2 KVM MMU struct
+ * @addr:	The base Intermediate physical address from which to invalidate
+ * @size:	Size of the range from the base to invalidate
+ */
+void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
+				phys_addr_t addr, size_t size);
 #endif	/* __ARM64_KVM_PGTABLE_H__ */
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index aa740a974e02..5d14d5d5819a 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -670,6 +670,26 @@ static bool stage2_has_fwb(struct kvm_pgtable *pgt)
 	return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
 }
 
+void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
+				phys_addr_t addr, size_t size)
+{
+	unsigned long pages, inval_pages;
+
+	if (!system_supports_tlb_range()) {
+		kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+		return;
+	}
+
+	pages = size >> PAGE_SHIFT;
+	while (pages > 0) {
+		inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_range, mmu, addr, inval_pages);
+
+		addr += inval_pages << PAGE_SHIFT;
+		pages -= inval_pages;
+	}
+}
+
 #define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has_fwb(pgt))
 
 static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot prot,
-- 
2.41.0.487.g6d72f3e995-goog

