Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62608809C07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573246AbjLHFzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573209AbjLHFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:55:05 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF79C1720
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:55:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d05e4a94c3so15607065ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014910; x=1702619710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kq9/CzymS2t6cI6IAaf6StcamgWHCvrnQt5+bd0vsJ4=;
        b=C5d+xgNa+bd/wBsXAzgYPwyVmwfbfPYqJyTxOoQHV/imaBbdWWjpFdrSyfw5NIYZzi
         GI8+7ygk5JAA/X+/Q6y+vkMcjHtjh33AJtoNI07auVjS2gZgRNgO6itVBYxOF1NK/tOP
         gSj5m4yNeVVBcw+AbsiZNezvDKQNILD9O34vRXwGAXK3GHguscwrywOIV5Scq5J6hXjq
         Xaqwoq/5bEqwEUFf8DFu6Oe+B2r01CkWN4g3eHMTc+XgXl0ih5SP2/V81W3gVoF6a/d9
         GhY/zAibT/1/b9DydcFVak4NJDD+WKiEgmYdsXmBDNc8H9iw/oImIM8/7o+m/rZmU+84
         DiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014910; x=1702619710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq9/CzymS2t6cI6IAaf6StcamgWHCvrnQt5+bd0vsJ4=;
        b=YfVIoiWX2XcAY45JZy63Y6JrUjmQ+lVIxU+QxEpfYSpPjSBR5VbvnRxn6tQFIf+2T3
         TtwoyTndu9lyozRny6QbFRG8ORLxDBxuJDFuz2pKGxx8s+1uqMYBa2tvcibeeWKkAECY
         upV3zQ1Oc2TnbKya3twatSq3dZECSc3J4x2GV4u/1JLeFrKZtZnYTZ369teSUdej216Z
         iAkfAHrr0XPQFaPj1RzLd4+36W+lbzdQAisGiT0HkWBgoFq4Eb2uhGQEf4TJTkQMQKDv
         6gV9VnIYhMTm9a7maTGG0RsRqENgb7H82krvsGgWsZcVAU4fA7jLeUxElgPCKHeUIbIR
         T2XA==
X-Gm-Message-State: AOJu0YyuO6oYKuCsCN5Vs+cRPWgNKJD83ZYYbNi0A0NLvqS2Uf8VQahC
        C3s65hlD9QCZTt+MWhNN/8je+A==
X-Google-Smtp-Source: AGHT+IHV6F7Dn38rHWvZV+XaXS58Ch7TWuC4F5MVn7OmuYlLci2zlP9Fr0nUwpZzieoBTkpnbrTn6A==
X-Received: by 2002:a17:903:2290:b0:1b8:90bd:d157 with SMTP id b16-20020a170903229000b001b890bdd157mr4496557plh.26.1702014910345;
        Thu, 07 Dec 2023 21:55:10 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:09 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 06/12] LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date:   Thu,  7 Dec 2023 21:54:36 -0800
Message-ID: <20231208055501.2916202-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
asm/fpu.h, so it only needs to add kernel_fpu_available() and export
the CFLAGS adjustments.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/loongarch/Kconfig           | 1 +
 arch/loongarch/Makefile          | 5 ++++-
 arch/loongarch/include/asm/fpu.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ee123820a476..65d4475565b8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -15,6 +15,7 @@ config LOONGARCH
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 204b94b2e6aa..f5c4f7e921db 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -25,6 +25,9 @@ endif
 32bit-emul		= elf32loongarch
 64bit-emul		= elf64loongarch
 
+CC_FLAGS_FPU		:= -mfpu=64
+CC_FLAGS_NO_FPU		:= -msoft-float
+
 ifdef CONFIG_DYNAMIC_FTRACE
 KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
@@ -46,7 +49,7 @@ ld-emul			= $(64bit-emul)
 cflags-y		+= -mabi=lp64s
 endif
 
-cflags-y			+= -pipe -msoft-float
+cflags-y			+= -pipe $(CC_FLAGS_NO_FPU)
 LDFLAGS_vmlinux			+= -static -n -nostdlib
 
 # When the assembler supports explicit relocation hint, we must use it.
diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index c2d8962fda00..3177674228f8 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -21,6 +21,7 @@
 
 struct sigcontext;
 
+#define kernel_fpu_available() cpu_has_fpu
 extern void kernel_fpu_begin(void);
 extern void kernel_fpu_end(void);
 
-- 
2.42.0

