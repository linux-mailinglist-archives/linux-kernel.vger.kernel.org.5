Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3395F76CB6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjHBLEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjHBLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:04:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831E1FC2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OJDFzby0ZnN0v9KkGBrIpBxHQA0M/SWomoqJPt4Ln9Y=; b=kzTXafX28IJou13ECVF9CGzks4
        9p3lDuem3HsbpaPsV6FxeKtg4Mg7vi8wa/2r3mDzHa5P6voZ4HQqDtWTDl8oa85++z2HpVto9WPoP
        L1rRgkFBrrBjTzPNHa9+vtZyZhSDliH4BesAb0Uf74WBDNtbTGxC/GGZnZ3+K3NY5Ul97NU7ckqV8
        yMjAGmW4kNV3sdlmYOBDxQ70LWwfzWF5UEOh4Bbl+3kZyCEl79QgqcgvLwLL5TeVoXaCt+fFHaDGb
        /JANK/uTbwqL5qy/ceTeVJPnXMQNHatYUQzAej5EI/Ok2VkYPJJhfwKQweAJHlXL4MH3nPtWJN3Ou
        pSSZvOIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qR9eE-00EaIn-Fy; Wed, 02 Aug 2023 11:04:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 283E6300301;
        Wed,  2 Aug 2023 13:04:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F1F1021000C90; Wed,  2 Aug 2023 13:04:09 +0200 (CEST)
Message-ID: <20230802110323.016197440@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 12:55:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, andrew.cooper3@citrix.com,
        David.Kaplan@amd.com
Subject: [PATCH 1/2] x86/ibt: Suppress spurious ENDBR
References: <20230802105545.594381530@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that under certain circumstances GCC emits ENDBR
instructions for _THIS_IP_ usage. Specifically, when it appears at the
start of a basic block -- but not elsewhere.

Since _THIS_IP_ is never used for control flow, these ENDBR
instructions are completely superfluous. Override the _THIS_IP_
definition for x86_64 to avoid this.

Less ENDBR instructions is better.

Fixes: 156ff4a544ae ("x86/ibt: Base IBT bits")
Reported-by: David Kaplan <David.Kaplan@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/linkage.h      |    8 ++++++++
 include/linux/instruction_pointer.h |    5 +++++
 2 files changed, 13 insertions(+)

--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -8,6 +8,14 @@
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
 
+#ifdef CONFIG_64BIT
+/*
+ * The generic version tends to create spurious ENDBR instructions under
+ * certain conditions.
+ */
+#define _THIS_IP_ ({ unsigned long __here; asm ("lea 0(%%rip), %0" : "=r" (__here)); __here; })
+#endif
+
 #ifdef CONFIG_X86_32
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -2,7 +2,12 @@
 #ifndef _LINUX_INSTRUCTION_POINTER_H
 #define _LINUX_INSTRUCTION_POINTER_H
 
+#include <asm/linkage.h>
+
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
+
+#ifndef _THIS_IP_
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#endif
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */


