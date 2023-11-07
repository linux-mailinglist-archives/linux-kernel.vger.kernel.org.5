Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D117E3A85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKGK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjKGK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92712B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso817418f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354572; x=1699959372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP/Xz2BZ0CN3QwJs26MNtdiNNK8TyKjqE/jUpDPgkTo=;
        b=CPmH/a2Tp+R4syctTx0yG2r1QKUgFeEl5B2EHNfrX1zA1Bl8q58AGHuXkystiSbISR
         DzPQ5/fv/MTNFsyVhr/N3wKMCdelJgeEVdO8XVt/a/XxCNhrWl9WWWR65BIhrX15zB62
         4z48sMKyIOdFHzJqHcd/p312EfKRL3cLRttfQxOm1iNHnZ97na6E2goRN3SChAOYDnLv
         QyW/t50gG8JQabdq/wdXK7FkXTPgDLrAoLdPLuGANLNwW7uVfxcMsh9ECYmCZ52NbamV
         6hraY7EyYUkH4qaL0swyq//9a968QgEyUsm7ycOWgvRJsOh7ujptxQe20tbH7pQzfle4
         QhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354572; x=1699959372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP/Xz2BZ0CN3QwJs26MNtdiNNK8TyKjqE/jUpDPgkTo=;
        b=KjPROZQF9DRf8eOiq2a63BaePld1k2kWhlIg/aUI14ZkfJvJPjxt+Mbd4wCc0NcgYW
         qeol5yLqv+c0gYHPOwnXMe3TH6A7zBJfBrOf9oF+mz4XJILXJYB/qGSbUrRtSZxYv2+l
         i60HFXEdy32Sv9Ic8QXmzKI4Ug/DuO9Z/yMVngexKCmvtkKTp46/jhvfQ+g7kdH3oVRp
         DwsXxeuEUqHrUMr5cXZZQbhtxmNxTkcXO3xn+APFcm8DkiiX99VkWjM4zsl95NzV0cAk
         Pc3V+7yLvH4AuIKB3sq0vsaWt4lXHaVkHh5w+xXR3MshanzclupT1rD3u0CdToTM4v4e
         DTsA==
X-Gm-Message-State: AOJu0YwTSql6CeLW2CknQJf+1yqccM47ujVReUEN07LUKBmWsPfH/h0T
        XTdvPXaUpxVfzS7Pqqe0t33zzA==
X-Google-Smtp-Source: AGHT+IE6VYSHRuwoE2N98xFWFeww3WuAv2d6RelnI44p7pd6PDNb8XsMUCdLyux86n2WxtMje6eQ5g==
X-Received: by 2002:a05:600c:3b91:b0:407:52f0:b01a with SMTP id n17-20020a05600c3b9100b0040752f0b01amr26054544wms.2.1699354571542;
        Tue, 07 Nov 2023 02:56:11 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:11 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Subject: [PATCH v3 09/20] riscv: add ISA extension parsing for Zfh/Zfh[min]
Date:   Tue,  7 Nov 2023 11:55:45 +0100
Message-ID: <20231107105556.517187-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add parsing for Zfh[min] ISA extensions[1].

Link: https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 556d1da02877..10ebd36f67e0 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,8 @@
 #define RISCV_ISA_EXT_ZVKSED		63
 #define RISCV_ISA_EXT_ZVKSH		64
 #define RISCV_ISA_EXT_ZVKT		65
+#define RISCV_ISA_EXT_ZFH		66
+#define RISCV_ISA_EXT_ZFHMIN		67
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 56570b838910..7c04c03e435f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -260,6 +260,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
+	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
 	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
 	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
 	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
-- 
2.42.0

