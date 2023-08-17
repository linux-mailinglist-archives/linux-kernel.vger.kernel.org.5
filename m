Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10877F630
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350725AbjHQMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350784AbjHQMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:15:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB626AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:15:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cf42a3313so17642767b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692274534; x=1692879334;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fumC1u/vFnTZamX/AoMbevXmYqNleX6J0hBBPzcrTcg=;
        b=J2ddzwNe+YM37+i6Mkr1j+ujsDSlCXtFvwrsMKyIUF06CrdcwLIQatdZ6N6HLkqyIz
         HEQJw7EIEM458BEvi/u6Yc/Z/g7KoZMmjovITJ43Vk3yE2ZuHjP7x20CbcfriY+wX3+T
         pKa7naYOBuzOmgdJZ+0bVms3iCopdOK1TY2HcfLZY6ezfg9msNQ+LwQ3cnM4PXK7Hmaj
         1WR0Ih+ZMr2J4YKSckIlx5aTFv53IA4cFJhaJD1f0GO2KR/3ioPyvVZBsi6EL+ZGJ7Pp
         Qyq+JnI/2ZxJivhxuyUAJtZmX2N8nuo4Qo3rSGWPpNYOq5Iwr1ydGXxHBvH7zYlja26o
         qk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692274534; x=1692879334;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fumC1u/vFnTZamX/AoMbevXmYqNleX6J0hBBPzcrTcg=;
        b=KasBvGYiaXeCWbyznES2/nmi3RPFD3HJ41UOYpxzH2KVV5iZCVTRhYCNHEsBZzFmn8
         Z48/SsMaQiHUOSX4K8ZjmLt0LBPhdeA2/yDjUmdnDgInQwl8fmxMBwu5CMRgAMkMzOGi
         ynXu/hs+fKEKQBMIk4R4eBcAiFxpIJ5Ee9r/PTtwWxIbIDOb70o39A4rf5mS7E4uxq51
         RKMX2mtKMXeCDwN3gCdaqBu7fB98YPSNGCFTYWgsCypV/mpLLWiAPKu0LJtEtR2cOcg7
         aPW26LPtvjZrUXOtx/dovLmB1/3qO7G/4fsOPopp5RVaA+rARb+qYKOQmKX3P4MYNXIe
         HY1g==
X-Gm-Message-State: AOJu0YyNgX8RE+lGFTmK70i4/SnjELrnMSmSqyVLyQAfEUpilDO6qtjQ
        4oENZLeIp0nU9rdtFlfuoB2JycT5hoo+tA==
X-Google-Smtp-Source: AGHT+IFooHGYI9RZ6+SPXWTyqkDkXHybwlUQeGM5PHOMbZ/wv23qY4rUBjA1E5OOCBLV9MFkoF5gdHwI3YfOGw==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a81:b70b:0:b0:56c:e0c5:de88 with SMTP id
 v11-20020a81b70b000000b0056ce0c5de88mr60182ywh.1.1692274534365; Thu, 17 Aug
 2023 05:15:34 -0700 (PDT)
Date:   Thu, 17 Aug 2023 12:15:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230817121513.1382800-1-jackmanb@google.com>
Subject: [PATCH RESEND] x86/entry: Don't write to CR3 when restoring to kernel CR3
From:   Brendan Jackman <jackmanb@google.com>
To:     luto@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, laijs@linux.alibaba.com,
        yosryahmed@google.com, reijiw@google.com, oweisse@google.com,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Skip resuming KERNEL pages since it is already KERNEL CR3

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

While staring at paranoid_exit I was confused about why we had this CR3
write, avoiding it seems like a free optimisation. The original commit
21e94459110252 ("x86/mm: Optimize RESTORE_CR3") says "Most NMI/paranoid
exceptions will not in fact change pagetables" but I didn't't understand
what the "most" was referring to. I then discovered this patch on the
mailing list, Andy said[1] that it looks correct so maybe now is the
time to merge it?

Note there's another patch in [1] as well, the benefit of that one is
not obvious to me though.

We've tested an equivalent patch in our internal kernel.

[1] https://lore.kernel.org/lkml/20200526043507.51977-3-laijs@linux.alibaba.com/
-- >8 --
 arch/x86/entry/calling.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index f6907627172b..b2458685d56e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -236,14 +236,13 @@ For 32-bit we have the following conventions - kernel is built with
 .macro RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
 	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
+	 * Skip resuming KERNEL pages since it is already KERNEL CR3.
 	 */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -261,10 +260,6 @@ For 32-bit we have the following conventions - kernel is built with
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
-- 
2.41.0.694.ge786442a9b-goog

