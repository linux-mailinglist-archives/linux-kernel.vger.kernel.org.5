Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67757FC122
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbjK1O4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbjK1Ozj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:55:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A32106
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfb83211b9so25352375ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183322; x=1701788122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+aK5RATSMuwz0R11fQ6d3osSrL0r31QZEh4gl5Kftw=;
        b=o8lj6AePTJKotUIH1flyqPRRwjpM/ftdYvv6XxsaJxj37UQ7IakeqdQRP3w9SkZitF
         xa5FMLLyuPnKNMa+J155d7a4rYXPy/tXu460VPXJx3sHtMz6SykUL1o8xra0usQKQs/Y
         7KasoMcevznFfOEaFYaTMcvB8CSddFhef+v+2eKXM7hnAxG6/HOzG6ZHicwfoe9rsfNe
         Yj/1Iu1ZU/5nCzDb4IOZqDs4BCW9hYVNtK5o9QpHlSEB7bpSVbBSnPewfvMurS8fMB2S
         GSwPA0mY8QnY8pCf2ujliOj+jdUwOfQy26Z0xkfbn3zqi6jOKz3X3OIMml94iI5hIQvY
         79VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183322; x=1701788122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+aK5RATSMuwz0R11fQ6d3osSrL0r31QZEh4gl5Kftw=;
        b=t9LNVRHPOKiLUpFFb4e9l4Fmxj2UpuvdKu545SR4ude61Kkf1VvEXZ4oxqQenSvvgf
         7T3fy3x4TdpCL0itKzDtH843dvIeGrNL3ZcftwRDsASDVSCWmesPq569uJCyxj4WC273
         RgAqorXsnTvIjBrhLlHjwkVYN96hawmPZvtqOfu98LzAcft2tkm6cNEx0ceY42zGaPdq
         mNEqCPOU/9mqSW4j7l3jSgokZjgkIKg/WcS4Xk8eaS8XbMeYUvcTY3P874bijRXOU4MN
         nVXGtUG0W23he9ru5ep4DphomMtsFirD04w+xtikQmR3aKo1C8b1Jhc3gf7KvqYupJGx
         V43A==
X-Gm-Message-State: AOJu0YxFJg1B0nlnMb7/YkocV8MM67Q6ZUdQR7KheNmTM/LTsI3itY2f
        69qj5I1OwvuUC6dJWnLVAblqKg==
X-Google-Smtp-Source: AGHT+IH2xWVOITfzziniBlNh6pTHruM1083PD+Pd2O1gzhC3MdYm+hsrORloedeBl+KCem0W7nVbUQ==
X-Received: by 2002:a17:902:c949:b0:1cf:bd6c:f7fd with SMTP id i9-20020a170902c94900b001cfbd6cf7fdmr11119342pla.49.1701183322059;
        Tue, 28 Nov 2023 06:55:22 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:55:21 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 14/15] RISC-V: KVM: Allow Zfa extension for Guest/VM
Date:   Tue, 28 Nov 2023 20:23:56 +0530
Message-Id: <20231128145357.413321-15-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Zfa extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 32c7ff23ecce..909bd98220ee 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -165,6 +165,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZIHINTNTL,
 	KVM_RISCV_ISA_EXT_ZVFH,
 	KVM_RISCV_ISA_EXT_ZVFHMIN,
+	KVM_RISCV_ISA_EXT_ZFA,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 6b2d81c8cfe7..ba18587ae8c7 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -47,6 +47,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZBKC),
 	KVM_ISA_EXT_ARR(ZBKX),
 	KVM_ISA_EXT_ARR(ZBS),
+	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
 	KVM_ISA_EXT_ARR(ZICBOM),
@@ -123,6 +124,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
-- 
2.34.1

