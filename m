Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0B7A5E76
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjISJpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjISJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:45:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583D9E;
        Tue, 19 Sep 2023 02:45:07 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:45:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695116705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d8xIsc4sePtutJqhd6WlEejexYZaNqODb5FCP/tcuA=;
        b=SCKlqV+po1aiem+Br/mUwBQ+iiTj4DfPIUN9bXm/4RXIpeMBezw1y6XQDMfIaBHtOJ6QNT
        0TReRLDJiNiPwW6wG0DpnnBfkN9Lfxe3l4Wnv7phYoSCnQdBNs4KCExJ6j60SsyNnA/kNa
        ElEkNl2j7DxYSJ+5BfovArTkJLu2VdA+VPdxWwkVQJA1mBYZVT4l8z4vglwaY94YmFtp+J
        hyzlBBRc+ULQx4YS+wAkR9sJaYMjOPU01JVXMDR/qdj7XtI04fwcxvo5lMyd8QPlgu8re1
        m9/ZLTBcYoHQBYG/RI+9NZyJjLUV5b6vaXHUyXbtf60nvfnJUoGU1daPJocVeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695116705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3d8xIsc4sePtutJqhd6WlEejexYZaNqODb5FCP/tcuA=;
        b=kXlTV/h8ELdleg5FiqV5XCQTp6WaYY6K4PlAQQhvofXi6oW85MdiFFPVnxYp0jFOk9QhFl
        PrTqS1s9aU3lL3CQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/srso: Fix SBPB enablement for spec_rstack_overflow=off
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b20820c3cfd1003171135ec8d762a0b957348497.1693889988.git.jpoimboe@kernel.org>
References: <b20820c3cfd1003171135ec8d762a0b957348497.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169511670491.27769.1578583529325282203.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     01b057b2f4cc2d905a0bd92195657dbd9a7005ab
Gitweb:        https://git.kernel.org/tip/01b057b2f4cc2d905a0bd92195657dbd9a7005ab
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:48 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 19 Sep 2023 10:54:39 +02:00

x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

If the user has requested no SRSO mitigation, other mitigations can use
the lighter-weight SBPB instead of IBPB.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/b20820c3cfd1003171135ec8d762a0b957348497.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b0ae985..10499bc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2433,7 +2433,7 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		return;
+		goto pred_cmd;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
