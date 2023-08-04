Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3776FAD4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjHDHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjHDHL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 03:11:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079FF30C4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 00:10:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc3d94d40fso15005915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691133056; x=1691737856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLgqGxCEOJUWYl1HLzDiDyCtuT3vN8bbM1YFd5If7Hk=;
        b=huTaTGCouicXJqoF3OEt6UaDylAOrbKUTRYDM7hccOOkVS8vQFtKchgBM/8pr81TGl
         4xRvendyIemNoWM+VcufHw84hR05Gxlm7QgRIexK1Fcgr5E/tN5IX84CFamvf5CpsVcl
         dItnBo2ldYwo2a3ihnDIW6/30sopoDS2QNH8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691133056; x=1691737856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLgqGxCEOJUWYl1HLzDiDyCtuT3vN8bbM1YFd5If7Hk=;
        b=D7G1IvtsuyCTLJ/OdNoZlNriPkEnOZX+IPdmZaaBHyPEnJGdcwlZMM8kCn5NLs9Dbk
         Nlc3TlHi2EdG4rSP+aNK36qnOcCnpVOa51H/WwDjBNFF2Q2EB6vUytiKOf6c77mqdTmK
         NQ5incAKb9qaivnxcqo/lPpmH+2diAmiPBmZGSk+syphWybD9eiiY0sD4W4+qCjBzIVB
         9x1tYM+ff97h7VrBpW/8zFuCz9QyLZ1HTAutgNLlz9KlNSmcBNdXAilf5CQ/kPPuVhsX
         n6tS1E/SOx/1yKy8w/CfZ9EItS3UqKtWXkkP2lDOn0yIio0DdNsmsqH3N33qS1UHrVx8
         TATw==
X-Gm-Message-State: AOJu0Ywr1nYr7dLJGqmbETDcCxDv1VpX8HovLPD1vVmnz9TmrPZwHdhf
        +5YJWra4sZuvj9nLxynbxJR+DA==
X-Google-Smtp-Source: AGHT+IETdwNZg9gj+A7ervMmpFTsOMlLZiUHM59Tw5IabaPwEazFEscS0doAxstPoxaGixEQ6FiJCg==
X-Received: by 2002:a17:902:d904:b0:1bb:2020:be0d with SMTP id c4-20020a170902d90400b001bb2020be0dmr950403plz.14.1691133056517;
        Fri, 04 Aug 2023 00:10:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b001bb9d6b1baasm1004673plb.198.2023.08.04.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 00:10:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ARM: ptrace: Restore syscall skipping and restart while tracing
Date:   Fri,  4 Aug 2023 00:10:53 -0700
Message-Id: <20230804071045.never.134-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3616; i=keescook@chromium.org;
 h=from:subject:message-id; bh=YJOlkz5vR8N2JtifY2dbTGKNtQ5WuTgnR2Q8FS+sopI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkzKR9I86BSc6Kgktbv/7TDrdJhNiDSv95T3xHY
 eyI/ytlKbuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZMykfQAKCRCJcvTf3G3A
 Jik5D/wJIILgmLRP6PaC7n466O199JDTx/nN4iSx3/PxF6xa5b2VxRNepGSXm+bdcy5M4OqFg3r
 TA1mKMteXSnWTrbT6GiBIpzbb7RZFqHQOobd5wekGbI0n067nE+ORmctWJhm+Ez+ND7kvimDYsA
 m0J22/G7zNs0ra32uU0923Itwf0Ecq3IpRk6/Nq0Thkqs6Ske3CEnT7knCi/TW2wVVRFaYYGBg4
 JRpm78U3nRqxZZKGzRMHXrjS+C0zpxMYb/mAi70Gqst2Cv8SQ6zG+AF+0yXYHtn9nDL6cpYs/zg
 2RJt+z6nn1dc1PjKFW2epvs50HQWpZ6bxr27B9saaxelsggIzQvZiSP3kRP20HiSKuy15PBpfCt
 lPiwqMq/vdC+jkApGPq34GOt5QykWpS6foa957+wSOq8zGbgJ+P6VR9dABq/CWSKdpYo8u8Rq1Q
 QivGh6o9OZTwFFf+tzPyFnrCP8vukNObnld8PCe9Fb2ZReOQa7Q0dce7AWkvt6u0DflPGvGr9NT
 wFVfmqWQUQRZ4u9BQS/OSWloz11A49wuJuNiBnO43ROHdO94wjO1qs4Z5Iz4X4KfaUUsSguYalJ
 H4OwKyvCk8gKBRbgGrvrMqp4nQvKxVditb2rk2EjVJEARIxXoYwJwZEmcJEeKbv2JPCRnqimCs/
 PCY1+m3 4PNLqCLQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store
