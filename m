Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267577B88B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjHNMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjHNMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B818F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1dQK7+y7wnp9bbFjSoE9Iy4vHQneof7CDIZ0OzqGKqo=; b=EmAL5xkzB4R4Wn54xCVDxw3dYJ
        Cw+bD4PkfUiVSxEhEJ2xpv2l0ajq5oN1kJMNFEiEj6yZQi6RXkjR2NYaAkKw5cuPL0UVsSNulyL08
        Fgs3aTm5wWEBKA7RKmixSK2VCYIeYrAlMakjfnJv7vanbiJxPjFvNjg4tIR//OvWQQaHW7ZxTLJb+
        yy8LXCWZIdvfLk0917bJyR71+0sxHW4N0C9iIeylLvBYioXWvtopOvnNGyf8TuRe6wDDmSYIfCmwG
        SU9VV7SamP+Prh+2eZmF63CEc/4Hu4uMCZDwHIX5cOjLzgGLIHHk41AWxRQK1QLSTFxPbbYjvdsxT
        woIZvXwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVWXY-001t43-A1; Mon, 14 Aug 2023 12:19:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8C7F3004AF;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B0D7921C1D1B2; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121148.571027074@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 01/11] x86/cpu: Fixup __x86_return_thunk
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

Patch fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow
mitigation") reimplemented __x86_return_thunk with a mix of
SYM_FUNC_START and SYM_CODE_END, this is not a sane combination.

Since nothing should ever actually 'CALL' this, make it consistently
CODE.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -264,7 +264,9 @@ SYM_CODE_END(srso_safe_ret)
 SYM_FUNC_END(srso_untrain_ret)
 __EXPORT_THUNK(srso_untrain_ret)
 
-SYM_FUNC_START(__x86_return_thunk)
+SYM_CODE_START(__x86_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
 	ALTERNATIVE_2 "jmp __ret", "call srso_safe_ret", X86_FEATURE_SRSO, \
 			"call srso_safe_ret_alias", X86_FEATURE_SRSO_ALIAS
 	int3


