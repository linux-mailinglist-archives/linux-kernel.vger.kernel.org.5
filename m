Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655B7BEEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379096AbjJIXMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379081AbjJIXMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:12:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C096191
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:09:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso7010711276.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696892950; x=1697497750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiBpW9pAzYjkcsGf2tpIHcI9bB/NEZB+QU7M3fwotPk=;
        b=flrdaV3kdL4Z2dcGAehIbabH2GPEBpqUbJdOhhRFPax7pxqCcEv9neUhXQjthofQ1F
         3Cc1fr9qlsnPl1wL2BoOQ9hmOJcFpI92MQLWpGallnYxpdV681bO4L4BtWlL/Y6Z93Ca
         nUllN8PwrBuu+EjoN2IxSMRNDC0Uhqqvu7zLub4tjBDnu03hFMD4CAnKNmHe9bec2PpY
         uuBNWzk6t668wpAAF9zAxTGBoPuZsuoCQNvZv0n29GwhpwqCS5xgldcJQrXJEHfzfwyJ
         +MIh1OzkKNeRTEzLSt/rrqYg5wmfqvWFqx3PDfOHR+9w967YXK5qH5n+l1/Nt43ZAWaP
         m0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892950; x=1697497750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiBpW9pAzYjkcsGf2tpIHcI9bB/NEZB+QU7M3fwotPk=;
        b=p1iTIEx++FXxixxsrY7YoOVDKSUZ1u8W7f9co38lgK3MbkOuFE20ziWq6z8HskRyrI
         RGYtZcZ9OhFb7JXsARSRnizg8FU7tgpGDolInaR24d08z6sCkL/QfV2hoZAq+Am4B5Xz
         q9CxuiG+bYXD6szwlcVdNg9QhYszmMdrgY4RkRZ3qXrdLKYc7sVtqU8jwDWhA+VqgaVE
         un5Z2d4HxtPmt9s5Drp6ZrbmIg2ZtaAXxyd1+hgBgKYwbGKJ06tJk7QoX3pHAPU0hUNM
         XAvp+uTbt+GxBhdWA2g4HEo67gJ4ClaXX3rrwXl4FsFuPrsnIi0jp92ChfJnl5V0YyMf
         VJlg==
X-Gm-Message-State: AOJu0YyXa1sw1DnQ1UPqIklrXZBy1qZgGV+693ja8GNlksC7mTwKVME+
        meKulDTbM6YTi8qIpyWDy9TyLCYO5Y3G
X-Google-Smtp-Source: AGHT+IGhUbm0HO7NhAypaQMYBLq6ihENbJzVhn6yFKRW07/auTo8tnu6zuo6xvHt4/x6EbTnXbNJa84X0oC+
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:20a1])
 (user=rananta job=sendgmr) by 2002:a25:ce89:0:b0:d91:c4e8:bfdd with SMTP id
 x131-20020a25ce89000000b00d91c4e8bfddmr219902ybe.1.1696892950277; Mon, 09 Oct
 2023 16:09:10 -0700 (PDT)
Date:   Mon,  9 Oct 2023 23:08:52 +0000
In-Reply-To: <20231009230858.3444834-1-rananta@google.com>
Mime-Version: 1.0
References: <20231009230858.3444834-1-rananta@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009230858.3444834-7-rananta@google.com>
Subject: [PATCH v7 06/12] KVM: arm64: PMU: Add a helper to read the number of counters
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

Add a helper, kvm_arm_get_num_counters(), to read the number
of counters from the arm_pmu associated to the VM. Make the
function global as upcoming patches will be interested to
know the value while setting the PMCR.N of the guest from
userspace.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/pmu-emul.c | 17 +++++++++++++++++
 include/kvm/arm_pmu.h     |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index a161d6266a5c..84aa8efd9163 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -873,6 +873,23 @@ static bool pmu_irq_is_valid(struct kvm *kvm, int irq)
 	return true;
 }
 
+/**
+ * kvm_arm_get_num_counters - Get the number of general-purpose PMU counters.
+ * @kvm: The kvm pointer
+ */
+int kvm_arm_get_num_counters(struct kvm *kvm)
+{
+	struct arm_pmu *arm_pmu = kvm->arch.arm_pmu;
+
+	lockdep_assert_held(&kvm->arch.config_lock);
+
+	/*
+	 * The arm_pmu->num_events considers the cycle counter as well.
+	 * Ignore that and return only the general-purpose counters.
+	 */
+	return arm_pmu->num_events - 1;
+}
+
 static void kvm_arm_set_pmu(struct kvm *kvm, struct arm_pmu *arm_pmu)
 {
 	lockdep_assert_held(&kvm->arch.config_lock);
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index cd980d78b86b..672f3e9d7eea 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -102,6 +102,7 @@ void kvm_vcpu_pmu_resync_el0(void);
 
 u8 kvm_arm_pmu_get_pmuver_limit(void);
 int kvm_arm_set_default_pmu(struct kvm *kvm);
+int kvm_arm_get_num_counters(struct kvm *kvm);
 
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu);
 #else
@@ -181,6 +182,11 @@ static inline int kvm_arm_set_default_pmu(struct kvm *kvm)
 	return -ENODEV;
 }
 
+static inline int kvm_arm_get_num_counters(struct kvm *kvm)
+{
+	return -ENODEV;
+}
+
 static inline u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	return 0;
-- 
2.42.0.609.gbb76f46606-goog

