Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641C877540E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjHIH1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjHIH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9399A1FCE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0cNzgV7QfF46H9skhOZymYevXO8FDyoZfdqutENZD+0=; b=IDjEIVnf8hRG/Z1COZptTFJDgk
        yTNNSXbhsucrRkTJ4rywIoG5OwS2e1MtwoycB5kudj4iWShgGyOU+7aYU/2t1d+fMAnv7POuC+3Le
        +6PwihufK3A+GNeMiyrk7qw21Y/dwhWyr7rmZRXAToPF3gVdCZ0i7Zg6SM37IYjlQhdxfUbeTic2u
        spKNe+54j68MRpBwGH84T7o/De1YfYXI5zpWvNbfThUpl85Tt/7vdTmEmS9x9NaA7XL2dn5gTWAgi
        xMsDgu1WTUHDUBV+nhfpqXMYGQKMwtg6DXaNNSGEUvSLv2iaXK9k6Kcj84XEd+aNwYD/lPwMA9DM0
        q9dIiqNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTdaf-005TeN-2L;
        Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96CAF301188;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6475F2CEBEB0D; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072200.990061113@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 08/17] x86/cpu: Add IBPB on VMEXIT to retbleed=
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

Since IBPB-on-VMEXIT is an obvious variant of retbleed=ibpb, add it as
an such.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -751,6 +751,7 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_UNRET_SRSO,
 	RETBLEED_MITIGATION_UNRET_SRSO_ALIAS,
 	RETBLEED_MITIGATION_IBPB,
+	RETBLEED_MITIGATION_IBPB_VMEXIT,
 	RETBLEED_MITIGATION_IBRS,
 	RETBLEED_MITIGATION_EIBRS,
 	RETBLEED_MITIGATION_STUFF,
@@ -763,6 +764,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_UNRET_SRSO,
 	RETBLEED_CMD_UNRET_SRSO_ALIAS,
 	RETBLEED_CMD_IBPB,
+	RETBLEED_CMD_IBPB_VMEXIT,
 	RETBLEED_CMD_STUFF,
 };
 
@@ -772,6 +774,7 @@ static const char * const retbleed_strin
 	[RETBLEED_MITIGATION_UNRET_SRSO]	= "Mitigation: srso untrained return thunk",
 	[RETBLEED_MITIGATION_UNRET_SRSO_ALIAS]	= "Mitigation: srso alias untrained return thunk",
 	[RETBLEED_MITIGATION_IBPB]		= "Mitigation: IBPB",
+	[RETBLEED_MITIGATION_IBPB_VMEXIT]	= "Mitigation: IBPB on VMEXIT only",
 	[RETBLEED_MITIGATION_IBRS]		= "Mitigation: IBRS",
 	[RETBLEED_MITIGATION_EIBRS]		= "Mitigation: Enhanced IBRS",
 	[RETBLEED_MITIGATION_STUFF]		= "Mitigation: Stuffing",
@@ -808,6 +811,8 @@ static int __init retbleed_parse_cmdline
 			retbleed_cmd = RETBLEED_CMD_UNRET_SRSO_ALIAS;
 		} else if (!strcmp(str, "ibpb")) {
 			retbleed_cmd = RETBLEED_CMD_IBPB;
+		} else if (!strcmp(str, "ibpb_vmexit")) {
+			retbleed_cmd = RETBLEED_CMD_IBPB_VMEXIT;
 		} else if (!strcmp(str, "stuff")) {
 			retbleed_cmd = RETBLEED_CMD_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
@@ -881,13 +886,17 @@ static void __init retbleed_select_mitig
 		break;
 
 	case RETBLEED_CMD_IBPB:
+	case RETBLEED_CMD_IBPB_VMEXIT:
 		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
 			pr_err("WARNING: CPU does not support IBPB.\n");
 			goto do_cmd_auto;
 		} else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
 			if (boot_cpu_has_bug(X86_BUG_SRSO) && !has_microcode)
 				pr_err("IBPB-extending microcode not applied; SRSO NOT mitigated\n");
-			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+			if (retbleed_cmd == RETBLEED_CMD_IBPB)
+				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+			if (retbleed_cmd == RETBLEED_CMD_IBPB_VMEXIT)
+				retbleed_mitigation = RETBLEED_MITIGATION_IBPB_VMEXIT;
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
 			goto do_cmd_auto;
@@ -961,6 +970,12 @@ static void __init retbleed_select_mitig
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
+		mitigate_smt = true;
+		break;
+
+	case RETBLEED_MITIGATION_IBPB_VMEXIT:
+		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 		mitigate_smt = true;
 		break;
 


