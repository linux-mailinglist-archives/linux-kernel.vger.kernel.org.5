Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22EE7BEEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379036AbjJIXKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379098AbjJIXKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:10:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D34DD7C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:09:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so6623740276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696892947; x=1697497747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVCCYYHAr8CSZ5MG69SHY7zRH5V9FX2+QRsBdoTJR7I=;
        b=pGGEoyVSbHTYDM8EyC8DsP/zCCo/mHiUpartxl9Cy99L3obtUaSTvgZ7VkrUBn/sOz
         H7IVng/CFw6/iwMGxSHRCuMHmyxQs7MYn1oj3TOxvWyq2DS8yiTUhCbNAbx5m1ufekrT
         suuH2tCvkrHWHaJi7jERrs+Hf6WjEMqAE4ceKpvYbkTgfq/3VokTvP/X3sVDkvuhWa/J
         w2bWLI4xvvXwS1WliSDq6bjwrJVHhminN176Zr6k7HDydzdu+VrbuX7cqw8lJrnq6O+a
         xDoKu4W3tMh3Qo2GiNoXQ9GBf8Va0OUspSn5oxQyYQcgI35lOE/vmOxgwrrcnEd+o9NB
         L3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892947; x=1697497747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVCCYYHAr8CSZ5MG69SHY7zRH5V9FX2+QRsBdoTJR7I=;
        b=eNgF/ElPvq/ujKBpkW1S7c1oLN60u12t9HPJ6fcB4FmhlbZMaXxw9OioXUlYm7UP+G
         55FQ+EmJhNCODQyWy5xakatGZc4tkrtJQWe+1bKHZz7jzsuCkO5GxO9qr201VMdKt8Dr
         NXwfV5z+E/RfDldLQdj/2IjaSEVzV7hM6+u3WZaJbfQx22TLX/LBDTbZHA1+Piba4Ire
         IBJyietDq8kGXIH0FQQWQu8YxYpq4H3uPXJYN3ejeYaBFbG/YaI0YftPOclEp/8PfvOA
         l/SkoXF+6+Dysu/z2Ytsw5C99k9/hmfnglJmS6ejQSfZfhT6vo3uuddgnqyB1fFDYfTf
         ttig==
X-Gm-Message-State: AOJu0YxK4FAlpGY+Gn3egcRfqxZezeGN5P9k6nhdZy9zNM04s6pt+Qse
        9HmobzlP48hTk3WswdX3HcffFGOzCFsv
X-Google-Smtp-Source: AGHT+IHIs4oBYizNBaeSJxR7psR+gQ2uPd5kPXIt+bfHzIRybaO/dEl/UqH/5vlJK0t0Tca8kOKZZSSy04NM
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a25:d313:0:b0:d7b:92d7:5629 with SMTP id
 e19-20020a25d313000000b00d7b92d75629mr287651ybf.8.1696892947170; Mon, 09 Oct
 2023 16:09:07 -0700 (PDT)
Date:   Mon,  9 Oct 2023 23:08:49 +0000
In-Reply-To: <20231009230858.3444834-1-rananta@google.com>
Mime-Version: 1.0
References: <20231009230858.3444834-1-rananta@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009230858.3444834-4-rananta@google.com>
Subject: [PATCH v7 03/12] KVM: arm64: PMU: Clear PM{C,I}NTEN{SET,CLR} and
 PMOVS{SET,CLR} on vCPU reset
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reiji Watanabe <reijiw@google.com>

On vCPU reset, PMCNTEN{SET,CLR}_EL0, PMINTEN{SET,CLR}_EL1, and
PMOVS{SET,CLR}_EL1 for a vCPU are reset by reset_pmu_reg().
This function clears RAZ bits of those registers corresponding
to unimplemented event counters on the vCPU, and sets bits
corresponding to implemented event counters to a predefined
pseudo UNKNOWN value (some bits are set to 1).

The function identifies (un)implemented event counters on the
vCPU based on the PMCR_EL0.N value on the host. Using the host
value for this would be problematic when KVM supports letting
userspace set PMCR_EL0.N to a value different from the host value
(some of the RAZ bits of those registers could end up being set to 1).

Fix this by clearing the registers so that it can ensure
that all the RAZ bits are cleared even when the PMCR_EL0.N value
for the vCPU is different from the host value. Use reset_val() to
do this instead of fixing reset_pmu_reg(), and remove
reset_pmu_reg(), as it is no longer used.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/sys_regs.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 818a52e257ed..3dbb7d276b0e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -717,25 +717,6 @@ static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
-static u64 reset_pmu_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
-{
-	u64 n, mask = BIT(ARMV8_PMU_CYCLE_IDX);
-
-	/* No PMU available, any PMU reg may UNDEF... */
-	if (!kvm_arm_support_pmu_v3())
-		return 0;
-
-	n = read_sysreg(pmcr_el0) >> ARMV8_PMU_PMCR_N_SHIFT;
-	n &= ARMV8_PMU_PMCR_N_MASK;
-	if (n)
-		mask |= GENMASK(n - 1, 0);
-
-	reset_unknown(vcpu, r);
-	__vcpu_sys_reg(vcpu, r->reg) &= mask;
-
-	return __vcpu_sys_reg(vcpu, r->reg);
-}
-
 static u64 reset_pmevcntr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	reset_unknown(vcpu, r);
@@ -1115,7 +1096,7 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	  trap_wcr, reset_wcr, 0, 0,  get_wcr, set_wcr }
 
 #define PMU_SYS_REG(name)						\
-	SYS_DESC(SYS_##name), .reset = reset_pmu_reg,			\
+	SYS_DESC(SYS_##name), .reset = reset_val,			\
 	.visibility = pmu_visibility
 
 /* Macro to expand the PMEVCNTRn_EL0 register */
-- 
2.42.0.609.gbb76f46606-goog

