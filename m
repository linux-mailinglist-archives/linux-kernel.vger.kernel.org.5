Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24187D4196
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjJWVSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjJWVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:53 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36A510DD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7afd45199so39490117b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095865; x=1698700665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b6n2hqqBemYL89ZXVDSUOUI69G9HFJxSx2FZy1kuzU=;
        b=giHvaqdde3hdtFYvqMzTd/cxO2SQJun+/TVVAOSrBGnOzVvF1JIpaint6Wg4wOd5ux
         s8W4FvMWaaRGLF/vI9W91sMQh3mkxN7tYodk1Om9tRsNaMJ5Ej/mldahEsKq7hRl+pQT
         B2Ob1z/IOJAbC0kIbIJsrHy4rFAhd84WL6VpsXe/TUZNqwQPyrrwZAymQxhJEDjSAZZS
         U7kz1Ox3g5v+Qtx1wOakEOvR2wE2sLIyOAGmgCksooZyb6Xpy/T/F/ZdclDO1PZr/G44
         jmXKVe6x4C9GlNhFJkillowng/+7Hka6z+/5bh3gbUzGFK0jbVZtAXgbaWXUrl8CpgHW
         bxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095865; x=1698700665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b6n2hqqBemYL89ZXVDSUOUI69G9HFJxSx2FZy1kuzU=;
        b=iNWKNjcp6P0yi1IcXtIWUlBLpCH/N1/DivR4qB0EibSroCweaZRm6cSB4P5eDDmkpB
         8TkXhD4vkBleoOlOMAr3qG0WxhBcPRo8TBc5ehrSZ49Il6ZE5AxfbDaKE93cJ1+XmLjt
         gyKwSSGLYSffQJp6bUwOYNWxnbcMiwIPYxncz5z+cUh6jL/2Taatq1YmtY7DHVePeyLQ
         /SvqvLkXwTCcPEWRmH7X+Z0rh/jBILxlmg9alMLccURkG57Z7MSz7e56G+bUxSvidbOJ
         /UNq+58cMDIqHFfgHouw7WA0A8qKe23tFvOw8AUssjehH6Rz8i0kn7ELeOfVp6W691cf
         VBrA==
X-Gm-Message-State: AOJu0YypOw9IeOsNhGKlv7MBXAbP2BCpoN1XCt9IPg3NWWVHF9LhDBg+
        VeUOam+h7H1ZaqnPQnwD7GHCbpLIZw==
X-Google-Smtp-Source: AGHT+IG+aeGUHUOhVtMNeNYEEFrkwPYSqyTC9NizN8DFd46tHDqRUwA/QgwvVV+81+PgLjMTzjnDlw==
X-Received: by 2002:a81:5216:0:b0:58e:a9d3:bf98 with SMTP id g22-20020a815216000000b0058ea9d3bf98mr11236696ywb.27.1698095865584;
        Mon, 23 Oct 2023 14:17:45 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:45 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 8/9] percpu: Remove PER_CPU_FIRST_SECTION
Date:   Mon, 23 Oct 2023 17:17:29 -0400
Message-ID: <20231023211730.40566-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023211730.40566-1-brgerst@gmail.com>
References: <20231023211730.40566-1-brgerst@gmail.com>
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

