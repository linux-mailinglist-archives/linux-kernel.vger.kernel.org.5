Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAEC77B88A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjHNMUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjHNMTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86790F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4YdyLh/jaFymiTs1kquLvymfFdQhLGTp8bGZNgL90Dw=; b=tKK6amFPdJKTLwe2ykNtNstSJF
        k2tmEmP4HYagy/5XVSUh8PfKrR3gKbUR/9YhsIo464YO8FQEGmq1pzROaNH8UliZRqLBu333dsWgg
        oDTJU7QC66IRzJ2UJuWbxSuCArNiuptO7SpjyAYIQb/ljVJVYfUOi24qf14QsibDeAh098bHZXi3B
        y0fiiOOdGwM1szmOIUrhUESFMGT4tODVRBqjKcaY4NVJPTO/aNrar76F+DNARe7PbLaPxa8wwZQRg
        RDS3XE80CC8sC3X0pvnxpM+n52rEzA+Kxc7gsccyi/Vl76+vy9Ed1MXeAwQZMODWowA9A4ej+0AMZ
        kTMc/+sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVWXY-001t45-Bh; Mon, 14 Aug 2023 12:19:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4A1030075E;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BEB3121C1D181; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121148.775293785@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 04/11] x86/alternative: Make custom return thunk unconditional
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is infrastructure to rewrite return thunks to point to any
random thunk one desires, unwrap that from CALL_THUNKS, which up to
now was the sole user of that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    4 ----
 arch/x86/kernel/alternative.c        |    2 --
 2 files changed, 6 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -347,11 +347,7 @@ extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
 extern void entry_ibpb(void);
 
-#ifdef CONFIG_CALL_THUNKS
 extern void (*x86_return_thunk)(void);
-#else
-#define x86_return_thunk	(&__x86_return_thunk)
-#endif
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 extern void __x86_return_skl(void);
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -687,9 +687,7 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_RETHUNK
 
-#ifdef CONFIG_CALL_THUNKS
 void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
-#endif
 
 /*
  * Rewrite the compiler generated return thunk tail-calls.


