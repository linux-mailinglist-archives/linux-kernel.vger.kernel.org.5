Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53C177540C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjHIH1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjHIH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB91FD0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zoLAuzkIHX55kt02j2vg7TbXefeLx4iSw6mLX1oYzJs=; b=YZqtjwI+Hd9FoxVBeKsgNySyrk
        JY490/rHu/X/6Afnwrs9mppQHBC7PW08qJTWbNWwyOY9dNn5C4W5T6vPyjtsFFpN70LLUJ4ch4tZp
        m0M3xOFXXpiWNYOxCt92fWSWt1koaziy8eHmNUISBXezJISLcmt80jRVV8qbRk1C9nKrIcty9j+Gv
        S9BZb5WGSjzgA0ETeGL0T+Xecc2G9fohhTFrry9k0ugPotFg2kUkcRyBkTBcA0WJCWkf3+NbWyJJy
        H3+b5gQAQ6UZ0LjK1DyyXjQohLMUdn31C7FZQER8c/SixE0ZiyYoj/XJgiUbWYdec8bH59nWT5GXQ
        b20f6u9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTdae-005TeH-2m;
        Wed, 09 Aug 2023 07:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A91E300346;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3DD012C865678; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.450404700@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 01/17] x86/alternative: Unconditional custom return thunk
References: <20230809071218.000335006@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
@@ -698,9 +698,7 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_RETHUNK
 
-#ifdef CONFIG_CALL_THUNKS
 void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
-#endif
 
 /*
  * Rewrite the compiler generated return thunk tail-calls.


