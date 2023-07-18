Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473FF757E03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjGRNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjGRNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:00 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84099E9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:44:59 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56669eb7565so4083710eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689687898; x=1692279898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq7HxHbLSZkIZz8Cp9SQzofzfhw66+x3AcdqZHyV/wI=;
        b=k4HJ9OnD7dtdzB4Iac0w4i15O+332x9P1rbwy1zN853Eo7fOvtUrt61CwghExTU95j
         raqZsbBSnsSsc0c2qIzbc5nooA6Evkh7AdkQstmgde1F7A8f48d7q48fGmp24glvAGMC
         llQNd4rWUYe2GzYC/LZ4Ih4o0me9BxvkaZs8S8xoWsdPYtsy5FfAdEMH4VJ3VAzS3sI3
         q/vmXgSalw/b2xQe11/2O69Pp5247CtxGoVmygd1vXrfQH64N7Sp+c43YDlMumMacRAN
         MhPv7gVwPg0e/3el1y08JkGuE5ynEUCwkCUKC4BBR9AZqJFr+RU1fk8lQ5dBs7Ut4Yzl
         Zm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687898; x=1692279898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq7HxHbLSZkIZz8Cp9SQzofzfhw66+x3AcdqZHyV/wI=;
        b=HsUAZW5KKWK+lYtBHfRzBD/vYKR68PtPNQzgxn+X2Z5cLyVsRSWsin4W8QNC0ZrDUG
         2l/owL2O0qywYoeMDvXrp6LTBa1EbS3Lz9wvFaUF8bHpcjZnVasUtF+SyaeLwtMTS6sn
         MyFtGt1kiXAfefMdIFKo5XxGw6VzZsXhhPZVC7M//4tSr9W5hsBCKyFunDksYh4eNukw
         Hx9tK7REj0nrT+lhfH2eCo3KeDibmFAsXz7J6aAHaBipQM0bnQewTvTQet8j5Yxs26s8
         SvzPgGUvTIdCQUaG1mEtqlLhwkq8BCncHLO1S1YJ4E8yjG6gbw8LsjI5njB3k0SJsHG+
         vqVw==
X-Gm-Message-State: ABy/qLYjei/Y7f8K2E3B9gl1h2/z8cHPqeV7YT9kl1s0xMjQwDsRUfff
        hcMV6ZhWvTegCQrAVjzMF2YILJFd8w==
X-Google-Smtp-Source: APBJJlHe/xx44lIqHT69NCt2pPRefZC8tcUgS1bQBwY7vbTvD4izk7JvY/mCQlYEQ37NjQwjOmtYPQ==
X-Received: by 2002:a4a:304a:0:b0:564:e465:5d5c with SMTP id z10-20020a4a304a000000b00564e4655d5cmr6688742ooz.2.1689687898110;
        Tue, 18 Jul 2023 06:44:58 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id q7-20020a4aac47000000b005660ed0becesm726778oon.39.2023.07.18.06.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:44:57 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 1/6] x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
Date:   Tue, 18 Jul 2023 09:44:41 -0400
Message-ID: <20230718134446.168654-2-brgerst@gmail.com>
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

This comment comes from a time when the kernel attempted to use SYSRET
on all returns to userspace, including interrupts and exceptions.  Ever
since commit fffbb5dc ("Move opportunistic sysret code to syscall code
path"), SYSRET is only used for returning from system calls. The
specific tracing issue listed in this comment is not possible anymore.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_64.S | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 91f6818884fa..c01776a51545 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -166,22 +166,9 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	jne	swapgs_restore_regs_and_return_to_usermode
 
 	/*
-	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
-	 * restore RF properly. If the slowpath sets it for whatever reason, we
-	 * need to restore it correctly.
-	 *
-	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
-	 * trap from userspace immediately after SYSRET.  This would cause an
-	 * infinite loop whenever #DB happens with register state that satisfies
-	 * the opportunistic SYSRET conditions.  For example, single-stepping
-	 * this user code:
-	 *
-	 *           movq	$stuck_here, %rcx
-	 *           pushfq
-	 *           popq %r11
-	 *   stuck_here:
-	 *
-	 * would never get past 'stuck_here'.
+	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
+	 * restoring TF results in a trap from userspace immediately after
+	 * SYSRET.
 	 */
 	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
 	jnz	swapgs_restore_regs_and_return_to_usermode
-- 
2.41.0

