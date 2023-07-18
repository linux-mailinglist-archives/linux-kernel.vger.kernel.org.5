Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C95757E05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGRNpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjGRNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:08 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1DEA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:02 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1b0606bee45so4444879fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687901; x=1692279901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjiy+RZzhIETh3eDrX+VMpaBXAb3ySzD13mUYqdBjXY=;
        b=g+sYUxKzTb++c6teRndf67/J+dzoTsMqnhAxJxdpRybA10LSWB8nV2KaAWKjwdytiI
         Qq0y7I5NnojxL/CQj0sVI+h1EQ8VF0ckGo5yySR0B5VeX+B/JEDkHxkMYktU488yKbFB
         +a0vioe8dDWbOZZPU+Za0o8GgJo2/ac2HesxJAyUj+oK+J3jhuc1vHe0f1KoxprPgTfg
         i2E+7G7uEETjxA/Wt98brLVjOVBLz9muSnbIORuriSZSxdaekBkl+iQWox7HqUiAOJUf
         vBnMSKaoAJyWL4r/jgI8wh/O0MK9e+Nt9dCd427qf8VrRC9A/cLCA7PKtMlWer3CZBCI
         BlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687901; x=1692279901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjiy+RZzhIETh3eDrX+VMpaBXAb3ySzD13mUYqdBjXY=;
        b=ILOK0odIEelaK3TZCMLeTLdO4DIUGQ0alTmWoBp07MXF8+B3Rgzi9ttxe5yu8Bx9Qi
         dhMbQVw71wfDLGjYiXvuFmYNVJldRZC/6ZEpN+wcu7K2wxINnIdR0YJCVpdRyHz14/FD
         2ntTgAwpNi7tpKeo9jsxx3i95xKXsEtYNybsOK3dV6q7mWNf1teB8hsTACFgYYJ7/Sp6
         5zvwOvQEWi3SRCa417x1L7Wgysad6REFnvEhiwvekksFng+nb6hQkk4CJ5bKGux8XnqB
         Rb+hyjex6+o6ZvvvAQKlrEThcYYQwK3tzqIx8SRFhcYU1fMOCTtpLRGXQng+y9OlDCfg
         PD5g==
X-Gm-Message-State: ABy/qLbtEqEaFXZ654hcjChrpT45t5QS54dZ4VyfUtIzV60po5awA16T
        LAzxy+yWzWWBUWphqjzO8U0I/RZqaA==
X-Google-Smtp-Source: APBJJlH1B9L2R6oy0FxumtXqvegIURkv3Sn99fjw3Ib62L06dlyaTN3r07/P7Dg72RjO+GKx+UQydQ==
X-Received: by 2002:a05:6870:3307:b0:1b0:b15:245 with SMTP id x7-20020a056870330700b001b00b150245mr3032884oae.16.1689687901411;
        Tue, 18 Jul 2023 06:45:01 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:45:00 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/6] x86/entry/compat: Combine return value test from syscall handler
Date:   Tue, 18 Jul 2023 09:44:43 -0400
Message-ID: <20230718134446.168654-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718134446.168654-1-brgerst@gmail.com>
References: <20230718134446.168654-1-brgerst@gmail.com>
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

Move the sysret32_from_system_call label to remove a duplicate test of
the return value from the syscall handler.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_64_compat.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 70150298f8bd..b16272395f1a 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -118,9 +118,6 @@ SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 
 	movq	%rsp, %rdi
 	call	do_SYSENTER_32
-	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
-		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -212,13 +209,15 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
+
+sysret32_from_system_call:
 	/* XEN PV guests always use IRET path */
 	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
-	/* Opportunistic SYSRET */
-sysret32_from_system_call:
 	/*
+	 * Opportunistic SYSRET
+	 *
 	 * We are not going to return to userspace from the trampoline
 	 * stack. So let's erase the thread stack right now.
 	 */
-- 
2.41.0

