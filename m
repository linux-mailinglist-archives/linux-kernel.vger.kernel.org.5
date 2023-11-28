Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC17FC1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbjK1OzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346446AbjK1Oy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:54:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9C1BF4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfc1512df1so19942875ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701183290; x=1701788090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm/Iyo3ZjfxV3AvcIfkWbfx2G5Qea1Dpvj7in6gJJEo=;
        b=fx0BCuYCbpHvzIZtgoFN0tiyMPMKqs06LYHAhTQV8ephbGpBLNBYRPli9kEEPXkJkz
         x8AbOoGEHWcbdaw47DvO0TfTd8QZU85n4FBBLR83CdqK6Cc2pohIJ4grMtGRVoSRZ+95
         H9QT7kLwuFCuuv/2u8bXy/pQKUvNNeGIzsmbSYoe2GIKXv7F6wWSaamplV/9OOtGvcsr
         kKmlANlqzLL5fqPec/C/ulkH70yFtNS585v5Qi3GBQPyd1QycDTxKQaSipvOm7mhWHds
         tIKlKKesxPTJM477U15ON1FRW+OAaZkqV3lGj++FqRl4lTlO7pqdCverQ2+BHCQDE53q
         1SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183290; x=1701788090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zm/Iyo3ZjfxV3AvcIfkWbfx2G5Qea1Dpvj7in6gJJEo=;
        b=pBt6pV8VyuddODfO1sWQeBiMa6XrtSWymRXDkHu0VFicXyfP0qwE/gsj2RnVk+6lV5
         jg4D6TH1RbNbCiK3u6FdsQDg2E4lt+Vt90zH8d9zhea/ox8tmKcD7QFBIbRpvRIpytwk
         mGIoRiiSut90UmOJE2oniSiz1iaOVlZ1MUp44YrNKcjci3eZSgCveJAvPdkEKGbxNyHY
         XZK7pGjl64zvakJRok6osHKkppHlHgWD5/o0EOPEyIyobvNyJ6B1rrwLlGcY62Ct85Y4
         2SlErO2vL+o54i8+9+9c6dgLY9QEmuqFTa/9mZ3XZek8kHUKCBJs2LgJL+zF3ys7cezN
         3cwg==
X-Gm-Message-State: AOJu0YxSH/Y0iILnUjyfZQ1uV4XXEnoZZw4wvchrCsN1CjpGXmZtCPM/
        Okd6lSxrD7tYa06YuosLGQ5lKMwb/F5glTPTJ6A=
X-Google-Smtp-Source: AGHT+IGNa0gmUO/XYyy1AQclzWoEopJjPk2a6P+hxdcxMn26I35PIIr0XIYsIPFAX9+qx2+hdanbsA==
X-Received: by 2002:a17:902:cec8:b0:1cf:c018:b4e9 with SMTP id d8-20020a170902cec800b001cfc018b4e9mr10533194plg.43.1701183290185;
        Tue, 28 Nov 2023 06:54:50 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001bf11cf2e21sm10281552plg.210.2023.11.28.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:54:49 -0800 (PST)
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
Subject: [PATCH 08/15] RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
Date:   Tue, 28 Nov 2023 20:23:50 +0530
Message-Id: <20231128145357.413321-9-apatel@ventanamicro.com>
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

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Zfh[min] extensions for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 2 ++
 arch/riscv/kvm/vcpu_onereg.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 241632f91f73..fa1a8e01b803 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -160,6 +160,8 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZVKSED,
 	KVM_RISCV_ISA_EXT_ZVKSH,
 	KVM_RISCV_ISA_EXT_ZVKT,
+	KVM_RISCV_ISA_EXT_ZFH,
+	KVM_RISCV_ISA_EXT_ZFHMIN,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 4cd075f4cf9f..ba418ac47e81 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -47,6 +47,8 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZBKC),
 	KVM_ISA_EXT_ARR(ZBKX),
 	KVM_ISA_EXT_ARR(ZBS),
+	KVM_ISA_EXT_ARR(ZFH),
+	KVM_ISA_EXT_ARR(ZFHMIN),
 	KVM_ISA_EXT_ARR(ZICBOM),
 	KVM_ISA_EXT_ARR(ZICBOZ),
 	KVM_ISA_EXT_ARR(ZICNTR),
@@ -118,6 +120,8 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_RISCV_ISA_EXT_ZFH:
+	case KVM_RISCV_ISA_EXT_ZFHMIN:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
 	case KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_RISCV_ISA_EXT_ZICSR:
-- 
2.34.1

