Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E27FFD62
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376924AbjK3VQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376868AbjK3VQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:16:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6210E5;
        Thu, 30 Nov 2023 13:16:35 -0800 (PST)
Date:   Thu, 30 Nov 2023 21:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701378994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZp+GrgQueujGyYhkSpSToDn+O/RdIcR3u3XHoaYEGU=;
        b=wuwv1UV/7FMEk63ekl2NYG08zVvGA/b2g70mT2TLDlgjmOPsnOYXQub2sTi1f2tDFtyDG3
        0DcDT3Id4hn5YLeVMrqSyfC8JrswmkFF2AGGDCf8IRHUxbVwQXQOllyYFP62WTW1SDw21v
        rzPJawYeDSPt8qh//94mcRTE0p880FYGMbANztggI4EhX5UkBIIA5DtIzKhq2TvWDq4Azl
        ksshedtfD2SCpTG2r7MDW7MkK42V6YAujmd9Y/9pHmKnsNXU89ZLSia1gVjoG82Q9HZyMX
        LoUbqTp0nFw9yGb1xDZuuga1IBwrI6ccjR7EulmuA7r6us/Uo88G3+9JzSn7aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701378994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZp+GrgQueujGyYhkSpSToDn+O/RdIcR3u3XHoaYEGU=;
        b=u0xTzHs6S7hMjlBZjsXkB9GWYorhPWtwl5BM5hjKWSiyrFpUUIJKqhmXXcR3uT9wnGGEKn
        8byY07RhK9ktpqAA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Define PER_CPU_VAR macro also for !__ASSEMBLY__
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231105213731.1878100-2-ubizjak@gmail.com>
References: <20231105213731.1878100-2-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <170137899333.398.9789817783303895226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     43bda69ed9e3b86d0ba5ff9256e437d50074d7d5
Gitweb:        https://git.kernel.org/tip/43bda69ed9e3b86d0ba5ff9256e437d50074d7d5
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 05 Nov 2023 22:34:35 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 20:06:16 +01:00

x86/percpu: Define PER_CPU_VAR macro also for !__ASSEMBLY__

Some C source files define 'asm' statements that use PER_CPU_VAR,
so make PER_CPU_VAR macro available also without __ASSEMBLY__.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231105213731.1878100-2-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b86b27d..0f12b20 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -84,10 +84,15 @@
 })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
+#define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
 #define __force_percpu_prefix	""
+
+#define PER_CPU_VAR(var)	(var)__percpu_rel
+
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
