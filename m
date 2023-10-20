Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31447D0EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377237AbjJTLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377215AbjJTLlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:41:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF5D10F4;
        Fri, 20 Oct 2023 04:38:28 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8+QVuQZ3+FiNfDUREWz5giVzmYwA78wRPkybcBT2Ek=;
        b=2R/FccQp0WMeAm6YJLiivhWJQf+UnA35/cOjTK3vG0T9sFioHiap4SiNbkfwguMS+gbz3T
        Jh9GqQoh9aU280oSCnW6W8qG0meiM/fmiPc/UCIjPEtIWNOJmLlcaDhKcIpsRsLEA8XCfL
        ZQY5NzrU19GD/cdpg4vrmeix8oh/n1PCI0rvSTpFZvAcnclh2YyaYdzQPEHnugzxq9jhoq
        6TSWIN1fMN3M2tNr58d481FSqgC2qvDU1e0UWIAOq7q8b2fwfGqT7Qk0WuTvRKYJfuChzF
        cZmvtlwSYXHAbTWNtfjsfDk1rQ7OyAD4SBBiaC+akF433SRZ8DtcSh7Nwasp9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8+QVuQZ3+FiNfDUREWz5giVzmYwA78wRPkybcBT2Ek=;
        b=s97PNXC/zyF3OQ7ljP1TWmXjHFAxesbIv+e9+O3rGXdgIWm31lA7kVcALuKvYGHLcLB9x5
        KOT4eiWunbefHpCw==
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
Message-ID: <169780187573.3135.2892527778268998057.tip-bot2@tip-bot2>
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

Commit-ID:     e0dd49a0eb690820e9d0eef0ad7b6ae435cf6549
Gitweb:        https://git.kernel.org/tip/e0dd49a0eb690820e9d0eef0ad7b6ae435cf6549
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:40:00 +02:00

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
index b827390..56d8bd6 100644
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
