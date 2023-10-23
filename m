Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72757D418F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjJWVRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJWVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:17:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7B10A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5ac376d311aso13125157b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698095858; x=1698700658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MozeFj7AsxNvK40iWKEorOKKdXplrF78HG0tGDcuTc0=;
        b=mPMlRFjRGMnGvJ5YGVNKgI7/9Cpr6OAO30MHnQIFWoZd2kuDqUXTRmwDHeEcVQigBO
         yAsfSXuKXzgkDvhYShOeIZWsMumWvEyBdL6LyEp9IEDIWh2e/FPpDg4LxrN42W1Dlz18
         8fzI2x9YiHlREACG+kd0MjX50JDzEIMhK4D/mEgbM4ZpSbR2Twt+ZRKZKS3glL5+/tbZ
         TfXQSDkz1Va7PjRtWFzvAqevUL77ruiv13S6xVC35rSojFeD9jGsCsKZq6CK4C51o/jo
         3kbWzi7hL/putZTi2jXhfHR5VR9BAD1Kx/qamT2ZLaKPtPuhWPncofhfH70MzLYfJj2n
         v9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095858; x=1698700658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MozeFj7AsxNvK40iWKEorOKKdXplrF78HG0tGDcuTc0=;
        b=kvxcgLelmYj524Jc0UtVc8ly7dEbugsaXsWV1eHKRPcauifU3Vlq/044ifT6spy1g7
         baR0BC7W4FiKdSz3j/f/cG0ThjCHvYSQFF7lKURXyPYO2DV7qw2Y+Dr1perUd9zpYUaz
         wcyzs49q5V27k8JpYMXkLJ1yIhY4GPqDQygAKhA9iiZhi3uGNYj+halpR/h0lFmfl+0R
         0XW2PYSbRH+PxW21MTNrUaTtIZgbtF1LXrvCDEbd4kt4LpVsDrc4Re7X10B1wcut0YOI
         0EwW/nD2pMJbiKyGJJCMh1PjRhu5VLZB+adRoELVIiBAqDuTsGOvoytJ6PukrIc37Yua
         mqcw==
X-Gm-Message-State: AOJu0YzwBbFZ8cXzJTMirdQsT7hQE0u5+WSxfiTgFxXLHaSlh0BHAFQY
        Uozlc+A4pkRPuDdDGEC4zweIZGay+g==
X-Google-Smtp-Source: AGHT+IEuCPqe+IS0hOpSs2Z4PuwRfzAdub62aA+hbQ66+ZzWLjlFzdxQaj9h2Ph3lGDF8pr/8Gd9mg==
X-Received: by 2002:a0d:f741:0:b0:59b:5696:c33 with SMTP id h62-20020a0df741000000b0059b56960c33mr10450976ywf.46.1698095857963;
        Mon, 23 Oct 2023 14:17:37 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o139-20020a0dcc91000000b00583e52232f1sm3485430ywd.112.2023.10.23.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:17:37 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/9] x86/stackprotector/32: Remove stack protector test script
Date:   Mon, 23 Oct 2023 17:17:22 -0400
Message-ID: <20231023211730.40566-2-brgerst@gmail.com>
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

Test for compiler support directly in Kconfig.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 2 +-
 scripts/gcc-x86_32-has-stack-protector.sh | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5ef081aa12ac..039872be1630 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -411,7 +411,7 @@ config PGTABLE_LEVELS
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC) $(CLANG_FLAGS))
+	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
 	  the compiler produces broken code or if it does not let us control
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
deleted file mode 100755
index 825c75c5b715..000000000000
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# This requires GCC 8.1 or better.  Specifically, we require
-# -mstack-protector-guard-reg, added by
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
-- 
2.41.0

