Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5E75CD6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGUQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjGUQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748912726
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:45 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4039f7e1d3aso17432721cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955844; x=1690560644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjiy+RZzhIETh3eDrX+VMpaBXAb3ySzD13mUYqdBjXY=;
        b=pBsh1Da+bk04OLuUyhhlN/h5LJWYOgP9+z1lNk/rsHS7ZZOT+N/PriVaizlB0sHCAI
         ec7NWcYEeAKLg9cKgMyUwEZiE6Aq2+LFWRUfGngrJS0A0Atal032dkqCOakPbSHoNKIW
         H8YMcUlTK2b8sqg8tCJOCZzW4QQ+3A2rxqvVa8YoNvyxkODDClEUo/06mV1v+Pu10NGm
         7cqVhpCPWuj39FFW20hchaBnHx/Yvd8UnVrhqBu+sX2ddNAy0gBFjTkOxF1ysxfC6FAi
         SYmPDUgdk62d2pVR3k2YLDH1WfX2FrXZVsjCjHlrdMhoB4f6RTvBICAv8RDR7LNn9zAt
         t2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955844; x=1690560644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjiy+RZzhIETh3eDrX+VMpaBXAb3ySzD13mUYqdBjXY=;
        b=gWhnOEvSO7Q1WnMQ5UQV7aIGNO1M1dPDVu1pUD6D6Uy+GK2kqn+JqM5IlyYfrsr5t8
         4KMKERmWWBg1a9dg2YGL41P0GW/+le4hRzJ8aAG44zT7hGXevN4tydIt2I3AGjXK+Umh
         1qirKJrC4oLyrxTFT3EMNaMYh9UdNhXif42WIHIXK+0yIa/mrvnEh6jAGGGXDxStbvUl
         y9ot7vgHuGdccSeAzDCBA7pe+Q80KQ0jOUA7OtbOzsUujb9IU1KBAiw0N27vIrKorEFv
         MrV6DZGfE9gZTBdfUM+9lMEEb9qp0F4iw2bDPOnl1I90oTeUM4C9nol8EnhIXNGwmwth
         kHpw==
X-Gm-Message-State: ABy/qLZN1sTo64armZD7SpzpAY+K6JfOis/RCL58NpbXqbzp0XspLIyp
        VBc11nEebATqobAGGAQ4KQXz+8Nrww==
X-Google-Smtp-Source: APBJJlEPqIU09qw9n9rZaYvWnsygWXNlRJUpH0d07XeqiASOwHj5W665dA614dIGZf4VfQj4JOxH0Q==
X-Received: by 2002:a05:622a:184:b0:403:cb17:c108 with SMTP id s4-20020a05622a018400b00403cb17c108mr680402qtw.24.1689955843960;
        Fri, 21 Jul 2023 09:10:43 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b004054fbf9273sm311286qtd.80.2023.07.21.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:10:43 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 3/6] x86/entry/compat: Combine return value test from syscall handler
Date:   Fri, 21 Jul 2023 12:10:14 -0400
Message-ID: <20230721161018.50214-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721161018.50214-1-brgerst@gmail.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
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

