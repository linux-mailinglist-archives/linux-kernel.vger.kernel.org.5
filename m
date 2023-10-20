Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD87D184E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjJTVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjJTVlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:41:15 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49E10CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:41:03 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6ccedabb330so1722827a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697838063; x=1698442863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZTHdI73LjJ+tdCxtrSBfoEJbDPL8Ytb4Ns2eCXo9P0=;
        b=y4zAW0/8BWDmc5grsWpujLKF33jqLDUDBjqO2j8ZOTZ9c/5vdN2eihPbiSEjbqbb1H
         Ui8QCxbwM9KPrucINuKUGmXUDtDd+XhTZA/v/iXhN61NVOujbwq2jLLCPtEcEz0ExEif
         0VXARZ/p81STmhb+F3YlypqKStCVotnefWOGcFrb/UZqVIe4ZAQHqca5q1cf851+LNFn
         j0ge9azxGnkfe89wFvCZYXld2uGCG49KxAT0aS6B1k2k9B+6mSarlrUJ5PuY1shrlySf
         u2ucrS8uxGYAJPtSebpaBzFCI7P9Mq1O9Qp96Pd8KllgBMNncyb0R/DkPVOlwgvT5Nmk
         eaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697838063; x=1698442863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZTHdI73LjJ+tdCxtrSBfoEJbDPL8Ytb4Ns2eCXo9P0=;
        b=MBrgJDCgacNgmWBhZeDRxKOKh3R7Kr6Dq6JeU3vkBKBV8y2u0cAJM83z21hYvXTZIR
         SJCFknIvpw0Zr39yc5HhzWspqdhQpj4dyEQBeRw2bSd+pjVGTavWvtuqDnaBRrRtcgIn
         y2GAaIHEeZWuA7bMuZE+QeqzWkTCRx9DBqkhjXLvGcYnpb2VLF/BY5CFYb2zq/FsqDNU
         EmITyF2mnUT7aSz+YhYSBjnCyqIAhKdg8ZOdXcUcnkd6fhAXTuz4saO1bfrUl3Lj5fNe
         iBUp3OWD4MHcw45C0ypUuV2vwITpHceXZ1Da2/M0qc2d1LRPb7Be82tyQZBCIjIDb0Ec
         6diQ==
X-Gm-Message-State: AOJu0YzZhX+T6Cp2ukcHa9yV6y3CHqpeSUXOgYk7VS3sEYLHqe9njcLb
        8b/LjN+iWp4bZZRxniQp0UHpxfpXZ0rt
X-Google-Smtp-Source: AGHT+IGmQUtWN2yXPx1W8N9ywV18/lF8tjnlx7PJ7Cm9muwl3a03ohwjxnNV0mAYCF4av1euZ/wFeeKf4Clv
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a05:6830:33c2:b0:6b9:182b:cebc with SMTP
 id q2-20020a05683033c200b006b9182bcebcmr795333ott.7.1697838063058; Fri, 20
 Oct 2023 14:41:03 -0700 (PDT)
Date:   Fri, 20 Oct 2023 21:40:46 +0000
In-Reply-To: <20231020214053.2144305-1-rananta@google.com>
Mime-Version: 1.0
References: <20231020214053.2144305-1-rananta@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020214053.2144305-7-rananta@google.com>
Subject: [PATCH v8 06/13] KVM: arm64: Sanitize PM{C,I}NTEN{SET,CLR},
 PMOVS{SET,CLR} before first run
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unimplemented counters, the registers PM{C,I}NTEN{SET,CLR}
and PMOVS{SET,CLR} are expected to have the corresponding bits RAZ.
Hence to ensure correct KVM's PMU emulation, mask out the bits in
these registers for these unimplemented counters before the first
vCPU run.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/arm.c      |  2 +-
 arch/arm64/kvm/pmu-emul.c | 11 +++++++++++
 include/kvm/arm_pmu.h     |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e3074a9e23a8b..3c0bb80483fb1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -857,7 +857,7 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 		}
 
 		if (kvm_check_request(KVM_REQ_RELOAD_PMU, vcpu))
-			kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
+			kvm_vcpu_handle_request_reload_pmu(vcpu);
 
 		if (kvm_check_request(KVM_REQ_RESYNC_PMU_EL0, vcpu))
 			kvm_vcpu_pmu_restore_guest(vcpu);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 9e24581206c24..31e4933293b76 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -788,6 +788,17 @@ u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 	return val & mask;
 }
 
+void kvm_vcpu_handle_request_reload_pmu(struct kvm_vcpu *vcpu)
+{
+	u64 mask = kvm_pmu_valid_counter_mask(vcpu);
+
+	kvm_pmu_handle_pmcr(vcpu, kvm_vcpu_read_pmcr(vcpu));
+
+	__vcpu_sys_reg(vcpu, PMOVSSET_EL0) &= mask;
+	__vcpu_sys_reg(vcpu, PMINTENSET_EL1) &= mask;
+	__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= mask;
+}
+
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_vcpu_has_pmu(vcpu))
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 2e90f38090e6d..567dc288a5ddb 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -63,6 +63,7 @@ void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val);
 void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
 				    u64 select_idx);
+void kvm_vcpu_handle_request_reload_pmu(struct kvm_vcpu *vcpu);
 int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
 			    struct kvm_device_attr *attr);
 int kvm_arm_pmu_v3_get_attr(struct kvm_vcpu *vcpu,
@@ -142,6 +143,7 @@ static inline void kvm_pmu_software_increment(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val) {}
 static inline void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu,
 						  u64 data, u64 select_idx) {}
+static inline void vm_vcpu_handle_request_reload_pmu(struct kvm_vcpu *vcpu) {}
 static inline int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu,
 					  struct kvm_device_attr *attr)
 {
-- 
2.42.0.655.g421f12c284-goog

