Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE37EB1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjKNOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjKNOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:14:25 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8971BEF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:58 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77773d3246aso14497385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699971237; x=1700576037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oJqbvRhcnLQ4NxthWPQmg85qomzW1aIjvQdZvqQ+P8=;
        b=dnx4y6VFVZXXxHxrPOZEMg+iwKsctF0YCegxpcgZ/bb45IGDJdKj4Y8+McR3vD6lI5
         y2T4cb1YbVszVikjWD42lwmNcxbHGVd6w9MD/TqmJvjdWRPwfGpWRniaRgFPXgXtpw0r
         CekBGC17nhNv8+evmB3Ke3NNJSyC2p1l7UO/tchmEyHmU1LTpo+GTvH2cKwnGsfW6N9I
         WK50pJpK80jGRpPiSQHMsNACQxFI5dgz76zrgd9AcA1AurxepWt6XLTl376nS4yju3Ti
         RWrDD7Ng5Y4Le361FOJ7lj3e0zdTnfSIfP8ilouMgdtmsUEvINxXqo6mDB+1iorQy/0F
         +szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971237; x=1700576037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oJqbvRhcnLQ4NxthWPQmg85qomzW1aIjvQdZvqQ+P8=;
        b=rFXqiNyGcZM+bZiqZWO/U8EIWMhrYwi1x+avh6BgCEFNNyvrwFgKO7UK7dP2B29Gr2
         WYJA/ylBLjZwmHlDvxmSOGbwPjbsaEAgLsXeWRqDjLj2ZOdJbSwLz3J4f+d8qsvObzMZ
         xgbSHFcQv9js6iUG+vVSXfZIvWpN82zIMnKbbaTogNcXVZga6f9TpvGkc+ZIlzuWxN22
         RT3NsAVSEA//lwjUQM+xQIRcK2OxA/wUqeAmatkCZ2nveT6CDIwgJQTaVvRJFLf5fNay
         XyCdG13DmgaJZKw6kD1WWMq8dLsvH+RNT8GBlzQfwCRuJ+GgTaBjr4dZ98SBUeK/fBT0
         S95g==
X-Gm-Message-State: AOJu0Yy7EokWv/Al6/kvCj2XZYXxqWu9h0opFxVrstTYmhuuVGyIQnlv
        WxvCO3CIkJ25ooHG4YkYBp7ing==
X-Google-Smtp-Source: AGHT+IF9EjIfzzCxNwPyM1ga1yNOhI5yYokOjuEfqsXGtogg+vNsqW/HCxpZN6Ez5oZMRSmIbkGJGw==
X-Received: by 2002:a05:620a:28d4:b0:773:a789:cd15 with SMTP id l20-20020a05620a28d400b00773a789cd15mr2090356qkp.6.1699971236775;
        Tue, 14 Nov 2023 06:13:56 -0800 (PST)
Received: from carbon-x1.. ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a220200b00777611164c5sm2701263qkh.106.2023.11.14.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:13:56 -0800 (PST)
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
        Samuel Ortiz <sameo@rivosinc.com>,
        Jerry Shih <jerry.shih@sifive.com>
Subject: [PATCH v4 19/20] riscv: hwprobe: export Zfa ISA extension
Date:   Tue, 14 Nov 2023 09:12:55 -0500
Message-ID: <20231114141256.126749-20-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114141256.126749-1-cleger@rivosinc.com>
References: <20231114141256.126749-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zfa ISA extension[1] through hwprobe.

Link: https://drive.google.com/file/d/1VT6QIggpb59-8QRV266dEE4T8FZTxGq4/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/sys_riscv.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 896ecfbbe5f4..41463b932268 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -157,6 +157,10 @@ The following keys are defined:
        defined in the RISC-V Vector manual starting from commit e2ccd0548d6c
        ("Remove draft warnings from Zvfh[min]").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFA`: The Zfa extension is supported as
+       defined in the RISC-V ISA manual starting from commit 056b6ff467c7
+       ("Zfa is ratified").
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index fffc69d9f6ba..91fbe1a7f2e2 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -55,6 +55,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
 #define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
 #define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
+#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index e90537593f5f..f0bd7b480b7f 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -193,6 +193,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		if (has_fpu()) {
 			EXT_KEY(ZFH);
 			EXT_KEY(ZFHMIN);
+			EXT_KEY(ZFA);
 		}
 #undef EXT_KEY
 	}
-- 
2.42.0

