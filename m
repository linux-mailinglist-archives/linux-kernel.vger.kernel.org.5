Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790787FC2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346486AbjK1OzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346474AbjK1Oyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:50 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E9C1FF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bddf66ed63so3922309a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183285; x=1701788085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfMEYFNY4t0wNlr3hA5A82AOB/2KSEl3zEL3USkF3fk=;
        b=NsrGMrP6iaqZHR3mxy+8keIe+BfQPUPdJjoiQD8MlHSRLUhdgIjThBfZ84aRcGSnAT
         xCKfpaavnwehytlR1/3s6W+a5b+BMqZvC0mTuIb4xTg929VLcF+xrLWPqAGMj9JjmpSE
         ZbLyMxNnn4HNg/1Z2HMfxU2HrGYqtXDvxlHscwRrGc7AkxqAqQwAn+VepqvRrYqMf+du
         pARUIbiTNgquZf9Z3n6mfAxMo76o94DOSXcoWEZbD3TB/K2lrP6EBNF4/Q7wvTwLXwvx
         22fm1bf1eqSnNY88Gn/CgN/nBrkUPmcUELvD4fH417Y+shMzzNkZrSAeNYdkvs9Ptpqo
         Yt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183285; x=1701788085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfMEYFNY4t0wNlr3hA5A82AOB/2KSEl3zEL3USkF3fk=;
        b=TBq5hnXM9Sxr6uNq5cUUiP0Wki+cRHEvxQ6ugsVSpCf6H7sLMMRWBSfMf7q9F9QvuM
         ceZ2ayBKADHj77GMzQYrfTIZnA48y1eHxVQEBYLl/PkyoN+aX+ohyhzMyTqzWyoksuQd
         /P2srxI7hd4CWfLkY2NbNcIyooTWg1LjV1oZDcKJTP05swu6gqqADCi4SHx0BfP0pliP
         rrXsJOJlMdKAmnmwzWTpmNPmUxQIEitLjGyoXPY52m4KIzKWPi0GBVU6ub15jLQuVZY/
         xRU/zBJDlpO0hNt0sv5lneegJgTWNUo3xZ9e7H0BjB+7iEbbqSlEiii1bQoQFczE+E+6
         9HpA==
X-Gm-Message-State: AOJu0YwvTe7E32ZDRWdUVphjhh96Ri1mFWRSL1PeRKbyqNu3zYoJqIhZ
        ad1pBWneJTdLHPQBToBLkdqbFw==
X-Google-Smtp-Source: AGHT+IE6h2fUA1tLYkF7nxYU5YCCr84rmf1flbtFaYMziBR2dmaX4sBzK4UtuEfEDYJpjxQHNuwUGw==
X-Received: by 2002:a17:90b:1b07:b0:285:9cce:a63f with SMTP id nu7-20020a17090b1b0700b002859ccea63fmr17562386pjb.23.1701183284854;
        Tue, 28 Nov 2023 06:54:44 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:44 -0800 (PST)
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
Subject: [PATCH 07/15] KVM: riscv: selftests: Add vector crypto extensions to get-reg-list test
Date:   Tue, 28 Nov 2023 20:23:49 +0530
Message-Id: <20231128145357.413321-8-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KVM RISC-V allows vector crypto extensions for Guest/VM so let us
add these extensions to get-reg-list test. This includes extensions
Zvbb, Zvbc, Zvkb, Zvkg, Zvkned, Zvknha, Zvknhb, Zvksed, Zvksh, and Zvkt.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index aabc05e4b02b..04ff8836c474 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -64,6 +64,16 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKSED:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKSH:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZKT:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVBB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVBC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKG:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKNED:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKNHA:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKNHB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKSED:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKSH:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZVKT:
 		return true;
 	/* AIA registers are always available when Ssaia can't be disabled */
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
@@ -392,6 +402,16 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZKSED),
 		KVM_ISA_EXT_ARR(ZKSH),
 		KVM_ISA_EXT_ARR(ZKT),
+		KVM_ISA_EXT_ARR(ZVBB),
+		KVM_ISA_EXT_ARR(ZVBC),
+		KVM_ISA_EXT_ARR(ZVKB),
+		KVM_ISA_EXT_ARR(ZVKG),
+		KVM_ISA_EXT_ARR(ZVKNED),
+		KVM_ISA_EXT_ARR(ZVKNHA),
+		KVM_ISA_EXT_ARR(ZVKNHB),
+		KVM_ISA_EXT_ARR(ZVKSED),
+		KVM_ISA_EXT_ARR(ZVKSH),
+		KVM_ISA_EXT_ARR(ZVKT),
 	};
 
 	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name))
@@ -781,6 +801,16 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zkr, ZKR);
 KVM_ISA_EXT_SIMPLE_CONFIG(zksed, ZKSED);
 KVM_ISA_EXT_SIMPLE_CONFIG(zksh, ZKSH);
 KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvbb, ZVBB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvbc, ZVBC);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvkb, ZVKB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvkg, ZVKG);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvkned, ZVKNED);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvknha, ZVKNHA);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvknhb, ZVKNHB);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvksed, ZVKSED);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvksh, ZVKSH);
+KVM_ISA_EXT_SIMPLE_CONFIG(zvkt, ZVKT);
 
 struct vcpu_reg_list *vcpu_configs[] = {
 	&config_aia,
@@ -814,5 +844,15 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zksed,
 	&config_zksh,
 	&config_zkt,
+	&config_zvbb,
+	&config_zvbc,
+	&config_zvkb,
+	&config_zvkg,
+	&config_zvkned,
+	&config_zvknha,
+	&config_zvknhb,
+	&config_zvksed,
+	&config_zvksh,
+	&config_zvkt,
 };
 int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.34.1

