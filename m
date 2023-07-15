Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C087545D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGOAyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGOAyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:54:33 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA413ABA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:22 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6b9bfaeb902so1691150a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689382461; x=1689987261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMoefZA3MlfauFX/NYW5KwnK8DnygDi/JN2AwltT7bM=;
        b=SX3GKM5mrWJriN6mxD7VKeCoEPGOfTdqn9EwSVirR6iKLo+Nl6dOv0quukgzWk7nHV
         6SuTwz5hjAZ7RKSmLUVJAnQwmGnCeiKEXzsUeJS6USuq1kdz9DNMt2LL73YEMCwj9WtV
         /f5/EMib2Mx/MrnCnC8HQBCxs0PSREypg3sn2FU4oZq+NwN8DlcYLayUp8dvvQ/PDvse
         Tid41Ff1Asl9LR8kElyDqeng1Ti3X11kF3j9m6GGmCa3VeZRfS5fA/IyMr1nNEJGM/hh
         pYCNhoUPVBY51zoHdVpxLc1drh0sy2xu3hEaoB2qkIdpv/8VbSBobhzqoI+oFtOp0nB8
         DM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382461; x=1689987261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMoefZA3MlfauFX/NYW5KwnK8DnygDi/JN2AwltT7bM=;
        b=IyS5euFbNEgAPuBPQ29pBJfFQfmE55tL0thsCRRA77UGBTeoCm8tPiE78KsGw5JbjI
         gv8xaYhWx/hYfTvBBQFIGr/yOfiINjbnDUuE0LK+v14xwbyQmAcdVFZMos/YtzCK93E7
         gP5jGKHeJwcFsPhwTti/O8sYNuegMxM9YDE6Cm90GA5assCiiCCm16Q7bIPeM7HqGIAW
         SkEnm0NanfcaVvqw8NycuZiQYH8J8g7gsckCJl5/WlUzUi9EnIWM5ca4JL8Ic3JY5ieF
         0LJTKYckOspU9QDwzNo9DFQZePtz1F+xW4cxxrqRqWt1t4wogDrUgJWjHrheWPLRHy6o
         gc/Q==
X-Gm-Message-State: ABy/qLZ+SLi+0PBH0XtN6GD9tFXmZnPJkL0NVWu34seguh8bAQm3zBli
        GvOH3oBs/CWy/gOalJA4cuGnNsyTLpbj
X-Google-Smtp-Source: APBJJlH5a3wI02XfLCdrjutA0c7lgVeZowupHuccGushVFyo4odptnWudcM/MN2XtoF/0rCDIRcqb128IY2O
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a05:6830:1d6b:b0:6b8:c631:5c5a with SMTP
 id l11-20020a0568301d6b00b006b8c6315c5amr5318063oti.4.1689382461471; Fri, 14
 Jul 2023 17:54:21 -0700 (PDT)
Date:   Sat, 15 Jul 2023 00:54:04 +0000
In-Reply-To: <20230715005405.3689586-1-rananta@google.com>
Mime-Version: 1.0
References: <20230715005405.3689586-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
Message-ID: <20230715005405.3689586-11-rananta@google.com>
Subject: [PATCH v6 10/11] KVM: arm64: Invalidate the table entries upon a range
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
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>
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

Currently, during the operations such as a hugepage collapse,
KVM would flush the entire VM's context using 'vmalls12e1is'
TLBI operation. Specifically, if the VM is faulting on many
hugepages (say after dirty-logging), it creates a performance
penalty for the guest whose pages have already been faulted
earlier as they would have to refill their TLBs again.

Instead, leverage kvm_tlb_flush_vmid_range() for table entries.
If the system supports it, only the required range will be
flushed. Else, it'll fallback to the previous mechanism.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 5d14d5d5819a..5ef098af1736 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -806,7 +806,8 @@ static bool stage2_try_break_pte(const struct kvm_pgtable_visit_ctx *ctx,
 		 * evicted pte value (if any).
 		 */
 		if (kvm_pte_table(ctx->old, ctx->level))
-			kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
+			kvm_tlb_flush_vmid_range(mmu, ctx->addr,
+						kvm_granule_size(ctx->level));
 		else if (kvm_pte_valid(ctx->old))
 			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, mmu,
 				     ctx->addr, ctx->level);
-- 
2.41.0.455.g037347b96a-goog

