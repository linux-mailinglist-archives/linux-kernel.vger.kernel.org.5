Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742C5775408
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHIH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHIH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D021BCF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0h4UtQHS5lmkLTQkMktH8D/oH/01AwN6dSYfEgrTw0Y=; b=IH8pj/0D3Ddi0Wcd/NTGob2SGX
        iuch/2+LNkDLXh8B/8zIZqVriLUoaNXe4Oz8Az9AbzcpxWIdaq5IhJhJ8Rc59z6G5cbf+uoOapWeJ
        1ZqKeCOOHEAA9mkFK6jH7C3G+32eQ8JGT0dB10U0XhQGb5RbJumJAh8NYptPdAh+o3c98yBVayeCo
        IeETdUBFtZCmIhllN+wuDKn3j/yRm86qrjtC03JjFoKbisVDFATnQpXMcvN3RyRozlfoU6XohkwfI
        dEimeZMuvBpNT9MJNIoKeU600fBA58s5kv2Oe+jhAad++M9GpGo2FHlmeYCsO7l6Uau+LWIHlQpcY
        gbMA1afw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdae-004olL-Rp; Wed, 09 Aug 2023 07:26:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66F7530049D;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E49D2C1E85AC; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.715361518@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 04/17] objtool/x86: Fix SRSO mess
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

arch_is_rethunk() indicates those functions that will be considered
equivalent to INSN_RETURN and any callsite will be added to the
.return_sites section.

Notably: srso_untrain_ret, srso_safe_ret and __ret do not qualify.

The only thing that needs consideration is srso_safe_ret(), since that
is, like __x86_return_thunk, inside another instruction. Skip
validating that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c |    5 +----
 tools/objtool/check.c           |    2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -824,8 +824,5 @@ bool arch_is_retpoline(struct symbol *sy
 
 bool arch_is_rethunk(struct symbol *sym)
 {
-	return !strcmp(sym->name, "__x86_return_thunk") ||
-	       !strcmp(sym->name, "srso_untrain_ret") ||
-	       !strcmp(sym->name, "srso_safe_ret") ||
-	       !strcmp(sym->name, "__ret");
+	return !strcmp(sym->name, "__x86_return_thunk");
 }
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -455,7 +455,7 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 
-			if (func->return_thunk || func->alias != func)
+			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
 				continue;
 
 			if (!find_insn(file, sec, func->offset)) {


