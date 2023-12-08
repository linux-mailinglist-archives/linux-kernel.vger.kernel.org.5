Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE244809BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573195AbjLHFzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjLHFzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:55:00 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29AC1727
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:55:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so1136192b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014904; x=1702619704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT/f+zG+eBk9GDNM3PRDRS7FWs4vWVwDUJpda1v2enk=;
        b=Dk8xWHfZUEGYbcq4rBFQOt5NQX1WON5x0U03CMOa1gXwmiOHsQ1+cjsCrw58iIsRMg
         IKnXNYpyf6ARFQkPvi9k/8Xcmp4eSXf83/eKRPBJTAxyuhx/Jk1eKduJ6mcQ3OH6cCP8
         eFi6iM35kXFxXlsKMAWkmXDWbgXm9p7UYUZE7Ha8n4gWb7q/ZSvuJthn8sojYk38IOMK
         9ybjvw9uSUar+rl1fer5qNtkEPSVoKyeidlKAPogOFxNC9JgTf81nyLr1Wg1SR1AOtas
         xVW1CVKp2r6T916J6rhLHiclSqifFTC5LJJ0Z0NZpMFHTIZzFxVnBRMhcs0HmWRvpAyB
         ynew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014904; x=1702619704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cT/f+zG+eBk9GDNM3PRDRS7FWs4vWVwDUJpda1v2enk=;
        b=HMnwudvKPgSct+iSm5r6xuCgajztDuhOB6dZ3b2CyGifmjPWuQeQegQ/ZP8fD5p6XG
         t84dlLr4B3jMXI/lbSO2RXRLy3RzMoo/PBAwyOzbapsBFTg0DJuyglYG5XmRBbexlRTQ
         Cm6DvqXLKG20NFR7bntNpcdgR1WsjmmeFvSL+inMkJlAJ5AjB7G56MXDZnLOqhFYIGo0
         pDsaUl12+XL9xpZClHERcJ9CqmMqTtBrRXXCy7GgvpfUcPYrEH7HDjeQ2hCY/CC5dHjY
         TqQ+Hw0lIA18Zq++SK+XLsTa/vmiWwGkwmU5RBpH8NJFnmiOMLcla22Nt8VEPnd370vk
         LLYQ==
X-Gm-Message-State: AOJu0YyH5T3Efsr8K7MAEGGeG0jYaXyh3zJBp/i7ainyWanUwo4qoDaf
        LhOWnYTggcoEHwiCgBBKEWYq+g==
X-Google-Smtp-Source: AGHT+IHjHZOPQupU2gBIY1LJy6ZLE2Spe4muScdMLjHj9er/qEsoCLB+Of3eLXhwYzBMH5NUihe96w==
X-Received: by 2002:a05:6a20:160a:b0:190:14d9:4797 with SMTP id l10-20020a056a20160a00b0019014d94797mr1355279pzj.4.1702014904099;
        Thu, 07 Dec 2023 21:55:04 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:03 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 01/12] arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
Date:   Thu,  7 Dec 2023 21:54:31 -0800
Message-ID: <20231208055501.2916202-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
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

Several architectures provide an API to enable the FPU and run
floating-point SIMD code in kernel space. However, the function names,
header locations, and semantics are inconsistent across architectures,
and FPU support may be gated behind other Kconfig options.

Provide a standard way for architectures to declare that kernel space
FPU support is available. Architectures selecting this option must
implement what is currently the most common API (kernel_fpu_begin() and
kernel_fpu_end(), plus a new function kernel_fpu_available()) and
provide the appropriate CFLAGS for compiling floating-point C code.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Makefile     | 4 ++++
 arch/Kconfig | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 511b5616aa41..e65c186cf2c9 100644
--- a/Makefile
+++ b/Makefile
@@ -969,6 +969,10 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
 
+# Architectures can define flags to add/remove for floating-point support
+export CC_FLAGS_FPU
+export CC_FLAGS_NO_FPU
+
 ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
 KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..6df834e18e9c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1478,6 +1478,15 @@ config ARCH_HAS_NONLEAF_PMD_YOUNG
 	  address translations. Page table walkers that clear the accessed bit
 	  may use this capability to reduce their search space.
 
+config ARCH_HAS_KERNEL_FPU_SUPPORT
+	bool
+	help
+	  An architecture should select this option if it supports running
+	  floating-point code in kernel space. It must export the functions
+	  kernel_fpu_available(), kernel_fpu_begin(), and kernel_fpu_end() from
+	  <asm/fpu.h>, and define CC_FLAGS_FPU and/or CC_FLAGS_NO_FPU as
+	  necessary in its Makefile.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
-- 
2.42.0

