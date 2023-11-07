Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531087E3A96
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjKGK4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbjKGK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFED73
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40837396b1eso3063415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354575; x=1699959375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJyd1YBcb+U2PBneGSdwCeFg8Fe7xoja8XAVvgGr8QM=;
        b=kL4dRSDmheqW1rZa9Ma3GuG+hJghK/vLfPpPAmTPnPQNkc+v+PO+QBYBteB7FCABIW
         4f/qF0/vmHTJ1g6cvFQXULenWdUxp+VJzkQnWeq1n+uncWDzbigRGwknYyxCZGn+0Z2G
         Y3/yQdSfRdsJ8lqDBJUfNIoRs7gCb+FesUP1K1Hbo0ov53pqvU6CiD8ztEtWwb/iSSPF
         JCEd8vN1AwG7Zr/INM0c94gTDcri5IBnaENuCqx/yxENbZNhg+DIiKChTv1OT8W37P+k
         J9uJLRKVHGKrkKwxLXuSJj2g3oQ7oZv4inwm3OZzl2o3Kl6EIUP+MaVAgNoAwEvncWq9
         ERKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354575; x=1699959375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJyd1YBcb+U2PBneGSdwCeFg8Fe7xoja8XAVvgGr8QM=;
        b=VsYi0Mwqb7hEFhiBERupqGtIjsRWunUIw+2PT9SDlcNE63IFPsBcZZP28IktjpAPxT
         OMVYC8k2lK9AeGueCHhIDLE2RGxfUG8+WL7Xc17zs/Czf8OAMQ5DsZ3zZRx+RZv2K+5c
         wF2meGZZSHeyHnYWUlynnrBgiXow6wSa54Cx3xqMT40+7GhmlVKaFGBS/nk+2UFJx83H
         bPvBi35sdZ6gVYBDSTLLMYnxFVlmesln8QnQaZYcXC1GtpJNf1789VBlKOlHRtJdqqgw
         XYnxgxjN8lj1nLpVlApwbyoA9dS0vJyq5VeKOV10mBlPYfcF3mg8nlJPzkRucznDF/p3
         HU6Q==
X-Gm-Message-State: AOJu0YyEZ/GHyx5lECCxJNcgyfrvrWKqtR8KTBqjhXl8iNoZMGAdZylv
        5DNP0oNB5QxGWIcmoAfBN/5hXQ==
X-Google-Smtp-Source: AGHT+IFwqzEm1CRJc3Tvln28fqzLrx5PcA3gU0DPHRFsH47EQLrWlkSUXHW5cbEtNQ1KO6g6dWi35Q==
X-Received: by 2002:a05:600c:35d6:b0:404:7606:a871 with SMTP id r22-20020a05600c35d600b004047606a871mr24942179wmq.2.1699354574695;
        Tue, 07 Nov 2023 02:56:14 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:14 -0800 (PST)
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
Subject: [PATCH v3 12/20] riscv: add ISA extension parsing for Zihintntl
Date:   Tue,  7 Nov 2023 11:55:48 +0100
Message-ID: <20231107105556.517187-13-cleger@rivosinc.com>
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

Add parsing for Zihintntl ISA extension[1] that was ratified in commit
0dc91f5 ("Zihintntl is ratified") of riscv-isa-manual[2].

Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/view [1]
Link: https://github.com/riscv/riscv-isa-manual/commit/0dc91f505e6d [2]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 10ebd36f67e0..5b57b24db60c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -83,6 +83,7 @@
 #define RISCV_ISA_EXT_ZVKT		65
 #define RISCV_ISA_EXT_ZFH		66
 #define RISCV_ISA_EXT_ZFHMIN		67
+#define RISCV_ISA_EXT_ZIHINTNTL		68
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7c04c03e435f..baa8edfb0e6a 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -258,6 +258,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
+	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
 	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-- 
2.42.0

