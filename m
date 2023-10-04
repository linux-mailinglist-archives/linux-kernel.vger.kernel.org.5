Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51447B78E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjJDHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbjJDHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:41:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C128AD;
        Wed,  4 Oct 2023 00:41:11 -0700 (PDT)
Date:   Wed, 04 Oct 2023 07:41:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696405269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3DAeRCTXgcmL6wGVPGeNq0prqCeKyw0QqbONR1xZzA=;
        b=Q+wQZ0+kZ+Df3U8BgTnZQUMdhZE3NH1TUEbqHW/kRE/0PeUE1ueE734AyeBuuVELApI8Yf
        eObZh6nDTDMxCCWvrAomMqgvlGCiu7T7P6B8+ljoR4xEwQS4k9mX9x/hG1o2InJ0qA4hd8
        +pKt1UdZfPgKeuYHi2xCzQsSaYx29d5h6Vow2xAND9EHI3PhW0ht3O6BH8H2LHHyjbRLJn
        6xYobE47r5Y+F+4aDxRRvjBM/cH3wuF6QPnaiPJRW9+8doGF6ZwcY+U5zxI8/OTEqJfCW5
        5ri7rtAzAV6AOfg2jAZdAF4jmPDdOBZeUJ+UkHGMSNZMK04qB47LBPkW1shosQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696405269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N3DAeRCTXgcmL6wGVPGeNq0prqCeKyw0QqbONR1xZzA=;
        b=YziiVtxsZ1a8Jf5cVXyQ7mu4FCn3bG8pZhRWIt7QOBXwC9SjsDEtR9IRdm2KqO7ZNHpv87
        b1fNN8FaqoCt/VDQ==
From:   "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tdx: Replace deprecated strncpy() with strtomem_pad()
Cc:     Justin Stitt <justinstitt@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
References: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
MIME-Version: 1.0
Message-ID: <169640526821.3135.14252605949556446798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c9babd5d95abf3fae6e798605ce5cac98e08daf9
Gitweb:        https://git.kernel.org/tip/c9babd5d95abf3fae6e798605ce5cac98e08daf9
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Tue, 03 Oct 2023 21:54:59 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Oct 2023 09:34:07 +02:00

x86/tdx: Replace deprecated strncpy() with strtomem_pad()

strncpy() works perfectly here in all cases, however, it is deprecated and
as such we should prefer more robust and less ambiguous string APIs:

    https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Let's use strtomem_pad() as this matches the functionality of strncpy()
and is _not_ deprecated.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://github.com/KSPP/linux/issues/90
Link: https://lore.kernel.org/r/20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com
---
 arch/x86/coco/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863..2e1be59 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -119,7 +119,7 @@ static void __noreturn tdx_panic(const char *msg)
 	} message;
 
 	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
-	strncpy(message.str, msg, 64);
+	strtomem_pad(message.str, msg, '\0');
 
 	args.r8  = message.r8;
 	args.r9  = message.r9;
