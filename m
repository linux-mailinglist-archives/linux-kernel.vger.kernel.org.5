Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15227D1847
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbjJTVlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbjJTVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:41:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA7D7F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:40:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso18750737b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697838058; x=1698442858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRZJl825jTe4bNk4e/h0EcnYD7OOEsJ4orW3IfNwdD4=;
        b=GFt2h0oUOpCAeqIf56JfA/hb+414FjMqTiNto4ntFBD3x92sd7Hy+jLuZxkkVfYVqQ
         j+uNxXMQzNKJ3M3lF9UJpYWdKR6lBYVV+pfbtrz7lpVBAyxLbjRCXxX3WpmZm6QLjamG
         H7PSWIDroNc1YANPohvGSmH1HzRaZ3EmbAZTmSea85C8TV+04vOCKSKfvegRLF+QjU/m
         J12ls22GdHTlSIc8d9xEqCH/nt23rfHzXTukM80cS8vmwxGKQy+q3+Ulkr5AauWQRg0D
         MWXGJGNEp+dCs6x2yltwk3FGbNTaYuvDh3hviqdJSg7VZpTmtncf89F070VRZtB75aTU
         imYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697838058; x=1698442858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRZJl825jTe4bNk4e/h0EcnYD7OOEsJ4orW3IfNwdD4=;
        b=Dz96XAIyeJ2/wlYCvhvKhjv84PR9ofOVhTPgjXN0M4dT2OUveD5QKofMOmlkIE4vbd
         GSBtXXxdZe60lnWoZ7TQAoNq8fXhU7s7sba0ivLzcPfg50EBiL92GjZKy3VtuCULT8HD
         abKgLoZySMkWPKA/6uxRz0/8xI+YRSHrtBVlS8k4rJO061bbg8tIWsFS+6uXoWx4VTJE
         Ox+IFnYWUQ5WesEYiFN0bSTGPs5yrmXNFC4TQY7yLoZi+d+2MBNUXIgh9rZsCX6b5S28
         w5JrRu7xCMHiUsk38wpY7EHQsoi/SChRRBmFSVCxQB2TyQXJpXeXuJgdVEwAAS4wpqbq
         cRJg==
X-Gm-Message-State: AOJu0Yy2HA3JbmKuaboZ1xnDQpn7wwIIoyF63eDQe9bTFEXrGdJovQe8
        lohp9jsuM5K/HuiuLS3McWNHBz6XiiiQ
X-Google-Smtp-Source: AGHT+IHe1u7IUea+IlhDVSmNzeHVDsOIIsOYR3rNgYKN/Y9aeMFrZpa/CBGN7KTEhg1GR5frubeMf8zmtcdy
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a0d:dd10:0:b0:577:619e:d3c9 with SMTP id
 g16-20020a0ddd10000000b00577619ed3c9mr76387ywe.10.1697838058021; Fri, 20 Oct
 2023 14:40:58 -0700 (PDT)
Date:   Fri, 20 Oct 2023 21:40:41 +0000
In-Reply-To: <20231020214053.2144305-1-rananta@google.com>
Mime-Version: 1.0
References: <20231020214053.2144305-1-rananta@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020214053.2144305-2-rananta@google.com>
Subject: [PATCH v8 01/13] KVM: arm64: PMU: Introduce helpers to set the
 guest's PMU
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
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>
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

Introduce new helper functions to set the guest's PMU
(kvm->arch.arm_pmu) either to a default probed instance or to a
caller requested one, and use it when the guest's PMU needs to
be set. These helpers will make it easier for the following
patches to modify the relevant code.

No functional change intended.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 arch/arm64/kvm/pmu-emul.c | 50 +++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 3afb281ed8d2c..eb5dcb12dafe9 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -874,6 +874,36 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 	return true;
 }
 
+static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
+{
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	kvm->arch.arm_pmu = arm_pmu;
+}
+
+/**
+ * kvm_arm_set_default_pmu - No PMU set, get the default one.
+ * @kvm: The kvm pointer
+ *
+ * The observant among you will notice that the supported_cpus
+ * mask does not get updated for the default PMU even though it
+ * is quite possible the selected instance supports only a
+ * subset of cores in the system. This is intentional, and
+ * upholds the preexisting behavior on heterogeneous systems
+ * where vCPUs can be scheduled on any core but the guest
+ * counters could stop working.
+ */
+static int kvm_arm_set_default_pmu(struct kvm *kvm)
+{
+	struct arm_pmu *arm_pmu = kvm_pmu_probe_armpmu();
+
+	if (!arm_pmu)
+		return -ENODEV;
+
+	kvm_arm_set_pmu(kvm, arm_pmu);
+	return 0;
+}
+
 static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -893,7 +923,7 @@ static int kvm_arm_pmu_v3_set_pmu(struct kvm_vcpu *vcpu, int pmu_id)
 				break;
 			}
 
-			kvm->arch.arm_pmu = arm_pmu;
+			kvm_arm_set_pmu(kvm, arm_pmu);
 			cpumask_copy(kvm->arch.supported_cpus, &arm_pmu->supported_cpus);
 			ret = 0;
 			break;
@@ -917,20 +947,10 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 		return -EBUSY;
 
 	if (!kvm->arch.arm_pmu) {
-		/*
-		 * No PMU set, get the default one.
-		 *
-		 * The observant among you will notice that the supported_cpus
-		 * mask does not get updated for the default PMU even though it
-		 * is quite possible the selected instance supports only a
-		 * subset of cores in the system. This is intentional, and
-		 * upholds the preexisting behavior on heterogeneous systems
-		 * where vCPUs can be scheduled on any core but the guest
-		 * counters could stop working.
-		 */
-		kvm->arch.arm_pmu = kvm_pmu_probe_armpmu();
-		if (!kvm->arch.arm_pmu)
-			return -ENODEV;
+		int ret = kvm_arm_set_default_pmu(kvm);
+
+		if (ret)
+			return ret;
 	}
 
 	switch (attr->attr) {
-- 
2.42.0.655.g421f12c284-goog

