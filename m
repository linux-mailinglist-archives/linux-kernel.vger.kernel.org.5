Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357AF7EC9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjKORhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjKORha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:30 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BD83
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:26 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77a277eb084so456483885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069845; x=1700674645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M04sUMEmylKhcxCvp1sLw6caUnGoADRX8jt4cdDowFM=;
        b=G8GbXkxnIRiQD1WtTb9sJV81aEwsEtbcJXXPVw16DZrQmZYO0OmIHbvyhBcDfjViSI
         2i85+lhcunNYFRC3HUmQa+NwUFS9fI1C9ThowM0MDASDFs3HTLUFdfxuh6SpeB/UW1Pg
         tQgeEOXPVMl2cl5Pc859wHSWZ2GlREWZSKzTEgpdbZmMPWCl3PhMtKOJ5C+P2eBgZ+/s
         NKmMICZ9zfgiK9ebVbQIytyrys1Gz4lKMze6ZIf0xcE6lxpCLwtuzfJnSRixIh0eNABd
         rhKRrIZPA96q937ByzRy6wQ8WpbvWNjqdUMN4dWKmtXHCfQKNdb4x5TEW7rqxIYYqXap
         oCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069845; x=1700674645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M04sUMEmylKhcxCvp1sLw6caUnGoADRX8jt4cdDowFM=;
        b=TX7CRToV6Z/0Gjl65/bmI0g0H9oTFa3uhlpDsw2EGXO14SX1lcr/DOosN91TV9qCMr
         SKZNIxVfFB6vBmjBiXBZ+TcRmlMlxUJniSDW6EfvFi12TDCD4OK27rCaHLCFJpLWSXQV
         y4pHeyLIGiArKsA1KpkfpkaF8ilPqS4cKQGvUDs//TB8Qv63y9n/YQLUsdQ0R3wkHvzc
         yB1v0KFY08RtfGZvbgoA53lEjb0v4o85/UzqTC3CiWQX6FXeDmmjx/jIN6noNGz17bM2
         Hfr8wyVA/g38AH0YYAVjgl+EtogrJ+pH3SkUZN1rGM4fODOQmRKaCk9M67pBhw89f+cY
         QOvQ==
X-Gm-Message-State: AOJu0YwR2Pqyo7X8ZguUwEhXWH+HmV0SijKq5dnYlljlf5w0Iye7ZBMi
        /GSjQZXj1NLpoLEmace2lljPj1dPfg==
X-Google-Smtp-Source: AGHT+IGv/GvoH+u6ZPMC5Nk6aJ8mdZ5hpmFr7IUe4AjU06WSnBNR6QJDQGYlfcnMjmOcHTogaHrJYA==
X-Received: by 2002:a05:620a:38c7:b0:778:ba73:1650 with SMTP id qq7-20020a05620a38c700b00778ba731650mr4745937qkn.30.1700069845162;
        Wed, 15 Nov 2023 09:37:25 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:24 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 01/14] x86/stackprotector/32: Remove stack protector test script
Date:   Wed, 15 Nov 2023 12:36:55 -0500
Message-ID: <20231115173708.108316-2-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
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

Test for compiler support directly in Kconfig.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 2 +-
 scripts/gcc-x86_32-has-stack-protector.sh | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)
 delete mode 100755 scripts/gcc-x86_32-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 882b11eccbb3..46c55fd7ca86 100644
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

