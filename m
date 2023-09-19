Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978D47A5ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjISJya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjISJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E071F0;
        Tue, 19 Sep 2023 02:53:14 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:53:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117191;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SY8oVWk6zlglMI9XbDrnIRIKpD+8JvKtwWhUjnX1BB4=;
        b=KnNreuHZUu4SsRdceDdtijn8gSQ1XDCLJNsKefbltF8o6DHdMC8LV9Nd6jNzZv0p31tgPf
        Zd1+4IMjm0d1QGCENINHtKDzUArayZGq79Z+CXVJGsHQ8NCMZyhYjW5+dzZDi6/0B1RWoE
        MC3FtQxfdGaHSjFLj83ZQUmRkGSrH3VBaMyZASS46ZPY5895+CA7XGfxhtluNJSeqpth+O
        T+hQIHnAASYUOR3by4ctMvfJ83C2E9xBzeH/8laSXR61aTPwxEeR5R7X5dihMvmflBJZ6i
        0XLFWXJWW76ppwbml836TZH0KmPFA8SFe8jbOvboHbMuuGjr8dGuuthW1mb+wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117191;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SY8oVWk6zlglMI9XbDrnIRIKpD+8JvKtwWhUjnX1BB4=;
        b=tsuOLHcnUoiTddt3Si4auxg2ULTyXvW/slbmrwmtVKyGiOt4WAVAQebVkGqGJ5vuH4ceAO
        cOxcXNDDBAavmRDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Move retbleed IBPB check into existing
 'has_microcode' code block
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <0a22b86b1f6b07f9046a9ab763fc0e0d1b7a91d4.1693889988.git.jpoimboe@kernel.org>
References: <0a22b86b1f6b07f9046a9ab763fc0e0d1b7a91d4.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169511719062.27769.2510260108122622522.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     27ee0600912c8a02fd6901bc4413709282d7b3f8
Gitweb:        https://git.kernel.org/tip/27ee0600912c8a02fd6901bc4413709282d7b3f8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 11:42:48 +02:00

x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block

Simplify the code flow a bit by moving the retbleed IBPB check into the
existing 'has_microcode' block.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/0a22b86b1f6b07f9046a9ab763fc0e0d1b7a91d4.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 941ac94..6b443f0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2430,10 +2430,8 @@ static void __init srso_select_mitigation(void)
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
 			return;
 		}
-	}
 
-	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (has_microcode) {
+		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
 			srso_mitigation = SRSO_MITIGATION_IBPB;
 			goto out;
 		}
