Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7B7EC9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjKORhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjKORhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:31 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE81196
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:28 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77891f362cfso95334585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069846; x=1700674646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQoC9i+SJdGrvV/tO6Xn3N5JH39L1Nc9The4vgz1I64=;
        b=f15IXd/ORWdLM5P0ax5IPt5Rn6AAt+VKROAp5rBsKebk7SYsnvto1bsLPDP+NMQdvn
         dM90RUAEtRZ6e4fZm84E1a4Qgy4Z6qeXeuvLu9b9tx1auPq38H9KiXeOI2mr6km4xETg
         QpR+6FSxGWA/01Sieh5rQX5W7Vfl0rgE46MGTIraF0g+qmpZGNW0Dbu7/wtR1NyW2zMy
         zknZ4GmV0kKvi3NCCKsKGtZDQzrwXuvIRth4SG1a2/grOD31SUM7PxnLyGP7tFFtiiNi
         hvwoJ5vb8DH8V7xXDfT0gIvBkjebNZUHycgmLnwJPTjaaJZs+ScVqyTJEy07sn9eM/ek
         jRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069846; x=1700674646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQoC9i+SJdGrvV/tO6Xn3N5JH39L1Nc9The4vgz1I64=;
        b=m+HIuVntOyQA5vSWSmEd9djC8mIMYuubbeZuRwJmpIIdHn5zdiwbV4bIq1j9WA2IUk
         FrSyLcfc/ZnsGV1mcpsZgdGlShc+l13sn8LnPXfp2fO/VEM8Umk/VZ9RAEzl5kEHI0ed
         CN068Hc5io16tcAiHJnVKWsMhpP7tClNLZ4j/UG0C+YdMXhmnysBkwwsnJdQVQycOtOP
         gTqZZ0Ou4nAKFWEoPlPQ7cjhWGzHSjWCjUILmFEx9umzKIEB54N4mb17TO1g8DP5nVqV
         PcXqQe0uOFgC6Z4wb8ErJ+aQXc1NS7jMbtPoNrS5oJnhRdt401bpkVegpQ+1ozcFB/J6
         FkqQ==
X-Gm-Message-State: AOJu0YyjKdN/md5rwFd8cg43Jd4InFLRwmRK2l+G2OG15Atm+5qhe6dI
        3x5MnEpsvoI82FLprgpQyj6lkf415A==
X-Google-Smtp-Source: AGHT+IGMXjNqkuSzjoGvur/XIBWUx1Pyb6YhUOZ6uponQtwlbT8p7gl83U2+dPSqFNHhprGiL3tQdA==
X-Received: by 2002:a05:620a:bd3:b0:778:969e:3a0c with SMTP id s19-20020a05620a0bd300b00778969e3a0cmr8867556qki.27.1700069846651;
        Wed, 15 Nov 2023 09:37:26 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:25 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 02/14] x86/stackprotector/64: Remove stack protector test script
Date:   Wed, 15 Nov 2023 12:36:56 -0500
Message-ID: <20231115173708.108316-3-brgerst@gmail.com>
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

This test for the stack protector was added in 2006 to make sure the
compiler had the PR28281 patch applied.  With GCC 5.1 being the minimum
supported compiler now, it is no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 5 ++---
 scripts/gcc-x86_64-has-stack-protector.sh | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 46c55fd7ca86..a1d2f7fe42bb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,12 +410,11 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
+	default y if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
-	  the compiler produces broken code or if it does not let us control
-	  the segment on 32-bit kernels.
+	  the compiler does not allow control of the segment and symbol.
 
 menu "Processor type and features"
 
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
deleted file mode 100755
index 75e4e22b986a..000000000000
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
-- 
2.41.0

