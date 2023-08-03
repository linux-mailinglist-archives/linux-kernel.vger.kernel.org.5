Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8576EEE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbjHCP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbjHCP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:59:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2BB119;
        Thu,  3 Aug 2023 08:59:16 -0700 (PDT)
Date:   Thu, 03 Aug 2023 15:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691078355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CGDd2kSv+5ScAGu3AuIQTXMiwiyG4QuN8Ija4eWBgw=;
        b=fHqKZhAmbCAU2hRQf++LWiiSWlFb7PIQ86VPEHgUTksu2pXkoCMNx/Vw0uR1P/FN+U0NCa
        RmQXFXeC5bCf112Q6ihg89vghZEBh/U4zFByt6QLG7Re4Qh672l85xb6uQ3RytpD/oybRs
        VGgZu+q9JdaXZpAiS3s5OcL6lVryrrLCTURE7TupaWMRweJRX1kF9Ee8N1XqEmJHh7jxkB
        MHxR+Yi9CSBxJGlaLr3pA3HK14c9DP9mAxQT+YcsxoPGoysi1EAeKTr4S4NO8txA4P6O5F
        b7PKNKcNcs/PjI5r/f8n/XsJeI2sqk1WbkIzy5xs1bHSIiSv2sP3L+/r9rHgnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691078355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CGDd2kSv+5ScAGu3AuIQTXMiwiyG4QuN8Ija4eWBgw=;
        b=0JGsXdHXgWYoxl/c6B3BQpNGzSjLwqb+SjKFIvnaKn6RdQMMqHlKl12QXPsffGtwS88iWK
        NZiJqcEn3E2tzCDA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Avoid unneeded __div64_32 function definition
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803082619.1369127-4-arnd@kernel.org>
References: <20230803082619.1369127-4-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <169107835487.28540.16453020083177349536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     65412c8d72741cc6e6b082b478b8957d7e7c0480
Gitweb:        https://git.kernel.org/tip/65412c8d72741cc6e6b082b478b8957d7e7c0480
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 03 Aug 2023 10:26:15 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 03 Aug 2023 12:08:35 +02:00

x86/asm: Avoid unneeded __div64_32 function definition

The __div64_32() function is provided for 32-bit architectures that
don't have a custom do_div() implementation. x86_32 has one, and
does not use the header file that declares the function prototype,
so the definition causes a W=1 warning:

  lib/math/div64.c:31:32: error: no previous prototype for '__div64_32' [-Werror=missing-prototypes]

Define an empty macro to prevent the function definition from getting
built, which avoids the warning and saves a little .text space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230803082619.1369127-4-arnd@kernel.org
---
 arch/x86/include/asm/div64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index b8f1dc0..9931e4c 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -71,6 +71,12 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #define mul_u32_u32 mul_u32_u32
 
+/*
+ * __div64_32() is never called on x86, so prevent the
+ * generic definition from getting built.
+ */
+#define __div64_32
+
 #else
 # include <asm-generic/div64.h>
 
