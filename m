Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007437545D9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGOAy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGOAyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:54:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F323ABC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso2085727276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689382462; x=1689987262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUK72LErj/cW/DTmM0D0+KH5bgl9rti1KYfAR7QuG/E=;
        b=sshR00+aAtBOwWYiCZGAYpO4fnVVTo5dI2raRcizF4Tm6lh+XV/lYXfBQd4dBrS+qm
         i9fl23qrXjR5kHI3koSQi2N0fvB1mruZ7myfnUZdtau2iBmAY25ul9EC/XtB0oyjhP+j
         DPSRaMZQvinCY+Tx+9uroryxalSjGSfC6ZTutGuMfsHVSZXDnWp3lgux9oekKpiJWkDd
         LnpF26hYxlw4oSLziHYFF2uWUIJeHfOhfTzx5I6iySyI2QIpX/VckMtq2Y1BylDNSPF6
         bZiFVMVdblBlMiDEWAav1nw/+iNW2eGy7WyE50JOnaa7KlDcyD+Jv7AkWo7c1CCRY5dH
         jolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382462; x=1689987262;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUK72LErj/cW/DTmM0D0+KH5bgl9rti1KYfAR7QuG/E=;
        b=DmfdJQIs8wk3n45xFdR9AQbA8hjAetyetOYKu24FDxIAIrjlEcQvcx4yHOXXTHJHkT
         1VrNPqvSzB7MlS6i9gVmQLrpKhX+ukKDWhKzozk40vFei7751rSJEl9nUlW64GrIpEpx
         AgkQKotdS1i5qiJNL4c7T/9dEV+DfeSnPEeM2ZSVLQC9ijQWS73sDPgckSrGtghkMkh/
         1uPwPAdh2XvHCr7x1iI64Pa15slwlOB7v/mtbIALw2a/rZk2zfRkobgXecu/T3IzQbV7
         F96Ie2vw5boVEBk498bxLRhNw2Kw5k7rHj5z4dy4RKLtSDi8psxHWSlTUteNZv9dd22T
         WUTw==
X-Gm-Message-State: ABy/qLZMlWEIZN9s0ZaE03a5dpkxn1yjbJx2l2+7+CqZU7DavAM5h0Fk
        8clrFkTknvspPIDPctQkF8Co1X/kApww
X-Google-Smtp-Source: APBJJlE0qITDo/wAXwRSd8iXWERdmKc71Dhpe2SjiRxhIc+LHhnKc3gfGxQ/Ra7EcVIhEZwkmD1LWTU7Ye9M
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a25:32c2:0:b0:c62:5700:6520 with SMTP id
 y185-20020a2532c2000000b00c6257006520mr34849yby.3.1689382462727; Fri, 14 Jul
 2023 17:54:22 -0700 (PDT)
Date:   Sat, 15 Jul 2023 00:54:05 +0000
In-Reply-To: <20230715005405.3689586-1-rananta@google.com>
Mime-Version: 1.0
References: <20230715005405.3689586-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
Message-ID: <20230715005405.3689586-12-rananta@google.com>
Subject: [PATCH v6 11/11] KVM: arm64: Use TLBI range-based intructions for unmap
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
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the stage-2 unmap walker traverses
the given range and, as a part of break-before-make, performs
TLB invalidations with a DSB for every PTE. A multitude of this
combination could cause a performance bottleneck on some systems.

Hence, if the system supports FEAT_TLBIRANGE, defer the TLB
invalidations until the entire walk is finished, and then
use range-based instructions to invalidate the TLBs in one go.
Condition deferred TLB invalidation on the system supporting FWB,
as the optimization is entirely pointless when the unmap walker
needs to perform CMOs.

Rename stage2_put_pte() to stage2_unmap_put_pte() as the function
now serves the stage-2 unmap walker specifically, rather than
acting generic.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 67 +++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 5ef098af1736..cf88933a2ea0 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -831,16 +831,54 @@ static void stage2_make_pte(const struct kvm_pgtable_visit_ctx *ctx, kvm_pte_t n
 	smp_store_release(ctx->ptep, new);
 }
 
