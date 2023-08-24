Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82F787929
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbjHXUNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbjHXUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:12:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5E1BD1;
        Thu, 24 Aug 2023 13:12:55 -0700 (PDT)
Date:   Thu, 24 Aug 2023 20:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692907973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cA/0GyYWOjRYWT3uupYZWjwpxVQRTjUoPuZIbG25Ng=;
        b=UrjmZhs7qfBcSxtAPrZbhZpZy5Te5CHQRR+s0LUrnk0gavs9o2j6T1C9Gl5BSwzzsZ7/cp
        xSlKnH6xDKT9GT4sjqyjN8iAHjREM3vpUtYa9oHDlJnroxhJyNFwsd+ub1yFKx0EUjKtFX
        4hfcZhDegefl4UKBzp/3+Lh2NXCp3HA7sS38MbtpdrKjaR72RdfskLPIHY8t0U2u+JoZXZ
        /tGFoXysBQmSuFN+tBE2jlEft6rc4g7crCJ1boRPMT4q06+mXCBbB7zjTpkeaYtBHhXgq4
        GTOgU+BgnrQXhVJmLzoxOAvqw/m9tx2hYZ+6x8+6juDGxfleeZ3gMK91RJR00g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692907973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cA/0GyYWOjRYWT3uupYZWjwpxVQRTjUoPuZIbG25Ng=;
        b=G87XPdEg8dbUS9LAZ/fj6Oi0rXrMrP+/J/uVvN09eDVFsBNM2GZQgMuy1NnWZVG9b28Vlo
        0NQnTp0A0P4Q4GCQ==
From:   "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/hpet: Refactor code using deprecated
 strncpy() interface to use strscpy()
Cc:     Justin Stitt <justinstitt@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230822-strncpy-arch-x86-kernel-hpet-v1-1-2c7d3be86f4a@google.com>
References: <20230822-strncpy-arch-x86-kernel-hpet-v1-1-2c7d3be86f4a@google.com>
MIME-Version: 1.0
Message-ID: <169290797330.27769.8900864167037530170.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4108d141bfd04cf7b2bbf96e899ee5392f62e8a2
Gitweb:        https://git.kernel.org/tip/4108d141bfd04cf7b2bbf96e899ee5392f62e8a2
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Tue, 22 Aug 2023 22:13:36 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Aug 2023 21:22:40 +02:00

x86/hpet: Refactor code using deprecated strncpy() interface to use strscpy()

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, it is a simple swap from `strncpy` to `strscpy`. There is
one slight difference, though. If NUL-padding is a functional
requirement here we should opt for `strscpy_pad`. It seems like this
shouldn't be needed as I see no obvious signs of any padding being
required.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Link: https://lore.kernel.org/r/20230822-strncpy-arch-x86-kernel-hpet-v1-1-2c7d3be86f4a@google.com
---
 arch/x86/kernel/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c8eb1ac..1648aa0 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -421,7 +421,7 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
 	 * the IO_APIC has been initialized.
 	 */
 	hc->cpu = boot_cpu_data.cpu_index;
-	strncpy(hc->name, "hpet", sizeof(hc->name));
+	strscpy(hc->name, "hpet", sizeof(hc->name));
 	hpet_init_clockevent(hc, 50);
 
 	hc->evt.tick_resume	= hpet_clkevt_legacy_resume;
