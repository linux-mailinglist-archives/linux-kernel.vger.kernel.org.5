Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F8A7D519D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjJXNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjJXNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C79198A;
        Tue, 24 Oct 2023 06:21:05 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YJNAq3utUE/mbx92iL09S+Fybi+Kw1ltBDQ9lkJRbk=;
        b=a9vSdJdO6aZTYnv0b+lXKYhYm6rmhpjIo99z0WDJPKp96OWmzDLWvaSiB1fluOrxtrmglJ
        rSma3nMagXSiexgHuWFw6W62Y7HuOIOwMflVVBF5in2Gf+fYYEHcVcRMoAWAVlpZDVO92M
        qz6DyZCJ10odYDSk6Oskhr/2IY97Y5lUYYMQ6HVRH92JdsotuWZfbgic8fqX+exAYYWxDp
        pRSUvqhPD9HdESM/DV38rYoB+xobF8+ted+R6MadrDEUoEZ8YY3QQYbTECONGxkIBovaBK
        SO3l/F80Xgnwe93LREtQtNTLGh19OIs31sBhG+nFJy1ROeK+rkFnA+uLkrXN5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YJNAq3utUE/mbx92iL09S+Fybi+Kw1ltBDQ9lkJRbk=;
        b=AjlzGHx9IBdGd1AR9n91c8GrffYfbmKLBuy2kNwVUWgXpzckwWB3ZLbFbQkE6dwF30eQGj
        CzJf5R7Jh/W+poBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Cache builtin microcode too
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010150702.495139089@linutronix.de>
References: <20231010150702.495139089@linutronix.de>
MIME-Version: 1.0
Message-ID: <169815366173.3135.15317194687578772075.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     d419d28261e72e1c9ec418711b3da41df2265139
Gitweb:        https://git.kernel.org/tip/d419d28261e72e1c9ec418711b3da41df2265139
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:54 +02:00

x86/microcode/amd: Cache builtin microcode too

save_microcode_in_initrd_amd() fails to cache builtin microcode and only
scans initrd.

Use find_blobs_in_containers() instead which covers both.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.495139089@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 56d8bd6..2458379 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -533,7 +533,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	cp = find_microcode_in_initrd(ucode_path);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 
