Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9D802C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjLDHpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:45:44 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CCB9;
        Sun,  3 Dec 2023 23:45:50 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so336411b3a.0;
        Sun, 03 Dec 2023 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701675950; x=1702280750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4CnEqDyKTvmNdAc7DRa4LlVgyEs45rDoDvLnaRpgY=;
        b=UUK+Zvlnt+fW5IFc4du7pbJCcZ45y7jEDu05nVHwPlSaQLb53yW8kQIREfeX258IQ2
         wIvd2aAaT8g4AxIDEjSm4RzoEgEtJCsYs6mFiO6QElu/q7JQN8cup8mCdlhVC5ThS3Iv
         6D8FoL6TTn1EQFNIMMQOyZW9XBHtqmXedIo6YdbXR4fLh9rhv9yCW+4aXtw0f81unK+O
         ObbgDxqSLvNLhsiog6lmqsoCKsgsPpKZYbR9uX5XcuRgH+OWvJxB76gC8p6+ZZAF7rnd
         Je9bKMVnbqzafjoeOIyELLCJ01YG/eAjDNfvEx0pl00lk73jj0O9z1igsLf1UA/nJsr9
         /p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701675950; x=1702280750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft4CnEqDyKTvmNdAc7DRa4LlVgyEs45rDoDvLnaRpgY=;
        b=gDACjHms+swyfc6341rgvd0Me15bYqW//aUOoFeObQJYAywLAtMVoSkpC3sLnqOIOY
         /xs37aPvZ0sVHr/nv2TE4oE0NIoxP/eh59flrTN0LwU9WKKYXyZw1hRRnpPILXyG6t95
         Vkm08e9P/gYe00LZBcyTFWTUOCVyyyRCcz4W/9kIu1helFMJAQAX9l2hsBuQZtqU450K
         YJCn4lGT1lSgkb4hytJReRqBru/Kih1/7MKbDtaUK5yEKvwrhkrvpun+bIAA67HteG1H
         ScAwq6ZwDCeRenzg0gHXmcKwsQKjna1S5qS0v2POFaGuHS+UjSALFimbiMo5Ns9Y8fLJ
         hhtg==
X-Gm-Message-State: AOJu0YxLepkzQ8XWvQb3vgncehR6pKdpIAr0GPL/rzM4DRTqEfPmuarZ
        sow8NcuUef3J5Cf8bX7rKTA=
X-Google-Smtp-Source: AGHT+IHIlzTzEUSq43fRNjkv59CBGGxLxGkguQEo5unDzVKvrgbjxT3r0jpAQOuSERgBlzxiOXcRJQ==
X-Received: by 2002:a05:6a00:301a:b0:6ce:2732:1ded with SMTP id ay26-20020a056a00301a00b006ce27321dedmr1888075pfb.39.1701675949807;
        Sun, 03 Dec 2023 23:45:49 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.41])
        by smtp.gmail.com with ESMTPSA id g6-20020aa79f06000000b006ce358d5d9asm3391659pfr.141.2023.12.03.23.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 23:45:49 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/intr: Explicitly check NMI from guest to eliminate false positives
Date:   Mon,  4 Dec 2023 15:45:35 +0800
Message-ID: <20231204074535.9567-1-likexu@tencent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

Explicitly checking the source of external interrupt is indeed NMI and not
other types in the kvm_arch_pmi_in_guest(), which prevents perf-kvm false
positive samples generated after vm-exit but before kvm_before_interrupt()
from being incorrectly labelled as guest samples:

# test: perf-record + cpu-cycles:HP (which collects host-only precise samples)
# Symbol                                   Overhead       sys       usr  guest sys  guest usr
# .......................................  ........  ........  ........  .........  .........
#
# Before:
  [g] entry_SYSCALL_64                       24.63%     0.00%     0.00%     24.63%      0.00%
  [g] syscall_return_via_sysret              23.23%     0.00%     0.00%     23.23%      0.00%
  [g] files_lookup_fd_raw                     6.35%     0.00%     0.00%      6.35%      0.00%
# After:
  [k] perf_adjust_freq_unthr_context         57.23%    57.23%     0.00%      0.00%      0.00%
  [k] __vmx_vcpu_run                          4.09%     4.09%     0.00%      0.00%      0.00%
  [k] vmx_update_host_rsp                     3.17%     3.17%     0.00%      0.00%      0.00%

In the above case, perf records the samples labelled '[g]', the RIPs behind
the weird samples are actually being queried by perf_instruction_pointer()
after determining whether it's in GUEST state or not, and here's the issue:

If vm-exit is caused by a non-NMI interrupt (such as hrtimer_interrupt) and
at least one PMU counter is enabled on host, the kvm_arch_pmi_in_guest()
will remain true (KVM_HANDLING_IRQ is set) until kvm_before_interrupt().

During this window, if a PMI occurs on host (since the KVM instructions on
host are being executed), the control flow, with the help of the host NMI
context, will be transferred to perf/core to generate performance samples,
thus perf_instruction_pointer() and perf_guest_get_ip() is called.

Since kvm_arch_pmi_in_guest() only checks if there is an interrupt, it may
cause perf/core to mistakenly assume that the source RIP of the host NMI
belongs to the guest world and use perf_guest_get_ip() to get the RIP of
a vCPU that has already exited by a non-NMI interrupt.

Error samples are recorded and presented to the end-user via perf-report.
Such false positive samples could be eliminated by explicitly determining
if the exit reason is KVM_HANDLING_NMI.

Note that when vm-exit is indeed triggered by PMI and before HANDLING_NMI
is cleared, it's also still possible that another PMI is generated on host.
In this case, perf/core should generate two samples, belonging to host and
guest separately, but that's perf/core's story.

Fixes: 73cd107b9685 ("KVM: x86: Drop current_vcpu for kvm_running_vcpu + kvm_arch_vcpu variable")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/include/asm/kvm_host.h | 9 ++++++++-
 arch/x86/kvm/x86.h              | 6 ------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c8c7e2475a18..93e667f3099d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1868,8 +1868,15 @@ static inline int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn,
 }
 #endif /* CONFIG_HYPERV */
 
+enum kvm_intr_type {
+	/* Values are arbitrary, but must be non-zero. */
+	KVM_HANDLING_IRQ = 1,
+	KVM_HANDLING_NMI,
+};
+
+/* Linux always use NMI for PMU. */
 #define kvm_arch_pmi_in_guest(vcpu) \
-	((vcpu) && (vcpu)->arch.handling_intr_from_guest)
+	((vcpu) && ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI))
 
 void __init kvm_mmu_x86_module_init(void);
 int kvm_mmu_vendor_module_init(void);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2f7e19166658..4dc38092d599 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -431,12 +431,6 @@ static inline bool kvm_notify_vmexit_enabled(struct kvm *kvm)
 	return kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_ENABLED;
 }
 
-enum kvm_intr_type {
-	/* Values are arbitrary, but must be non-zero. */
-	KVM_HANDLING_IRQ = 1,
-	KVM_HANDLING_NMI,
-};
-
 static __always_inline void kvm_before_interrupt(struct kvm_vcpu *vcpu,
 						 enum kvm_intr_type intr)
 {

base-commit: 1ab097653e4dd8d23272d028a61352c23486fd4a
-- 
2.43.0

