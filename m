Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECDC7CC453
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343845AbjJQNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbjJQNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:15:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07173107
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c51774da07so6837751fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697548535; x=1698153335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3obtZPNOKP8LH+KjJEwDeimcpj3eT+9Cd34xi+FsYNw=;
        b=u5ZkaH2bN/ItQa1WQ4P8FXFoAITbBqWQIulaDtndjIOMQShIKOLFu0FcM5qBO4URTj
         g6Hgaft8g3okguJy/haY3vpj9LeNY9cUe5ROcpiHEMhIJ2f2p1B+v8nIhR/VPf/Rczsz
         v3hv9mTEPBnqcgI28wW7uPsKwRzocHA96gFk3/P3RuzUdigvu6Wela8JUb3RuXODoKL9
         jxVuPaSXuUK9f3bOWw5dnn5zNpMgbTGtPRiWXf8dbKJ826OI6fjJ7fQODs3sq8x7k4TE
         dCjV9z97j7r5xI/W016egpc/UpHKYDQA864Cd03cGZ+Oa/4p45TX69HOOkdbYVKSet5t
         iD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697548535; x=1698153335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3obtZPNOKP8LH+KjJEwDeimcpj3eT+9Cd34xi+FsYNw=;
        b=qPLLFSYPCrMbiqLaONWMIJVY7/lZbk31TRmDK8Nsp9pbTGI3xb4W6LEwdWj37oyYSf
         YDDWz6A/NDMAZl79BL69OagVCaUHE4d8JlA/yvaxCLy0cCo29em0ecFOhNW6WKPrMF+w
         3FWrbtawtwr7l0DQG0I11cIlpgV3P9MT2dpXazpUsvht3SXBAJFYA1lyiGNNTI4lJg9v
         TivUhcp3EjwYyajMrgO4CXRYfw2Mw4f8SeV9mEXoTNZkn/DSbbnPYp4ITxEL8ccz8t55
         HCO0ktmCJ/J3UFxRCzsrvQYkGBjJgCr0QEQs+k9iSPy1nY8qSRcLRAJJ/qlr5Rtn2Mwl
         c/5Q==
X-Gm-Message-State: AOJu0Yyzj28zTGaBFWrmbHYA7hjGmPEdrfxa6c11rAaeSidMtrVMO/7W
        7KiJ4/TM/HDKmcO1y+544wlNxKae8PsnMSHUD97Kyw==
X-Google-Smtp-Source: AGHT+IF341BXCev0oxtaNbakkAnO4ZAxajhUcsSm+LPtv73PBIJRAamKmYX/PlGez1RMG9nLGmAzPA==
X-Received: by 2002:a05:651c:c8c:b0:2bf:b0d3:20f9 with SMTP id bz12-20020a05651c0c8c00b002bfb0d320f9mr1924875ljb.5.1697548535010;
        Tue, 17 Oct 2023 06:15:35 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:96:820c:ecf7:a817])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm9873393wmb.2.2023.10.17.06.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:15:34 -0700 (PDT)
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
Subject: [PATCH v2 09/19] riscv: hwprobe: export Zfh/Zfhmin ISA extensions
Date:   Tue, 17 Oct 2023 15:14:46 +0200
Message-ID: <20231017131456.2053396-10-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017131456.2053396-1-cleger@rivosinc.com>
References: <20231017131456.2053396-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export Zfh/Zfhmin ISA extensions[1] through hwprobe only if FPU support
is available.

Link: https://drive.google.com/file/d/1z3tQQLm5ALsAD77PM0l0CHnapxWCeVzP/view [1]
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 Documentation/riscv/hwprobe.rst       | 6 ++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_riscv.c         | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 8681fb601500..35aedfff5049 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -137,6 +137,12 @@ The following keys are defined:
   * :c:macro:`RISCV_HWPROBE_EXT_ZVKT`: The Zvkt extension is supported as
        defined in version 1.0 of the RISC-V Cryptography Extensions Volume II.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFH`: The Zfh extension version 1.0 is supported
+       as defined in the RISC-V ISA manual.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZFHMIN`: The Zfhmin extension version 1.0 is
+       supported as defined in the RISC-V ISA manual.
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
   information about the selected set of processors.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 2529cee323db..390805c49674 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -49,6 +49,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 23)
 #define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 24)
 #define		RISCV_HWPROBE_EXT_ZVKT		(1 << 25)
+#define		RISCV_HWPROBE_EXT_ZFH		(1 << 26)
+#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 27)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 25d35800809f..4cca8b982a7a 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -185,6 +185,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			CHECK_ISA_EXT(ZVKSH);
 			CHECK_ISA_EXT(ZVKT);
 		}
+
+		if (has_fpu()) {
+			CHECK_ISA_EXT(ZFH);
+			CHECK_ISA_EXT(ZFHMIN);
+		}
 #undef CHECK_ISA_EXT
 	}
 
-- 
2.42.0

