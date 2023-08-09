Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE6775414
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHIH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjHIH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:27:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A0B1BFF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1JzBOdEpj0kY5PCXuAuvYaN0CxQoKNldEQz5hq+vbwQ=; b=LaSxP2nwjlkh8B1HSNU7FFXNrx
        NJC1DgWY8pl/o4ZLpHbqdVB6EYyu87DuCEaSUfmamd2swSBGnYci1T1b3XNB101fSH4EPDVApWS3G
        yixjPuU3QOaPLruG6ESkPyEzFR94+yhpC078wkoGbH7L7xKiSaGpyedbhMKMqMZNEJK+rUxTWjCAB
        1tS+lF5BirIA0+mRiRaOBxCJVPdW26qPmlgoec09f+fbxBXYYc0a71VmVVVeXu9PQQmZGDncvZozf
        rPjTl/uhvlvbsCVQKMU5BDLhR8Ky/9eWXujvCEb5xA485opPV8C0Gc1qPZN6AQ9nQN2wHMGR1jtG6
        aUx2JQzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdag-004olW-7f; Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5718302DD9;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 953E02C86567A; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.394962649@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 14/17] objtool: Add comments to the arch_is_$foo() magic symbols
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

Clarification was asked for...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1292,16 +1292,28 @@ static int add_ignore_alternatives(struc
 	return 0;
 }
 
+/*
+ * Symbols that replace INSN_CALL_DYNAMIC, every (tail) call to such a symbol
+ * will be added to the .retpoline_sites section.
+ */
 __weak bool arch_is_retpoline(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that replace INSN_RETURN, every (tail) call to such a symbol
+ * will be added to the .return_sites section.
+ */
 __weak bool arch_is_rethunk(struct symbol *sym)
 {
 	return false;
 }
 
+/*
+ * Symbols that are embedded inside other instructions, because sometimes crazy
+ * code exists. These are mostly ignored for validation purposes.
+ */
 __weak bool arch_is_offset_insn(struct symbol *sym)
 {
 	return false;


