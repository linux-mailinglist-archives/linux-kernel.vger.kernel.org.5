Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF857884BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbjHYKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbjHYKUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BD21987;
        Fri, 25 Aug 2023 03:19:51 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+j/7aD9ZZHPV/FxV9pF4tNpf0qsTyYJ7CBOlmHhqcVU=;
        b=cLq7e7KM4QkdgCSipZkLEc0t1CDdYt3bJDn6B03zVYSem76CFe65e8x/OA9GkBGQBTxEc0
        whloinVzedFCRH4W8X6cpoVX//EX3Yr9+e2MSVa3dBFSonnhRpVP4l5xcNtUK4UNxe199N
        lpo7oRYyJpJi3eytb+q9hIcE/FPTpLaWhaqajIsDUMdcSLQMR6kI0/AQ8nj9DeQ7tTMdOx
        gu0CbuYXc0KCFvVE3E9TdxU52duraReU2swf1lgM7cTjYWZ9CQU+Tal6VIfaUN7lEjLSHf
        KAsdhxVSCPmY+bDSE702b0fDpV42Pa7+CuSj5zkidik+NDPyxMl3mKHo7met6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958769;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+j/7aD9ZZHPV/FxV9pF4tNpf0qsTyYJ7CBOlmHhqcVU=;
        b=963MIJ5zAoKUMj8kYeyF1Iwvmu+HabmDAqg2lJwSo40i7GGK3ZB3QALPoL2AysLNtjdqHG
        VwFxi1v9Pgl3+fDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Move retbleed IBPB check into existing
 'has_microcode' code block
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c64b84b6df4e82423abe2441a1a088a8c7f1ae14.1692919072.git.jpoimboe@kernel.org>
References: <c64b84b6df4e82423abe2441a1a088a8c7f1ae14.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295876939.27769.6118442585512132661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a542794756c50e0b339a751635cdbbd5893f2b4e
Gitweb:        https://git.kernel.org/tip/a542794756c50e0b339a751635cdbbd5893f2b4e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:01 +02:00

x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block

Simplify the code flow a bit by moving the retbleed IBPB check into the
existing 'has_microcode' block.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/c64b84b6df4e82423abe2441a1a088a8c7f1ae14.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0621615..b086fd4 100644
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
