Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08630757E07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjGRNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjGRNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:08 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409B13D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:06 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b9c9089d01so1621491a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687904; x=1692279904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhx7ZNTqJJ5S4apOkLmOT04A37Dl3XYqjJCOeSe5i6M=;
        b=ac/UA9oQieeU7aKWTU7r/VlMO91BsBamlxGWOzMoRGB3MvyWn+GHeyMYYwXQdsCP1r
         EMr4rzY2EzSci18/H9ze9ypL1Y2iAokvbSVRVzanUX4t88iAwEiadokLF7YgcjLMZ0wq
         Naks0DCzYb+6dQBs+bujxrxHdwz+QBfxWodCyOj5WU8xUGMcqHbIbRQOIZD47gafJ6t9
         B13j3+H8mVt+AYmwgf8tafpVWdZYCCsYiXi+o91ANyIKnyIq592P1UY1s9LKHjpkIJfn
         D4sc5g5gzpJNkgSGoSX1tRfLMDDte6gGP0ucocI9jGm+ADrHf27JPXbf+BsUqfVcBkrh
         SiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687904; x=1692279904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhx7ZNTqJJ5S4apOkLmOT04A37Dl3XYqjJCOeSe5i6M=;
        b=PkvYvBFg5AVY0AcU0oMkGLN1O3HNtoIhG67KTg/YumHdBdzVWroTSYJp2s43Jfyb5a
         emVgVlHzHd7ii5FyyARfIUsop8K42k8tEjCgY5BM70y3Yw+MgQ0vbEU4m045EUfOGqCI
         c8nN61AZhvLbMu4o4XC6JMh1lCnbZzf0QAFyc/CfAJWaoh74FQ4PKpfoMQ5YUQid6dL4
         /4SsNJQGFvKLPFK1dtjJYps8vSzmXWEfjZcII8Op1xFsFFKrxKJTDnST5Im1+ay9N1mX
         A9pcqjE7FMiJV5kQhS1EL2diiG326rVfWMq0O5duRo8Pgh3A3lJMhLpfQbZgJp3U3gl4
         XMeg==
X-Gm-Message-State: ABy/qLbqGbXKT+N1H3+bOCLoX7Ua5vO6vFtsCCO57tHRz/VjYAueUUON
        jES1YC2PorSQjD5+sMQeyZo43zQw0w==
X-Google-Smtp-Source: APBJJlHHEpYaPtmPlelVXaPLRa+62+5m60Gw2B6Oe+j+yg61RVtMGwTH/3TcsXAu7Hc9TYTk7dHUtg==
X-Received: by 2002:a05:6870:9a17:b0:1ad:2b76:c3 with SMTP id fo23-20020a0568709a1700b001ad2b7600c3mr14234488oab.39.1689687904726;
        Tue, 18 Jul 2023 06:45:04 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:45:03 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/6] x86/entry/32: Remove SEP test for SYSEXIT
Date:   Tue, 18 Jul 2023 09:44:45 -0400
Message-ID: <20230718134446.168654-6-brgerst@gmail.com>
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

SEP must be already be present in order for do_fast_syscall_32() to be
called on native 32-bit, so checking it again is unnecessary.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 15660f936ede..fca6f2b7daf3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -275,8 +275,7 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	 * We don't allow syscalls at all from VM86 mode, but we still
 	 * need to check VM, because we might be returning from sys_vm86.
 	 */
-	return static_cpu_has(X86_FEATURE_SEP) &&
-		regs->cs == __USER_CS && regs->ss == __USER_DS &&
+	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
 		regs->ip == landing_pad &&
 		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
 #endif
-- 
2.41.0

