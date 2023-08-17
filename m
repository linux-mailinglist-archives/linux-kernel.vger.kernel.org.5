Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C786277EE44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbjHQAbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347334AbjHQAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:30:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D39272E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:30:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586a5ac5c29so89749117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692232235; x=1692837035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xjUNDJiBCoJcgjT/+49Msar3+0uyb3GjRudfsNPpjA=;
        b=nnwae7ChRhKPujDVQLlOFC/RbuGXKrYufvf1XOGFJo5aF+NN2asXevdOm4rbRZg8Tq
         aERDuo7GrEeVKvsx4Y4ftQzz7Fe54TcomW89SWLsiO2sFU0mLEMQMqCt3tWaiUuAZpF9
         aB+0qT5dhPAgfNfruG8Fkkt1LGwyH1vWQpzPpfbxi1n6HBjodVHOOTQ16KQgjvYU1+3h
         5o4p52ynaOPp3OxqDByhxbsEDOIbdsTuEmsCpOQo7M54IVuyHnmBv6YncwY0QMSo4Qjc
         98YJ22vCwSwb5CqrV3TU8soGecZyVDxibeatCdFjdbc7wJ1L26MX9SOsRVTVtLMiuYhe
         hBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692232235; x=1692837035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xjUNDJiBCoJcgjT/+49Msar3+0uyb3GjRudfsNPpjA=;
        b=GyfpzcjrUQIUypWcx7l8hCbFxOB2D+Hv39D7yweVknHD+CZDSc9gnMaQITG93GZm7V
         LP+pSxighKLrBPHE/izAnG21C8DMbZ0S1+HDqeUjPPtPfc0WkicisLEnR5GpGnqB4WHy
         HLfyZjxyjpqaKQiugHRzA4iK1lS0oZTr/8DvhKf6WjNNfCAcp5DvVCL2QWqFzMnFr9EQ
         8FN5e34lwkLMUIwLANTsss5obcRTbRpCDtPM1Gei7E6qNU3l5XsLbEACq8pQDJUWB3LU
         V3Gp1aOeccSFE/Lg1vpJxp4/90AckvfoPRwE+QrQ9GbsOoXCexAK7cYxIONph0io2mTX
         L16g==
X-Gm-Message-State: AOJu0YxCR4DtZZJD09g7fCid4dNpOPlQPd9w6uK+wNQAlnvfovPzH0mX
        WkT2W/WR6EgQm/sur4D6Zxeh86gPuQxJ
X-Google-Smtp-Source: AGHT+IFXQ7fYcd7YawZs3vGh87IG1agI3VzWVFMFYY7UPKBon+KAo2ZGhUuGKeey7RaOXJKKXMGpcZI4dNMW
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a81:430c:0:b0:58c:b5a4:8e1f with SMTP id
 q12-20020a81430c000000b0058cb5a48e1fmr49495ywa.3.1692232235400; Wed, 16 Aug
 2023 17:30:35 -0700 (PDT)
Date:   Thu, 17 Aug 2023 00:30:20 +0000
In-Reply-To: <20230817003029.3073210-1-rananta@google.com>
Mime-Version: 1.0
References: <20230817003029.3073210-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230817003029.3073210-4-rananta@google.com>
Subject: [PATCH v5 03/12] KVM: arm64: PMU: Clear PM{C,I}NTEN{SET,CLR} and
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
index 2ca2973abe66f..9d3d44d165eed 100644
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
2.41.0.694.ge786442a9b-goog

