Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE47FC26C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbjK1OyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345866AbjK1OyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:11 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415C10CC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c1acc1fa98so4804301a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183258; x=1701788058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWjJzXo4ydUM1qBdZFj/A/LBdPnzjXBTEeDQn9bxklc=;
        b=SR+B9bwQXi1BDIf/KEeufLybH3ombV18cVXRQqpJImYLpG8SpO+cdSbaVDIqnQ2z84
         JLxtK+Wynfvo7HT3RPHaPeNVq1IGraDhjzk9PYH5I+QPmIjjeBz76mM0BLj3ZJEWGKMZ
         5emkb6wQAPk1p0MEFurduanGw9AI6Pt8s+mBDGdd4PuJrkRLJj0LZEIGn1KBXftxHaB2
         v0ZM5QIt/I8JhGLB5o/BGhfMGFBFzzyFJLRQotvpMz6FpTHlYUpE4P3k2Y8L9MtxOfu4
         SzJzILJYi2fMEC4+nbRwzoKTHpLHu75c/QblP+axsASgrroErSlhMupJTxipK3jTpdpR
         dyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183258; x=1701788058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWjJzXo4ydUM1qBdZFj/A/LBdPnzjXBTEeDQn9bxklc=;
        b=SFwO5Bugw8n5v0nEen9S3v0Mf02bH4mP8k36quJc0tMD3j170L7gS09stBUInlLGcL
         YWStnvRLZXVF7SH6K1nNHf/QJLSirAOb0mWhMa97eHFqkIvekksWxEPrYCHb4MD09XUG
         AybTZQXbQJq0/4dxMWpzNU0iVBnYb/1pDl0/dh+uDGu4B8Hmh6lw0f6VtYqXr+WPh+dH
         8YUhzYw1KukBcFFfdZrI4WYapnd6X9QxuQNDtaHq4rwV8i0Cxop/oiAQbRmWzpYyBDFE
         AgkbmafIW4ZafwqHB2l3UyiJh1vWODAN0qFHpupTr2Uj913PYCZ8qkKzWrzDcH0RaHkK
         iagw==
X-Gm-Message-State: AOJu0YzdDUuWwB6vcK794eD8gZQS8ign04FsTsUPSt6sd8+I8ERwWKbr
        27YmikeULL7m+8N1RjuFXrblKg==
X-Google-Smtp-Source: AGHT+IGxW136Vwz0iG0z8Bd+73y8peGGLL8YdmZ8vllqxs8AnDN8I+cKti2HazA7AW6wj4+a/QmmRQ==
X-Received: by 2002:a17:90b:4b0e:b0:285:b687:b831 with SMTP id lx14-20020a17090b4b0e00b00285b687b831mr14391825pjb.10.1701183257699;
        Tue, 28 Nov 2023 06:54:17 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:17 -0800 (PST)
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
Subject: [PATCH 02/15] RISC-V: KVM: Allow Zbc extension for Guest/VM
Date:   Tue, 28 Nov 2023 20:23:44 +0530
Message-Id: <20231128145357.413321-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128145357.413321-1-apatel@ventanamicro.com>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Zbc extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 60d3b21dead7..518b368b41e5 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -139,6 +139,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZIHPM,
 	KVM_RISCV_ISA_EXT_SMSTATEEN,
 	KVM_RISCV_ISA_EXT_ZICOND,
+	KVM_RISCV_ISA_EXT_ZBC,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f8c9fa0c03c5..f789517c9fae 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -42,6 +42,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(SVPBMT),
 	KVM_ISA_EXT_ARR(ZBA),
 	KVM_ISA_EXT_ARR(ZBB),
+	KVM_ISA_EXT_ARR(ZBC),
 	KVM_ISA_EXT_ARR(ZBS),
 	KVM_ISA_EXT_ARR(ZICBOM),
 	KVM_ISA_EXT_ARR(ZICBOZ),
@@ -92,6 +93,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_RISCV_ISA_EXT_ZBB:
+	case KVM_RISCV_ISA_EXT_ZBC:
 	case KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_RISCV_ISA_EXT_ZICOND:
-- 
2.34.1

