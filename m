Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2691C7FD585
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjK2LWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjK2LW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A211999;
        Wed, 29 Nov 2023 03:22:33 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anY+yYbVYxDCgtJGB2+zgOIlzKFzZFRqE7Fg+5xOJzM=;
        b=jIq50YJzBTc5ve9MwheEKPf6e7VQVQ76kvHJP9htIN1dlOQ3lEBtMoIg4u0Ujrgt0TG4wd
        G0+GCsIAAIx3WJQXtGbMIgSFjwR32/v4lxqBUa2G9Pr2jRpYCtvO/3uHzShJSV59aEdfyC
        7ooh6YKzd/O7pSUPcle14CHgm2J8agxCN2ijfXNeBTZYyex260S2+kZAsnjoWG23MOzJUz
        Od8KjEBK5Ir1+nW+IrbbsK2Pm5m5xUKDkFs84Hk9pX9elaLzYuKdz0gW3YC08jczR0PiwF
        dQdiZDW8H+kO31zWdda4CKizQHOV7kWHuKQFs7RmrQbWf04CB/bapoDR8xokrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256952;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anY+yYbVYxDCgtJGB2+zgOIlzKFzZFRqE7Fg+5xOJzM=;
        b=evz7qc94nAIYrjvpkImx7qxpdCrUURrUTkyX1LpTkVpX55pdJGV2Z9pkWrMYkUDukiBC8l
        L50Lt5L9JY1U97AA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-5-bp@alien8.de>
References: <20231120104152.13740-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125695160.398.4842656235205898970.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0da91912fc150d6d321b15e648bead202ced1a27
Gitweb:        https://git.kernel.org/tip/0da91912fc150d6d321b15e648bead202ced1a27
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 01 Nov 2023 12:31:44 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:11:59 +01:00

x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-5-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3d74347..ebe6be8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1024,6 +1024,11 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
+}
+
+static void init_amd_zen(struct cpuinfo_x86 *c)
+{
+	fix_erratum_1386(c);
 
 	/* Fix up CPUID bits, but only if not virtualised. */
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
@@ -1074,11 +1079,6 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 	}
 }
 
-static void init_amd_zen(struct cpuinfo_x86 *c)
-{
-	fix_erratum_1386(c);
-}
-
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
 	fix_erratum_1386(c);