thread_info->abi_syscall"), the seccomp selftests "syscall_errno",
"syscall_faked", and "syscall_restart" have been broken. This was
related to two issues:

- seccomp and PTRACE depend on using the special value of "-1" for
  skipping syscalls. This value wasn't working because it was getting
  masked by __NR_SYSCALL_MASK in both PTRACE_SET_SYSCALL and
  get_syscall_nr().

- the syscall entry label "local_restart" is used for resuming syscalls
  interrupted by signals, but the updated syscall number (in scno) was
  not being stored in current_thread_info()->abi_syscall, causing traced
  syscall restarting to fail.

Explicitly test for -1 in PTRACE_SET_SYSCALL and get_syscall_nr(),
leaving it exposed when present, allowing tracers to skip syscalls
again.

Move the AEABI-only assignment of current_thread_info()->abi_syscall
after the "local_restart" label to allow tracers to survive syscall
restarting.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 4e57a4ddf6b0 ("ARM: 9107/1: syscall: always store thread_info->abi_syscall")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Note that I haven't tested OABI at all, and AEABI+OABI_COMPAT doesn't
work with seccomp. I booted an AEABI system under AEABI+OABI_COMPAT,
but I wasn't able to test tracing...
---
 arch/arm/include/asm/syscall.h | 3 +++
 arch/arm/kernel/entry-common.S | 5 +++--
 arch/arm/kernel/ptrace.c       | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index dfeed440254a..fe4326d938c1 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -25,6 +25,9 @@ static inline int syscall_get_nr(struct task_struct *task,
 	if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
 		return task_thread_info(task)->abi_syscall;
 
+	if (task_thread_info(task)->abi_syscall == -1)
+		return -1;
+
 	return task_thread_info(task)->abi_syscall & __NR_SYSCALL_MASK;
 }
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index bcc4c9ec3aa4..08bd624e4c6f 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -246,8 +246,6 @@ ENTRY(vector_swi)
 	bic	scno, scno, #0xff000000		@ mask off SWI op-code
 	str	scno, [tsk, #TI_ABI_SYSCALL]
 	eor	scno, scno, #__NR_SYSCALL_BASE	@ check OS number
-#else
-	str	scno, [tsk, #TI_ABI_SYSCALL]
 #endif
 	/*
 	 * Reload the registers that may have been corrupted on entry to
@@ -256,6 +254,9 @@ ENTRY(vector_swi)
  TRACE(	ldmia	sp, {r0 - r3}		)
 
 local_restart:
+#if defined(CONFIG_AEABI) && !defined(CONFIG_OABI_COMPAT)
+	str	scno, [tsk, #TI_ABI_SYSCALL]	@ store scno for syscall restart
+#endif
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 2d8e2516906b..fef32d73f912 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -783,8 +783,9 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 
 		case PTRACE_SET_SYSCALL:
-			task_thread_info(child)->abi_syscall = data &
-							__NR_SYSCALL_MASK;
+			if (data != -1)
+				data &= __NR_SYSCALL_MASK;
+			task_thread_info(child)->abi_syscall = data;
 			ret = 0;
 			break;
 
-- 
2.34.1

