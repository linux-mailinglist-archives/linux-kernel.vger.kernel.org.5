Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0637E3A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbjKGK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjKGK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:56:58 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F710DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:56:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso817465f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699354581; x=1699959381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5SlhQ+MFK/oE1hG84P6kssLtuGPrTemJS5B/ituwJs=;
        b=HuLzHD5+NUplFSRSEigRYCAeD0v0cEK2NPID/6oGjjEmaPDUHskQwVpB+cWEvkFNFN
         NLIXXtPCTYKJCr+iwcVISdLgyRoD0Ghc5Y2NxjsB4ERA1RuGWaxrgSEjhxJWZzcjOVgl
         epmv7DDwCUkdjvpTYcao+ZD/WCzd8c6rsMgyv97wph253i5bbm5UPKrZrBjBff97WAJ9
         h6Gue5A1/boJ6p9HATQZo5uXfW53Wm9NjqMb/tTW5dwlygNm6B48cSqj1DxcosSFuZDq
         5A7M8z5EsZSF5ssB7cD5fLPSiKSd7DBa32/fq1epkaUuLNBeewtAwqfJkmLsMF7rp3XE
         1XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354581; x=1699959381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5SlhQ+MFK/oE1hG84P6kssLtuGPrTemJS5B/ituwJs=;
        b=A1DmjBq7PuTtHXRa2Tjbe1y4LjTXVqPmar+KKfIgSLnqu8hBa2SmVqS6gpZSvX8kQP
         kSyw3bU8HrE6/xCBPz+qd7ZP//+qoF0hWIyY9jxvROsLp0T2tyU+tLcNLE/g8RzOmqAq
         w5uDDRu9gExsjQUw49H/ezyUnIQpDVgKkcH58FSdKJnr9RDTo+fA4wmrS2MCUyT/ZZQJ
         zLgKPiiIaQmVTpHtWB2gn+Jjds+32fHFpc41XbXv0yWclydN8+qY9KP8vkF+ygL2zXX8
         QDf9XdLSyL31kKFv1zdr+L76yhHcfgo69Gk3ZSfH3kqAe3kjS4/gwzuVUDPxms52J7aM
         iR7w==
X-Gm-Message-State: AOJu0Yz91LI1sopBI8wM7tEIvHyHe24FkdPmOlDJlYR6E2I59X5c6Q1M
        ZJhaFLL3AOQMaO7eQT3Ewu8tyA==
X-Google-Smtp-Source: AGHT+IFQS7qfkMNRtAKpq/tiaOzmGYA+PKb/n54XAFPfjBLLUBdHDw7kelXyOwVBWWtsxlUnnASLNQ==
X-Received: by 2002:a05:600c:ac3:b0:404:72f9:d59a with SMTP id c3-20020a05600c0ac300b0040472f9d59amr26109516wmr.0.1699354580425;
        Tue, 07 Nov 2023 02:56:20 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:7db3:bdd9:4cab:2ee3])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c501e00b00405442edc69sm15396853wmr.14.2023.11.07.02.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:56:20 -0800 (PST)
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
Subject: [PATCH v3 16/20] riscv: hwprobe: export Zvfh[min] ISA extensions
Date:   Tue,  7 Nov 2023 11:55:52 +0100
Message-ID: <20231107105556.517187-17-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107105556.517187-1-cleger@rivosinc.com>
References: <20231107105556.517187-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zvfh[min] ISA extension[1] through hwprobe.

Link: https://drive.google.com/file/d/1_Yt60HGAf1r1hx7JnsIptw0sqkBd9BQ8/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 8 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_riscv.c         | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 2f37b26d27da..2a2fe4b026e7 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -146,6 +146,14 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTNTL`: The Zihintntl extension version 1.0
        is supported as defined in the RISC-V ISA manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFH`: The Zvfh extension is supported as
+       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+       ("Remove draft warnings from Zvfh[min]").
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZVFHMIN`: The Zvfhmin extension is supported as
+       defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
+       ("Remove draft warnings from Zvfh[min]").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 36c8d073c987..5124327b70ff 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -52,6 +52,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZFH		(1 << 26)
 #define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 27)
 #define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 28)
+#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 29)
+#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 30)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index af2b01b0a5b6..3cd5d42ae01f 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -185,6 +185,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			CHECK_ISA_EXT(ZVKSED);
 			CHECK_ISA_EXT(ZVKSH);
 			CHECK_ISA_EXT(ZVKT);
+			CHECK_ISA_EXT(ZVFH);
+			CHECK_ISA_EXT(ZVFHMIN);
 		}
 
 		if (has_fpu()) {
-- 
2.42.0

