Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208F7545D3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 02:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGOAym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 20:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjGOAyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 20:54:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6303AA1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cac213f9264so2084243276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689382460; x=1689987260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQY+Dtk1XWrNNGuHSHxbkYrauldxXbZA83USiWOTL6o=;
        b=TCgWEy2z8oOGQwvnSBHn0AkAkVSlT9c37MgvWUaNlBXCNKNpJR/vOwVyuvEfVCFhZH
         75Djs6cT8vsl01b8fPqnk9tIFBiF7zvqtCVYGWLZuWsMETu/RPDzgHfQJ0N6NM5C6vOx
         hB+mAtMX3eXFTzff5OpvcbDHdQLWnoerWsIudu0SL4c3QoXFOjZqkSdjyoCJtPVXGr6W
         //LvcxbEku4U7vC3//3dhn54WTCVJcS92mQ6c7NC+uGD3MBXy3sOfSBG1WMjwOX4vcYi
         XoUh9543oJXJngnlcI/Jw0nJMM49HqIHNGb/O4YAGu77Z/SnUdDFBBfexEdSrvLeIvbz
         Ltlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382460; x=1689987260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQY+Dtk1XWrNNGuHSHxbkYrauldxXbZA83USiWOTL6o=;
        b=Yhp4nTrUOX11coTKAbUu8dNUrVEWpFkInSV+dOsZdm3jIaZxtPV9Ya/FXENyFj0jHv
         e4vk06OWIGiLwujfTHBzZy4Y58/TIs9PKXh+3R6oiOIuJo+TssrVdrSJOdXYPTbd0Z7j
         zCx1i7nFKcbOXEuueHXfSWQ2iRVKhfrxHUakCJzEzvEmEiN51+z3HRwG+nxwvNV8tevB
         wYldX2w4Ct4+y+FFPeSww5SAIa//L5stdVmBthw+MxYXYTywC3MAHrWXApoyT5R8Cw0P
         Hec6W4gigl7aEuI/kJVwHmI16FA2al4eHJcUuolv/Yw+/iJQmAU5j8qxOWJoOAmKLmep
         Su8w==
X-Gm-Message-State: ABy/qLYRI54Ur/fDAx7wB2jRfpBTNAfOHA5Vh8LEqKZ/3tIKB5yZHCWS
        7ZFqT5/dIqN7dDRJNtpuTx57Xev5diCO
X-Google-Smtp-Source: APBJJlG5n3Bft6SS+LPAWDb1hmMGpZKEdbwJGhCcCMWgOINPk2C5Y/61Tx4AtYFAIRblEEw/+bRH7gfv6I55
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a25:ab81:0:b0:c5f:85f5:a0e5 with SMTP id
 v1-20020a25ab81000000b00c5f85f5a0e5mr14207ybi.5.1689382460190; Fri, 14 Jul
 2023 17:54:20 -0700 (PDT)
Date:   Sat, 15 Jul 2023 00:54:03 +0000
In-Reply-To: <20230715005405.3689586-1-rananta@google.com>
Mime-Version: 1.0
References: <20230715005405.3689586-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
Message-ID: <20230715005405.3689586-10-rananta@google.com>
Subject: [PATCH v6 09/11] KVM: arm64: Flush only the memslot after write-protect
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After write-protecting the region, currently KVM invalidates
the entire TLB entries using kvm_flush_remote_tlbs(). Instead,
scope the invalidation only to the targeted memslot. If
supported, the architecture would use the range-based TLBI
instructions to flush the memslot or else fallback to flushing
all of the TLBs.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 387f2215fde7..985f605e2abc 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1082,7 +1082,7 @@ static void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot)
 	write_lock(&kvm->mmu_lock);
 	stage2_wp_range(&kvm->arch.mmu, start, end);
 	write_unlock(&kvm->mmu_lock);
-	kvm_flush_remote_tlbs(kvm);
+	kvm_flush_remote_tlbs_memslot(kvm, memslot);
 }
 
 /**
-- 
2.41.0.455.g037347b96a-goog

