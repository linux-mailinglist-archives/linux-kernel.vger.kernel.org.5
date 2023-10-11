Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049D67C4DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbjJKJBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345866AbjJKJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:01:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B33CC;
        Wed, 11 Oct 2023 02:01:05 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:01:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697014864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+W7LmK13kuQHjba0aXrO/nn+kMn14TbwlhICOETVIY=;
        b=cxzAUO8sy6iMpc2ARvf70RZ9hLiC4C6AJKQzwpZFtU0d0q6GmLiix4fuHZ7F9+Ek8K+p8R
        N/8Gl6x32z4IVSYqyd3Nw1ysrETfj15tP8+yAt4w6GcbonymXU0eTsYJxPXO0EXt/cFNes
        UmrSDomSkEA7zXUQTnflfHi9qsxsEyeOrq8pywK32C7BvvRmY+56ybYeVR9QDyVKs9sBMV
        2Kq1Pbx30OKiIkZSVF9aFN58K0pB95b5biRRJumd1fUKDRfPidgh3Brawz4ORRK9niy4oL
        eQxWm9U5Yo6yBeOcU/FFlohIAp7RcUbvI/xM5voehSc2wwFJOxpjBswmYTKNXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697014864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+W7LmK13kuQHjba0aXrO/nn+kMn14TbwlhICOETVIY=;
        b=oxHt8BCjCrkYcg/NtZylWNEsI7lR6SDfYmKjePJG9VH74yODawlI7BKv29MoODgYmkCcZO
        t7iWM2LTXhNOccCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Use correct per CPU ucode_cpu_info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010150702.433454320@linutronix.de>
References: <20231010150702.433454320@linutronix.de>
MIME-Version: 1.0
Message-ID: <169701486308.3135.13026498326049431565.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     8c4ac53f1d8bcb3bd4b5c2f338eb068f505d6816
Gitweb:        https://git.kernel.org/tip/8c4ac53f1d8bcb3bd4b5c2f338eb068f505d6816
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Oct 2023 19:39:32 +02:00

x86/microcode/amd: Use correct per CPU ucode_cpu_info

find_blobs_in_containers() is invoked on every CPU but overwrites
unconditionally ucode_cpu_info of CPU0.

Fix this by using the proper CPU data and move the assignment into the
call site apply_ucode_from_containers() so that the function can be
reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.433454320@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a2776f2..f6ed2c5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -503,9 +503,6 @@ static void find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data 
 	if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	/* Needed in load_microcode_amd() */
-	ucode_cpu_info->cpu_sig.sig = cpuid_1_eax;
-
 	*ret = cp;
 }
 
@@ -513,6 +510,9 @@ static void apply_ucode_from_containers(unsigned int cpuid_1_eax)
 {
 	struct cpio_data cp = { };
 
+	/* Needed in load_microcode_amd() */
+	ucode_cpu_info[smp_processor_id()].cpu_sig.sig = cpuid_1_eax;
+
 	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return;
