Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842D67AD956
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjIYNj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjIYNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:39:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4061116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:39:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5bbb205e3so58382785ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695649187; x=1696253987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vUWcwNassqNthW+S+LkFt6P4jG1B8nw+IYC+PUr7yI=;
        b=O79L0dYOVuVFQ6UGfZRCQcFAs0hK2hMV4CZmHzPW11+ELCKGgxw8v5hItOUWGKtAmj
         8tYgtTkjkOxAl7bBGBH1p6p+ZJTksHLGhNpEGmuPAVuV5ijy92+mW0qJP1H96+d8BAKu
         aClp1Wxnee236ftIzaaF/6Cast1qG0Eti5c3CVe3H6t4mLaIa8wwmOTztIxa+zDPmhsv
         GioAjMkY4j929WA8JCWidNPB0AJ35+Rt8phADamOAXJ1b5+2t4ttlqoq5aSwa0a1j0St
         Z+VkX9e/ILFECM7+tzJZZzVVkiDrmJsk1QZ9/HIhlSDn6k3omW5RtdPtHcEB35+YJXr5
         Mf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649187; x=1696253987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vUWcwNassqNthW+S+LkFt6P4jG1B8nw+IYC+PUr7yI=;
        b=W87kzZJEs8laE+NEgaY7Elg/Md9v/7XrwfDUSbmRzV7R/iI7CPXo5NWtt94vllrlLV
         XIK2z2Isn6e0PC474CtfbAi+5LvlQd7QfwVNtvV2GZsioofE7ljjZULtNddOwwBmbiTZ
         ner1Tdyz+LHtCucfvRx1w7LUgG9Uo2lZjT013QBuvpAZc99tfOLm7I/mVTRE0KyrQ9FI
         1qyU83v3HdbGohQLvjlPdPJM+U29JG5NI65N8Rk+vyIKQ9XPqkHLQ9uFnH/vZm4V2TvD
         HOHoednxmaWZ2YMSX5pXSbMNzKFEoOxDG/vWVmuK9Trgn+OwCrChEKROYNufJBRacrwq
         9Qlw==
X-Gm-Message-State: AOJu0YwK1mjJXaK+AvDc0DZGGExscFmAWBC3YxXZxAioFWLi6lgqAhTg
        HOqbIQ+CAfEOgz+yFLVdTDIqzw==
X-Google-Smtp-Source: AGHT+IHSOl9ki8QCBXo+uVtTVFpD8HahTf26vYb6+QGHrGWFkZ/UI6Ksnsz5GkQiW3yp4D+zsZYpGw==
X-Received: by 2002:a17:902:c412:b0:1c5:b4a1:ff3 with SMTP id k18-20020a170902c41200b001c5b4a10ff3mr9924366plk.40.1695649186774;
        Mon, 25 Sep 2023 06:39:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm969433pld.129.2023.09.25.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:39:46 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 5/9] RISC-V: KVM: Allow XVentanaCondOps extension for Guest/VM
Date:   Mon, 25 Sep 2023 19:08:55 +0530
Message-Id: <20230925133859.1735879-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925133859.1735879-1-apatel@ventanamicro.com>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable XVentanaCondOps extension for
Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index b1baf6f096a3..e030c12c7dfc 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -138,6 +138,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZIFENCEI,
 	KVM_RISCV_ISA_EXT_ZIHPM,
 	KVM_RISCV_ISA_EXT_SMSTATEEN,
+	KVM_RISCV_ISA_EXT_XVENTANACONDOPS,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 388599fcf684..17a847a1114b 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -40,6 +40,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SVINVAL),
 	KVM_ISA_EXT_ARR(SVNAPOT),
 	KVM_ISA_EXT_ARR(SVPBMT),
+	KVM_ISA_EXT_ARR(XVENTANACONDOPS),
 	KVM_ISA_EXT_ARR(ZBA),
 	KVM_ISA_EXT_ARR(ZBB),
 	KVM_ISA_EXT_ARR(ZBS),
@@ -89,6 +90,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
+	case KVM_RISCV_ISA_EXT_XVENTANACONDOPS:
 	case KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_RISCV_ISA_EXT_ZBS:
-- 
2.34.1

