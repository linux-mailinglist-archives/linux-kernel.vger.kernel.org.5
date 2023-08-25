Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46197787D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbjHYCID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbjHYCHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:07:41 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197619A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:07:39 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c09c1fd0abso5918485ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692929258; x=1693534058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ij7IJ9LeENVlJByi4z/6QrJLTj5aVJhs6LLV7CfHy1E=;
        b=nZY/HsLnBnVzySI5bwR83jGtbGyAfr52IW7zOyBFfiKpVXDzCz66LOicUFzYv7+pjp
         npFN6/fXfHEsdYPRvxhmAcBXuKa8iMXGOKHemw0KdIlsqkkXiLnSXXDcDnZYdVuZBLGS
         VI9bK5XLqVYp/wn87KYxY8dZhSkVnavD8mDxyzgLdYXe9GpF4ZoD3Lzx/8GjB9V/sZ1W
         6+l3YikZuyH3kyvhGw7m6g/eEjc/Lnb8+7T85xgUkVWlGeps+Q24Rl77dCIiUQkElMJF
         RlxuicGUGppQCuBWcsHPVz/467/laIGeNy3RpNIa4jqIQ4JH5NK4hyDm31oi/CweNAvt
         ZAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692929258; x=1693534058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij7IJ9LeENVlJByi4z/6QrJLTj5aVJhs6LLV7CfHy1E=;
        b=fteq6FayOf6Gr2sMw76lVrLTQcbbl2v0nC+ALFPNE3Fu0EOBpodV6Lm6UXuCj3Jp4v
         Vdc6YXW4iGJSub/8PL9sIeqoEYmsRAxc7mreX9upXxI2GxdcUtKe7ylx0/ThBKle2kIV
         ttpuaqEDI8U2SAeRZHhgg54da/+yJUOyTW5A/SjoLMsFVhdLOu+Xp7o3FiZ/gWgg8tGu
         Nk58ITvIkaVp59zhSa25cqGtp5cJs6i3Vw9ksx/9R2E/TT2igJ4xm22D6cUef32C8VLn
         gU7CSHhK9ommGyE2c1KhALcuI5+woAacZUDwUZz1hCpFyVDy2zikt2Ivruf1k81OWSTx
         RTUQ==
X-Gm-Message-State: AOJu0YzmgT69TExUbslmjTyA0dj5c05ovkrl/CzcOncsGiNlOFeLTdf1
        A7lDv0nOYDqflU/ZdynSJOqYjm4MYt0=
X-Google-Smtp-Source: AGHT+IF7loOUbycshuEEvy226/Q/37wCJDPtRBqLjjJlP1CdSVcxR8XOuDqm3RnPk2MjhQ3dFwEeCkRrGno=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f203:b0:1bc:e6a:205e with SMTP id
 m3-20020a170902f20300b001bc0e6a205emr6177096plc.5.1692929258615; Thu, 24 Aug
 2023 19:07:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 24 Aug 2023 19:07:33 -0700
In-Reply-To: <20230825020733.2849862-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230825020733.2849862-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230825020733.2849862-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86/mmu: Retry fault before acquiring mmu_lock if
 mapping is changing
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>
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

Retry page faults without acquiring mmu_lock if the resolved hva is covered
by an active invalidation.  Contending for mmu_lock is especially
problematic on preemptible kernels as the mmu_notifier invalidation task
will yield mmu_lock (see rwlock_needbreak()), delay the in-progress
invalidation, and ultimately increase the latency of resolving the page
fault.  And in the worst case scenario, yielding will be accompanied by a
remote TLB flush, e.g. if the invalidation covers a large range of memory
and vCPUs are accessing addresses that were already zapped.

Alternatively, the yielding issue could be mitigated by teaching KVM's MMU
iterators to perform more work before yielding, but that wouldn't solve
the lock contention and would negatively affect scenarios where a vCPU is
trying to fault in an address that is NOT covered by the in-progress
invalidation.

Reported-by: Yan Zhao <yan.y.zhao@intel.com>
Closes: https://lore.kernel.org/all/ZNnPF4W26ZbAyGto@yzhao56-desk.sh.intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1a5a1e7d1eb7..8e2e07ed1a1b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4334,6 +4334,9 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	if (unlikely(!fault->slot))
 		return kvm_handle_noslot_fault(vcpu, fault, access);
 
+	if (mmu_invalidate_retry_hva(vcpu->kvm, fault->mmu_seq, fault->hva))
+		return RET_PF_RETRY;
+
 	return RET_PF_CONTINUE;
 }
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

