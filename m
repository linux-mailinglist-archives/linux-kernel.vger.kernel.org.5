Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421E7B8278
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjJDOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbjJDOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:34:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22906C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:34:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053e6e8ca7so5615325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696430088; x=1697034888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3YF5WNle5WpS70J/C6Gc27a4yBxFn8dy6pHVVBXBUQ=;
        b=nRHBWLD2BeVsjKK5IK+4w2nw3Xcmd5InkpiYdvBHxWAvTdSR0H7mLrad7F2boeNqfv
         3F6cScUSKN6Au2l3K8rl+zW9Ygtl99QOUNxb59C49ofNNpNS0xRtRZlD92HOOFATEjfm
         fF1cGaMBGrIJAvup1b25GhNrumCwBfWP8ix1AjjrO0cWGD68yKgowlBYUISkxkT066Am
         sMDaGsX//zKl3HZDzdoPK0z6AcQSb3G2ysLXDMGfJfqcswaqeTIx57Lz9BO5MQ0JilsW
         G0EnSHKfBJrvQKi6dsdF61STbyE2/wfxeJgxp4N2taU9OlXXpClcOHmQCX2KeVoVFneC
         Infw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430088; x=1697034888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3YF5WNle5WpS70J/C6Gc27a4yBxFn8dy6pHVVBXBUQ=;
        b=bECxuwMA6C/hrnm1kDQEzZKS8q2qyqeyBvgUqr+jd8IM5nrmyr+d4laB97ejf4Kpf2
         x9U33gVd5ocDr7KX2n1Ouul5zyXrlSKscUUQuySQE2K1yyiriyKIYe0W2bRL75I2QrjL
         AthKNdpfX4pZc/+2rV52QuIblV6BxPFh8RJ9a4SrXnPY6yQQ0mXphqyR0MHhE+epQxGO
         HUqZ5f6IoHjYsTk6ZvMrsVvTy0Riw3zmmi1TQh4nCyhH6s1zyudHqvcHZhtmTJo2GdOG
         NruNfiwXl0U0Sql+vlCuwEqLWa/YsI73TA4vq0WlMBZDZwGf4X61NLAL5fSQ4LWgGlHU
         KDXA==
X-Gm-Message-State: AOJu0Yw1J5iow2QyA5Tn5eD/NxIsmVDXzwJ4deFYWNFduSNID/Kx7kqE
        SclpPww7D4VIXPRnE+ilua5Anw==
X-Google-Smtp-Source: AGHT+IGG8Kcx0OpDIRRrfevcHI4+l//9I5GBAldHw3+cp6ZLo6USiLMAAmHvXUqVSmuiNG9ieb8B4A==
X-Received: by 2002:a05:600c:511d:b0:401:b53e:6c3e with SMTP id o29-20020a05600c511d00b00401b53e6c3emr2517778wms.1.1696430088453;
        Wed, 04 Oct 2023 07:34:48 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id t20-20020a1c7714000000b00401e32b25adsm1686205wmi.4.2023.10.04.07.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:34:48 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: [PATCH 4/5] riscv: kvm: Use SYM_*() assembly macros instead of deprecated ones
Date:   Wed,  4 Oct 2023 16:30:53 +0200
Message-ID: <20231004143054.482091-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004143054.482091-1-cleger@rivosinc.com>
References: <20231004143054.482091-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ENTRY()/END()/WEAK() macros are deprecated and we should make use of the
new SYM_*() macros [1] for better annotation of symbols. Replace the
deprecated ones with the new ones and fix wrong usage of END()/ENDPROC()
to correctly describe the symbols.

[1] https://docs.kernel.org/core-api/asm-annotations.html

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kvm/vcpu_switch.S | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
index d74df8eb4d71..8b18473780ac 100644
--- a/arch/riscv/kvm/vcpu_switch.S
+++ b/arch/riscv/kvm/vcpu_switch.S
@@ -15,7 +15,7 @@
 	.altmacro
 	.option norelax
 
-ENTRY(__kvm_riscv_switch_to)
+SYM_FUNC_START(__kvm_riscv_switch_to)
 	/* Save Host GPRs (except A0 and T0-T6) */
 	REG_S	ra, (KVM_ARCH_HOST_RA)(a0)
 	REG_S	sp, (KVM_ARCH_HOST_SP)(a0)
@@ -208,9 +208,9 @@ __kvm_switch_return:
 
 	/* Return to C code */
 	ret
-ENDPROC(__kvm_riscv_switch_to)
+SYM_FUNC_END(__kvm_riscv_switch_to)
 
-ENTRY(__kvm_riscv_unpriv_trap)
+SYM_CODE_START(__kvm_riscv_unpriv_trap)
 	/*
 	 * We assume that faulting unpriv load/store instruction is
 	 * 4-byte long and blindly increment SEPC by 4.
@@ -231,12 +231,10 @@ ENTRY(__kvm_riscv_unpriv_trap)
 	csrr	a1, CSR_HTINST
 	REG_S	a1, (KVM_ARCH_TRAP_HTINST)(a0)
 	sret
-ENDPROC(__kvm_riscv_unpriv_trap)
+SYM_CODE_END(__kvm_riscv_unpriv_trap)
 
 #ifdef	CONFIG_FPU
-	.align 3
-	.global __kvm_riscv_fp_f_save
-__kvm_riscv_fp_f_save:
+SYM_FUNC_START(__kvm_riscv_fp_f_save)
 	csrr t2, CSR_SSTATUS
 	li t1, SR_FS
 	csrs CSR_SSTATUS, t1
@@ -276,10 +274,9 @@ __kvm_riscv_fp_f_save:
 	sw t0, KVM_ARCH_FP_F_FCSR(a0)
 	csrw CSR_SSTATUS, t2
 	ret
+SYM_FUNC_END(__kvm_riscv_fp_f_save)
 
-	.align 3
-	.global __kvm_riscv_fp_d_save
-__kvm_riscv_fp_d_save:
+SYM_FUNC_START(__kvm_riscv_fp_d_save)
 	csrr t2, CSR_SSTATUS
 	li t1, SR_FS
 	csrs CSR_SSTATUS, t1
@@ -319,10 +316,9 @@ __kvm_riscv_fp_d_save:
 	sw t0, KVM_ARCH_FP_D_FCSR(a0)
 	csrw CSR_SSTATUS, t2
 	ret
+SYM_FUNC_END(__kvm_riscv_fp_d_save)
 
-	.align 3
-	.global __kvm_riscv_fp_f_restore
-__kvm_riscv_fp_f_restore:
+SYM_FUNC_START(__kvm_riscv_fp_f_restore)
 	csrr t2, CSR_SSTATUS
 	li t1, SR_FS
 	lw t0, KVM_ARCH_FP_F_FCSR(a0)
@@ -362,10 +358,9 @@ __kvm_riscv_fp_f_restore:
 	fscsr t0
 	csrw CSR_SSTATUS, t2
 	ret
+SYM_FUNC_END(__kvm_riscv_fp_f_restore)
 
-	.align 3
-	.global __kvm_riscv_fp_d_restore
-__kvm_riscv_fp_d_restore:
+SYM_FUNC_START(__kvm_riscv_fp_d_restore)
 	csrr t2, CSR_SSTATUS
 	li t1, SR_FS
 	lw t0, KVM_ARCH_FP_D_FCSR(a0)
@@ -405,4 +400,5 @@ __kvm_riscv_fp_d_restore:
 	fscsr t0
 	csrw CSR_SSTATUS, t2
 	ret
+SYM_FUNC_END(__kvm_riscv_fp_d_restore)
 #endif
-- 
2.42.0

