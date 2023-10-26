Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98A7D865F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345516AbjJZQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjJZQBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 12:01:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5671BC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:27 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7a80a96dbso19652607b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698336087; x=1698940887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Eshj9ssogtik9Akv+/0p6H72PveiCEWZM0GK4P1lOg=;
        b=OkoLIX6XzzwhgdyCMTG8iAGU4SqCs2PwRyw1wQB8sCZy4e95zRwjuUQNSi54YnyWuD
         Y3IolT3RkKI+O91OQigu44miZGubYjv+lmuyJb9sVhvDXTptjNNJKz/JMY6FhTD6RWAh
         04lzE9ubTByYfpDgbWzSBIVLzgsXYKna/llX5aK5VizkyE7jq5yZ+9i42k7wDAqX50wl
         vm3tjOnOwsQA3z9wdYXQUemp3WFo2yHCizfUTbdflsGWhsX5+VyuPY9CurXFPLaAZMVq
         xKlHKgewqhj3Mu5vz8gYZv2GFC38Bssv0BNTx1pxupw6iFwwCCRBVPtle86jmJb+OW20
         7CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698336087; x=1698940887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Eshj9ssogtik9Akv+/0p6H72PveiCEWZM0GK4P1lOg=;
        b=b6HLkGFeV9ij+DXxydy/R3nVbHSXqgCGgPh4/4Cmk/fJdf9i0KmpbOAwcnkG3yg8Ha
         VC/InkBXQWMdwgM7+L5NGW2sl0IaH0RT/3pMBNd51rK8LSTK5qmp/kJKGp9xBWZkznmt
         frLYymDAVEyXEtr+OWLtVa3slQ/vlSvaWcK5Or8QbFHSWBF9HG8SyKtd6e+a4BvVE960
         umdylS8UKYBuo7DV9kyVXpUZ3njU7t2YYkYQsECfsh9rrloJJplyn8QCeXSXbrrN4Xdr
         Ing2IZEmQu3X0WTgpbLMXUZUQVE6kpju0g5yJWn7dAyHeUafs/HFRUivfhyBkVJRktkH
         dSxA==
X-Gm-Message-State: AOJu0YxtuTkRupIINveIY0JjxKGSun2J6RocivbsXVE+BoVqVeQI2Q0f
        AMCFLp4cOHdF+Ti5njOY0Q4bYZHBbg==
X-Google-Smtp-Source: AGHT+IHa3Vr8CD7ZclnSSB9PHvuGUnCTqXc8HcuAAe1VrmExkaFMqNkbfeyFMNJZPgfkSZ8BFrNDFA==
X-Received: by 2002:a05:690c:708:b0:5a7:b53a:3223 with SMTP id bs8-20020a05690c070800b005a7b53a3223mr5207193ywb.21.1698336086730;
        Thu, 26 Oct 2023 09:01:26 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id a71-20020a0dd84a000000b005a20ab8a184sm6130129ywe.31.2023.10.26.09.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:01:26 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 02/11] x86/stackprotector/64: Remove stack protector test script
Date:   Thu, 26 Oct 2023 12:00:51 -0400
Message-ID: <20231026160100.195099-3-brgerst@gmail.com>
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

This test for the stack protector was added in 2006 to make sure the
compiler had the PR28281 patch applied.  With GCC 5.1 being the minimum
supported compiler now, it is no longer necessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/Kconfig                          | 2 +-
 scripts/gcc-x86_64-has-stack-protector.sh | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)
 delete mode 100755 scripts/gcc-x86_64-has-stack-protector.sh

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 039872be1630..92144c6f26d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,7 +410,7 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
+	default y if 64BIT
 	default $(cc-option,-mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard)
 	help
 	  We have to make sure stack protector is unconditionally disabled if
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

