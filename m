Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4277D541
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjHOVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbjHOVf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:35:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D531BDD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:35:50 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso7913497a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135349; x=1692740149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jXXlrX5DzE4Hghu7ToUaWJNzp/mTz7CuA6+i3yYWT20=;
        b=USjc9iB3NqYv1bv2FZwD7xwEEynvodyTs0vCg/keKBBbTvxsxOjxknFq9MHnwQ665M
         eSQqAqV66fZIdfZFXD2bmMhEmAisBI78aYi9OP+x1eaVpHRzEJZrDwbwB4ep4ObGkWnF
         gN+mveNmI46n7FTJcfDySmGbvsGmYjA9jk1oU9PkQb902bONPll6NLl01s9WMmWhH4XZ
         n5Hpf9Us0QgLfPrMV5ANSkTDiADkT8EegqmGBbf2dkvcO8dcbxet6I+QQY23PCRO26S3
         7Z41veYXH0HWxpS7gQikz5YJdMdIQvfaQ7jZS2eEQl17qUqFGVhs/KTMiU03AMAGPJz4
         C+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135349; x=1692740149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXXlrX5DzE4Hghu7ToUaWJNzp/mTz7CuA6+i3yYWT20=;
        b=WQ7sJd0yWD+SHTucTeA7dyES77V74eFf84qryNyfIevki/nujtZKguPbg6exINa1qe
         sUQgwqnler7HoG8c9f0p77FcmpHU3+wuqJI5W1unZLgM6Qgk8saYSW6R4mRsOjyrzBRW
         kWe6IXUI1HvFCplzq55omsI1tOhue5mY6IQNc1Vsmrj9MQu6eobkIKS7gI4xQY7/lXRK
         l/OqF/jvOdUsTi3yQRYItbrAKbE+hmo3uIaP+sAWORqhUrXLn8hVtzezciExJq++eT/S
         qrKQnC+KnUnSYDrWlZKIcxRNXfEsOF1zC2gBp4lD+IEFphJNOUXCtmGmvSDyPGIbn4wU
         m+Rw==
X-Gm-Message-State: AOJu0YwW+af3Odyj2crHPCeoaXH36O9iJlqc2Vxv1m1Xk/ZfTtdGBvhG
        WPvgu9wt2jwNgNrJdz3xPm358htLF+g=
X-Google-Smtp-Source: AGHT+IFk0HNZ30dHY5GX2GHPf9vSUKa+3cF4WUclVLhZGcIW2/yXqodNdtcU6wu1QFuNC3eybCy1wlJf+aA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:db52:b0:269:84ec:7140 with SMTP id
 u18-20020a17090adb5200b0026984ec7140mr838342pjx.2.1692135349548; Tue, 15 Aug
 2023 14:35:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Aug 2023 14:35:29 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-7-seanjc@google.com>
Subject: [PATCH 06/10] iommu/amd: KVM: SVM: Use pi_desc_addr to derive ga_root_ptr
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     kvm@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vcpu_data.pi_desc_addr instead of amd_iommu_pi_data.base to get the
GA root pointer.  KVM is the only source of amd_iommu_pi_data.base, and
KVM's one and only path for writing amd_iommu_pi_data.base computes the
exact same value for vcpu_data.pi_desc_addr and amd_iommu_pi_data.base,
and fills amd_iommu_pi_data.base if and only if vcpu_data.pi_desc_addr is
valid, i.e. amd_iommu_pi_data.base is fully redundant.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 1 -
 drivers/iommu/amd/iommu.c | 2 +-
 include/linux/amd-iommu.h | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e49b682c8469..bd81e3517838 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -919,7 +919,6 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 			struct amd_iommu_pi_data pi;
 
 			/* Try to enable guest_mode in IRTE */
-			pi.base = avic_get_backing_page_address(svm);
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c3b58a8389b9..9814df73b9a7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3622,7 +3622,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 
 	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
-		ir_data->ga_root_ptr = (pi_data->base >> 12);
+		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
 		ir_data->ga_vector = vcpu_pi_info->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		ret = amd_iommu_activate_guest_mode(ir_data);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 953e6f12fa1c..30d19ad0e8a9 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -20,7 +20,6 @@ struct amd_iommu;
 struct amd_iommu_pi_data {
 	u32 ga_tag;
 	u32 prev_ga_tag;
-	u64 base;
 	bool is_guest_mode;
 	struct vcpu_data *vcpu_data;
 	void *ir_data;
-- 
2.41.0.694.ge786442a9b-goog

