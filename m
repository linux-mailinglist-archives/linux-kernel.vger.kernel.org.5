Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B247F80E3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjLLFfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLLFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:35:03 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF5D1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:35:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d098b87eeeso46345605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 21:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702359308; x=1702964108; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcj60ICAmx2Wgj1m3BhaBwMoYIl3KbsB3eCSbSy5S74=;
        b=Vji2CaE2Nquab2swUAivgUpGrMIQSChLOi1FhGA62KDiMm8XUtc42WvPcz1S56h1p4
         sBGbo0IHf3hbgJ9twjOQ36VECk6uq9HUCROQHvNhL9KxyzyNN9co5ZJ2S/bc8lSPxH+B
         xMAu+NZTUMJLx52XXB+6eLRtpaS34O5Jk987CbRcGqLF7hxcHS9p+wk21ldpdP7GqJii
         4RQbQWhjnzr1bhtMC8+JS1z9Wcms6X2zzflDBXdAlA8bxUF32BTe8J12A9wpdvLx17BC
         iKHzfZo1Lkmb/DD0ipyi+eNcHGGKWJFBcRIZfXwlbfuF1gP4Mw8my7uyWYi5cPsXjSuJ
         cMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359308; x=1702964108;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcj60ICAmx2Wgj1m3BhaBwMoYIl3KbsB3eCSbSy5S74=;
        b=f+sFIwQycEnBQC4CGKAlAogFhRRGF/YQmn2KcwmGgKbbXmgi9BP5r/Y5h7x1iqpe2J
         I82ny0F4FcxPucXSOfBFeMkFDKARjV30VipfGPtb5K2o1fy68r/Rqs0s36RcJ0OrG/Se
         H+YZRHuiH2+eZMx/Qtn3ljHa3RpofYLyK27ooSApl2QNRxMipz4DiVY0jVlN/oKcVuFi
         qKhmhlhB1Bk4gvsSwCfTTR85xUAO2OKC/Fhkf7e7aHMhzZkP6AtFiVN710gSnLuvZZ2K
         YQoqq0f3TCd4DySAWUiW2VzXObB4OTdB+lZjwOubN0zR6QlRxplMdVI2dCZD8G300EI1
         11GQ==
X-Gm-Message-State: AOJu0Yys5APiKpPnBZEhCST0XcV2vL88mLIy8wLgHhk5PI4ji24B/CVR
        HGbH79uhCKhF250zlz1/IOz5UQ==
X-Google-Smtp-Source: AGHT+IH+0SEHIrmD1lG9gKpeJV/gu+68+6vQQUc6qbNwDMzT/HchEiI83Pj9+Ajy1EiiaZ5i2c6GhQ==
X-Received: by 2002:a17:902:eb88:b0:1d0:6ffd:9e37 with SMTP id q8-20020a170902eb8800b001d06ffd9e37mr6217232plg.137.1702359308075;
        Mon, 11 Dec 2023 21:35:08 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001cf5654fc29sm7654118pls.72.2023.12.11.21.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:35:07 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] RISCV: KVM: should not be interrupted when update the external interrupt pending
Date:   Tue, 12 Dec 2023 05:34:59 +0000
Message-Id: <20231212053501.12054-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The emulated IMSIC update the external interrupt pending depending on the
value of eidelivery and topei. It might lose an interrupt when it is
interrupted before setting the new value to the pending status.

For example, when VCPU0 sends an IPI to VCPU1 via IMSIC:

VCPU0                           VCPU1

                                CSRSWAP topei = 0
                                The VCPU1 has claimed all the external
                                interrupt in its interrupt handler.

                                topei of VCPU1's IMSIC = 0

set pending in VCPU1's IMSIC

topei of VCPU1' IMSIC = 1

set the external interrupt
pending of VCPU1

                                clear the external interrupt pending
                                of VCPU1

When the VCPU1 switches back to VS mode, it exits the interrupt handler
because the result of CSRSWAP topei is 0. If there are no other external
interrupts injected into the VCPU1's IMSIC, VCPU1 will never know this
pending interrupt unless it initiative read the topei.

If the interruption occurs between updating interrupt pending in IMSIC
and updating external interrupt pending of VCPU, it will not cause a
problem. Suppose that the VCPU1 clears the IPI pending in IMSIC right
after VCPU0 sets the pending, the external interrupt pending of VCPU1
will not be set because the topei is 0. But when the VCPU1 goes back to
VS mode, the pending IPI will be reported by the CSRSWAP topei, it will
not lose this interrupt.

So we only need to make the external interrupt updating procedure as a
critical section to avoid the problem.

Tested-by: Roy Lin <roy.lin@sifive.com>
Tested-by: Wayling Chen <wayling.chen@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kvm/aia_imsic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index 6cf23b8adb71..0278aa0ca16a 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -37,6 +37,8 @@ struct imsic {
 	u32 nr_eix;
 	u32 nr_hw_eix;
 
+	spinlock_t extirq_update_lock;
+
 	/*
 	 * At any point in time, the register state is in
 	 * one of the following places:
@@ -613,12 +615,17 @@ static void imsic_swfile_extirq_update(struct kvm_vcpu *vcpu)
 {
 	struct imsic *imsic = vcpu->arch.aia_context.imsic_state;
 	struct imsic_mrif *mrif = imsic->swfile;
+	unsigned long flags;
+
+	spin_lock_irqsave(&imsic->extirq_update_lock, flags);
 
 	if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
 	    imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
 		kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
 	else
 		kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
+
+	spin_unlock_irqrestore(&imsic->extirq_update_lock, flags);
 }
 
 static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
@@ -1029,6 +1036,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *vcpu)
 	imsic->nr_eix = BITS_TO_U64(imsic->nr_msis);
 	imsic->nr_hw_eix = BITS_TO_U64(kvm_riscv_aia_max_ids);
 	imsic->vsfile_hgei = imsic->vsfile_cpu = -1;
+	spin_lock_init(&imsic->extirq_update_lock);
 
 	/* Setup IMSIC SW-file */
 	swfile_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
-- 
2.17.1

