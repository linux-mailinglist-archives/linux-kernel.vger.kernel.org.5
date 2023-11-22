Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0627F3C28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbjKVDGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343551AbjKVDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:06:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F7EF4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso659631b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700622390; x=1701227190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBSDlJJdl9cJTZEKARyFff2b3kLrE8gro26mzSoUMfg=;
        b=kKAPHuA5bShBI1m2kdLOwPZWo8rdZdMqdWYrYnxgC8FodR0uho+MtADydgTUEbiBuN
         8mnXYcbNH53F4H69ufumyBCjhq/Un3bEB/7P901+gV595tFRhk9NMn31GuUIMMdxBH50
         SB1jAK05uJxHWDdSIGlB2pD00GD1/Gx+W9S3+9QWa1SxPHgBtjjSbhoez7j19sDuqlZT
         e6q8RuL5mo6z29SGBsLAvzhEDJjqKRjLcr/y/HVvdNQUiiJ/e47Mf0Sp962coyiGqhje
         RCtJBuaCF5R3BPbMQ6uPXJ4QrqlGjb5LT6DiOAkzu1yWzochUKd6aeBykAqp1P80eclp
         c5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700622390; x=1701227190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBSDlJJdl9cJTZEKARyFff2b3kLrE8gro26mzSoUMfg=;
        b=NYhogTze78FWoglGmIm6ZyCHgANciqaGsxM08/9kDtV533G7bOzUbTzup1gF9WdKyM
         EASbL4JP5gN6SRsp2Xr7OeuVOut1ugRvOsO8wTHcb6AwLYbVotXOtbY/oxr8rV4bDJVC
         pvij6diNLdbC5adxwOpL23U4nT9ud1tuYFuUOJ9ZwBlsKSjrK9aXBWBzg2xTlLc3cNtP
         g+yTT0cuS3S4zCfFfKAduvWWsu9qnV9jFIvLK1//t5D5eXhYSFVSXYrDYoVsgNite4PI
         jJ46EYlagLLZeLp3GG+SmC5PPzVYt2r28M9ONE3gpUTxqwMpvia4iO0GwG9SDPR0OQ6n
         bYRQ==
X-Gm-Message-State: AOJu0YyDwxbASTVR9dEyCCspeQJjUWP4kGr6S41//QuWmHMJU8qfsF5g
        FL6PKbhh2kNVi7ToD5qZL1/+ug==
X-Google-Smtp-Source: AGHT+IGAWRMig9MTM8HwbUunWOHJsJ/tdXoUczvav4ujcqkNnMcjGyNXeyS3D3MD4r1LtBjigmKHkw==
X-Received: by 2002:a05:6a00:98e:b0:6cb:cdd0:76f7 with SMTP id u14-20020a056a00098e00b006cbcdd076f7mr417804pfg.21.1700622390174;
        Tue, 21 Nov 2023 19:06:30 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s2-20020aa78282000000b006a77343b0ccsm8614917pfm.89.2023.11.21.19.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:06:29 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 3/3] drm/amd/display: Support DRM_AMD_DC_FP on RISC-V
Date:   Tue, 21 Nov 2023 19:05:15 -0800
Message-ID: <20231122030621.3759313-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122030621.3759313-1-samuel.holland@sifive.com>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

RISC-V uses kernel_fpu_begin()/kernel_fpu_end() like several other
architectures. Enabling hardware FP requires overriding the ISA string
for the relevant compilation units.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/gpu/drm/amd/display/Kconfig            | 5 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 6 ++++--
 drivers/gpu/drm/amd/display/dc/dml/Makefile    | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dml2/Makefile   | 6 ++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 901d1961b739..49b33b2f6701 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -8,7 +8,10 @@ config DRM_AMD_DC
 	depends on BROKEN || !CC_IS_CLANG || ARM64 || RISCV || SPARC64 || X86_64
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
-	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
+	select DRM_AMD_DC_FP if ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG
+	select DRM_AMD_DC_FP if PPC64 && ALTIVEC
+	select DRM_AMD_DC_FP if RISCV && FPU
+	select DRM_AMD_DC_FP if LOONGARCH || X86
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 4ae4720535a5..834dca0396f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -35,6 +35,8 @@
 #include <asm/neon.h>
 #elif defined(CONFIG_LOONGARCH)
 #include <asm/fpu.h>
+#elif defined(CONFIG_RISCV)
+#include <asm/switch_to.h>
 #endif
 
 /**
@@ -89,7 +91,7 @@ void dc_fpu_begin(const char *function_name, const int line)
 	depth = __this_cpu_inc_return(fpu_recursion_depth);
 
 	if (depth == 1) {
-#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
+#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH) || defined(CONFIG_RISCV)
 		kernel_fpu_begin();
 #elif defined(CONFIG_PPC64)
 		if (cpu_has_feature(CPU_FTR_VSX_COMP))
@@ -122,7 +124,7 @@ void dc_fpu_end(const char *function_name, const int line)
 
 	depth = __this_cpu_dec_return(fpu_recursion_depth);
 	if (depth == 0) {
-#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
+#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH) || defined(CONFIG_RISCV)
 		kernel_fpu_end();
 #elif defined(CONFIG_PPC64)
 		if (cpu_has_feature(CPU_FTR_VSX_COMP))
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index ea7d60f9a9b4..5c8f840ef323 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -43,6 +43,12 @@ dml_ccflags := -mfpu=64
 dml_rcflags := -msoft-float
 endif
 
+ifdef CONFIG_RISCV
+include $(srctree)/arch/riscv/Makefile.isa
+# Remove V from the ISA string, like in arch/riscv/Makefile, but keep F and D.
+dml_ccflags := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifneq ($(call gcc-min-version, 70100),y)
 IS_OLD_GCC = 1
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index acff3449b8d7..15ad6e3a2173 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -42,6 +42,12 @@ dml2_ccflags := -mfpu=64
 dml2_rcflags := -msoft-float
 endif
 
+ifdef CONFIG_RISCV
+include $(srctree)/arch/riscv/Makefile.isa
+# Remove V from the ISA string, like in arch/riscv/Makefile, but keep F and D.
+dml2_ccflags := -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)([^v_]*)v?/\1\2/')
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
-- 
2.42.0

