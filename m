Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85137D865E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345521AbjJZQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjJZQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017FD1B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso767653276.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336086; x=1698940886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MozeFj7AsxNvK40iWKEorOKKdXplrF78HG0tGDcuTc0=;
        b=GB4NcKHd4RJL62zGkcpJ37lY5KUvD4GOW6pYjX3nDrxmSSor3nzIAqypIayvUJl7y0
         A26QvGTpRtXeqnhjGFtuaq0s5SGqNdQliEvM5xWsdPb0pLzBWiHtdEy7FKipcsLl08yy
         KAOalrx1/TY4l2KmbZ4uP0jCr1U7N1+qB0EAztxNxAOucRJB+LTj1QsDgTJUgXxx0LKo
         ThKgTITtWUApjAV9oC+l5cqITFStMLFvtqUN24vcjvOexbcNewj8KkZL0qcb6R+2ekFA
         F/VM/H9wMXbTJO6+XhGSeln23aDUCZodiKA8GTLu8/M5EPtLgXaNeQ7C3zYjSr1oCjAl
         axwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336086; x=1698940886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MozeFj7AsxNvK40iWKEorOKKdXplrF78HG0tGDcuTc0=;
        b=AP/6kypU9oCmrS7q+PessGEkd58Idixm0JrTDGE68QW7yTzLxOS0V/AD4zC1fHJ54m
         m/slOIA8bwcnFcivP8snhF8lexipgbiO3+WWUyR/R27EqQpZPEdSAySrITMGbgiVorDT
         cZUSt5DcH0QBD6g3WUG4WsNuDd+bvq0LU7qqeieheeSI4FVL8iS/3rah6cfDRLVRBOOo
         2boZKW7q593zNX/s0q4lU9VGcDBqMOCmSjEMNWIQtooHByCQ9q4M6Kf92bpkhvlBvhf1
         tL9bqYDpaNTPtQ8zwLjyIF0Q4aINv8v0YEmX/4Sr9f/XMnmz2M+CW6Q8MEVtHChGH7B/
         U/KQ==
X-Gm-Message-State: AOJu0Yx56/0Dfmnrbi9tMlYrj6FOn8jWj9oUjAz7k1lEwt7EuNvwDKMd
        jDL2tkfJYWD4HNgVVI8kPerKyQ7G3A==
X-Google-Smtp-Source: AGHT+IEmsuAkaa6JdhdfdGoyhVB6sQ0PzZzoOGMEf4SwzUKMacducUIkEaYetXvcATEXa8eppKFJ0A==
X-Received: by 2002:a05:690c:d96:b0:5a7:aa83:9fb with SMTP id da22-20020a05690c0d9600b005a7aa8309fbmr22744081ywb.0.1698336085720;
        Thu, 26 Oct 2023 09:01:25 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:25 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 01/11] x86/stackprotector/32: Remove stack protector test script
Date:   Thu, 26 Oct 2023 12:00:50 -0400
Message-ID: <20231026160100.195099-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

