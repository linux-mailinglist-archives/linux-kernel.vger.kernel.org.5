Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194817D8667
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345614AbjJZQCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbjJZQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:02:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7CBD59
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8628e54d4so9761417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336096; x=1698940896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b6n2hqqBemYL89ZXVDSUOUI69G9HFJxSx2FZy1kuzU=;
        b=d8vLPhX0Xan4gRYruPzX6i0hYvrmS/wY231LQBpNO8xt1tis34AFmiG1X/4tJNpP0j
         w/O2+irKWJo9TnzXT1kDudUg5UlcePeUN0sg01qXwDw9I4DbYg081yPEg/sIUpOBZbVP
         970Q5SYqKIT7LLukSxN8Ra+H6JDNSny9ZNkcrE6RSAewW7FEYCI6aokx2rXtj3OsHjSG
         kVvPF+jHfpJHjR+D55YljR8W7stH/I/aUfBM7OP+DcoSEmp/LsTKgGBcIyYw6zIO7XRw
         yUhV8DDxhPKBKGyJvUfloXKYMFW//pa5J/7Q3w4wKfx3whfmChsaE3+Cx3uI3ZTQqC+d
         512w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336096; x=1698940896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b6n2hqqBemYL89ZXVDSUOUI69G9HFJxSx2FZy1kuzU=;
        b=hjDCqpi/FGkHwDfDEmA1MpiQu17N8JDlyqP9wDi7ERng4MEXEqWF39trWz4pSPSzqc
         otRnRthfL2Eu//VP3VhUODHEaiJRDI/MQTu0La0mgD2xrqzGYHJ/g7XCX/kc6CpLCp25
         vWvgj7BXCHsPOmdc/DaF3o4tDnlJOnmAJXt2hRqHiqOPoZ8ORTgiUSdfP11nCZZOo0OE
         8mDaSvNisTrzHruvVKfCcEXGYzcTUML0aLNYqiPITsi/Dagcn+z7Eqbl0+do6UDz0O1c
         shEvoZonmk4vf+rvlByNT0biy4IRxlVn+zhJtfZLvse1mGKXHE7oQSHynMFPwBvJoH5A
         TQtA==
X-Gm-Message-State: AOJu0Yy4LE1JBqwlXfJLpWjPmAT6QhQIjisdPUp9HDOS8DEci8Cfa9cq
        WJgA8JSQRzWVW1kafssJ9WX0Y84zwA==
X-Google-Smtp-Source: AGHT+IF52EUeI+1nimgxqGIaY1v2WJjReSyg/UHNuouVeY2BPi7knjSy2u6C/z3fZYbO/fZHp1AswA==
X-Received: by 2002:a81:aa48:0:b0:59f:699b:c3b3 with SMTP id z8-20020a81aa48000000b0059f699bc3b3mr5147764ywk.0.1698336095705;
        Thu, 26 Oct 2023 09:01:35 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:35 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 10/11] percpu: Remove PER_CPU_FIRST_SECTION
Date:   Thu, 26 Oct 2023 12:00:59 -0400
Message-ID: <20231026160100.195099-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  1 -
 include/linux/percpu-defs.h       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 67d8dd2f1bde..23d8acc72760 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1032,7 +1032,6 @@
  */
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
-	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index ec3573119923..b9ddee91e6c7 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -26,13 +26,11 @@
 #define PER_CPU_SHARED_ALIGNED_SECTION "..shared_aligned"
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
 #endif
-#define PER_CPU_FIRST_SECTION "..first"
 
 #else
 
 #define PER_CPU_SHARED_ALIGNED_SECTION ""
 #define PER_CPU_ALIGNED_SECTION "..shared_aligned"
-#define PER_CPU_FIRST_SECTION ""
 
 #endif
 
@@ -114,16 +112,6 @@
 #define DEFINE_PER_CPU(type, name)					\
 	DEFINE_PER_CPU_SECTION(type, name, "")
 
-/*
- * Declaration/definition used for per-CPU variables that must come first in
- * the set of variables.
- */
-#define DECLARE_PER_CPU_FIRST(type, name)				\
-	DECLARE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
-#define DEFINE_PER_CPU_FIRST(type, name)				\
-	DEFINE_PER_CPU_SECTION(type, name, PER_CPU_FIRST_SECTION)
-
 /*
  * Declaration/definition used for per-CPU variables that must be cacheline
  * aligned under SMP conditions so that, whilst a particular instance of the
-- 
2.41.0

