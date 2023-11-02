Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C77DF123
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376272AbjKBL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjKBL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:29:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93093131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:29:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d58b3efbso464807f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698924543; x=1699529343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK9f/0DyWoovHMW6tPJeem6iX8A0uEcMjFuwkUDDCuM=;
        b=Ab/KOJpQwGaxoUiUb8senjwYjA7Qkzd6BAtIQkeTbwMIGyayD9csK9X+QmFG1/H+D4
         75v1KAFY/7WVX9isuTarnUdFIg0NyjJ16GcZHiA3dNi/jIZGPPeyR+A/mxEhvCUQDZm5
         H3Kcy4091V9U3USTHPvVJE/zVC8ZqcIGclUHuujqwYT8WVUE3aOHA7mUknQGZYRzRZss
         epsw6wOx1Yzk9y2zZZr+f3UrTHS8zVl2X3bJSfwo1UOuaj493D9UAeMYl/vWPC98HJss
         yMlegsJbDFzc7Zf6O8rPvqQxS9d64ZOZQgvIuDsAo3wY1SfUTs3si0XAUprciEYT/Kxg
         v/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698924543; x=1699529343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nK9f/0DyWoovHMW6tPJeem6iX8A0uEcMjFuwkUDDCuM=;
        b=JGMn1A3XZ9zxIh8qCX8eQxZZb6bNihbz7yu8aHQkkN4k/TTeXEmDcgPB2UAkFbo0JQ
         ZO2IEmCd1mUGpWwel00hkom2VWtP0RkGENUUrDA8edLOANmS7L322xDFlLzZdVIVyW4R
         L072+vXRJN4V5+TNDniSgLlNBf6XI++STGthLgDpVuM+eCE90EEDDKxWPvcEWesZ+wxh
         wsquh8eCDQBv3BFM4uiDKt7PHW1ejZqIC7n4Ua/q2tQzehr5F1NGPN/Cs5xjqbn54ZoV
         yXzFgFfGhBtoSv7uPrkI9vlUE182eJaxCXyZFaz3hEpSonop9F6mzPbRoC4TB+POD7yR
         /pPQ==
X-Gm-Message-State: AOJu0YxWvm9bK5xME8ydV90O4BIiWAdokisHSMI507fDjk1GvI/XK4Xl
        e24GbwiJhfhE+1YirwzuQ9A=
X-Google-Smtp-Source: AGHT+IEy8/D8BKIcTWAHmXk2m6V5ixzICj5Yq8nTO4nn5gpqYSz5QdxR3dN/9kGA2hPh0HnHh8LwYg==
X-Received: by 2002:adf:f646:0:b0:31f:db1b:7296 with SMTP id x6-20020adff646000000b0031fdb1b7296mr11670913wrp.21.1698924542495;
        Thu, 02 Nov 2023 04:29:02 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d4f8a000000b003232f167df5sm2168227wru.108.2023.11.02.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 04:29:02 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] x86/callthunks: Move call thunk template to .S file
Date:   Thu,  2 Nov 2023 12:25:46 +0100
Message-ID: <20231102112850.3448745-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102112850.3448745-1-ubizjak@gmail.com>
References: <20231102112850.3448745-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently INCREMENT_CALL_DEPTH explicitly defines %gs: segment
register prefix for its percpu variable. This is not compatible
with !CONFIG_SMP, which requires non-prefixed percpu variables.

Move call thunk template to its own callthunks-tmpl.S assembly file
where PER_CPU_VAR macro from percpu.h can be used to conditionally
use %gs: segment register prefix, depending on CONFIG_SMP.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/Makefile          |  2 +-
 arch/x86/kernel/callthunks-tmpl.S | 11 +++++++++++
 arch/x86/kernel/callthunks.c      | 10 ----------
 3 files changed, 12 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/kernel/callthunks-tmpl.S

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3269a0e23d3a..6b6b68ef4c3b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -143,7 +143,7 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
-obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
+obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o callthunks-tmpl.o
 
 obj-$(CONFIG_X86_CET)			+= cet.o
 
diff --git a/arch/x86/kernel/callthunks-tmpl.S b/arch/x86/kernel/callthunks-tmpl.S
new file mode 100644
index 000000000000..e82c473bd1b1
--- /dev/null
+++ b/arch/x86/kernel/callthunks-tmpl.S
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <asm/nospec-branch.h>
+
+	.section .rodata
+	.global skl_call_thunk_template
+	.global skl_call_thunk_tail
+
+skl_call_thunk_template:
+	INCREMENT_CALL_DEPTH
+skl_call_thunk_tail:
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e9ad518a5003..d0922cf94c90 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -62,16 +62,6 @@ static const struct core_text builtin_coretext = {
 	.name = "builtin",
 };
 
-asm (
-	".pushsection .rodata				\n"
-	".global skl_call_thunk_template		\n"
-	"skl_call_thunk_template:			\n"
-		__stringify(INCREMENT_CALL_DEPTH)"	\n"
-	".global skl_call_thunk_tail			\n"
-	"skl_call_thunk_tail:				\n"
-	".popsection					\n"
-);
-
 extern u8 skl_call_thunk_template[];
 extern u8 skl_call_thunk_tail[];
 
-- 
2.41.0

