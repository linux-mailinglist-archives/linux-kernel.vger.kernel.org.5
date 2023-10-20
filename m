Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481807D0EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377282AbjJTLhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377107AbjJTLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14DBD5B;
        Fri, 20 Oct 2023 04:37:20 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7rquPvt7QDQYVBgfg7x6sEf6nSLkJi4u/H+hJZVgpQ=;
        b=rFfSAjl8/PxgczolkAh73sOxI2xvBLrFo5zXVzUNieFghPDZUxYCNwOo5Ph15a5GYK32sA
        QH5fQ0rk6vwVlA6QFhcmBvbgjQqOgXZ/pzF7Qxpv2aKZNp32lsY9WN+hL34z+2hCC0iZ9I
        uul9QmtSeDjr0gZizeG1i893UM01mp3pkYciJ/iP5dQTA6Yb0pPXz+0sTlXk2fJ2rbgR9R
        JnphsQlSiqoHz6ijlr8IiCFh83e39SrJRyYm90Z97c6GugVNdZ1mh9b4zSBgXZfFieo/HG
        ZsiCiC/7sd1MUkRNHthKGk7/Bupe3hAMadnW/07dzuW0nX3DDI1NMtLXzxiSxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T7rquPvt7QDQYVBgfg7x6sEf6nSLkJi4u/H+hJZVgpQ=;
        b=RwK4D5/YuUONiOXgiGKvv1ktKXph0Klyt16WrJU2vwep31Pb2tLLuGzAKnb+eOJIQfgUyv
        rYBnFQyYzBvXjzCQ==
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
Message-ID: <169780183877.3135.16167476121418163828.tip-bot2@tip-bot2>
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

Commit-ID:     351236947a45a512c517153bbe109fe868d05e6d
Gitweb:        https://git.kernel.org/tip/351236947a45a512c517153bbe109fe868d05e6d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:59 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:29:25 +02:00

x86/srso: Move retbleed IBPB check into existing 'has_microcode' code block

Simplify the code flow a bit by moving the retbleed IBPB check into the
existing 'has_microcode' block.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
