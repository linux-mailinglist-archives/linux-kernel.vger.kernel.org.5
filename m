Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0167D0ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377465AbjJTLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377456AbjJTLjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:39:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC92108;
        Fri, 20 Oct 2023 04:38:10 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWLNPxAL6RB4jWe7j4BW9JKrK+K+JTutnur4CH8rKmM=;
        b=Gvj2cJ/1KNv8N6SZFVfv1jZQLYcrITN+MS5g9AxvrQfEc+hNd9cjFZs6lmZQYmtZ5iGp8W
        Vu88PQBMhw1LBGt/0458z/FuYTL2+hvvEksp3I1VikmK56Q11o9sQJSWsaMLASOzCzpaOu
        2i4+8TLPpzQk/UeGS9RXtePA6uys880YbPu+iVe+EENyX7geGtHlY/r+Axc55/jshXsHf4
        5vdmx6BU8zNvl2UY54AnHE1NSGLIS72BRiMVBsyg8q1jME6WXAES68253xC2TDR093qYny
        U92GxBwYgD0XX/VT5squ5vOUwsoNyKCDKD3NMiZBdnuHmP2fMAbKwapp5taZKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oWLNPxAL6RB4jWe7j4BW9JKrK+K+JTutnur4CH8rKmM=;
        b=puXd1RnAYzg/PpcdGJbfHWwIQMMeCz/9sj3LfC7sW6mWBjuwJayiQejKFnmfW+IjRem3Xm
        KAnUhWfpaHFfvmDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Clean up mc_cpu_down_prep()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.028651784@linutronix.de>
References: <20231002115903.028651784@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187253.3135.16969663955261216142.tip-bot2@tip-bot2>
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

Commit-ID:     d91172afa89d1bb7ada97625d761bcdefdd4f9f6
Gitweb:        https://git.kernel.org/tip/d91172afa89d1bb7ada97625d761bcdefdd4f9f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:55 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:53:58 +02:00

x86/microcode: Clean up mc_cpu_down_prep()

This function has nothing to do with suspend. It's a hotplug
callback. Remove the bogus comment.

Drop the pointless debug printk. The hotplug core provides tracepoints
which track the invocation of those callbacks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.028651784@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 0ed96d2..e306fee 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -498,16 +498,10 @@ static int mc_cpu_online(unsigned int cpu)
 
 static int mc_cpu_down_prep(unsigned int cpu)
 {
-	struct device *dev;
-
-	dev = get_cpu_device(cpu);
+	struct device *dev = get_cpu_device(cpu);
 
 	microcode_fini_cpu(cpu);
-
-	/* Suspend is in progress, only remove the interface */
 	sysfs_remove_group(&dev->kobj, &mc_attr_group);
-	pr_debug("%s: CPU%d\n", __func__, cpu);
-
 	return 0;
 }
 
