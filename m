Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A737F3C27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjKVDGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjKVDGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:06:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668090
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so298311b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700622388; x=1701227188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qgh5NSWFVqrYvvpg0jEH3io2ggLKyOiM/1ZRjzAMrY=;
        b=ZnGd2bienBrsgJzHIARTLV63gA01T2BPAnyy0zfPONzpQ9yBcN3D0Fc6xEoQ7Jb1eO
         td06ieXqvF9z6PJRsw3kSOsNqxwBj2l0/lGSa46DuawC37Fezdzkd0REuQ2stDzL2Uke
         mBfJvsja/yv+DO48RgxNLD3GikvDSnB9G71JgytbD8kFiiVzM5TXX3baFZLeDCybuDpl
         /zsUj9+CAaClQtrLSHqRcUTAIDFjMEqpzk93Op409njwcB4Fa6JO5W3uO6zp42MlZxjC
         w0QDygkf2aIXSKj6ovQq3oQcbdGGh9hFvFpVkpU2uRsK6ydgA7Kjam/YGAp6PV10tZ4f
         cXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700622388; x=1701227188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qgh5NSWFVqrYvvpg0jEH3io2ggLKyOiM/1ZRjzAMrY=;
        b=OebeqoICPTn+7pvpwfTkn+3xKdZVqVoCLRXV2kJUEpo+c10OLkJHR0qLk61IYq+be5
         2aHNlD0m/9hqpa0mzw1Gny+e1unXLLtmk8HhXEztSBdWzezAl2+QMRJ7BSiGPTKhQOBk
         8G9//wkVGzHF20ueGEgyougYliY1d2Hi4lymbh7Nxra/zK2XBv9PyaWnJqi6n7O1cUwu
         ZmIucDG4tj+YXOilz2IPsxHWuF8XLGhRb8KNl/ZWVtmtLnWJEG1gZolRqu7GATVUf/td
         n8cGbMx8XQHH6QfrsxPshrSpb1tlrbylLHlwu7g+SwD41xarJVOxFjvgvp6++OTow/9z
         p2kw==
X-Gm-Message-State: AOJu0Yzm/qSnStki2fNwC1d4pYAoTgBNw5r3aFz0r6S2KHgrbiI6xEgv
        n0kckUC/QRYQLxGdkciHepwtOA==
X-Google-Smtp-Source: AGHT+IERIccwRaRQ+wlnx1zMjy0fsc3cDGpf4RjMA9LPr92p23dqVKDgXQEo3A0Wn14b3XN9NyJnpA==
X-Received: by 2002:a05:6a20:7da0:b0:17a:4871:63fd with SMTP id v32-20020a056a207da000b0017a487163fdmr1833586pzj.0.1700622388655;
        Tue, 21 Nov 2023 19:06:28 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s2-20020aa78282000000b006a77343b0ccsm8614917pfm.89.2023.11.21.19.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:06:28 -0800 (PST)
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
Subject: [PATCH 2/3] riscv: Factor out riscv-march-y to a separate Makefile
Date:   Tue, 21 Nov 2023 19:05:14 -0800
Message-ID: <20231122030621.3759313-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122030621.3759313-1-samuel.holland@sifive.com>
References: <20231122030621.3759313-1-samuel.holland@sifive.com>
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

Since it is not possible to incrementally add/remove extensions from the
compiler's ISA string by appending arguments, any code that wants to
modify the ISA string must recreate the whole thing. To support this,
factor out the logic for generating the -march argument so it can be
reused where needed.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/Makefile     | 12 +-----------
 arch/riscv/Makefile.isa | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 arch/riscv/Makefile.isa

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..c738eafe67a0 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -58,22 +58,12 @@ ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
 	KBUILD_LDFLAGS += --no-relax-gp
 endif
 
-# ISA string setting
-riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
-riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
-riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
-
 ifdef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
 KBUILD_CFLAGS += -Wa,-misa-spec=2.2
 KBUILD_AFLAGS += -Wa,-misa-spec=2.2
-else
-riscv-march-$(CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI) := $(riscv-march-y)_zicsr_zifencei
 endif
 
-# Check if the toolchain supports Zihintpause extension
-riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
+include $(srctree)/arch/riscv/Makefile.isa
 
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
diff --git a/arch/riscv/Makefile.isa b/arch/riscv/Makefile.isa
new file mode 100644
index 000000000000..e10c77e26fe6
--- /dev/null
+++ b/arch/riscv/Makefile.isa
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# ISA string setting
+riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
+riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
+riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
+riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
+riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
+
+ifndef CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC
+riscv-march-$(CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI) := $(riscv-march-y)_zicsr_zifencei
+endif
+
+# Check if the toolchain supports Zihintpause extension
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
-- 
2.42.0

