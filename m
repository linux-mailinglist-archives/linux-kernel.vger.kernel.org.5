Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC78801C49
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjLBKqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLBKqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:46:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BE5123;
        Sat,  2 Dec 2023 02:46:07 -0800 (PST)
Date:   Sat, 02 Dec 2023 10:46:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701513964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6kPvZSlBQ8JhN9p8gUC/qjj/w3vTn3U0EtoaGJS2Dg=;
        b=duD6sljqbJYnjaALP4h1bHbUzsU06Z4KlecwGR+bN4H43hF3vlNs/WBUQdspGTF2aBX7o+
        k/EKck9rrOFvl7YfN/g7x397hlZCuujf9NT/l84xpFDQHScTRb7U79imKtoOwmwQFltGJd
        6WlSUn8o9L3DH00Il1PFN+sQ3neCq2LAaA1wHuiTWrmVbxzxgSBRKXd65r5KiphmcX9M5Y
        L3kwjv7g39XG/ZrH1NzeT4+njPa3zaSozT7fjExP4g1ig/4g2YD/tInEUTYxIfTcQ0A3so
        LHMZDbI6rteKRhC8hDAhUKk+MMYflF6MCC3Bs27FUSSM7I/XzSCXxuKm9dd16A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701513964;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6kPvZSlBQ8JhN9p8gUC/qjj/w3vTn3U0EtoaGJS2Dg=;
        b=dlybmCKM0y03bWUQTFPhuS2VNpWCVauxOWtOm+D4qOWiW8zJGHS8Cih/Bzyn6BVdM7Frrg
        rJbGhlCSr1mgleCA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Check vendor in the AMD microcode callback
Cc:     <stable@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231201184226.16749-1-bp@alien8.de>
References: <20231201184226.16749-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170151396382.398.13488399404074572021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9b8493dc43044376716d789d07699f17d538a7c4
Gitweb:        https://git.kernel.org/tip/9b8493dc43044376716d789d07699f17d538a7c4
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 01 Dec 2023 19:37:27 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 02 Dec 2023 11:40:24 +01:00

x86/CPU/AMD: Check vendor in the AMD microcode callback

Commit in Fixes added an AMD-specific microcode callback. However, it
didn't check the CPU vendor the kernel runs on explicitly.

The only reason the Zenbleed check in it didn't run on other x86 vendors
hardware was pure coincidental luck:

  if (!cpu_has_amd_erratum(c, amd_zenbleed))
	  return;

gives true on other vendors because they don't have those families and
models.

However, with the removal of the cpu_has_amd_erratum() in

  05f5f73936fa ("x86/CPU/AMD: Drop now unused CPU erratum checking function")

that coincidental condition is gone, leading to the zenbleed check
getting executed on other vendors too.

Add the explicit vendor check for the whole callback as it should've
been done in the first place.

Fixes: 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")
Cc: <stable@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231201184226.16749-1-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a7eab05..f322ebd 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1320,6 +1320,9 @@ static void zenbleed_check_cpu(void *unused)
 
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
