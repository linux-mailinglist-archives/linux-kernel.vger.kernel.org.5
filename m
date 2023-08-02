Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAC76CB69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjHBLEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjHBLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:04:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CAD1FC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=apvcoInpYri3GsLvQN0fxRBQnpJkdbgo5+Z9wGvq+yo=; b=XEcRpPw5c69fzYWh1h/qfPIB+K
        8dBdsEFZr8Y/HzyE158xsbYYZ+OO4A1CRwh7L8WE2J59E2svQNy6f7U4Ze319MLlwCE2PkU+VjdtT
        RUgQ+93ftb8xEIouyffxoqfLJ5KkxH8opEY+RlimBq0xjpp5/VogA3ZKhiScFH9+v7uEtCMbK5ibz
        auTRVjsdudL4fnvMEYokZwNMUvCEeyuk0fKZn/yb/xHueCegsaJ4qdXgGBtFCcwNrVR0EYe4J6uUZ
        qXrT0aM2VkL0TM5SnpdEw6c9JdYy8GVJnU7KZCXyNMO3/yOAfzL1l42g/Dvm16d7RJ+wXVP54rLFS
        ObeSoyjg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qR9eE-00FtVq-1a;
        Wed, 02 Aug 2023 11:04:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2659A3001DD;
        Wed,  2 Aug 2023 13:04:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F3D4121000C9E; Wed,  2 Aug 2023 13:04:09 +0200 (CEST)
Message-ID: <20230802110323.086971726@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 02 Aug 2023 12:55:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, andrew.cooper3@citrix.com,
        David.Kaplan@amd.com
Subject: [PATCH 2/2] x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()
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

Commit cb855971d717 ("x86/putuser: Provide room for padding") changed
__put_user_nocheck_*() into proper functions but failed to note that
SYM_FUNC_START() already provides ENDBR, rendering the explicit ENDBR
superfluous.

Fixes: cb855971d717 ("x86/putuser: Provide room for padding")
Reported-by: David Kaplan <David.Kaplan@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/putuser.S |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -56,7 +56,6 @@ SYM_FUNC_END(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
 SYM_FUNC_START(__put_user_nocheck_1)
-	ENDBR
 	ASM_STAC
 2:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,7 +75,6 @@ SYM_FUNC_END(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
 SYM_FUNC_START(__put_user_nocheck_2)
-	ENDBR
 	ASM_STAC
 4:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -96,7 +94,6 @@ SYM_FUNC_END(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
 SYM_FUNC_START(__put_user_nocheck_4)
-	ENDBR
 	ASM_STAC
 6:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -119,7 +116,6 @@ SYM_FUNC_END(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
 SYM_FUNC_START(__put_user_nocheck_8)
-	ENDBR
 	ASM_STAC
 9:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32


