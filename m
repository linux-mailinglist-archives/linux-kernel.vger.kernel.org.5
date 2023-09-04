Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0A79191B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351664AbjIDNsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347747AbjIDNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:48:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04E170D;
        Mon,  4 Sep 2023 06:48:23 -0700 (PDT)
Date:   Mon, 04 Sep 2023 13:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693835301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otnQIUtjVCVy162nyXJjyBsoULeNjLd2WaaoV4qD1E4=;
        b=E/4wsoDLUQYfn94n5PU5r7MC4TzqOekYuRFjJc2yvBMn+upA9Qi6tYGA++E4Rv37K1yt5x
        Z1Sxe/4zKTLEyhiOS6RQd23ghSAWh1V2sGo8aV20613EcYlSUEXdaiFcC0t3sBLVwLggTh
        rB253pDoKxQgB824MXWvk/SinLJ4BB48Hxbin+dwhr1jh1b+mqyMo+ADgrgyrNo3sYrdS1
        yrpF/jDN5rVggCyv96yfR2QXp0QPlwJvqLmUjS3JompVkQepYbcvMW/YJjd9A24NSvJo1W
        E/vUGTYzqUrNUeYvVIsQd7tTdYaqbYj5TWs4kyZJu8eRK0Huo6qcgPzxF4CVXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693835301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otnQIUtjVCVy162nyXJjyBsoULeNjLd2WaaoV4qD1E4=;
        b=mUC3z74yTsE1qrM/ICGdAcB953ORs0A2xYbuau9qAMTciFHmhR+Rg3bCnOHsO8beYvr2LO
        irbhi167ZedvipCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/smp: Don't send INIT to non-present and non-booted CPUs
Cc:     Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasant Hegde <vasant.hegde@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87cyzwjbff.ffs@tglx>
References: <87cyzwjbff.ffs@tglx>
MIME-Version: 1.0
Message-ID: <169383530091.27769.15770168191921146668.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3f874c9b2aae8e30463efc1872bea4baa9ed25dc
Gitweb:        https://git.kernel.org/tip/3f874c9b2aae8e30463efc1872bea4baa9ed25dc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 09 Aug 2023 20:52:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 04 Sep 2023 15:41:42 +02:00

x86/smp: Don't send INIT to non-present and non-booted CPUs

Vasant reported that kexec() can hang or reset the machine when it tries to
park CPUs via INIT. This happens when the kernel is using extended APIC,
but the present mask has APIC IDs >= 0x100 enumerated.

As extended APIC can only handle 8 bit of APIC ID sending INIT to APIC ID
0x100 sends INIT to APIC ID 0x0. That's the boot CPU which is special on
x86 and INIT causes the system to hang or resets the machine.

Prevent this by sending INIT only to those CPUs which have been booted
once.

Fixes: 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible")
Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/87cyzwjbff.ffs@tglx
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d7667a2..4e45ff4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1250,7 +1250,7 @@ bool smp_park_other_cpus_in_init(void)
 	if (this_cpu)
 		return false;
 
-	for_each_present_cpu(cpu) {
+	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
 		if (cpu == this_cpu)
 			continue;
 		apicid = apic->cpu_present_to_apicid(cpu);