-static void stage2_put_pte(const struct kvm_pgtable_visit_ctx *ctx, struct kvm_s2_mmu *mmu,
-			   struct kvm_pgtable_mm_ops *mm_ops)
+struct stage2_unmap_data {
+	struct kvm_pgtable *pgt;
+	bool defer_tlb_flush_init;
+};
+
+static bool __stage2_unmap_defer_tlb_flush(struct kvm_pgtable *pgt)
+{
+	/*
+	 * If FEAT_TLBIRANGE is implemented, defer the individual
+	 * TLB invalidations until the entire walk is finished, and
+	 * then use the range-based TLBI instructions to do the
+	 * invalidations. Condition deferred TLB invalidation on the
+	 * system supporting FWB, as the optimization is entirely
+	 * pointless when the unmap walker needs to perform CMOs.
+	 */
+	return system_supports_tlb_range() && stage2_has_fwb(pgt);
+}
+
+static bool stage2_unmap_defer_tlb_flush(struct stage2_unmap_data *unmap_data)
+{
+	bool defer_tlb_flush = __stage2_unmap_defer_tlb_flush(unmap_data->pgt);
+
+	/*
+	 * Since __stage2_unmap_defer_tlb_flush() is based on alternative
+	 * patching and the TLBIs' operations behavior depend on this,
+	 * track if there's any change in the state during the unmap sequence.
+	 */
+	WARN_ON(unmap_data->defer_tlb_flush_init != defer_tlb_flush);
+	return defer_tlb_flush;
+}
+
+static void stage2_unmap_put_pte(const struct kvm_pgtable_visit_ctx *ctx,
+				struct kvm_s2_mmu *mmu,
+				struct kvm_pgtable_mm_ops *mm_ops)
 {
+	struct stage2_unmap_data *unmap_data = ctx->arg;
+
 	/*
-	 * Clear the existing PTE, and perform break-before-make with
-	 * TLB maintenance if it was valid.
+	 * Clear the existing PTE, and perform break-before-make if it was
+	 * valid. Depending on the system support, the TLB maintenance for
+	 * the same can be deferred until the entire unmap is completed.
 	 */
 	if (kvm_pte_valid(ctx->old)) {
 		kvm_clear_pte(ctx->ptep);
-		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu, ctx->addr, ctx->level);
+
+		if (!stage2_unmap_defer_tlb_flush(unmap_data))
+			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu,
+					ctx->addr, ctx->level);
 	}
 
 	mm_ops->put_page(ctx->ptep);
@@ -1070,7 +1108,8 @@ int kvm_pgtable_stage2_set_owner(struct kvm_pgtable *pgt, u64 addr, u64 size,
 static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 			       enum kvm_pgtable_walk_flags visit)
 {
-	struct kvm_pgtable *pgt = ctx->arg;
+	struct stage2_unmap_data *unmap_data = ctx->arg;
+	struct kvm_pgtable *pgt = unmap_data->pgt;
 	struct kvm_s2_mmu *mmu = pgt->mmu;
 	struct kvm_pgtable_mm_ops *mm_ops = ctx->mm_ops;
 	kvm_pte_t *childp = NULL;
@@ -1098,7 +1137,7 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 	 * block entry and rely on the remaining portions being faulted
 	 * back lazily.
 	 */
-	stage2_put_pte(ctx, mmu, mm_ops);
+	stage2_unmap_put_pte(ctx, mmu, mm_ops);
 
 	if (need_flush && mm_ops->dcache_clean_inval_poc)
 		mm_ops->dcache_clean_inval_poc(kvm_pte_follow(ctx->old, mm_ops),
@@ -1112,13 +1151,23 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
 
 int kvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 addr, u64 size)
 {
+	int ret;
+	struct stage2_unmap_data unmap_data = {
+		.pgt = pgt,
+		.defer_tlb_flush_init = __stage2_unmap_defer_tlb_flush(pgt),
+	};
 	struct kvm_pgtable_walker walker = {
 		.cb	= stage2_unmap_walker,
-		.arg	= pgt,
+		.arg	= &unmap_data,
 		.flags	= KVM_PGTABLE_WALK_LEAF | KVM_PGTABLE_WALK_TABLE_POST,
 	};
 
-	return kvm_pgtable_walk(pgt, addr, size, &walker);
+	ret = kvm_pgtable_walk(pgt, addr, size, &walker);
+	if (stage2_unmap_defer_tlb_flush(&unmap_data))
+		/* Perform the deferred TLB invalidations */
+		kvm_tlb_flush_vmid_range(pgt->mmu, addr, size);
+
+	return ret;
 }
 
 struct stage2_attr_data {
-- 
2.41.0.455.g037347b96a-goog

