Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91078792B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbjHXUNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243472AbjHXUM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:12:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B41BCD;
        Thu, 24 Aug 2023 13:12:54 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:12:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692907973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXTQ2wqGEq8Pz6yTwF/JEdPBqKNqe6nRDvBoVDyPzTQ=;
        b=4Z7clyBSL7da6Yggng7uxjBXzvwVfRWuPzqQyd3TlC1rz4xD2pNMQ85vPKBspx9TdyKmK3
        1/vF2Zgs0Sm2Q0FO8yGpJ8OGgMJ4miSiswBvYVqG3vRFIrMavhRdNggiEPXwdDLWkUuomO
        +hlhAjpFkopRtK1Zs+RM9j0QtFhawsBfveqvLLTTNGEXs/yYT3dALSoMdSx2Zyu1zgYpAJ
        DJXbw/q+Prj5PBTOG7RHZmvrjLByLAmvswEtt+qdY/go+w5xdwDv57Uvawds9Y3g4u617c
        G4CrvqrKp5/B7E8hqTTrFZCae3QLtF2gS46+JrxVhY/iRqb/45bSaXvZst3j1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692907973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXTQ2wqGEq8Pz6yTwF/JEdPBqKNqe6nRDvBoVDyPzTQ=;
        b=kXd+GBrW+zDPcxYKvbwTBEl2R4cy5iP+IgLywRn3r9yS174VivPTicuDMjvLWNRuHiIFG3
        jutIaJfXUdEySkAA==
From:   "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform/uv: Refactor code using deprecated
 strncpy() interface to use strscpy()
Cc:     Justin Stitt <justinstitt@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dimitri Sivanich <sivanich@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20230822-strncpy-arch-x86-kernel-apic-x2apic=5Fu?=
 =?utf-8?q?v=5Fx-v1-1-91d681d0b3f3=40google=2Ecom=3E?=
References: =?utf-8?q?=3C20230822-strncpy-arch-x86-kernel-apic-x2apic=5Fuv?=
 =?utf-8?q?=5Fx-v1-1-91d681d0b3f3=40google=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169290797270.27769.5277467952297102028.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     212f07a21622cbd4bb271b558b2d3ae0652e9875
Gitweb:        https://git.kernel.org/tip/212f07a21622cbd4bb271b558b2d3ae0652e9875
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Tue, 22 Aug 2023 22:05:30 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Aug 2023 21:22:50 +02:00

x86/platform/uv: Refactor code using deprecated strncpy() interface to use strscpy()

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, it means we can drop the `...-1` from:
|       strncpy(to, from, len-1);

as well as remove the comment mentioning NUL-termination as `strscpy`
implicitly grants us this behavior.

There should be no functional change as I don't believe the padding from
`strncpy` is needed here. If it turns out that the padding is necessary
we should use `strscpy_pad` as a direct replacement.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dimitri Sivanich <sivanich@hpe.com>
Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Link: https://lore.kernel.org/r/20230822-strncpy-arch-x86-kernel-apic-x2apic_uv_x-v1-1-91d681d0b3f3@google.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d9384d5..b524dee 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -294,8 +294,7 @@ static void __init early_get_apic_socketid_shift(void)
 
 static void __init uv_stringify(int len, char *to, char *from)
 {
-	/* Relies on 'to' being NULL chars so result will be NULL terminated */
-	strncpy(to, from, len-1);
+	strscpy(to, from, len);
 
 	/* Trim trailing spaces */
 	(void)strim(to);
@@ -1013,7 +1012,7 @@ static void __init calc_mmioh_map(enum mmioh_arch index,
 
 	/* One (UV2) mapping */
 	if (index == UV2_MMIOH) {
-		strncpy(id, "MMIOH", sizeof(id));
+		strscpy(id, "MMIOH", sizeof(id));
 		max_io = max_pnode;
 		mapped = 0;
 		goto map_exit;
