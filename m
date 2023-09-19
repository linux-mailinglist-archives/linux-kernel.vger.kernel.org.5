Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D47A5814
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjISDy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjISDyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:54:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1F135
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:54:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-578afd8b46cso368676a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695095654; x=1695700454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4XXbW7JTA+rX6h2wllSUbALMsH935/QgdVn7NuGhB8=;
        b=SZUfbmyXa9kHcmrS6PWs/XaUTkBZbQTOIGPglqhn6Lo2zx9S7C+r2XWrl28jajAjOw
         bCAdVYfrmchzZ5tL06KzgzlnqLAHmhTkpTj/dMDodFy7RhYv3zb7CP1oR+nG0j8Efyt6
         CmXrUBfguYYWDef5x5GkXBYBKCNTfcDcSYoYhSJvlzoeXraxM3/8WH4+q17MkC7vkQmD
         EjvEmFIYdVWB3m+4uzMcsR6HWHDwsXLret6PBHINAXlCAodkTGoHNcbqTp4GgXZe94r8
         MmDyXUbE9W8rp+fX2a9sztrIvh+c62yAXrX1amP6KpnyjuldUWaElR7cFEXcgn35CSHm
         YOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095654; x=1695700454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4XXbW7JTA+rX6h2wllSUbALMsH935/QgdVn7NuGhB8=;
        b=rS9PuEAuLwxGChYdqx7ZbrO1vlpxU6yeUzTYCNfNkh2yXoioVVIhq/ZhDdGtBomVQk
         JIOkHZDIMtrdMOjstQq+mwtna5+tRxJeJ51iczk2qCElpxpz8+R98XIqgS9hMy1ldiNb
         dNjUy8vxEMpxd03ninsWjp6/SFL/fk1CfhrQIGDmMce16MSGpPn2vEPGWbSAhZE2YjK2
         dhmVixxJohIEXfdRw30Ln0aWV4sraiXKq9zHbaI50adw1yk6/d5K8zdXLRYyT0Hyc9Xn
         LoHLcKmXD3O63k1tpGsghGyFIFvACd0TwTb2Jm2CFS4aybRk+/DdxZFB6KTaAOh+O5QT
         o3kQ==
X-Gm-Message-State: AOJu0YxX/y5dwBjfm5a7UEa9Z2Th27uUFRgrdjrz9nT6cWqBjSPlu2E9
        AxnKTOF19FXhbupAK/cLR3rEgqUQpHKfifkEScL0xw==
X-Google-Smtp-Source: AGHT+IER7aDasNv4HryZXs+OqFjdWVOMVvC9oosimk80Dhx9t1V5Xr51sadYHq9bBP2SmlwGRGTGig==
X-Received: by 2002:a17:90a:c0f:b0:274:3a86:4c10 with SMTP id 15-20020a17090a0c0f00b002743a864c10mr9217500pjs.29.1695095654352;
        Mon, 18 Sep 2023 20:54:14 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00273fc850342sm4000802pjf.20.2023.09.18.20.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 20:54:14 -0700 (PDT)
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
Subject: [PATCH 3/7] RISC-V: KVM: Allow XVentanaCondOps extension for Guest/VM
Date:   Tue, 19 Sep 2023 09:23:39 +0530
Message-Id: <20230919035343.1399389-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919035343.1399389-1-apatel@ventanamicro.com>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

