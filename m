Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4057FC290
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbjK1PlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbjK1Ozb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:55:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D661BD0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfc3f50504so21137935ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183316; x=1701788116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkGfNv4MRWM+/ohqvIrTgVS2Seh7FR6OjZNHRMq6/PQ=;
        b=M4rWykJPIoBaXrpqL9YaNfrWcbRDFTv+V5JMzGlinePKCQ91x8NvswN9+nXWnXyRv/
         D/qtq9ZCXDHcOYcGVeeJ2tZiQIvAZNZy05hZ8Iu8ZRON4tXcj11GCJKjOQul4HEqCaig
         JUfBJ6UoIgDCJ1XdUdDMYht6XI/CZhdlapnDCn9cFI46NLOCUbPj4Cx90VZhqsFiAsFm
         +PSi2M8AhtvFG+/d6xlXpvDYYCebZ/gFT//FDSWuxPNaYj4shReq9CsoIUexVOoV+3v5
         2+uzkGfOUdmEET+lW63n/WfWVzKvPRQNSiFxBrgwRCrESnZC6ai3kBRZ2/FMPHhKnmub
         7WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183316; x=1701788116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkGfNv4MRWM+/ohqvIrTgVS2Seh7FR6OjZNHRMq6/PQ=;
        b=OzU0/yuu9+BhJZSL2V6MgU/yzhXUDqJmoW8tO561L68HIuY4WxgQXhshzbmm2HZ/lw
         2fXDVSDkmAm6sBb/fvp/SJ5VpiSNVNpZ+lHPpEB4PP32DxlyM2V6dkVQq6GwGCu5v+Nz
         E0laUfzBmykf+x+GALhT92ozQ/LvH7fuDEJuat7o3Wv66jsL+qGZyVfE8KMKaBazsR6g
         2LUoxlQFgk3mR/bAIp1LTlw7Ah9e+sYMrlvKnJ+C0Q92tWH341/2jfZleWzu0yY45cas
         PoyY78kyFnnb+hQssj6C+i2ONNTCLzTBa8dd64qofTgS7DLaeHnKthIAT8XsaIOQiwAM
         MPQg==
X-Gm-Message-State: AOJu0YyNuckC3f/gzR1V8k8U3LTN5eMO5TLYRe0r5NtCA9SnD9/mR0KD
        GaIwCUZaWqDgQy+foSEGQy5MRw==
X-Google-Smtp-Source: AGHT+IHha1V/+lGe74ulF5vndgORIT1jhXH9iyKmg5JY+8yLgvt+PCD6lksk87FC5mErYuRTqwnFCg==
X-Received: by 2002:a17:902:da84:b0:1cf:ea64:f501 with SMTP id j4-20020a170902da8400b001cfea64f501mr4453347plx.9.1701183316449;
        Tue, 28 Nov 2023 06:55:16 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:55:16 -0800 (PST)
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
Subject: [PATCH 13/15] KVM: riscv: selftests: Add Zvfh[min] extensions to get-reg-list test
Date:   Tue, 28 Nov 2023 20:23:55 +0530
Message-Id: <20231128145357.413321-14-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM RISC-V allows Zvfh[min] extensions for Guest/VM so let us
add these extensions to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index e1d43cc9da16..df03bc511fbf 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -69,6 +69,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVBC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVFH:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVFHMIN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKG:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKNED:
@@ -410,6 +412,8 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZKT),
 		KVM_ISA_EXT_ARR(ZVBB),
 		KVM_ISA_EXT_ARR(ZVBC),
+		KVM_ISA_EXT_ARR(ZVFH),
+		KVM_ISA_EXT_ARR(ZVFHMIN),
 		KVM_ISA_EXT_ARR(ZVKB),
 		KVM_ISA_EXT_ARR(ZVKG),
 		KVM_ISA_EXT_ARR(ZVKNED),
@@ -812,6 +816,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zksh, ZKSH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvbb, ZVBB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvbc, ZVBC);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvfh, ZVFH);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvfhmin, ZVFHMIN);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvkb, ZVKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvkg, ZVKG);
 KVM_ISA_EXT_SIMPLE_CONFIG(zvkned, ZVKNED);
@@ -858,6 +864,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zkt,
 	&config_zvbb,
 	&config_zvbc,
+	&config_zvfh,
+	&config_zvfhmin,
 	&config_zvkb,
 	&config_zvkg,
 	&config_zvkned,
-- 
2.34.1

