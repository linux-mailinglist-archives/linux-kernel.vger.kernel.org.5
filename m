Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72F175CD68
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGUQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjGUQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:10:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5484730C4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:42 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4039a2b71c1so15688771cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689955841; x=1690560641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq7HxHbLSZkIZz8Cp9SQzofzfhw66+x3AcdqZHyV/wI=;
        b=d3BFI96ATRff7zKqJu5Ad+SdNzIiWDGxdcnfFZdlHWnJ0mTqZerdvffw7hUF5sDKd0
         rny6ZKRCd1JQvOOlk0pU+NSmhhtfSd0eDHvYqRQXLbWffnN5HkriP4oFFa46G8ECpGRu
         CvpbyuIrCQkTTGUVdcF6frQD0ma3dhVI6e9HICS7cPGEHmvvUTw/mziEpSItIxCFL66x
         uB8yJzayDVfObZxHtm3N8uofP1rOLaWFwEluq1zihE1M5Q5dBGDvnBncTxOvKloUg/N6
         WmGSKe33uOlKFfDStARFGCoRQlfl2weR7Tz4xzJAwaGoMFO8AT78Rdxyv/pFkRgJQUkX
         liDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689955841; x=1690560641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq7HxHbLSZkIZz8Cp9SQzofzfhw66+x3AcdqZHyV/wI=;
        b=JTDoID2jq7rtRS+rcmz3hPIdIsew556/F34tf9ZcTiOFnFx5sZuX2Vpqu+MWyymGui
         igW9lKRMCaiHuEIOO8v/jf+l61ZvcFzYxCWTnfDhi9rR+O7dWmHEac4qlUZsbSaoOQeg
         3dYVVe6D52ZyQ4d84LLudRAIvlSrIhoJp6VN+6yqQnXceuJ//Cr/sC3viIrWDz6dD9EI
         /dgMdn2OfF7t7sd7G1kq6l1M6YbU1c/FUJeJYvi1y5TjnlUgrRSpe31PCMAWuKwVWIcV
         5hPGKRtz8soup5m3Md0QuzBOnMonX9FsRv8iBbwzhiQPETxEBr+PYZbHVNNAeG6boxHi
         V/dw==
X-Gm-Message-State: ABy/qLYk3I4/70rckQdOzoe0o71R6X29m/l1+59554go33J96OBR6o05
        pcdRq+2MWZJPijUr+F+K9fvwOUGAEg==
X-Google-Smtp-Source: APBJJlES5zHm2fv/T8RsAfRQTeRO1LvK9fmhp8rc5mECHyFO9fntz/tQe8d4qLhSb/Pe1ziY6vSW0w==
X-Received: by 2002:ac8:57d2:0:b0:3f6:aff0:6dec with SMTP id w18-20020ac857d2000000b003f6aff06decmr422831qta.32.1689955840820;
        Fri, 21 Jul 2023 09:10:40 -0700 (PDT)
Received: from citadel.. (047-026-243-217.res.spectrum.com. [47.26.243.217])
        by smtp.gmail.com with ESMTPSA id c16-20020ac87d90000000b004054fbf9273sm311286qtd.80.2023.07.21.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:10:39 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 1/6] x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
Date:   Fri, 21 Jul 2023 12:10:12 -0400
Message-ID: <20230721161018.50214-2-brgerst@gmail.com>
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

