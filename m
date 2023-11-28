Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318787FC163
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbjK1Ozh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346545AbjK1OzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:55:10 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7041FEF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfd04a6e49so17426405ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183300; x=1701788100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5JCc1y7hChZCMhp/0UYXh4hGb5WFeFKUHk/se+Qy3o=;
        b=LRdjJD1Ap5Jq2lae5f5/XxeSz3kLdt4pslDFekE2C0WptfSmQI//f5159W8OLWCdkA
         BYnHOMosHX+qekqXaruqY37QiTQKpyqZgj83XrYQPqIZ9++USpNFyvbQpww80uOMSv4T
         w2pDsj86dOhCN7OxVhzkUoifZw43xXr4gINdtW5UHPwUuHXmB7z3D8nsWZ/eicCTopUR
         NsQeuC9+U1ag91S0+rrt4wvcSN6QtMNCiofAMZcDf6FBeeI0zUETVWCC8MvCCvDODPNW
         2TMAkc9NO4cKCKqYHul4qR7vUf8PfBYyLBrkHo6CJQdH0opSvfzgv9OofABBCl04mfaY
         UTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183300; x=1701788100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5JCc1y7hChZCMhp/0UYXh4hGb5WFeFKUHk/se+Qy3o=;
        b=oPEhy0s6gsTCm9YZIfKQ0WqmwVjsVEdgVevbGuvANVDvr02LadYn+sp8Rn+PHgM66I
         YW73W7mZlLVL3lJxbZDCmdDL+X/dY+o7Xd9FvAhRr/HL4qL/VLfvACYU1NckWRowHjSO
         V+/vpi7I0xByWfnNB+IpzDg+u4p4ums2o054C7PyksWL1+cW03DuZivyuqOTdouJ0sVg
         k426KUlKzwLV7mocedG12RdPqG1auz7DGiGOHr2kl4P77WdIW3sMYct9VBmvSoVlz/WQ
         /PO6kLGmPBZwu9bKZ2L1Q54E0N0rHDq/j6bj36+vtmMj7RdrNbu6qfylD3H58fihbvJ6
         slUA==
X-Gm-Message-State: AOJu0YxIoRIwwmNZNiRiy/rrGoGHBfM3XOWkOTr1qGLmaOJJ1JjN1W0l
        2IP7OuY6r4lE4rvRMTmZt8oUsA==
X-Google-Smtp-Source: AGHT+IFHvz2KJ2Ptp4VuMdWWkjIvpDtHxQBvBlRtVm0cv6eOX2vsedmq5SV8bJu7+77gjoAbna9mJQ==
X-Received: by 2002:a17:903:24c:b0:1cf:7e39:feb with SMTP id j12-20020a170903024c00b001cf7e390febmr26796386plh.23.1701183300534;
        Tue, 28 Nov 2023 06:55:00 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:55:00 -0800 (PST)
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
Subject: [PATCH 10/15] RISC-V: KVM: Allow Zihintntl extension for Guest/VM
Date:   Tue, 28 Nov 2023 20:23:52 +0530
Message-Id: <20231128145357.413321-11-apatel@ventanamicro.com>
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
user space to detect and enable Zihintntl extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index fa1a8e01b803..0ed5b0f8a230 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -162,6 +162,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZVKT,
 	KVM_RISCV_ISA_EXT_ZFH,
 	KVM_RISCV_ISA_EXT_ZFHMIN,
+	KVM_RISCV_ISA_EXT_ZIHINTNTL,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index ba418ac47e81..ba0a44b6b757 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -55,6 +55,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZICOND),
 	KVM_ISA_EXT_ARR(ZICSR),
 	KVM_ISA_EXT_ARR(ZIFENCEI),
+	KVM_ISA_EXT_ARR(ZIHINTNTL),
 	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
 	KVM_ISA_EXT_ARR(ZIHPM),
 	KVM_ISA_EXT_ARR(ZKND),
@@ -126,6 +127,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_RISCV_ISA_EXT_ZICSR:
 	case KVM_RISCV_ISA_EXT_ZIFENCEI:
+	case KVM_RISCV_ISA_EXT_ZIHINTNTL:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
 	case KVM_RISCV_ISA_EXT_ZIHPM:
 	case KVM_RISCV_ISA_EXT_ZKND:
-- 
2.34.1

