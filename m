Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE981199A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjLMQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjLMQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:34:45 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7893C8E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:51 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5913b73b53eso1265510eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485290; x=1703090090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyOMuEpj1SBQevcg7f2PgWvrxn60g/AMBaY0W3leFwk=;
        b=m81KjJJ1PWZsp9wAVgDcEHLyEs9BNpTWYX/Q+7NL3kvYFhxl4LXD9nseLsd0NPQGPD
         uJew29+9z06vOUhvMa85+SKKRiF3fD9MQKbdJDlEhiCOE9DH/TYDXdIX2Eft7518eUbd
         2m6+zFjCopTgKWfOoitYLdGnzY8oFyEx0p3OzDrS1PulwVJ2B5fNzANcWyoK0twOn/Qp
         sLsULxYAHy/HnSXXg+EOzy1DRKNNeEunfXowqmw547/k1cFDaGwH6byK5/qo1ikueUKv
         auD/oVRgizQ/Sx8iyxJBonBMCwpJIes5xluw5LysLPnBqy0wy0t12SB9VoJ9KA+mBFLJ
         05Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485290; x=1703090090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyOMuEpj1SBQevcg7f2PgWvrxn60g/AMBaY0W3leFwk=;
        b=YniPh+xF/b8FfsyQBKgm1Q923s82l7e6nIPrnepJHimQ1W7kLVpO4kilFQSU9Hdjlw
         jkwTvxH8n9ZeHwp5mfKBGjYKMRkDqFxCNk5gc6CetfndDNyQr2rMtaiGoHGfGtLHAGkn
         RAYu1OTyB2NiY4Pw8LLRXu8EOnqZzpJdRr+LNpD4uhGH1PkKmYRavRNz3I9uGuK+9mCA
         ybUR8BvJ9EGW2wzoJVAYUzpoWulZPq623uEhBX7p9njY5STgNIZbd8VdPUH7V/Rrud6I
         60lX3Q+8lrUOmCaIymuWrNxNtV925qpTYIWeM+Ax7bLUCYR/cGSPy36ZViuiCf6C7bkB
         /Xnw==
X-Gm-Message-State: AOJu0YzelOIwHadvlbwbIApgDOdCUTzgClbrXWSMH71rwfcyZ2iudoIN
        e2unK9HKBm+9W9QKlfMgXNjpiWPIZQ==
X-Google-Smtp-Source: AGHT+IENdXzRhSAkQMg67rXQcVH/NQuzBUzo/HxGzFnuFmGLQo8CYRySkbZKpCH3LMi1Hml6AdPj+g==
X-Received: by 2002:a4a:ab09:0:b0:590:7382:8b92 with SMTP id i9-20020a4aab09000000b0059073828b92mr4978248oon.11.1702485290439;
        Wed, 13 Dec 2023 08:34:50 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j11-20020a4ad2cb000000b005907ad9f302sm3104901oos.37.2023.12.13.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:34:49 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Brian Gerst <brgerst@gmail.com>, Michal Luczaj <mhal@rbox.co>
Subject: [PATCH 3/3] x86/sigreturn: Reject system segements
Date:   Wed, 13 Dec 2023 11:34:43 -0500
Message-ID: <20231213163443.70490-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213163443.70490-1-brgerst@gmail.com>
References: <20231213163443.70490-1-brgerst@gmail.com>
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

Do not allow system segments (TSS and LDT) from being loaded into segment
registers via sigreturn.  Loading these segments into a segment register
normally results in a general protection fault.  In the case of sigreturn,
setting CS or SS to a system segment will cause IRET to fault.  This
then results in the instruction decoder attempting to use the invalid
segment.  This can be avoided by rejecting system segments in the
sigreturn() syscall.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Reported-By: Michal Luczaj <mhal@rbox.co>
Link: https://lore.kernel.org/lkml/20231206004654.2986026-1-mhal@rbox.co/
---
 arch/x86/kernel/signal_32.c | 4 ++++
 arch/x86/kernel/signal_64.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index c12624bc82a3..0e1926b676b0 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -98,7 +98,11 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 
 	/* Get CS/SS and force CPL3 */
 	regs->cs = sc.cs | 0x03;
+	if (!valid_user_selector(regs->cs))
+		return false;
 	regs->ss = sc.ss | 0x03;
+	if (!valid_user_selector(regs->ss))
+		return false;
 
 	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
 	/* disable syscall checks */
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 23d8aaf8d9fd..666b147bf43a 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -79,7 +79,11 @@ static bool restore_sigcontext(struct pt_regs *regs,
 
 	/* Get CS/SS and force CPL3 */
 	regs->cs = sc.cs | 0x03;
+	if (!valid_user_selector(regs->cs))
+		return false;
 	regs->ss = sc.ss | 0x03;
+	if (!valid_user_selector(regs->ss))
+		return false;
 
 	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
 	/* disable syscall checks */
-- 
2.43.0

