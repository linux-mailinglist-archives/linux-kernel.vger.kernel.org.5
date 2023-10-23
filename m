Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC17D2CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJWI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjJWI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:29:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F23CD68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdf4752c3cso15992645ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698049789; x=1698654589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WLOSQOA5Tm0Adw6Ut8ujQkn4XXYrNjbdXHKCGaB3LM=;
        b=iLxR9CpPHj5MF5lOEEwlXsnK9mVa74W1k3vTSLD7gZlk6/+nytiotJkBdq1fclkXTO
         ndO4S8Ys9lefTYja8AhjD2oUy4fizVh2ATwxMEtEi64rwKKA/1wwnmLgX6ub2uwgVjXJ
         V6x8BKU2UU77QDAl3SRrTP+yPewkIixiXSFjq+Sgl0twKDPXVdXrkKjQekfLcPIcBQSJ
         QUL4Dfp7E6cqOPO6XMk/CuIhsB5Llo7CcyM5+LNA+L84tbW1a7erxFzPvljqAjqsTFMY
         kWHcJWdgJ2RZDK/ONbKSSY0OZIJAmSm3EYOgESFNezsJ4r4GeDZkY32KRLaZJ5h+QNud
         QAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049789; x=1698654589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WLOSQOA5Tm0Adw6Ut8ujQkn4XXYrNjbdXHKCGaB3LM=;
        b=G2Tqt395QWhPS+PDBtx8bPqZk+1D+sanX7fWf8/egX1MVSEpk4/enLmMaQYP24xIgP
         akZn40PAgVP0/745/FyljFVep3A2bCPDnI8qskAsOfpvIOmbOPTmGe4rW1qnWbuy9yCu
         SEXmQRhlChb3l4XvV4q+hemEZ2ofC95G5ILkjiAQpqRymCnCMIOv9XNHG41mVJUnLk47
         SN50V5OutgVKeIBYdVchFfui7c+JBMEDmFtkSAGK4nnEnNXBkckeF8wckmqX0P4RZ+nx
         h5gfQeBbF0p30nQ957n/H4OluxicArSUvfqMC0FBBIkWoIwzCrUuVC1wTMhhD+ktSJO5
         +WJg==
X-Gm-Message-State: AOJu0YwYXHXW5dNhOZoNfcQAQOXvDLbrUUUUrV/2hyOZjUzB8zbF1h2Q
        7av7ceczofkvRan61HhtBpWKnw==
X-Google-Smtp-Source: AGHT+IHnm6GiYKkee1BBGlEg9/2GVy9OXofYG3BGHLaj+6z7TyuT5to3Ev1GjwdsT/XgsL2yDJJgGg==
X-Received: by 2002:a17:902:e548:b0:1c9:b187:4d84 with SMTP id n8-20020a170902e54800b001c9b1874d84mr8674687plf.14.1698049789506;
        Mon, 23 Oct 2023 01:29:49 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm5415805plh.186.2023.10.23.01.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Oct 2023 01:29:49 -0700 (PDT)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, maz@kernel.org,
        anup@brainfault.org, atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, liyu.yukiteru@bytedance.com,
        sunjiadong.lff@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, chaiwen.cc@bytedance.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 05/12] riscv: kvm: Switch back to CSR_STATUS masking when entering guest
Date:   Mon, 23 Oct 2023 16:29:04 +0800
Message-Id: <20231023082911.23242-6-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231023082911.23242-1-luxu.kernel@bytedance.com>
References: <20231023082911.23242-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kvm enters vcpu, it first disables local irqs before preparing vcpu
context and uses SRET instruction to enter guest mode after vcpu context
is ready, which automatically restores guest's irq status. However, after
we switch to CSR_IE masking for interrupt disabling, the SRET instruction
itself can not restore guest's irq status correctly as interrupts are
still masked by CSR_IE.

This commit handles this special case by switching to traditional
CSR_STATUS way to disable irqs before entering guest mode.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/irqflags.h |  3 +++
 arch/riscv/kvm/vcpu.c             | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index e0ff37315178..60c19f8b57f0 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -64,6 +64,9 @@ static inline void arch_local_irq_restore(unsigned long flags)
 	csr_write(CSR_IE, flags);
 }
 
+#define local_irq_enable_vcpu_run		local_irq_switch_on
+#define local_irq_disable_vcpu_run		local_irq_switch_off
+
 #else /* CONFIG_RISCV_PSEUDO_NMI */
 
 /* read interrupt enabled status */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 82229db1ce73..233408247da7 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -621,6 +621,14 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 	guest_state_exit_irqoff();
 }
 
+#ifndef local_irq_enable_vcpu_run
+#define local_irq_enable_vcpu_run		local_irq_enable
+#endif
+
+#ifndef local_irq_disable_vcpu_run
+#define local_irq_disable_vcpu_run		local_irq_disable
+#endif
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	int ret;
@@ -685,7 +693,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
-		local_irq_disable();
+		local_irq_disable_vcpu_run();
 
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
@@ -712,7 +720,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		    kvm_request_pending(vcpu) ||
 		    xfer_to_guest_mode_work_pending()) {
 			vcpu->mode = OUTSIDE_GUEST_MODE;
-			local_irq_enable();
+			local_irq_enable_vcpu_run();
 			preempt_enable();
 			kvm_vcpu_srcu_read_lock(vcpu);
 			continue;
@@ -757,12 +765,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * recognised, so we just hope that the CPU takes any pending
 		 * interrupts between the enable and disable.
 		 */
-		local_irq_enable();
-		local_irq_disable();
+		local_irq_enable_vcpu_run();
+		local_irq_disable_vcpu_run();
 
 		guest_timing_exit_irqoff();
 
-		local_irq_enable();
+		local_irq_enable_vcpu_run();
 
 		preempt_enable();
 
-- 
2.20.1

