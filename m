Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B569800660
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjLAI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:57:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094E84
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:57:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b427507b7so13989265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701421050; x=1702025850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEz57f4iqZ5wbUjNIKafkeeRwZy5R/glhsL5WersMuc=;
        b=VmVGpAenl2ZnMeQH0YDZPhI4A5/3waD5jgiMJB7rl9re+V6QIFs2Td4C8XB94OiYti
         ho6Gc3cnRQqsW+5I2lxDU1RN8paq4QR7A5EtUZm/v1FF1v1B9IeNE2W9/fZJL0g7PCr+
         iIfnh1qU8QYziyEFzrRGqtd3BPJQVDaLS/V0IXXvj3xa00AOur3cZJan17o/R+rf0+Y2
         50M2pXWtU2Z5D0iVF36GzkmuVkMEPA1jFHNAotqJ1z5BIVUNN1e1EGGJWMxllnUpT+FE
         +IUROs+B0PmwIbDInKsbq6C7fTamjbaKgIZHQ9/9IfzTD+8TeEI/5LRSODdbpyqLn7a3
         q6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421050; x=1702025850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEz57f4iqZ5wbUjNIKafkeeRwZy5R/glhsL5WersMuc=;
        b=SMpz2O6fkqA7xtCn7Rr8UJgnmpjKd6xSYyHb9csdEzHl5Mv1IrSGBHOt25ChvDmXrE
         pYmpQycaAUkQaeuMZ5ZnEzcSQ8/VGPcYvG7A4gx8OrQrGcAcZQEk6aKp7C2Bv/97hi6b
         mHLE8eU9URW3qz8bcVh8dmh/z00ONmASY7pl6dZLYVQCt7aF4sr8sdWOQqm1OvWXIK3e
         2aJhXQHFh/AS6uD4UJ0fclaUQaeqOTMFJMol2q4Wy/ytgd9V5ms2gwH7z/SKjyre19/5
         fQxQERnfMezjodUELAxpElRBL6m12Fgne6kWZAMO2bpMUBP56zBH4tOwzvsv+WyhpDG3
         polA==
X-Gm-Message-State: AOJu0YybeTSDM/yA+JRsV5ymLolCf2XobJnR0ZM69gN8YZRO4cDjMl4O
        2TYme6yWloGrsPMAuDtTWqY=
X-Google-Smtp-Source: AGHT+IFATjIq+Oq77UCymcOdvjYh4ZHRCZNif812JukWqyzxSmhzKo6xnUC3RP2OGuyD+FwSuw2jsA==
X-Received: by 2002:a05:600c:a2a2:b0:40b:5e59:b7d9 with SMTP id hu34-20020a05600ca2a200b0040b5e59b7d9mr245294wmb.182.1701421050257;
        Fri, 01 Dec 2023 00:57:30 -0800 (PST)
Received: from localhost.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id je18-20020a05600c1f9200b003feea62440bsm4753894wmb.43.2023.12.01.00.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:57:30 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/callthunks: Correct calculation of dest address in is_callthunk()
Date:   Fri,  1 Dec 2023 09:57:27 +0100
Message-Id: <20231201085727.3647051-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.31.1
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

GCC didn't warn on the invalid use of relocation destination
pointer, so the calculated destination value was applied to
the uninitialized pointer location in error.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/lkml/20231201035457.GA321497@dev-arch.thelio-3990X/
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/callthunks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index f5507c95e7be..c561dd481eb9 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -306,7 +306,7 @@ static bool is_callthunk(void *addr)
 	if (!thunks_initialized || skip_addr((void *)dest))
 		return false;
 
-	*pad = dest - tmpl_size;
+	pad = (void *)(dest - tmpl_size);
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
 	apply_relocation(insn_buff, tmpl_size, pad,
-- 
2.31.1

