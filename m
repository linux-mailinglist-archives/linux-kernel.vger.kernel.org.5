Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B37FC1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbjK1Ozb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346450AbjK1OzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:55:03 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1E211F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d00689f5c8so3346725ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183295; x=1701788095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hci+9UDHQawot6/zMSxnmVJawqM8CfBCCGrmHWBS6oU=;
        b=TPayRs9whr3uuBaSuUDfkKGmADZDwNbp1WsrOGt+sBJEPDcZX20OkJDROXx6TGhDFb
         GCTh2QDhTznTXxDFo8xTeF253YzQIXaLsEBdz7hTlX6Fz87og2Bnu2KHyIsQdO0VE5cd
         hCIGVVunV2bYNFA64VEkhPiO10ISP8HvwZiB2DQbS7GXwpemN5RM6fqTLAnhBzZZn992
         tIsEhWxCkLjtKNeqJtrnREYhPG5TluaCLDFn+kkiU/0GTZheA5AnB68Lvslo/Wvq4gxG
         h49nA5D0OBNtMd6aN3pQUM51QCuQXrHVMNhaGlEv1+x/RFkSjrgNr6tVK7vVgc/n9y+t
         udMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183295; x=1701788095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hci+9UDHQawot6/zMSxnmVJawqM8CfBCCGrmHWBS6oU=;
        b=rF+NKbntQmOjEs4RTolN32u4Jwz6oR34kQdaD9QYJUwVxHsrQ/G0m5shcCAneNK9V1
         9hFtUcCSh5kPg8BqoGjNWtAgU1h09gh35IqSRhrY0c+Xyf62eQqlOSdHRd6/U0AEF39I
         l6BSVEr9iuxXICQt7ew31KPqlgqETIY1ruuw8HDO+GzY+319DQJJkq2kNVILMnchHoan
         ylW3wJ6ENTpC9tE7e/hGkgIvwGZzDhCh9TKcbS41g9ZfKcv5rHyv+YVpspmpMPvIDKH3
         q+kQQAfzp9Pg6AVxWQjP2pEtKhbm1Yz1SkQs8HmHbS7Xy5BSvx4sQ1rc3r5YOBpDYFy0
         NT8A==
X-Gm-Message-State: AOJu0Yx43eMtD85IY87EYWm3DcbCHgBvJT0ufurweytH7XCoMLjDfLlK
        bbnjReiTqeXMZZistB6hwgRlpg==
X-Google-Smtp-Source: AGHT+IHnloDLnCJ3p0XiWdFIxCZ3S8kJNR5OplVR8qRnvg9ozpD5v57Rnc9CKkPkmm+OJT2ekALH/g==
X-Received: by 2002:a17:902:e5c7:b0:1cf:a4e8:d2be with SMTP id u7-20020a170902e5c700b001cfa4e8d2bemr18008232plf.12.1701183295332;
        Tue, 28 Nov 2023 06:54:55 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:55 -0800 (PST)
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
Subject: [PATCH 09/15] KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
Date:   Tue, 28 Nov 2023 20:23:51 +0530
Message-Id: <20231128145357.413321-10-apatel@ventanamicro.com>
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

The KVM RISC-V allows Zfh[min] extensions for Guest/VM so let us
add these extensions to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 04ff8836c474..4af0f9a750e8 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -49,6 +49,8 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFH:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
@@ -387,6 +389,8 @@ static const char *isa_ext_id_to_str(const char *prefix, __u64 id)
 		KVM_ISA_EXT_ARR(ZBKC),
 		KVM_ISA_EXT_ARR(ZBKX),
 		KVM_ISA_EXT_ARR(ZBS),
+		KVM_ISA_EXT_ARR(ZFH),
+		KVM_ISA_EXT_ARR(ZFHMIN),
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOZ),
 		KVM_ISA_EXT_ARR(ZICNTR),
@@ -786,6 +790,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
 KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
+KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
+KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
 KVM_ISA_EXT_SUBLIST_CONFIG(zicboz, ZICBOZ);
 KVM_ISA_EXT_SIMPLE_CONFIG(zicntr, ZICNTR);
@@ -829,6 +835,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_zbkc,
 	&config_zbkx,
 	&config_zbs,
+	&config_zfh,
+	&config_zfhmin,
 	&config_zicbom,
 	&config_zicboz,
 	&config_zicntr,
-- 
2.34.1

